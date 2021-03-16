#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytuesdayR)
library(ggplot2)
data(mtcars)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Car weights VS Car fuel consumption"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Weight of the car (1000 lbs):",
                        min = 1,
                        max = 5.5,
                        value = 1) #default value
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 0.5)

        # draw the histogram with the specified number of bins
        mtcars%>%
            filter(wt > input$bins)%>%
            ggplot(mapping = aes(x=mpg,y=wt)) + geom_line()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
