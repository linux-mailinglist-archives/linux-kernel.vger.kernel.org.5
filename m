Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37137FDDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjK2Qxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2Qxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:53:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07276B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:53:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332c0c32d19so4499f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701276835; x=1701881635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzCsfdBE7WkJbZOrYaWER7MpwPAWaQ/409ygwrMaF7U=;
        b=jfG8X4mfovjdLYdd1+OXNyAjqIo5Zcxf1Fi6hkebiR955zw5vDDv+W41rktDnlLU11
         AMOsg+h9yUxZQaMMz00ALtoWKnOt5CR0Uf6kW6VaRIGHIeEr1NzUWLqnIpgkr0yXVpn8
         9P1QczoBC9u8/aUdOoXMM0BnDRVyrNw3KB78HrxAiUjjUb3Abmvmydd9S05O+JNNPOhF
         FyyNtvTLWTXbf24z4Gs4ZFcMRF4Rj8f6ABwpuna04KLr4vi62cYbM9scgRr7hUffanMc
         5ffnHgMDh9qhioxMgfNPk6DoN/dh+NUVO63t6bebjMnoHedkT9Cd2akBVU1Wu0kI3ghX
         wdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276835; x=1701881635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzCsfdBE7WkJbZOrYaWER7MpwPAWaQ/409ygwrMaF7U=;
        b=ZX+uikziWaO09u7GOIm118EVn+En/+a6gYzgfMVwNI+Ud5edyqUGQbN7NqjmrOMU/m
         hOXQ1MCdtya/a4j2jylM9E6w51/GlYTWtMcIrNGQQCghiMe9mauNaKnK+0J0eHpoV9KT
         5COiiTFfPrS2axFYy0Sl90UC005LBvT7vL8gry0yWszpUDPrKjyzqgki3XVxmGdNa1o4
         cIB3JdiQ2D0ts+gLEaEK1DQsKPwy06aLW7d7d5AqyQ3ov04v2uBgokE3J2G4M3Q3wJsi
         vqI+fh7yraVQYbETwf2jwvP1tyIFun7ZxVkVVVFnB5i0nXDiYPuWHpZc4qwoJD+nefMq
         1GPw==
X-Gm-Message-State: AOJu0YwRSuNjoJLymgaBvOeAxO6dCUWE0YD6WdBDaIFVlCpVmyn9/1h1
        Jr2Hs6tH4XVJLLYlUcLHO6e3pA==
X-Google-Smtp-Source: AGHT+IEPWyjXiaZUzZ1MrsR0HEwWzcJjiTw6tWwlLLD/S1yLhTsREN8om50ndJRKuEVRPHad5oCR8w==
X-Received: by 2002:a05:6000:c12:b0:332:ffcc:861b with SMTP id dn18-20020a0560000c1200b00332ffcc861bmr8104628wrb.1.1701276835407;
        Wed, 29 Nov 2023 08:53:55 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id x1-20020adfec01000000b003313e4dddecsm18374499wrn.108.2023.11.29.08.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:53:55 -0800 (PST)
Message-ID: <ce9297d4-db9f-44c7-a590-2b9d4600be42@linaro.org>
Date:   Wed, 29 Nov 2023 17:53:54 +0100
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Please hold on before merging this change. I've some comment about it 
but I have to double check a couple of things before


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

