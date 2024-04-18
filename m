Return-Path: <linux-kernel+bounces-149696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA68A94B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F4AB2252A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB17D3E3;
	Thu, 18 Apr 2024 08:13:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D607D09A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427981; cv=none; b=sYQPd1O0OjFSnHElLvqgIfOo5TUrQqSiygoaqBh0h8lkMDX3qyEvduirm7ZFLoyoWXEi5UyY1LevPQvTLsB/mDpcE4b1VxnsrgUr7RohHDjKSoFCqpu047C+9qvQMA+a/3Zh9Uj98NpcPi7tQIyBuS3WTokH4al8jopsRyFaf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427981; c=relaxed/simple;
	bh=a1lDZyQcKMG8tu88vZXH92dfxB+K0HC43vvv9bgkkGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHz+7njcAMJ00WrfgqLxFxR58QI12U1XOf7z9266phq1LfFyQ0/lro9Tn89AaKUkDKuIL/gyjCVWz+ac0pwdpUoMWDVl/s+i6JeOatejeac6HJWn5Uas7M0fgh/mwnXByFRDFhTMr+Lgu8G+G/R6kB3Q85kDzJOjxKoxtXgX3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxMt5-0004Xm-Bg; Thu, 18 Apr 2024 10:12:55 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
Date: Thu, 18 Apr 2024 10:12:54 +0200
Message-ID: <5932394.MhkbZ0Pkbq@diego>
In-Reply-To: <cb2004e3-563e-4d36-ab69-89b1d9f6221b@theobroma-systems.com>
References:
 <20240417141642.2243193-1-heiko@sntech.de>
 <cb2004e3-563e-4d36-ab69-89b1d9f6221b@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 18. April 2024, 10:07:37 CEST schrieb Quentin Schulz:
> On 4/17/24 16:16, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > The Jaguar SBC provides a M.2 slot connected to the pcie3 controller.
> > In contrast to a number of other boards the pcie-refclk is gpio-controlled,
> > so the necessary clock is added to the list of pcie3 clocks.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >   .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 53 +++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> > index 5002105dc78e..908fbabd8b00 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> > @@ -72,6 +72,25 @@ led-1 {
> >   		};
> >   	};
> >   
> > +	/*
> > +	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
> > +	 * clock generator.
> > +	 * The clock output is gated via the OE pin on the clock generator.
> > +	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
> > +	 */
> > +	pcie_refclk_gen: pcie-refclk-gen-clock {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <1000000000>;
> > +	};
> > +
> > +	pcie_refclk: pcie-refclk-clock {
> > +		compatible = "gpio-gate-clock";
> > +		clocks = <&pcie_refclk_gen>;
> > +		#clock-cells = <0>;
> > +		enable-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>; /* PCIE30X4_CLKREQN_M0 */
> 
> I think we usually want to have the pinctrl for GPIOs as well to not 
> assume the pins are muxed in that function by default or by the bootloader?
> 
> > +	};
> > +
> >   	pps {
> >   		compatible = "pps-gpio";
> >   		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> > @@ -466,6 +485,40 @@ &pcie2x1l0 {
> >   	status = "okay";
> >   };
> >   
> > +&pcie30phy {
> > +	status = "okay";
> > +};
> > +
> > +&pcie30x4m0_pins {
> 
> I'm wondering if it really makes sense to reuse this node if we're 
> planning to change the only property it has to mean something different?

ok, will create a specific node for the new pinctrl
As an added pro, this also moves it to the pinctrl area in the dts

> > +	/*
> > +	 * pcie30x4_clkreqn_m0 is used by the refclk generator
> > +	 * pcie30x4_perstn_m0 is used as via the reset-gpio
> > +	 */
> > +	rockchip,pins =
> > +		/* pcie30x4_waken_m0 */
> > +		<0 RK_PC7 12 &pcfg_pull_none>;
> > +};
> > +
> > +&pcie3x4 {
> > +	/*
> > +	 * The board has a gpio-controlled "pcie_refclk" generator,
> > +	 * so add it to the list of clocks.
> > +	 */
> > +	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> > +		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> > +		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
> > +		 <&pcie_refclk>;
> > +	clock-names = "aclk_mst", "aclk_slv",
> > +		      "aclk_dbi", "pclk",
> > +		      "aux", "pipe",
> > +		      "ref";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie30x4m0_pins>;
> > +	reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTN_M0 */
> 
> Ditto, I assume we want to have a pinmux for that GPIO as well?

Correct. While the Rockchip pinctrl driver _does_ the muxing when a gpio
is requested, it wouldn't touch pinconf settings u-boot or whoever might
have set differently before.

Heiko



