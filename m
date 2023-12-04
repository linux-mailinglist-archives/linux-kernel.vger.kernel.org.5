Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A871803AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjLDQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:55:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7FCBB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:55:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so23871745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701708926; x=1702313726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gdwaTpLNBr7sA7AwFQ/+pGFdvl9soWUtB8Z1U9cjJk=;
        b=H24e38KDCSflSRDhe/MKHM50QJuvaWyLD7eewxK7UTV9jsIiyrLyBxLsN4ujkLbTY0
         x9qS/rwx0/lchdnATxx0TzmKD2Ci0jkb3cdzmAdkwTivkh7RK2bl8jFxeBART0rO4M/X
         VFrlpEc4qvAl6RUi6vuT20CwrmPGUOkM1fln/IEqMkx3GJSiCAWUHGns5JmjXUyN/ZPY
         NnHVyJ7qzde9WgzrfdVnRcKkApLjRUO3I4PDmM468zUomHYA0EFFMEZWGa9LzSOIIaTE
         EIAFF9AA1kbiJY4t96afrcaIPkZ9BplJaA+7wUHtcEkATtq3KfaAAVkJvTXpgWpW0SY8
         9VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708926; x=1702313726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gdwaTpLNBr7sA7AwFQ/+pGFdvl9soWUtB8Z1U9cjJk=;
        b=d98xeuz4PadOVXjxkT8cEod29x81XUSloj4fMNhOjI8mAYsmsyeYzjqR6AUZf4Sg/E
         EQMVaRQVi/+NIdihZghjPRKTPGoYayD/sAd4I4idcApnvUxpzzgjAbkwCJgS0bwCRbvB
         YJTa+5trOaG3NRKSK/xFVkKQ3dvuE0NddXS/skvVldcHDT3/23Up5WrEzVlAaAj+0bTn
         rHAl8XMV6pk1KH9nZJxwILA6kPySEDioKawb8ypySaMnkDykw8bXKaDP7tzbXMB64kOK
         yqCMdvXO0zpeTVR1X0Er52aLbl1FDR94UXE9oPxWMblpyFjQx+EL7oWQ2QSzneT6k9fe
         Ldyg==
X-Gm-Message-State: AOJu0YxOs0Crh2womgogT1rAB0lNSUmpsJwHD/kdbMZ37DvsqbNaRAqh
        GOqnsppJw+v2WLBJpb3KGNCJOg==
X-Google-Smtp-Source: AGHT+IEDltZ3Re0khBvM5AY2nz+sa1kkygHRHGWkxzz9Jb4ph4xPFgeiPbj9o7n9hM3b8YiuI+TXzw==
X-Received: by 2002:a05:600c:851a:b0:40b:5392:7ee9 with SMTP id gw26-20020a05600c851a00b0040b53927ee9mr1258612wmb.0.1701708925944;
        Mon, 04 Dec 2023 08:55:25 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c831:1e47:2:5b96? ([2a05:6e02:1041:c10:c831:1e47:2:5b96])
        by smtp.googlemail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm14340224wms.34.2023.12.04.08.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:55:25 -0800 (PST)
Message-ID: <b3c86caf-635d-416b-af98-9e26f2a68948@linaro.org>
Date:   Mon, 4 Dec 2023 17:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal: sysfs: Rework the handling of trip point
 updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <12338384.O9o76ZdvQC@kreacher> <4883151.31r3eYUQgx@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4883151.31r3eYUQgx@kreacher>
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

On 04/12/2023 15:50, Rafael J. Wysocki wrote:
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
> Moreover, input processing need not be done under the thermal zone lock
> in any of these functions.
> 
> Rework trip_point_temp_store() and trip_point_hyst_store() to address
> the above, move the part of thermal_zone_set_trip() that is still
> useful to a new function called thermal_zone_trip_updated() and drop
> the rest of it.
> 
> While at it, make trip_point_hyst_store() reject negative hysteresis
> values.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes
> 
> v1 -> v2: Still check device_is_registered() under the zone lock
> 
> ---
>   drivers/thermal/thermal_core.h  |    2 +
>   drivers/thermal/thermal_sysfs.c |   75 ++++++++++++++++++++++++++++------------
>   drivers/thermal/thermal_trip.c  |   45 ++++--------------------
>   include/linux/thermal.h         |    4 --
>   4 files changed, 64 insertions(+), 62 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -78,6 +78,19 @@ mode_store(struct device *dev, struct de
>   	return count;
>   }
>   
> +static int check_thermal_zone_and_trip_id(struct device *dev,
> +					  struct thermal_zone_device *tz,
> +					  int trip_id)
> +{
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
> +
> +	if (trip_id < 0 || trip_id >= tz->num_trips)
> +		return -EINVAL;

I'm not sure if this check is useful. The function is called from 
trip_point_*_store() which is providing the trip id from the file name 
parsing which is in turn built from an existing trip id. There is no 
reason the trip id is going to be wrong.

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

