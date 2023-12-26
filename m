Return-Path: <linux-kernel+bounces-11441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B281E66B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011FC1F227F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78D4D123;
	Tue, 26 Dec 2023 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lc1MGMGc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A04CDFD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554e4f8610aso1144143a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703583189; x=1704187989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KZXQn9ODEq2Iz6nICwBj41bsX2uZdgILwjZcdz3rdo=;
        b=Lc1MGMGc8cYLNOruArOlfLfpl10uKwMLHPM0lfVaNuLCjNYGxfLW6sXaRCnz/YVdDA
         uaZ/sBAHFo3FIyEPGZP8WdC3tuS/T0Xe3U24RpphEUCEhBSXrprYbAHMPP5NftMQEME7
         H+ZStbE9Gcny8p6klXiQZ5z/Bm777gSEjM59C8FZKmGog1i+onnjrMWeBgoKHEbE90Jj
         59napbmBEapTd31vKDH11E8JUTZoHfg/Q4roVZAsm6/LEBj5HJmQ5U6RCyJ9mF67lY4T
         j18ej3H3dstvCGEQzkGxOIVvMvgPOaIIX75xR0poYaqwdcz/7/6W3eSQLmufcxAIprRc
         3i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703583189; x=1704187989;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KZXQn9ODEq2Iz6nICwBj41bsX2uZdgILwjZcdz3rdo=;
        b=BOm/jPiZtHDhro/K6bTpo96pUseYxvpSHb/ju5LVlMcEMMikL5O4hq9aRNmzc+JuNl
         +azMKmzwCMWP/ui3OJREdZvY8t6lLWn1mQFt+UkPbUuPMmBSPQGb2cUTHkWOpW0cBp4C
         SRhSyUghZj/KDgg7B9knFmqICwUGeq0Wqe8gxSEI5UGsWVOntXN1ct/08hXICGH8tr3p
         0VRtqpLYhAHBE37M3dQnWM2wMgvGa69OOKsWW/378eZ74P2BriD/OSP/jXb8LKolTzd+
         VgEC95iq0TiUUjUhjGHrufTvaF/dMb+8KtmgWtKm74wCaJ0K57M4Qzg83clVKRedE/Y+
         d8jg==
X-Gm-Message-State: AOJu0YyKTJYrVYrYSZLwM9ZdCYmRWdN52qWnsDTyRQ/biIXXnPsKszJ/
	cRu54/vfGNiDE354oC0E3G+8+4fQbBRebA==
X-Google-Smtp-Source: AGHT+IEX+w6RcnhYAn58ymj+DhttkmNbHTaZmlbUYjB9bu1GxzcKegPLW1HCJAWjfu8zmizgHwo/Yg==
X-Received: by 2002:a50:fa96:0:b0:553:7ecc:d51c with SMTP id w22-20020a50fa96000000b005537eccd51cmr4901281edr.72.1703583189415;
        Tue, 26 Dec 2023 01:33:09 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b00553754bd636sm7180779edo.35.2023.12.26.01.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:33:08 -0800 (PST)
Message-ID: <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
Date: Tue, 26 Dec 2023 10:33:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
Content-Language: en-US
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, quic_ppratap@quicinc.com,
 quic_jackp@quicinc.com, Andy Gross <agross@kernel.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
 <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 06:37, Krishna Kurapati PSSNV wrote:
> 
> 
> On 12/25/2023 6:35 PM, Krzysztof Kozlowski wrote:
>> On 22/12/2023 07:36, Krishna Kurapati wrote:
>>> The high speed related interrupts present on QC targets are as follows:
>>>
>>
>>
>>>   
>>>     interrupt-names:
>>> -    minItems: 1
>>> -    maxItems: 4
>>> +    minItems: 2
>>> +    maxItems: 5
>>>   
>>>     qcom,select-utmi-as-pipe-clk:
>>>       description:
>>> @@ -361,60 +378,21 @@ allOf:
>>>           compatible:
>>>             contains:
>>>               enum:
>>> -              - qcom,ipq4019-dwc3
>>
>> Why do you remove it, without adding it somewhere else. Nothing in the
>> commit msg explains it.
>>
> 
> Apologies, Will check and add it back.

Please check your patch for other entries. I just took first compatible
which turns out to be gone. I did not check the reset and I don't want
to keep checking.

...

>>> -    then:
>>> -      properties:
>>> -        interrupts:
>>> -          minItems: 1
>>> -          maxItems: 2
>>> -        interrupt-names:
>>> -          minItems: 1
>>> -          items:
>>> -            - const: hs_phy_irq
>>> -            - const: ss_phy_irq
>>> -
>>> -  - if:
>>> -      properties:
>>> -        compatible:
>>> -          contains:
>>> -            enum:
>>> -              - qcom,sc7280-dwc3
>>> +              - qcom,sm6115-dwc3
>>> +              - qcom,sm6125-dwc3
>>>       then:
>>>         properties:
>>>           interrupts:
>>>             minItems: 3
>>>             maxItems: 4
>>>           interrupt-names:
>>> -          minItems: 3
>>>             items:
>>> +            - const: pwr_event
>>>               - const: hs_phy_irq
>>> -            - const: dp_hs_phy_irq
>>> -            - const: dm_hs_phy_irq
>>> +            - const: qusb2_phy
>>
>> Why qusb2_phy is after hs_phy_irq? In the earlier if:then: it is the
>> second one.
>>
> 
> In v3 as well, the hs_phy_irq is before qusb2_phy interrupt:
> https://lore.kernel.org/all/20231211121124.4194-2-quic_kriskura@quicinc.com/

? How v3 matters?

> 
>>
>>>               - const: ss_phy_irq
>>>   
>>>     - if:
>>> @@ -460,11 +422,13 @@ allOf:
>>>           compatible:
>>>             contains:
>>>               enum:
>>> +              - qcom,ipq5332-dwc3
>>>                 - qcom,sc8280xp-dwc3
>>>                 - qcom,x1e80100-dwc3
>>>       then:
>>>         properties:
>>>           interrupts:
>>> +          minItems: 3
>>
>> Hm, why? This commit is unmanageable. Your commit msg is already huge
>> but still does not explain this. Are you sure you are fixing only one
>> logical thing per patch? Does not look like.
>>
> 
> This is reordering the targets based on interrupts they have. I put it 
> in one commit because splitting this into multiple patches breaks one 
> thing or other. Also once I am defining permutations, I have to group 
> targets into these combinations in the same patch. I know this is a big 
> commit but it solves the interrupt cleanup and defines a way for future 
> targets.


This does not answer why, you sc8280xp and x1e80100 not get one optional
interrupt. I asked "why" you are doing this change. Why do you need it?
What is the rationale?

Then I grunted about unmanageable commit, because all my troubles to
review it are the effect of it: it is very difficult to read. It is also
difficult for you, because you keep making here mistakes. So if you
cannot write this commit properly and I cannot review it, then it is way
over-complicated, don't you think? But this is still second problem
here, don't ignore the fist - "why?"

Best regards,
Krzysztof


