Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD6811883
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442400AbjLMQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442349AbjLMQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:00:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0873B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:00:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-336417c565eso510750f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702483227; x=1703088027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wQgJVXTbrMMfThGWjtIRWTD7vVL6atDUhY4Ep1StLs=;
        b=XJBsjoyztyuO8UoyE9qdylknvKliNODQgRo87KgJkZ/DgKz5qJsdV2cQLiH0406bq7
         yAQ2bU39xsajKqu7Vj3FicLci9l+gepYKMBsEa+B4dykczWEOMPO5KSFbNOa0NNmNSBD
         ERVxKJ7px9RS0HjkiMMW906EpHvbf8+0ifNwY6bECGxonz5+b2tp65jCWdhCSfG+OLnL
         2zFFAu6/6VyiF1iyDSu5UeWwg2d9YsOpB4r4BgsgluwgdWs7vOtD7iGSo+phoOQwBOJr
         bzSQUmUOfsm8uoDsB2hgIekTPBfcG3CxtzN/sZLGMyZCR2LQ6U7lfB9EwJLivXXhGDL6
         oYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483227; x=1703088027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wQgJVXTbrMMfThGWjtIRWTD7vVL6atDUhY4Ep1StLs=;
        b=Y0wSQNjG0ppqdqwttP98lbx5uaUnS2w5CcoJAw5ABmUMIbMGUUXbYOcXaF16CVo7sK
         7H6ds+Cy+/G874YAz+qnb+n/+ee88pBgy7Xuib5Tg35vV1T5sCY0xkXhugaINmkFr2F2
         wf3nI3Bn8ZUzNpy7qZWcgjazXCOfRX/4gl1qa2b0w0Usvs4e9JHhELd8aj1ffdf0x/xH
         5fF3VC5IaO+0ql/qhZ86nAvQRVIxh1e3VtshaLC1bSxN7KBr6lW6O+eS03kADBnQNX0G
         CqexLVyk4HMJ/GQZujj9hM8C6BEs3wZblONywZHWsMOs9I+THKtXogDjsxRgdvxYhXf9
         Evbg==
X-Gm-Message-State: AOJu0YzDks3WMqIqILV0bnfVhRpE8JMBgILDhtxykIa9wq3Zsbcss8AC
        pyv/+/Q0gHxUtv0Kb4BkZJ+IRA==
X-Google-Smtp-Source: AGHT+IHbdOR4+AKZ8GxKN19778YZkvtVfp1xfJFhP4NykzxaNPbc/ujq9Iouol0pUbKfYOOqdCI9PA==
X-Received: by 2002:a05:6000:90c:b0:334:b174:9a14 with SMTP id cw12-20020a056000090c00b00334b1749a14mr2721396wrb.50.1702483227055;
        Wed, 13 Dec 2023 08:00:27 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d4c4a000000b003333abf3edfsm13647343wrt.47.2023.12.13.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:00:26 -0800 (PST)
Message-ID: <327458e6-de96-460f-8ec6-a1c31fcf6b5e@linaro.org>
Date:   Wed, 13 Dec 2023 17:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
 <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
 <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
 <6579c604.050a0220.8fe5c.d191@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6579c604.050a0220.8fe5c.d191@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 15:56, Christian Marangi wrote:
