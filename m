Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE47F78D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjKXQYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKXQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:24:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D719A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:24:09 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9e1021dbd28so287444766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700843047; x=1701447847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4Ai1u86sLDHXuJmf3sDrBBCF8Xvj7MvGhsc5FZvOYY=;
        b=ddB19PCG6LTXsDnyKJR9wLlyQ7aQcbWLtW42mWDx12BF8ygi6bTq+lY9Iu79oghKn4
         NHKbLwGTrPHarBbbXWxpBCpid9+ZeUAlGMSqQzD8ysiJSmE8nT/H3UcQlKLKQoMZ33S8
         1ksljaPLLbZm0KDBKeByWtIggIoGyL1nF/oG1az6yuasEPTVZ4yPtGITEQeqZAMTViVF
         pu0kRRwG5ePZqsOstlqAy4hQET6ij59Y8xC9GR3VyB/tbzUUTtARek10bdx1Wv7YFqHH
         i4gYrp9Z3xDAiwiy0lBNzssq9644WvJa+mhZ81047pBUwgKOhzhtPp0ZcSoHv/dTJ+zD
         DGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843047; x=1701447847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4Ai1u86sLDHXuJmf3sDrBBCF8Xvj7MvGhsc5FZvOYY=;
        b=c9v+Mb/VrWXzUGrLxf9QuhUvpI1rI7JRjJUTmN96qep8Z0BXD8GfK3vK7tEf2l014B
         zU/EzM5v61gzQgcoR997eT/PAR+Fhj3ZxCbch/0Dk5xb0TYsaht0qJzBPPSo3vOjxSg4
         0ejQqWy+7SQUhj80Yvlk4q94UktD/9YaaFkeQEav76EoXxU1U93kdZG9DMXa4Rs/MAHX
         cvMO5731hMFhmqmSDPU/gY5+PzSZ6ZqCJn9SqGHuUeh6HjT4ba7B2/irnHsgcGLZHnsK
         Dq62iB6KijfEPNluRAU7FTYzTRfhss/MSibVzpBSXmukp7DP4lxjRsDEG9gqiGpZNDsu
         7F0Q==
X-Gm-Message-State: AOJu0YxKS34jchxv2+Q0bjhXW6ow00tGXlyGWx+UGUTvJVL8IS9P5IJ9
        J6H6onWuMlmo3YhX7jNiIB7sUQ==
X-Google-Smtp-Source: AGHT+IGpUrlqBCDFO/+in9UzwxMOck6elIWNtkLnslhRBLK/Fke0Z04KesDOFXDdUf8z09gcfH2Uuw==
X-Received: by 2002:a17:906:7741:b0:a01:ae9a:d376 with SMTP id o1-20020a170906774100b00a01ae9ad376mr2609002ejn.64.1700843047351;
        Fri, 24 Nov 2023 08:24:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090616d800b009ffb4af0505sm2238854ejd.104.2023.11.24.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:24:06 -0800 (PST)
Message-ID: <9fb984b3-331b-45ce-8f82-03bc476acd3c@linaro.org>
Date:   Fri, 24 Nov 2023 17:24:04 +0100
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
 <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
 <DM4PR12MB5938256CC0E50256004ED6B19DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DM4PR12MB5938256CC0E50256004ED6B19DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 13:07, Sayyed, Mubin wrote:

>>>>>> This does not look right. What you want is to bind one device
>>>>>> driver and choose different functionality based on properties.
>>>>> [Mubin]:  I am doing it based on earlier discussion related to AXI
>>>>> Timer PWM
>>>> driver.  It was suggested to use #pwm-cells property for identifying
>>>> role of
>>>> device(PWM/clocksource) https://lore.kernel.org/linux-
>>>> devicetree/20210513021631.GA878860@robh.at.kernel.org/.
>>>>
>>>> You are mixing bindings with driver. I said here about driver and yes
>>>> - you must use pwm-cells to differentiate that. It's obvious.
>>>>
>>>> So again, one driver binding.
>>> [Mubin]: I will explore whether mfd framework can be used to handle this.
>>
>> You do not need MFD for this, because you do not have a really MFD. This is just
>> one device, so I expect here one driver. Why do you need multiple drivers (which
>> also would solve that problem but why?)?
> Cadence TTC IP can be used as timer(clocksource/clockevent) and PWM device.
> We have drivers/clocksource/timer-cadence-ttc.c for clocksource/clockevent functionality. 
> New driver for PWM functionality will be added to drivers/pwm/pwm-cadence.c (3/3 of this
> Series).  In given SoC,  multiple instances of TTC IP are possible(ZynqMP  Ultrscale SoC has 4
> Instances), few of them could be configured as clocksource/clockevent devices and others
> as PWM ones. So,  cloksource as well as PWM drivers for cadence TTC IP would be enabled in 
> the kernel. 
> 
> Now in this scenario, each TTC device would be matching with 2 drivers, clocksource and PWM, since
> compatible string is same.  If I don’t add #pwm-cells checking in clocksource driver and return 
> -ENODEV based on that, each device would always bind with clocksource driver. PWM driver 
> would never probe since clocksource driver probes ahead of PWM one in probing order.

None of these above explain why you need two drivers.

> 
> I am exploring mfd to deal with said scenario. Do you see any better way to handle this? 

You basically repeated previous sentence about MFD without answering.
Yeah, better way could be to have one driver. Why you cannot have it
that way?


Best regards,
Krzysztof

