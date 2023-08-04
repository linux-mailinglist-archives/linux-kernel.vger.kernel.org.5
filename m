Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470B76FBCB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjHDIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHDIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:17:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F6B469A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:17:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31783d02093so1631051f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691137049; x=1691741849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtpPWtmTMtrxIoIHR4Tp9VLaeBaBImgFjEFb4F44FV8=;
        b=OuGXWl9mN/2k8BpWiNjcnO2kR/5nOmkrTRFk1rN7pwJ9wE2IgfWd9FMoehMZqN4MOL
         zHd4UnZofLCYqRgquW77v+Ix2miH2/oojPTw9NA08XlMbkKD1pe7Ndrfk4IJyfxL+8WG
         VGSFhhGWGSNn/zY3JL9tdwcv+zDLLZHK7GTJTHmOAbaYLP6oWVwxnKg41cc1TdRBD9/+
         iHilPYZIXSzn9QZ8dHeDvwDxMOO4Jm1cevvYPGjpMIDkVhwSEEZOSkqR/PVNBOeKF8G5
         KNSM7RLHNhXHeiCjRssEhMkxsQFtb74ROlIcI5cscuJ2q8SWvdgsfs2Bbb/j+C467vXQ
         siOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137049; x=1691741849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtpPWtmTMtrxIoIHR4Tp9VLaeBaBImgFjEFb4F44FV8=;
        b=JMsqNtSH7JIxRUlsWn9ktyun2jleca64kVe0U860g+O0Kx4648trWyb91x1VGgbLGS
         tUbSW2FBm196AUWDkpMiWXqujb0wXA1QJ1sKLfBuwMyH+DzL4XB9e3QsWm/egak4tHGO
         LtkiAJ5ejNFaLE9L3TVGSgqOsRBorUmnLyaq7HOizJO3kPDsM4eWXbcATdgKON4xOI7Z
         qak6EEiHFwTwHw/GaOD0ZLktUpMCuh82Qz915hEf5wAxaeJc3mzEnfmkIwqISzbPmGJa
         krgz1lDxfhivYEBKkh+RDPtHLVjK2IOcSEVc3i5DAbrK4HyfQCxnYgPsiBLBqS/CrGZK
         x4kg==
X-Gm-Message-State: AOJu0Ywf748IZCl6xlGMycI+7Xn4hEmPThnc0R+yoOKYXWDvDzlMmfWR
        SqrVvJhdz0oswt/8BuQfrQmBofTvipp5yKw/UlU=
X-Google-Smtp-Source: AGHT+IGgX/IfuWOTGmQUfDoIrgeXHHPS9RMUliwMNOygIkLHwq4te6gwJtnUBoUHbvEvzc44DFDCbQ==
X-Received: by 2002:adf:fd12:0:b0:313:dfa3:4f7b with SMTP id e18-20020adffd12000000b00313dfa34f7bmr735709wrr.20.1691137049217;
        Fri, 04 Aug 2023 01:17:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u10-20020adfed4a000000b003144b95e1ecsm1866611wro.93.2023.08.04.01.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:17:28 -0700 (PDT)
Message-ID: <03643466-2f5c-2d68-424d-19836dcceb78@linaro.org>
Date:   Fri, 4 Aug 2023 10:17:28 +0200
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
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
 <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
 <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
 <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
 <CAJZ5v0gtkZTwt-qP0uwvTJNx8cpO1o1esmW9BfVxB67X3Yt++w@mail.gmail.com>
 <b4e474f9-79e8-534b-509e-12eb5995fa0c@linaro.org>
 <CAJZ5v0iH+qf6eBuZASPKyA6rT8O6FiA7516MiYYUx6Uc+wR4Ow@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iH+qf6eBuZASPKyA6rT8O6FiA7516MiYYUx6Uc+wR4Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 21:58, Rafael J. Wysocki wrote:
