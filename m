Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD67DF5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjKBPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKBPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:10:49 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E3DC;
        Thu,  2 Nov 2023 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=6SoiL9YhDyjvs2Md8/XpQozMsOuUsRO0bsuBElGwhzc=; b=U6mMWjbWiqdGE0I0nEXGrFLvGU
        5zfFBJBIDIMT2rADo5z4b1ETwlPKv0wIeaztdVrDrqoWMe6AgY1Wwy8cqucLX4Xl/dA+UcE0S4GB4
        3r1djHOQwpucY4hoHJjU0QiXGFbcJ2w6H/tfClD0QK8xySvjkYsSdCeyHV8XcyiGDsW0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33560 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qyZKz-00081h-1c; Thu, 02 Nov 2023 11:10:29 -0400
Date:   Thu, 2 Nov 2023 11:10:24 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, leoyang.li@nxp.com, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-Id: <20231102111024.5b67f6b1bc238f3e1612463a@hugovil.com>
In-Reply-To: <223f6bfe-4e99-4b04-98e8-73fc43dcd212@linaro.org>
References: <20231101183549.2960083-1-hugo@hugovil.com>
        <20231101183549.2960083-4-hugo@hugovil.com>
        <223f6bfe-4e99-4b04-98e8-73fc43dcd212@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 3/3] arm64: dts: freescale: introduce rve-gateway
 board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 08:36:32 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 01/11/2023 19:35, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The RVE gateway board is based on a Variscite VAR-SOM-NANO,
