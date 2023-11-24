Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC27F72D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjKXLfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbjKXLfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:35:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A010EC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:35:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a02cc476581so244393266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700825747; x=1701430547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zzTOgsssmSTby31cmMkv2xut8AtsXXDlysL2S5L92c=;
        b=P1hbx9YpGmf8gmNdju1KHDmpnt04QpSZ2DLv5+zQPQRBsXStUT0/L3AmdWP8SckTDj
         hwT8kTNmtag+3G0FL7LDx7zhAZVAWyBxbFPgvhMbPOGqHVFNzWMBUsK1hKOCydtRko3g
         g8jok9EPtdaj3AF0pqLPJTMxtvviwne/YPoqvkHp3kd8QnSqAhDJAHK3HV0hLiTgdFzG
         GdRxw9Xcon2I0/dtBLT/HEKEcp40IbASqyRytqcPklzGZkSeh2KHy4LjXulBFQk6pKSe
         S2m2EI3c0LJ5WeO+H2W+uH8i75QDwmbO4u8v5Qsb1oGacPE1DN0NG0YTw6drxuzO22fA
         xYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825747; x=1701430547;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zzTOgsssmSTby31cmMkv2xut8AtsXXDlysL2S5L92c=;
        b=XXn23oOu5efvpgfSnKnCEe16qAgMwfXeuPDlwSsqZaM31hkeRt3ua4lsbQHr6JVPbT
         zb3oxcI84EPQ4aG5n5iFCgKKbFA2a0klnAgS4mx/AO76fCAtng9xw1SgfIIzFHOrLYLf
         AUJty38yokk5au7TCkv27eIGCKp9sEdsI4NPhwxaCvnZCrPXxNXvAY70b0FCq280JA8/
         L6c4y9s1Udl02x15rbFQ1bvfQ55SLC+Um7e7GzBDvCcNXJ8iulO9cDFOOY16GY+8nTYs
         KqF7fmJxM0qWxiAtdYvgQaL6OhCCsihIvuByaErKgsDoZX2xzk3oVPw8nTFAg78Zb7Kq
         kjiA==
X-Gm-Message-State: AOJu0Yybe2ZUwhwZCetm/RBjDPFGV4EQD6e9DtggMq66lLOZ5/B+IQLe
        dvkKjUUa8HLyP6iKBTAtgC3JTg==
X-Google-Smtp-Source: AGHT+IFjID4A3mtDT0B4pzun4CsbLl7voN49Zz8Xgmxlj017P20tBLM219itd6PeHtBnJIvpyW8+wQ==
X-Received: by 2002:a17:906:389b:b0:a02:1e8d:b94f with SMTP id q27-20020a170906389b00b00a021e8db94fmr1698755ejd.57.1700825746988;
        Fri, 24 Nov 2023 03:35:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906b19800b00992e14af9c3sm1985516ejy.143.2023.11.24.03.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 03:35:46 -0800 (PST)
Message-ID: <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
Date:   Fri, 24 Nov 2023 12:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Content-Language: en-US
To:     "Sayyed, Mubin" <mubin.sayyed@amd.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
 <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
 <DM4PR12MB593888B73B65D25E42490EF29DB1A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <e0f28ec5-b980-490b-a857-5218fe521381@linaro.org>
 <DM4PR12MB5938CB10059DF7E39A2A0E239DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DM4PR12MB5938CB10059DF7E39A2A0E239DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 12:03, Sayyed, Mubin wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, November 15, 2023 5:41 PM
>> To: Sayyed, Mubin <mubin.sayyed@amd.com>
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-pwm@vger.kernel.org; git (AMD-Xilinx)
>> <git@amd.com>; mubin10@gmail.com; krzysztof.kozlowski+dt@linaro.org;
>> u.kleine-koenig@pengutronix.de; thierry.reding@gmail.com;
>> robh+dt@kernel.org; conor+dt@kernel.org; tglx@linutronix.de;
>> daniel.lezcano@linaro.org; Simek, Michal <michal.simek@amd.com>
>> Subject: Re: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
>> TTC device configured as PWM
>>
>> On 15/11/2023 06:55, Sayyed, Mubin wrote:
>>>>> +	/*
>>>>> +	 * If pwm-cells property is present in TTC node,
>>>>> +	 * it would be treated as PWM device.
>>>>> +	 */
>>>>> +	if (of_property_read_bool(timer, "#pwm-cells"))
>>>>> +		return -ENODEV;
>>>>
>>>> You will introduce dmesg errors, so regressions.
>>>>
>>> [Mubin]: I will change it to "return 0" to avoid dmesg errors.
>>
>> No, because solution is wrong.
>>
>>>
>>>> This does not look right. What you want is to bind one device driver
>>>> and choose different functionality based on properties.
>>> [Mubin]:  I am doing it based on earlier discussion related to AXI Timer PWM
>> driver.  It was suggested to use #pwm-cells property for identifying role of
>> device(PWM/clocksource) https://lore.kernel.org/linux-
>> devicetree/20210513021631.GA878860@robh.at.kernel.org/.
>>
>> You are mixing bindings with driver. I said here about driver and yes - you must
>> use pwm-cells to differentiate that. It's obvious.
>>
>> So again, one driver binding.
> [Mubin]: I will explore whether mfd framework can be used to handle this.

You do not need MFD for this, because you do not have a really MFD. This
is just one device, so I expect here one driver. Why do you need
multiple drivers (which also would solve that problem but why?)?

Best regards,
Krzysztof

