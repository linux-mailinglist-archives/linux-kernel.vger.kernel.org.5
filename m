Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBC81290C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443297AbjLNHYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjLNHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:24:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C337B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:24:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-336447f240cso499790f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702538693; x=1703143493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FC44dyY+Ke7P64YuM+T2OSFN4w0vxiPwWw2ccDn9I8w=;
        b=wyypiCbFPAxb2b3/HaXe6PBHQrvxiqLwGTEhicOIdOO8XzceLRC80aD2CBf+m5S24b
         ULadti9AVW9jM1u4hMJg2Q1fX2h+eS31IpYecTqmPuaaVGJTi8DdgOLJfEB5BCIEx1fb
         wuYEDBavbeTE3buvAgfk1sWr4XyEhpEM0BVcufmwPRwkM7l+i546YIvwMOCO/7y6lo0H
         8EZ6O27dyK1I/CG2htlDFlDYNN8sliK38q+DaVU4GNs7txu/llO1s+05zUUcp4lDFJWS
         lgucqSr8RMzUHpiLCFA5wBn8Zo+Ccce7RJvFe5ulFGll4gDFITydIijZ85B/iTtzPOxp
         TC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702538693; x=1703143493;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FC44dyY+Ke7P64YuM+T2OSFN4w0vxiPwWw2ccDn9I8w=;
        b=b2eWqG/Uba/O8AZaJmXBh/ywraCV0ztI1iXvKURuGlIXvRiQYD9ULdoHYUcesHEtbF
         Yv29TEd7bmy/GFN78HPvuY/ZTLVPlo/rXtYwu6oEtwFMDMU8f3AyQSpAFsdrb/WoSjRo
         F5R+kwejw9/7V0grvJ4l8NbkmgS3OvF3bPpRE0Yc2Mq64RQF/1g6qOVAFHQIR8rNoJ2O
         BJek7A8zq8aAc3vgmIQi+o0UXBFqnFM7D3wtdLyZk/xfn2HtHVepAc6dqrtwZosj7QnX
         993ABlmXyxbjYZ5EMkJueMm0+ZyNWkNUZuhf3yFogxJlhfpc63kC3457jF8jkn+XYa+d
         OJEg==
X-Gm-Message-State: AOJu0Yy8IL3mjNYP+DNvH2HeT7LH3+683Y5MPKWDah4UYNIJ6Lp3G6WV
        9az7iQqoEVI/p1/aylkDjFPsJg==
X-Google-Smtp-Source: AGHT+IGgsAWOi7nOEHooTXtSn6LU9x1VKfeRhROduW89OIjETqH4Px6J/6kDubirw4d/QCNMU3tu9w==
X-Received: by 2002:a05:600c:4507:b0:40c:2b2b:6429 with SMTP id t7-20020a05600c450700b0040c2b2b6429mr4612221wmo.67.1702538693326;
        Wed, 13 Dec 2023 23:24:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b0040c44b4a282sm15575290wmq.43.2023.12.13.23.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 23:24:52 -0800 (PST)
Message-ID: <1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org>
Date:   Thu, 14 Dec 2023 08:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
Content-Language: en-US
To:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-9-ninad@linux.ibm.com>
 <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
 <44abff4a-0a8e-499b-8b98-a4a1680cb431@linux.ibm.com>
 <427fa99c-764c-4d6a-b9f1-cd9089710d5e@linaro.org>
 <edcdcea2-febc-4859-9ccf-b8c59b794f01@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <edcdcea2-febc-4859-9ccf-b8c59b794f01@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/12/2023 20:49, Ninad Palsule wrote:
> Hello Krzysztof,
> 
> On 12/13/23 13:37, Krzysztof Kozlowski wrote:
>> On 13/12/2023 20:02, Ninad Palsule wrote:
>>> Hello Krzysztof,
>>>
>>> On 12/12/23 14:26, Krzysztof Kozlowski wrote:
>>>> On 12/12/2023 17:40, Ninad Palsule wrote:
>>>>> This drop adds following devices in the device tree.
>>>>> - EEPROM/VPD
>>>>> - Power supplies
>>>>> - Humidity, pressure and temperature sensors.
>>>>> - Trusted platform module(TPM) chip
>>>>>
>>>>> Tested:
>>>>>       This board is tested using the simics simulator.
>>>>>
>>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>>> ---
>>>> Don't mix DTS with drivers. DTS and drivers go via different subsystems
>>>> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
>>>> now again DTS #7?
>>> There is a dependency on driver code as patch #8 uses the compatibility
>>> string added in driver patch #7.  I have now moved driver patch at the
>>> start. Is that ok? OR you are suggesting something else?
>> First, there is no dependency. Second, except confusing order anyway DTS
>> will go via separate trees. Third, again, there is no dependency. If
>> there is, your patchset is broken and this needs to be fixed. Although I
>> don't understand how new hardware can depend on driver... it's really odd.
> 
> Thanks for the quick response.
> 
> This board uses the nuvoton TPM device. The tpm devices uses 
> "nuvoton,npct75x" driver hence we added it in the device tree. If the 
> driver doesn't have this compatibility string then it won't load. So if 
> someone tries to use this board then tpm won't work unless the 

... and if there is no board it also fails to load.

> compatibility string is added in the driver. That is the dependency I am 
> talking about.

This is not a dependency! It's unrelated.

Best regards,
Krzysztof

