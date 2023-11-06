Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52757E1814
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKFACi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:02:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32985D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:02:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so2309595f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 16:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699228952; x=1699833752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1AYyM8WMgGaJPfSt8fkmKPCmurjYQvKjXkBlzKHwao=;
        b=T65BnQt7GdaGf91W48Is3AWtj1PvJVhY4kKuXBEP2vQ1/OE8ivVbFbvuVnszVSl/Pl
         gAbxJnO/4/bDtJwiePL+WNCqaeGi96rSDoL9sdewtqqJvMaeBjTd0j0Aa5jgkHWznD2D
         /JsnysPfBTN9ID1LwxiSOb8AsFV08dbeWlpxErBAZF7nQnQLAUWyFoh2ju8ZpP3jfLFK
         czOWVGjiz42ewdWkEP/Hd7tzeF6AY9T58TS/0rPvCIaJUo/20/91qOnjHEpts6FbhaUP
         v22ezo2bq1SmUUWyh0u9UcoZJAZb8cil4A9UCGYxqnmp/iKIDC9HkDKDgCuE3lbOvP9U
         syPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699228952; x=1699833752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1AYyM8WMgGaJPfSt8fkmKPCmurjYQvKjXkBlzKHwao=;
        b=eFoRuBUYbZ6fFsrtcwm0gHpUHM0xASyTPf7sGq9q/Fx5TVRrTj60Q7yl1ynNTId0ug
         OX3JUUw1O2CrdnvKaCevXibtT9IwGQjeFa4o749jSSGdG3Zrl3n5A4SS+oIgDJbC94TE
         47Oo9FF6pEkmTmpl8ilYxOFAR7SK0t/fTB9Kml8Rvabvo6ffl4k+kc93/qwWZtEog8+4
         TSxtbw6ABLpdjE4ThPL1vMfzveKsqa+iKc/vUrwxGo+uxOU+V16rEcRBODPLDZ17F6Cv
         /93tioYejdLeTnNZ1XZZYt56eLu8SqL3AOPbjnIS9a00VbewReqaOB7vmDmFYd7HnHqm
         Bncg==
X-Gm-Message-State: AOJu0YxOS2nK1+4gQS/E5Pr3P0m2K2ZzpJ0DJk5pxn9NdQeMZGIS/MT/
        j4pJYPpznCQSOV5lyJoKCSVwkQ==
X-Google-Smtp-Source: AGHT+IG1SlWCrb8exGbqnTO8eoBdntnUvQrXYJfIuCg2LsAQitLdPnyoxiskqKc3Y3arWbSVTJYrwA==
X-Received: by 2002:a5d:5887:0:b0:32f:b47c:f1f6 with SMTP id n7-20020a5d5887000000b0032fb47cf1f6mr8893115wrf.32.1699228952385;
        Sun, 05 Nov 2023 16:02:32 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:3442:eeb4:7620:ee3d? ([2a05:6e02:1041:c10:3442:eeb4:7620:ee3d])
        by smtp.googlemail.com with ESMTPSA id i7-20020adfe487000000b0032de6f95fb3sm7834663wrm.40.2023.11.05.16.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 16:02:31 -0800 (PST)
Message-ID: <283d4abe-885b-415d-a24d-681408a23845@linaro.org>
Date:   Mon, 6 Nov 2023 01:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Add trip thresholds for trip crossing
 detection
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <12317335.O9o76ZdvQC@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12317335.O9o76ZdvQC@kreacher>
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


On 03/11/2023 15:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The trip crossing detection in handle_thermal_trip() does not work
> correctly in the cases when a trip point is crossed on the way up and
> then the zone temperature stays above its low temperature (that is, its
> temperature decreased by its hysteresis).  The trip temperature may
> be passed by the zone temperature subsequently in that case, even
> multiple times, but that does not count as the trip crossing as long as
> the zone temperature does not fall below the trip's low temperature or,
> in other words, until the trip is crossed on the way down.
> 
> |-----------low--------high------------|
>               |<--------->|
>               |    hyst   |
>               |           |
>               |          -|--> crossed on the way up
>               |
>           <---|-- crossed on the way down
> 
> However, handle_thermal_trip() will invoke thermal_notify_tz_trip_up()
> every time the trip temperature is passed by the zone temperature on
> the way up regardless of whether or not the trip has been crossed on
> the way down yet.  Moreover, it will not call thermal_notify_tz_trip_down()
> if the last zone temperature was between the trip's temperature and its
> low temperature, so some "trip crossed on the way down" events may not
> be reported.
> 
> To address this issue, introduce trip thresholds equal to either the
> temperature of the given trip, or its low temperature, such that if
> the trip's threshold is passed by the zone temperature on the way up,
> its value will be set to the trip's low temperature and
> thermal_notify_tz_trip_up() will be called, and if the trip's threshold
> is passed by the zone temperature on the way down, its value will be set
> to the trip's temperature (high) and thermal_notify_tz_trip_down() will
> be called.  Accordingly, if the threshold is passed on the way up, it
> cannot be passed on the way up again until its passed on the way down
> and if it is passed on the way down, it cannot be passed on the way down
> again until it is passed on the way up which guarantees correct
> triggering of trip crossing notifications.
> 
> If the last temperature of the zone is invalid, the trip's threshold
> will be set depending of the zone's current temperature: If that
> temperature is above the trip's temperature, its threshold will be
> set to its low temperature or otherwise its threshold will be set to
> its (high) temperature.  Because the zone temperature is initially
> set to invalid and tz->last_temperature is only updated by
> update_temperature(), this is sufficient to set the correct initial
> threshold values for all trips.
> 
> Link: https://lore.kernel.org/all/20220718145038.1114379-4-daniel.lezcano@linaro.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 (RFC) -> v2: Add missing description of a new struct thermal_trip field.
> 
> And because no comments have been sent for a week, this is not an RFC
> any more.

Can you give me a few days to review this patch and test it with some 
debugfs code planned to be submitted?

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

