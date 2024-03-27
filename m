Return-Path: <linux-kernel+bounces-120662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5180388DB23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D411F2A5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05904AEF1;
	Wed, 27 Mar 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="is6knbdE"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF94AEEC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534756; cv=none; b=T3pODD4KYTCnijoXgUwHB4kqLaUs1Y1oYQ+BbnaF4WamIr7X5ISY+kD7nFnsU1ACHFGpyfKUo6jVgGb8sZ6nKUBaNuQK7kO4OMMGIoyACuuOJDnBvYTFbBrecdYhOvAfkPdzcH9+5pIJwQvznboxFuNcdLeU1bD2HaS/2FNF05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534756; c=relaxed/simple;
	bh=PFFbvpMeKSlCkoL8Tky03mF0hQ30Gi1s1ZDpID39A5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0sOKU5OrVu/MrZWr2FYYy1P0c5j1w9TbFlRu2SK1OGEyaYNiqftKvOFBsSae6YVldqq6WxBV4DQ82PpxjCoSsyv8jtQsPckJMUdp3cRiagq7ttA8I6vIl3TKuqisQvDn6RBe6Pg8l6lZFxBYJMR4PjSDG8i5abRLV0izKjknMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=is6knbdE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c08d1e900so4223873a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711534753; x=1712139553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUbPJYx8dWY/6/KPCGGxTzNMVxFuv/KVqNkpthIY5cg=;
        b=is6knbdEPMDxH34IF+BWFsAi8UlyZ0ZVYtoi1YkKJdaAKbhBJ5R/1YgUzNpft6CmpR
         pmkeQ1oF5PvwqPwUhkh7NTdZ7QWW59+C+FR2izKLfSfSc0bml9I3KvvWRbxaaUx9QXuP
         /Okcrc1V6Xg5hAbUrBOuQCrdQY5XTdwDJM+g94C2y6GAgBgfuC4l8uVcznDVE0DTJVWf
         EH/04lEsmIa+8XcPMD6pqgsTxPRSRjtkP7L5aJevfEZ/3KH2y7+ZghItGtz7nUcotePS
         DLJO48lKQl6ONSvSZ3Ti492fdHOi7RGA7o3UMHKtbtcSEE7iZXkx7W2wUd3UpW3HPXSr
         lR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711534753; x=1712139553;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUbPJYx8dWY/6/KPCGGxTzNMVxFuv/KVqNkpthIY5cg=;
        b=Xea8oC604zLLGoG8fxo6prd5GvEi1X+qhQJ6ith6ABeJOkZgKm08fbcwNac6H3SHDE
         7J8dqpdFj7GlXY9p4Eq/L79MUPI1B/LnbTiBjO4uKFCbK0hwiPVtmzQ0oWMKOe69e0SF
         AMHTT9nRyQOFr2lGip5qv3a1hd39ft6UuaFdBKjSwnTzazKIEbwUWh9adgTvIwOnkaqm
         a5TCfiinnZT8FtvJBbwr+pCtENl99Kp46viI1/X7ZyCNSzgwgF+XTSDLdTX6LiOm8+gX
         TYXKChy4Tt7e60E6A7DQz803g6t5uXvu9LWZkofQSX0aobeTDyS0oizM3y0PALVBzcTp
         Kyog==
X-Forwarded-Encrypted: i=1; AJvYcCUeodJ3ncxHbr7+3wBhrLl11ms+rWhDJvBtFwmcuH+XX9SL6xtmuBpCpwGIWcbwUdzsj9vrTjHoK0w/T+xCWG+9ImHplDL13xOXtOWq
X-Gm-Message-State: AOJu0Yz+KIIhpMoKE4QccHbP8Sngyi3zwxotMc2I9weLpNzEw/zim6xP
	DD21toyUUMPCG0l0W64DhPgAg03Txpc0MKtcC4opD1VZmpT10HbuH3jIbBr7aKsvXusaNGlEC/f
	Q
X-Google-Smtp-Source: AGHT+IGo9lVr88CG0JfJ8pYR4ujOEuzT5XwLFjTM/gJJNzvFUiXt15iwG3UPULPwe6FnYnMP1k4rdA==
X-Received: by 2002:a50:954c:0:b0:56b:defa:57b0 with SMTP id v12-20020a50954c000000b0056bdefa57b0mr3445885eda.10.1711534753127;
        Wed, 27 Mar 2024 03:19:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id a11-20020a05640233cb00b0056bc0c44f02sm5090077edc.96.2024.03.27.03.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:19:12 -0700 (PDT)
Message-ID: <62242f04-c18d-4da0-bd40-1be26886e41a@linaro.org>
Date: Wed, 27 Mar 2024 11:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
 <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
 <6a6e7c4d-d5fd-42ae-bc3d-a3978d65e8e4@solid-run.com>
 <b086a02c-624f-4225-a9fb-164095742ce9@linaro.org>
 <6af08a38-5239-4f5f-9e87-108e3400a6e6@solid-run.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6af08a38-5239-4f5f-9e87-108e3400a6e6@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 20:26, Josua Mayer wrote:
