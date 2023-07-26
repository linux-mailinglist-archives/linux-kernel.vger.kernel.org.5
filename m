Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D562763F19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGZS4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGZS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:56:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B926BB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:56:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcfe28909so3835866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690397775; x=1691002575;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9TNH7rN4X9jpMQPTCMF3nIKFqvH8qBSBTAhAKjOMj4=;
        b=wg8lmXgWMte3pwdxKKPlZRCYxwSSF52uu/3BnHBhIqnPp3BBeCjUkU91c+w+JAq7xk
         zwUKtBrWU9rdWhxjZVdHGTLotMfTFqx3b4FAAHnrC7sFtOvIIkgSvmyHzktfZrMzBbIL
         epWcHPl5lUZ/T8li4I+2ZAUcC3WfqmRnJezQvsKmBWgeAa37DJAnCtsYCe5uYZoiT6ZY
         REdCc1/lSqX3x+vbqA3u4bCgPfXxWsM6lpsUqU36M+6z/fKuYp0N4PFvNSDO8Xm/gRUA
         PPgxm59uXELgsARLTacPD5DCTImeEni+wl4b+sWGP4SAHPm2ciEv4tmVb2qdEB4hGcAn
         SuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397775; x=1691002575;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9TNH7rN4X9jpMQPTCMF3nIKFqvH8qBSBTAhAKjOMj4=;
        b=hIIR0ap0Zgf6rqsEJPBlJwNuvivJCCJTIJNoE4ED9hOvlRnts44Ip3ReakQbO3GL5n
         6OLqN8tQWmHriYMPEm9u2r0c0OIX143K/LJDb4oVf2Em0S3a1irS7OyQsQbrxh6nNZGh
         /ezxDWG7jgm7YtuY+g4xzil5NKVK8vDJUX2yoAklC6jXlDy1m9lnJyHmq5c6m/Zu7HYw
         m+8rGuA9pdlaSFo7CJWsvR/jwkmrCKtM4jiHkFU8s16alF2Rr4KlPY4QZYJneXA8bmJ6
         rB0eoSc5nX/TEXJDgW60u0MDcdZLXTOjUNlW7SfyUtJBwU2ieE90IEd7vYZ9DJQILE4s
         UFpQ==
X-Gm-Message-State: ABy/qLaQVZ0MNBO/NdN/AexPnqskIV7cJ44pJSO2I3nW2MWnkfq2cXZf
        l/Rfb3BUbU/ikPy8GiBf9M1YiA==
X-Google-Smtp-Source: APBJJlGh2w5f+EQQtrt4UZ96x5E9mC6mEOFaqoZGru1fRrfgLZKS2d0h/3bkDc7eR8ENEr0A5CRxBg==
X-Received: by 2002:a17:906:310f:b0:99b:431b:a5e9 with SMTP id 15-20020a170906310f00b0099b431ba5e9mr43984ejx.45.1690397775536;
        Wed, 26 Jul 2023 11:56:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b00992a8a54f32sm9814652ejc.139.2023.07.26.11.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:56:15 -0700 (PDT)
Message-ID: <d7380f31-8ac6-7c7b-b2b8-11d497e0de00@linaro.org>
Date:   Wed, 26 Jul 2023 20:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: nuvoton: Add Fii Mori system
Content-Language: en-US
To:     Charles Boyer <Charles.Boyer@fii-usa.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Vivekanand Veeracholan <vveerach@google.com>,
        Lancelot Kao <lancelot.cy.kao@fii-na.com>
References: <20230726184651.1221-1-Charles.Boyer@fii-usa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726184651.1221-1-Charles.Boyer@fii-usa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 20:46, Charles Boyer wrote:
> Add the device tree for Mori BMC, which is an Ampere server platform
> manufactured by Fii. The device tree is based on Nuvoton NPCM730 SoC.
> 
> Signed-off-by: Charles Boyer <Charles.Boyer@fii-usa.com>
> ---
>  arch/arm/boot/dts/nuvoton/Makefile            |    1 +
>  .../boot/dts/nuvoton/nuvoton-npcm730-mori.dts | 1491 +++++++++++++++++

Thank you for your patch. There is something to discuss/improve.


