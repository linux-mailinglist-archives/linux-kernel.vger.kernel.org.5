Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208D759AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGSQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGSQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:20:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028241733
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:20:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b8390003e2so92021761fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1689783627; x=1692375627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE6Is2eLQJVnSm6mxat9UkFt1cQr6vv9ra4Rn8lKBE0=;
        b=qksWaB2bygJNidQYthcrJNS02xpeqYLu6aMgPGpSq9KEGxS7jz/OuskaD9jEg7Yg+i
         Z35DUqXlyewAdQwD7GoWPpq+LALDzyDpnuLM/Xc66xRO7BrtTjMbKw9/6GBAd5P0hhn7
         9hwLzjr0yprTOqdmkb8zUa7NliYfyoMfSznzCqZx0bANQoB9xyyH1BnZhkFfNZvd1htc
         W6Kez4kR3Qa7oLc/XT4vWbej9BvrgznaE2F9PWt2vFCwNWjOu/ny8Ecc1BgiKXWjEywk
         niOTVi36B4h9pBTuI4zNgRRj+H48V3VkWyFPdoilYmYbsQLFsGTY3kQFMT0N0VCZKzAM
         CIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783627; x=1692375627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE6Is2eLQJVnSm6mxat9UkFt1cQr6vv9ra4Rn8lKBE0=;
        b=jklRDakmD33unE4yhev8ikMwcOPBSu5rbR81XyrX0OodeUq5g2vMXzDPzT8JLH8sQX
         SLYBnWe8lvQYPtMLyl6MKIViCCVqP1dRbHXmAclsjf3ctUIOa1FpqCstrzgeuakSUS7F
         aJmwrC+lvUTPdhdA7Qsz+Ml4B14YJkYFDT2mMnz7Sc4yxzJSLxKMfPBYdfaLM7haFrZg
         hWRn+OczOtoLeys0DOBZHETRtk3wDpKUCFZgw//l0CSCrpMBTFmv8bk+LtL7sonLTRlq
         tat6INGOhf6n20+F8pBkwcqanWZd6ZR7d1KMbhfGJ+Tiwts40k333pNH2XjrkauRARGS
         t0+g==
X-Gm-Message-State: ABy/qLZIb150SnQ911bENBmis6ZowVS9AvgaeW/yJwG38Ue+2QCFwmK0
        oxUr9T2DoTccFXjuNDRc4YsLg9EO54CvWSME6Ao/pg==
X-Google-Smtp-Source: APBJJlGpIthV9lGnDiiKD699N3tMkUVJfhAy5s4ewEBqQgEX3nuLSqZSPZfPWPx7d4ks1PRUi9leawzaFUPrpxAaw/8=
X-Received: by 2002:a2e:3018:0:b0:2b5:7f93:b3b0 with SMTP id
 w24-20020a2e3018000000b002b57f93b3b0mr302705ljw.17.1689783627154; Wed, 19 Jul
 2023 09:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170724.2016988-1-tharvey@gateworks.com>
 <20230607170724.2016988-2-tharvey@gateworks.com> <20230717002717.GI9559@dragon>
 <CAJ+vNU2Wn0jf8QyZsGiw3f=XThZEfXajhGJTmZz2mnJXgprAhQ@mail.gmail.com> <20230719015750.GR9559@dragon>
In-Reply-To: <20230719015750.GR9559@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 19 Jul 2023 09:20:14 -0700
Message-ID: <CAJ+vNU0fvi5hD40PPEa_hQjZoDb0yzxJf=5+B=R2GZoRcs2GeA@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 6:58=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wro=
te:
>
> On Tue, Jul 18, 2023 at 02:16:22PM -0700, Tim Harvey wrote:
> > On Sun, Jul 16, 2023 at 5:27=E2=80=AFPM Shawn Guo <shawnguo@kernel.org>=
 wrote:
