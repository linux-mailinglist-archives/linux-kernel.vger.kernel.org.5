Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A276CCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjHBMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHBMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:34:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CBF2701
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:34:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31792ac0fefso3706428f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979645; x=1691584445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WFFSn3jymzrJofl23kw/JQQOzxObljhxr6Q0oYB/RQ=;
        b=xx5BRTcxYKZ/Iu1R16AD/iXFgV28VQUghKB1YFHqBlSaX3SroAJ9X0Rthy9CeAqpmD
         i0MyLBuZDWsdaxDYBcMC6pzYkp4lffK6VtpjPJn1z+QYF1T6ctV144gB4fbaj6K9X4t9
         FxrF0I4FVoLoBSL66GlFIIPeZ4kXTKCPQ9wTMKRORORYSiIl4Eibkpj8bmD+rHaesX6m
         7RQp+qU8AQlfjUe+V0jkQK7OEU+prGz38sC7JADaEmNZp23g9dIQ962pDa54AXqvwaK7
         pcYlTFOtTzHEZ3ED3wmHtf4xaEkboPQM7ek47PmkR/xGzMicGA+LeXkr7Nz/+IBooUWH
         pLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979645; x=1691584445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WFFSn3jymzrJofl23kw/JQQOzxObljhxr6Q0oYB/RQ=;
        b=K8de9IE1rubZpw5pLJVW43VRFvS5lQ06adXw20IedQcjx0BxesSX+/dzi3Mdmy1kKN
         VZZJXMyau16G78UV6CxBczDT4rg3WV9SZC72idGvV9+r/kR0/mtAaAOmvMqhm6YeMbSA
         Y5CqSyO6+HEao+H2Ghy/Q3x5VRyN3hIO135GUxGinJ/j9zP27+dfECDkuK5B+AtqPPZo
         DgHjATZOCNExH5jov4PwJC3zeeu53EPTvy1TQ3gZfA6eVtDjAfRmzMbKR0sZsv1S2Wf7
         LxdspiXU8piEailjjhxcLHjkI5bXPI724iflP2Ea3RMRcnRofULus47bWJjpbaFCM9D+
         mi1A==
X-Gm-Message-State: ABy/qLYSxDBdiw51ZeGCch7LWBBrPNHEpp8+HPidXZGM5NiPekaruYb1
        O/mMK558Hr+IZc+kvuGycFA8eNFRfVbkiRJbJ1k=
X-Google-Smtp-Source: APBJJlG0paexJ7/NKsSD0pFtwMtHj6ducITmLEcN/b1nGlAZfXeHsarFYbC9Jd0rlk1G1CcFXoEmsA==
X-Received: by 2002:a5d:4b4d:0:b0:317:54de:7315 with SMTP id w13-20020a5d4b4d000000b0031754de7315mr4430222wrs.61.1690979645208;
        Wed, 02 Aug 2023 05:34:05 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y7-20020adfdf07000000b00317ab75748bsm5916057wrl.49.2023.08.02.05.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:34:04 -0700 (PDT)
Message-ID: <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
Date:   Wed, 2 Aug 2023 14:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
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
 <4501957.LvFx2qVVIh@kreacher>
 <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 01/08/2023 21:02, Rafael J. Wysocki wrote:
> On Tue, Aug 1, 2023 at 8:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 25/07/2023 14:04, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Some drivers need to update trip point data (temperature and/or
>>> hysteresis) upon notifications from the platform firmware or they
>>> may need to reprogram hardware when trip point parameters are changed
>>> via sysfs.  For those purposes, they need to connect struct thermal_trip
>>> to a private data set associated with the trip or the other way around
>>> and using a trip point index for that may not always work, because the
>>> core may need to reorder the trips during thermal zone registration (in
>>> particular, they may need to be sorted).
>>>
>>> To allow that to be done without using a trip point index, introduce
>>> a new field in struct thermal_trip that can be pointed by the driver
>>> to its own data structure containing a trip pointer to be initialized
>>> by the core during thermal zone registration.  That pointer will then
>>> have to be updated by the core every time the location of the given
>>> trip point object in memory changes.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v2 -> v3: No changes.
>>>
>>> v1 -> v2: No changes.
>>>
>>> ---
>>>    drivers/thermal/thermal_core.c |   20 +++++++++++++++++---
>>>    include/linux/thermal.h        |   13 +++++++++++++
>>>    2 files changed, 30 insertions(+), 3 deletions(-)
>>>
>>> Index: linux-pm/include/linux/thermal.h
>>> ===================================================================
>>> --- linux-pm.orig/include/linux/thermal.h
>>> +++ linux-pm/include/linux/thermal.h
>>> @@ -76,16 +76,29 @@ struct thermal_zone_device_ops {
>>>        void (*critical)(struct thermal_zone_device *);
>>>    };
>>>
>>> +struct thermal_trip_ref {
>>> +     struct thermal_trip *trip;
>>> +};
>>
>> That introduces a circular dependency. That should be avoided.
> 
> Sorry, but this is an empty statement without any substance.

I'm just pointing that we have a struct A pointing to struct B and 
struct B pointing to struct A.

[ ... ]

>>>    struct thermal_cooling_device_ops {
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
>>>        if (result)
>>>                goto release_device;
>>>
>>> +     mutex_lock(&tz->lock);
>>> +
>>>        for (count = 0; count < num_trips; count++) {
>>> -             struct thermal_trip trip;
>>> +             int temperature = 0;
>>> +
>>> +             if (trips) {
>>> +                     temperature = trips[count].temperature;
>>> +                     if (trips[count].driver_ref)
>>> +                             trips[count].driver_ref->trip = &trips[count];
>>> +             } else {
>>> +                     struct thermal_trip trip;
>>
>> As mentioned above, that should not appear in the thermal core code.
> 
> Well, this is a matter of opinion to me.  Clearly, I disagree with it.

Why? It is not an opinion. The thermal core code has been very very tied 
with the ACPI implementation (which is logical given the history of the 
changes). All the efforts have been made to cut these frictions and make 
the thermal core code driver agnostic.

The changes put in place a mechanism for the ACPI driver.

The thermal zone lock wrapper is put in place for the ACPI driver.

> Anyway, I want to be productive, so here's the thing: either something
> like this is done, or drivers need to be allowed to walk the trips
> table.
> 
> Which one is better?

None of them. I think we can find a third solution where the changes are 
self contained in the ACPI driver. What do you think?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

