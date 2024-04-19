Return-Path: <linux-kernel+bounces-151347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6488AAD49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFD41C20DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20A81203;
	Fri, 19 Apr 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="f0HDg5vv"
Received: from smtpdh18-2.aruba.it (smtpdh18-2.aruba.it [62.149.155.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC47F7C3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524677; cv=none; b=bJvi+4a4EKyWcYlm7Li5g6jL0VLUUScbvetneDQZqG770vhClGO2nzKcuHCkuS6Qz7PtBDsKlV+I/u60jxoC+hvIuteT3UNw75h214hvZEWhgdcO447chR99TBWAtNAcoYkZCjEKS8MK9h0CYCjUy95Hy06Yq0JsGggKpkIlfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524677; c=relaxed/simple;
	bh=34ds8pezHaM8zXbo0rmCy4/NhMnoDRXFp3berQVnbqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTWMyc9PMyzvLg9EAgUz8rXfzoAcfZPJ1/57tgKorclTuj15r0qqBskPqJ1gGtt8TWzGAYOJYDmUno8khPHt1MFyUDlEb/1OKYKR9H2o1agGBDY6UB/aDX0f8pcfJ+5hCC6zTR3FDYWfnrBkQfLfywCPE9CPT59P1AJFfV14+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=f0HDg5vv; arc=none smtp.client-ip=62.149.155.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.22.218])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xlzfrZWY8wcFexlzgrNLR8; Fri, 19 Apr 2024 13:01:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713524485; bh=34ds8pezHaM8zXbo0rmCy4/NhMnoDRXFp3berQVnbqY=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=f0HDg5vvdopiAbL1mEWcSejSAEUD+vJkFHp8U/RWpon4kcKeAFjYiZ6hBj/fs1E8d
	 qHm/7RklsfjOJFQALl49OJAJDWwNiqaVEpcBzvflm4ILCuAmp1srFCtkIRSkKGrkQP
	 wP02gN2bFl3R0hdii1wns320D8SGMnfZ3bxBxTmjI9ZAzvfZCfRyGnAIiGyUaCpUYa
	 6+q1Rj/oGSofoEe9F0Q5GEO+OxBAg7dgEqHESFUxMk+fiYzmXbijYmiKycSBJUDfMQ
	 A65qaTA2ihT9lf1ryEoqnjY+oFF8rzcK9vrboCTs1bU3D9m71bSg6sHZKk4mSoqv6k
	 VQjufBKJoAIHA==
Date: Fri, 19 Apr 2024 13:01:22 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
Message-ID: <ZiJPAr91xzBhuWbF@engicam>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
 <20240418133923.3705-4-fabio.aiuto@engicam.com>
 <CAOf5uwmy_3NOupkroYX=W2WJKK1sgg0r0L22fOrbbZ3Z6z1jFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwmy_3NOupkroYX=W2WJKK1sgg0r0L22fOrbbZ3Z6z1jFA@mail.gmail.com>
X-CMAE-Envelope: MS4xfDq01KQxM5pcyd7Ph2lUxkEV+kMY3uThS5wlw58h4inUqJULoKSusFE8hXDkuaM5c2VuflrPauWHAbMqZ8IDoJhD16+070WjX7BR7gT2O/wpBjYlfMib
 74lvy+WPrWEttlY76pSiZj0JmdkgnUa1wazzL0ZAVz/2hKVZ6odxgliy0tL+ju/xFxCoYL+vQH3oilBEap40ZeoX4XFNIv0GALJzxQLl7tJLKV+whxHcE6sh
 5OP/LhZfuLW1IpYyJs9heExMJrZJCDeembyC12yNAAkRsq9Ac+vjK79jk7c2puiljP5r6IoCoJOuch4Aj+PyhYk8GJtNAVhbzmmckBxK5+r8IxYbh5X5sn4L
 T5Ry+SlRBhTPGIUM8B6CEvB21VaMYl5KE6VjsbGh921wyKtqfa8XKoGR3dxg/EiBHjS5NRyOJMyxZlyxAD5J8qgFdMbXRTsHjbx7rwhExTOYmoXaFjrd5r+R
 3I2l7TO2YBcnG2mN4/t7u6k0AYCtedaLw8Lm7UphpUwFlWsQ051diQj1vaIqHL7+tRnXuVDtDl30R3MgMeoF/rTf05GHdy9y1Bxf2/bS63xNbcukP5s3VrSE
 9LFfCvBd0OKUsgOfrZ3MIhkU

Hello Michael,

