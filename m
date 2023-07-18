Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B47586B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGRVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGRVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:16:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2E1998
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:16:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992ace062f3so865427666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1689714996; x=1692306996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3l5b6fjCqYkc1Ou+xz9fDA/3zqE2Nao7Y82ogOypK4=;
        b=1GbbTX1wQ3HyzN+6JhzVk6tFEqPdThi7ya6ZBYCaSoPmTyIEciobKI0uKW3LqmbW2O
         UnSBey/amOqVMKOeYKN++L33D+YcyCVvlFlciAAKZ3lo5Xo9NvJH0aYxD/Mu41p+ViXX
         my0AxuJEqpfkhh/Wt7PB2tsG7PrkO+HDGAPrUcIFyq/zepnMtgsV9nnTSXUwZFo88M+6
         ALdVi6gds82qtmYx+bruYddSKcUcWPuJe/5+BRNThgpzp05F6qp+T3B8yc3F5ooQVyvG
         cTPglpBcSykd02PuH//Dz8uWtxStGt1zGyRHebduaMXxQd3bfH5kKfCraH0L8SHyc2zb
         QsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689714996; x=1692306996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3l5b6fjCqYkc1Ou+xz9fDA/3zqE2Nao7Y82ogOypK4=;
        b=LPzf5Rjr0JVWBw6NHnsSKRcqNhIvAGlUVi+JmghDjtN3k3YYiMsjcJD5Y7161/9sa3
         ibwZ+zAnLM+flOH/po3FaBQUFxR4C5cRU0uTCZX2uCb3edd9S6takpLNEl5RwGQrVZZS
         Ly+5/Hpqmru3MDd3KuFCrjfwP/1XDWlnw4lsffqq5AMAtpPfI1OIJm+K286ALqh21tYA
         SkklyBeoN88IwJuFeymHHLo+prLNHCXv2gt32KjkUCIBjlVlXal6aONsH2xxc2yK/hIZ
         NLfQq2gy4ci+Eqh/f6N3NMv6yo7DHrggCOt/P31HUehZKyT1hnQYlmdEw5QlS463Kps2
         dgxA==
X-Gm-Message-State: ABy/qLbVWbvlfD7N9fntMW0AZwSrQMt6x9SCsE2LpRLdUGubx9/5GNQs
        NG53SecI/Z0Y9XUUCN/s/UHcYyqzIPQCLsMsFourWw==
X-Google-Smtp-Source: APBJJlE+HnXXcT07j8t7C89/yxNlvYSRHCuNfd0fNYCV4MuOQPdATMP1uBMS49Yd4Ei7HXNOLMnKrT1/MHWtcviG0Kw=
X-Received: by 2002:a17:906:51:b0:994:577:f9df with SMTP id
 17-20020a170906005100b009940577f9dfmr737739ejg.4.1689714995726; Tue, 18 Jul
 2023 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170724.2016988-1-tharvey@gateworks.com>
 <20230607170724.2016988-2-tharvey@gateworks.com> <20230717002717.GI9559@dragon>
