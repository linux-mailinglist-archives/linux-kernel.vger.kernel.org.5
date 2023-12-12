Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9F80E49A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjLLHBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLLHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:01:16 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AC3D1;
        Mon, 11 Dec 2023 23:01:21 -0800 (PST)
Received: from [192.168.0.4] (ip5f5aee94.dynamic.kabel-deutschland.de [95.90.238.148])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E627361E5FE04;
        Tue, 12 Dec 2023 08:00:34 +0100 (CET)
Message-ID: <72fe6f18-e3d7-4c74-9734-01a33dc8e100@molgen.mpg.de>
Date:   Tue, 12 Dec 2023 08:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     Jim Liu <JJLIU0@nuvoton.com>, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Rob Herring <robh@kernel.org>,
        linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231212065147.3475413-1-jim.t90615@gmail.com>
 <20231212065147.3475413-2-jim.t90615@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231212065147.3475413-2-jim.t90615@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jim,


Thank you for your patch.

Am 12.12.23 um 07:51 schrieb Jim Liu:
> Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver
> 
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

As you seem to be employed by Nuvoton, should your company/work email be 
listed somehow, and even be used for the author address?

> ---
> Changes for v9:
>     - no changed
> Changes for v8:
>     - no changed
> Changes for v7:
>     - no changed
> ---
>   .../bindings/gpio/nuvoton,sgpio.yaml          | 86 +++++++++++++++++++
>   1 file changed, 86 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> new file mode 100644
> index 000000000000..84e0dbcb066c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton SGPIO controller
> +
> +maintainers:
> +  - Jim LIU <JJLIU0@nuvoton.com>
> +
> +description: |
> +  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
> +  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595)

s/is combine/combines a/

> +  and parallel to serial IC (HC165), and use APB3 clock to control it.

use*s*

> +  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).

Only one space before the (.

> +  NPCM7xx/NPCM8xx have two sgpio module each module can support up

… modules. Each module …

> +  to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.

1.  Space after the comma.
2.  64 input pin*s

> +  GPIO pins have sequential, First half is gpo and second half is gpi.

have sequential ?.

> +  GPIO pins can be programmed to support the following options
> +  - Support interrupt option for each input port and various interrupt
> +    sensitivity option (level-high, level-low, edge-high, edge-low)

option*s*

> +  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,output-ngpios GPIO lines.
> +    nuvoton,input-ngpios GPIO lines is only for gpi.

s/is/are/

> +    nuvoton,output-ngpios GPIO lines is only for gpo.

s/is/are/

It’d be great if you mentioned the datasheet name and revision in the 
description.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-sgpio
> +      - nuvoton,npcm845-sgpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  nuvoton,input-ngpios:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The numbers of GPIO's exposed. GPIO lines is only for gpi.

s/is/are/

> +    minimum: 0
> +    maximum: 64
> +
> +  nuvoton,output-ngpios:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The numbers of GPIO's exposed. GPIO lines is only for gpo.

s/is/are/

> +    minimum: 0
> +    maximum: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - interrupts
> +  - nuvoton,input-ngpios
> +  - nuvoton,output-ngpios
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    gpio8: gpio@101000 {
> +        compatible = "nuvoton,npcm750-sgpio";
> +        reg = <0x101000 0x200>;
> +        clocks = <&clk NPCM7XX_CLK_APB3>;
> +        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        nuvoton,input-ngpios = <64>;
> +        nuvoton,output-ngpios = <64>;
> +    };

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul Menzel