> On Wed, Dec 13, 2023 at 03:43:54PM +0100, Rafael J. Wysocki wrote:
>> On Wed, Dec 13, 2023 at 3:20 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
>>>
>>> On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
>>>> On 12/12/2023 23:13, Christian Marangi wrote:
>>>>> Add initial support for cold and critical_cold trip point. Many if not
>>>>> all hwmon and thermal device have normally trip point for hot
>>>>> temperature and for cold temperature.
>>>>>
>>>>> Till now only hot temperature were supported. Add support for also cold
>>>>> temperature to permit complete definition of cold trip point in DT.
>>>>>
>>>>> Thermal driver may use these additional trip point to correctly set
>>>>> interrupt for cold temperature values and react based on that with
>>>>> various measure like enabling attached heater, forcing higher voltage
>>>>> and other specialaized peripherals.
>>>>>
>>>>> For hwmon drivers this is needed as currently there is a problem with
>>>>> setting the full operating range of the device for thermal devices
>>>>> defined with hwmon. To better describe the problem, the following
>>>>> example is needed:
>>>>>
>>>>> In the scenario of a simple hwmon with an active trip point declared
>>>>> and a cooling device attached, the hwmon subsystem currently set the
>>>>> min and max trip point based on the single active trip point.
>>>>> Thermal subsystem parse all the trip points and calculate the lowest and
>>>>> the highest trip point and calls the .set_trip of hwmon to setup the
>>>>> trip points.
>>>>>
>>>>> The fact that we currently don't have a way to declare the cold/min
>>>>> temperature values, makes the thermal subsystem to set the low value as
>>>>> -INT_MAX.
>>>>> For hwmon drivers that doesn't use clamp_value and actually reject
>>>>> invalid values for the trip point, this results in the hwmon settings to
>>>>> be rejected.
>>>>>
>>>>> To permit to pass the correct range of trip point, permit to set in DT
>>>>> also cold and critical_cold trip point.
>>>>>
>>>>> Thermal driver may also define .cold and .critical_cold to act on these
>>>>> trip point tripped and apply the required measure.
>>>>
>>>> Agree with the feature but we need to clarify the semantic of the trip
>>>> points first. What actions do we expect for them in order to have like a
>>>> mirror reflection of the existing hot trip points.
>>>>
>>>> What action do you expect with:
>>>>
>>>>   - 'cold' ?
>>>>
>>>>   - 'critical_cold' ?
>>>>
>>>>
>>>
>>> This is more of a sensible topic but I think it's the thermal driver
>>> that needs to implement these. As said in the commit description,
>>> examples are setting higher voltage from the attached regulator,
>>> enabling some hardware heater.
>>
>> So how is it different from an active trip point?  There are heating
>> rather than cooling devices associated with it, but other than this??
>>
> 
>  From what I read from documentation, active trip point are used to
> trigger cooling-device. Cold (and crit_cold) are to setup trip point to
> the device. The device will normally trigger an interrupt (or even
> internally with the correct register set autonomously apply some measure
> to handle the problem)

Actually what specifies an active cooling device is it requires energy 
in order to operate. More precisely, the goal of an active cooling 
device is too move the heat from one place to another place. So the 
system, instead of relying on the natural convection thermal transfer, 
will force this transfer. So the "active" means external system + energy.

> In theory it's possible to have passive trip point for cold condition
> but still we lack any definition of the lower spectrum of the trip
> point.

Yes, absolutely :) And that is why I think we should clarify that to 
conform to the general semantic of the thermal management. If we define 
things in the thermal framework but having a different meaning in the 
thermal management vocabulary. That will be really odd and look amateur 
work :)

In the lower spectrum, an external warming device where we use energy to 
provide some heat is active. But if we use some kind of software 
solution (like what suggested before), we indeed use energy, but the 
solution is internal to the system, so I do believe we can consider it 
as passive.

IMO, we should see, especially on mobile, passive trip point for too 
hot, and active trip point for too cold. That would not surprising as 
the former has too much energy generated and the latter not enough energy.

(BTW, as a side note, active or passive trip points do not really make 
sense to me. It is the mitigation devices which are active or passive).

For the systems which do not have a dedicated warming up hardware, we 
should implement a "warming device" as a passive one (which is a 
different story from your proposal I agree).


>>> Maybe with critical cold bigger measure can be applied. Currently for
>>> critical trip point we shutdown the system (if the critical ops is not
>>> declared) but with critical_cold condition I think it won't work... I
>>> expect a system in -40°C would just lock up/glitch so rebooting in that
>>> condition won't change a thing...
>>>
>>> Anyway yes we can define a shutdown by default for that but IMHO it
>>> wouldn't make much sense.
>>
>> So why do you want to add it at all?
> 
> Again it's really to fill a hole we have from a long time... One example
> is the qcom tsens driver that have trip point for cold and crit_cold.
> Those in theory can be set in DT with the trip point but we lack any
> definition for them. (using passive trip point would be confusing IMHO)
> 
> Another example is an Aquantia PHY that have register for the cold and
> critical_cold trip point.
> 
> Currently defining a critical trip point for the negative temp results
> in the system shutdown.

Yes, and the more I think about it, the more I'm inclined to have:

  * trip (active|passive) + hot|cold
  * trip cold (meaning "really too cold")
  * trip hot (meaning "really too hot")
  * trip critical (meaning "I'm about to collapse")

We may have also active devices with multiple level of warm up, so it 
will need to be managed by a governor like the step wise.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

