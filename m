Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7975776D2FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjHBPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjHBPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:52:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB994233
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:50:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso167555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690991449; x=1691596249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Ss3r+QCu4BZnzw3b/YfsbbL8/OQIEjREb8HjMtg3ug=;
        b=z50j76Y9e/MdwtFR3s6pty1bP2KztmrSyEziF9Q4jMbM02yt65YmZf0Cytxyvd6Qe8
         KbNgyp/s51Mb9DBd50WvqnsEQtGA1p9unhpRArpA+0h/v4AFPkPlSZXdUr33JTqc+Zvu
         1OVVAsBDH9MbG+F/gDz+XBnoOynoLXml+p6dr7VMRB66xY5fRgvd4Mi6IP+hkfbEHNNa
         J0CRLr9PEpNT0d2TqdtAf6b8o85UU/KmKomgFPzXmvbEbpRNmk8IVB9d6fM5G5ea7uR8
         q2BpEWRg5NKmqqjyVOspVF2lYpewWXh2wfq2qDQGa0HA/1+489h2sE4PbDAUvixu9oB+
         2gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991449; x=1691596249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ss3r+QCu4BZnzw3b/YfsbbL8/OQIEjREb8HjMtg3ug=;
        b=f+h4uZaprYdIjmHJHADDPfsAj/HtrImxmnaohUaILAk1h7P8RynGpBjtn2YyKjLSr7
         STR+IbAfeWL6K8F6De0llsDvp0aa6MpU/F+HTTB1LWiytfuEzAwMh5MkoHpa07ko3s6/
         b1WI/5ntwdTCP59v0EaLSbxxRw3GfuwHvkWlFGeCSZxVxYrV/3g8iZzPnMm95ZdbicXC
         EQ9l9sDnY3b90mXexRxPB9lKuEAGcbZGmiI8Hq2c3Jjs+wrV1jU66ziNteT3yTF9gcUT
         Ze/rWrkac6yZDeK6ohwyJ9HPt+GqevGH/7AjIHbMcLKL1W9u1joSd2oXpSA8x8Z6Q2t8
         GZng==
X-Gm-Message-State: ABy/qLaJDCE1Cuey1zu4NMqR6ubgqmCVcm9VIL38FSG9Ht7nltdRUgj0
        mRCQgt9rb4TrDMhN1i4bWSzO99s9SD0ZK6w5el8=
X-Google-Smtp-Source: APBJJlGxc7HGOnzT6qieeEtV6ahPu4r0HdboWAtc/x8nTAAVKuX50KCo0SnMyTTzXzqahCt8tmPOpg==
X-Received: by 2002:a05:600c:2a54:b0:3fa:934c:8350 with SMTP id x20-20020a05600c2a5400b003fa934c8350mr5150734wme.27.1690991449039;
        Wed, 02 Aug 2023 08:50:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l9-20020a05600012c900b003143801f8d8sm19369842wrx.103.2023.08.02.08.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:50:48 -0700 (PDT)
Message-ID: <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
Date:   Wed, 2 Aug 2023 17:50:48 +0200
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 15:03, Rafael J. Wysocki wrote:

[ ... ]

>>>>> +struct thermal_trip_ref {
>>>>> +     struct thermal_trip *trip;
>>>>> +};
>>>>
>>>> That introduces a circular dependency. That should be avoided.
>>>
>>> Sorry, but this is an empty statement without any substance.
>>
>> I'm just pointing that we have a struct A pointing to struct B and
>> struct B pointing to struct A.
> 
> Why is this a problem in general?

Cyclic dependencies are often a sign of a design problem.

> There are cases in which struct A needs to be found given struct B
> (like in the ACPI thermal case, when the driver needs to get to
> trips[i] from its local data) and there are cases in which struct B
> needs to be found given struct A (like when a driver's callback is
> invoked and passed a trip pointer, so the driver needs to get to its
> local data from it - arguably this is not the case right now, but I
> suppose it will be the case in the future).
>
>> [ ... ]
>>
>>>>>     struct thermal_cooling_device_ops {
>>>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>>>> ===================================================================
>>>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>>>> @@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
>>>>>         if (result)
>>>>>                 goto release_device;
>>>>>
>>>>> +     mutex_lock(&tz->lock);
>>>>> +
>>>>>         for (count = 0; count < num_trips; count++) {
>>>>> -             struct thermal_trip trip;
>>>>> +             int temperature = 0;
>>>>> +
>>>>> +             if (trips) {
>>>>> +                     temperature = trips[count].temperature;
>>>>> +                     if (trips[count].driver_ref)
>>>>> +                             trips[count].driver_ref->trip = &trips[count];
>>>>> +             } else {
>>>>> +                     struct thermal_trip trip;
>>>>
>>>> As mentioned above, that should not appear in the thermal core code.
>>>
>>> Well, this is a matter of opinion to me.  Clearly, I disagree with it.
>>
>> Why? It is not an opinion.
> 
> So what's wrong with it, technically?  What's broken by it?  Why does
> it make the code more difficult to maintain?



>> The thermal core code has been very very tied
>> with the ACPI implementation (which is logical given the history of the
>> changes). All the efforts have been made to cut these frictions and make
>> the thermal core code driver agnostic.
>>
>> The changes put in place a mechanism for the ACPI driver.
> 
> Not really, for all drivers that have local trip data and need to get
> to trips[i] from there and/or the other way around.
> 
>> The thermal zone lock wrapper is put in place for the ACPI driver.
> 
> Yes, it is, because that's the most straightforward way to address the
> use case at hand IMV.
> 
>>> Anyway, I want to be productive, so here's the thing: either something
>>> like this is done, or drivers need to be allowed to walk the trips
>>> table.
>>>
>>> Which one is better?
>>
>> None of them. I think we can find a third solution where the changes are
>> self contained in the ACPI driver. What do you think?
> 
> The ACPI thermal driver needs to update trip point temperatures at
> times.  For this purpose, it needs to get from its local trip data to
> trip[i] somehow.
> 
> Creating a new trips[] array and handing it over to the core is not an
> option, because it potentially breaks the thermal device binding to
> the zone (in which trip indices are used, mind you).
> 
> So how exactly do you want the driver to do the above?
> 
> It could save a pointer to each trips[i] in its local data structures
> before registering the zone, but then if the core reordered the trips,
> those pointers would become stale.
> 
> So how?

Let me check if I can do something on top of your series to move it in 
the ACPI driver.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

