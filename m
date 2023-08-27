Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA3789CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjH0JpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjH0Jop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:44:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD14109;
        Sun, 27 Aug 2023 02:44:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so34386881fa.3;
        Sun, 27 Aug 2023 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693129480; x=1693734280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj+dLh/RT67sXwiclV6iSITHwyxMnYDWSijVM63sCSk=;
        b=LpS/7A3CJg6Yf8jfyuHP+ferwjpkA103vzKIZ9SNK4CgEkEPjfAVcSBXs9/5DJnfoa
         e2dAJCX6dzTNqEaT1IwO7pfgp+KJALeMOziPF9+OXlag6eulkPTgMGk83OJyxn1hanLy
         vQFtFh7yZsdRVHC7SDEyqzy5UpO5MV/BnqDakhKUeMaeCEMtd2oClsANWdb+vWkXssMt
         fHz322lDyDncxWwKvHv335njXr14WelHI6b48JnF/0Gmy7pvCqMRSQ1NiyVhFMn6Jl9k
         P2pEEACqib/lA7SMicPdVBfTL7AO2kqwhVl9cq9DQ/DBf1SRtZCbs//J3CCe2uSyMJ92
         53GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693129480; x=1693734280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hj+dLh/RT67sXwiclV6iSITHwyxMnYDWSijVM63sCSk=;
        b=VjIPJ1KW4E8yEkoGRhNuTKVdrhyYJZoHJ+eTY3udz95ocHHP8e0CmYpw8yoQnbDUZI
         LMTgwq5AvOEbFGaVrz+AUlV6+NNVBqXtFazgqBOegsZ7HkepFaV3EJc6bYGxdGgEeEN7
         a77l6UrmeOQUQROcJFYE3KWQ/p4E/xIhvyRByJgJ0TG9Zq/q8z3/jVi6ZnnzWU5F+rWJ
         eO/RRznBzx2qu9t5KX2HXbeFkLaoRBSL+7ihjSlwiiY8+1NoHIgWy3gGhmkIi33ySDcI
         3XCTFOoKl5f4IV7FpMHo3x8JGicArjF2MG5N3V5XKX31doigo+qk6W51lHIRJkkvDuwW
         RBsA==
X-Gm-Message-State: AOJu0Yz+bI/pm5/KLL7bhgIrZSCE6V5AKo9hSWsOtRTbPO39MDg9Xcyt
        T5U3KH7od+pW6Wfs5Cf+g2TPpqV/18gmfdmCHe0=
X-Google-Smtp-Source: AGHT+IHrQO0FCUQje9LS8EBWQhOyWv6a5KAh+Vz8V2yZmN9/aglwZdeOzrjvnzj2GKa6x2zD1HG+8eusm5eGjLxN7nM=
X-Received: by 2002:a2e:a209:0:b0:2ba:7fc2:cc4c with SMTP id
 h9-20020a2ea209000000b002ba7fc2cc4cmr16272313ljm.24.1693129480204; Sun, 27
 Aug 2023 02:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230809185722.248787-1-tmaimon77@gmail.com> <20230809185722.248787-2-tmaimon77@gmail.com>
 <20230821170941.GA1915730-robh@kernel.org>
In-Reply-To: <20230821170941.GA1915730-robh@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 27 Aug 2023 12:44:28 +0300
Message-ID: <CAP6Zq1i+P8Jh2_G9gJMdtCKcVF6m9vkWAP5rJXBCJ1aNfc2Bvw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl
 and GPIO documentation
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your review

