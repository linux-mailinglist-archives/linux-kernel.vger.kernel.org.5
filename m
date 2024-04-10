Return-Path: <linux-kernel+bounces-137855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C789E84D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D449282A38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29E8F6C;
	Wed, 10 Apr 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/qTIFgL"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA8944E;
	Wed, 10 Apr 2024 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712717623; cv=none; b=oPQSGUOLZtWT5hEJWUdE26nx4/Jzv4Y+eMV602ZPEiSYyW/KuoKXO0Fr3VEjNSPucsC+4NcLltjbmAI8GIsWv7ooBF1brd/sfKoVL5ZGvS+URVCZp3S+tWydOQognXqfTMDEn3ods4YcrbfaWYJd9RRg2WSe1LOWwtpQ8TdtfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712717623; c=relaxed/simple;
	bh=N/c3s4pXiXjsXe27SCDXhfffr8lRzIuMpLM86eZJMFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQBIz2rtc/mGCt7a4P+XCQbgy1PEJpp55jWmEToQLSmCc6aOuLQO+S9IOzwX70MgDV0IA+5Xo4TS5dk0MC/4vqLyF1yZuMuuJhspwP04rKHpsbtGLtIJj9Z8vmP90/ztN2Oyv5GdlYBZ+QV4UKoI+bsiluuOhMYQWlKIgMF9R1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/qTIFgL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so5046214a12.0;
        Tue, 09 Apr 2024 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712717621; x=1713322421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjb1A/Xpn+Hcv5f9QW3zcd/teDlI874BzDQ8QmIg9YA=;
        b=c/qTIFgLCT48BFsBruOKHZBUdrYqNt0oeF3J1p96Y9NDMKNnVMUOmKCWVrE2Fw3CPB
         ROlDe7Rt4eWvNqQ3wSksYX6LvQvRhAfGa8fH4H8m7YFJyC7jGDS4cwki8ok9yjs+I/7f
         sJDtVTEty5WVsC9SxF5DqVqjOiXTPNzQMDDeDNnrvQpa/5IR4GxsJLoKvgY4RMu7bFJc
         Ob4VTworv9zSK33k+1gJcwpc00ZPTOR9NW45YsZriJU4p2vTHYADaIlB1zNf8xZnysCq
         qTBqVhEUeZvJ5RZ+XYW+q61BYy+QWB+ytTz0WeZ/lhrW2s8aFDk2ZMV/7mj4hEYbFFsI
         RjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712717621; x=1713322421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjb1A/Xpn+Hcv5f9QW3zcd/teDlI874BzDQ8QmIg9YA=;
        b=lHM4tyDSqi5x7dlJQwgJLG7j6XccFyvzdRTXZ4J/Ld9VQ7aIZWg/ht4YovrHCpXh9O
         aSVcHfYeeHImd0JzPXxRJs0JGIcwkvtbwDXZ3+4MCueL56/0T1wvRTYgqJePdhodNVl/
         UEstv6UrDT5E2koIomGyfxkF+18gWvwXlgADXbMrtPXiHg0Jq4lAu6LmDlqx6aX8//BF
         oC0g4OneKbPa2EUoRkhrmGioZrfoauRODbcclNHnqq0ssTy6ciiqqNckI3FLJ9yk+4LO
         PD84kqCVIGWn5OCfbiMJpgevKJs9L1PFmw0r6N5ictKNhBbtX/OmzdLDctVTtb79JnHY
         R97w==
X-Forwarded-Encrypted: i=1; AJvYcCU+DUFC8wNUFzMYM6A4+NSdx2+S0kDPRI2qQEQ6CpOpeipG49C6aXMo/16HjMvCrrYhCxbQA5KgPg7duwQVf7YLJPFacTs04+DG0sQG1z2fLRGNkl1uXMzPHbRyDLFlgj/RYJ6QimilrILHaMCsNsTxv5VTYb3PlN2nOxD8L59FGWDp09c=
X-Gm-Message-State: AOJu0Yw0JgGq1cT0CZfSYD67SBOXTy6FPCLllCvFjJ1RaKmhI/W3yPdU
	xDJaSC7f+8oxux4Uc55FMIc362AqNr8n+EsgLbTSxtfgMLiwfLBU
X-Google-Smtp-Source: AGHT+IHj0IOYvfafmf1cM0QwZPdzZmcJIei4sGG4+PVzX/M0pVSI/HSAipov7jn9IagHKnEoD0iK2Q==
X-Received: by 2002:a17:902:9f96:b0:1e4:30ab:31ca with SMTP id g22-20020a1709029f9600b001e430ab31camr1572325plq.61.1712717620846;
        Tue, 09 Apr 2024 19:53:40 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b001dd82855d47sm9608915plb.265.2024.04.09.19.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 19:53:40 -0700 (PDT)
