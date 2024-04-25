Return-Path: <linux-kernel+bounces-158181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D574F8B1CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5546B2362F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46A278C68;
	Thu, 25 Apr 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lAtFCm50"
Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5574437
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032689; cv=none; b=eNCJeagKvuJh8GDXJN6TjYEqiGe/Jz66W95oVU8aEBi+v+DjDrvKYRI0ZXd1+l2Yz4BC5NYbDgdjaq5TDhCNbiZR0ST3ghUV7ND78eehOFwX3WzTtLSqQLt2JCBOqCxhNzCEKsP8gKdyQIGysDSASnytbQqCjkLf7KedY8gxvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032689; c=relaxed/simple;
	bh=xITDB7UKgCxQTUlRqzOvcHkRmrO0TzMhT36ooI6yReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fESIoPH9xzVabSyH4Kmf/GYtS0/yvrpn5888rDVruvoHfffP/4GL6go1ds02itxPT3pecLnQ3rSwAiagKjJx+Ym3/9OjWJZ7jQ5XxqTCdxdSawgT2vbZXPOJirbjjng/T2Je/59cFcsJl7li08MLSq5C5nrWLCgCBwRuSY05/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=lAtFCm50; arc=none smtp.client-ip=62.149.156.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.5.97])
	by Aruba Outgoing Smtp  with ESMTPSA
	id zu9OrLBIrTSwmzu9QrYPoi; Thu, 25 Apr 2024 10:08:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714032496; bh=xITDB7UKgCxQTUlRqzOvcHkRmrO0TzMhT36ooI6yReU=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=lAtFCm50kWBXTrfufeZzItaWHAg2Zn4PLdP+/QNXCQbWTBSUx+xTK+waPMiHQFHHr
	 q5HRUP7tJkM5D2LFMXUlvliJBtYkJwrjoiInOWUV283foI0SKrKmZm3VLRqyyqkWZW
	 pKfOZAabOVv8jEPRi8f61FNXM2bM9iqhqJCptNTw5dBWTFpqzX5k+ADl25p8cEFwpa
	 Z+ud1LbekAcok3uiVXKhrCaPYUxooN5aIC6ax8Y9QSJM9VmKRRJyXpmk6i9ahD17Ee
	 KfbXX7zmh8lJ300HLHETP3MQHeKopPdhjs6IuPpsiuEaKj/cCEchczLZ/YfESbASjx
	 ZD0JHKVVB9ovA==
Date: Thu, 25 Apr 2024 10:08:14 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
Message-ID: <ZioPbmPmIuKME7zl@engicam>
References: <20240419144953.8700-1-fabio.aiuto@engicam.com>
 <20240419144953.8700-4-fabio.aiuto@engicam.com>
 <ZioJ032d0ZgwKbli@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZioJ032d0ZgwKbli@dragon>
X-CMAE-Envelope: MS4xfEw2TEhR79G8KBdkloDMFZ13/DFcmttqslcwtXPGe8mgYNSYBVH7RHr+TmJ87iZQYslrqpnMYgGuFPJ+2sfpkR8ldW4jXps7rE3qln8jliUQHO6DBRbf
 HZQOthm8zhPm8Ws8VQuhp+UpoCs+4DTzBfsSJQfzH0lSCAPFuJfLVUq7Jp6Sy3P5YcVXjRT2fQ3zbFEtj8/XEPmG1mga9sIaW0FbZX2mXUYtVm/CjgBzVXo0
 YJk5JvMQ+i7QN0henzkXiz8fk+nx1sWaObXJcMpUIDD1NbEE8/6gpf1yVKiERUd4doH8lvWe8yLNnRX3OEudxSQzcSBj91nEEJmF8grevjmq6vB7xEcK1iTZ
 Sx1eOLPcXyKDA5OvAlNOoU/xQXvuxT+8rnQyKTguKJMEdrYdZbG2/LefaDt0BnC0I9mNZG2oUCaBk3/HOw+TPjyO4uf2yZFbhv6ALEoA24Fc0Y9evdbtZurC
 3Yb2WUjDf6gESBJhDc03CC1qeCC0/OGjXT/cgzbGDpDdUqfp/3VAyPozYtBynkGZRUrIC4MN7Tg2DYrWNbLorMz2k7AXQacYqbRzR+R0g/rbuO3O70t/FJAN
 6Xk=

