Return-Path: <linux-kernel+bounces-22002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F28297B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E221F24820
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9840C0E;
	Wed, 10 Jan 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JE9ESgpx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE873FB36
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3368ae75082so2804421f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883196; x=1705487996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/CFezntBDwJgvbMFFPYTvlY4ZLvj7+eyQcOr19vwEo=;
        b=JE9ESgpxZLJn4qT+SuuKa52V2MTaWHlSmVxgqTkYYFL2tmyKYsekIcpy57UrTjqxCB
         m7m+bLmNSnrZXiD3zhlPaWBVGSbRQfJuUqYJK8hhasUnueluOwZGGbQ0YiEp0YAMDGnY
         flhoueLpLdCLRIhP4wiZ6v6kvpCQJ/3mBLWaB8yzmrghRhT9wWjUcL1MoK7l9wsayGbV
         YXxP4GQXn5nLgLixBJhzG190qky4LRKnYSsD+MgX3hGvcp9CCzL3hhQod029Xvetuivy
         eeX2s8kdb1q3MzY2qnDYLUzbCW30P77rCiefsdrm5UxWpJxvz/29/GEa6HOCR0DRUT3Y
         T7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883196; x=1705487996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/CFezntBDwJgvbMFFPYTvlY4ZLvj7+eyQcOr19vwEo=;
        b=hPhwY9EJIRow+yLZmIIjqO+IcB2Qgq3dcyq8B4iX1TTbvPOyOIOYFrQD+zz1hPBVus
         604WzDo0ABWB5BNtAKCGiaTiX/j1/CnGkWfp7BAIKdRRTARFJ9kiBHe3yp9VCVOhYhRh
         I/c7KRsd0xvt4ANHiT4fMRLQbYFXVMV50YL66ir02ji08QixKZl31UYZ/Iz1T3D/gf6U
         PzTrF58vYFrSXpMlBlloHvI0HLpI3EWjZUWJCwrER7dDjXscAd8uFqZn0t6tbhzeVtwd
         TqfDzRWojfF9Po+BsnHYoEADTlAgQxcJA92D3YjuJfqdeuBYbAwtFDHb7jp33auATklg
         fluw==
X-Gm-Message-State: AOJu0YxethGmQxMaa+YmOM0Sw5j+jFTHaFiT28vMaRj4s1h6uHilWjTn
	JB8XAwNrWeX6T+gbWNrX/O6vBapym11omg==
X-Google-Smtp-Source: AGHT+IH0Wzhg7u2tUzT4i2vx4fKztU5ylnTcAD7npyuXoDvijwmVpNciQ74UR/q3fQKCC4R1dNNpSg==
X-Received: by 2002:adf:f989:0:b0:336:7db7:aaae with SMTP id f9-20020adff989000000b003367db7aaaemr1044442wrr.8.1704883195934;
        Wed, 10 Jan 2024 02:39:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id c2-20020adfe742000000b003366a9cb0d1sm4549056wrn.92.2024.01.10.02.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 02:39:55 -0800 (PST)
Message-ID: <7110b0a8-5b0c-4817-9432-26528bbbb5a9@linaro.org>
Date: Wed, 10 Jan 2024 11:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>, sam@ravnborg.org,
 bbrezillon@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lee@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
References: <20240110102535.246177-1-dharma.b@microchip.com>
 <20240110102535.246177-2-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110102535.246177-2-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 11:25, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../display/atmel/atmel,hlcdc-dc.yaml         | 133 ++++++++++++++++++
>  .../bindings/display/atmel/hlcdc-dc.txt       |  75 ----------
>  2 files changed, 133 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
> new file mode 100644
> index 000000000000..49ef28646c48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries

What about original copyrights from TXT file? Although conversion is
quite independent, I could imagine some lawyer would call it a
derivative work of original TXT.

If you decide to add explicit copyrights (which anyway I do not
understand why), then please make it signed off by some of your lawyers
to be sure that you really claim that, in respect of other people
copyrights.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/atmel/atmel,hlcdc-dc.yaml#

Filename like compatible.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCDC (High LCD Controller) DRM driver

Driver as Linux driver? Not suitable for bindings, so please drop.

> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description: |
> +  Device-Tree bindings for Atmel's HLCDC DRM driver. The Atmel HLCDC Display

Drop entire first sentence and instead describe hardware.

> +  Controller is a subdevice of the HLCDC MFD device.
> +  # See ../../mfd/atmel,hlcdc.yaml for more details.

Full paths please.

> +
> +properties:
> +  compatible:
> +    const: atmel,hlcdc-display-controller
> +
> +  pinctrl-names:
> +    const: default
> +
> +  pinctrl-0: true

Why do you need these two? Are they really required?

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  port@0:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description:
> +      Output endpoint of the controller, connecting the LCD panel signals.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      reg:
> +        maxItems: 1
> +
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base

Hm, why do you reference endpoint-base? This looks oddly different than
all other bindings for such devices, so please explain why.

> +        unevaluatedProperties: false
> +        description:
> +          Endpoint connecting the LCD panel signals.
> +
> +        properties:
> +          bus-width:
> +            description: |
> +              Any endpoint grandchild node may specify a desired video interface according to
> +              ../../media/video-interfaces.yaml, specifically "bus-width" whose recognized

Drop redundant information. Don't you miss some $ref?


> +              values are <12>, <16>, <18> and <24>, and override any output mode selection
> +              heuristic, forcing "rgb444","rgb565", "rgb666" and "rgb888" respectively.
> +            enum: [ 12, 16, 18, 24 ]
> +
> +additionalProperties: false

This goes after required:

> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +  - compatible
> +  - pinctrl-names
> +  - pinctrl-0
> +  - port@0
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    //Example 1

Drop

> +    hlcdc: hlcdc@f0030000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +      compatible = "atmel,sama5d3-hlcdc";
> +      reg = <0xf0030000 0x2000>;
> +      interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +      clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +      clock-names = "periph_clk","sys_clk", "slow_clk";

This part does not look related... If this is part of other device,
usually it is enough to have just one complete example.

Also, fix coding style - space after ,

> +
> +      hlcdc-display-controller {
> +        compatible = "atmel,hlcdc-display-controller";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <0>;
> +
> +          hlcdc_panel_output: endpoint@0 {
> +            reg = <0>;
> +            remote-endpoint = <&panel_input>;
> +          };
> +        };
> +      };
> +
> +      hlcdc_pwm: hlcdc-pwm {
> +        compatible = "atmel,hlcdc-pwm";

How is this related?

> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_lcd_pwm>;
> +        #pwm-cells = <3>;
> +      };
> +    };
> +  - |
> +    //Example 2 With a video interface override to force rgb565
> +    hlcdc-display-controller {
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;

And how is this? Where is the compatible? Maybe just drop second
example, what are the differences?

Are you sure your Microchip folks reviewed it before?

Best regards,
Krzysztof


