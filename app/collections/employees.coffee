Collection = require './collection'

# By default, email addresses with no Gravatars will be hidden from the Facewall.
# However, adding ?shame to the request URL will show these as empty squares in the Facewall mesh.
defaultGravatarImage = if location.search isnt '?shame' then '404' else 'blank'

class Employees extends Collection

    # Replace this with your own database of employees.
    # You may use a URL which returns JSON in the following format:
    # {
    #    "users":[
    #       {
    #          "id": 1,
    #          "createdAt": 1282254176000,
    #          "email": "aschwartz@hubspot.com",
    #          "firstName": "Adam",
    #          "lastName": "Schwartz",
    #          "role": "Principal Software Engineer"
    #       },
    #       // ...
    #    ]
    # }
    # url: -> "http://localhost:9000/employees"
    url: -> "/static/js/employees.js"

    # Or you may hard code a JSON string in place of the example USER_JSON (see above)
    # fetch: (options) ->
    #     @add @parse JSON.parse USER_JSON
    #     setTimeout (-> options.success()), 100

    parse: (data) ->
        _.map data.users, (employee) =>
            employee.gravatar = "https://secure.gravatar.com/avatar/#{CryptoJS.MD5(employee.email)}?d=#{defaultGravatarImage}"

            # Default to showing full name when role is not available
            employee.role = employee.firstName + ' ' + employee.lastName unless employee.role

            employee

module.exports = Employees