Dear Shawn,

Il Thu, Apr 25, 2024 at 03:44:19PM +0800, Shawn Guo ha scritto:
> On Fri, Apr 19, 2024 at 04:49:53PM +0200, Fabio Aiuto wrote:

<snip>

> > +	usdhc3_pwrseq: usdhc3-pwrseq {
> 
> Can we drop it, as it's unused?
> 
> > +		compatible = "mmc-pwrseq-simple";
> 
> It controls nothing, neither clock nor GPIO?

please see v4.

Thank you for your comments, will fix all issues in a v5
patchset.

kr, fabio

> 
> > +	};
> > +
> > +	wl_reg_on: regulator-wlregon {
> > +		compatible = "regulator-gpio";
> > +		regulator-name = "WL_REG_ON";
> > +		regulator-min-microvolt = <100000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		states = <3300000 0x1>, <100000 0x0>;
> > +		gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		vin-supply = <&bt_reg_on>;
> > +	};
> > +};
> > +
> > +&cm33 {
> > +	mbox-names = "tx", "rx", "rxdb";
> > +	mboxes = <&mu1 0 1>,
> > +		 <&mu1 1 1>,
> > +		 <&mu1 3 1>;
> > +	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > +			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > +	status = "okay";
> > +};
> > +
> > +&flexcan1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_flexcan1>;
> > +	fsl,stop-mode = <&aonmix_ns_gpr 0x10 4>;
> > +	status = "okay";
> > +};
> > +
> > +&flexcan2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_flexcan2>;
> > +	fsl,stop-mode = <&aonmix_ns_gpr 0x10 4>;
> > +	status = "okay";
> > +};
> > +
> > +&lpi2c1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&pinctrl_lpi2c1>;
> > +	pinctrl-1 = <&pinctrl_lpi2c1>;
> > +	status = "okay";
> > +
> > +	pcf8523: rtc@68 {
> > +		compatible = "nxp,pcf8523";
> > +		reg = <0x68>;
> > +	};
> > +
> > +	sgtl5000: codec@a {
> 
> audio-codec for the node name.  And we should sort slave nodes in unit-address.
> 
> > +		compatible = "fsl,sgtl5000";
> > +		status = "okay";
> 
> 'compatible' first, 'reg' second, and 'status' last. 
> 
> > +		#sound-dai-cells = <0>;
> > +		reg = <0x0a>;
> > +		clocks = <&clk IMX93_CLK_SAI3_GATE>;
> > +		VDDA-supply = <&reg_3v3_avdd_sgtl>;
> > +		VDDIO-supply = <&reg_3v3_sgtl>;
> > +		VDDD-supply = <&reg_1v8_sgtl>;
> > +	};
> > +};
> > +
> > +&lpuart1 { /* console */
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart1>;
> > +	status = "okay";
> > +};
> > +
> > +&lpuart5 { /* RS485 */
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart5>;
> > +	status = "okay";
> > +};
> > +
> > +&lpuart8 { /* RS232 */
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart8>;
> > +	status = "okay";
> > +};
> > +
> > +&micfil {
> > +	#sound-dai-cells = <0>;
> > +	assigned-clocks = <&clk IMX93_CLK_PDM>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> > +	assigned-clock-rates = <196608000>;
> > +	status = "okay";
> > +};
> > +
> > +&mu1 {
> > +	status = "okay";
> > +};
> > +
> > +&mu2 {
> > +	status = "okay";
> > +};
> > +
> > +&sai1 {
> > +	#sound-dai-cells = <0>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_sai1>;
> > +	assigned-clocks = <&clk IMX93_CLK_SAI1>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> > +	assigned-clock-rates = <12288000>;
> > +	status = "okay";
> > +};
> > +
> > +&sai3 {
> > +	pinctrl-names = "default";
> > +	#sound-dai-cells = <0>;
> > +	pinctrl-0 = <&pinctrl_sai3>;
> 
> pinctrl-0 right after pinctrl-names.
> 
> > +	assigned-clocks = <&clk IMX93_CLK_SAI3>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> > +	assigned-clock-rates = <24576000>;
> > +	fsl,sai-mclk-direction-output;
> > +	status = "okay";
> > +};
> > +
> > +&usdhc3 { /* WiFi */
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
> > +	pinctrl-1 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
> > +	pinctrl-2 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
> > +	vmmc-supply = <&wl_reg_on>;
> > +	bus-width = <4>;
> > +	no-1-8-v;
> > +	non-removable;
> > +	max-frequency = <25000000>;
> > +	status = "okay";
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> 
> Drop newline and move them before pinctrl-names.
> 
> > +
> > +	brcmf: bcrmf@1 {
> > +		reg = <1>;
> > +		compatible = "brcm,bcm4329-fmac";
> 
> Flip the order.
> 
> > +	};
> > +};
> > +
> > +&wdog3 {
> > +	status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +
> 
> Drop newline.
> 
> > +	pinctrl_flexcan1: flexcan1grp {
> > +		fsl,pins = <
> > +			MX93_PAD_PDM_CLK__CAN1_TX		0x139e
> > +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
> > +		>;
> > +	};
> > +
> > +	pinctrl_flexcan2: flexcan2grp {
> > +		fsl,pins = <
> > +			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
> > +			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
> 
> Try to vertically align hex values.
> 
> > +		>;
> > +	};
> > +
> > +	pinctrl_laird: lairdgrp {
> > +		fsl,pins = <
> > +			MX93_PAD_GPIO_IO22__GPIO2_IO22		0x31e // WL_REG_ON
> > +			MX93_PAD_GPIO_IO19__GPIO2_IO19		0x31e // BT_REG_ON
> 
> /* ... */ for comments.
> 
> Shawn
> 
> > +		>;
> > +	};
> > +
> > +	pinctrl_lpi2c1: lpi2c1grp {
> > +		fsl,pins = <
> > +			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
> > +			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
> > +		>;
> > +	};
> > +
> > +	pinctrl_sai1: sai1grp {
> > +		fsl,pins = <
> > +			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK		0x31e
> > +			MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC	0x31e
> > +			MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00	0x31e
> > +			MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00	0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_sai3: sai3grp {
> > +		fsl,pins = <
> > +			MX93_PAD_GPIO_IO26__SAI3_TX_SYNC	0x31e
> > +			MX93_PAD_GPIO_IO16__SAI3_TX_BCLK	0x31e
> > +			MX93_PAD_GPIO_IO17__SAI3_MCLK		0x31e
> > +			MX93_PAD_GPIO_IO21__SAI3_TX_DATA00	0x31e
> > +			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00	0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart1: uart1grp {
> > +		fsl,pins = <
> > +			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
> > +			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart5: uart5grp {
> > +		fsl,pins = <
> > +			MX93_PAD_GPIO_IO01__LPUART5_RX		0x31e
> > +			MX93_PAD_GPIO_IO00__LPUART5_TX		0x31e
> > +			MX93_PAD_GPIO_IO02__LPUART5_CTS_B	0x31e
> > +			MX93_PAD_GPIO_IO03__LPUART5_RTS_B	0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart8: uart8grp {
> > +		fsl,pins = <
> > +			MX93_PAD_GPIO_IO13__LPUART8_RX		0x31e
> > +			MX93_PAD_GPIO_IO12__LPUART8_TX		0x31e
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc3: usdhc3grp {
> > +		fsl,pins = <
> > +			MX93_PAD_SD3_CLK__USDHC3_CLK		0x17fe
> > +			MX93_PAD_SD3_CMD__USDHC3_CMD		0x13fe
> > +			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
> > +			MX93_PAD_SD3_DATA1__USDHC3_DATA1        0x13fe
> > +			MX93_PAD_SD3_DATA2__USDHC3_DATA2        0x13fe
> > +			MX93_PAD_SD3_DATA3__USDHC3_DATA3        0x13fe
> > +		>;
> > +	};
> > +};
> > -- 
> > 2.34.1
> > 
> 

