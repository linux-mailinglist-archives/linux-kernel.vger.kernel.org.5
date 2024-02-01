Return-Path: <linux-kernel+bounces-47737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647F845220
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487591C21D92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573F21586FD;
	Thu,  1 Feb 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3d2ouuR"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13B208DD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773188; cv=none; b=CY8bK+Sc43IdKKs0GkJkbidi4dBNOldbnD9btIrPmVKxolzfwMnJaiXxvL+cZbc59NR3vCpzRWkpRRYpiIOH6bc/v1SfMFnRmOWE0epzqhgdawy7mAhdTrJxQOgQLcfu/5f6CrWmbZTM4mEsUPZj90CaUV4Wh4wawo+lH+FKGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773188; c=relaxed/simple;
	bh=yrqeUwpzQhQgqlGwMhKSo/hiESVkLGWE5flJXn3sULk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVK4aXaleD1gzWzGy2U7f3QPenIP6hymGbGhrxroLWilZPD/sXOyThac0DeBGDz0mVve5Xxb3qQegxTH2rBuzL9vzul6lv/OgFZ4p0byiOa605V2isQE73CXsPOdjfOZDezIYwX8XMg5T/YpI8qjJDUd1guOLTbCZSrTXGM49rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3d2ouuR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so754335a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706773185; x=1707377985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qgmsm9BRtTJBjXBbdJJ16Hw0zd4DqLTuh86MYmetfb8=;
        b=m3d2ouuRwnPCs3g+egHDI165oGCjs7DG8tEYvoS0mlm7Q/HlOEKAMJ38MrCq+sID57
         qf8TOz2bGyRKZ1t3AjtHPxaS6KsH/Hwb6uHXoRt06KmXPkW8Zu4J35npm3ccYWH5rgOd
         ExlPlAX/IE23OlFkRiQXDi7lsp1UcksSeIKS6OmEGJyBGieIYXLLMtSdMdLVh+2HH804
         t77yjpeYdhIn5qPp88CM+Ed3/vXwi5itT9uEPAYw0bN3xzeF4cVLJ0Qkgqe8ISG1Iwfs
         IcTds6K4dOfZZOPzi8s5/Wxyff+jjqqdEuYUoBETuI9A3RUrb6J3VWEmdQCizQzSd8Qy
         3PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706773185; x=1707377985;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgmsm9BRtTJBjXBbdJJ16Hw0zd4DqLTuh86MYmetfb8=;
        b=vrJZVwdcCkF79oHVqlClJR57srbr9QJbCMLjjt3GRRX9Vl1/UqiLSPntWNIHGj+tfQ
         Z0Tl0mc3bKgG1ff8J+eYyhZjfJMOHZtuTFw1fNVvcnJC9WqpYoFGabpMdc8K+YWWxADP
         GRe58r0Zq9oYwoht0q8b8lHkqAjQWQ4KBkq4RCatsDUFyVbawiT+1ez+Uhpc6ZQO4aCV
         ulPcaSl3UdhEetSxPYyNVQdirMYCql6Np0Xo9Gfk++5Gjk84IlHKON/kxSTTntsIbnT2
         bcxAatUGosL46qjgSySIR5wX0wU321uIQVPovMphELsRHrjjeUIDc+A/LUTRWbV88Oy8
         32Rg==
X-Gm-Message-State: AOJu0YynfjynTVqzz8S8rOttT0XAivK6VS770tfY86yWcEtbfCWJNhib
	/WBSF6fP9RDk4VHQ7ALYOFbL9Bd/M44MtSw+/RzCuJB3w7NO+/iJXTKVKavCSLE=
X-Google-Smtp-Source: AGHT+IEyDWTXSgGf79ipDAT9IMCerYPN4dQ7xOhFzJF6dsCAwSM1keOCqXPsOqMNSeYDcK5Mm+W+CQ==
X-Received: by 2002:a17:906:f2c6:b0:a35:85b7:560a with SMTP id gz6-20020a170906f2c600b00a3585b7560amr2778687ejb.46.1706773184749;
        Wed, 31 Jan 2024 23:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUFCmsep7OitSGMUdT2kz69EmaAiTLHsHHcbu81LuUyZV3OYZILMC6ECogMyOaEs8VylVXiCzu1QNGDw+8ctBqEqm3D9vea+qqs4erNejU9KARAjxsovZoBGEpIk8DlnFXKl0CA5t79iYMJvF+3rmKl55NVRIL21hKPD4BRz2A+h6KA5wEnOmfXP1Bu87EfKQ5biY56kjwZThcKgAmMFVuj9Lvwx4hI5G1yFzEt9Z9bhVpnjYyY1jyyrBx0G5Vsr5A2HwaBTGn/I9HOz+q0xbhdDVvktnplA1V2Mx0bGAh6WuXBN9NgJj/+YE5hOslCXKyswqdiADQG0zb1tA2FLdcQijas/yljioYth0fVLKbHJPZpv0n//ThSpxPGSiWfDxMc8nvi+KP/sOAxkQIBfvPJ1ZC3IxhQo9aiPkbHpHqxJivvjrnZuj+RtWL6bPeBd5Od2iYz5ok4SqRD6nXXiloZOdQ5G0jKaGDRdEBXpGJY6ovKVR46QiXIkCRncyDQBcmLxddYrE6DTnjbVj4rz+XMgX4UE71pV+Ldpy5KltTDIAnauhvPEUIteednwZgNnXYxmhs97DSbWP1L9QN2+oqJPpoAaZNiK4FFcYPHVNerZc8Xfx1vrDczUfqbHI8u+5qRL4EPq5W8/dFcyCt9gmS9MGqD6Yd4ja5R7zk6OQr3h7V2aJxCvypSeEGrP8s=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906170200b00a33604d2a41sm6916476eje.132.2024.01.31.23.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 23:39:44 -0800 (PST)
