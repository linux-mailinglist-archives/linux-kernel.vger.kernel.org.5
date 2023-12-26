Return-Path: <linux-kernel+bounces-11440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11081E666
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC0EB21D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3EF4D11A;
	Tue, 26 Dec 2023 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ki8jdkjH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0E4CE1F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2356bb40e3so358140666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703582892; x=1704187692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guAVeD3Hak4vfCKKwioe7579n4+j6Wz5Tsd/laBd5QY=;
        b=ki8jdkjHYxGPDu7g07I7mlMKbV9zVpGlowdEveZRxMqMH26sE+mGQdFivpt2o3+OJv
         g7owFFnqCDWWp9B4XNRb0nIEBoQJDxwfRYIGSGbugIwq7jTv+zzxllnx0sYg0MvA6UyA
         cFAe/D1F8/Idfbrww5L3oIJnx3HVJUvOAni9frtCpqN7Ql5dlUGl5xnddWkCQ0rR2JkN
         4uZwn7t9M27cqTiwS5QFNVqX3j0gSyxeuFHq4zZBsEhgHTS2tkCf9vxwzwt2VK/rfWtV
         7NSw+i2aEP0+xoE9NWinGtRW04SSaAmO/6ns0XxNcxzgt3hBGdlSSEYGdDHBlh39aIn1
         UHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703582892; x=1704187692;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guAVeD3Hak4vfCKKwioe7579n4+j6Wz5Tsd/laBd5QY=;
        b=KwC4RRZ6kR34t+mQ+S3dJ3VvVl8CbEH3q7L2l6P3J3jCJfx6dO5PSCGUSOh2H525GT
         OatbFS1zjEiHzAWDU1HfKdVYs6KGW/kRVoHkjGUtXamjK/o9tyYqvcg1vkA++kygOBcX
         1zA9r3P7sO48rkfaZ93dfVopRlIZGnzTrjRRizJvvA3Yqfsin3qvsvZyBkFCqsap8kep
         e8U+uEPAXs7luPi4TxfIYGzAKCT4pnBTtp/Ih5bXGKwvsPaRJr6nNHUWZ/TaT2RlI4nT
         L+eOfj4T6XltiQDqw9P9RImK1yIxQnwH26iCwR7T9M6wcXF2K09ZeUWLKWve5WzTpB4y
         ItmA==
X-Gm-Message-State: AOJu0YynV8dCDZ15tLVZBdAt7Uiij1IWxeBpv2HgrNw6A32RC4Co6y9H
	HFzKDUtO3FiBFdKVfux9rtdbnFVxSSRZXQ==
X-Google-Smtp-Source: AGHT+IETyCo7bY8dXFHo68ivE9hByYhBb8a99Pa2mkt2ICjxwpdCJ4CJZvXY273teIFxQu6m5CV3/g==
X-Received: by 2002:a17:906:7fc6:b0:a23:5bfc:edf6 with SMTP id r6-20020a1709067fc600b00a235bfcedf6mr3235465ejs.73.1703582892028;
        Tue, 26 Dec 2023 01:28:12 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id zr16-20020a170907711000b00a26af4d96c6sm4636929ejb.4.2023.12.26.01.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:28:11 -0800 (PST)
Message-ID: <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
Date: Tue, 26 Dec 2023 10:28:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 08:25, Jie Luo wrote:
>>> -    description:
>>> -      the first Address and length of the register set for the MDIO controller.
>>> -      the second Address and length of the register for ethernet LDO, this second
>>> -      address range is only required by the platform IPQ50xx.
>>> +    maxItems: 5
>>> +    description: |
>>> +      The first address and length of the register set for the MDIO controller,
>>> +      the optional second address and length of the register is for CMN block,
>>> +      the optional third, fourth and fifth address and length of the register
>>> +      for Ethernet LDO, the optional Ethernet LDO address range is required by
>>
>> Wait, required? You said in in response to Rob these are not required!
> 
> As for the response to Rob, i was saying the uniphy ahb and sys clocks
> are not needed on ipq9574.
> The LDO are needed on ipq5332 and ipq5018 currently.

