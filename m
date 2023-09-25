Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28E67AD5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjIYKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:19:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1C3A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:19:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405505b07dfso22396145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695637160; x=1696241960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHtjwLPuNIM982JG8tRGrHl7cHo/0iOH5NWHHo23YQ0=;
        b=kq/BZrKIniVcrT/riHVdGvJKkbh0cmY0CBflhmr6xg20tqNTd7ktEbnrV16ctca1ZR
         KnTLjjb2XYwss6REge+2CS0d0fz5nKLd8uQQcWdGlGf6uX6QOYWbiPCfccLAbu08T+U9
         2oHEVQ9vk72FOfpo6/TWws9TFVcCnjMuL8xAV8mkMegLU5zKsa6Mqd1Rq51zuoKNYt3h
         DlpGAxC19mopX8TzfW08oLyDHfY/NOJ4HUmtQSwl5YB7vo2H+zC5t50uRTvzVv7szkCm
         5elcVOPQx/hP3gR3zQ0ejcoJ+H9O6jqASaocar98TuXMuSSGkET/OMcTN55s2MLU+lF0
         9UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695637160; x=1696241960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHtjwLPuNIM982JG8tRGrHl7cHo/0iOH5NWHHo23YQ0=;
        b=NKCGozjVLHkfvxkCSLwRqW8Ues/tALYsjEJ9rLo9RIx+u7EKD+VFsp+HZyneimrq/l
         L8el/KRdnecLdr/qEc66K9TKsNgeVBlM6E9e2uXZtN4V1RJDwMCW/sJ4GM3BfBJvfkPF
         GKIMhAsQUN+gEFdy/BXPE6gCMNIXO9RYaCrF+TtiPwc9TLEoefnUE0Jsl/27FYPKzADs
         mJWWuFD9yuibJ7rTdh0Cfl1UHqnxmRSCCg+KeYkHw0JYCfaEJPaDXPZgx8uvkrp14lfO
         yGoKvBrPStadyNJterbF1iYhbhjxcxYs0ul+C5B+3muHQ7Bu/UtdDupoHtszf1zVqIQH
         J5YA==
X-Gm-Message-State: AOJu0YwEqkmg9XSIOaZI/hvWdP47YC2LdRr06VkYozM+DU0ByGa+FSUN
        x1Mi7aTYS0PCk+zwDeAncKzel/Henqh6pGxZ5zQ=
X-Google-Smtp-Source: AGHT+IEk9j2816s7sFR+gkKxXV2xh8ch+/ES8qsjs/S06EjJobIwoZuLiCcNyAiK37ukW2W8UqWo7g==
X-Received: by 2002:a1c:6a1a:0:b0:403:c70b:b688 with SMTP id f26-20020a1c6a1a000000b00403c70bb688mr5207596wmc.6.1695637160370;
        Mon, 25 Sep 2023 03:19:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm9199319wml.47.2023.09.25.03.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:19:19 -0700 (PDT)
Message-ID: <7558dd96-0d96-9463-9a97-7ea8bac2046e@linaro.org>
Date:   Mon, 25 Sep 2023 12:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal: core: Check correct temperature for thermal trip
 notification
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230922192724.295129-1-nfraprado@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230922192724.295129-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nicolas,

On 22/09/2023 21:27, Nícolas F. R. A. Prado wrote:
> The thermal trip down notification should be triggered when the
> temperature goes below the trip temperature minus the hysteresis. But
> while the temperature is correctly checked against that, the last
> temperature is instead compared against the trip point temperature. The
> end result is that the notification won't always be triggered, only when
> the temperature happens to drop quick enough so that the last
> temperature was still above the trip point temperature.
> 
> Fix the incorrect check.
> 
> Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 58533ea75cd9..120fcf23b8e5 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -361,7 +361,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip_id)
>   		    tz->temperature >= trip.temperature)
>   			thermal_notify_tz_trip_up(tz->id, trip_id,
>   						  tz->temperature);
> -		if (tz->last_temperature >= trip.temperature &&
> +		if (tz->last_temperature >= (trip.temperature - trip.hysteresis) &&
>   		    tz->temperature < (trip.temperature - trip.hysteresis))
>   			thermal_notify_tz_trip_down(tz->id, trip_id,
>   						    tz->temperature);

We already did a try to fix the thermal trip cross notification but this 
is not sufficient for a full fix.

We are receiving multiple notifications from the same event, all this 
due to the hysteresis.

Let's say, we have a trip point T and a hysteresis H.

There is a trip point crossed the way up when:

	last_temperature < T and temperature >= T

At this point, we send a notification

Now, the temperature decreases but it stays in the hysteresis:

	last_temperature >= T and temperature > (T - H)

And then, the temperature increases again and is greater than T.

	last_temperature > (T - H) and temperature >= T

We send a second notification.

With the mitigation kicking in at temp >= T, we end up with multiple 
events 'temperature crossed the trip point the way up"'. That forces the 
receiver of the events to detect duplicate events in order to ignore them.

More info:

	https://lore.kernel.org/all/20220718145038.1114379-4-daniel.lezcano@linaro.org/
	
We have done a lot of cleanups to use the 'generic trip points' and 
remove those get_trip_* ops. So the trip point structure is a core 
component being reused by the drivers and registered as an array.

Next step is to make sure the trip points are ordered in the array, so 
we can implement the correct trip point crossing detection.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