>  2 files changed, 1492 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts
> 
> diff --git a/arch/arm/boot/dts/nuvoton/Makefile b/arch/arm/boot/dts/nuvoton/Makefile
> index 89c157dad312..ab74184b0283 100644
> --- a/arch/arm/boot/dts/nuvoton/Makefile
> +++ b/arch/arm/boot/dts/nuvoton/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_NPCM7XX) += \
>  	nuvoton-npcm730-gsj.dtb \
>  	nuvoton-npcm730-gbs.dtb \
>  	nuvoton-npcm730-kudo.dtb \
> +	nuvoton-npcm730-mori.dtb \
>  	nuvoton-npcm750-evb.dtb \
>  	nuvoton-npcm750-runbmc-olympus.dtb
>  dtb-$(CONFIG_ARCH_WPCM450) += \
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts
> new file mode 100644
> index 000000000000..45ef0b29d6ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts
> @@ -0,0 +1,1491 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2023 Fii USA Inc.
> +
> +/dts-v1/;
> +#include "nuvoton-npcm730.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +        model = "Fii mori Board";
> +        compatible = "fii,mori", "nuvoton,npcm730";

Missing bindings patch (don't forget about running checkpatch).

> +
> +        aliases {
> +                serial0 = &serial0;

...

> +
> +        iio-hwmon {
> +                compatible = "iio-hwmon";
> +                io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +                        <&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>;
> +        };
> +
> +        leds {
> +                compatible = "gpio-leds";
> +                BMC_ALIVE {

Eh... so many things to say...

1. Please base your work on already upstreamed code, so you will not
repeat the same errors we already fixed. It can happen though that this
Nuvoton boards are in terrible shape...

2. Underscores and capital letters are not allowed.

3. It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +                        gpios = <&gpio9 4 0>;

Use appropriate defines for flags.

> +                };
> +                boot_status_led {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +                        gpios = <&gpio10 15 0>;

Define

> +                };
> +        };
> +
> +        pinctrl: pinctrl@f0800000 {

Weird placement... but okay...

> +
> +        ahb {
> +                udc5: udc@f0835000 {
> +                        compatible = "nuvoton,npcm750-udc";
> +                        reg = <0xf0835000 0x1000
> +                                   0xfffd2800 0x800>;

Aren't these two items?

> +                        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +                        status = "okay";

Are you adding new node or overriding? Why board defines compatible for
SoC component? This is confusing...

> +                        clocks = <&clk NPCM7XX_CLK_SU>;
> +                        clock-names = "clk_usb_bridge";
> +                };
> +        };
> +
> +        pcie-slot {
> +                pcie0: pcie-slot@0 {
> +                        label = "slot0";
> +                };
> +                pcie1: pcie-slot@1 {
> +                        label = "slot1";
> +                };
> +                pcie2: pcie-slot@2 {
> +                        label = "slot2";
> +                };
> +                pcie3: pcie-slot@3 {
> +                        label = "slot3";
> +                };
> +        };
> +};

Missing blank line.

> +&gmac0 {
> +        phy-mode = "rgmii-id";
> +        snps,eee-force-disable;
> +        status = "okay";
> +};
> +
> +&emc0 {
> +        phy-mode = "rmii";
> +        status = "okay";
> +        fixed-link {
> +                speed = <100>;
> +                full-duplex;
> +        };
> +};
> +
> +&ehci1 {
> +        status = "okay";
> +};
> +
> +&ohci1 {
> +        status = "okay";
> +};
> +
> +&aes {
> +        status = "okay";
> +};
> +
> +&sha {
> +        status = "okay";
> +};
> +
> +&spi1 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&gpio177_pins &gpio176o_pins
> +                        &gpio175ol_pins>;
> +        status = "okay";
> +        jtag_master {

Nope, nope. Don't use reviewers as tools. Use tools for this:

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

`make dtbs W=1`

> +                compatible = "nuvoton,npcm750-jtag-master";
> +                spi-max-frequency = <25000000>;
> +                reg = <0>;
> +
> +                pinctrl-names = "pspi", "gpio";
> +                pinctrl-0 = <&pspi1_pins>;
> +                pinctrl-1 = <&gpio177_pins &gpio176o_pins
> +                                                &gpio175ol_pins>;
> +
> +                tck-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
> +                tdi-gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>;
> +                tdo-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +                tms-gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
> +                status = "okay";

okay is by default, why do you need it?

> +        };
> +};
> +
> +&fiu0 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&spi0cs1_pins>;
> +        status = "okay";
> +        spi-nor@0 {
> +                compatible = "jedec,spi-nor";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                reg = <0>;
> +                spi-max-frequency = <5000000>;
> +                spi-rx-bus-width = <2>;
> +                label = "bmc";
> +                partitions@80000000 {
> +                        compatible = "fixed-partitions";
> +                        #address-cells = <1>;
> +                        #size-cells = <1>;
> +                        u-boot@0 {
> +                                label = "u-boot";
> +                                reg = <0x0000000 0xC0000>;
> +                                read-only;
> +                        };
> +                        image-descriptor@f0000 {
> +                                label = "image-descriptor";
> +                                reg = <0xf0000 0x10000>;
> +                        };
> +                        hoth-update@100000 {
> +                                label = "hoth-update";
> +                                reg = <0x100000 0x100000>;
> +                        };
> +                        kernel@200000 {
> +                                label = "kernel";
> +                                reg = <0x200000 0x500000>;
> +                        };
> +                        rofs@700000 {
> +                                label = "rofs";
> +                                reg = <0x700000 0x35f0000>;
> +                        };
> +                        rwfs@3cf0000 {
> +                                label = "rwfs";
> +                                reg = <0x3cf0000 0x300000>;
> +                        };
> +                        hoth-mailbox@3ff0000 {
> +                                label = "hoth-mailbox";
> +                                reg = <0x3ff0000 0x10000>;
> +                        };
> +                };
> +        };
> +};
> +
> +&fiu3 {
> +        pinctrl-0 = <&spi3_pins>;
> +        status = "okay";
> +
> +        spi-nor@0 {
> +                compatible = "jedec,spi-nor";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                spi-rx-bus-width = <2>;
> +                reg = <0>;
> +                label = "hnor";
> +        };
> +};
> +
> +// emmc
> +&sdhci0 {
> +        status = "okay";
> +};
> +// USB
> +&ehci1 {
> +        status = "okay";
> +};
> +
> +&ohci1 {
> +        status = "okay";
> +};
> +
> +&vdma {
> +        status = "okay";
> +};
> +
> +&pcimbox {
> +        status = "okay";
> +};
> +
> +&vcd {
> +        status = "okay";
> +};
> +
> +&ece {
> +        status = "okay";
> +};
> +
> +&watchdog1 {
> +        status = "okay";
> +};
> +
> +&rng {
> +        status = "okay";
> +};
> +
> +&serial0 {
> +        status = "okay";
> +};
> +
> +&serial1 {
> +        status = "okay";
> +};
> +
> +&serial2 {
> +        status = "okay";
> +};
> +
> +&serial3 {
> +        status = "okay";
> +};
> +
> +&adc {
> +        #io-channel-cells = <1>;
> +        status = "okay";
> +};
> +
> +&otp {
> +        status = "okay";
> +};
> +
> +&i2c0 {
> +        status = "okay";
> +        clock-frequency = <400000>;
> +};
> +
> +&i2c1 {
> +        status = "okay";
> +        clock-frequency = <400000>;
> +        i2c-switch@75 {
> +                compatible = "nxp,pca9548";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0x75>;
> +                i2c-mux-idle-disconnect;
> +
> +                i2c16: i2c@0 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <0>;
> +                };
> +                i2c17: i2c@1 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <1>;
> +                };
> +                i2c18: i2c@2 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <2>;
> +                };
> +                i2c19: i2c@3 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <3>;
> +
> +                        cpu@50 {

cpu? Is it really a CPU on I2C bus?

> +                                compatible = "atmel,24c64";
> +                                reg = <0x50>;
> +                        };
> +                };
> +                i2c20: i2c@4 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <4>;
> +                };
> +                i2c21: i2c@5 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <5>;
> +                };
> +                i2c22: i2c@6 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <6>;
> +                };
> +                i2c23: i2c@7 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <7>;
> +                };
> +        };

