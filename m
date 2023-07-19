Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7E758B15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGSB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSB6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3521BE9;
        Tue, 18 Jul 2023 18:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D0761683;
        Wed, 19 Jul 2023 01:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C73C433C9;
        Wed, 19 Jul 2023 01:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689731883;
        bh=RawEnqc1EkIgdkG2i7me4l9fFj/6mUCWCz+xGcSTwAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7a7oEr8cy6h2A3djds9QBxY5rCG1G+E9+SWbmSrMqgK/lMSCQqJOb3xV05iUsCoN
         nN6poCxArph65dloIeJ0lF/SQIjMWHOg/QGU9+9zKLscwn/9IyVDUEPKN3JGOUtYxb
         ypkBXycMSAg6oIOYs243x+kWrPKEsXsYtRMpjL0vtYqc9xY9U7Pa8+/mIqgxE6IGz4
         bdqzzqjWpHwNci/K3JKCV9qOeABLl36BBNRZF2eIpp7L8J4+vkPY3H4qBmGyZlZh8F
         kTbnIpsumRmJMlPnAKBna4b9QoBYH+7ZXgVIaMa0XzboSZDIikXDlO44OiXiTWJbYi
         th22DTt01xFtQ==
Date:   Wed, 19 Jul 2023 09:57:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw71xx-2x
Message-ID: <20230719015750.GR9559@dragon>
References: <20230607170724.2016988-1-tharvey@gateworks.com>
 <20230607170724.2016988-2-tharvey@gateworks.com>
 <20230717002717.GI9559@dragon>
 <CAJ+vNU2Wn0jf8QyZsGiw3f=XThZEfXajhGJTmZz2mnJXgprAhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2Wn0jf8QyZsGiw3f=XThZEfXajhGJTmZz2mnJXgprAhQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:16:22PM -0700, Tim Harvey wrote:
> On Sun, Jul 16, 2023 at 5:27 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Wed, Jun 07, 2023 at 10:07:24AM -0700, Tim Harvey wrote:
> > > The Gateworks imx8mp-venice-gw71xx-2x consists of a SOM + baseboard.
> > >
> > > The GW702x SOM contains the following:
> > >  - i.MX8M Plus SoC
> > >  - LPDDR4 memory
> > >  - eMMC Boot device
> > >  - Gateworks System Controller (GSC) with integrated EEPROM, button
> > >    controller, and ADC's
> > >  - PMIC
> > >  - SOM connector providing:
> > >   - eQoS GbE MII
> > >   - 1x SPI
> > >   - 2x I2C
> > >   - 4x UART
> > >   - 2x USB 3.0
> > >   - 1x PCI
> > >   - 1x SDIO (4-bit 3.3V)
> > >   - 1x SDIO (4-bit 3.3V/1.8V)
> > >   - GPIO
> > >
> > > The GW71xx Baseboard contains the following:
> > >  - GPS
> > >  - RJ45 GbE (eQoS)
> > >  - off-board I/O connector with UART, I2C, SPI, GPIO
> > >  - EERPOM
> > >  - PCIe clock generator
> > >  - full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
> > >  - USB Type-C with USB 2.0 host and peripheral support
> > >  - Wide range DC input supply
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > >  .../dts/freescale/imx8mp-venice-gw71xx-2x.dts |  19 ++
> > >  .../dts/freescale/imx8mp-venice-gw71xx.dtsi   | 236 ++++++++++++++++++
> > >  3 files changed, 256 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > index 62f22b77b38b..b3bb823d0168 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw7905-2x.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > > new file mode 100644
> > > index 000000000000..53120fc9cd7f
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > > @@ -0,0 +1,19 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2023 Gateworks Corporation
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "imx8mp.dtsi"
> > > +#include "imx8mp-venice-gw702x.dtsi"
> > > +#include "imx8mp-venice-gw71xx.dtsi"
> > > +
> > > +/ {
> > > +     model = "Gateworks Venice GW71xx-2x i.MX8MP Development Kit";
> > > +     compatible = "gateworks,imx8mp-gw71xx-2x", "fsl,imx8mp";
> > > +
> > > +     chosen {
> > > +             stdout-path = &uart2;
> > > +     };
> > > +};
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > > new file mode 100644
> > > index 000000000000..86999f52d4b2
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > > @@ -0,0 +1,236 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2023 Gateworks Corporation
> > > + */
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/leds/common.h>
> > > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > > +
> > > +/ {
> > > +     led-controller {
> > > +             compatible = "gpio-leds";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_gpio_leds>;
> > > +
> > > +             led-0 {
> > > +                     function = LED_FUNCTION_STATUS;
> > > +                     color = <LED_COLOR_ID_GREEN>;
> > > +                     gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
> > > +                     default-state = "on";
> > > +                     linux,default-trigger = "heartbeat";
> > > +             };
> > > +
> > > +             led-1 {
> > > +                     function = LED_FUNCTION_STATUS;
> > > +                     color = <LED_COLOR_ID_RED>;
> > > +                     gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
> > > +                     default-state = "off";
> > > +             };
> > > +     };
> > > +
> > > +     pcie0_refclk: pcie0-refclk {
> >
> > Can we name the node clock-xxx?
> >
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <100000000>;
> > > +     };
> > > +
> > > +     pps {
> > > +             compatible = "pps-gpio";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_pps>;
> > > +             gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> > > +             status = "okay";
> > > +     };
> > > +};
> > > +
> > > +/* off-board header */
> > > +&ecspi2 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_spi2>;
> > > +     cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&gpio4 {
> > > +     gpio-line-names =
> > > +             "", "", "", "",
> > > +             "", "", "", "",
> > > +             "dio1", "", "", "dio0",
> > > +             "", "", "pci_usb_sel", "",
> > > +             "", "", "", "",
> > > +             "", "", "", "",
> > > +             "dio3", "", "dio2", "",
> > > +             "pci_wdis#", "", "", "";
> > > +};
> > > +
> > > +&i2c2 {
> > > +     clock-frequency = <400000>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_i2c2>;
> > > +     status = "okay";
> > > +
> > > +     accelerometer@19 {
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_accel>;
> > > +             compatible = "st,lis2de12";
> > > +             reg = <0x19>;
> >
> > Can we start the property list from these two?
> >
> > > +             st,drdy-int-pin = <1>;
> > > +             interrupt-parent = <&gpio4>;
> > > +             interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> > > +             interrupt-names = "INT1";
> > > +     };
> > > +};
> > > +
> > > +&pcie_phy {
> > > +     fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > > +     fsl,clkreq-unsupported;
> > > +     clocks = <&pcie0_refclk>;
> > > +     clock-names = "ref";
> > > +     status = "okay";
> > > +};
> > > +
> > > +&pcie {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_pcie0>;
> > > +     reset-gpio = <&gpio4 29 GPIO_ACTIVE_LOW>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +/* GPS */
> > > +&uart1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_uart1>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +/* off-board header */
> > > +&uart3 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_uart3>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +/* USB1 Type-C front panel */
> > > +&usb3_0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_usb1>;
> > > +     fsl,over-current-active-low;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb3_phy0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb_dwc3_0 {
> > > +     /* dual role is implemented but not a full featured OTG */
> > > +     adp-disable;
> > > +     hnp-disable;
> > > +     srp-disable;
> > > +     dr_mode = "otg";
> > > +     usb-role-switch;
> > > +     role-switch-default-mode = "peripheral";
> > > +     status = "okay";
> > > +
> > > +     connector {
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_usbcon1>;
> > > +             compatible = "gpio-usb-b-connector", "usb-b-connector";
> >
> > Start the properties from 'compatible'?
> >
> > Shawn
> >
> 
> Hi Shawn,
> 
> My notes say that pinctrl should come first (if needed) followed by
> compatible, reg, other props, and finally status (if needed). Assuming
> I'm wrong about that where in the list should pinctrl be and is this
> documented anywhere for future reference?

It's more a recommended idiom than documented/hard rule.

- compatible
- reg
- general properties
- vendor specific properties
- status

Shawn
