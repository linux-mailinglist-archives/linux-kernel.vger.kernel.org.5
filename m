Return-Path: <linux-kernel+bounces-158781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01A8B24D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94561F23AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42514AD0A;
	Thu, 25 Apr 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9e4rQt1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75E149E0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058182; cv=none; b=hCdObzA723TqLC9aWPb4iWGNmOb6GkXOVvNMkxClxr9qy3qki+HoaGDPfmSMHiKejRKeaWCILZk1SrsUM1P5kLPALflmR6+uDu7R1RaTsSt9eMUQdtpYgoFOs31NnOb5tWHeydovJW8UBS74ZL4qEaUVbZJxjXYp/Djxt9zeKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058182; c=relaxed/simple;
	bh=5yxhYykwugKSH3LzzWOU0n0bbIEo1Q8ay/PBp5JY8Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyIxkNxoYuPmou5ROJzBUub6lLPyecXY50ztDgxfdx04GVWMm3kJv1+Q8Dz4NKyDnPRC6Mw+o2V+N76hLSHs2W94xH/wBvfoLWJVHOSjvM7ZaR0F7PaBCCrBdEe9CvQ+HfVOFejaN2iL8iZD+cmSSnS7GfqkRai0yzcpe0Hamuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9e4rQt1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5200afe39eso122737066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714058178; x=1714662978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CyrXcSnM/MfOVZ3XMl41JkXc30kPx3wxBN2F1+zdXXg=;
        b=t9e4rQt1aRIur5CMQojLglcZ+ldhcztsQ5PiRYx5uHM7DZRfCe0aiefrtq5ZudedKm
         A5dsXCjsN7USbugtY8TumURKGJwB9EttkXinXHD5VIrfMr1bREvPp46J2RKPJ19jRecG
         +Cjnxvqr/R0MUmFx/vEY1feh1wrAXGzxTkJD3wcUGj1jOxzhFv49p/DrllhNOe+aBzlO
         EpJarK4EOoM85YVgBwcw5O+MANMKCfky0fKW9kt7DeVI7UsFUigThM5cPwfpNdcs/40k
         csAj1DpiimT+UHKJ8RBMKUEn7mG/6yUf8p8QFx5O5A/FXNf2o7Cc78GaIhbo0QEqgz8w
         TlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058178; x=1714662978;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyrXcSnM/MfOVZ3XMl41JkXc30kPx3wxBN2F1+zdXXg=;
        b=KZksKQIlnD4g9ZbS6fUH5oIzkHJ+6R8ixDz4kCxlIiHXQjHOvKLHM03L6lbYx554uE
         0zTtDdw+A1+r9Sit6DgnMTQRXAS62cqkBKTFMmmNX7GqHZZc2aVC0KALhz8vN7OBQoXu
         kBt0WWVxaczc+5Dun307jvsAmXE8plq6VqHA0pU8/zmO0jXL0pUS/ECDxoSkqRXUWCwc
         Qg7jUq7c6QQK/VCoGifdJlKiK5eBYawGEE71nV8zl+6sV85/AoItiSvEIFmICMmUnYqf
         5RafoGZjZ2cAJlgQsAWZ6uDOWLiBC1aq/kHvkBOjsn2UivHohYPRC0wAlFjUNNtGYoc7
         QfJw==
X-Forwarded-Encrypted: i=1; AJvYcCWEie8CyiJ+BAf92VUfBqgB1JYElx4TNVddE1xo/evY+hiLyGi3DgJdJ4Q0ZIe1LL+YQSUhFPJ77X0W/7pdV0nwOs+Lcj/vYcmddY5D
X-Gm-Message-State: AOJu0YzJLqJQ857FInQ/yWizuzTcCHodgUfEFDN85YKjP0x6hWI4SHaZ
	QQnmcJHWPY4fjRduKYJGoSZh8+8JMf4MnNg/tG4KLbn8xY7i+O/fHY5rzt183cw=
X-Google-Smtp-Source: AGHT+IGqu80UeP2zZXNY3+qIMygrtn8SShEVi35k8vcUYyHt6Hg47hFykQyDe9+iZi2t5jjCeMYQQw==
X-Received: by 2002:a17:906:c202:b0:a52:5493:a0b9 with SMTP id d2-20020a170906c20200b00a525493a0b9mr27837ejz.39.1714058177950;
        Thu, 25 Apr 2024 08:16:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a526a992d82sm9663042ejz.4.2024.04.25.08.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:16:17 -0700 (PDT)
