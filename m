Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016C7FAB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjK0USQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjK0USO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:18:14 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51C1BD;
        Mon, 27 Nov 2023 12:18:20 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58d533268e6so1474058eaf.1;
        Mon, 27 Nov 2023 12:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116300; x=1701721100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bENZaIEkpJYeXQb3obhDaVX2IagyhGDLjLt3ZYuJ/ok=;
        b=eEriZf4yxFKnEDzKUsRMOkZH1KtOYZK5c8ck34FAuirqZlDdGgKr4ONWT93mx0PRIN
         fljO8mEFLVjlzf8ZJ8R4wbGTsCOIOFk8NmTgZdJb1syq29RqnOwIf3SBNsPLWUONcdP0
         AqelDIFwLN2IfE3K22VTXBrTwf8/6eRboOjM7jR3p57BJlsK5NsT50s4WwlZx6CwcESX
         ayEFQpBquRHB7moPNvfG+MLo9gFUdEJAFNQO6SRReyOyX3BSlaQ2J4NJW8inu6vEORom
         H6tWVxoThKx/31jWZhbegJbB0Mw4UW2eJrBdCzydGDfsocgKA5lXugwsaEF2ay6Qj9X7
         u28Q==
X-Gm-Message-State: AOJu0Yy9b8f1BvMoxRHU5F0cllo385xHe5nTTQxJu0CyOz71A5SizQ0s
        4PzS4sh3WQxvloK2Utyojw==
X-Google-Smtp-Source: AGHT+IFIzZ++vKtHlOgq7ThtESTzfXnpNg+vniSqQtFwqwxLBYUrKmp3ByScpp7i4/Z7fRvKpCna2A==
X-Received: by 2002:a05:6820:827:b0:58d:974b:5056 with SMTP id bg39-20020a056820082700b0058d974b5056mr3811141oob.1.1701116299998;
        Mon, 27 Nov 2023 12:18:19 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u188-20020a4a57c5000000b0058d1de21893sm990011ooa.24.2023.11.27.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:18:19 -0800 (PST)
Received: (nullmailer pid 3044125 invoked by uid 1000);
        Mon, 27 Nov 2023 20:18:18 -0000
Date:   Mon, 27 Nov 2023 14:18:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/39] dt-bindings: soc: Add Cirrus EP93xx
Message-ID: <20231127201818.GA2966449-robh@kernel.org>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-6-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-6-d59a76d5df29@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:44AM +0300, Nikita Shubin wrote:
> Add device tree bindings for the Cirrus Logic EP93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/arm/cirrus/cirrus,ep9301.yaml         | 38 ++++++++++

>  .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  | 83 ++++++++++++++++++++++
>  include/dt-bindings/soc/cirrus,ep9301-syscon.h     | 46 ++++++++++++

This looks like it is mostly clocks. I'd put it in bindings/clock/ and 
include/dt-bindings/clock/ instead.

>  3 files changed, 167 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
> new file mode 100644
> index 000000000000..97dd8b6aefa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cirrus/cirrus,ep9301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx platforms
> +
> +description:
> +  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: The TS-7250 is a compact, full-featured Single Board Computer (SBC)
> +          based upon the Cirrus EP9302 ARM9 CPU

Wrap lines at 80 unless there's some advantage to going to 100. Here 
there is not.

> +        items:
> +          - const: technologic,ts7250
> +          - const: cirrus,ep9301
> +
> +      - description: The Liebherr BK3 is a derivate from ts7250 board
> +        items:
> +          - const: liebherr,bk3
> +          - const: cirrus,ep9301
> +
> +      - description: EDB302 is an evaluation board by Cirrus Logic,
> +          based on a Cirrus Logic EP9302 CPU
> +        items:
> +          - const: cirrus,edb9302
> +          - const: cirrus,ep9301
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
> new file mode 100644
> index 000000000000..283cf2386d95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/cirrus/cirrus,ep9301-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Platforms System Controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-syscon
> +              - cirrus,ep9307-syscon
> +              - cirrus,ep9312-syscon
> +              - cirrus,ep9315-syscon

The registers of these are all the same as (or a superset of) the 
EP9301? That's what you are claiming. Perhaps already discussed, but 
there's no blurb here to explain the relationship.

'syscon' is a Linux term. Is this block really called this?

> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd

Doesn't look like an simple-mfd to me. You don't have independent child 
blocks which don't depend on the parent node.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +
> +patternProperties:
> +  '^pins-':
> +    type: object
> +    description: pin node
> +    $ref: /schemas/pinctrl/pinmux-node.yaml
> +
> +    properties:
> +      function:
> +        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]
> +
> +      groups:
> +        enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
> +                gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
> +                rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp ]
> +
> +    required:
> +      - function
> +      - groups
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@80930000 {
> +      compatible = "cirrus,ep9301-syscon",
> +                   "syscon", "simple-mfd";
> +      reg = <0x80930000 0x1000>;
> +
> +      #clock-cells = <1>;
> +      clocks = <&xtali>;
> +
> +      spi_default_pins: pins-spi {
> +        function = "spi";
> +        groups = "ssp";
> +      };
> +    };
> diff --git a/include/dt-bindings/soc/cirrus,ep9301-syscon.h b/include/dt-bindings/soc/cirrus,ep9301-syscon.h
> new file mode 100644
> index 000000000000..6bb8f532e7d0
> --- /dev/null
> +++ b/include/dt-bindings/soc/cirrus,ep9301-syscon.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> +#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> +
> +#define EP93XX_CLK_PLL1		0
> +#define EP93XX_CLK_PLL2		1
> +
> +#define EP93XX_CLK_FCLK		2
> +#define EP93XX_CLK_HCLK		3
> +#define EP93XX_CLK_PCLK		4
> +
> +#define EP93XX_CLK_UART		5
> +#define EP93XX_CLK_SPI		6
> +#define EP93XX_CLK_PWM		7
> +#define EP93XX_CLK_USB		8
> +
> +#define EP93XX_CLK_M2M0		9
> +#define EP93XX_CLK_M2M1		10
> +
> +#define EP93XX_CLK_M2P0		11
> +#define EP93XX_CLK_M2P1		12
> +#define EP93XX_CLK_M2P2		13
> +#define EP93XX_CLK_M2P3		14
> +#define EP93XX_CLK_M2P4		15
> +#define EP93XX_CLK_M2P5		16
> +#define EP93XX_CLK_M2P6		17
> +#define EP93XX_CLK_M2P7		18
> +#define EP93XX_CLK_M2P8		19
> +#define EP93XX_CLK_M2P9		20
> +
> +#define EP93XX_CLK_UART1	21
> +#define EP93XX_CLK_UART2	22
> +#define EP93XX_CLK_UART3	23
> +
> +#define EP93XX_CLK_ADC		24
> +#define EP93XX_CLK_ADC_EN	25
> +
> +#define EP93XX_CLK_KEYPAD	26
> +
> +#define EP93XX_CLK_VIDEO	27
> +
> +#define EP93XX_CLK_I2S_MCLK	28
> +#define EP93XX_CLK_I2S_SCLK	29
> +#define EP93XX_CLK_I2S_LRCLK	30
> +
> +#endif /* DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H */
> 
> -- 
> 2.41.0
> 
