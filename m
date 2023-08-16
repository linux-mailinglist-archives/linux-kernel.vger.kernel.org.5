Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1388977E651
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjHPQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbjHPQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:25:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC823272B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:25:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe8a158fcbso48085655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692203131; x=1692807931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08B+ShI7xrrN5X88VrSc2sfz7TBWkw8FJeF7CumSbag=;
        b=WU8Ohxl7XC8aAQCY6gaC4M7nujPuhmMcqm9o+3KtSZNuHlbXpGYPN/o+dA62H0Bv7k
         iHvelKaABBbNWwSa+5lo3OpKW8wQQ4hRrOYffMVSWcHq4mHKeRPzojG2WDQbTu6NI+ll
         cmYGdykzrHtTqsWnzrOOdlyERYWvh4HnxLsggRX0WmCmjHqiLCJg7T1aKx1hjn0uyedn
         C2wePv67sOSdJwdgiL9R/8TeNkwThTZiRXk/jbufruq9xmByq601akaend3ZoDenLwcD
         ir/VSP6i6ZbdazRrMCW2Q9TUEr20FTp8y5/wwV7pc6clBxag4XW92LkH7PQyUv6Se1Em
         3L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203131; x=1692807931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08B+ShI7xrrN5X88VrSc2sfz7TBWkw8FJeF7CumSbag=;
        b=Hi8/VLGI6Bm7daWaoUcOfNj7uMLByzLWvKFZz1I79wGGteffjSh8T7cz3qNayqex/e
         ax2d9Dr5yozmtRbny1I8nmJnJgSfrFwKr4j1M7aVO6ioGknplMULAzUdlb1xYIHg6tjA
         SBYItBRd2jsmNKJHMVnRdQilTyTCkTrAA0LvoSjPhwVtUWhlrQMY4bw/bsXBZ9e3Nsu3
         jCuz9IUy/ZSeZxAjAGpYnfXLCio/s4TwInqpc8DVQSx9Olc9HlAKOZY3P8iGTuuViVFb
         Q/Pvpcw22EAIXoyYQt3cPNZn6iwcSFfdnWmBoFyPDduSkexubhb1Gtzdof4iBJye57YU
         QF0w==
X-Gm-Message-State: AOJu0YxeTP87Ac5TsVVbnJ8sSHR6aoYNOe5Lw1GAfrrzmUIYlL+y4pGd
        Nx7QRW9JwKoYzETV8bhJJ3Fl1g==
X-Google-Smtp-Source: AGHT+IGgD7U5dlhpBPbYmCPv5P83ayzCohsiJSs0Azcg9o8gUOJhbXugj2UuZQBo5tDzBEA3lZtIYw==
X-Received: by 2002:a05:600c:3797:b0:3fe:5501:d282 with SMTP id o23-20020a05600c379700b003fe5501d282mr1966098wmr.34.1692203131198;
        Wed, 16 Aug 2023 09:25:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm24687785wmd.19.2023.08.16.09.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:25:30 -0700 (PDT)
Message-ID: <c53f99db-353a-26c3-3b0a-3a3befbed528@linaro.org>
Date:   Wed, 16 Aug 2023 18:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 05/11] ACPI: thermal: Carry out trip point updates
 under zone lock
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
 <2236767.iZASKD2KPV@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2236767.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 20:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a race condition between acpi_thermal_trips_update() and
> acpi_thermal_check_fn(), because the trip points may get updated while
> the latter is running which in theory may lead to inconsistent results.
> For example, if two trips are updated together, using the temperature
> value of one of them from before the update and the temperature value
> of the other one from after the update may not lead to the expected
> outcome.
> 
> Moreover, if thermal_get_trend() runs when a trip points update is in
> progress, it may end up using stale trip point temperatures.
> 
> To address this, make acpi_thermal_trips_update() call
> thermal_zone_device_adjust() to carry out the trip points update and
> provide a new  acpi_thermal_adjust_thermal_zone() wrapper around
> __acpi_thermal_trips_update() as the callback function for the latter.
> 
> While at it, change the acpi_thermal_trips_update() return data type
> to void as that function always returns 0 anyway.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

[ ... ]

>   {
> -	int i, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
>   	bool valid;
> +	int i;
>   
> -	if (ret)
> -		return ret;
> +	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
>   
>   	valid = tz->trips.critical.valid |
>   		tz->trips.hot.valid |
> @@ -710,6 +732,7 @@ static struct thermal_zone_device_ops ac
>   	.get_trend = thermal_get_trend,
>   	.hot = acpi_thermal_zone_device_hot,
>   	.critical = acpi_thermal_zone_device_critical,
> +	.update = acpi_thermal_adjust_thermal_zone,

It is too bad we have to add a callback in the core code just for this 
driver.

I'm wondering if it is not possible to get rid of it ?

Is it possible to use an internal lock for the ACPI driver to solve the 
race issue above ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

