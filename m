Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6490776BC82
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjHAS3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHAS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:29:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF32139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:29:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so56093965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690914578; x=1691519378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5ZgJY5V+lo4A+wauiGyF7FGynGi+N7roRkZKmsI0AM=;
        b=eT2gdrPCtxsywlMIzI0TJTR9wixsxeRfVWlJ3BZYPS8d2A4Wauy/Buvv0XyiqEXPL8
         wSj9acw6cTiJ6TFtLC0bidkO5jKw0nX1nF1b2h33y3ITkSmbqQ6vV1I4Eks2octUl9jc
         GZbqNMMiD9+wJoysKKB1omyJkZgN0CevVnP/oA208funS7zPZkVEDa9CcWejL8AzC3rJ
         mQ9pOgCQVlFeKabtlLhKlZP31oVmsvGM1Bx8sWee13rRd/O6zsBNOkAOpiqM+dxhX2Qi
         5iCk1af131QanFGOVh+/qeuX4YDmmGOGUlQfu+8/7/7FiaE6fuPJjAbHHzPzENoLOP7X
         I08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914578; x=1691519378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5ZgJY5V+lo4A+wauiGyF7FGynGi+N7roRkZKmsI0AM=;
        b=S+zH78yosUMmGBlBxqUnttHHNV9VITY8HzideGNVGq+ZaIV2wZxrok9SNtsEAAycoT
         0MJLaBUUrRzMWT4C0fJV2dYBdCU2DoE1VVe4SHuSODdRD+3I2fuGTrOFE+taC+jDP2YP
         BZ9GAgLx3zo51BKXGepnkW6QEAM7DuXYLK95EW5BVUJ238aYKco+pWHkAm9rQqNV//Pt
         JeZ0N8ty24HuKxWnnOCH+5k0gnsPncDzNHl/tmvMH0qNkJQU+7kWrD7n3uw0EltU3K9k
         m0MZETiyzA5YqPIRCGs2fS/kmyxAJn8aPI4G8genuI2IwEIHlTMAJ+j1inoyVfKpJ74j
         s1VA==
X-Gm-Message-State: ABy/qLal8M7T2A5mKuP8AhJ71Pmcr87IkmkIOEr4l9SlAQ3XbuE5+nf0
        3fmZU5jGE/HngdOUn98SSjsLag==
X-Google-Smtp-Source: APBJJlGUPVRlf5YX550xqXJIcw2gB32dk1dhHfelMrwI3HdnHxIp01OWrQLT5vrnjc1FZrNabpYHLA==
X-Received: by 2002:a7b:cb88:0:b0:3fc:f9c:a3e6 with SMTP id m8-20020a7bcb88000000b003fc0f9ca3e6mr3096943wmi.9.1690914578528;
        Tue, 01 Aug 2023 11:29:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c16-20020a7bc010000000b003fbb06af219sm14355016wmb.32.2023.08.01.11.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:29:38 -0700 (PDT)
Message-ID: <8ea6d9b1-f8a5-a899-ea30-7ec5d40a0c26@linaro.org>
Date:   Tue, 1 Aug 2023 20:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/8] thermal: core: Do not handle trip points with
 invalid temperature
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4822145.GXAFRqVoOG@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4822145.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 14:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Trip points with temperature set to THERMAL_TEMP_INVALID are as good as
> disabled, so make handle_thermal_trip() ignore them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes.
> 
> v1 -> v2: No changes.
> 
> ---
>   drivers/thermal/thermal_core.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -348,7 +348,8 @@ static void handle_thermal_trip(struct t
>   	struct thermal_trip trip;
>   
>   	/* Ignore disabled trip points */
> -	if (test_bit(trip_id, &tz->trips_disabled))
> +	if (test_bit(trip_id, &tz->trips_disabled) ||
> +	    trip.temperature == THERMAL_TEMP_INVALID)
>   		return;

This will set the temperature to THERMAL_TEMP_INVALID at each thermal 
zone update.

It would make more sense to set it when setting the disabled bit at init 
time, no?

But is that something we really want to do ? The trip point will be 
reordered due to the temperature change (-273°C)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

