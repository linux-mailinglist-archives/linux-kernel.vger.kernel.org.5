Return-Path: <linux-kernel+bounces-158322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6C8B1E53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD211F223E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71D85954;
	Thu, 25 Apr 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+5nVCjU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6384E08
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038309; cv=none; b=JzK0sm3lRO5g09QXKna2uIs64JmeR82enrnnTiAl6HSXWsYLD7gMqO0lQ8N5NYRvr4WBGzF3nTi9i2p1ahfbeUlwMcMdu7ejGd3pqGFb4nBDiIKlSSeuiFv+va/qfjwOctvaSsaZcs3AMREhWd4EXxTtMvTPiJiG5Re2fvV77sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038309; c=relaxed/simple;
	bh=zGp8P7Zg46vs0kf8u0T5g6NrUtBw1bsIh1TMnzg2Kiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akYx1pJPLT3aGULlJc3Tu/m/9Vb8spjz57E0RfukIclSMCfTlh0Iw37ct6uhaGAoYgzVuQO2Exm/tfUU9o82dBFG+160t2b7679KqR3uRa2WX9uy9MBQ9sBjQUTcLiBbd9YXTJRiVbDamDBWD7zt8X8X6Uikb7D7prHs8k2OkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+5nVCjU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a559b919303so100839666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714038306; x=1714643106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sd/yDEZNSXNv4F2hBnesujiLmDqnF6sSJXT5A6WErHk=;
        b=w+5nVCjUqOZfH0DtsUfM0i0m+jTpJaISgiuElllAzPlza4P8ztjFigPkYoa9QJSeVV
         7uHERBq+AcIb/DkmkfsG8dA1NVarifiv+CLDbtXdc0RzDonLMo+AZiTwj8FRXrGNKjvj
         AALdfO42wIsCuwBaJL8nyGypImGF9gKM++/BOkbdpH6u6DqInBZyErdcvOMDFG+HEKXR
         dzr6mdzpWh6CGqV5pTDInA92U4JUlQOfqx3Ao9JdZrI96vmeiRhCJFIreLUwixIIwjrj
         DusmVsdJPecFkUZeR5zDD5NRPqj+A8Sbuz5swyfi1HRetQTcNiyGFMCWm8o1EAV34PiV
         P6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038306; x=1714643106;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd/yDEZNSXNv4F2hBnesujiLmDqnF6sSJXT5A6WErHk=;
        b=eQg4dak7uowub8zvM+D0FN81RjAuRgeUMAIE9rbO+d+DbRwe2qv/UirCn8v3YbOAg1
         JNvFMByBhxsWoqZoWrA58/lgur/0bUndkCe3NCCPI3gMAplSMsQt0CTbB3kmk10J2fZ7
         yFP5V4DoVcfoIHAVbeGwzDdsd62ZEzLUclscFAjktM93zGYhRx5H/XgVl9llxMYOgSrF
         Z5P3kN2WJpDsEAmNBQahYGtVmlnrzkQkTN1KmS9PxUis1I3hD2rGVtsGPmT8b3owjbff
         Aat2paWzFLm2y3QW8wqvG9lDXs8khLEXfq+VIwOyXpHJf1e0K9H4vVUUq6Xv2PiRzIZI
         OVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjw4UVEIOl0LMQyReim9veDMRkSLLq8oxDhqwJ1NkW+CrNL4sKb7E6g4KOz17INMTG8zFaEw5P7Afs23GsPBMWGBIG8lunrRu1bIwv
X-Gm-Message-State: AOJu0Yx7QoZFeFI/itHjJER0bgvSsbfF7szC1wgkzlAPnm8WSlfR6f2+
	fjMp7PxFhcTmyFjmK2X+xFrjwtr9uimi+oyzWiINao+qR+wKOi0vy3pEaC6rGEM=
X-Google-Smtp-Source: AGHT+IGXAMwuWN/rtF6tjgpdSk3f6LFEJuxVHm5k21FZ8E7aYQBpOTkMsLYnBVVIL2HJvSLBwvPMCg==
X-Received: by 2002:a17:907:774f:b0:a46:da57:6ee4 with SMTP id kx15-20020a170907774f00b00a46da576ee4mr4223627ejc.73.1714038305534;
        Thu, 25 Apr 2024 02:45:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id lu10-20020a170906faca00b00a52299d8eecsm9214840ejb.135.2024.04.25.02.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:45:05 -0700 (PDT)