Message-ID: <fe81e528-998a-4b3f-b3e5-bf10e031d34f@gmail.com>
Date: Wed, 10 Apr 2024 10:53:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
To: Rob Herring <robh@kernel.org>
Cc: linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240409095637.2135-1-ychuang570808@gmail.com>
 <20240409095637.2135-3-ychuang570808@gmail.com>
 <20240409162959.GA1370985-robh@kernel.org>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20240409162959.GA1370985-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Rob,

Thanks for your review.


On 2024/4/10 上午 12:29, Rob Herring wrote:
> On Tue, Apr 09, 2024 at 09:56:36AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 163 ++++++++++++++++++
>>   1 file changed, 163 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..8b9ec263213f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>> @@ -0,0 +1,163 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 pin control and GPIO
>> +
>> +maintainers:
>> +  - Shan-Chun Hung <schung@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +allOf:
>> +  - $ref: pinctrl.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35d1-pinctrl
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle of the system-management node.
> If these are the *only* registers to access the pinctrl functions, then
> this binding should be a child node of the system-management node and
> then you don't need this property.
>
> And if the registers for pinctrl are a defined range, you should add a
> 'reg' property (even though Linux and regmap don't use it).

I will add a 'reg' property for this.

>> +
>> +  ranges: true
> This property makes no sense with the binding as-is. You don't have
> any address to translate. Maybe with the above changes it will.

I will fix the
      ranges = <0 0x40040000 0xc00>;
as
      reg = <0 0x40040000 0xc00>;
      ranges;
>> +
>> +patternProperties:
>> +  "^gpio@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: false
>> +    properties:
>> +      gpio-controller: true
>> +
>> +      '#gpio-cells':
>> +        const: 2
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +      clocks:
>> +        maxItems: 1
>> +
>> +      interrupt-controller: true
>> +
>> +      '#interrupt-cells':
>> +        const: 2
>> +
>> +      interrupts:
>> +        description:
>> +          The interrupt outputs to sysirq.
>> +        maxItems: 1
>> +
>> +    required:
>> +      - gpio-controller
>> +      - '#gpio-cells'
>> +      - reg
>> +      - clocks
>> +      - interrupt-controller
>> +      - '#interrupt-cells'
>> +      - interrupts
>> +
>> +  "^pin-[a-z0-9]+$":
>> +    type: object
>> +    description:
>> +      A pinctrl node should contain at least one subnodes representing the
>> +      pinctrl groups available on the machine. Each subnode will list the
>> +      pins it needs, and how they should be configured, with regard to muxer
>> +      configuration, pullups, drive strength, input enable/disable and input
>> +      schmitt.
>> +
>> +    $ref: pincfg-node.yaml#
>> +
>> +    properties:
>> +      power-source:
>> +        description: |
>> +          Valid arguments are described as below:
>> +          0: power supply of 1.8V
>> +          1: power supply of 3.3V
>> +        enum: [0, 1]
>> +
>> +      drive-strength-microamp:
>> +        oneOf:
>> +          - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
>> +            description: 1.8V I/O driving strength
>> +          - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 82000 ]
>> +            description: 3.3V I/O driving strength
>> +
>> +    unevaluatedProperties: false
> In the indented cases, it's preferred to put this before 'properties'.
>

I will fix it.

>> +
>> +  "-grp$":
>> +    type: object
>> +    description:
>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>> +      Client device subnodes use below standard properties.
> Missing $ref to common properties and 'unevaluatedProperties'.

I will fix it.

>> +    properties:
>> +      nuvoton,pins:
>> +        description:
>> +          Each entry consists of 4 parameters and represents the mux and config
>> +          setting for one pin.
>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +        minItems: 1
>> +        items:
>> +          items:
>> +            - minimum: 0
>> +              maximum: 13
>> +              description:
>> +                Pin bank.
>> +            - minimum: 0
>> +              maximum: 15
>> +              description:
>> +                Pin bank index.
>> +            - minimum: 0
>> +              maximum: 15
>> +              description:
>> +                Mux 0 means GPIO and mux 1 to 15 means the specific device function.
>> +
>> +required:
>> +  - compatible
>> +  - nuvoton,sys
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    pinctrl@40040000 {
>> +        compatible = "nuvoton,ma35d1-pinctrl";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        nuvoton,sys = <&sys>;
>> +        ranges = <0 0x40040000 0xc00>;
>> +
>> +        gpio@0 {
>> +            reg = <0x0 0x40>;
>> +            interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk GPA_GATE>;
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        uart-grp {
>> +            uart11-pins {
> This is not what the schema says.
>> +                nuvoton,pins = <11 0 2>,
>> +                               <11 1 2>,
>> +                               <11 2 2>,
>> +                               <11 3 2>;
>> +                bias-disable;
>> +                power-source = <1>;
>> +            };
>> +        };
> Include a pin-* node in the example.

This is my mistake. "pin-*" was the naming convention used in previous 
versions, which
has now been changed to "-pins". Additionally, its hierarchy should be 
under "-grp".
I will make corrections for these two issues.


>> +    };
>> -- 
>> 2.34.1
>>

Best Regards,
Jacky Huang



