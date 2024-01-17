Return-Path: <linux-kernel+bounces-28901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51924830465
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD9D287C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2921DDC8;
	Wed, 17 Jan 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SX7pIKLW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA761DDCD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490282; cv=none; b=H3cAdXvyV4VrQ+MOQTPxqmEdw1WAKJLLTzg96hbs7R3Uk0AbJSO8HaumllawTa6URQkx3Ev+RIzl8rC9HXUbdbhNTAPUwo6Is32aKFLgduH2gWPulJyTYkOyuGt6Wz70Wb3VY21A7NNcZyf9gW11CzAVLskOOYvyS8GOmokh/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490282; c=relaxed/simple;
	bh=QRDKON7BGWmqtF99+d9BGwKh8O6Emw8WrlF7c0fsO9E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=lC+ilXAzvE/mCEEJulrklXUDfX3qlqdxnOT8G+9aqhXxryeypOf5s3lJtZcKbM3FtmSyjr6C8Z88RiCJF60W13K+flP6G+H8Qpr/74KDoBHriRQzAx7V1KeobTWhVVklm6EZemselXEzTCw5P4Lj8I6YoZGB8+H0CH44FrJkZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SX7pIKLW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a277339dcf4so1220157666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705490279; x=1706095079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0p59CgV1xC8KsfSCLQYYUuKamfvRchHMY3FNpvGi04=;
        b=SX7pIKLWD8PW12h1+WBYI3juFlQOWXIFcy5q0idohiaGLFhMxkusuayZrVSKbdEpK2
         9RymUiVnfU/tD/l1n7B2Iukzo1UYl3FGpEAbTcGeNkpnO834QNVt8SOr4MpRL9gUIUKM
         z/y9rkjS3YbjTwvzKTTv4tpARdicbjADDF7umCN2rbd44svMEoXEa2DMQpLkkL4ohGTO
         mYUuiPjgrqsiBV7Y9ubPDg0JQEKut+2beNDrEVUQj37rApAarrxKV273LZ2ONJCmq8iP
         Nkbu7IPNZ2c82ZHO5Kjz9rsM83REC8QJjv/LYy1afW88xmpdRbFF6fguw2cNXjbS7Pzw
         w1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705490279; x=1706095079;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0p59CgV1xC8KsfSCLQYYUuKamfvRchHMY3FNpvGi04=;
        b=VCIPGfVmQCGcMPKmLv2BkqbUvHyiqn7B3n7V/Vg9ZWoa6cGRq37ot4WVZ99Cx/p5+G
         6sv/6fx+qD4C8PfaQczIjBtO2ySaj93gwp3LLynt0Du2l63uxGVY0H2GvLFZBulT2yfz
         aZtxrv3mQDCjEcomoR3WM8d8K/5YPngXyAtz/mASO8NQhppOOencV4FTF3G4MHHAMBVp
         aMrk41rtugwmpFvDjz+/3R9Mc3hFVOAlimNASWr+yW8cFYBRtIeN4gQVTDA92blfvpp+
         YRMXvfK0vDWEJx9wK6NJi+xtxJ5sFRutJzfKSyIgZbSA2m6pVKsZxI3uQ51IASjntB9d
         KpfA==
X-Gm-Message-State: AOJu0YxSnDQbfxuVrG6vfSCrLL6jsqlVh7Mi6TmqHfVGJrUbeVwroC6s
	/nHd9E/kdy9r7hNZgZV2yzCTVZELpmzxIg==
X-Google-Smtp-Source: AGHT+IGfwFmtbWsAl5I6/i2SFbfFEUTT/dErh+wL86Joc4LmMwfAO7uAOJEVXsXdHCwicNJjh+JXFg==
X-Received: by 2002:a17:907:9515:b0:a28:88d6:5d9c with SMTP id ew21-20020a170907951500b00a2888d65d9cmr3939094ejc.131.1705490278807;
        Wed, 17 Jan 2024 03:17:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906c20f00b00a2ae7fb3fc6sm7707654ejz.93.2024.01.17.03.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 03:17:58 -0800 (PST)
Message-ID: <90bdc95f-c4a7-40c8-aa55-e4460a4ce9dd@linaro.org>
Date: Wed, 17 Jan 2024 12:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: PCI: ti,j721e-pci-*: Fix check for
 num-lanes
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, afd@ti.com, srk@ti.com
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-2-s-vadapalli@ti.com>
 <28fd561a-7c13-48dc-9995-230dc758f257@linaro.org>
 <a25ea57b-4529-4a4c-9e0b-ccd85b0457d6@ti.com>
 <bd3e809f-5d97-428f-9387-a2475c4f0d7d@linaro.org>
 <ef9a7718-039c-4eef-915d-c96778d70a0f@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ef9a7718-039c-4eef-915d-c96778d70a0f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 12:11, Siddharth Vadapalli wrote:
