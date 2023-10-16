Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811077C9E44
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjJPEcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJPEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:32:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC8FD9;
        Sun, 15 Oct 2023 21:32:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5c91bec75so25548185ad.3;
        Sun, 15 Oct 2023 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697430738; x=1698035538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UCFhBDvZjaXYckEiQSf07sabqV40haEdrThyu2LHxJk=;
        b=bnEkZByCoi9CMYO3etNhiBW4S07RVLZq0/zN1D61rfSt5xPR45k58Z95aA/k4WWvSE
         1A1AvwGtr0tY7CQEylbEOruoJ9o5qv5t4spS/9jU+c7NUa0pyYUWUsEmA8XHTad35SDf
         I0F0lJAh5jcoa+x2NWpu+u0j/pymylRT9/AOIsuTXMCmXGsZxTgpzqPUrGYsaTdBnuOb
         yhvqfVpE3nzUW9SIwks4/QH8Y0IsaMrvMfHPTulabJ3cGQd1Vxr7bjzeRi/Zit90iGFL
         YuUeaGX4SOijq3bRTUGqnQFfcJhldWA6pTgUKf/samXL8oSM1pCY00BuL7SrcEKDZVjt
         7l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697430738; x=1698035538;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCFhBDvZjaXYckEiQSf07sabqV40haEdrThyu2LHxJk=;
        b=ex5SPqgLbFXOQqQwLyoLWhs6UfjCVlXcZxnsVya4SFbGyBDQLQmX6QToehF8v+xND4
         gCOZY8LpKFZn/GLwWnNJrQ84yQ0Jk/c/q03WRF9WiQ62D50/+NE+KioagUyEp2jdiROO
         0hDi9E0G9ZyEut7trEh9WZdv7z2BiBHiqjGW1s4LsNSSfQi+g13/hWWrhDMyI4bx7YoZ
         uTi1kqVR2DbYWBsYCnHVkXhIYThHEcQpg/eDmViM4jOMvMQoftFSJveNIByHuqCgnKUl
         EAN25eOCRAV3jukAVjJFAqmTyUFC/0itLHHJQlZRvTGHWMafaGA8MTl/651eUHW0vsBw
         Mrcw==
X-Gm-Message-State: AOJu0YxDhGeu8WHOisSjgYQ0t8V7WuwzKvuYJoFMCpzYcpD7WIag2ieZ
        LoGdNN6M1b20eM/1pIeyDEo=
X-Google-Smtp-Source: AGHT+IGMLjXLlV1frys+1PBR1G3La+RmiogYkszbwFdsl9I70A+rIfQZSglO1xAQSf7YYbmnqQsOEQ==
X-Received: by 2002:a17:903:248:b0:1c4:72c9:64fc with SMTP id j8-20020a170903024800b001c472c964fcmr32443185plh.22.1697430737483;
        Sun, 15 Oct 2023 21:32:17 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001bc676df6a9sm7423020plx.132.2023.10.15.21.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 21:32:17 -0700 (PDT)
Message-ID: <17a80031-98bf-48bf-8cea-c0ca4400f142@gmail.com>
Date:   Mon, 16 Oct 2023 12:32:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jacky Huang <ychuang570808@gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-3-ychuang570808@gmail.com>
 <7800b2d6-33c4-4c4f-8d0c-c11ff0e47535@linaro.org>
Content-Language: en-US
In-Reply-To: <7800b2d6-33c4-4c4f-8d0c-c11ff0e47535@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thank you for the review.


On 2023/10/13 上午 03:41, Krzysztof Kozlowski wrote:
> On 11/10/2023 11:05, Jacky Huang wrote:
>> From: Jacky Huang<ychuang3@nuvoton.com>
>>
>> Add the dt-bindings header for nuvoton ma35d1 pinctrl, that gets shared
>> between the pin control driver and pin configuration in the dts.
>>
>> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
>>
>> Signed-off-by: Jacky Huang<ychuang3@nuvoton.com>
>> ---
>>   .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 180 ++++++++++++++++++
>>   include/dt-bindings/pinctrl/ma35d1-pinfunc.h  |  38 ++++
>>   2 files changed, 218 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>>   create mode 100644 include/dt-bindings/pinctrl/ma35d1-pinfunc.h
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..0ddedbad4b78
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
>> @@ -0,0 +1,180 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 pin control and GPIO
>> +
>> +maintainers:
>> +  - Shan-Chun Hung<schung@nuvoton.com>
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
>> +    description:
>> +      phandle to the syscon node
> sys is quite generic. Description explains nothing except duplicating
> known information. Drop duplicated info and instead explain to what this
> phandle points and how it is going to be used.
>
>
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      maxItems: 1
> So just phandle, not phandle-array, unless it is defined like this in
> some other binding.

I would like to update this as:

   nuvoton,sys:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Help pinctrl driver to access system registers by means of regmap.



>> +
>> +  ranges: true
>> +
>> +allOf:
>> +  - $ref: pinctrl.yaml#
> allOf: goes after required: block.

I will fix it.

>> +
>> +patternProperties:
>> +  "gpio[a-n]@[0-9a-f]+$":
> ^gpio@[0-9a-f]+$":

I will fix this, and also fix the dtsi.

>> +    type: object
>> +    additionalProperties: false
>> +    properties:
>> +
> Drop blank line

I will fix it.

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
>> +      - reg
>> +      - interrupts
>> +      - interrupt-controller
>> +      - '#interrupt-cells'
>> +      - gpio-controller
>> +      - '#gpio-cells'
> Keep the same order as in list of properties.

I will fix the order.

