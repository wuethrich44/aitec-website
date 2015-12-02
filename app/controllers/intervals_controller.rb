class IntervalsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_interval, only: [:update, :destroy]

  # POST /intervals
  # POST /intervals.json
  def create
    @interval = Interval.new(interval_params)

    respond_to do |format|
      if @interval.save
        format.html { redirect_to url_for(:controller => :application, :action => :index), notice: 'Interval was successfully created.' }
        format.json { render :show, status: :created, location: @interval }
      else
        format.html { render :new }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /intervals/1
  def update
  	 @existing_interval = Interval.find_by(is_current: true)
  	 
  	 if(@existing_interval != nil)
	  	 @existing_interval.is_current = false
	  	 @existing_interval.save
	 end
  
  	 if(@interval.is_current)
  	 	@interval.is_current = false
  	 else
	  	@interval.is_current = true
	 end
	 
	 @interval.save
	 
	 respond_to do |format|
      format.html { redirect_to url_for(:controller => :application, :action => :index), notice: 'Interval was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # DELETE /intervals/1
  # DELETE /intervals/1.json
  def destroy
    @interval.destroy
    respond_to do |format|
      format.html { redirect_to url_for(:controller => :application, :action => :index), notice: 'Interval was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interval
      @interval = Interval.find(params[:id])
    end

    def interval_params
      params.require(:interval).permit(:start, :end)
    end
end
