Return-Path: <linux-kernel+bounces-519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E2814263
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47740283F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430BD52D;
	Fri, 15 Dec 2023 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxSzv4p5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA1D297
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc4e15605aso2310351fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702625364; x=1703230164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRRYTNYuBblRTutX3hwp/bGacQ6sGNdgtV2qh27qS/Y=;
        b=jxSzv4p5eQfYl1GrwiVJEf2QZjJ7WD/qg/UNYodkKCsf8TMmOdll4LDraCz9lR5yuj
         avJPXT1hE557tC3aYLRR6YcF+/ietSsMHZ8+buSXFpSNqtuAgk5ww7iDe/HsjYhp5Muq
         h7Aq5W6uiCWrpUl3tk82GfWMtpzye7EP6uTkBtv+u8m0OGjkUBMlmjOj1D3CIzAoRNZm
         0ZHeTT48xHL0GgVvg8JEpmXfPKADOglgfQlS9gyJsS8RKA1r/5Tib5QX11NXFYKd86f7
         VOaOfjaFWf0Ui6gVfKhQmIZWI06qfPw7BDRzI0S/VS1LLwUh54MYjxm7Fu9cJYlhmUqp
         eh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625364; x=1703230164;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRRYTNYuBblRTutX3hwp/bGacQ6sGNdgtV2qh27qS/Y=;
        b=GOY1aLZ/UZqi4I3462ytz6fEYs2seC74SMlmn1e0CtW+9jeH4C1N9FxuM0yLP+WoAM
         oXmpfzmSoB7+fo7IF8R17SFq8xjCaaJnJ1NmJOVNKMQ22o34UvRGbSWqCQ6oEM4kjJS7
         yc+qO6+cQLxyfut728GRs7KVRSDGWjKJXaz5PML0JTIxbsFp1iDMYSVkCLm9BAP4iRRf
         7ZvTFuAgZo/OA5DgjOdSN5+UmSIrh8MJMNTlRQpcQDuTTydov17ylYan3V8ZZJEyL9JH
         xPzSxMnsV3Qy24aTcQPuLG48XKkVZhR2js/lng6PhEBIi+V+Ixx0nxFjw+93NA1FWjQl
         R9VA==
X-Gm-Message-State: AOJu0YyEHMp+8h5jK+Huu7Kj3DlV6BH2pG/YrldYWkTxMOGYDuS8WCs4
	fx0zTmnFXs5S9F5gw0gEopr5Wg==
X-Google-Smtp-Source: AGHT+IFJVERhuqwoaQ/eJHQyYHXmTBNb+Syj1YvvsJHRjmaVghCCM0SF+cwny+sv+NOEfCV4kfJjwQ==
X-Received: by 2002:a05:651c:199f:b0:2cb:2b69:bb0 with SMTP id bx31-20020a05651c199f00b002cb2b690bb0mr5151052ljb.7.1702625364361;
        Thu, 14 Dec 2023 23:29:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id z18-20020a50cd12000000b00551ee5cd912sm2774172edi.35.2023.12.14.23.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 23:29:23 -0800 (PST)
Message-ID: <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
Date: Fri, 15 Dec 2023 08:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, Conor Dooley <conor@kernel.org>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robert.marko@sartura.hr,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
 <20231214-outshine-shush-8a11c68607cd@spud>
 <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 07:46, Jie Luo wrote:
> 
> 
> On 12/15/2023 1:12 AM, Conor Dooley wrote:
>> On Wed, Dec 13, 2023 at 04:26:56PM +0800, Jie Luo wrote:
>>>
>>>
>>> On 12/13/2023 12:06 AM, Conor Dooley wrote:
>>>> On Tue, Dec 12, 2023 at 07:51:50PM +0800, Luo Jie wrote:
>>>>> Update the yaml file for the new DTS properties.
>>>>>
>>>>> 1. cmn-reference-clock for the CMN PLL source clock select.
>>>>> 2. clock-frequency for MDIO clock frequency config.
>>>>> 3. add uniphy AHB & SYS GCC clocks.
>>>>> 4. add reset-gpios for MDIO bus level reset.
>>>>>
>>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>>>> ---
>>>>>    .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++++++++++-
>>>>>    1 file changed, 153 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>>> index 3407e909e8a7..9546a6ad7841 100644
>>>>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>>> @@ -20,6 +20,8 @@ properties:
>>>>>              - enum:
>>>>>                  - qcom,ipq6018-mdio
>>>>>                  - qcom,ipq8074-mdio
>>>>> +              - qcom,ipq9574-mdio
>>>>> +              - qcom,ipq5332-mdio
>>>>>              - const: qcom,ipq4019-mdio
>>>>>      "#address-cells":
>>>>> @@ -30,19 +32,71 @@ properties:
>>>>>      reg:
>>>>>        minItems: 1
>>>>> -    maxItems: 2
>>>>> +    maxItems: 5
>>>>>        description:
>>>>> -      the first Address and length of the register set for the MDIO controller.
>>>>> -      the second Address and length of the register for ethernet LDO, this second
>>>>> -      address range is only required by the platform IPQ50xx.
>>>>> +      the first Address and length of the register set for the MDIO controller,
>>>>> +      the optional second, third and fourth address and length of the register
>>>>> +      for ethernet LDO, these three address range are required by the platform
>>>>> +      IPQ50xx/IPQ5332/IPQ9574, the last address and length is for the CMN clock
>>>>> +      to select the reference clock.
>>>>> +
>>>>> +  reg-names:
>>>>> +    minItems: 1
>>>>> +    maxItems: 5
>>>>>      clocks:
>>>>> +    minItems: 1
>>>>>        items:
>>>>>          - description: MDIO clock source frequency fixed to 100MHZ
>>>>> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
>>>>> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
>>>>> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>>>>> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>>>>>      clock-names:
>>>>> +    minItems: 1
>>>>>        items:
>>>>>          - const: gcc_mdio_ahb_clk
>>>>> +      - const: gcc_uniphy0_ahb_clk
>>>>> +      - const: gcc_uniphy1_ahb_clk
>>>>> +      - const: gcc_uniphy0_sys_clk
>>>>> +      - const: gcc_uniphy1_sys_clk
>>>>
>>>>> +  cmn-reference-clock:
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - 0   # CMN PLL reference internal 48MHZ
>>>>> +              - 1   # CMN PLL reference external 25MHZ
>>>>> +              - 2   # CMN PLL reference external 31250KHZ
>>>>> +              - 3   # CMN PLL reference external 40MHZ
>>>>> +              - 4   # CMN PLL reference external 48MHZ
>>>>> +              - 5   # CMN PLL reference external 50MHZ
>>>>> +              - 6   # CMN PLL reference internal 96MHZ
>>>>
>>>> Why is this not represented by an element of the clocks property?
>>>
>>> This property is for the reference clock source selection of CMN PLL,
>>> CMN PLL generates the different clock rates for the different Ethernet
>>> blocks, this CMN PLL configuration is not located in the GCC, so the
>>> clock framework can't be used, which is the general hardware register
>>> instead of RCG register for GCC.
>>
>> I don't see how the clock being provided by the "GCC" (whatever that is)
>> or by some other clock controller or fixed clock makes a difference.
>> Why can't the other clock provider be represented in the devicetree?
>>
> 
> cmn-reference-clock is for selecting the reference clock source for the
> whole Ethernet block, which is just the standalone configure register.

Sure, you are aware though that all clocks are just configure registers?

Which clocks are these mentioned in the property? From where do they come?

Anyway, property is in existing form is not correct - this is not a
generic property.


> however the clock provider has the logical register distribution, such
> as for one clock tree, there is RCG, DIVIDER and branch registers in
> the qcom soc chip.
> 
> The clock consumer defines the clock IDs of device tree to reference the
> clocks provided by the clock controller, and these clock IDs are
> provided by the header file of clock provider.
> 
> like this,
> clocks = <&gcc GCC_MDIO_AHB_CLK>, 
> 
>           <&gcc GCC_UNIPHY0_AHB_CLK>, 
> 
>           <&gcc GCC_UNIPHY1_AHB_CLK>, 
> 
>           <&gcc GCC_UNIPHY0_SYS_CLK>, 
> 
>           <&gcc GCC_UNIPHY1_SYS_CLK>;
> 
> gcc is the device node of clock provider, and GCC_MDIO_AHB_CLK is the 
> clock ID.



Best regards,
Krzysztof