On Mon, 21 Aug 2023 at 20:09, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Aug 09, 2023 at 09:57:21PM +0300, Tomer Maimon wrote:
> > Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> > pinmux and GPIO controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 215 ++++++++++++++++++
> >  1 file changed, 215 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..8a12f5134450
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> > @@ -0,0 +1,215 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM845 Pin Controller and GPIO
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +description:
> > +  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
> > +  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
> > +  and multiple functions that directly connect the pin to different
> > +  hardware blocks.
> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,npcm845-pinctrl
> > +
> > +  ranges:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  nuvoton,sysgcr:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: a phandle to access GCR registers.
> > +
> > +patternProperties:
> > +  '^gpio@':
> > +    type: object
> > +
> > +    description:
> > +      Eight GPIO banks that each contain 32 GPIOs.
> > +
> > +    properties:
> > +      gpio-controller: true
> > +
> > +      '#gpio-cells':
> > +        const: 2
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      gpio-ranges:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - gpio-controller
> > +      - '#gpio-cells'
> > +      - reg
> > +      - interrupts
> > +      - gpio-ranges
> > +
> > +  '-mux$':
> > +    $ref: pinmux-node.yaml#
> > +
> > +    properties:
> > +      groups:
> > +        description:
> > +          One or more groups of pins to mux to a certain function
> > +        items:
> > +          enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> > +                  smb5b, smb5c, lkgpo0, pspi, jm1, jm2, smb4den, smb4b,
> > +                  smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> > +                  smb22, smb23, smb23b, smb4d, smb14, smb5, smb4, smb3,
> > +                  spi0cs1, spi0cs2, spi0cs3, spi1cs0, spi1cs1, spi1cs2,
> > +                  spi1cs3, spi1cs23, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> > +                  bmcuart1, uart2, sg1mdio, bmcuart0b, r1err, r1md, r1oen,
> > +                  r2oen, rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3,
> > +                  fanin4, fanin5, fanin6, fanin7, fanin8, fanin9, fanin10,
> > +                  fanin11, fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2,
> > +                  pwm3, r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg2,
> > +                  ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5, smb0, smb1, smb2,
> > +                  smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
> > +                  sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
> > +                  mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
> > +                  scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
> > +                  spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
> > +                  smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
> > +                  spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
> > +                  hgpio5, hgpio6, hgpio7 ]
> > +
> > +      function:
> > +        description:
> > +          The function that a group of pins is muxed to
> > +        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> > +                smb5b, smb5c, lkgpo0, pspi, jm1, jm2, smb4den, smb4b,
> > +                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> > +                smb22, smb23, smb23b, smb4d, smb14, smb5, smb4, smb3,
> > +                spi0cs1, spi0cs2, spi0cs3, spi1cs0, spi1cs1, spi1cs2,
> > +                spi1cs3, spi1cs23, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> > +                bmcuart1, uart2, sg1mdio, bmcuart0b, r1err, r1md, r1oen,
> > +                r2oen, rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3,
> > +                fanin4, fanin5, fanin6, fanin7, fanin8, fanin9, fanin10,
> > +                fanin11, fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2,
> > +                pwm3, r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg2,
> > +                ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5, smb0, smb1, smb2,
> > +                smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
> > +                sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
> > +                mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
> > +                scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
> > +                spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
> > +                smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
> > +                spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
> > +                hgpio5, hgpio6, hgpio7 ]
> > +
> > +    dependencies:
> > +      groups: [ function ]
> > +      function: [ groups ]
> > +
> > +    additionalProperties: false
> > +
> > +  '^pin':
> > +    $ref: pincfg-node.yaml#
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          A list of pins to configure in certain ways, such as enabling
> > +          debouncing
> > +
> > +      bias-disable: true
> > +
> > +      bias-pull-up: true
> > +
> > +      bias-pull-down: true
> > +
> > +      input-enable: true
> > +
> > +      output-low: true
> > +
> > +      output-high: true
> > +
> > +      drive-push-pull: true
> > +
> > +      drive-open-drain: true
> > +
> > +      input-debounce:
> > +        description:
> > +          Debouncing periods in microseconds, one period per interrupt
> > +          bank found in the controller
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 1
> > +        maxItems: 4
> > +
> > +      slew-rate:
> > +        description: |
> > +          0: Low rate
> > +          1: High rate
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1]
> > +
> > +      drive-strength:
> > +        enum: [ 0, 1, 2, 4, 8, 12 ]
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: pinctrl.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - ranges
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - nuvoton,sysgcr
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pinctrl: pinctrl@f0800260 {
> > +        compatible = "nuvoton,npcm845-pinctrl";
> > +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        nuvoton,sysgcr = <&gcr>;
> > +
> > +        gpio0: gpio@f0010000 {
>
> unit-address should be 0.
>
> Otherwise,
The unit-address is correct f0010000
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> > +          gpio-controller;
> > +          #gpio-cells = <2>;
> > +          reg = <0x0 0xB0>;

Thanks,

Tomer
