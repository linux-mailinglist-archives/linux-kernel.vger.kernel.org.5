Return-Path: <linux-kernel+bounces-87195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAEF86D0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BA41C21566
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5170AFD;
	Thu, 29 Feb 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ/AYTEr"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D12E3E1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228481; cv=none; b=nFOD8n6IC5wXTCFif9wXpe0KxTnrmPpYd8F4002NNN/8fs4ykWElacPcYztiI9tyhJeB5bYVnlRvkEZfKhxRFDB57RIJVhxrOjP0tEqNgkIkceTjcsvPAHB3b0+wcfKjx0Jvd8iqVPZhvntNj3kTlTH0WiZGpheJguVQFwYX8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228481; c=relaxed/simple;
	bh=Vt51PLDm+qqwo1+lF7bppptNgSSC5xhHiwCtQY8Hio0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjA8rcBs0z+fCSo7QByX/E/CrBRFxgTABaSa5KXAzG/Lsfpkp/SOEZWnaVfILxfrwrFG/EOcDErEuvvjTh2tW7XUAtKLjRiddFkh9EH53e9SvEqyuLsunkiORJx1PlOyxf+lsJNa08IW7+8YtAgBWnniQJgLC/yf9RH1I/IlqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZ/AYTEr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4429c556efso214183466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709228478; x=1709833278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zytYnRTtQPDtsil9H1JUD4FPmGN5bcMZ2FHwWsum8w=;
        b=qZ/AYTErL0fAi8kwgUKJ3+9FFlsLvI8TcwoiTv2jzPEfJkukqWCGOQ7gRSWFvxMAQr
         kG8X9A8LAlVOx3t+iJuNBVTfXi6Pbb14LJjsUqlByk0OcdEFIiGqaXjqiOsDLFIZQkmI
         Q9PB6n/g3it4KtDNplEIk7VwJezqQlFvnb4yLL2nJCgTc0j2sUGPq8yqh3Yn92/XHUb0
         ED352OciBY2y3htCIc3GPdAvdruy2JrsLWvDhBIIbjIukhK+3qEVEabX6tld54XwOsQN
         1fMW6u9ZIN5esLq5O4NryggcqSgf82LeXawfc0K+xErBYcSn1mxAnu6qvju7OiZRplLu
         xHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228478; x=1709833278;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zytYnRTtQPDtsil9H1JUD4FPmGN5bcMZ2FHwWsum8w=;
        b=ePtDHMs1iWz4PkUC4C5K77H97bV+krvrAOEO+wki5r+TDsHdYaBHj/CydcGTTAG62E
         ik9CEWWwlO+BznoAPKQ2QCJdWHvEp2DuGDpU7r1kmaIM3UUKWEaj5zJDCJpl5/sTIedv
         UeWF+qhrdnAaDUUbDUccPH84d5Gp+TjhpH+DRHQcGchgL4NOWzAYN3I03LFvn6ewe+zS
         cUyng+47JsyxknmwxOTVBhPrd1Wjeszx4ljaO4lBNbI/kADG9oTcq/oLX6Pwz2J79nWx
         3fTvWzvjmflIBxz4YI0QU5CqYFxafwtnHIWOKRTtOLbxDZDjODGlf5P74z5ikq6GznPm
         DWYg==
X-Forwarded-Encrypted: i=1; AJvYcCVii3xHkyqAN46VYOia2MaYv+U2JI+ILn/WBkvpR6v0tQI2Igs09+zAfmUEj30744rkeSa34AQ8po8CNFVairRoBX2mx3Dhb3TBNi3d
X-Gm-Message-State: AOJu0YwGwaehudsnraRDc2dYZ5XnE1NKJguSGcOZCJ1hY0sBK2Vb/Or2
	1hToOB19LfoUTcyP90zzd0ITVDLwvR4rQnyocXKU68QHwv7r5j4hYU3IG0jkBhA=
X-Google-Smtp-Source: AGHT+IH9LRuofxOXA8A09/IC1O0+9Vunzu+NXHqc2+p6uPow0/WmiGba6teKAlj3ud2OyN9mieJygw==
X-Received: by 2002:a17:906:80c4:b0:a43:ff8c:6d9c with SMTP id a4-20020a17090680c400b00a43ff8c6d9cmr2205206ejx.56.1709228477937;
        Thu, 29 Feb 2024 09:41:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id mp20-20020a1709071b1400b00a431488d8efsm888255ejc.160.2024.02.29.09.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:41:17 -0800 (PST)
