Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0575F80E1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjLLCaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjLLC3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:29:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2B10E6;
        Mon, 11 Dec 2023 18:29:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so48136515e9.2;
        Mon, 11 Dec 2023 18:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1702348153; x=1702952953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3/O2bOCMvIPD26EPX7q58jz6Wb52iFUgUWfAqCj8EA=;
        b=Rk3vCJacSrWx1t80H7eKJMwYkvlu4MGu0On1Vpv5IOMmFuIFiTl96qLZTzijp7SJGx
         slyipDdu5MWpeQ6zvk5NVa8rmMU/HbPBjwqeDDzjvPiVI27OUDdkf/2NEgnXw2cWbX+n
         MKdqdu7fTAc/NDNZXutDNVYvhKd6i6r976Rlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348153; x=1702952953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3/O2bOCMvIPD26EPX7q58jz6Wb52iFUgUWfAqCj8EA=;
        b=SwwrIp8uUYO+KSZqquuS6rAgJLXVT9Ffi9w6lSB2ZAjTIyDSGeDToBuW3nVXaes8Xd
         9RpRMhwvHIiG6o5YyeN7gP+Kii5EsVn1ybf34ONBDVaOlsdx24u/8saN7RUAPkTov3By
         tA79Fcne4t/8A9+AX52ZpXZEUmjWMPnJSujfs7j/NUw9AN6YWT3AwaVO0DsEo2xGGtet
         SSsCM1YPvHQMhqT3dccTVz25Xco17RvF/1PKLwQbqCnEIeeIE/e+MtlEPGzlvpsc/0qK
         bpoPBaUBynGLKhi7l9Dk+2wa6EXx9tnOOMd5IKT/2ITF1/0cRKHs+9iqQE5qn4vD4p9q
         lmTA==
X-Gm-Message-State: AOJu0Yy/9mYQQasAYq0x/2osrj6gWL1wMQgIzKcnbrNwrpyRwQb1DO+q
        mX3+yfLVF5vTqZ6hsRx0PPsgPbKO4T0qCsQkFx4=
X-Google-Smtp-Source: AGHT+IG834/1rgSOMj78cSfVHFrNZusC7+eevaxEHUBQZ+3PySBubE1silX2hArWsVVW2sOqfsCkE/q9cSpyHzIvvWU=
X-Received: by 2002:a05:600c:240d:b0:40b:5e59:ea01 with SMTP id
 13-20020a05600c240d00b0040b5e59ea01mr2937341wmp.160.1702348153266; Mon, 11
 Dec 2023 18:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20231211162656.2564267-1-peteryin.openbmc@gmail.com> <20231211162656.2564267-3-peteryin.openbmc@gmail.com>
In-Reply-To: <20231211162656.2564267-3-peteryin.openbmc@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 12 Dec 2023 12:59:01 +1030
Message-ID: <CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC
To:     Peter Yin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 02:59, Peter Yin <peteryin.openbmc@gmail.com> wrote:
>
> Add linux device tree entry related to
> the Meta(Facebook) computer-node system use an AT2600 BMC.
> This node is named "Harma".
>
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Looks good, thanks for your work. This will be submitted for the 6.8
merge window.

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---

For next time: Please describe what you've changed between this
version and the previous version just here, below the ---. This helps
reviewers understand what has changed, and why it's changed, from the
previous version.

