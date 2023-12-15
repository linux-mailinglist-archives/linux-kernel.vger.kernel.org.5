Return-Path: <linux-kernel+bounces-630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F58143D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27976B22494
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C8018654;
	Fri, 15 Dec 2023 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgfahVL3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86118039
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so392205e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702629595; x=1703234395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UD+PsiouIGjnHw+qN+1OZcdDEWTILWyx3Ef0CxvyJaI=;
        b=WgfahVL3vMJo0OaWKtdtD5du/e21olnLq2L+wwaD3Bu2f689B3hiIKSPodX9kAxJEp
         EzqG5WWXT64RcenDgV3nhAPwb+gsDUJXiXEm3cCx3ZOYytdKhHETBKUsyuUw6N0s7GtF
         FfnRf2X2g01cyF3H7Y0loEoiwcbgNuQ7yD183XryYUJOT/PHpjSZ82vq/ZbvkyAXYK28
         0tjsmtI4KWJD3M/+VO7s1CAzG/O+q7y4ou/0ATWZgU9FB3rEzy2aUZydN+IX/FLRhj2A
         zdfvq+6/7HNj9rbwIBf1eetufWuS/2KxJ7Y1HT8PHdGlyAws4JLNudMYg86JwUwYQ9Wy
         j8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702629595; x=1703234395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD+PsiouIGjnHw+qN+1OZcdDEWTILWyx3Ef0CxvyJaI=;
        b=hqwI47UJEQReslTzeHc1DSBRzloBKj8JfS5fqDoG2hRYr1LcLsr72uavYhgVVK08s5
         s4gDrf0atSleQUnhsvmnKVmfHgw5J7JCkR3AmECYlRcBsp4eSQyNkK4XYtVaTtUD+DMT
         Y7RSCFEyfGeEUB76tpm9vhBNyXmbjqx4a/sVX5iG6mPltABBaNMRzzIdrBc3wmwUKZwP
         QuJDIxPTxywToeixhdrF6aC6QB59F4ZURGMTbVonFCXIF/8DUd8MN8cjSPkP/xqHJx46
         4mIViwxSJiyUlEtMCCApD+/sq0bsF9+RicKQm5sI/A4cyjhRT0M6scHtyMRe/STwPZ2X
         CwYw==
X-Gm-Message-State: AOJu0YwxbopVb9mL1CRnMxLGPAWV3ZGPDvYbgLVX78H3BvUDxCy5jyvy
	e3GgMsSTBrpcuScLoEzYK+144g==
X-Google-Smtp-Source: AGHT+IGZN9eh1H7VUq+iWRymK7eL4uSs3y4FVHoORS2jf2PpsmkKm2hg5g96DD1Dqyp4BOJRJ1gjiA==
X-Received: by 2002:a05:6512:ac3:b0:50b:fe80:7858 with SMTP id n3-20020a0565120ac300b0050bfe807858mr3410200lfu.148.1702629595350;
        Fri, 15 Dec 2023 00:39:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm10520851ejc.71.2023.12.15.00.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 00:39:54 -0800 (PST)
Message-ID: <b89abf8c-57f8-46a6-a071-b1591340fbdf@linaro.org>
Date: Fri, 15 Dec 2023 09:39:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
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
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
 <20231214090304.16884-6-quic_luoj@quicinc.com>
 <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
 <3c8e33b4-6ebc-476f-a00f-15cc8a1ad9e4@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3c8e33b4-6ebc-476f-a00f-15cc8a1ad9e4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 09:28, Jie Luo wrote:
> 
> 
> On 12/15/2023 3:27 PM, Krzysztof Kozlowski wrote:
>> On 14/12/2023 10:03, Luo Jie wrote:
>>> Update the yaml file for the new DTS properties.
>>>
>>> 1. cmn-reference-clock for the CMN PLL source clock select.
>>> 2. clock-frequency for MDIO clock frequency config.
>>> 3. add uniphy AHB & SYS GCC clocks.
>>> 4. add reset-gpios for MDIO bus level reset.
>>>
>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>> ---
>>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 143 +++++++++++++++++-
>>>   1 file changed, 139 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>> index 3407e909e8a7..79f8513739e7 100644
>>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>> @@ -20,6 +20,8 @@ properties:
>>>             - enum:
>>>                 - qcom,ipq6018-mdio
>>>                 - qcom,ipq8074-mdio
>>> +              - qcom,ipq9574-mdio
>>> +              - qcom,ipq5332-mdio

Why do you add entries to the end of the list? In reversed order?

>>>             - const: qcom,ipq4019-mdio
>>>   
>>>     "#address-cells":
>>> @@ -30,19 +32,77 @@ properties:
>>>   
>>>     reg:
>>>       minItems: 1
>>> -    maxItems: 2
>>> +    maxItems: 5
>>>       description:
>>> -      the first Address and length of the register set for the MDIO controller.
>>> -      the second Address and length of the register for ethernet LDO, this second
>>> -      address range is only required by the platform IPQ50xx.
>>> +      the first Address and length of the register set for the MDIO controller,
>>> +      the optional second, third and fourth address and length of the register
>>> +      for ethernet LDO, these three address range are required by the platform
>>> +      IPQ50xx/IPQ5332, the last address and length is for the CMN clock to
>>> +      select the reference clock.
>>> +
>>> +  reg-names:
>>> +    minItems: 1
>>> +    maxItems: 5
>>>   
>>>     clocks:
>>> +    minItems: 1
>>>       items:
>>>         - description: MDIO clock source frequency fixed to 100MHZ
>>> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
>>> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
>>> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>>> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>>>   
>>>     clock-names:
>>> +    minItems: 1
>>>       items:
>>>         - const: gcc_mdio_ahb_clk
>>> +      - const: uniphy0_ahb
>>> +      - const: uniphy1_ahb
>>> +      - const: uniphy0_sys
>>> +      - const: uniphy1_sys
>>> +
>>> +  cmn-reference-clock:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Nothing improved here
> 
> With this change, the warning is not reported when i run
> dt_binding_check, looks the new added property needs
> the type ref to avoid the warning reported.

Nothing improved in the property name, nor its style, nor in the actual
contents/values.

...

>>> +  reset-gpios:
>>> +    maxItems: 1
>>> +
>>> +  reset-assert-us:
>>> +    maxItems: 1
>>
>> This does not look related to ipq5332.
> 
> The reset gpio properties are needed on ipq5332, since qca8084 phy is
> connected, which uses the MDIO bus level gpio reset.

I am talking about this property, not these properties.

> 
> Without declaring these gpio properties, the warning will be reported
> by dt_binding_check.

How is it even possible to have warnings if there is no such node in
DTS? We do not care about warnings in your downstream code.


Best regards,
Krzysztof