Clocks as well but:

"A driver can function without knowing about all these new registers and
..."

Anyway, this should be list ("items:") with descriptions, instead of one
big description listing things.


> 
>>
>>> +      the platform IPQ50xx/IPQ5332.
>>
>> So these are valid for all platforms or not? Looks not, but nothing
>> narrows the list for other boards.
> 
> i add the limitation on the reg usage for the ipq5332 platform on the
> following part "if condition" of this patch, i will update the patch
> to narrow down for the other compatibles.
> 
>>
>> Anyway, why do you add entries in the middle? LDO was the second, so it
>> cannot be now fifth.
> 
> As Rob's suggestion, i move the cmn_blk to second location for
> simplifying the limitation description, i checked the upstream dts code,
> the LDO is not used currently, so we can move cmn_blk to the second
> location here.

I cannot find his suggestion in the previous thread. Where did he
propose it?

...

>>> +  qcom,cmn-ref-clock-frequency:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum:
>>> +      - 25000000
>>> +      - 31250000
>>> +      - 40000000
>>> +      - 48000000
>>> +      - 50000000
>>> +      - 96000000
>>> +    default: 48000000
>>> +    description: |
>>> +      The reference clock source of CMN PLL block is selectable, the
>>> +      reference clock source can be from wifi module or the external
>>> +      xtal, the reference clock frequency 48MHZ can be from internal
>>> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
>>> +      if the 48MHZ is specified, which means the external 48Mhz is used.
>>
>> This does not resolve mine and Conor's concerns from previous version.
>> External clocks are defined as clock inputs.
> 
> No matter the external or internal reference clock, they are the clock
> source selection for CMN, there are only 48MHZ can be external or 
> internal, other clocks have the different clock rate, so the internal
> 48MHZ reference clock can be implied when the 
> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by 
> Conor in the previous
> comments.

I don't think he proposed it, but maybe I missed some message (care to
point me to his message where he agreed on usage of
qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
same page, that the presence of clocks defines choice of internal clock.
This property should go away.

It is tiring to keep discussing this.

> 
>>
>>> +
>>> +  clock-frequency:
>>> +    enum:
>>> +      - 390625
>>> +      - 781250
>>> +      - 1562500
>>> +      - 3125000
>>> +      - 6250000
>>> +      - 12500000
>>> +    default: 390625
>>> +    description: |
>>> +      The MDIO bus clock that must be output by the MDIO bus hardware,
>>> +      only the listed frequencies above can be supported, other frequency
>>> +      will cause malfunction. If absent, the default hardware value 0xff
>>> +      is used, which means the default MDIO clock frequency 390625HZ, The
>>> +      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
>>> +      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
>>> +      register, there is higher clock frequency requirement on the normal
>>> +      working case where the MDIO slave devices support high clock frequency.
>>>   
>>>   required:
>>>     - compatible
>>> @@ -59,8 +118,10 @@ allOf:
>>>             contains:
>>>               enum:
>>>                 - qcom,ipq5018-mdio
>>> +              - qcom,ipq5332-mdio
>>>                 - qcom,ipq6018-mdio
>>>                 - qcom,ipq8074-mdio
>>> +              - qcom,ipq9574-mdio
>>>       then:
>>>         required:
>>>           - clocks
>>> @@ -70,6 +131,20 @@ allOf:
>>>           clocks: false
>>>           clock-names: false
>>>   
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,ipq5332-mdio
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 5
>>> +          maxItems: 5
>>> +        reg-names:
>>> +          minItems: 4
>>
>> Why all other variants now have 5 clocks and 5 reg entries? Nothing of
>> it is explained in the commit msg.
> 
>  From the condition above, only "qcom,ipq5332-mdio" has 5 clocks (mdio +
> 4 uniphy clocks) and 4 regs (mdio + cmn_blk + 2 LDOs) as the cmn_blk is
> moved to the second location.
> 
> how it can gives the 5 clocks and 5 regs for other variants here?

How? Just read the beginning of your patch. It clearly says everyone has
up to 5 reg entries and up to 5 clocks.



Best regards,
Krzysztof


