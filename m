Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7987B07C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjI0PLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjI0PK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:10:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89763FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:10:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3231df68584so7361835f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695827454; x=1696432254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7/QyqfocAhfu8bxoT9H2OQkM4bSGlZOnuBXKrlKBtE=;
        b=MGpO+g6EASYCLS6Iv/ZEN+1G3g6L8YFrZdxc6NnWHAsNZnCz6vLl7qoSsPpsEYn5nh
         F6rwkRhYo4+poQaHUXu1OBLVXmmGrmg+ukBarYvib3aYDUSuHqWG8ati9SfWlbHHHrJy
         CzB6ohCGsWbEyZEY3JaZeWVzVMdsRgsQ4oIYXEAck8PC/rr49uDP9ap9D5o882FL+xZF
         k8ogJhfBiqbVXuheLCW+uxmIpRr5isqJ2fLlr1dCq7vTObXIGdAVRrtchZKluB2Bqiau
         Z7snqCILtKu7HlZW00lym4OTxTz7/YK8CEG261YxK5C6xkXX1cKlyd49Vc4GiBaXnmCM
         JKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827454; x=1696432254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7/QyqfocAhfu8bxoT9H2OQkM4bSGlZOnuBXKrlKBtE=;
        b=JFr0POTDFJHblV1pEWkGEdynsf3U6f+TX999I570kg1MFWkVLg7wuLN2U+W0eANqBo
         VSZOjKmo7I70DWFP86++PunKNJpeBmTzZVXMoWk8OtPOAXXO/OmGYzCrkKdEIe7Wy8mI
         ACKqqoHDrymi+xGKhR8rTlQ8TNgMx5hGoAvrJupN9/tnn4OdsoaH5RPw61oWdBjiz0XI
         pmYvc1jfopzJW6pXPYb9SBxEF2pTSfSCU7kHzzQLkuoszktwDQAJ14Ujsow/Gd+/sJei
         U0QkTO5KUHKep+IuAC2ORf4vQA5GAlSi2xwTcwZgb90Hd2vXoiLKe/m7oU63Wl0OWQxn
         Kvyg==
X-Gm-Message-State: AOJu0YxLo0jVcXwKjODvlCvS0Z33YYkUn0caxJZedLrXxWAUJBvZ9Ugp
        HfFZRRx30QDLG8lqgu+W/IS53w==
X-Google-Smtp-Source: AGHT+IEXDp86PZthFHHV/b7rLUllis5UrQNPd8u96jlHvLRY7qRew9B2k7muaVJ+FOkSxnj2Rap7Dw==
X-Received: by 2002:a05:6000:12ca:b0:317:6470:3271 with SMTP id l10-20020a05600012ca00b0031764703271mr2188274wrx.45.1695827453867;
        Wed, 27 Sep 2023 08:10:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id d29-20020adfa41d000000b003197869bcd7sm12245788wra.13.2023.09.27.08.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:10:53 -0700 (PDT)
Message-ID: <9f1374db-f866-ff52-e86c-99fecee24d1b@linaro.org>
Date:   Wed, 27 Sep 2023 17:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 07/13] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <2590280.Lt9SDvczpP@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2590280.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 19:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Eliminate the __thermal_zone_get_trip() usage that adds unnecessary
> overhead (due to pointless bounds checking and copying of trip point
> data) from the power allocator thermal governor and generally make it
> use trip pointers instead of trip indices where applicable.

Actually the __thermal_zone_get_trip() change was done on purpose to 
replace the 'throttle' callback index parameter by the trip pointer and 
removing those call to __thermal_zone_get_trip() while the code was 
using the trip pointer.

IMO, the changes should focus on changing the trip_index parameter by 
the trip pointer directly in the throttle ops. The pointer can be 
retrieved in the handle_thermal_trip() function and passed around for 
the rest of the actions on this trip point