> > >
> > > On Wed, Jun 07, 2023 at 10:07:24AM -0700, Tim Harvey wrote:
> > > > The Gateworks imx8mp-venice-gw71xx-2x consists of a SOM + baseboard=
.
> > > >
> > > > The GW702x SOM contains the following:
> > > >  - i.MX8M Plus SoC
> > > >  - LPDDR4 memory
> > > >  - eMMC Boot device
> > > >  - Gateworks System Controller (GSC) with integrated EEPROM, button
> > > >    controller, and ADC's
> > > >  - PMIC
> > > >  - SOM connector providing:
> > > >   - eQoS GbE MII
> > > >   - 1x SPI
> > > >   - 2x I2C
> > > >   - 4x UART
> > > >   - 2x USB 3.0
> > > >   - 1x PCI
> > > >   - 1x SDIO (4-bit 3.3V)
> > > >   - 1x SDIO (4-bit 3.3V/1.8V)
> > > >   - GPIO
> > > >
> > > > The GW71xx Baseboard contains the following:
> > > >  - GPS
> > > >  - RJ45 GbE (eQoS)
> > > >  - off-board I/O connector with UART, I2C, SPI, GPIO
> > > >  - EERPOM
> > > >  - PCIe clock generator
> > > >  - full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
> > > >  - USB Type-C with USB 2.0 host and peripheral support
> > > >  - Wide range DC input supply
> > > >
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > > >  .../dts/freescale/imx8mp-venice-gw71xx-2x.dts |  19 ++
> > > >  .../dts/freescale/imx8mp-venice-gw71xx.dtsi   | 236 ++++++++++++++=
++++
> > > >  3 files changed, 256 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw7=
1xx-2x.dts
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw7=
1xx.dtsi
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/bo=
ot/dts/freescale/Makefile
> > > > index 62f22b77b38b..b3bb823d0168 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-=
edimm2.2.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw71xx-2x.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw74xx.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw7905-2x.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-verdin-nonwifi-dahlia.dtb
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.=
dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > > > new file mode 100644
> > > > index 000000000000..53120fc9cd7f
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> > > > @@ -0,0 +1,19 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright 2023 Gateworks Corporation
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "imx8mp.dtsi"
> > > > +#include "imx8mp-venice-gw702x.dtsi"
> > > > +#include "imx8mp-venice-gw71xx.dtsi"
> > > > +
> > > > +/ {
> > > > +     model =3D "Gateworks Venice GW71xx-2x i.MX8MP Development Kit=
";
> > > > +     compatible =3D "gateworks,imx8mp-gw71xx-2x", "fsl,imx8mp";
> > > > +
> > > > +     chosen {
> > > > +             stdout-path =3D &uart2;
> > > > +     };
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dts=
i b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > > > new file mode 100644
> > > > index 000000000000..86999f52d4b2
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> > > > @@ -0,0 +1,236 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright 2023 Gateworks Corporation
> > > > + */
> > > > +
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/leds/common.h>
> > > > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > > > +
> > > > +/ {
> > > > +     led-controller {
> > > > +             compatible =3D "gpio-leds";
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_gpio_leds>;
> > > > +
> > > > +             led-0 {
> > > > +                     function =3D LED_FUNCTION_STATUS;
> > > > +                     color =3D <LED_COLOR_ID_GREEN>;
> > > > +                     gpios =3D <&gpio4 1 GPIO_ACTIVE_HIGH>;
> > > > +                     default-state =3D "on";
> > > > +                     linux,default-trigger =3D "heartbeat";
> > > > +             };
> > > > +
> > > > +             led-1 {
> > > > +                     function =3D LED_FUNCTION_STATUS;
> > > > +                     color =3D <LED_COLOR_ID_RED>;
> > > > +                     gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>;
> > > > +                     default-state =3D "off";
> > > > +             };
> > > > +     };
> > > > +
> > > > +     pcie0_refclk: pcie0-refclk {
> > >
> > > Can we name the node clock-xxx?
> > >
> > > > +             compatible =3D "fixed-clock";
> > > > +             #clock-cells =3D <0>;
> > > > +             clock-frequency =3D <100000000>;
> > > > +     };
> > > > +
> > > > +     pps {
> > > > +             compatible =3D "pps-gpio";
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_pps>;
> > > > +             gpios =3D <&gpio4 3 GPIO_ACTIVE_HIGH>;
> > > > +             status =3D "okay";
> > > > +     };
> > > > +};
> > > > +
> > > > +/* off-board header */
> > > > +&ecspi2 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_spi2>;
> > > > +     cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&gpio4 {
> > > > +     gpio-line-names =3D
> > > > +             "", "", "", "",
> > > > +             "", "", "", "",
> > > > +             "dio1", "", "", "dio0",
> > > > +             "", "", "pci_usb_sel", "",
> > > > +             "", "", "", "",
> > > > +             "", "", "", "",
> > > > +             "dio3", "", "dio2", "",
> > > > +             "pci_wdis#", "", "", "";
> > > > +};
> > > > +
> > > > +&i2c2 {
> > > > +     clock-frequency =3D <400000>;
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_i2c2>;
> > > > +     status =3D "okay";
> > > > +
> > > > +     accelerometer@19 {
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_accel>;
> > > > +             compatible =3D "st,lis2de12";
> > > > +             reg =3D <0x19>;
> > >
> > > Can we start the property list from these two?
> > >
> > > > +             st,drdy-int-pin =3D <1>;
> > > > +             interrupt-parent =3D <&gpio4>;
> > > > +             interrupts =3D <21 IRQ_TYPE_LEVEL_LOW>;
> > > > +             interrupt-names =3D "INT1";
> > > > +     };
> > > > +};
> > > > +
> > > > +&pcie_phy {
> > > > +     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > > > +     fsl,clkreq-unsupported;
> > > > +     clocks =3D <&pcie0_refclk>;
> > > > +     clock-names =3D "ref";
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&pcie {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_pcie0>;
> > > > +     reset-gpio =3D <&gpio4 29 GPIO_ACTIVE_LOW>;
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +/* GPS */
> > > > +&uart1 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_uart1>;
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +/* off-board header */
> > > > +&uart3 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_uart3>;
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +/* USB1 Type-C front panel */
> > > > +&usb3_0 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_usb1>;
> > > > +     fsl,over-current-active-low;
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&usb3_phy0 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&usb_dwc3_0 {
> > > > +     /* dual role is implemented but not a full featured OTG */
> > > > +     adp-disable;
> > > > +     hnp-disable;
> > > > +     srp-disable;
> > > > +     dr_mode =3D "otg";
> > > > +     usb-role-switch;
> > > > +     role-switch-default-mode =3D "peripheral";
> > > > +     status =3D "okay";
> > > > +
> > > > +     connector {
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_usbcon1>;
> > > > +             compatible =3D "gpio-usb-b-connector", "usb-b-connect=
or";
> > >
> > > Start the properties from 'compatible'?
> > >
> > > Shawn
> > >
> >
> > Hi Shawn,
> >
> > My notes say that pinctrl should come first (if needed) followed by
> > compatible, reg, other props, and finally status (if needed). Assuming
> > I'm wrong about that where in the list should pinctrl be and is this
> > documented anywhere for future reference?
>
> It's more a recommended idiom than documented/hard rule.
>
> - compatible
> - reg
> - general properties
> - vendor specific properties
> - status
>

ok, thank you for the clarification.

I will submit a new version of:
arm64: dts: freescale: Add imx8mp-venice-gw73xx-2x
arm64: dts: freescale: Add imx8mp-venice-gw72xx-2x
arm64: dts: freescale: Add imx8mp-venice-gw71xx-2x
arm64: dts: freescale: Add imx8mm-venice-gw7905-0x

best regards,

Tim