Il Fri, Apr 19, 2024 at 09:29:12AM +0200, Michael Nazzareno Trimarchi ha scritto:
> Hi Fabio
> 
> On Thu, Apr 18, 2024 at 3:43 PM Fabio Aiuto <fabio.aiuto@engicam.com> wrote:
> >
> > i.Core MX93 is a NXP i.MX93 based SoM by Enigcam which
> > needs to be mounted on top of Engicam baseboards.
> >
> > Add support for EDIMM 2.0 Starter Kit hosting
> > i.Core MX93.
> >
> > Starter Kit main features:
> >
> > 2x LVDS interfaces
> > HDMI output
> > Audio out
> > Mic in
> > Micro SD card slot
> > USB 3.0 A port
> > 3x USB 2.0 A port
> > Gb Ethernet
> > 2x CAN bus, 3x UART interfaces
> > SIM card slot
> > M.2 KEY_B slot
> >
> > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> > Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx93-icore-mx93-edimm2.dts | 354 ++++++++++++++++++
> >  2 files changed, 355 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 045250d0a040..d26c0a458a44 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -226,6 +226,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx93-icore-mx93-edimm2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> > new file mode 100644
> > index 000000000000..8d57374eebdf
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> > @@ -0,0 +1,354 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2022 NXP
> > + * Copyright 2024 Engicam s.r.l.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx93-icore-mx93.dtsi"
> > +
> > +/ {
> > +       model = "Engicam i.Core MX93 - EDIMM 2 Starterkit";
> > +       compatible = "engicam,icore-mx93-edimm2", "engicam,icore-mx93",
> > +                    "fsl,imx93";
> > +
> > +       aliases {
> > +               rtc1 = &bbnsm_rtc;
> > +       };
> > +
> > +       bt_reg_on: regulator-btregon {
> > +               compatible = "regulator-gpio";
> > +               regulator-name = "BT_REG_ON";
> > +               pinctrl-names = "default";
> > +               regulator-min-microvolt = <100000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               states = <3300000 0x1>, <100000 0x0>;
> > +               gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > +               regulator-always-on;
> > +       };
> > +
> 
> Are you sure about regulator always on? I have seen that you broadcom
> wifi and bluetooth connected. Same comment for the other
> patches where you have almost all the regulator boot on , always on. I
> can not be sure that is really true
> 
> Please take a look here
> arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi

thank you for your comment, for wifi/bt module is better to
remove regulator-always-on.

For other regulators (e.g. sgtl5000) they are fixed and always on
from an hardware design point of view.

Will remove regulator-always-on for bt_reg_on in the v3 patchset.

kr,

fabio 

> 
> Michael
> 
> > +       chosen {
> > +               stdout-path = &lpuart1;
> > +       };
> > +
> > +       reg_1v8_sgtl: regulator-1v8-sgtl {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "1v8_sgtl";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               always-on;
> > +       };
> > +
> > +       reg_3v3_avdd_sgtl: regulator-3v3-avdd-sgtl {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "3v3_avdd_sgtl";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               always-on;
> > +       };
> > +
> > +       reg_3v3_sgtl: regulator-3v3-sgtl {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "3v3_sgtl";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               always-on;
> > +       };
> > +
> > +       reserved-memory {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               linux,cma {
> > +                       compatible = "shared-dma-pool";
> > +                       reusable;
> > +                       alloc-ranges = <0 0x80000000 0 0x40000000>;
> > +                       size = <0 0x10000000>;
> > +                       linux,cma-default;
> > +               };
> > +
> > +               rsc_table: rsc-table@2021f000 {
> > +                       reg = <0 0x2021f000 0 0x1000>;
> > +                       no-map;
> > +               };
> > +
> > +               vdevbuffer: vdevbuffer@a4020000 {
> > +                       compatible = "shared-dma-pool";
> > +                       reg = <0 0xa4020000 0 0x100000>;
> > +                       no-map;
> > +               };
> > +
> > +               vdev0vring0: vdev0vring0@a4000000 {
> > +                       reg = <0 0xa4000000 0 0x8000>;
> > +                       no-map;
> > +               };
> > +
> > +               vdev0vring1: vdev0vring1@a4008000 {
> > +                       reg = <0 0xa4008000 0 0x8000>;
> > +                       no-map;
> > +               };
> > +
> > +               vdev1vring0: vdev1vring0@a4000000 {
> > +                       reg = <0 0xa4010000 0 0x8000>;
> > +                       no-map;
> > +               };
> > +
> > +               vdev1vring1: vdev1vring1@a4018000 {
> > +                       reg = <0 0xa4018000 0 0x8000>;
> > +                       no-map;
> > +               };
> > +       };
> > +
> > +       sound {
> > +               compatible = "simple-audio-card";
> > +               simple-audio-card,name = "imx93-sgtl5000";
> > +               simple-audio-card,format = "i2s";
> > +               simple-audio-card,bitclock-master = <&dailink_master>;
> > +               simple-audio-card,frame-master = <&dailink_master>;
> > +               /*simple-audio-card,mclk-fs = <1>;*/
> > +               simple-audio-card,cpu {
> > +                       sound-dai = <&sai3>;
> > +               };
> > +
> > +               dailink_master: simple-audio-card,codec {
> > +                       sound-dai = <&sgtl5000>;
> > +                       clocks = <&clk IMX93_CLK_SAI3_IPG>;
> > +               };
> > +       };
> > +
> > +       usdhc3_pwrseq: usdhc3-pwrseq {
> > +               compatible = "mmc-pwrseq-simple";
> > +       };
> > +
> > +       wl_reg_on: regulator-wlregon {
> > +               compatible = "regulator-gpio";
> > +               pinctrl-names = "default";
> > +               regulator-name = "WL_REG_ON";
> > +               regulator-min-microvolt = <100000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               states = <3300000 0x1>,
> > +                                <100000 0x0>;
> > +               gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +               vin-supply = <&bt_reg_on>;
> > +       };
> > +};
> > +
> > +&cm33 {
> > +       mbox-names = "tx", "rx", "rxdb";
> > +       mboxes = <&mu1 0 1>,
> > +                <&mu1 1 1>,
> > +                <&mu1 3 1>;
> > +       memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > +                       <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > +       status = "okay";
> > +};
> > +
> > +&flexcan1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_flexcan1>;
> > +       fsl,stop-mode = <&aonmix_ns_gpr 0x10 4>;
> > +       status = "okay";
> > +};
> > +
> > +&flexcan2 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_flexcan2>;
> > +       fsl,stop-mode = <&aonmix_ns_gpr 0x10 4>;
> > +       status = "okay";
> > +};
> > +
> > +&lpi2c1 {
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +       clock-frequency = <400000>;
> > +       pinctrl-names = "default", "sleep";
> > +       pinctrl-0 = <&pinctrl_lpi2c1>;
> > +       pinctrl-1 = <&pinctrl_lpi2c1>;
> > +       status = "okay";
> > +
> > +       pcf8523: rtc@68 {
> > +               compatible = "nxp,pcf8523";
> > +               reg = <0x68>;
> > +       };
> > +
> > +       sgtl5000: codec@a {
> > +               compatible = "fsl,sgtl5000";
> > +               status = "okay";
> > +               #sound-dai-cells = <0>;
> > +               reg = <0x0a>;
> > +               clocks = <&clk IMX93_CLK_SAI3_GATE>;
> > +               clock-names = "mclk";
> > +               assigned-clock-rates = <12000000>, <12000000>;
> > +               VDDA-supply = <&reg_3v3_avdd_sgtl>;
> > +               VDDIO-supply = <&reg_3v3_sgtl>;
> > +               VDDD-supply = <&reg_1v8_sgtl>;
> > +       };
> > +};
> > +
> > +&lpuart1 { /* console */
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_uart1>;
> > +       status = "okay";
> > +};
> > +
> > +&lpuart5 { /* RS485 */
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_uart5>;
> > +       status = "okay";
> > +};
> > +
> > +&lpuart8 { /* RS232 */
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_uart8>;
> > +       status = "okay";
> > +};
> > +
> > +&micfil {
> > +       #sound-dai-cells = <0>;
> > +       pinctrl-names = "default";
> > +       assigned-clocks = <&clk IMX93_CLK_PDM>;
> > +       assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> > +       assigned-clock-rates = <196608000>;
> > +       status = "okay";
> > +};
> > +
> > +&mu1 {
> > +       status = "okay";
> > +};
> > +
> > +&mu2 {
> > +       status = "okay";
> > +};
> > +
> > +&sai1 {
> > +       #sound-dai-cells = <0>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_sai1>;
> > +       assigned-clocks = <&clk IMX93_CLK_SAI1>;
> > +       assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> > +       assigned-clock-rates = <12288000>;
> > +       status = "okay";
> > +};
> > +
> > +&sai3 {
> > +       pinctrl-names = "default";
> > +       #sound-dai-cells = <0>;
> > +       pinctrl-0 = <&pinctrl_sai3>;
> > +       assigned-clocks = <&clk IMX93_CLK_SAI3>;
> > +       assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> > +       assigned-clock-rates = <24576000>;
> > +       fsl,sai-mclk-direction-output;
> > +       status = "okay";
> > +};
> > +
> > +&usdhc3 { /* WiFi */
> > +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
> > +       pinctrl-1 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
> > +       pinctrl-2 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
> > +       vmmc-supply = <&wl_reg_on>;
> > +       bus-width = <4>;
> > +       no-1-8-v;
> > +       non-removable;
> > +       max-frequency = <25000000>;
> > +       status = "okay";
> > +
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +
> > +       brcmf: bcrmf@1 {
> > +               reg = <1>;
> > +               compatible = "brcm,bcm4329-fmac";
> > +       };
> > +};
> > +
> > +&wdog3 {
> > +       status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +
> > +       pinctrl_flexcan1: flexcan1grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_PDM_CLK__CAN1_TX               0x139e
> > +                       MX93_PAD_PDM_BIT_STREAM0__CAN1_RX       0x139e
> > +               >;
> > +       };
> > +
> > +       pinctrl_flexcan2: flexcan2grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_GPIO_IO25__CAN2_TX     0x139e
> > +                       MX93_PAD_GPIO_IO27__CAN2_RX     0x139e
> > +               >;
> > +       };
> > +
> > +       pinctrl_laird: lairdgrp {
> > +               fsl,pins = <
> > +                       MX93_PAD_GPIO_IO22__GPIO2_IO22          0x31e // WL_REG_ON
> > +                       MX93_PAD_GPIO_IO19__GPIO2_IO19          0x31e // BT_REG_ON
> > +               >;
> > +       };
> > +
> > +       pinctrl_lpi2c1: lpi2c1grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_I2C1_SCL__LPI2C1_SCL           0x40000b9e
> > +                       MX93_PAD_I2C1_SDA__LPI2C1_SDA           0x40000b9e
> > +               >;
> > +       };
> > +
> > +       pinctrl_sai1: sai1grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_SAI1_TXC__SAI1_TX_BCLK         0x31e
> > +                       MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC        0x31e
> > +                       MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00      0x31e
> > +                       MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00      0x31e
> > +               >;
> > +       };
> > +
> > +       pinctrl_sai3: sai3grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_GPIO_IO26__SAI3_TX_SYNC        0x31e
> > +                       MX93_PAD_GPIO_IO16__SAI3_TX_BCLK        0x31e
> > +                       MX93_PAD_GPIO_IO17__SAI3_MCLK           0x31e
> > +                       MX93_PAD_GPIO_IO21__SAI3_TX_DATA00      0x31e
> > +                       MX93_PAD_GPIO_IO20__SAI3_RX_DATA00      0x31e
> > +               >;
> > +       };
> > +
> > +       pinctrl_uart1: uart1grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_UART1_RXD__LPUART1_RX          0x31e
> > +                       MX93_PAD_UART1_TXD__LPUART1_TX          0x31e
> > +               >;
> > +       };
> > +
> > +       pinctrl_uart5: uart5grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_GPIO_IO01__LPUART5_RX          0x31e
> > +                       MX93_PAD_GPIO_IO00__LPUART5_TX          0x31e
> > +                       MX93_PAD_GPIO_IO02__LPUART5_CTS_B       0x31e
> > +                       MX93_PAD_GPIO_IO03__LPUART5_RTS_B       0x31e
> > +               >;
> > +       };
> > +
> > +       pinctrl_uart8: uart8grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_GPIO_IO13__LPUART8_RX          0x31e
> > +                       MX93_PAD_GPIO_IO12__LPUART8_TX          0x31e
> > +               >;
> > +       };
> > +
> > +       pinctrl_usdhc3: usdhc3grp {
> > +               fsl,pins = <
> > +                       MX93_PAD_SD3_CLK__USDHC3_CLK            0x17fe
> > +                       MX93_PAD_SD3_CMD__USDHC3_CMD            0x13fe
> > +                       MX93_PAD_SD3_DATA0__USDHC3_DATA0        0x13fe
> > +                       MX93_PAD_SD3_DATA1__USDHC3_DATA1        0x13fe
> > +                       MX93_PAD_SD3_DATA2__USDHC3_DATA2        0x13fe
> > +                       MX93_PAD_SD3_DATA3__USDHC3_DATA3        0x13fe
> > +               >;
> > +       };
> > +};
> > --
> > 2.34.1
> >
> >
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com

