Return-Path: <linux-kernel+bounces-28601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32165830095
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD16E1F24D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA29BE65;
	Wed, 17 Jan 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCF0Cm4C"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137FBE4C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477059; cv=none; b=dXYR1r4/RYY8nIvr7JC4Pd+35A5cuJ33Hw+STPpwS+0kOv5fc7FZ9ikuCIaM0dgmVhlT8JjSff65cpSrLBeUKrOgLoIhmGu0Y66uL+YpfjVXOkAs11m95potu+u5GkS5OcgV45wbBf78zf05jFljC5MLIex80iuO09ZeOxav0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477059; c=relaxed/simple;
	bh=1eQ/pqXoQG270ZvRFbCAoZaq95bnLk24Xb2QmOUHtD4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=g9DP0rSpM3iZmRkhIs2hmu8CzFSo5rhnJ10HzjIQWYuxOauc9qUAZCd/e0Sv8+slVWDCuSvhRJguu9fpjoEGHGhRAz8AUMtwER4yHsCvclMxY7VnsmFCxpNt3hPNJBSIAvH0LVjvtpz/b/YPH0xvcuaz+iSNd5/oUC7iQlDTbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HCF0Cm4C; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2ece31f5fdso32752266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705477056; x=1706081856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYY6pYg4hJx8t4EgMJgj47ze8WV3NufoN+cY8Yko8wU=;
        b=HCF0Cm4CejSuzv7zvWUFGQYwsvykH0eGcUH4QntSC8rdmGwvvNFgtcsWXEy9N+pzJX
         Pdnopc9wzaQioauFAwZ0M3k0zrm5mxRBXOcWITC8GMkt+3J4YyRxFks2f31PWVhStPoi
         LGmdggmVnHuEGPnlsF5t9pdrHZjwhbVKcqCSqVWH08WFfI1DFJSLWysw9uHzK05Nglrb
         raVBDSLMirvGRO2p3QZAjSOiLRRoiqoN0mCVy5aler9/Uqzd3NVxDHCu1SY+A4nk0t+y
         iBqBIk4TFcKPYP2D0U/smH/Stb+lPxbuMP2Jb2fxmQ1+e71awQNXKKoQi08VCGoHY3lt
         WsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477056; x=1706081856;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYY6pYg4hJx8t4EgMJgj47ze8WV3NufoN+cY8Yko8wU=;
        b=cp/lHyZd9mM9ApC2cxT1xcUacF3Z2ZTDQEedzqVGIXAu1Z46sUp096idQPWSMt/cYo
         WwzIIXce+HSJdSHvzqXtWkeK2pTAeLUKOMdOytPeid2qIFEicBCLIEF2a5Ay4kARFwPT
         z07uXk7z2kJHqSEXG2tQKJ8IWwIkKuUo7eb3pDCfqDHPOhOuCgaieIV0H6OgoI2emxEw
         MNYxf5lN17VY5ZAzuLj37GkhEc2SNJqSzF2jSDYKe3GzVC/zs+ztZIEVOjeAeKanRRP9
         /BATe2oDuka55BI0lvtL/arSH4elj/GJN8ikIgoaA1pE0vd6vK15WXRfswcFHXYboUyT
         F5iA==
X-Gm-Message-State: AOJu0YyYJ4uFGgke8u3m4hxHCdLcb56yDwniLola/DgIBFYf55qXB0Q0
	FTOjS1PE7bXHc79TtnxwzloCCCbDc7sdPA==
X-Google-Smtp-Source: AGHT+IGI2hc8ONom1x59NxfFXZFzuHKuCXPlvMiNSpZswnyOsMJ0vVpL5nxjhgoEBxbXs1a6lONRLw==
X-Received: by 2002:a17:907:a609:b0:a2d:89a3:3c17 with SMTP id vt9-20020a170907a60900b00a2d89a33c17mr2601230ejc.110.1705477055857;
        Tue, 16 Jan 2024 23:37:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id bv2-20020a170906b1c200b00a2e81e4876dsm1507299ejb.44.2024.01.16.23.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:37:35 -0800 (PST)
Message-ID: <5b39c702-c74e-4cd5-accf-b6b8792e65b2@linaro.org>
Date: Wed, 17 Jan 2024 08:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema
 format
Content-Language: en-US
To: Dharma.B@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lee@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
References: <20240110102535.246177-1-dharma.b@microchip.com>
 <20240110102535.246177-3-dharma.b@microchip.com>
 <683b7838-9c19-4a51-8ec4-90ac8a8a94ce@linaro.org>
 <a59fe94a-feac-439e-a93d-3a90f7d05de5@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a59fe94a-feac-439e-a93d-3a90f7d05de5@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 03:22, Dharma.B@microchip.com wrote:
> Hi Krzysztof,
> On 10/01/24 11:31 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 10/01/2024 11:25, Dharma Balasubiramani wrote:
>>> Convert the atmel,hlcdc binding to DT schema format.
>>>
>>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>>> ---
>>>   .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 106 ++++++++++++++++++
>>>   .../devicetree/bindings/mfd/atmel-hlcdc.txt   |  56 ---------
>>>   2 files changed, 106 insertions(+), 56 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>>> new file mode 100644
>>> index 000000000000..555d6faa9104
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>>
>> This looks not tested, so limited review follows:
> I acknowledge that I didn't test the patches individually. I appreciate 
> your understanding. Taken care in v2.
>>
>>> @@ -0,0 +1,106 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +# Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Atmel's HLCDC (High LCD Controller) MFD driver
>>
>> Drop "MFD driver" and rather describe/name the hardware. MFD is Linux
>> term, so I really doubt that's how this was called.
> Done.
>>
>>> +
>>> +maintainers:
>>> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
>>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>> +
>>> +description: |
>>> +  Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver.
>>
>> Drop
> Done.
>>
>>> +  The HLCDC IP exposes two subdevices:
>>> +  # a PWM chip: see ../pwm/atmel,hlcdc-pwm.yaml
>>> +  # a Display Controller: see ../display/atmel/atmel,hlcdc-dc.yaml
>>
>> Rephrase to describe hardware. Drop redundant paths.
> Sure, I will truncate this to "subdevices: a PWM chip and a display 
> controller." & drop the |.
> 
> I added description about those two subdevices below.

Then why do you still keep there comments? # is a comment.
..

> in v3.
>>
>>> +
>>> +  hlcdc-display-controller:
>>
>> Does anything depend on the name? If not, then just display-controller
> Got an error "'hlcdc-display-controller' does not match any of the 
> regexes: 'pinctrl-[0-9]+'" so I retained it in v2,but as conor advised 
> to have node names generic and we can easily adopt, I will modify it in v3.

That's not a dependency. I was talking about any users of the binding.
User of a binding is for example: Linux kernel driver, other open-source
projects, out-of-tree projects.


Best regards,
Krzysztof