> 
> 
> On 17/01/24 16:23, Krzysztof Kozlowski wrote:
>> On 17/01/2024 11:47, Siddharth Vadapalli wrote:
>>> Hello Krzysztof,
>>>
>>> On 17/01/24 16:04, Krzysztof Kozlowski wrote:
>>>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>>>> The existing implementation for validating the "num-lanes" property
>>>>> based on the compatible(s) doesn't enforce it. Fix it by updating the
>>>>> checks to handle both single-compatible and multi-compatible cases.
>>>>>
>>>>> Fixes: b3ba0f6e82cb ("dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes")
>>>>> Fixes: adc14d44d7cb ("dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings")
>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>> ---
>>>>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 26 ++++++++++++++-----
>>>>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 26 ++++++++++++++-----
>>>>>  2 files changed, 38 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>>>> index 97f2579ea908..278e0892f8ac 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>>>> @@ -68,8 +68,9 @@ allOf:
>>>>>    - if:
>>>>>        properties:
>>>>>          compatible:
>>>>
>>>> Missing contains:, instead of your change.
>>>
>>> I did try the "contains" approach before determining that the implementation in
>>> this patch is more suitable. Please consider the following:
>>>
>>> For AM64 SoC the primary compatible is "ti,am64-pcie-ep" and fallback compatible
>>> is "ti,j721e-pcie-ep". For J7200 SoC the primary compatible is
>>> "ti,j7200-pcie-ep" while the fallback compatible is again "ti,j721e-pcie-ep".
>>>
>>> Therefore, the device-tree nodes for AM64 and J7200 look like:
>>>
>>> AM64:
>>>     compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
>>>     ...
>>>     num-lanes = 1;
>>>
>>> J7200:
>>>     compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
>>>     ...
>>>     num-lanes = 4;
>>>
>>> This implies that when the check for "num-lanes" is performed on the device-tree
>>> node for PCIe in J7200, the fallback compatible of "ti,j721e-pcie-ep" within the
>>> AM64's "compatible: contains:" check will match the schema and it will check the
>>> existing "num-lanes" being described as "const: 1" against the value in J7200's
>>> PCIe node resulting in a warning. 
>>
>> What warning? What did you put to contains?
> 
> The warning is:
> num-lanes: expected value is 1
> which it has determined due to the presence of "ti,j721e-pcie-ep" in the first
> check which is only applicable to AM64. The shared fallback compatible here is
> responsible for incorrect checks when using "contains".
> 
> Using "contains", the check for "num-lanes" with "const: 1" corresponding to
> AM64 ends up validating against the device-tree node for J7200 since the
> fallback compatible "ti,j721e-pcie-ep" is "contained" in the list of compatibles

Why do you put fallback to contains? It does not make sense. You want to
check for containing the device compatible.

> present in the device-tree node. That shouldn't be the case which is why "items"
> is used in this patch to get an exact match.
> 
>>
>>> Therefore, using "contains" will result in
>>> errors if the check has to be performed for device-tree nodes with fallback
>>> compatibles. The "items" based approach I have used in this patch ensures that
>>> the schema matches *only* when both the primary and fallback compatible are
>>> present in the device-tree node.
>>
>> Long message, but I don't understand it. Why this binding is different
>> than all others which rely on contains?
> 
> This binding is different because of the existence of a shared fallback

Many other bindings are the same.

> compatible and a shared property being evaluated. In other bindings which use
> contains, either there isn't a shared fallback compatible, or the property which

No, we do not talk about such bindings. We talk about fallbacks. Using
contains for other cases is redundant, so why even bringing them up here?

> is present in device-tree nodes which have the shared fallback compatible isn't
> evaluated.>
> In brief, with the existing device-tree, without any changes, adding "contains"
> will throw warnings due to the incorrect schema matching for validating the
> "num-lanes" property.

? What?
> 
>>
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          items:
>>>>> +            - const: ti,j784s4-pcie-ep
>>>>
>>>> Why? Previous code was correct.
>>>
>>> Though I used "patience diff", for some reason the addition of
>>> "ti,j721e-pcie-ep" in the check has been treated as the removal of
>>> "ti,j784s4-pcie-ep" first followed by adding the same later for generating the
>>> diff in this patch. The diff above is equivalent to the addition of:
>>
>> No, why do you change existing code? It is correct.
> 
> Either a "contains" or an "items" is required to evaluate the "num-lanes"
> property and neither of them are present in the existing code.

No, it's not. Your code is equivalent to old handling of j784s4.
Contains is totally irrelevant here.

NAK.

Best regards,
Krzysztof


