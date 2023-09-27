Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63BA7B095C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjI0Pvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjI0Pve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:51:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CFA3ABA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:37:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3232be274a0so4244254f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695829065; x=1696433865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+c41Z29h1pZ9sFJu8iZns80gRGUweaCHUdE5sjhlKV0=;
        b=KtQF4pW03iIWPv5xPYwQV3QLNvnjhueUvM2vS3aE6Yd5En5CgQX13jRnb3pSKx201y
         DPfHcA8wXaSaFh/O8bD7sj58+RyOyrbypD+h2/BJnwZF5ssJS4EswYWdLE/6HmOZPR55
         M2jDaO+2z2zYHzyI7nJM0o4mjFE5YSm8XKtiDbEbbiFYuYErsZxIcYYZE+mtSLMp0L2K
         KhiNzgKH+QRzdb/aCaBuBetesVDsSfgdiKT+3ectSM91o5pcVTaGHrLH3QPfFnTlshZ1
         cPANNNTUO48O89Ftu+2dVshtV/8V+qz+t6VghlKzFtybjM1DG859irxtwMTd8XoBAWfd
         a7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829065; x=1696433865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c41Z29h1pZ9sFJu8iZns80gRGUweaCHUdE5sjhlKV0=;
        b=IuGlJt6vkDppyFBbk1nXPbtSmm6Bx+bGeQZdrPFhr3X6QAOqo0OrXuKG8KkHAjTPu+
         FM/Tm5tJMwxzJzMXsJaq/sb62FQQyAVFBghQmTg4fYWFH/QbbSf1ZQwFUWhsobwwYn9I
         XM3D1/WW5Wjy3W1UEzyhd6s9G4mnf1I771PwW38Wtg2dcdiFAcyO4gBJF5JLqA5ppOE9
         hMcMawYm53AkOgZmgbM26vxgDSJwaL0RXdQ07bNN0al9Kisg6Vw+QfOmQ7x/istmNKnp
         VHh/4upgZxgUY9E7FuqPN+IQ2NQU+gSeow3gaLutjsBel+SsJiSmZktk/D1FSRNOsRWO
         gK+g==
X-Gm-Message-State: AOJu0YxbNkSAfQ6sRY66L2md7+ws8tokA8CAbuc++AJIz5OcHp+L+pp+
        5n6NLX57QgjVloj460NZrjjOwQP+beEO97dGPdc=
X-Google-Smtp-Source: AGHT+IFBJnn51g+Nws/rADxL0hMPtAm9b/lnLL6DtiDmGTQrfdC3KSFioHmMnuI5UekqIq4rYxqbaw==
X-Received: by 2002:adf:f50f:0:b0:319:5234:5c92 with SMTP id q15-20020adff50f000000b0031952345c92mr1737140wro.35.1695829065420;
        Wed, 27 Sep 2023 08:37:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id x17-20020a5d6511000000b0031fd849e797sm17354482wru.105.2023.09.27.08.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:37:45 -0700 (PDT)
Message-ID: <d4bdea97-1e92-6422-01c4-bf7caca4ea45@linaro.org>
Date:   Wed, 27 Sep 2023 17:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 06/13] thermal: gov_fair_share: Rearrange
 get_trip_level()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <1957441.PYKUYFuaPT@kreacher> <1882755.CQOukoFCf9@kreacher>
 <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org>
 <CAJZ5v0ifXSWd4QL+j-=8OBr1aQr0WAeMBGYtis_gkHJDBLeWMg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ifXSWd4QL+j-=8OBr1aQr0WAeMBGYtis_gkHJDBLeWMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 17:06, Rafael J. Wysocki wrote:
> On Wed, Sep 27, 2023 at 5:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/09/2023 19:54, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make get_trip_level() access the thermal zone's trip table directly
>>> instead of using __thermal_zone_get_trip() which adds overhead related
>>> to the unnecessary bounds checking and copying the trip point data.
>>>
>>> Also rearrange the code in it to make it somewhat easier to follow.
>>>
>>> The general functionality is not expected to be changed.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/thermal/gov_fair_share.c |   22 ++++++++++------------
>>>    1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> Index: linux-pm/drivers/thermal/gov_fair_share.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
>>> +++ linux-pm/drivers/thermal/gov_fair_share.c
>>> @@ -21,23 +21,21 @@
>>>     */
>>>    static int get_trip_level(struct thermal_zone_device *tz)
>>>    {
>>> -     struct thermal_trip trip;
>>> -     int count;
>>> +     const struct thermal_trip *trip = tz->trips;
>>> +     int i;
>>>
>>> -     for (count = 0; count < tz->num_trips; count++) {
>>> -             __thermal_zone_get_trip(tz, count, &trip);
>>> -             if (tz->temperature < trip.temperature)
>>> +     if (tz->temperature < trip->temperature)
>>> +             return 0;
>>> +
>>> +     for (i = 0; i < tz->num_trips - 1; i++) {
>>> +             trip++;
>>> +             if (tz->temperature < trip->temperature)
>>>                        break;
>>>        }
>>
>> Is it possible to use for_each_thermal_trip() instead ? That would make
>> the code more self-encapsulate
> 
> It is possible in principle, but this is a governor which is regarded
> as part of the core, isn't it?
> 
> So is an extra overhead related to using a callback (which may be
> subject to retpolines and such) really justified in this case?

 From my POV, all trip points browsing should be replaced by 
for_each_thermal_trip() so any change in the future in how we go through 
the existing thermal trips will impact one place.

If the routine needs to be optimized, that is something we can do also 
(may be an inline the callback?)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