Here and in all other places - missing blank line after node.

> +        i2c-switch@77 {
> +                compatible = "nxp,pca9548";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0x77>;
> +                i2c-mux-idle-disconnect;
> +
> +                i2c24: i2c@0 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <0>;
> +                };
> +                i2c25: i2c@1 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <1>;
> +
> +                        adm1272@1f {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                                compatible = "adi,adm1272";
> +                                reg = <0x1f>;
> +                                shunt-resistor-micro-ohms = <333>;
> +                        };
> +
> +                };
> +                i2c26: i2c@2 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <2>;
> +                };
> +                i2c27: i2c@3 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <3>;
> +                };
> +                i2c28: i2c@4 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <4>;
> +                };
> +                i2c29: i2c@5 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <5>;
> +                };
> +                i2c30: i2c@6 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <6>;
> +                };
> +                i2c31: i2c@7 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <7>;
> +                };
> +        };
> +};
> +
> +&i2c2 {
> +        status = "okay";
> +        clock-frequency = <400000>;
> +        i2c-switch@77 {
> +                compatible = "nxp,pca9548";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0x77>;
> +                i2c-mux-idle-disconnect;
> +
> +                i2c32: i2c@0 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <0>;
> +                };
> +                i2c33: i2c@1 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <1>;
> +                };
> +                i2c34: i2c@2 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <2>;
> +                };
> +                i2c35: i2c@3 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <3>;
> +
> +                        //REAR FAN