Message-ID: <d8eb6652-18b5-4ed6-9a44-7c2a0f3bc3bb@linaro.org>
Date: Thu, 25 Apr 2024 11:45:03 +0200
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0T3R7UPFO07.2VR2436TG4N8B@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:39, Thierry Reding wrote:
> On Thu Apr 25, 2024 at 9:52 AM CEST, Krzysztof Kozlowski wrote:
>> On 24/04/2024 19:04, Thierry Reding wrote:
>>> On Wed Apr 24, 2024 at 6:26 PM CEST, Thierry Reding wrote:
>>>> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
>>>>> On 12/04/2024 15:05, Sumit Gupta wrote:
>>>>>> MC SID and Broadbast channel register access is restricted for Guest VM.
>>>>>
>>>>> Broadcast
>>>>>
>>>>>> Make both the regions as optional for SoC's from Tegra186 onwards.
>>>>>
>>>>> onward?
>>>>>
>>>>>> Tegra MC driver will skip access to the restricted registers from Guest
>>>>>> if the respective regions are not present in the memory-controller node
>>>>>> of Guest DT.
>>>>>>
>>>>>> Suggested-by: Thierry Reding <treding@nvidia.com>
>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>> ---
>>>>>>  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++---------
>>>>>>  1 file changed, 49 insertions(+), 46 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>> index 935d63d181d9..e0bd013ecca3 100644
>>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>> @@ -34,11 +34,11 @@ properties:
>>>>>>            - nvidia,tegra234-mc
>>>>>>  
>>>>>>    reg:
>>>>>> -    minItems: 6
>>>>>> +    minItems: 4
>>>>>>      maxItems: 18
>>>>>>  
>>>>>>    reg-names:
>>>>>> -    minItems: 6
>>>>>> +    minItems: 4
>>>>>>      maxItems: 18
>>>>>>  
>>>>>>    interrupts:
>>>>>> @@ -151,12 +151,13 @@ allOf:
>>>>>>  
>>>>>>          reg-names:
>>>>>>            items:
>>>>>> -            - const: sid
>>>>>> -            - const: broadcast
>>>>>> -            - const: ch0
>>>>>> -            - const: ch1
>>>>>> -            - const: ch2
>>>>>> -            - const: ch3
>>>>>> +            enum:
>>>>>> +              - sid
>>>>>> +              - broadcast
>>>>>> +              - ch0
>>>>>> +              - ch1
>>>>>> +              - ch2
>>>>>> +              - ch3
>>>>>
>>>>> I understand why sid and broadcast are becoming optional, but why order
>>>>> of the rest is now fully flexible?
>>>>
>>>> The reason why the order of the rest doesn't matter is because we have
>>>> both reg and reg-names properties and so the order in which they appear
>>>> in the list doesn't matter. The only thing that matters is that the
>>>> entries of the reg and reg-names properties match.
>>>>
>>>>> This does not even make sid/broadcast optional, but ch0!
>>>>
>>>> Yeah, this ends up making all entries optional, which isn't what we
>>>> want. I don't know of a way to accurately express this in json-schema,
>>>> though. Do you?
>>>>
>>>> If not, then maybe we need to resort to something like this and also
>>>> mention explicitly in some comment that it is sid and broadcast that are
>>>> optional.
>>>
>>> Actually, here's another variant that is a bit closer to what we want:
>>>
>>> --- >8 ---
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> index 935d63d181d9..86f1475926e4 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> @@ -34,11 +34,11 @@ properties:
>>>            - nvidia,tegra234-mc
>>>  
>>>    reg:
>>> -    minItems: 6
>>> +    minItems: 4
>>>      maxItems: 18
>>>  
>>>    reg-names:
>>> -    minItems: 6
>>> +    minItems: 4
>>>      maxItems: 18
>>>  
>>>    interrupts:
>>> @@ -146,17 +146,21 @@ allOf:
>>>      then:
>>>        properties:
>>>          reg:
>>> +          minItems: 4
>>>            maxItems: 6
>>>            description: 5 memory controller channels and 1 for stream-id registers
>>>  
>>>          reg-names:
>>> -          items:
>>> -            - const: sid
>>> -            - const: broadcast
>>> -            - const: ch0
>>> -            - const: ch1
>>> -            - const: ch2
>>> -            - const: ch3
>>> +          anyOf:
>>> +            - items:
>>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3 ]
>>> +              uniqueItems: true
>>> +              minItems: 6
>>> +
>>> +            - items:
>>> +                enum: [ ch0, ch1, ch2, ch3 ]
>>> +              uniqueItems: true
>>> +              minItems: 4
>>>  
>>>    - if:
>>>        properties:
>>> @@ -165,29 +169,22 @@ allOf:
>>>      then:
>>>        properties:
>>>          reg:
>>> -          minItems: 18
>>> +          minItems: 16
>>>            description: 17 memory controller channels and 1 for stream-id registers
>>>  
>>>          reg-names:
>>> -          items:
>>> -            - const: sid
>>> -            - const: broadcast
>>> -            - const: ch0
>>> -            - const: ch1
>>> -            - const: ch2
>>> -            - const: ch3
>>> -            - const: ch4
>>> -            - const: ch5
>>> -            - const: ch6
>>> -            - const: ch7
>>> -            - const: ch8
>>> -            - const: ch9
>>> -            - const: ch10
>>> -            - const: ch11
>>> -            - const: ch12
>>> -            - const: ch13
>>> -            - const: ch14
>>> -            - const: ch15
>>> +          anyOf:
>>> +            - items:
>>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7,
>>> +                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15 ]
>>> +              minItems: 18
>>> +              uniqueItems: true
>>> +
>>> +            - items:
>>> +                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10,
>>> +                        ch11, ch12, ch13, ch14, ch15 ]
>>> +              minItems: 16
>>> +              uniqueItems: true
>>
>> No, because order is strict.
> 
> Why? I realize that prior to this the order was indeed strict and it's

That's the policy for entire Devicetree. I said why in other email:
because any bindings consumer can take it via indices.

> common to have these listed in strict order in the DTS files. However,
> this is an arbitrary restriction that was introduced in the patch that
> added reg-names. However, */*-names properties have always assumed the
> ordering to be non-strict because each entry from the * property gets
> matched up with the corresponding entry in the *-names property, so the
> ordering is completely irrelevant.

This was raised so many times... reg-names is just a helper. It does not
change the fact that order should be strict and if binding defined the
order, it is an ABI.

Best regards,
Krzysztof


