Return-Path: <linux-kernel+bounces-69875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C8858FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC841C2116C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68E7AE5A;
	Sat, 17 Feb 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dk1/KLnm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A17A737
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177213; cv=none; b=Fb+YxLxUGikXPAaCZ0NrEcylQeikDIKOUjLckQCAvIDwAAASeOmFQLUfDcFv5wt2QTPg/c4PfQrh60XjEZV5X/YL9lFUGSeMhhSZP5eumRBej0CzUwUvIEfqRmPTQryddKpMquDJdFAjnQDIuxaCr5D2SaSBshiCQ5giEHiTg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177213; c=relaxed/simple;
	bh=ApRmf4hF+UhxtHe1xKf1xdSY/gEUqO8iQK2Z4TdkMFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpcIudKHF5X9vfIyT5Hmsqh0RtLYYWSuptXZbszi7QiRS/c0AQbb/7pKVQxnpvKZe/BjVWFWAHUpkgTEHH+M7c5FByx9h04sCJP2Rz3qPU51B3cVpyq4WTZ+nEUkApv+RK8eExObjeH4wGMRUMDVC2kWX8IdzHBQ9sFUvLEbX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dk1/KLnm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so4059597a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708177210; x=1708782010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGNCofLugqlZyC2Yzss6Pd9EV+Orj4VOX1RB8jZiSMs=;
        b=dk1/KLnmBYyTPlyoyD+NG4+XEFCFCe2ksx7CNeump8gI0LW+izZpbkwrqPRsmINq92
         rus2hSGnoQF8OXnaLwvkFCXywUl8sAhH8efc3/qACDDZFhFQF8ZA2PMKkCPngkIx2eu/
         4G36FaToeEmdtgtWasGPEl+nf7RAyQHYgLDspEIDlL0XekWA4QJYPg/fLHCckrqT7WGf
         +tML7SWylu66dzEWyZp+mPCm5TWQex78db1x7nvfMSocZ6aLJ9vTgm982PrTlZlmazBS
         q4EL/ert9Gws6SeEvpFrOj47Fv8M0dRJRFWkf9WDHMRFxFXFYU9SbFatpY4MSXfbYl9n
         BwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177210; x=1708782010;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGNCofLugqlZyC2Yzss6Pd9EV+Orj4VOX1RB8jZiSMs=;
        b=r+t0Q/FEPfM14TdcJVbmRZxXhwR8wqyE2TZxEm2//Dq99g2FQ79cyFdnjlizlnU1IL
         qj8nQJg/a+4A+C1yCT5YENkdwFWSlKnZpXkW7PE9qBDG8scSCffbBQk59xcGyM5neyPM
         pfCLr9IvFBMrLij8PNfz+XnsHI2RuYEhQhbnuOKPj+GdoNjpnA1ep0ZNtSdGsXH//MGo
         xiWIrnQbZNFyb5UZLz3ieCO9egtUk/i9QVIOtdg2E7fVTUDjwYc/wKXsRcu0M2zB2/R8
         aw7A9HNo3ZwwAzFtk7MKm+UMD1I+lmu3UUlVgLS3V9deKNtXdI0euq2K0Ob1R+KrOJ9W
         8MEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOkgx/Z6rGqrFBSdzXDZ9niuD3DqlwWVVbNQJx4sv1HyHUuqgcKyiG6UmXFQi3tBr0VxBKsR0J1O32s9Uqyw2QjfNkNBlMpHcu+VJU
X-Gm-Message-State: AOJu0YzWutRM15s8GNCQ1jpU8HK4Wswg3IXHqs8ZDOF0jBF5vFs7u+70
	SogFSNKeSUGRSNFIAJNvqcsInm8Lz6BrMztywscZK+kKlgf4ys2q46wvWGAV9uw=
