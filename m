Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECA7FED08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjK3KkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Kj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:39:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800310D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:40:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3316c6e299eso510406f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701340800; x=1701945600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTOLZJakU9gN6Im+DyUzEgXZxdixZJwPR7HjKovGFk8=;
        b=d12tJu7alWkeD09cOmi+3U2zfRgI0lUST+f37oRMOi/TvkIr5egWU7jnYZL6Id36lV
         U4GRqszk99o6HtlO9SgSrbJ54fGBVZ+L/pLPpShBBkz3Mmxjs6Kurt/HkSxFeYd0PJ8N
         E/xJ6GO03o/VHZqPi7QEv0k/9BSU+X3KXbbRWjkUMVixF3Y96J77hPQ8/g+/P9+TpXBJ
         PSpqo5I8YHi7XBnU/UYI4QJFtSVNxrdPSqrI4kXqKtPVILHc7zguqkQju6x+HiUxxhTR
         jUHAtWUHpOIVSocvziogQNm4MtRq/UoYrAzRx8SrpNne3lDZmCEqo1Y3mn6PTLxwF4lc
         vaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340800; x=1701945600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTOLZJakU9gN6Im+DyUzEgXZxdixZJwPR7HjKovGFk8=;
        b=MAcI15LSrhpUYeUdy5lP0kRRTe8sbrNlwWfJudqGVLY8w2WGYwT1uZIShRXqravKxJ
         beWEIAo2Xr1nmiiEHZ3J9ctn5cCY2/5I9xUQH3T0/5/thb6aAmk1VDclN9SrDuKhDtrn
         /oGPcNMptMRqUutlaDd5fStps/r3LxR56x0zRRLg7tD84lgUP39G4Ng3LAwQOHv1HCkT
         xiNgoqery6hK4e6JMwOer3tWemTOoj+yTZJwhyDaNyJJDhI9WqF5psAjsC6I/Ef3qJ1p
         IHWea7pxOWSNVy/GGUobzpIRaf/470zDJhJnc4a71ps0ewXCdN2560BTSso3zTuQmh2U
         /tpw==
X-Gm-Message-State: AOJu0YxfuL7ScSHrLx0vEsyTKZzxkL4MVAdPO84tcVnaP+pPdv+3iR7J
        +/YV+BxT0e0L98uh1Lvq+Hrm7DFVHf66gPm5tZQ=
X-Google-Smtp-Source: AGHT+IHQHK/h76SXGtY2D/c0GjznZZDGZ5j5bQtjbsp/YOT1bu7c8bK+P9YzavuyRZR4RJbAmbk6+w==
X-Received: by 2002:adf:fa8d:0:b0:333:12f9:d381 with SMTP id h13-20020adffa8d000000b0033312f9d381mr4440388wrr.36.1701340799879;
        Thu, 30 Nov 2023 02:39:59 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:3992:5718:8297:bc86? ([2a05:6e02:1041:c10:3992:5718:8297:bc86])
        by smtp.googlemail.com with ESMTPSA id f9-20020a5d50c9000000b00332c6c5ce82sm1147492wrt.94.2023.11.30.02.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:39:59 -0800 (PST)
Message-ID: <d83a54db-4dc8-483e-9f4e-4c7d853f4c46@linaro.org>
Date:   Thu, 30 Nov 2023 11:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <12350772.O9o76ZdvQC@kreacher> <4869676.GXAFRqVoOG@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4869676.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,


On 29/11/2023 14:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both trip_point_temp_store() and trip_point_hyst_store() use
> thermal_zone_set_trip() to update a given trip point, but none of them
> actually needs to change more than one field in struct thermal_trip
> representing it.  However, each of them effectively calls
> __thermal_zone_get_trip() twice in a row for the same trip index value,
> once directly and once via thermal_zone_set_trip(), which is not
> particularly efficient, and the way in which thermal_zone_set_trip()
> carries out the update is not particularly straightforward.
> 
> Moreover, some checks done by them both need not go under the thermal
> zone lock and code duplication between them can be reduced quite a bit
> by moving the majority of logic into thermal_zone_set_trip().
> 
> Rework all of the above functions to address the above.

The resulting change looks to me over complicate for the code it is 
supposed to improve. One new function, one enum and leaking the sysfs 
buffer to a function located outside of thermal-sysfs.c. That does not 
improve the readability IMO.

The function thermal_zone_set_trip is only called from thermal_syfs.c

Why not directly change the trip point temp/hyst value in the array in 
the thermal_sysfs functions and remove the function 
thermal_zone_set_trip() ?


> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Fix missing return statement in thermal_zone_set_trip() (Lukasz).
> 
> v1 -> v2:
>     * Fix 2 typos in the changelog (Lukasz).
>     * Split one change into the [1/2].
> 
> ---
>   drivers/thermal/thermal_core.h  |    9 ++++++
>   drivers/thermal/thermal_sysfs.c |   52 ++++++++--------------------------
>   drivers/thermal/thermal_trip.c  |   60 +++++++++++++++++++++++++++-------------
>   include/linux/thermal.h         |    3 --
>   4 files changed, 62 insertions(+), 62 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -122,6 +122,15 @@ void __thermal_zone_device_update(struct
>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			    struct thermal_trip *trip);
> +
> +enum thermal_set_trip_target {
> +	THERMAL_TRIP_SET_TEMP,
> +	THERMAL_TRIP_SET_HYST,
> +};
> +
> +int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> +			  enum thermal_set_trip_target what, const char *buf);
> +
>   int thermal_zone_trip_id(struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip);
>   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -120,31 +120,17 @@ trip_point_temp_store(struct device *dev
>   		      const char *buf, size_t count)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, ret;
> +	int trip_id;
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (!device_is_registered(dev)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
> -	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	if (ret)
> -		goto unlock;
> -
> -	ret = kstrtoint(buf, 10, &trip.temperature);
> -	if (ret)
> -		goto unlock;
> +	ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_TEMP, buf);
>   
> -	ret = thermal_zone_set_trip(tz, trip_id, &trip);
> -unlock:
> -	mutex_unlock(&tz->lock);
> -	
>   	return ret ? ret : count;
>   }
>   
> @@ -179,30 +165,16 @@ trip_point_hyst_store(struct device *dev
>   		      const char *buf, size_t count)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, ret;
> +	int trip_id;
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (!device_is_registered(dev)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
> -	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	if (ret)
> -		goto unlock;
> -
> -	ret = kstrtoint(buf, 10, &trip.hysteresis);
> -	if (ret)
> -		goto unlock;
> -
> -	ret = thermal_zone_set_trip(tz, trip_id, &trip);
> -unlock:
> -	mutex_unlock(&tz->lock);
> +	ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_HYST, buf);
>   
>   	return ret ? ret : count;
>   }
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -148,39 +148,61 @@ int thermal_zone_get_trip(struct thermal
>   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>   
>   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> -			  const struct thermal_trip *trip)
> +			  enum thermal_set_trip_target what, const char *buf)
>   {
> -	struct thermal_trip t;
> -	int ret;
> +	struct thermal_trip *trip;
> +	int val, ret = 0;
>   
> -	ret = __thermal_zone_get_trip(tz, trip_id, &t);
> +	if (trip_id < 0 || trip_id >= tz->num_trips)
> +		return -EINVAL;
> +
> +	ret = kstrtoint(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (t.type != trip->type)
> -		return -EINVAL;
> +	mutex_lock(&tz->lock);
>   
> -	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
> -		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
> -		if (ret)
> -			return ret;
> -	}
> +	trip = &tz->trips[trip_id];
>   
> -	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
> -		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
> -		if (ret)
> -			return ret;
> +	switch (what) {
> +	case THERMAL_TRIP_SET_TEMP:
> +		if (val == trip->temperature)
> +			goto unlock;
> +
> +		if (tz->ops->set_trip_temp) {
> +			ret = tz->ops->set_trip_temp(tz, trip_id, val);
> +			if (ret)
> +				goto unlock;
> +		}
> +		trip->temperature = val;
> +		break;
> +
> +	case THERMAL_TRIP_SET_HYST:
> +		if (val == trip->hysteresis)
> +			goto unlock;
> +
> +		if (tz->ops->set_trip_hyst) {
> +			ret = tz->ops->set_trip_hyst(tz, trip_id, val);
> +			if (ret)
> +				goto unlock;
> +		}
> +		trip->hysteresis = val;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
>   	}
>   
> -	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
> -		tz->trips[trip_id] = *trip;
> -
>   	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>   				      trip->temperature, trip->hysteresis);
>   
>   	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   
> -	return 0;
> +unlock:
> +	mutex_unlock(&tz->lock);
> +
> +	return ret;
>   }
>   
>   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -283,9 +283,6 @@ int __thermal_zone_get_trip(struct therm
>   int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			  struct thermal_trip *trip);
>   
> -int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> -			  const struct thermal_trip *trip);
> -
>   int for_each_thermal_trip(struct thermal_zone_device *tz,
>   			  int (*cb)(struct thermal_trip *, void *),
>   			  void *data);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

