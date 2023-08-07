Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8230772276
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjHGLeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjHGLde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:33:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B485248
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:31:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d43so3864595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691407787; x=1692012587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yG847+ykANyrrRuOFOgUHlifio1mpwNPWStZ5ZsUlY=;
        b=BaO7SpJKv1jDCZvrxi47UrPgRjKOD1RmEA5ftd1m1zmHe0gV4C+bk7yIUsI98W6BzS
         55WzdvGGCvOtueyb9YwFEOr5ZL8MdRkIDGMM2QZb8wIGpKKDXwRaUPSslFUkVAKoD9We
         +r5MmONLSVZOuvZu9hJy5BlT4zY4xTi5F1DYHrrkP/YeTofw4ZvHL47imnoH1u8v2dJa
         YNETI0ySclIuryJ9WmY3b+vQr1II88Wt5+4zejrcpJ3OMfft1nATxN0y6K8d2JkekXw2
         hc6vPMiGzrilbNrVkx7hjvPHX63Ajomg62r+WpB6amQI9Z7lZOTdXdIQq1KbM0kBOMVL
         g82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407787; x=1692012587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yG847+ykANyrrRuOFOgUHlifio1mpwNPWStZ5ZsUlY=;
        b=UUjLNXQmtbLApxob9aCfwsj4phc5K6bpSf5WCsuFSDjgaykV6783i9rPeWTnOrKlNG
         Gwr1XnUgrVvdd7y0Z/H5i4784yhQg7mgNvgdkHP0pmE5a6DCd7Q3OLdu0Elb/Zx7W0Tn
         tdmejDXJRW0eEmNBSGjlH2pAs0S8Rj+krsb6Y50A/xklTr9sokvcArQkO1bEXRT18Zb3
         iqAPAYbMiiH8TmpqREJlP4RznW+JNz4epKvOR7X23bCHiK1hgUs/WCHEdBP8dM4s6EDu
         ngLie9dLdl+Ub12F0bI3R5wL+MLK9yp5wgYSmzuJS9tSDgquakl/wQ6usNJINXbUARDi
         4zfA==
X-Gm-Message-State: AOJu0Yw1gW/pCDy5fcZ97yJT165blLrkpV5DPsmB4ywhf1XPHvRGpdv3
        iQ2v/ufz5IIGnlGsft97BYAxMA==
X-Google-Smtp-Source: AGHT+IE931aONdpzSikETzjGEE2Uo9weVSJZlo9N1M9Pmrb143I2wh0bzp6eN+8C49HMcUZmE6ni2Q==
X-Received: by 2002:a05:600c:208:b0:3fe:ad3:b066 with SMTP id 8-20020a05600c020800b003fe0ad3b066mr7051996wmi.41.1691407787574;
        Mon, 07 Aug 2023 04:29:47 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p17-20020a7bcc91000000b003fe2696ccfcsm10402137wma.23.2023.08.07.04.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:29:47 -0700 (PDT)
Message-ID: <f47b7e17-7ec6-4c19-9db1-c1a2e1ad66b6@linaro.org>
Date:   Mon, 7 Aug 2023 13:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 04/10] thermal: core: Add
 thermal_zone_update_trip_temp() helper routine
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <1967710.PYKUYFuaPT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1967710.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 23:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a helper routine called thermal_zone_update_trip_temp() that
> can be used to update a trip point's temperature with the help of a
> pointer to local data associated with that trip point provided by
> the thermal driver that created it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch in v4.
> 
> ---
>   drivers/thermal/thermal_trip.c |   37 +++++++++++++++++++++++++++++++++++++
>   include/linux/thermal.h        |    4 ++++
>   2 files changed, 41 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -180,3 +180,40 @@ int thermal_zone_set_trip(struct thermal
>   
>   	return 0;
>   }
> +
> +/**
> + * thermal_zone_update_trip_temp - Update the trip point temperature.
> + * @tz: Thermal zone.
> + * @trip_priv: Trip tag.
> + * @temp: New trip temperature.
> + *
> + * This only works for thermal zones using trip tables and its caller must
> + * ensure that the zone lock is held before using it.
> + *
> + * @trip_priv is expected to be the value that has been stored by the driver
> + * in the struct thermal_trip representing the trip point in question, so it
> + * can be matched against the value of the priv field in that structure.
> + *
> + * If @trip_priv does not match any trip point in the trip table of @tz,
> + * nothing happens.
> + */
> +void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
> +				   void *trip_priv, int temperature)
> +{
> +	int i;
> +
> +	lockdep_assert_held(&tz->lock);
> +
> +	if (!tz->trips || !trip_priv)
> +		return;
> +
> +	for (i = 0; i < tz->num_trips; i++) {
> +		struct thermal_trip *trip = &tz->trips[i];
> +
> +		if (trip->priv == trip_priv) {
> +			trip->temperature = temperature;
> +			return;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_update_trip_temp);

This function would imply the comparator is always trip->priv but if we 
want another comparison eg. trip->priv->id, that won't be possible.

Actually, I think you can reuse an existing function with a simple 
change, for_each_thermal_trip() located in thermal_core.h.

The changes would be renaming it without the '__' prefix and moving it 
in include/linux/thermal.h.

Then the comparison function and the temperature change can be an ACPI 
driver specific callback passed as parameter to for_each_thermal_zone



> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -286,9 +286,13 @@ int __thermal_zone_get_trip(struct therm
>   			    struct thermal_trip *trip);
>   int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			  struct thermal_trip *trip);
> +void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
> +				   void *trip_priv, int temperature);
>   
>   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>   			  const struct thermal_trip *trip);
> +void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
> +				   void *trip_priv, int temperature);
>   
>   int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