X-Google-Smtp-Source: AGHT+IEyOztav6llDybOLYDtCqnaHRLV4e8V+LlJgdSWOGaV7NM0slYf3+nnJ5AzBI6hArPdUAvYxA==
X-Received: by 2002:aa7:ca4d:0:b0:562:7705:57c8 with SMTP id j13-20020aa7ca4d000000b00562770557c8mr5666282edt.34.1708177209940;
        Sat, 17 Feb 2024 05:40:09 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id bf2-20020a0564021a4200b00562149c7bf4sm892560edb.48.2024.02.17.05.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:40:09 -0800 (PST)
Message-ID: <ed97be2e-4a3d-4be6-9a57-5c77d5fffc9c@linaro.org>
Date: Sat, 17 Feb 2024 14:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
 <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
 <SEZPR06MB69596C83014B1A424F0B376996532@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69596C83014B1A424F0B376996532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2024 14:14, Yang Xiwen wrote:
> On 2/17/2024 6:14 PM, Krzysztof Kozlowski wrote:
>> On 16/02/2024 16:21, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>> compatible lists.
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 115 +++++++++++++++++++++
>>>   .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 -------------
>>>   2 files changed, 115 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>> new file mode 100644
>>> index 000000000000..73256eee10f9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>> @@ -0,0 +1,115 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>> +
>>> +maintainers:
>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    minItems: 1
>> No, why? Compatibles must be fixed/constrained.
> Hi3798CV200 has only the first compatible listed in its device tree. But 
> you are right i can add it to hi3798mv200.dtsi so that `minItems` can be 
> removed
>>
>>> +    items:
>>> +      - enum:
>>> +          - hisilicon,hi3798cv200-usb2-phy
>>> +          - hisilicon,hi3798mv100-usb2-phy
>> This wasn't here before. Not explained in commit msg.
>>
>>> +      - const: hisilicon,inno-usb2-phy
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +    description: |
>> Do not need '|' unless you need to preserve formatting.
>>
>>> +      Should be the address space for PHY configuration register in peripheral
>>> +      controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
>>> +      Or direct MMIO address space.
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +    description: reference clock
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +patternProperties:
>>> +  'phy@[0-9a-f]+':
>>> +    type: object
>>> +    additionalProperties: false
>>> +    description: individual ports provided by INNO PHY
>>> +
>>> +    properties:
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      '#phy-cells':
>>> +        const: 0
>>> +
>>> +      resets:
>>> +        maxItems: 1
>>> +
>>> +    required: [reg, '#phy-cells', resets]
>> One item per line. Look at other bindings or example-schema.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - clocks
>>> +  - reg
>>> +  - '#address-cells'
>>> +  - '#size-cells'
>>> +  - resets
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/histb-clock.h>
>>> +
>>> +    peripheral-controller@8a20000 {
>>> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
>>> +        reg = <0x8a20000 0x1000>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        ranges = <0x0 0x8a20000 0x1000>;
>> Drop the node, not related to this binding. If this binding is supposed
>> to be part of other device in case of MFD devices or some tightly
>> coupled ones, then could be included in the example there.
>>
>>> +
>>> +        usb2-phy@120 {
>>> +            compatible = "hisilicon,hi3798cv200-usb2-phy";
>>> +            reg = <0x120 0x4>;
>>> +            clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
>>> +            resets = <&crg 0xbc 4>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            phy@0 {
>>> +                reg = <0>;
>>> +                #phy-cells = <0>;
>>> +                resets = <&crg 0xbc 8>;
>>> +            };
>>> +
>>> +            phy@1 {
>>> +                reg = <1>;
>>> +                #phy-cells = <0>;
>>> +                resets = <&crg 0xbc 9>;
>>> +            };
>>> +        };
>>> +
>>> +        usb2-phy@124 {
>>> +            compatible = "hisilicon,hi3798cv200-usb2-phy";
>> You can keep only one example, because they are basically the same.
> 
> It is listed here just because cv200 (and the upcoming mv200) actually 
> has two INNO phys in the SoC. And coincidently for both SoCs, one with 
> two ports is wired to USB2 controller(EHCI &OHCI), while the other one 
> with only one port is wired to DWC3 controller. The example here is 
> borrowed directly from hi3798cv200.dtsi.
> 

I see the differences and one difference means they are basically the same.

Best regards,
Krzysztof