> > with a NXP MX8MN nano CPU.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  MAINTAINERS                                   |   7 +
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../boot/dts/freescale/imx8mn-rve-gateway.dts | 284 ++++++++++++++++++
> >  3 files changed, 292 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 43c5ed3c4508..9423b1bf35fc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18778,6 +18778,13 @@ F:	samples/rust/
> >  F:	scripts/*rust*
> >  K:	\b(?i:rust)\b
> >  
> > +RVE BOARD SUPPORT
> > +M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Supported
> > +W:	https://rve.ca
> > +F:	arch/arm64/boot/dts/freescale/imx*rve-*.dts*
> 
> I still don't think individual boards should receive maintainer entry.
> https://lore.kernel.org/all/20210809080204.8381-1-shawnguo@kernel.org/

Hi,
ok, I was not aware of that. Will drop it for V3.


> > +
> >  RXRPC SOCKETS (AF_RXRPC)
> >  M:	David Howells <dhowells@redhat.com>
> >  M:	Marc Dionne <marc.dionne@auristor.com>
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 89aee6c92576..760a0ca7adc3 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -89,6 +89,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr3l-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mn-rve-gateway.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> > new file mode 100644
> > index 000000000000..312718982a52
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> > @@ -0,0 +1,284 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2023 DimOnOff
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/usb/pd.h>
> > +#include "imx8mn-var-som.dtsi"
> > +
> > +/ {
> > +	model = "RVE gateway";
> > +	compatible = "rve,rve-gateway", "fsl,imx8mn";
> 
> Missing compatible of SoM.

Fixed in V3.


> 
> > +
> > +	crystal_duart_24m: crystal-duart-24m {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +		status = "okay";
> 
> Drop

Fixed in V3.

> 
> > +
> > +		key-enter {
> > +			label = "enter";
> > +			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_ENTER>;
> > +		};
> > +
> > +		key-exit {
> > +			label = "exit";
> > +			gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_ESC>;
> > +		};
> > +	};
> > +
> > +	lcd {
> > +		compatible = "hit,hd44780";
> > +		display-height-chars = <2>;
> > +		display-width-chars = <20>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_lcd>;
> > +		data-gpios =
> > +			<&gpio5  1 GPIO_ACTIVE_HIGH>,
> 
> This should be after =, with the reset of lines properly aligned.

Fixed in V3.

> 
> > +			<&gpio1  6 GPIO_ACTIVE_HIGH>,
> > +			<&gpio1 14 GPIO_ACTIVE_HIGH>,
> > +			<&gpio4 28 GPIO_ACTIVE_HIGH>,
> > +			<&gpio5 24 GPIO_ACTIVE_HIGH>,
> > +			<&gpio5  2 GPIO_ACTIVE_HIGH>,
> > +			<&gpio1 12 GPIO_ACTIVE_HIGH>,
> > +			<&gpio5 25 GPIO_ACTIVE_HIGH>;
> > +		enable-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
> > +		rs-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> > +		rw-gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	reg_3p3v: regulator-3p3v {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "3P3V";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +		};
> 
> Fix indentation.

Fixed in V3.

> 
> > +
> > +	rotary: rotary-encoder { /* Bourns PEC12R rotary encoder, 24 steps. */
> 
> No comments after {. Put them in line before or after. This applies to
> other places as well.

Fixed all in V3.

> 
> > +		compatible = "rotary-encoder";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_rotary>;
> > +		gpios =
> > +			<&gpio1  5 GPIO_ACTIVE_LOW>, /* A */
> 
> This should be after =, with the reset of lines properly aligned.

Fixed in V3.

> 
> 
> > +			<&gpio3 21 GPIO_ACTIVE_LOW>; /* B */
> > +		linux,axis = <0>; /* REL_X */
> > +		rotary-encoder,encoding = "gray";
> > +		rotary-encoder,relative-axis;
> > +	};
> > +};
> > +
> > +&ecspi1 {
> > +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> > +
> > +	duart1: serial@0 {
> > +		compatible = "nxp,sc16is752";
> > +		reg = <0>;
> > +		spi-rx-bus-width = <1>;
> > +		spi-tx-bus-width = <1>;
> > +		spi-max-frequency = <4000000>;
> > +		clocks = <&crystal_duart_24m>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-line-names = "RADIO0", "RADIO1", "RADIO2", "RADIO3",
> > +		"RADIO4", "RADIO_RESET", "TP12", "TP11";
> > +		linux,rs485-enabled-at-boot-time;
> > +		rs485-rts-active-low;
> > +	};
> > +
> > +	/delete-node/ touchscreen@0;
> > +};
> > +
> > +&ecspi2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi2>;
> > +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +	/delete-property/ dmas;
> > +	/delete-property/ dma-names;
> > +	status = "okay";
> > +
> > +	duart2: serial@0 {
> > +		compatible = "nxp,sc16is752";
> > +		reg = <0>;
> > +		spi-rx-bus-width = <1>;
> > +		spi-tx-bus-width = <1>;
> > +		spi-max-frequency = <4000000>;
> > +		clocks = <&crystal_duart_24m>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-line-names = "LED_B_USER", "LED_R_USER", "LED_G_USER",
> > +		"GPIO_EXT3", "GPIO_EXT2", "GPIO_EXT1", "GPIO_EXT0", "TP13";
> > +		linux,rs485-enabled-at-boot-time;
> > +		rs485-rts-active-low;
> > +	};
> > +};
> > +
> > +/* Configure PWM pins in GPIO mode: */
> > +&gpio5 {
> > +	gpio-line-names = "", "", "", "PWM3", "PWM2", "PWM1";
> > +};
> > +
> > +&gpu {
> > +	status = "disabled";
> > +};
> > +
> > +&i2c2 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c2>;
> > +	status = "okay";
> > +
> > +	eeprom_cb: eeprom@56 { /* Carrier board EEPROM */
> > +		compatible = "atmel,24c04";
> > +		reg = <0x56>;
> > +		pagesize = <16>;
> > +		vcc-supply = <&reg_3p3v>;
> > +	};
> > +
> > +	lm75: sensor@48 {
> > +		compatible = "st,stlm75";
> > +		reg = <0x48>;
> > +		vs-supply = <&reg_3p3v>;
> > +	};
> > +
> > +	mcp7940: rtc@6f {
> > +		compatible = "microchip,mcp7940x";
> > +		reg = <0x6f>;
> > +	};
> > +};
> > +
> > +&i2c3 {
> > +	codec@1a {
> > +		status = "disabled";
> > +	};
> > +};
> > +
> > +&i2c4 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c4>;
> > +	status = "okay";
> > +
> > +	pcf8574_1: gpio@38 {
> > +		status = "okay";
> 
> Drop

Fixed all in V3.

> 
> > +		compatible = "nxp,pcf8574";
> > +		reg = <0x38>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-line-names = "LED_B_COMM3", "LED_R_COMM3", "LED_G_COMM3",
> > +		"TP14", "TP15", "LED_G_COMM4", "LED_R_COMM4", "LED_B_COMM4";
> > +	};
> > +
> > +	pcf8574_2: gpio@39 {
> > +		status = "okay";
> 
> Drop
> 
> 
> > +		compatible = "nxp,pcf8574";
> > +		reg = <0x39>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-line-names = "LED_B_COMM2", "LED_G_COMM2", "LED_B_COMM1",
> > +		"LED_R_COMM2", "LED_R_COMM1", "LED_G_COMM1", "TP16", "TP17";
> > +	};
> > +};
> > +
> > +&uart2 {
> > +	/delete-node/ bluetooth;
> 
> Why? If the hardware does not exist, why it is even in the DTSI? It does
> exist, so removing is not correct.

The current SOM DTSI is a melting pot of all "potentially" available
hardware, but there are a lot of SOM versions, with different
combinations of hardware components that can be populated or not...

The hardware do exist on some of our SOM versions, but not on some
others, and we do not use it at the moment.

In V3 I changed the line to:
    status = "disabled";

> 
> 
> > +};
> > +
> > +&usbotg1 {
> > +	dr_mode = "host";
> > +	disable-over-current;
> > +	status = "okay";
> > +};
> > +
> > +/* SD interface on expansion connector. */
> > +&usdhc2 {
> > +	/delete-property/vmmc-supply;
> 
> Why? The supply is needed.

The SOM dtsi references a regulator named reg_usdhc2_vmmc, but it
is not present in the SOM dtsi itself. Since we do not have such a
dedicated usdhc2 regulator on our board, initially I did this to get
rid of this error:
    Reference to non-existent node or label "reg_usdhc2_vmmc"

But for V3, I will change the vmmc-supply to refer to our board fixed
3.3V regulator:

 &usdhc2 {
+       vmmc-supply = <&reg_3p3v>;

Thank you for the review.

Hugo.


> 
> 
> Best regards,
> Krzysztof
> 
> 
