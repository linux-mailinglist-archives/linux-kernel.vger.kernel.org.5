Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C33807299
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378956AbjLFOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378870AbjLFOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:38:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2301BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:38:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c236624edso4733075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701873532; x=1702478332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gy0xfaNC3TmuUx7S3psA+A+EQOiJknmpliCDJOGmCGs=;
        b=RenhSSUWfvBNUjxN5b2nV8o0NZ7vKK+axTC+Ik7JwyQzohJi256+FuosE0gGG26V2p
         pMHihYmNZs7+GQ33eBmxNOK7mWMBq7iF+kMjhCecLLIehmp8YqrkYYiR9XBn6GjU26jj
         45d4XGFYG50hJGlZQwOKaSSl7C9DN5XTlAfz4/afxFxQQed3z0T5N1TkMO85u9DT/w9J
         7uSqpDVEPtKX12tluI1BiIU+VKIJY8LTTLHBLXuLM+i8I/kGTMQ91vuq9y+j5SUZW2aK
         UddJwWP19Kn6NvstbJzOt2afA0hxdpNouJP0NPgWjGQGFHpXpQfvQr0VAJY/T9q/aMw6
         afvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873532; x=1702478332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy0xfaNC3TmuUx7S3psA+A+EQOiJknmpliCDJOGmCGs=;
        b=rUqHTwA6LOXMhi5OZlR07tWCDuUJh7Y8N16KVAlMOj/Z5RetTdmozHgQalIBvc1Hw3
         NLSNMQiYZA1uBGbkQs4wK6ndzzhbMv+pUF/R72F1hmxMmZUMTEa9pFoCc7Gp/xBYYVHe
         ibrX9nWv2021eyNgrF/hGWgW9iXzC4Dg7ecej3U0ERbyB6q9K8KbAI4RBJJMFGAt7Z5R
         Wiq2dTS/hf3OP+QdqTVZKQDyGOkat5gapFUhJoMR5oj5kXnJgaNayvMRFXMCjx64BvhF
         dj5+19ZFD83JCVrR9HRiG+i9nN74wPcWRfN9v9wMSlY/zHwUV03iaMu0ge17QrMrwXBM
         64Rg==
X-Gm-Message-State: AOJu0YwtWC29Pqy1BIT/PWU1cz/52xksyundLlcTK5g5OedkEc9Uycxs
        6ux710gmOePPcEYVkCduZsN9qQ==
X-Google-Smtp-Source: AGHT+IHm7G/pgyKDeywjonXsUi1DVYn8l75DnmHejkL/8m44kWNZG0s+vcDFJM1/BPBUwwRVGf8Ytw==
X-Received: by 2002:a05:600c:252:b0:40c:23c7:8cf7 with SMTP id 18-20020a05600c025200b0040c23c78cf7mr364518wmj.167.1701873531976;
        Wed, 06 Dec 2023 06:38:51 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q3-20020adff783000000b003332febec90sm15062021wrp.7.2023.12.06.06.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:38:51 -0800 (PST)
Message-ID: <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
Date:   Wed, 6 Dec 2023 15:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <5737811.DvuYhMxLoT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5737811.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 05/12/2023 20:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The _store callbacks of the trip point temperature and hysteresis sysfs
> attributes invoke thermal_notify_tz_trip_change() to send a notification
> regarding the trip point change, but when trip points are updated by the
> platform firmware, trip point change notifications are not sent.
> 
> To make the behavior after a trip point change more consistent,
> modify all of the 3 places where trip point temperature is updated
> to use a new function called thermal_zone_set_trip_temp() for this
> purpose and make that function call thermal_notify_tz_trip_change().
> 
> Note that trip point hysteresis can only be updated via sysfs and
> trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
> so this code path need not be changed.

Why the ACPI driver is not calling thermal_zone_device_update() after 
changing the trip point like the other drivers?

It would make sense to have the thermal framework to be notified about 
this change and check if there is a trip violation, no ?


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Depends on https://lore.kernel.org/linux-pm/12337662.O9o76ZdvQC@kreacher/
> 
> ---
>   drivers/acpi/thermal.c                                       |    7 +++--
>   drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |    8 +++---
>   drivers/thermal/thermal_sysfs.c                              |    4 +--
>   drivers/thermal/thermal_trip.c                               |   14 ++++++++++-
>   include/linux/thermal.h                                      |    2 +
>   5 files changed, 27 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -146,9 +146,9 @@ trip_point_temp_store(struct device *dev
>   				goto unlock;
>   		}
>   
> -		trip->temperature = temp;
> +		thermal_zone_set_trip_temp(tz, trip, temp);
>   
> -		thermal_zone_trip_updated(tz, trip);
> +		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   	}
>   
>   unlock:
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -152,7 +152,6 @@ int thermal_zone_trip_id(struct thermal_
>   	 */
>   	return trip - tz->trips;
>   }
> -
>   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>   			       const struct thermal_trip *trip)
>   {
> @@ -161,3 +160,16 @@ void thermal_zone_trip_updated(struct th
>   				      trip->hysteresis);
>   	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   }
> +
> +void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> +				struct thermal_trip *trip, int temp)
> +{
> +	if (trip->temperature == temp)
> +		return;
> +
> +	trip->temperature = temp;
> +	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
> +				      trip->type, trip->temperature,
> +				      trip->hysteresis);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -289,6 +289,8 @@ int thermal_zone_for_each_trip(struct th
>   			       int (*cb)(struct thermal_trip *, void *),
>   			       void *data);
>   int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
> +void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> +				struct thermal_trip *trip, int temp);
>   
>   int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
>   
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -294,6 +294,7 @@ static int acpi_thermal_adjust_trip(stru
>   	struct acpi_thermal_trip *acpi_trip = trip->priv;
>   	struct adjust_trip_data *atd = data;
>   	struct acpi_thermal *tz = atd->tz;
> +	int temp;
>   
>   	if (!acpi_trip || !acpi_thermal_trip_valid(acpi_trip))
>   		return 0;
> @@ -304,9 +305,11 @@ static int acpi_thermal_adjust_trip(stru
>   		acpi_thermal_update_trip_devices(tz, trip);
>   
>   	if (acpi_thermal_trip_valid(acpi_trip))
> -		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
> +		temp = acpi_thermal_temp(tz, acpi_trip->temp_dk);
>   	else
> -		trip->temperature = THERMAL_TEMP_INVALID;
> +		temp = THERMAL_TEMP_INVALID;
> +
> +	thermal_zone_set_trip_temp(tz->thermal_zone, trip, temp);
>   
>   	return 0;
>   }
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -225,7 +225,8 @@ EXPORT_SYMBOL_GPL(int340x_thermal_zone_r
>   
>   static int int340x_update_one_trip(struct thermal_trip *trip, void *arg)
>   {
> -	struct acpi_device *zone_adev = arg;
> +	struct int34x_thermal_zone *int34x_zone = arg;
> +	struct acpi_device *zone_adev = int34x_zone->adev;
>   	int temp, err;
>   
>   	switch (trip->type) {
> @@ -249,14 +250,15 @@ static int int340x_update_one_trip(struc
>   	if (err)
>   		temp = THERMAL_TEMP_INVALID;
>   
> -	trip->temperature = temp;
> +	thermal_zone_set_trip_temp(int34x_zone->zone, trip, temp);
> +
>   	return 0;
>   }
>   
>   void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
>   {
>   	thermal_zone_for_each_trip(int34x_zone->zone, int340x_update_one_trip,
> -				   int34x_zone->adev);
> +				   int34x_zone);
>   }
>   EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