In-Reply-To: <20230717002717.GI9559@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 18 Jul 2023 14:16:22 -0700
Message-ID: <CAJ+vNU2Wn0jf8QyZsGiw3f=XThZEfXajhGJTmZz2mnJXgprAhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw71xx-2x
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 5:27=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wro=
te:
>
> On Wed, Jun 07, 2023 at 10:07:24AM -0700, Tim Harvey wrote:
> > The Gateworks imx8mp-venice-gw71xx-2x consists of a SOM + baseboard.
> >
> > The GW702x SOM contains the following:
> >  - i.MX8M Plus SoC
> >  - LPDDR4 memory
> >  - eMMC Boot device
> >  - Gateworks System Controller (GSC) with integrated EEPROM, button
> >    controller, and ADC's
> >  - PMIC
> >  - SOM connector providing:
> >   - eQoS GbE MII
> >   - 1x SPI
> >   - 2x I2C
> >   - 4x UART
> >   - 2x USB 3.0
> >   - 1x PCI
> >   - 1x SDIO (4-bit 3.3V)
> >   - 1x SDIO (4-bit 3.3V/1.8V)
> >   - GPIO
> >
> > The GW71xx Baseboard contains the following:
> >  - GPS
> >  - RJ45 GbE (eQoS)
> >  - off-board I/O connector with UART, I2C, SPI, GPIO
> >  - EERPOM
> >  - PCIe clock generator
> >  - full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
> >  - USB Type-C with USB 2.0 host and peripheral support
> >  - Wide range DC input supply
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx8mp-venice-gw71xx-2x.dts |  19 ++
> >  .../dts/freescale/imx8mp-venice-gw71xx.dtsi   | 236 ++++++++++++++++++
> >  3 files changed, 256 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-=
2x.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.=
dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index 62f22b77b38b..b3bb823d0168 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edim=
m2.2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw71xx-2x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw74xx.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw7905-2x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-verdin-nonwifi-dahlia.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts =
b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > new file mode 100644
> > index 000000000000..53120fc9cd7f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2023 Gateworks Corporation
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mp.dtsi"
> > +#include "imx8mp-venice-gw702x.dtsi"
> > +#include "imx8mp-venice-gw71xx.dtsi"
> > +
> > +/ {
> > +     model =3D "Gateworks Venice GW71xx-2x i.MX8MP Development Kit";
> > +     compatible =3D "gateworks,imx8mp-gw71xx-2x", "fsl,imx8mp";
> > +
> > +     chosen {
> > +             stdout-path =3D &uart2;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi b/=
arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > new file mode 100644
> > index 000000000000..86999f52d4b2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > @@ -0,0 +1,236 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2023 Gateworks Corporation
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > +
> > +/ {
> > +     led-controller {
> > +             compatible =3D "gpio-leds";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_gpio_leds>;
> > +
> > +             led-0 {
> > +                     function =3D LED_FUNCTION_STATUS;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&gpio4 1 GPIO_ACTIVE_HIGH>;
> > +                     default-state =3D "on";
> > +                     linux,default-trigger =3D "heartbeat";
> > +             };
> > +
> > +             led-1 {
> > +                     function =3D LED_FUNCTION_STATUS;
> > +                     color =3D <LED_COLOR_ID_RED>;
> > +                     gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>;
> > +                     default-state =3D "off";
> > +             };
> > +     };
> > +
> > +     pcie0_refclk: pcie0-refclk {
>
> Can we name the node clock-xxx?
>
> > +             compatible =3D "fixed-clock";
> > +             #clock-cells =3D <0>;
> > +             clock-frequency =3D <100000000>;
> > +     };
> > +
> > +     pps {
> > +             compatible =3D "pps-gpio";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_pps>;
> > +             gpios =3D <&gpio4 3 GPIO_ACTIVE_HIGH>;
> > +             status =3D "okay";
> > +     };
> > +};
> > +
> > +/* off-board header */
> > +&ecspi2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_spi2>;
> > +     cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +     status =3D "okay";
> > +};
> > +
> > +&gpio4 {
> > +     gpio-line-names =3D
> > +             "", "", "", "",
> > +             "", "", "", "",
> > +             "dio1", "", "", "dio0",
> > +             "", "", "pci_usb_sel", "",
> > +             "", "", "", "",
> > +             "", "", "", "",
> > +             "dio3", "", "dio2", "",
> > +             "pci_wdis#", "", "", "";
> > +};
> > +
> > +&i2c2 {
> > +     clock-frequency =3D <400000>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_i2c2>;
> > +     status =3D "okay";
> > +
> > +     accelerometer@19 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_accel>;
> > +             compatible =3D "st,lis2de12";
> > +             reg =3D <0x19>;
>
> Can we start the property list from these two?
>
> > +             st,drdy-int-pin =3D <1>;
> > +             interrupt-parent =3D <&gpio4>;
> > +             interrupts =3D <21 IRQ_TYPE_LEVEL_LOW>;
> > +             interrupt-names =3D "INT1";
> > +     };
> > +};
> > +
> > +&pcie_phy {
> > +     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > +     fsl,clkreq-unsupported;
> > +     clocks =3D <&pcie0_refclk>;
> > +     clock-names =3D "ref";
> > +     status =3D "okay";
> > +};
> > +
> > +&pcie {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_pcie0>;
> > +     reset-gpio =3D <&gpio4 29 GPIO_ACTIVE_LOW>;
> > +     status =3D "okay";
> > +};
> > +
> > +/* GPS */
> > +&uart1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart1>;
> > +     status =3D "okay";
> > +};
> > +
> > +/* off-board header */
> > +&uart3 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart3>;
> > +     status =3D "okay";
> > +};
> > +
> > +/* USB1 Type-C front panel */
> > +&usb3_0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_usb1>;
> > +     fsl,over-current-active-low;
> > +     status =3D "okay";
> > +};
> > +
> > +&usb3_phy0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb_dwc3_0 {
> > +     /* dual role is implemented but not a full featured OTG */
> > +     adp-disable;
> > +     hnp-disable;
> > +     srp-disable;
> > +     dr_mode =3D "otg";
> > +     usb-role-switch;
> > +     role-switch-default-mode =3D "peripheral";
> > +     status =3D "okay";
> > +
> > +     connector {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_usbcon1>;
> > +             compatible =3D "gpio-usb-b-connector", "usb-b-connector";
>
> Start the properties from 'compatible'?
>
> Shawn
>

Hi Shawn,

My notes say that pinctrl should come first (if needed) followed by
compatible, reg, other props, and finally status (if needed). Assuming
I'm wrong about that where in the list should pinctrl be and is this
documented anywhere for future reference?

Best regards,

Tim

> > +             type =3D "micro";
> > +             label =3D "Type-C";
> > +             id-gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
> > +     };
> > +};
> > +
> > +/* USB2 - MiniPCIe socket */
> > +&usb3_1 {
> > +     fsl,permanently-attached;
> > +     fsl,disable-port-power-control;
> > +     status =3D "okay";
> > +};
> > +
> > +&usb3_phy1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb_dwc3_1 {
> > +     dr_mode =3D "host";
> > +     status =3D "okay";
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_hog>;
> > +
> > +     pinctrl_hog: hoggrp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI1_RXD6__GPIO4_IO08      0x4000014=
6 /* DIO1 */
> > +                     MX8MP_IOMUXC_SAI1_TXC__GPIO4_IO11       0x4000014=
6 /* DIO0 */
> > +                     MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14      0x4000010=
6 /* PCIE_USBSEL */
> > +                     MX8MP_IOMUXC_SAI2_TXD0__GPIO4_IO26      0x4000014=
6 /* DIO2 */
> > +                     MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24      0x4000014=
6 /* DIO3 */
> > +                     MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28      0x4000010=
6 /* PCIE_WDIS# */
> > +             >;
> > +     };
> > +
> > +     pinctrl_accel: accelgrp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21      0x150   /=
* IRQ */
> > +             >;
> > +     };
> > +
> > +     pinctrl_gpio_leds: gpioledgrp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01       0x6     /=
* LEDG */
> > +                     MX8MP_IOMUXC_SAI1_RXD3__GPIO4_IO05      0x6     /=
* LEDR */
> > +             >;
> > +     };
> > +
> > +     pinctrl_pcie0: pcie0grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29       0x106
> > +             >;
> > +     };
> > +
> > +     pinctrl_pps: ppsgrp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03      0x146
> > +             >;
> > +     };
> > +
> > +     pinctrl_usb1: usb1grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC    0x140 /* =
USB1_FLT# */
> > +             >;
> > +     };
> > +
> > +     pinctrl_usbcon1: usbcon1grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21      0x140 /* =
USB1_ID */
> > +             >;
> > +     };
> > +
> > +     pinctrl_spi2: spi2grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK   0x140
> > +                     MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI   0x140
> > +                     MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO   0x140
> > +                     MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13     0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart1: uart1grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX    0x140
> > +                     MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX    0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart3: uart3grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX    0x140
> > +                     MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX    0x140
> > +             >;
> > +     };
> > +};
> > --
> > 2.25.1
> >