>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 585 ++++++++++++++++++
>  2 files changed, 586 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
>
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 23cbc7203a8e..92ba3208d2a2 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-facebook-fuji.dtb \
>         aspeed-bmc-facebook-galaxy100.dtb \
>         aspeed-bmc-facebook-greatlakes.dtb \
> +       aspeed-bmc-facebook-harma.dtb \
>         aspeed-bmc-facebook-minipack.dtb \
>         aspeed-bmc-facebook-tiogapass.dtb \
>         aspeed-bmc-facebook-wedge40.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> new file mode 100644
> index 000000000000..7db3f9eb0016
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +       model = "Facebook Harma";
> +       compatible = "facebook,harma-bmc", "aspeed,ast2600";
> +
> +       aliases {
> +               serial0 = &uart1;
> +               serial1 = &uart6;
> +               serial2 = &uart2;
> +               serial4 = &uart5;
> +
> +               i2c20 = &imux20;
> +               i2c21 = &imux21;
> +               i2c22 = &imux22;
> +               i2c23 = &imux23;
> +               i2c24 = &imux24;
> +               i2c25 = &imux25;
> +               i2c26 = &imux26;
> +               i2c27 = &imux27;
> +               i2c28 = &imux28;
> +               i2c29 = &imux29;
> +               i2c30 = &imux30;
> +               i2c31 = &imux31;
> +       };
> +
> +       chosen {
> +               stdout-path = &uart5;
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                             <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                             <&adc1 2>;
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               led-0 {
> +                       label = "bmc_heartbeat_amber";
> +                       gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led-1 {
> +                       label = "fp_id_amber";
> +                       default-state = "off";
> +                       gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +               led-2 {
> +                       label = "power_blue";
> +                       default-state = "off";
> +                       gpios = <&gpio0 124 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +};
> +
> +// HOST BIOS Debug
> +&uart1 {
> +       status = "okay";
> +};
> +
> +// SOL Host Console
> +&uart2 {
> +       status = "okay";
> +       pinctrl-0 = <>;
> +};
> +
> +// SOL BMC Console
> +&uart4 {
> +       status = "okay";
> +       pinctrl-0 = <>;
> +};
> +
> +// BMC Debug Console
> +&uart5 {
> +       status = "okay";
> +};
> +
> +// MTIA
> +&uart6 {
> +       status = "okay";
> +};
> +
> +&uart_routing {
> +       status = "okay";
> +};
> +
> +&vuart1 {
> +       status = "okay";
> +};
> +
> +&wdt1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +       aspeed,reset-type = "soc";
> +       aspeed,external-signal;
> +       aspeed,ext-push-pull;
> +       aspeed,ext-active-high;
> +       aspeed,ext-pulse-duration = <256>;
> +};
> +
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&fmc {
> +       status = "okay";
> +
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +       };
> +
> +       flash@1 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "alt-bmc";
> +               spi-max-frequency = <50000000>;
> +       };
> +};
> +
> +// BIOS Flash
> +&spi2 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "pnor";
> +               spi-max-frequency = <12000000>;
> +               spi-tx-bus-width = <2>;
> +               spi-rx-bus-width = <2>;
> +       };
> +};
> +
> +&kcs2 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xca8>;
> +};
> +
> +&kcs3 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xca2>;
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       max31790@30{
> +               compatible = "max31790";
> +               reg = <0x30>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +
> +       tmp75@4b {
> +               compatible = "ti,tmp75";
> +               reg = <0x4b>;
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +
> +       max31790@30{
> +               compatible = "max31790";
> +               reg = <0x30>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9543";
> +               reg = <0x70>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               imux20: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +                       //Retimer Flash
> +                       eeprom@50 {
> +                               compatible = "atmel,24c2048";
> +                               reg = <0x50>;
> +                               pagesize = <128>;
> +                       };
> +               };
> +               imux21: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +       // PDB FRU
> +       eeprom@52 {
> +               compatible = "atmel,24c64";
> +               reg = <0x52>;
> +       };
> +
> +       delta_brick@69 {
> +               compatible = "pmbus";
> +               reg = <0x69>;
> +       };
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9543";
> +               reg = <0x70>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               imux22: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +               };
> +               imux23: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +               };
> +       };
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +
> +       gpio@30 {
> +               compatible = "nxp,pca9555";
> +               reg = <0x30>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +       gpio@31 {
> +               compatible = "nxp,pca9555";
> +               reg = <0x31>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       i2c-mux@71 {
> +               compatible = "nxp,pca9546";
> +               reg = <0x71>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               imux24: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +               };
> +               imux25: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +               };
> +               imux26: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +               };
> +               imux27: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +               };
> +       };
> +       // PTTV FRU
> +       eeprom@52 {
> +               compatible = "atmel,24c64";
> +               reg = <0x52>;
> +       };
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +};
> +
> +&i2c13 {
> +       status = "okay";
> +
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9545";
> +               reg = <0x70>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               imux28: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +               };
> +               imux29: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +                       //MB FRU
> +                       eeprom@54 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x54>;
> +                       };
> +               };
> +               imux30: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +               };
> +               imux31: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +               };
> +       };
> +};
> +
> +// To Debug card
> +&i2c14 {
> +       status = "okay";
> +       multi-master;
> +
> +       ipmb@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c15 {
> +       status = "okay";
> +
> +       // SCM FRU
> +       eeprom@50 {
> +               compatible = "atmel,24c64";
> +               reg = <0x50>;
> +       };
> +
> +       // BSM FRU
> +       eeprom@56 {
> +               compatible = "atmel,24c64";
> +               reg = <0x56>;
> +       };
> +};
> +
> +&adc0 {
> +       aspeed,int-vref-microvolt = <2500000>;
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +               &pinctrl_adc2_default &pinctrl_adc3_default
> +               &pinctrl_adc4_default &pinctrl_adc5_default
> +               &pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +       aspeed,int-vref-microvolt = <2500000>;
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc10_default>;
> +};
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&gpio0 {
> +       pinctrl-names = "default";
> +       gpio-line-names =
> +       /*A0-A7*/       "","","","","","","","",
> +       /*B0-B7*/       "","","","",
> +                       "bmc-spi-mux-select-0","led-identify","","",
> +       /*C0-C7*/       "","","","","","","","",
> +       /*D0-D7*/       "","","sol-uart-select","","","","","",
> +       /*E0-E7*/       "","","","","","","","",
> +       /*F0-F7*/       "","","","","","","","",
> +       /*G0-G7*/       "","","","","","","","",
> +       /*H0-H7*/       "","","","","","","","",
> +       /*I0-I7*/       "","","","","","","","",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "","","","","","","","",
> +       /*N0-N7*/       "led-postcode-0","led-postcode-1",
> +                       "led-postcode-2","led-postcode-3",
> +                       "led-postcode-4","led-postcode-5",
> +                       "led-postcode-6","led-postcode-7",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "power-button","power-host-control",
> +                       "reset-button","","led-power","","","",
> +       /*Q0-Q7*/       "","","","","","","","",
> +       /*R0-R7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","","","","","","",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","led-identify-gate","",
> +       /*V0-V7*/       "","","","",
> +                       "rtc-battery-voltage-read-enable","","","",
> +       /*W0-W7*/       "","","","","","","","",
> +       /*X0-X7*/       "","","","","","","","",
> +       /*Y0-Y7*/       "","","","","","","","",
> +       /*Z0-Z7*/       "","","","","","","","";
> +};
> +
> +&sgpiom0 {
> +       status = "okay";
> +       max-ngpios = <128>;
> +       ngpios = <128>;
> +       bus-frequency = <2000000>;
> +       gpio-line-names =
> +       /*in - out - in - out */
> +       /*A0-A3 line 0-7*/
> +       "presence-scm-cable","power-config-disable-e1s-0",
> +       "","",
> +       "","power-config-disable-e1s-1",
> +       "","",
> +       /*A4-A7 line 8-15*/
> +       "","power-config-asic-module-enable",
> +       "","power-config-asic-power-good",
> +       "","power-config-pdb-power-good",
> +       "presence-cpu","smi-control-n",
> +       /*B0-B3 line 16-23*/
> +       "","nmi-control-n",
> +       "","nmi-control-sync-flood-n",
> +       "","",
> +       "","",
> +       /*B4-B7 line 24-31*/
> +       "","FM_CPU_SP5R1",
> +       "reset-cause-rsmrst","FM_CPU_SP5R2",
> +       "","FM_CPU_SP5R3",
> +       "","FM_CPU_SP5R4",
> +       /*C0-C3 line 32-39*/
> +       "","FM_CPU0_SA0",
> +       "","FM_CPU0_SA1",
> +       "","rt-cpu0-p0-enable",
> +       "","rt-cpu0-p1-enable",
> +       /*C4-C7 line 40-47*/
> +       "","smb-rt-rom-p0-select",
> +       "","smb-rt-rom-p1-select",
> +       "","i3c-cpu-mux0-oe-n",
> +       "","i3c-cpu-mux0-select",
> +       /*D0-D3 line 48-55*/
> +       "","i3c-cpu-mux1-oe-n",
> +       "","i3c-cpu-mux1-select",
> +       "","reset-control-bmc",
> +       "","reset-control-cpu0-p0-mux",
> +       /*D4-D7 line 56-63*/
> +       "","reset-control-cpu0-p1-mux",
> +       "","reset-control-e1s-mux",
> +       "power-host-good","reset-control-mb-mux",
> +       "","reset-control-smb-e1s",
> +       /*E0-E3 line 64-71*/
> +       "","reset-control-smb-e1s",
> +       "host-ready-n","reset-control-srst",
> +       "presence-e1s-0","reset-control-usb-hub",
> +       "","reset-control",
> +       /*E4-E7 line 72-79*/
> +       "presence-e1s-1","reset-control-cpu-kbrst",
> +       "","reset-control-platrst",
> +       "","bmc-jtag-mux-select-0",
> +       "","bmc-jtag-mux-select-1",
> +       /*F0-F3 line 80-87*/
> +       "","bmc-jtag-select",
> +       "","bmc-ready-n",
> +       "","bmc-ready-sgpio",
> +       "","rt-cpu0-p0-force-enable",
> +       /*F4-F7 line 88-95*/
> +       "presence-asic-modules-0","rt-cpu0-p1-force-enable",
> +       "presence-asic-modules-1","bios-debug-msg-disable",
> +       "","uart-control-buffer-select",
> +       "","ac-control-n",
> +       /*G0-G3 line 96-103*/
> +       "FM_CPU_CORETYPE2","",
> +       "FM_CPU_CORETYPE1","",
> +       "FM_CPU_CORETYPE0","",
> +       "FM_BOARD_REV_ID5","",
> +       /*G4-G7 line 104-111*/
> +       "FM_BOARD_REV_ID4","",
> +       "FM_BOARD_REV_ID3","",
> +       "FM_BOARD_REV_ID2","",
> +       "FM_BOARD_REV_ID1","",
> +       /*H0-H3 line 112-119*/
> +       "FM_BOARD_REV_ID0","",
> +       "","","","","","",
> +       /*H4-H7 line 120-127*/
> +       "","",
> +       "reset-control-pcie-expansion-3","",
> +       "reset-control-pcie-expansion-2","",
> +       "reset-control-pcie-expansion-1","",
> +       /*I0-I3 line 128-135*/
> +       "reset-control-pcie-expansion-0","",
> +       "FM_EXP_SLOT_ID1","",
> +       "FM_EXP_SLOT_ID0","",
> +       "","",
> +       /*I4-I7 line 136-143*/
> +       "","","","","","","","",
> +       /*J0-J3 line 144-151*/
> +       "","","","","","","","",
> +       /*J4-J7 line 152-159*/
> +       "SLOT_ID_BCB_0","",
> +       "SLOT_ID_BCB_1","",
> +       "SLOT_ID_BCB_2","",
> +       "SLOT_ID_BCB_3","",
> +       /*K0-K3 line 160-167*/
> +       "","","","","","","","",
> +       /*K4-K7 line 168-175*/
> +       "","","","","","","","",
> +       /*L0-L3 line 176-183*/
> +       "","","","","","","","",
> +       /*L4-L7 line 184-191*/
> +       "","","","","","","","",
> +       /*M0-M3 line 192-199*/
> +       "","","","","","","","",
> +       /*M4-M7 line 200-207*/
> +       "","","","","","","","",
> +       /*N0-N3 line 208-215*/
> +       "","","","","","","","",
> +       /*N4-N7 line 216-223*/
> +       "","","","","","","","",
> +       /*O0-O3 line 224-231*/
> +       "","","","","","","","",
> +       /*O4-O7 line 232-239*/
> +       "","","","","","","","",
> +       /*P0-P3 line 240-247*/
> +       "","","","","","","","",
> +       /*P4-P7 line 248-255*/
> +       "","","","","","","","";
> +};
> --
> 2.25.1
>
