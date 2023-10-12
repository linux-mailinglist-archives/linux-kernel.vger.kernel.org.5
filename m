Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354DE7C771D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442477AbjJLTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442490AbjJLTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:41:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7037DC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:41:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d569e73acso1275968f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697139681; x=1697744481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wgpeFdv2HfH35FWvjAPXJBapYWy7YrOOF1gDlYaHWk=;
        b=VwSh40EF0IkfBrNiBohy223KONyqQ9sWL5bO5RROD5qWYZFNo+KwJwrvH57nbDriZd
         8FDjd55KFM9NLAmOyp1RqyrVQYul/rDN/usqysc192Jt6TUZkPGKStrgs4g/7RzDWJOw
         9dWlaNbE1Z7PEbbKEQ1h2ERM46QE7bEyvx+/Z0miJb6ouLxYlv/wraItUJUOsLXdrNjf
         NiASXL8JH/g2gppL+oQ3OJCAmn96TTmODElI9o19XCBljEpWIz/Ln+1g5If7+HzgCCoA
         SypYQhOFiUFKqlc3rv19J5BVi1Wt9jYjPYSEcvOCYiHLYA9RT4sB02xUvwhUgEzcjz6k
         yZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139681; x=1697744481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wgpeFdv2HfH35FWvjAPXJBapYWy7YrOOF1gDlYaHWk=;
        b=cYPzB3brItwziVl4zkLICpy6KjItFL0hsm4O/L36/DKmZf4S7QH3KH8g/Im6DrW0MO
         +NP4YgcLBxi5aICx8RYkChoo2mS+jmPDQ90qZdiOKAsQbyEIhFtYFvvXZSe0V+awHCAv
         v1GFTi2+ny8BckY/gSpNwLtRPqPpTFUYJTkjzlRd/9g0KKenhBDhlHgCDdEAnBdgdXez
         EGsqx30XZ5quOtIdKp24Rj8lz512q7yJet60a+iXYNZgeixavBtRnNjMfMLb3Q7GXUu9
         o56zyYCTnfb76yYqtqkVHsEzMxBQy79j1rzx/8VlPsfenQhguVTc0UTbG3b/lcbVaWt1
         Dxng==
X-Gm-Message-State: AOJu0YzMdYN+hk1rlJtk9tOXk9WI5jvG+ZljoIDyqQUXSP/JEzqcNV9R
        ULEXlA7l6NqE1oBLbjsqC3nLUw==
X-Google-Smtp-Source: AGHT+IGf4B+HUj0U5ncSLbqyNABJe7JvinG0PwVugzcmOfiB+7m4r60TLM4JXV8GHBya9Zu/idyYIQ==
X-Received: by 2002:a5d:6daf:0:b0:32d:62e7:8ff9 with SMTP id u15-20020a5d6daf000000b0032d62e78ff9mr9125125wrs.34.1697139680871;
        Thu, 12 Oct 2023 12:41:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b00405ee9dc69esm625824wmj.18.2023.10.12.12.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 12:41:20 -0700 (PDT)
Message-ID: <7800b2d6-33c4-4c4f-8d0c-c11ff0e47535@linaro.org>
Date:   Thu, 12 Oct 2023 21:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-3-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231011090510.114476-3-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 11:05, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for nuvoton ma35d1 pinctrl, that gets shared
> between the pin control driver and pin configuration in the dts.
> 
> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 180 ++++++++++++++++++
>  include/dt-bindings/pinctrl/ma35d1-pinfunc.h  |  38 ++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/ma35d1-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> new file mode 100644
> index 000000000000..0ddedbad4b78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> @@ -0,0 +1,180 @@
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
> +    description:
> +      phandle to the syscon node

sys is quite generic. Description explains nothing except duplicating
known information. Drop duplicated info and instead explain to what this
phandle points and how it is going to be used.


> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1

So just phandle, not phandle-array, unless it is defined like this in
some other binding.

> +
> +  ranges: true
> +
> +allOf:
> +  - $ref: pinctrl.yaml#

allOf: goes after required: block.

> +
> +patternProperties:
> +  "gpio[a-n]@[0-9a-f]+$":

^gpio@[0-9a-f]+$":


