Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B1759A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGSPt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGSPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:49:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F7E42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:49:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95eac836eso8664891fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1689781786; x=1692373786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwnbdrqpPmABt/MADwBaR2/1uWELRMCzcJekaw4y+ls=;
        b=vw57WL0iQeOR3f5NyJuHdCsJuEed+P/ClzRiBwTqPQpNmaX7EVIuhUUbIzBQ/3CenO
         BYykdBXHTHNuiak4iHuxvIEU8w73IICG3I8snP5Uz6p3Su5V/j8F+nuDQbRYXgtt19Ry
         VMCANbJXjZAzFL0leLO2eq5zCQXCYtpbgGFoPZK0VXJI4cbwVFQhBz7v2HcpaUiRJ7ti
         H/+i/aDQu3eKwsvcZtOXNrmGTRVxr5kanpTONjFwUJHbJZS2BQc0ob6avJMnzZdaqX/p
         2KAfh1IivnqLVfpt4oXZV1zkYwFCH4BXm6IJ+T2GqcR/TF07yzgxtPIoptySrFsMMbge
         gb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781786; x=1692373786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwnbdrqpPmABt/MADwBaR2/1uWELRMCzcJekaw4y+ls=;
        b=jF9FnX9PnbYMmNCOtnNFGM0QCTtT7ePAshCPqKJUbPjzM6lGxuAtJPXWD5Oa6EvFH8
         NJ8gAe/CgNSq5tQfNxEMDb+q9xG02ooSt6Q2lej5wFaZ8tKEa/UxRBVrA1Etqp56mLsm
         J1KBrjPoED89tKNE3EiXhhT8Z3hxNHVHe5YeJBByn2ztC5in/IF6cTM+i9ac1GXvmGGs
         6Ff7H3l2yloaVCxMSoiOSOwiiRxIBNP1Nyai1NGpK4DHM71/Dvf3W7g5QPFLaQbVFqT1
         DLpLqYAm/9o7oA3+tdoWXYUc50rN9sSG0m+9P++E6YFBYPTudeerYkvzb99DKLR56AaR
         e+nA==
X-Gm-Message-State: ABy/qLa/KLStu37CxezfKemZX85PdZkPXRuH5K50SvhvmtiXt493K72H
        x5tiMJL5VolllR9kT+XNrRo9+fB7cWeapXrqYwJWxQ==
X-Google-Smtp-Source: APBJJlF8Ri0HACK/VGPo4CEQiKf1SuJY73Zy/+qf0UYaPL75NwxaGoe0wG3gliN8lv+E0DR/xkoO6CG+9aEDYMuJOPM=
X-Received: by 2002:a2e:9b5a:0:b0:2b9:4841:9652 with SMTP id
 o26-20020a2e9b5a000000b002b948419652mr216868ljj.25.1689781786484; Wed, 19 Jul
 2023 08:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230609174107.3373182-1-tharvey@gateworks.com> <20230609174107.3373182-2-tharvey@gateworks.com>