> On Thu, Aug 3, 2023 at 6:20 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 03/08/2023 16:15, Rafael J. Wysocki wrote:
>>> On Thu, Aug 3, 2023 at 3:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 02/08/2023 18:48, Rafael J. Wysocki wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>> Let me check if I can do something on top of your series to move it in
>>>>>> the ACPI driver.
>>>>>
>>>>> It doesn't need to be on top of my series, so if you have an idea,
>>>>> please just let me know what it is.
>>>>>
>>>>> It can't be entirely in the ACPI driver AFAICS, though, because
>>>>> trips[i] need to be modified on updates and they belong to the core.
>>>>> Hence, the driver needs some help from the core to get to them.  It
>>>>> can be something like "this is my trip tag and please give me the
>>>>> address of the trip matching it" or similar, but it is needed, because
>>>>> the driver has to assume that the trip indices used by it initially
>>>>> may change.
>>>>
>>>> May be I'm missing something but driver_ref does not seems to be used
>>>> except when assigning it, no?
>>>
>>> It is used on the other side.  That is, the value assigned to the trip
>>> field in it is accessed via trip_ref in the driver.
>>>
>>> The idea is that the driver puts a pointer to its local struct
>>> thermal_trip_ref into a struct thermal_trip and the core stores the
>>> address of that struct thermal_trip in there, which allows the driver
>>> to access the struct thermal_trip via its local struct
>>> thermal_trip_ref going forward.
>>>
>>> Admittedly, this is somewhat convoluted.
>>>
>>> I have an alternative approach in the works, just for illustration
>>> purposes if nothing else, but I have encountered a problem that I
>>> would like to ask you about.
>>>
>>> Namely, zone disabling is not particularly useful for preventing the
>>> zone from being used while the trips are updated, because it has side
>>> effects.  First, it triggers __thermal_zone_device_update() and a
>>> netlink message every time the mode changes, which can be kind of
>>> overcome.
>>
>> Right
>>
>>> But second, if the mode is "disabled", it does not actually
>>> prevent things like __thermal_zone_get_trip() from running and the
>>> zone lock is the only thing that can be used for that AFAICS.
>>   >
>>> So by "disabling" a thermal zone, did you mean changing its mode to
>>> "disabled" or something else?
>>
>> Yes, that is what I meant.
>>
>> May be the initial proposal by updating the thermal trips pointer can
>> solve that [1]
> 
> No, it can't.  An existing trips[] table cannot be replaced with a new
> one with different trip indices, because those indices are already in
> use.  And if the indices are the same, there's no reason to replace
> trips.
> 
>> IMO we can assume the trip point changes are very rare (if any), so
>> rebuilding a new trip array and update the thermal zone with the pointer
>> may solve the situation.
>>
>> The routine does a copy of the trips array, so it can reorder it without
>> impacting the array passed as a parameter. And it can take the lock.
> 
> The driver can take a lock as well.  Forbidding drivers to use the
> zone lock is an artificial limitation without technical merit IMV.

Yes, it is technically possible to take a lock from a driver. However, 
from a higher perspective, we have a core framework which is 
self-contained and we have a back-end which forces us to export this lock.

Even if it is possible, it is not desirable because we break the 
self-containment and thus that will make future changes in the core 
framework complicated because of the interactions with back-end drivers.

I'm not putting in question your changes in general but just want to 
keep the direction of having the core framework and the drivers 
interacting with the ops and a few high level functions where the core 
framework handle the logic.

The clocksource/clockevent drivers are an example on how the time 
framework and the drivers are clearly separated.

>> We just have to constraint the update function to invalidate arrays with
>> a number of trip points different from the one initially passed when
>> creating the thermal zone.
>>
>> Alternatively, we can be smarter in the ACPI driver and update the
>> corresponding temperature+hysteresis trip point by using the
>> thermal_zone_set_trip() function.
> 
> I don't see why this would make any difference.

The function thermal_zone_set_trip() takes the lock.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

