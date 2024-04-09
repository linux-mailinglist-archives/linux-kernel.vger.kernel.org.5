Return-Path: <linux-kernel+bounces-137320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4A189E060
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C9128DD35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8613E400;
	Tue,  9 Apr 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI8L30wi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7213E3F2;
	Tue,  9 Apr 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680202; cv=none; b=IgTp4TKyo6HDEp6QkZ02ivVvyL1X/DKeE5yOulLiYtXdXZZJY2VJ33nRxfim+4TLvChJ6CGOGLvkNM9BP+ACE5C7FVnktF+bIybcf+eQ820KBrErOGF2UpLlnsMJKCpRR1R0huMOStmsgkKGfGzMeb6+v/C5IALWC3U75UhvNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680202; c=relaxed/simple;
	bh=sqluHhiDFTvPVAtAz82cjsGRqtZJ0+0bxToUl7j52aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUqurf3Nz+7BMMaxajnICijj85Z+1vn65uK7IpOSpXhb0vC71mOk6q0yVfmIAQDb/S3QbdttaYlJFpqgMSgD3w7o4x/gPUVwNAqnkK/4IY9xF4qOL+GN3Alhw1P/nZVzv8KruiW+FqjUxH0eR5QGRZklRbjmCzdidutaoYdlOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI8L30wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C948FC433C7;
	Tue,  9 Apr 2024 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712680202;
	bh=sqluHhiDFTvPVAtAz82cjsGRqtZJ0+0bxToUl7j52aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WI8L30wi8+cPsQ6t6sJvESP3xYGy3z94xyR0hDTjzF51FDi+hyftf0KHT1sdnz/E/
	 Al/MCkZqa3cUfRwvHPauc0pM8XyTmcB8mSBRcKyAMvF0qwUngqU93+RiiC+GjBnZDU
	 /+/DVYHh91an/ZtxGP+zyRObpJQP+vDgXvEcqLZc4BfyodxH+2KTtlGZd5k3ajgd59
	 drm0WCZ8NkEDBzYC1dYz3BmzNwpAgNGapY4faSK+LIkeB7IazpJcJ1plTH2+WAoW7A
	 jiLORtsazrRCL9eC8WeTBbHTMZw5h7Wak8bKbuMpClwqbPpN09D6kgsEvGkaEEQ0HE
	 gDz6pq0QXmoRg==
Date: Tue, 9 Apr 2024 11:29:59 -0500
From: Rob Herring <robh@kernel.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com, schung@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Message-ID: <20240409162959.GA1370985-robh@kernel.org>
References: <20240409095637.2135-1-ychuang570808@gmail.com>
 <20240409095637.2135-3-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409095637.2135-3-ychuang570808@gmail.com>

On Tue, Apr 09, 2024 at 09:56:36AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> new file mode 100644
> index 000000000000..8b9ec263213f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 pin control and GPIO
> +
> +maintainers:
> +  - Shan-Chun Hung <schung@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,ma35d1-pinctrl
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  nuvoton,sys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle of the system-management node.

If these are the *only* registers to access the pinctrl functions, then 
this binding should be a child node of the system-management node and 
then you don't need this property.

And if the registers for pinctrl are a defined range, you should add a 
'reg' property (even though Linux and regmap don't use it).

> +
> +  ranges: true

This property makes no sense with the binding as-is. You don't have 
any address to translate. Maybe with the above changes it will.

> +
> +patternProperties:
> +  "^gpio@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      gpio-controller: true
> +
> +      '#gpio-cells':
> +        const: 2
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      interrupt-controller: true
> +
> +      '#interrupt-cells':
> +        const: 2
> +
> +      interrupts:
> +        description:
> +          The interrupt outputs to sysirq.
> +        maxItems: 1
> +
> +    required:
> +      - gpio-controller
> +      - '#gpio-cells'
> +      - reg
> +      - clocks
> +      - interrupt-controller
> +      - '#interrupt-cells'
> +      - interrupts
> +
> +  "^pin-[a-z0-9]+$":
> +    type: object
> +    description:
> +      A pinctrl node should contain at least one subnodes representing the
> +      pinctrl groups available on the machine. Each subnode will list the
> +      pins it needs, and how they should be configured, with regard to muxer
> +      configuration, pullups, drive strength, input enable/disable and input
> +      schmitt.
> +
> +    $ref: pincfg-node.yaml#
> +
> +    properties:
> +      power-source:
> +        description: |
> +          Valid arguments are described as below:
> +          0: power supply of 1.8V
> +          1: power supply of 3.3V
> +        enum: [0, 1]
> +
> +      drive-strength-microamp:
> +        oneOf:
> +          - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
> +            description: 1.8V I/O driving strength
> +          - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 82000 ]
> +            description: 3.3V I/O driving strength
> +
> +    unevaluatedProperties: false

In the indented cases, it's preferred to put this before 'properties'.


> +
> +  "-grp$":
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.

Missing $ref to common properties and 'unevaluatedProperties'.

> +    properties:
> +      nuvoton,pins:
> +        description:
> +          Each entry consists of 4 parameters and represents the mux and config
> +          setting for one pin.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        minItems: 1
> +        items:
> +          items:
> +            - minimum: 0
> +              maximum: 13
> +              description:
> +                Pin bank.
> +            - minimum: 0
> +              maximum: 15
> +              description:
> +                Pin bank index.
> +            - minimum: 0
> +              maximum: 15
> +              description:
> +                Mux 0 means GPIO and mux 1 to 15 means the specific device function.
> +
> +required:
> +  - compatible
> +  - nuvoton,sys
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +    pinctrl@40040000 {
> +        compatible = "nuvoton,ma35d1-pinctrl";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        nuvoton,sys = <&sys>;
> +        ranges = <0 0x40040000 0xc00>;
> +
> +        gpio@0 {
> +            reg = <0x0 0x40>;
> +            interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk GPA_GATE>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        uart-grp {
> +            uart11-pins {

This is not what the schema says.

> +                nuvoton,pins = <11 0 2>,
> +                               <11 1 2>,
> +                               <11 2 2>,
> +                               <11 3 2>;
> +                bias-disable;
> +                power-source = <1>;
> +            };
> +        };

Include a pin-* node in the example.

> +    };
> -- 
> 2.34.1
> 