In-Reply-To: <20230609174107.3373182-2-tharvey@gateworks.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 19 Jul 2023 08:49:32 -0700
Message-ID: <CAJ+vNU2e8Qe_XzzHt2Wm8ts91MvoDb_b=ie=5NbOtVJewCw3cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: Add imx8mm-venice-gw7905-0x
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:41=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The Gateworks imx8mm-venice-gw7905-0x consists of a SOM + baseboard.
>
> The GW700x SOM contains the following:
>  - i.MX8M Mini SoC
>  - LPDDR4 memory
>  - eMMC Boot device
>  - Gateworks System Controller (GSC) with integrated EEPROM, button
>    controller, and ADC's
>  - PMIC
>  - SOM connector providing:
>   - FEC GbE MII
>   - 1x SPI
>   - 2x I2C
>   - 4x UART
>   - 2x USB 2.0
>   - 1x PCI
>   - 1x SDIO (4-bit 3.3V)
>   - 1x SDIO (4-bit 3.3V/1.8V)
>   - GPIO
>
> The GW7905 Baseboard contains the following:
>  - GPS
>  - microSD
>  - off-board I/O connector with I2C, SPI, GPIO
>  - EERPOM
>  - PCIe clock generator
>  - 1x full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
>  - 1x half-length miniPCIe socket with USB2.0 and USB3.0
>  - USB 3.0 HUB
>  - USB Type-C with USB PD Sink capability and peripheral support
>  - USB Type-C with USB 3.0 host support
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2 - no changes
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-venice-gw7905-0x.dts |  28 ++
>  .../dts/freescale/imx8mm-venice-gw7905.dtsi   | 303 ++++++++++++++++++
>  3 files changed, 332 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x=
.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dt=
si
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index d94d464db03e..f13faf043d48 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-venice-gw7901.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-venice-gw7903.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-venice-gw7904.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-venice-gw7905-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-verdin-nonwifi-dahlia.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-verdin-nonwifi-dev.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-verdin-nonwifi-yavia.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts b/=
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
> new file mode 100644
> index 000000000000..914753f062cd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm.dtsi"
> +#include "imx8mm-venice-gw700x.dtsi"
> +#include "imx8mm-venice-gw7905.dtsi"
> +
> +/ {
> +       model =3D "Gateworks Venice GW7905-0x i.MX8MM Development Kit";
> +       compatible =3D "gateworks,imx8mm-gw7905-0x", "fsl,imx8mm";
> +
> +       chosen {
> +               stdout-path =3D &uart2;
> +       };
> +};
> +
> +/* Disable SOM interfaces not used on baseboard */
> +&fec1 {
> +       status =3D "disabled";
> +};
> +
> +&usdhc1 {
> +       status =3D "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi b/ar=
ch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi
> new file mode 100644
> index 000000000000..9646eb9e4928
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +/ {
> +       led-controller {
> +               compatible =3D "gpio-leds";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_gpio_leds>;
> +
> +               led-0 {
> +                       function =3D LED_FUNCTION_STATUS;
> +                       color =3D <LED_COLOR_ID_GREEN>;
> +                       gpios =3D <&gpio4 0 GPIO_ACTIVE_HIGH>;
> +                       default-state =3D "on";
> +                       linux,default-trigger =3D "heartbeat";
> +               };
> +
> +               led-1 {
> +                       function =3D LED_FUNCTION_STATUS;
> +                       color =3D <LED_COLOR_ID_RED>;
> +                       gpios =3D <&gpio4 2 GPIO_ACTIVE_HIGH>;
> +                       default-state =3D "off";
> +               };
> +       };
> +
> +       pcie0_refclk: pcie0-refclk {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <100000000>;
> +       };
> +
> +       pps {
> +               compatible =3D "pps-gpio";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_pps>;
> +               gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>;
> +               status =3D "okay";
> +       };
> +
> +       reg_usb2_vbus: regulator-usb2-vbus {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_reg_usb2_en>;
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb2_vbus";
> +               gpio =3D <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +       };
> +
> +       reg_usdhc2_vmmc: regulator-usdhc2 {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "SD2_3P3V";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +};
> +
> +/* off-board header */
> +&ecspi2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_spi2>;
> +       cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> +       status =3D "okay";
> +};
> +
> +&gpio1 {
> +       gpio-line-names =3D
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "gpioa", "gpiob", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "";
> +};
> +
> +&gpio4 {
> +       gpio-line-names =3D
> +               "", "", "", "pci_usb_sel",
> +               "", "", "", "pci_wdis#",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "";
> +};
> +
> +&gpio5 {
> +       gpio-line-names =3D
> +               "", "", "", "",
> +               "gpioc", "gpiod", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "",
> +               "", "", "", "";
> +};
> +
> +&i2c2 {
> +       clock-frequency =3D <400000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c2>;
> +       status =3D "okay";
> +
> +       eeprom@52 {
> +               compatible =3D "atmel,24c32";
> +               reg =3D <0x52>;
> +               pagesize =3D <32>;
> +       };
> +};
> +
> +/* off-board header */
> +&i2c3 {
> +       clock-frequency =3D <400000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c3>;
> +       status =3D "okay";
> +};
> +
> +&pcie_phy {
> +       fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +       fsl,clkreq-unsupported;
> +       clocks =3D <&pcie0_refclk>;
> +       clock-names =3D "ref";
> +       status =3D "okay";
> +};
> +
> +&pcie0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_pcie0>;
> +       reset-gpio =3D <&gpio4 6 GPIO_ACTIVE_LOW>;
> +       status =3D "okay";
> +};
> +
> +/* GPS */
> +&uart1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart1>;
> +       status =3D "okay";
> +};
> +
> +/* USB1 - Type C front panel SINK port J14 */
> +&usbotg1 {
> +       dr_mode =3D "peripheral";
> +       status =3D "okay";
> +};
> +
> +/* USB2 4-port USB3.0 HUB:
> + *  P1 - USBC connector (host only)
> + *  P2 - USB2 test connector
> + *  P3 - miniPCIe full card
> + *  P4 - miniPCIe half card
> + */
> +&usbotg2 {
> +       dr_mode =3D "host";
> +       vbus-supply =3D <&reg_usb2_vbus>;
> +       status =3D "okay";
> +};
> +
> +/* microSD */
> +&usdhc2 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +       pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +       pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +       cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
> +       vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +       bus-width =3D <4>;
> +       status =3D "okay";
> +};
> +
> +&iomuxc {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_hog>;
> +
> +       pinctrl_hog: hoggrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13      0x4000004=
0 /* GPIOA */
> +                       MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14      0x4000004=
0 /* GPIOB */
> +                       MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3        0x4000010=
6 /* PCI_USBSEL */
> +                       MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7        0x4000010=
6 /* PCIE_WDIS# */
> +                       MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5    0x4000004=
0 /* GPIOD */
> +                       MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4         0x4000004=
0 /* GPIOC */
> +               >;
> +       };
> +
> +       pinctrl_gpio_leds: gpioledgrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0        0x6     /=
* LEDG */
> +                       MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2        0x6     /=
* LEDR */
> +               >;
> +       };
> +
> +       pinctrl_i2c2: i2c2grp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL          0x400001c=
2
> +                       MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA          0x400001c=
2
> +               >;
> +       };
> +
> +       pinctrl_i2c3: i2c3grp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL          0x400001c=
2
> +                       MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA          0x400001c=
2
> +               >;
> +       };
> +
> +       pinctrl_pcie0: pciegrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6        0x106
> +               >;
> +       };
> +
> +       pinctrl_pps: ppsgrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5        0x106
> +               >;
> +       };
> +
> +       pinctrl_reg_usb2_en: regusb2grp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8       0x6     /=
* USBHUB_RST# (ext p/u) */
> +               >;
> +       };
> +
> +       pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19     0x40
> +               >;
> +       };
> +
> +       pinctrl_spi2: spi2grp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK    0x140
> +                       MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI    0x140
> +                       MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO    0x140
> +                       MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13      0x140
> +               >;
> +       };
> +
> +       pinctrl_uart1: uart1grp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX     0x140
> +                       MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX     0x140
> +               >;
> +       };
> +
> +       pinctrl_usdhc2: usdhc2grp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x190
> +                       MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d0
> +                       MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d0
> +                       MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d0
> +                       MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d0
> +                       MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d0
> +                       MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT  0xc0
> +               >;
> +       };
> +
> +       pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x194
> +                       MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d4
> +                       MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d4
> +                       MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d4
> +                       MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d4
> +                       MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d4
> +                       MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT  0xc0
> +               >;
> +       };
> +
> +       pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x196
> +                       MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d6
> +                       MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d6
> +                       MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d6
> +                       MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d6
> +                       MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d6
> +                       MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT  0xc0
> +               >;
> +       };
> +
> +       pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12        0x1c4
> +               >;
> +       };
> +};
> --
> 2.25.1
>

Hi Shawn,

I'm not sure if you missed this one or if you had some rework that you want=
ed?

Best regards,

Tim