> The general functionality is not expected to be changed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_power_allocator.c |  102 ++++++++++++----------------------
>   1 file changed, 38 insertions(+), 64 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -16,8 +16,6 @@
>   
>   #include "thermal_core.h"
>   
> -#define INVALID_TRIP -1
> -
>   #define FRAC_BITS 10
>   #define int_to_frac(x) ((x) << FRAC_BITS)
>   #define frac_to_int(x) ((x) >> FRAC_BITS)
> @@ -55,23 +53,23 @@ static inline s64 div_frac(s64 x, s64 y)
>    * @err_integral:	accumulated error in the PID controller.
>    * @prev_err:	error in the previous iteration of the PID controller.
>    *		Used to calculate the derivative term.
> + * @sustainable_power:	Sustainable power (heat) that this thermal zone can
> + *			dissipate
>    * @trip_switch_on:	first passive trip point of the thermal zone.  The
>    *			governor switches on when this trip point is crossed.
>    *			If the thermal zone only has one passive trip point,
> - *			@trip_switch_on should be INVALID_TRIP.
> + *			@trip_switch_on should be NULL.
>    * @trip_max_desired_temperature:	last passive trip point of the thermal
>    *					zone.  The temperature we are
>    *					controlling for.
> - * @sustainable_power:	Sustainable power (heat) that this thermal zone can
> - *			dissipate
>    */
>   struct power_allocator_params {
>   	bool allocated_tzp;
>   	s64 err_integral;
>   	s32 prev_err;
> -	int trip_switch_on;
> -	int trip_max_desired_temperature;
>   	u32 sustainable_power;
> +	const struct thermal_trip *trip_switch_on;
> +	const struct thermal_trip *trip_max_desired_temperature;
>   };
>   
>   /**
> @@ -90,14 +88,12 @@ static u32 estimate_sustainable_power(st
>   	u32 sustainable_power = 0;
>   	struct thermal_instance *instance;
>   	struct power_allocator_params *params = tz->governor_data;
> -	const struct thermal_trip *trip_max_desired_temperature =
> -			&tz->trips[params->trip_max_desired_temperature];
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   		struct thermal_cooling_device *cdev = instance->cdev;
>   		u32 min_power;
>   
> -		if (instance->trip != trip_max_desired_temperature)
> +		if (instance->trip != params->trip_max_desired_temperature)
>   			continue;
>   
>   		if (!cdev_is_power_actor(cdev))
> @@ -116,24 +112,23 @@ static u32 estimate_sustainable_power(st
>    * estimate_pid_constants() - Estimate the constants for the PID controller
>    * @tz:		thermal zone for which to estimate the constants
>    * @sustainable_power:	sustainable power for the thermal zone
> - * @trip_switch_on:	trip point number for the switch on temperature
> + * @trip_switch_on:	trip point for the switch on temperature
>    * @control_temp:	target temperature for the power allocator governor
>    *
>    * This function is used to update the estimation of the PID
>    * controller constants in struct thermal_zone_parameters.
>    */
>   static void estimate_pid_constants(struct thermal_zone_device *tz,
> -				   u32 sustainable_power, int trip_switch_on,
> +				   u32 sustainable_power,
> +				   const struct thermal_trip *trip_switch_on,
>   				   int control_temp)
>   {
> -	struct thermal_trip trip;
>   	u32 temperature_threshold = control_temp;
>   	int ret;
>   	s32 k_i;
>   
> -	ret = __thermal_zone_get_trip(tz, trip_switch_on, &trip);
> -	if (!ret)
> -		temperature_threshold -= trip.temperature;
> +	if (trip_switch_on)
> +		temperature_threshold -= trip_switch_on->temperature;
>   
>   	/*
>   	 * estimate_pid_constants() tries to find appropriate default
> @@ -386,7 +381,7 @@ static int allocate_power(struct thermal
>   	struct thermal_instance *instance;
>   	struct power_allocator_params *params = tz->governor_data;
>   	const struct thermal_trip *trip_max_desired_temperature =
> -			&tz->trips[params->trip_max_desired_temperature];
> +					params->trip_max_desired_temperature;
>   	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
>   	u32 *weighted_req_power;
>   	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
> @@ -513,46 +508,35 @@ static int allocate_power(struct thermal
>   static void get_governor_trips(struct thermal_zone_device *tz,
>   			       struct power_allocator_params *params)
>   {
> -	int i, last_active, last_passive;
> -	bool found_first_passive;
> -
> -	found_first_passive = false;
> -	last_active = INVALID_TRIP;
> -	last_passive = INVALID_TRIP;
> +	const struct thermal_trip *last_active = NULL:
> +	const struct thermal_trip *last_passive = NULL;
> +	bool found_first_passive = false;
> +	int i;
>   
>   	for (i = 0; i < tz->num_trips; i++) {
> -		struct thermal_trip trip;
> -		int ret;
> +		const struct thermal_trip *trip = &tz->trips[i];
>   
> -		ret = __thermal_zone_get_trip(tz, i, &trip);
> -		if (ret) {
> -			dev_warn(&tz->device,
> -				 "Failed to get trip point %d type: %d\n", i,
> -				 ret);
> -			continue;
> -		}
> -
> -		if (trip.type == THERMAL_TRIP_PASSIVE) {
> +		if (trip->type == THERMAL_TRIP_PASSIVE) {
>   			if (!found_first_passive) {
> -				params->trip_switch_on = i;
> +				params->trip_switch_on = trip;
>   				found_first_passive = true;
>   			} else  {
> -				last_passive = i;
> +				last_passive = trip;
>   			}
> -		} else if (trip.type == THERMAL_TRIP_ACTIVE) {
> -			last_active = i;
> +		} else if (trip->type == THERMAL_TRIP_ACTIVE) {
> +			last_active = trip;
>   		} else {
>   			break;
>   		}
>   	}
>   
> -	if (last_passive != INVALID_TRIP) {
> +	if (last_passive) {
>   		params->trip_max_desired_temperature = last_passive;
>   	} else if (found_first_passive) {
>   		params->trip_max_desired_temperature = params->trip_switch_on;
> -		params->trip_switch_on = INVALID_TRIP;
> +		params->trip_switch_on = NULL;
>   	} else {
> -		params->trip_switch_on = INVALID_TRIP;
> +		params->trip_switch_on = NULL;
>   		params->trip_max_desired_temperature = last_active;
>   	}
>   }
> @@ -567,14 +551,12 @@ static void allow_maximum_power(struct t
>   {
>   	struct thermal_instance *instance;
>   	struct power_allocator_params *params = tz->governor_data;
> -	const struct thermal_trip *trip_max_desired_temperature =
> -			&tz->trips[params->trip_max_desired_temperature];
>   	u32 req_power;
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   		struct thermal_cooling_device *cdev = instance->cdev;
>   
> -		if ((instance->trip != trip_max_desired_temperature) ||
> +		if (instance->trip != params->trip_max_desired_temperature ||
>   		    (!cdev_is_power_actor(instance->cdev)))
>   			continue;
>   
> @@ -636,7 +618,6 @@ static int power_allocator_bind(struct t
>   {
>   	int ret;
>   	struct power_allocator_params *params;
> -	struct thermal_trip trip;
>   
>   	ret = check_power_actors(tz);
>   	if (ret)
> @@ -662,12 +643,13 @@ static int power_allocator_bind(struct t
>   	get_governor_trips(tz, params);
>   
>   	if (tz->num_trips > 0) {
> -		ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
> -					      &trip);
> -		if (!ret)
> +		const struct thermal_trip *trip;
> +
> +		trip = params->trip_max_desired_temperature;
> +		if (trip)
>   			estimate_pid_constants(tz, tz->tzp->sustainable_power,
>   					       params->trip_switch_on,
> -					       trip.temperature);
> +					       trip->temperature);
>   	}
>   
>   	reset_pid_controller(params);
> @@ -697,11 +679,10 @@ static void power_allocator_unbind(struc
>   	tz->governor_data = NULL;
>   }
>   
> -static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
> +static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_index)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> -	struct thermal_trip trip;
> -	int ret;
> +	const struct thermal_trip *trip = &tz->trips[trip_index];
>   	bool update;
>   
>   	lockdep_assert_held(&tz->lock);
> @@ -710,12 +691,12 @@ static int power_allocator_throttle(stru
>   	 * We get called for every trip point but we only need to do
>   	 * our calculations once
>   	 */
> -	if (trip_id != params->trip_max_desired_temperature)
> +	if (trip != params->trip_max_desired_temperature)
>   		return 0;
>   
> -	ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> -	if (!ret && (tz->temperature < trip.temperature)) {
> -		update = (tz->last_temperature >= trip.temperature);
> +	trip = params->trip_switch_on;
> +	if (trip && tz->temperature < trip->temperature) {
> +		update = tz->last_temperature >= trip->temperature;
>   		tz->passive = 0;
>   		reset_pid_controller(params);
>   		allow_maximum_power(tz, update);
> @@ -724,14 +705,7 @@ static int power_allocator_throttle(stru
>   
>   	tz->passive = 1;
>   
> -	ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature, &trip);
> -	if (ret) {
> -		dev_warn(&tz->device, "Failed to get the maximum desired temperature: %d\n",
> -			 ret);
> -		return ret;
> -	}
> -
> -	return allocate_power(tz, trip.temperature);
> +	return allocate_power(tz, params->trip_max_desired_temperature->temperature);
>   }
>   
>   static struct thermal_governor thermal_gov_power_allocator = {
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