> +    type: object
> +    additionalProperties: false
> +    properties:
> +

Drop blank line

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
> +      - reg
> +      - interrupts
> +      - interrupt-controller
> +      - '#interrupt-cells'
> +      - gpio-controller
> +      - '#gpio-cells'

Keep the same order as in list of properties.

> +
> +  "pcfg-[a-z0-9-.]+$":

Why using different naming than other Nuvoton SoCs? You also accept
"foobarpcfg-1", which does not look intentional.


> +    type: object
> +    description:
> +      A pinctrl node should contain at least one subnodes representing the
> +      pinctrl groups available on the machine. Each subnode will list the
> +      pins it needs, and how they should be configured, with regard to muxer
> +      configuration, pullups, drive strength, input enable/disable and input
> +      schmitt.
> +
> +    allOf:
> +      - $ref: pincfg-node.yaml#

missing additional/unevaluatedProperties: false.

> +
> +    properties:
> +      bias-disable: true

Why do you need this and other ones?

> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      drive-strength:
> +        minimum: 0

0 mA? Is it really valid? Are you sure you used correct property?


> +        maximum: 7
> +
> +      input-enable: true
> +
> +      input-schmitt-enable: true
> +
> +      power-source:
> +        description:
> +          I/O voltage in millivolt.
> +        enum: [ 1800, 3300 ]

Missing units in property name. power-source also does not really
describe the property.

> +
> +additionalProperties:
> +  type: object
> +  additionalProperties:
> +    type: object

Wait, what? What are you describing here?

> +    properties:
> +      nuvoton,pin:
> +        description:
> +          Each entry consists of 4 parameters and represents the mux and config
> +          setting for one pin.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        minItems: 1
> +        items:
> +          items:
> +            - minimum: 0x80
> +              maximum: 0xec
> +              description:
> +                The pinctrl register offset in syscon registers.
> +            - minimum: 0
> +              maximum: 30
> +              description:
> +                The bit offset in the pinctrl register.
> +            - minimum: 0
> +              maximum: 15
> +              description:
> +                The multi-function pin value.
> +            - description:
> +                The phandle of a node contains the generic pinconfig options
> +                to use as described in pinctrl-bindings.txt.
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
> +
> +    pinctrl@40040000 {
> +        compatible = "nuvoton,ma35d1-pinctrl";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        nuvoton,sys = <&sys>;
> +        ranges = <0 0x40040000 0xc00>;
> +
> +        gpioa@40040000 {
> +                reg = <0x0 0x40>;
> +                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&clk GPA_GATE>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +        };
> +
> +        pcfg_default: pcfg-default {
> +                slew-rate = <0>;
> +                input-schmitt-disable;
> +                bias-disable;
> +                power-source = <3300>;
> +                drive-strength = <0>;

Really 0 mA?

Why this is so incomplete?

> +        };
> +    };
> +
> +    pinctrl {> +        uart13 {
> +                pinctrl_uart13: uart13grp {

According to your bindings this does not belong here.

> +                        nuvoton,pins =
> +                                <MA35_SYS_REG_GPH_H 24 2 &pcfg_default>,
> +                                <MA35_SYS_REG_GPH_H 28 2 &pcfg_default>;
> +                };
> +        };
> +    };
> +
> +    serial@407d0000 {

Drop node, not related at all.

> +        compatible = "nuvoton,ma35d1-uart";
> +        reg = <0x407d0000 0x100>;
> +        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk UART13_GATE>;
> +        pinctrl-0 = <&pinctrl_uart13>;
> +    };
> diff --git a/include/dt-bindings/pinctrl/ma35d1-pinfunc.h b/include/dt-bindings/pinctrl/ma35d1-pinfunc.h
> new file mode 100644
> index 000000000000..a2609d466dc9
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/ma35d1-pinfunc.h

Filename matching bindings. The same name.

> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2023 Nuvoton Technologies.
> + */
> +
> +#ifndef __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H
> +#define __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H
> +
> +#define MA35_SYS_REG_GPA_L	0x80

Registry addresses are not suitable for bindings. There is also no need
to have REG address in the binding. Drop entire file.

Best regards,
Krzysztof