Message-ID: <524f0bd3-1912-4a06-8c68-fea7ca563d68@linaro.org>
Date: Thu, 25 Apr 2024 17:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
To: Thierry Reding <thierry.reding@gmail.com>, Sumit Gupta
 <sumitg@nvidia.com>, robh@kernel.org, conor+dt@kernel.org, maz@kernel.org,
 mark.rutland@arm.com, treding@nvidia.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
 <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>
 <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com> <D0SILCYU98EV.1XW7NZFC9013K@gmail.com>
 <9561dede-37d0-4183-8742-448058803f8e@linaro.org>
 <D0T3R7UPFO07.2VR2436TG4N8B@gmail.com>
 <d8eb6652-18b5-4ed6-9a44-7c2a0f3bc3bb@linaro.org>
 <D0TANBDMJHH2.5XTXRZ09K4OU@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0TANBDMJHH2.5XTXRZ09K4OU@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 17:03, Thierry Reding wrote:
> On Thu Apr 25, 2024 at 11:45 AM CEST, Krzysztof Kozlowski wrote:
>> On 25/04/2024 11:39, Thierry Reding wrote:
>>> On Thu Apr 25, 2024 at 9:52 AM CEST, Krzysztof Kozlowski wrote:
>>>> On 24/04/2024 19:04, Thierry Reding wrote:
>>>>> On Wed Apr 24, 2024 at 6:26 PM CEST, Thierry Reding wrote:
>>>>>> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
>>>>>>> On 12/04/2024 15:05, Sumit Gupta wrote:
>>>>>>>> MC SID and Broadbast channel register access is restricted for Guest VM.
>>>>>>>
>>>>>>> Broadcast
>>>>>>>
>>>>>>>> Make both the regions as optional for SoC's from Tegra186 onwards.
>>>>>>>
>>>>>>> onward?
>>>>>>>
>>>>>>>> Tegra MC driver will skip access to the restricted registers from Guest
>>>>>>>> if the respective regions are not present in the memory-controller node
>>>>>>>> of Guest DT.
>>>>>>>>
>>>>>>>> Suggested-by: Thierry Reding <treding@nvidia.com>
>>>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>>>> ---
>>>>>>>>  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++---------
>>>>>>>>  1 file changed, 49 insertions(+), 46 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>>>> index 935d63d181d9..e0bd013ecca3 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>>>> @@ -34,11 +34,11 @@ properties:
>>>>>>>>            - nvidia,tegra234-mc
>>>>>>>>  
>>>>>>>>    reg:
>>>>>>>> -    minItems: 6
>>>>>>>> +    minItems: 4
>>>>>>>>      maxItems: 18
>>>>>>>>  
>>>>>>>>    reg-names:
>>>>>>>> -    minItems: 6
>>>>>>>> +    minItems: 4
>>>>>>>>      maxItems: 18
>>>>>>>>  
>>>>>>>>    interrupts:
>>>>>>>> @@ -151,12 +151,13 @@ allOf:
>>>>>>>>  
>>>>>>>>          reg-names:
>>>>>>>>            items:
>>>>>>>> -            - const: sid
>>>>>>>> -            - const: broadcast
>>>>>>>> -            - const: ch0
>>>>>>>> -            - const: ch1
>>>>>>>> -            - const: ch2
>>>>>>>> -            - const: ch3
>>>>>>>> +            enum:
>>>>>>>> +              - sid
>>>>>>>> +              - broadcast
>>>>>>>> +              - ch0
>>>>>>>> +              - ch1
>>>>>>>> +              - ch2
>>>>>>>> +              - ch3
>>>>>>>
>>>>>>> I understand why sid and broadcast are becoming optional, but why order
>>>>>>> of the rest is now fully flexible?
>>>>>>
>>>>>> The reason why the order of the rest doesn't matter is because we have
>>>>>> both reg and reg-names properties and so the order in which they appear
>>>>>> in the list doesn't matter. The only thing that matters is that the
>>>>>> entries of the reg and reg-names properties match.
>>>>>>
>>>>>>> This does not even make sid/broadcast optional, but ch0!
>>>>>>
>>>>>> Yeah, this ends up making all entries optional, which isn't what we
>>>>>> want. I don't know of a way to accurately express this in json-schema,
>>>>>> though. Do you?
>>>>>>
>>>>>> If not, then maybe we need to resort to something like this and also
>>>>>> mention explicitly in some comment that it is sid and broadcast that are
>>>>>> optional.
>>>>>
>>>>> Actually, here's another variant that is a bit closer to what we want:
>>>>>
>>>>> --- >8 ---
>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> index 935d63d181d9..86f1475926e4 100644
>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> @@ -34,11 +34,11 @@ properties:
>>>>>            - nvidia,tegra234-mc
>>>>>  
>>>>>    reg:
>>>>> -    minItems: 6
>>>>> +    minItems: 4
>>>>>      maxItems: 18
>>>>>  
>>>>>    reg-names:
>>>>> -    minItems: 6
>>>>> +    minItems: 4
>>>>>      maxItems: 18
>>>>>  
>>>>>    interrupts:
>>>>> @@ -146,17 +146,21 @@ allOf:
>>>>>      then:
>>>>>        properties:
>>>>>          reg:
>>>>> +          minItems: 4
>>>>>            maxItems: 6
>>>>>            description: 5 memory controller channels and 1 for stream-id registers
>>>>>  
>>>>>          reg-names:
>>>>> -          items:
>>>>> -            - const: sid
>>>>> -            - const: broadcast
>>>>> -            - const: ch0
>>>>> -            - const: ch1
>>>>> -            - const: ch2
>>>>> -            - const: ch3
>>>>> +          anyOf:
>>>>> +            - items:
>>>>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3 ]
>>>>> +              uniqueItems: true
>>>>> +              minItems: 6
>>>>> +
>>>>> +            - items:
>>>>> +                enum: [ ch0, ch1, ch2, ch3 ]
>>>>> +              uniqueItems: true
>>>>> +              minItems: 4
>>>>>  
>>>>>    - if:
>>>>>        properties:
>>>>> @@ -165,29 +169,22 @@ allOf:
>>>>>      then:
>>>>>        properties:
>>>>>          reg:
>>>>> -          minItems: 18
>>>>> +          minItems: 16
>>>>>            description: 17 memory controller channels and 1 for stream-id registers
>>>>>  
>>>>>          reg-names:
>>>>> -          items:
>>>>> -            - const: sid
>>>>> -            - const: broadcast
>>>>> -            - const: ch0
>>>>> -            - const: ch1
>>>>> -            - const: ch2
>>>>> -            - const: ch3
>>>>> -            - const: ch4
>>>>> -            - const: ch5
>>>>> -            - const: ch6
>>>>> -            - const: ch7
>>>>> -            - const: ch8
>>>>> -            - const: ch9
>>>>> -            - const: ch10
>>>>> -            - const: ch11
>>>>> -            - const: ch12
>>>>> -            - const: ch13
>>>>> -            - const: ch14
>>>>> -            - const: ch15
>>>>> +          anyOf:
>>>>> +            - items:
>>>>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7,
>>>>> +                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15 ]
>>>>> +              minItems: 18
>>>>> +              uniqueItems: true
>>>>> +
>>>>> +            - items:
>>>>> +                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10,
>>>>> +                        ch11, ch12, ch13, ch14, ch15 ]
>>>>> +              minItems: 16
>>>>> +              uniqueItems: true
>>>>
>>>> No, because order is strict.
>>>
>>> Why? I realize that prior to this the order was indeed strict and it's
>>
>> That's the policy for entire Devicetree. I said why in other email:
>> because any bindings consumer can take it via indices.
>>
>>> common to have these listed in strict order in the DTS files. However,
>>> this is an arbitrary restriction that was introduced in the patch that
>>> added reg-names. However, */*-names properties have always assumed the
>>> ordering to be non-strict because each entry from the * property gets
>>> matched up with the corresponding entry in the *-names property, so the
>>> ordering is completely irrelevant.
>>
>> This was raised so many times... reg-names is just a helper. It does not
>> change the fact that order should be strict and if binding defined the
>> order, it is an ABI.
> 
> Sorry, but that's not how we've dealt with this in the past. Even though
> this was now ten or more years ago, I distinctly recall that when we
> started adding these *-names properties and at the time it was very much
> implied that the order didn't matter.

Then you added it wrong and Rob was expressing the purpose of names
multiple times. The names were for cases when you could not determine
the order.

The strict order was repeated so many times in the mailing list, I lost
track.

> The only use-case that I know of where order was always meant to matter
> is backwards-compatibility for devices that used to have a single entry
> (hence drivers couldn't rely on *-names to resolve the index) and then
> had additional entries added. The *-names entry for that previously
> single entry would now obviously have to always be first in the list to
> preserve backwards-compatibility.
> 
> Besides, if reg-names was really only a helper, then it would also be
> completely redundant. Many device tree bindings have *-names properties
> marked as "required" precisely because of the role that they serve.

For most of the cases, so ones which do not have flexible order, it is
redundant and for that reason Qualcomm has been switching away from
xxx-names in several drivers.

However it is not entirely redundant, because it allows bindings
consumers to choose either index or name. Both are ABI, when documented
in the binding with strict order.

https://lore.kernel.org/all/CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12FBgxYg@mail.gmail.com/


Best regards,
Krzysztof


