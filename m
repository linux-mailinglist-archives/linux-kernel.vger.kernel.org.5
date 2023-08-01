Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59DA76BDD3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHATbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjHATb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:31:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C721718
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:31:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe24b794e5so18725745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690918283; x=1691523083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0k+A7StIulck13gMjusdP0c4WO4z/7CXgwSPJxPhFXI=;
        b=iqH+UtYxa2Bx6csoyd8hX7eSZhs/7wmRJrH4rpMtDV8IZ77AW5ns5Tg1cQ+gCFJUvX
         IddH1VHNrZSZ8B9Bibvyhtmz6yz69G1GT7pNfuBn0p0NqwWO+WjZR0OrjVqtHUyv2drF
         +c3tDsTPL0KBukADyIK3aVWIdrdcb+E0qWOpwuaVCy6B/kR6x+lN/e0P8mHZpt+OHO6C
         VcDfFRAfYC8Q1ZgnUHlKKCZp9ZCVulL/c2BbqH2++irfiJEOWVHMkwdrhHKgSndehv+Z
         /SptB6NBE5cZNUbNfuP6NPQzuT0pvAWnXDdTRBsG2CIQPg+aRQlkGY1VcrG1jJz3Wr6e
         19hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918283; x=1691523083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0k+A7StIulck13gMjusdP0c4WO4z/7CXgwSPJxPhFXI=;
        b=GsF/VYQGm8bLFXTOHfDvhDRhOZayxYlCXBdqrqaopR4I6DJbsdwYLV8UOc5Tui4kYZ
         EcIsyY0YzsQkhGQwtOsNxtZxD47UXKgRFprT0FQUd9uCyQ12YyqmlyuVGpd/VpZvkMBO
         vpLD6n/DEh9M0jLyfVSOEYDpoXjc7Wsg3gSptJAeap3q2bK39QuTLzZg04Ik2LMMoFG3
         vMelI8CwSsC32WIRkmXuK4iggZ7I2+2PuzmkZyPvqaE0MqnSbWE5wV1bvkcmovPjoI+I
         9GbI4nOgVxpWuy7x6kYkSUCux+f+EPP93jmvODTTkG8gQYyBKHdDZ3Fop66upUVYzcc1
         SScA==
X-Gm-Message-State: ABy/qLZRdCYgtsis3cdi4UUqDsAJJMfyarSdUFSblZRXK19ZSViGIS+n
        e5VOhdJdv2aDT817svx6oGsUIg==
X-Google-Smtp-Source: APBJJlE9HZSC0EqXM+vfXMamPRaWnK8SkKJyHJM4eHV+Z4B93Eu9cUKbjxpQ2z2SI/JuIcmqgimLbA==
X-Received: by 2002:a5d:698d:0:b0:317:5e55:f06f with SMTP id g13-20020a5d698d000000b003175e55f06fmr3061086wru.10.1690918283295;
        Tue, 01 Aug 2023 12:31:23 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w12-20020a5d404c000000b0031411b7087dsm16937425wrp.20.2023.08.01.12.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 12:31:22 -0700 (PDT)
Message-ID: <7a204bfe-51b8-80eb-01f3-261a5dfece7d@linaro.org>
Date:   Tue, 1 Aug 2023 21:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/8] thermal: core: Do not handle trip points with
 invalid temperature
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4822145.GXAFRqVoOG@kreacher>
 <8ea6d9b1-f8a5-a899-ea30-7ec5d40a0c26@linaro.org>
 <CAJZ5v0inZBtyVrAvgQ1LaVxZkKZHQJJ7A86ysaMmSKKQ2vmGTw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0inZBtyVrAvgQ1LaVxZkKZHQJJ7A86ysaMmSKKQ2vmGTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 21:05, Rafael J. Wysocki wrote:
> On Tue, Aug 1, 2023 at 8:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 25/07/2023 14:06, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Trip points with temperature set to THERMAL_TEMP_INVALID are as good as
>>> disabled, so make handle_thermal_trip() ignore them.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v2 -> v3: No changes.
>>>
>>> v1 -> v2: No changes.
>>>
>>> ---
>>>    drivers/thermal/thermal_core.c |    3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -348,7 +348,8 @@ static void handle_thermal_trip(struct t
>>>        struct thermal_trip trip;
>>>
>>>        /* Ignore disabled trip points */
>>> -     if (test_bit(trip_id, &tz->trips_disabled))
>>> +     if (test_bit(trip_id, &tz->trips_disabled) ||
>>> +         trip.temperature == THERMAL_TEMP_INVALID)
>>>                return;
>>
>> This will set the temperature to THERMAL_TEMP_INVALID at each thermal
>> zone update.
> 
> What do you mean?
> 
> It doesn't set anything.

Oh never mind, I read '=' not '=='

>> It would make more sense to set it when setting the disabled bit at init
>> time, no?
>>
>> But is that something we really want to do ? The trip point will be
>> reordered due to the temperature change (-273°C)
> 
> Again, I'm not sure what you mean.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