Message-ID: <44877f61-8f23-4334-90ae-35545c76c1a0@linaro.org>
Date: Thu, 29 Feb 2024 18:41:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: pinctrl: at91-pio4: convert Atmel's PIO4
 bindings to json-schema
Content-Language: en-US
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
 <20240229-pio4-pinctrl-yaml-v1-3-c4d8279c083f@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240229-pio4-pinctrl-yaml-v1-3-c4d8279c083f@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 12:39, Balakrishnan Sambath wrote:
> Convert the existing text DT bindings of Atmel's PIO4 pincontroller to
> yaml based DT schema.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---

Dependency shall be noted here, with lore link.

>  .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  98 ---------------
>  .../bindings/pinctrl/atmel,sama5d2-pinctrl.yaml    | 140 +++++++++++++++++++++
>  2 files changed, 140 insertions(+), 98 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> deleted file mode 100644
> index 774c3c269c40..000000000000
> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> +++ /dev/null
> @@ -1,98 +0,0 @@
> -* Atmel PIO4 Controller

..

> -...
> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.yaml
> new file mode 100644
> index 000000000000..8a2dee1d6dd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/atmel,sama5d2-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PIO4 Controller
> +
> +maintainers:
> +  - Balakrishnan Sambath <balakrishnan.s@microchip.com>
> +
> +description:
> +  The Microchip PIO4 controller is used to select the function of a pin and to
> +  configure it.
> +
> +

One blank line only.

> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sama7g5-pinctrl
> +      - atmel,sama5d2-pinctrl

Keep them alphabetically ordered.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

You need to describe items instead. And why is this flexible?

> +
> +  interrupts:
> +    description:
> +      Interrupt outputs from the controller, one for each bank.

maxItems

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1

Missing blank line.


> +if:

Missing allOf: and then put it how it is in example schema.

> +  properties:
> +    compatible:
> +      contains:
> +        const: microchip,sama7g5-pinctrl
> +then:
> +  patternProperties:
> +    '^.*([-_]default)?$':

No, properties must be defined in top level, not in if:then:. Also
underscore should not be allowed.

> +      anyOf:
> +        - $ref: "#/$defs/mchp-pio4-pincfg-node-1"
> +        - patternProperties:
> +            '^[a-z_-][a-z_-]*$':

Both regexes are way too permissive. Look how other bindings do it.
Usually these are -pins or -group.

> +              $ref: "#/$defs/mchp-pio4-pincfg-node-1"
> +else:
> +  patternProperties:
> +    '^.*([-_]default)?$':
> +      anyOf:
> +        - $ref: "#/$defs/mchp-pio4-pincfg-node-2"
> +        - patternProperties:
> +            '^[a-z_-][a-z_-]*$':
> +              $ref: "#/$defs/mchp-pio4-pincfg-node-2"
> +
> +$defs:
> +  mchp-pio4-pincfg-node-1:
> +    $ref: pincfg-node.yaml#properties
> +    properties:
> +      pinmux:
> +        $ref: pinmux-node.yaml#/properties/pinmux
> +      atmel,drive-strength:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +    required:
> +      - pinmux
> +
> +  mchp-pio4-pincfg-node-2:
> +    $ref: pincfg-node.yaml#properties
> +    properties:
> +      pinmux:
> +        $ref: pinmux-node.yaml#/properties/pinmux
> +    required:
> +      - pinmux
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +unevaluatedProperties: false

Nope, this must be additionalProperties: false. If you put here
unevaluated, it's a sign you define properties not in correct spot.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
> +
> +    pinctrl@fc038000 {
> +        compatible = "atmel,sama5d2-pinctrl";
> +        reg = <0xfc038000 0x600>;
> +        interrupts = <18 IRQ_TYPE_LEVEL_HIGH 7>,
> +                     <68 IRQ_TYPE_LEVEL_HIGH 7>,
> +                     <69 IRQ_TYPE_LEVEL_HIGH 7>,
> +                     <70 IRQ_TYPE_LEVEL_HIGH 7>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        clocks = <&pioA_clk>;
> +
> +        pinctrl_i2c0_default: i2c0_default {

Underscores are not allowed. Please open DTS coding style. Or test your
DTS with W=2.



Best regards,
Krzysztof