Fix the comments to match Linux coding style.

> +                        max31790@2c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                                compatible = "maxim,max31790";
> +                                reg = <0x2c>;
> +                        };
> +                };
> +                i2c36: i2c@4 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <4>;
> +                };
> +                i2c37: i2c@5 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <5>;
> +
> +                        //OUTLET1_T
> +                        lm75@5c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                                compatible = "ti,lm75";
> +                                reg = <0x5c>;
> +                        };
> +                };
> +                i2c38: i2c@6 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <6>;
> +
> +                        //INLET1_T
> +                        lm75@5c {
> +                                compatible = "ti,lm75";
> +                                reg = <0x5c>;
> +                        };
> +                };
> +                i2c39: i2c@7 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <7>;
> +                };
> +        };
> +};
> +
> +&i2c3 {
> +        status = "okay";
> +        clock-frequency = <400000>;
> +        pcie-slot = &pcie0;
> +};
> +
> +&i2c4 {
> +        status = "okay";
> +        clock-frequency = <400000>;
> +        mbfru@50 {
> +                compatible = "atmel,24c64";
> +                reg = <0x50>;
> +        };
> +
> +        i2c-switch@77 {
> +                compatible = "nxp,pca9548";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0x77>;
> +                i2c-mux-idle-disconnect;
> +
> +                i2c40: i2c@0 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <0>;
> +
> +                        //Power Sequencer
> +                        adm1266@40 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                                compatible = "adi,adm1266";
> +                                reg = <0x40>;
> +                        };
> +                };
> +                i2c41: i2c@1 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <1>;
> +                };
> +                i2c42: i2c@2 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <2>;
> +
> +                        //SKM EEPROM
> +                        skm@55 {

Come on... eeprom


> +                                compatible = "atmel,24c64";
> +                                reg = <0x55>;
> +                                pagesize = <0x20>;
> +                        };
> +                };
> +                i2c43: i2c@3 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <3>;
> +
> +                        gpio10: pca6416@20 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                                compatible = "nxp,pca6416";
> +                                reg = <0x20>;
> +                                pinctrl-names = "default";
> +                                gpio-controller;
> +                                #gpio-cells = <2>;
> +                                gpio-line-names =
> +                                        "P12V_PCIE_PE0_ON", "P12V_PCIE_PE1_ON", "P12V_PCIE_PE2_ON", "P12V_PCIE_PE3_ON", "P13V5_NBM_S0_PGD",
> +                                        "P12V_EFUSE_ABCD_EN", "P12V_EFUSE_EFGH_EN", "NC_P0_7", "MB_JTAG_MUX_SEL", "JTAG_SCM_MUX_OE_N",
> +                                        "FM_BMC_IO_CPLD_PROGRAM_N", "FM_BMC_IO_CPLD_HITLESS_N", "FM_IOEXP_DRAM_P12V_EN", "MB_CPLD_INIT",
> +                                        "NCSI_CX_PRSNT_N", "SYS_BOOT_STATUS_LED";
> +                        };
> +                };
> +                i2c44: i2c@4 {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <4>;
> +
> +                        gpio12: pca6416@21 {

Enough. This DTS should have basic things first cleaned up.



Best regards,
Krzysztof

