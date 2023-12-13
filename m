Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9F8115D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442253AbjLMPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442248AbjLMPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:10:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006BE4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:10:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso41771095e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702480210; x=1703085010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHHcP0mvob7dWrAUb/sVrRhb6E/UySo4RMlr/cYVhDo=;
        b=QGd4MR4MqLufaFSyzJYw/nbGoK44lT+9of8oIY/dRdvOIQElNNhlTPCYPImeGgWr8Z
         NL3EgEmWhY0aaCBwlVkolAWccs5zzeKnivAend89guNzJsWdnIwQ3O9PjRzO1VAM7soH
         /tDF56Iw9TiEtVjWxkSuOjb3ufbuTnb58WkXCJK3249HhxfyedfilKUkQJboXGN1F+5n
         jhKqbQe52pLS4k+om25tMnwr4JIzUud42XDqNGbL62qiYSKeeyctTXJDRuqRoVeSrVSX
         77AJuiqnBUdJZLXSx8irVg9t/h+u7TW16kYaiNxBLH97zDxh8z+InSrN9YjZFNsnfM+E
         IDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480210; x=1703085010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHHcP0mvob7dWrAUb/sVrRhb6E/UySo4RMlr/cYVhDo=;
        b=i0EtT8vuSgo/Pf+bEpo81ivTL2YpMmGgyFyiuCMsEPCRc/X/T/vAeC79qTZoYnphtt
         A56vj/8i8U/7ayZfc/xmo4pQ0hKiV4FaiDKN/LRA4Ru6Y2v64PyVLlqRT2TRV/KkSR8H
         ZVllWknR0YaWjJ2njytUpikj8PV8BlQzZ0XxojstlSqyT2gYnD0Pna/zYFDTNJG4ZtDM
         bOGPVOdCHUj6qPZN9y3kKj0viVGvbjrUVsar3JE23zwPz2QGy43YQDiB/gMo4xfbE5TE
         ABygd8+b/SlLptJS5Qku9wnJ2kVll1+uE17JbJpm9E8BsmYzSyV9ROiBWjvI8Hx4q0UC
         NcgA==
X-Gm-Message-State: AOJu0YwpmcN/PKYwp709BjtJCe+fhT2Aw8QV+V8ALLjFMrqOWm2xGU2x
        VHZap3c259OPyXJgpEspmyt+7Q==
X-Google-Smtp-Source: AGHT+IEtXRR8cQuuZEPZoPd0fzS80u8vmX0vob9aJBR3725B4/o6sO+zzw3MWxRdcbmLaX09Srkfiw==
X-Received: by 2002:a05:600c:1149:b0:40c:2348:b92 with SMTP id z9-20020a05600c114900b0040c23480b92mr5056955wmz.68.1702480210380;
        Wed, 13 Dec 2023 07:10:10 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm13973091wmb.15.2023.12.13.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 07:10:10 -0800 (PST)
Message-ID: <1788318a-2f65-451e-8d02-4de1bb93df3c@linaro.org>
Date:   Wed, 13 Dec 2023 16:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
 <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
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

On 13/12/2023 15:20, Christian Marangi wrote:
> On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
>> On 12/12/2023 23:13, Christian Marangi wrote:
>>> Add initial support for cold and critical_cold trip point. Many if not
>>> all hwmon and thermal device have normally trip point for hot
>>> temperature and for cold temperature.
>>>
>>> Till now only hot temperature were supported. Add support for also cold
>>> temperature to permit complete definition of cold trip point in DT.
>>>
>>> Thermal driver may use these additional trip point to correctly set
>>> interrupt for cold temperature values and react based on that with
>>> various measure like enabling attached heater, forcing higher voltage
>>> and other specialaized peripherals.
>>>
>>> For hwmon drivers this is needed as currently there is a problem with
>>> setting the full operating range of the device for thermal devices
>>> defined with hwmon. To better describe the problem, the following
>>> example is needed:
>>>
>>> In the scenario of a simple hwmon with an active trip point declared
>>> and a cooling device attached, the hwmon subsystem currently set the
>>> min and max trip point based on the single active trip point.
>>> Thermal subsystem parse all the trip points and calculate the lowest and
>>> the highest trip point and calls the .set_trip of hwmon to setup the
>>> trip points.
>>>
>>> The fact that we currently don't have a way to declare the cold/min
>>> temperature values, makes the thermal subsystem to set the low value as
>>> -INT_MAX.
>>> For hwmon drivers that doesn't use clamp_value and actually reject
>>> invalid values for the trip point, this results in the hwmon settings to
>>> be rejected.
>>>
>>> To permit to pass the correct range of trip point, permit to set in DT
>>> also cold and critical_cold trip point.
>>>
>>> Thermal driver may also define .cold and .critical_cold to act on these
>>> trip point tripped and apply the required measure.
>>
>> Agree with the feature but we need to clarify the semantic of the trip
>> points first. What actions do we expect for them in order to have like a
>> mirror reflection of the existing hot trip points.
>>
>> What action do you expect with:
>>
>>   - 'cold' ?
>>
>>   - 'critical_cold' ?
>>
>>
> 
> This is more of a sensible topic but I think it's the thermal driver
> that needs to implement these. As said in the commit description,
> examples are setting higher voltage from the attached regulator,
> enabling some hardware heater.

That is a warming device. In the thermal framework design it is part of 
the mitigation device actors like a cooling device. The driver does not 
have to deal with that.

> Maybe with critical cold bigger measure can be applied. Currently for
> critical trip point we shutdown the system (if the critical ops is not
> declared) but with critical_cold condition I think it won't work... I
> expect a system in -40°C would just lock up/glitch so rebooting in that
> condition won't change a thing...

 From my POV, a critical trip point is for a too hot or too cold trip 
point. The temperature should be set before the system will be 
malfunctioning, so a halt (or reboot if set) should work.

I'm not in favor of adding more callbacks if we can avoid them. Passing 
the trip point to the critical callback makes more sense to me.

> Anyway yes we can define a shutdown by default for that but IMHO it
> wouldn't make much sense.

Why? If the device is about to go to out of the functioning range, then 
it makes sense to shut it down. IIRC, electric signals lose their 
stability below the lower bound temperature.

There is the point about the mitigation to stay above a certain 
temperature. If the devices do not have any kind a 'warming' device, 
then an alternative would be to have a generic warming device mirroring 
the cooling device with a duty cycles at different performance states. 
With this case, we may need another trip point type for a governor which 
should handle that.

So we end up with the question: shall we add trip point types or trip 
point properties?

1. Trip point types

  - active / passive : mitigate
  - hot : notify userspace
  - critical : halt by default
  - cold : do something
  - cold_crit : do something else with a callback

2. Trip point types + property

  - active / passive : mitigate
    - hot : cool down
    - cold : warm up

  - hot : notify userspace
  - cold : notify userspace

  - critical:
   - hot : shutdown (or callback + trip)
   - cold : shutdown (or callback + trip)

That implies there are two models:

1. We assume cold / hot trip points are symmetric features of the 
thermal management. So we do mitigation using governors, if that 
mitigation fails then we end up with critical actions. A consistent 
behavior between temperature increase or decrease. From my POV, I prefer 
this approach because it reflects nicely the functioning range temperature.

2. We handle the cold situation differently by doing a on/off action on 
a specific device. That is an asymmetric approach.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