> Am 26.03.24 um 07:41 schrieb Krzysztof Kozlowski:
>> On 25/03/2024 21:12, Josua Mayer wrote:
>>> Am 25.03.24 um 20:34 schrieb Krzysztof Kozlowski:
>>>> On 22/03/2024 11:08, Josua Mayer wrote:
>>>>> Am 21.03.24 um 22:47 schrieb Josua Mayer:
>>>>>> Add bindings for SolidRun Clearfog boards, using a new SoM based on
>>>>>> CN9130 SoC.
>>>>>> The carrier boards are identical to the older Armada 388 based Clearfog
>>>>>> boards. For consistency the carrier part of compatible strings are
>>>>>> copied, including the established "-a1" suffix.
>>>>>>
>>>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml        | 12 ++++++++++++
>>>>>>  1 file changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
>>>>>> index 16d2e132d3d1..36bdfd1bedd9 100644
>>>>>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
>>>>>> @@ -82,4 +82,16 @@ properties:
>>>>>>            - const: marvell,armada-ap807-quad
>>>>>>            - const: marvell,armada-ap807
>>>>>>  
>>>>>> +      - description:
>>>>>> +          SolidRun CN9130 clearfog family single-board computers
>>>>>> +        items:
>>>>>> +          - enum:
>>>>>> +              - solidrun,clearfog-base-a1
>>>>>> +              - solidrun,clearfog-pro-a1
>>>>>> +          - const: solidrun,clearfog-a1
>>>>>> +          - const: solidrun,cn9130-sr-som
>>>>>> +          - const: marvell,cn9130
>>>>>> +          - const: marvell,armada-ap807-quad
>>>>>> +          - const: marvell,armada-ap807
>>>>>> +
>>>>>>  additionalProperties: true
>>>>> Before merging I would like some feedback about adding
>>>>> another product later, to ensure the compatibles above
>>>>> are adequate? In particular:
>>>>> - sequence of soc, cp, carrier compatibles
>>>>> - name of som compatible
>>>>>
>>>>> Draft for future bindings:
>>>>>       - description:
>>>>>           SolidRun CN9130 SoM based single-board computers
>>>>>           with 1 external CP on the Carrier.
>>>>>         items:
>>>>>           - enum:
>>>>>               - solidrun,cn9131-solidwan
>>>>>           - const: marvell,cn9131
>>>>>           - const: solidrun,cn9130-sr-som
>>>> This does not look correct. cn9131 is not compatible with your som.
>>> This is partially my question.
>>> I considered changing the som to "cn913x-sr-som".
>>>
>>> The SoM itself is always 9130, it contains the base SoC
>>> with 1x AP and 1x CP in a single chip.
>>> 9131 and 9132 <happen> on the carrier boards.
>> No wildcards, but if the SoM name is 9130 then use 9130.
>> The problem is that you use cn9130 SoC as fallback.
>>
>>>>>           - const: marvell,cn9130
>>>> SoCs are compatible only in some cases, e.g. one is a subset of another
>>>> like stripped out of modem. Are you sure this is your case?
>>> This is more complex, CN9131 and CN9132 are not single SoCs.
>>> A "9132" is instantiated by connecting two southbridge chips
>>> via a Marvell defined bus, each providing additional IO
>>> such as network, i2c, gpio.
>>>
>>> Note that even the first, "9130", while a single chip, contains two dies:
>>> An "AP" (Application Processor I assume) with very limited IO (1xsdio, 1xi2c),
>>> and a "CP" (Communication Processor I assume) with lots of IO.
>>> This CP as far as I know today is identical to the southbridges
>>> mentioned above.
>> OK, but how does it affect compatibility between them? Which parts are
>> the same? Or how much is shared?
> 9130, 9131, 9132 belong together.

I don't understand what it means.

> 9130 is single chip including two dies: AP, CP.
> The CP is available as an individual chip,
> up to two can be connected to one 9130.

And? How does it help me to decide? What is 9131 and 9132?

> 
> What does this mean for compatibility?
> Which compatibility specifically?
> Is there a definition we can refer to?

Devicetree spec.

Let me answer with a question, because you neither answer mine nor
provide detailed information.

Is Cortex-A15 compatible with Cortex-A7 in the Devicetree? No. Now what
does it mean to your case?

I don't even understand what is your case.

> 
> From software perspective we can always down-grade,
> i.e. run software only aware of the AP on 9130, 9131 or 9132.
> But we can't run software referencing the external CPs
> if they are not connected.

Same with Cortex A15 and A7, right?


> 
>>>>>           - const: marvell,armada-ap807-quad
>>>>>           - const: marvell,armada-ap807
>>>> Anyway, 6 compatibles is beyond useful amount. What are you expressing
>>>> here?
>>> I copied this part from the examples earlier in the file, such as:
>>>       - description: Armada CN9132 SoC with two external CPs
>>>         items:
>>>           - const: marvell,cn9132
>>>           - const: marvell,cn9131
>>>           - const: marvell,cn9130
>>>           - const: marvell,armada-ap807-quad
>>>           - const: marvell,armada-ap807
>>>>  Why is this even armada ap807?
>>> We noticed ap807 != ap806 (cn913x != 8040),
>>> because the thermal sensor coefficients converting
>>> raw values to celsius differed.
>> That's also not the best example.Might be correct but also looks
>> over-complicated. The point of board-level compatibles is to identify
>> machine and its common parts. It has little impact inside of kernel (at
>> least should be almost no users inside!)
> Indeed, the temperature coefficients are handled by the thermal device
> compatible string, not board-level.
>> , but there can be some users,
>> e.g. firmware or user-space.
>>
>> This claims that cn9132 is compatible with ap807, so you have exactly
>> the same base. The same base is not CPU! It's about the S in SoC, so
>> "System".
> I would think since the base is always a single chip combining 1x AP+CP,
> the "system" is marvell,cn9130.
> For Armada 8040, the system would be marvell,armada8040 by same
> logic (also combining 1x AP+CP, different version, not extensible).
>> Could firmware use marvell,armada-ap807 compatible to properly
>> detect type of system and treat all these boards as ap807?
> I have not looked into presence detection for CP's during initialization.
> U-Boot support without spaghetti is a future Me task.

???

> I suspect it is possible with asterisk *, because so far I have only seen
> configuration with at least 1 CP, never with 0.
> Presence of a boot-rom on each die e.g. supports this idea.

I still don't understand.

Best regards,
Krzysztof