Message-ID: <32fd4622-1bc1-48f7-85f0-e04fcb6c0f88@linaro.org>
Date: Thu, 1 Feb 2024 08:39:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: add sam9x7-lvds
 compatible
Content-Language: en-US
To: Dharma.B@microchip.com, robh@kernel.org
Cc: conor@kernel.org, krzk@kernel.org, Manikandan.M@microchip.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux4Microchip@microchip.com
References: <20240122082947.21645-1-dharma.b@microchip.com>
 <20240122082947.21645-2-dharma.b@microchip.com>
 <10a88fc6-2c4c-4f77-850f-f15b21a8ed49@kernel.org>
 <20240122-privacy-preschool-27dc7dcc5529@spud>
 <01c4fc05-9b3f-4007-9216-444a4306efd7@microchip.com>
 <20240130191255.GA2164257-robh@kernel.org>
 <f980706a-2bc7-46f2-8c3e-1cc62a1e2cb7@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f980706a-2bc7-46f2-8c3e-1cc62a1e2cb7@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 05:10, Dharma.B@microchip.com wrote:
> On 31/01/24 12:42 am, Rob Herring wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Tue, Jan 23, 2024 at 03:39:13AM +0000, Dharma.B@microchip.com wrote:
>>> Hi Conor,
>>>
>>> On 22/01/24 10:07 pm, Conor Dooley wrote:
>>>> On Mon, Jan 22, 2024 at 04:51:16PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 22/01/2024 09:29, Dharma Balasubiramani wrote:
>>>>>> Add the 'sam9x7-lvds' compatible binding, which describes the
>>>>>> Low Voltage Differential Signaling (LVDS) Controller found on Microchip's
>>>>>> sam9x7 series System-on-Chip (SoC) devices. This binding will be used to
>>>>>> define the properties and configuration for the LVDS Controller in DT.
>>>>>>
>>>>>> Signed-off-by: Dharma Balasubiramani<dharma.b@microchip.com>
>>>>>> ---
>>>>>>    .../display/bridge/microchip,sam9x7-lvds.yaml | 59 +++++++++++++++++++
>>>>>>    1 file changed, 59 insertions(+)
>>>>>>    create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..8c2c5b858c85
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
>>>>>> @@ -0,0 +1,59 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id:http://devicetree.org/schemas/display/bridge/microchip,sam9x7-lvds.yaml#
>>>>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Microchip SAM9X7 LVDS Controller
>>>>> What is the "X"?
>>>>>
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Dharma Balasubiramani<dharma.b@microchip.com>
>>>>>> +
>>>>>> +description: |
>>>>> Do not need '|' unless you need to preserve formatting.
>>>>>
>>>>>> +  The Low Voltage Differential Signaling Controller (LVDSC) manages data
>>>>>> +  format conversion from the LCD Controller internal DPI bus to OpenLDI
>>>>>> +  LVDS output signals. LVDSC functions include bit mapping, balanced mode
>>>>>> +  management, and serializer.
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: microchip,sam9x7-lvds
>>>>> What is "x"? Wildcard? Then no, don't use it and instead use proper SoC
>>>>> version number.
>>>> These SoCs actually do have an x in their name. However, and I do always
>>>> get confused here, the sam9x7 is a series of SoCs (the cover letter does
>>>> say this) rather than a specific device.
>>>> I think the series current consists of a sam9x70 sam9x72 and a sam9x75.
>>>> The devices are largely similar, but I am not sure if the sam9x70
>>>> supports LVDS at all. Having a compatible for the series does not seem
>>>> correct to me.
>>> Yes, you are correct. Only sam9x72 and sam9x75 have LVDS support, while
>>> sam9x70 does not. I will revise the compatibility to include both
>>> sam9x72 and sam9x75, as outlined below:
>>>
>>> properties:
>>>     compatible:
>>>       enum:
>>>         - microchip,sam9x72-lvds
>>>         - microchip,sam9x75-lvds
>>
>> I would presume these 2 are the same, but the above implies they
>> aren't. I think what you had is fine assuming these are all
>> fundamentally the same part with just packaging or fused off h/w
>> differences.
> 
> Yes, so is it okay to have compatible for a series? Shall I go ahead with
> "
>    compatible:
>      const: microchip,sam9x7-lvds

You said 9x70, which would match such 9x7 "series", is different, so I
still think series should not be used. I don't know much about Microchip
naming scheme, so this x is always confusing. However if these are the
same, maybe just use sam9x72?

Best regards,
Krzysztof


