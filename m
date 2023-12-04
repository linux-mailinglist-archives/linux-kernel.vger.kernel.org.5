Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B640804112
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjLDVoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjLDVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:44:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4487CBB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:44:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40838915cecso50820295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 13:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701726260; x=1702331060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/w7gPHBXMUYQxVBMSHxKa0iPfJI5g4576m+rQXIaxU=;
        b=eb4RTXfBW1an/e8yMemL/ZcqN+819U5zfNQ2NEgqY8AkHye+vOThFh+BGzwkC/42uC
         0Zmir7SXyeUJGiGJr4v9oKgmRLvEeN7gzHv8XifRAx9bhkHJaVpMMOjL1KWaTph1s02B
         G5VWasdh+61OrBC7rhF4VQmw14lelG8kzkcdyq7I1iZLUnjY8gNeDTTw4dS4my6KHw5l
         r8UQILmnmtPwwlbZ+j3IvSinQiWQXYP/PtovOMOh6tRibI3kqNp5MPfRxBwrjwkB1UbF
         C6A6m8MSIYGEifIfCLpC6e46m1nDCwPPf/YFbtUUihlhNhF9yA41Jo5uZcJCV7mZker9
         FIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701726260; x=1702331060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/w7gPHBXMUYQxVBMSHxKa0iPfJI5g4576m+rQXIaxU=;
        b=raaaNS2Tj3ah4A6GA4hi8kAdY4VcUbXNRJ1d8OEWGipgb57reUfdZ1HXggjmSs3BXz
         vhAwV/gFPG3/i2zaYBO6ZLIV1a4R+htb0Dj0/ewMRn6uVhV442SloAbFnXzrB69Moc5R
         c+Ngxh6MJC5pcJevsG+jr1v483AkxyCKlaZOVim0ufjeF3eamZwcFZJ1olJIzz2ZGb5+
         G1cB1PAUNgihAA30Yt9VzR5jwP+loUAV3mZVuQtPz6Zlo4aebDOSRLyTDSNhKvLd9mUm
         keZRBRJ2lkdf9WA0Le5VPj8SNduIEjPawyNj7a5p9uILhNH9UK1bxgKW5D2YIZUowa7I
         V5mA==
X-Gm-Message-State: AOJu0Yy8SSmkXCzumOjCtp1oYkKl8qokD58D1wKRwpHwAWSxadb4/TF5
        c8L/Xl/5wRjG44R61dd8YGjEtz2yASbRLMaihBo=
X-Google-Smtp-Source: AGHT+IEKr3w66+dxKPkpHMPBpU2XEHlRVOKP7Q2Cl6Hg4TXp/LQ1y5siBHOrozkPoICJuy1apjRKwg==
X-Received: by 2002:a05:600c:46c7:b0:40b:5e21:e26c with SMTP id q7-20020a05600c46c700b0040b5e21e26cmr2816769wmo.89.1701726259620;
        Mon, 04 Dec 2023 13:44:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:bbf5:3c34:edc0:c796? ([2a05:6e02:1041:c10:bbf5:3c34:edc0:c796])
        by smtp.googlemail.com with ESMTPSA id s8-20020a05600c45c800b00405c7591b09sm16579322wmo.35.2023.12.04.13.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 13:44:19 -0800 (PST)
Message-ID: <9750e644-8939-4ea2-a2fb-d2c7d7fbb264@linaro.org>
Date:   Mon, 4 Dec 2023 22:44:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal: sysfs: Rework the handling of trip point
 updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <12338384.O9o76ZdvQC@kreacher> <4883151.31r3eYUQgx@kreacher>
 <b3c86caf-635d-416b-af98-9e26f2a68948@linaro.org>
 <CAJZ5v0hEo_HPMR=wVsHDTjPrEBLXgBHwom491rEiLJfapg6Rhg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hEo_HPMR=wVsHDTjPrEBLXgBHwom491rEiLJfapg6Rhg@mail.gmail.com>
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

On 04/12/2023 18:47, Rafael J. Wysocki wrote:

[ ... ]

>>> +static int check_thermal_zone_and_trip_id(struct device *dev,
>>> +                                       struct thermal_zone_device *tz,
>>> +                                       int trip_id)
>>> +{
>>> +     if (!device_is_registered(dev))
>>> +             return -ENODEV;
>>> +
>>> +     if (trip_id < 0 || trip_id >= tz->num_trips)
>>> +             return -EINVAL;
>>
>> I'm not sure if this check is useful. The function is called from
>> trip_point_*_store() which is providing the trip id from the file name
>> parsing which is in turn built from an existing trip id. There is no
>> reason the trip id is going to be wrong.
> 
> I can drop the check just fine.
> 
> Do you have any other comments on this patch?

No, the rest LGTM


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