>> +
>> +  "pcfg-[a-z0-9-.]+$":
> Why using different naming than other Nuvoton SoCs? You also accept
> "foobarpcfg-1", which does not look intentional.
>

I will use '"^pin-[a-z0-9-.]+$" instead.


>> +    type: object
>> +    description:
>> +      A pinctrl node should contain at least one subnodes representing the
>> +      pinctrl groups available on the machine. Each subnode will list the
>> +      pins it needs, and how they should be configured, with regard to muxer
>> +      configuration, pullups, drive strength, input enable/disable and input
>> +      schmitt.
>> +
>> +    allOf:
>> +      - $ref: pincfg-node.yaml#
> missing additional/unevaluatedProperties: false.

I will add unevaluatedProperties: false.

>> +
>> +    properties:
>> +      bias-disable: true
> Why do you need this and other ones?

We expect the pin configuration to select one of ==>
bias-disable;
bias-pull-down;
bias-pull-up;

This is the same as rockchip,pinctrl.yaml and renesas,rzv2m-pinctrl.yaml.

>> +
>> +      bias-pull-down: true
>> +
>> +      bias-pull-up: true
>> +
>> +      drive-strength:
>> +        minimum: 0
> 0 mA? Is it really valid? Are you sure you used correct property?

We treat this value as the value to be written to the control register, 
not as
a current value in mA. I will correct this mistake.

>> +        maximum: 7
>> +
>> +      input-enable: true
>> +
>> +      input-schmitt-enable: true
>> +
>> +      power-source:
>> +        description:
>> +          I/O voltage in millivolt.
>> +        enum: [ 1800, 3300 ]
> Missing units in property name. power-source also does not really
> describe the property.


The output voltage level of GPIO can be configured as 1.8V or 3.3V,
but I cannot find any suitable output properties in 'pincfg-node.yaml.'
I noticed that 'xlnx,zynq-pinctrl.yaml' and 'xlnx,zynq-pinctrl.yaml' use
'power source' to specify the output voltage.  Should I follow their
approach or define a vendor-specific one?


>> +
>> +additionalProperties:
>> +  type: object
>> +  additionalProperties:
>> +    type: object
> Wait, what? What are you describing here?

I will fix it as:

   "-grp[0-9]$":
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin 
configuration.
       Client device subnodes use below standard properties.
     properties:
       nuvoton,pins:
       ....

and fix the example dts also.

>> +    properties:
>> +      nuvoton,pin:
>> +        description:
>> +          Each entry consists of 4 parameters and represents the mux and config
>> +          setting for one pin.
>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +        minItems: 1
>> +        items:
>> +          items:
>> +            - minimum: 0x80
>> +              maximum: 0xec
>> +              description:
>> +                The pinctrl register offset in syscon registers.
>> +            - minimum: 0
>> +              maximum: 30
>> +              description:
>> +                The bit offset in the pinctrl register.
>> +            - minimum: 0
>> +              maximum: 15
>> +              description:
>> +                The multi-function pin value.
>> +            - description:
>> +                The phandle of a node contains the generic pinconfig options
>> +                to use as described in pinctrl-bindings.txt.
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
>> +
>> +    pinctrl@40040000 {
>> +        compatible = "nuvoton,ma35d1-pinctrl";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        nuvoton,sys = <&sys>;
>> +        ranges = <0 0x40040000 0xc00>;
>> +
>> +        gpioa@40040000 {
>> +                reg = <0x0 0x40>;
>> +                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +                clocks = <&clk GPA_GATE>;
>> +                gpio-controller;
>> +                #gpio-cells = <2>;
>> +                interrupt-controller;
>> +                #interrupt-cells = <2>;
>> +        };
>> +
>> +        pcfg_default: pcfg-default {
>> +                slew-rate = <0>;
>> +                input-schmitt-disable;
>> +                bias-disable;
>> +                power-source = <3300>;
>> +                drive-strength = <0>;
> Really 0 mA?
>
> Why this is so incomplete?

We treat this value as the value to be written to the control register, 
not as
a current value in mA. I will correct this mistake.

>> +        };
>> +    };
>> +
>> +    pinctrl {> +        uart13 {
>> +                pinctrl_uart13: uart13grp {
> According to your bindings this does not belong here.

I will fix.

>> +                        nuvoton,pins =
>> +                                <MA35_SYS_REG_GPH_H 24 2 &pcfg_default>,
>> +                                <MA35_SYS_REG_GPH_H 28 2 &pcfg_default>;
>> +                };
>> +        };
>> +    };
>> +
>> +    serial@407d0000 {
> Drop node, not related at all.

Okay, I will drop this node.

>> +        compatible = "nuvoton,ma35d1-uart";
>> +        reg = <0x407d0000 0x100>;
>> +        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clk UART13_GATE>;
>> +        pinctrl-0 = <&pinctrl_uart13>;
>> +    };
>> diff --git a/include/dt-bindings/pinctrl/ma35d1-pinfunc.h b/include/dt-bindings/pinctrl/ma35d1-pinfunc.h
>> new file mode 100644
>> index 000000000000..a2609d466dc9
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/ma35d1-pinfunc.h
> Filename matching bindings. The same name.
>
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technologies.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H
>> +#define __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H
>> +
>> +#define MA35_SYS_REG_GPA_L	0x80
> Registry addresses are not suitable for bindings. There is also no need
> to have REG address in the binding. Drop entire file.
>
> Best regards,
> Krzysztof
>

I will remove 'ma35d1-pinfunc.h' as it will be useless after the 
'nuvoton,pin' definition changed. Best Regards, Jacky Huang
