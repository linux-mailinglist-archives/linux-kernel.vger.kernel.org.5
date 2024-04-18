Return-Path: <linux-kernel+bounces-149652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662678A9402
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9788A1C217BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA93E493;
	Thu, 18 Apr 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="U1tzA1E4"
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9F3D984
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425479; cv=none; b=KbBZzjPjLshLW66nB6aY4byeC1KwEOnp0u581FO0jwPNjbHHckbwlORFHP3CAQriVVNdqII+nftoAgZXs1uuxZnNpkB1cGX7uIKEUUQlkk8tnTZcL4xJ0BSpBiSTvU1g1znJH+yePrDhjGOQDhJRPPZxbGGzdNW4cwEhjTsipYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425479; c=relaxed/simple;
	bh=/D7loSoJ8LTuZFSDTmGdK+mo8Ji5LnnuBOROJJyE4rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUgDDmOEhn6gcdvweQHM0wHY//Npt0deMAnK7o+PUzdU8N5y2NSmZpPO8CZVwtuDcrcfv+Gg+nrJG9jQG5rGretIni39BLe5U6ItQ1cYC+svaVp74lHR9gyv7gzOupfwPz47RfWJKRDMrcQxVlEFIsWpIa3nLYh7MRyC8JrLS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=U1tzA1E4; arc=none smtp.client-ip=62.149.156.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.28.123])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xMBpr2JFzjEwexMBqrCMpp; Thu, 18 Apr 2024 09:28:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713425295; bh=/D7loSoJ8LTuZFSDTmGdK+mo8Ji5LnnuBOROJJyE4rY=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=U1tzA1E4DcLAj/KgA3NwRvty/MP3y1sdyO95Qk+bPG7EtxNfh3K6HzmV7bfGip5w8
	 pyr3GytQicCeaDLF1GqbqtVQyYYeXPesTUxazjbUbOMKLqFwIXx9C6x3wli2Le1rou
	 NNZjSbgRvOMlSNYmp1LaAWJi2hcr5SGWtD8hGhRmY2JLyuSlhOOjqUzne7zgFZWqgb
	 gxmzFgWsXwOp+GXU1+BfcmsXP+MXH5DGbbraQMCxVGK7RIeKbjbrO+C4b3D2uvVpSf
	 0hDybEJidTM68sU7AuTEjicW7t/no38M3twffTYcjZVGef8uUenkQuiLWjZ6ZVieVt
	 o5sv6+Ey1JrUw==
Date: Thu, 18 Apr 2024 09:28:13 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0
 Starter Kit
Message-ID: <ZiDLjT3wEeiiHjz9@engicam>
References: <20240417153528.7838-1-fabio.aiuto@engicam.com>
 <20240417153528.7838-5-fabio.aiuto@engicam.com>
 <41a1ca01-384a-40ca-a5f6-6205bb43825b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a1ca01-384a-40ca-a5f6-6205bb43825b@kernel.org>
X-CMAE-Envelope: MS4xfIqOolBh5THzUaCAYTNotxuYXn9r+bHpV5qiOjW+r+LG0RRPRAuuhMJP3GdpT68KtsTYjnbSJjA2+B/dCIdYpLrAFzxPmzu+hBEbVQxIZrOY7UQ30p+Q
 gw3/qYokJYm74WgWpoTFvFE5IpQYBT0ZII3yTf1zNeDC9QX5Vd58gCB8+h7GJI5BabYj13u2HajQXqhCLHI336qT5/bOP8qzPAVl9lbsAfD0KTJkiNRiezuI
 Rr1FQrl+wFvvZCqKSU8jqgBabiy6w0XdD2+Pp7aI/hFIfXQyYcTvE4vleTgKlPdueCT2HWmMqWMc3EO99Pz2kEtd5zcJM9srfj5H5/T7st5iDf11g1Pg+9SG
 GNxeZpPrx5NGgOjSKqzjHD1cjMjzIqznEalKYS3ERV2jFuxqvhRkwv6PnBSg4Pef+jTTgLmV6RKShJoEtLcf7R6ZKDqwgdPWpKWhGIFGsOHMWO4HNDjE7+7p
 MiPfX4EI1D6kkypVa+IDiLyFohlqBnWNwJ3J3hBCGoxuw9nc9p7LMpsOSVFBJEbHH8qZl01ld+JrbuzNH3ANce4ucFtVSIXqJ7wGCocJ8ELj1X3J+GiJC2v3
 NGrFtucMcI9X89RnRSKp52cW

Dear Krzysztof,

Il Wed, Apr 17, 2024 at 07:08:00PM +0200, Krzysztof Kozlowski ha scritto:
> On 17/04/2024 17:35, Fabio Aiuto wrote:
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
> >  .../dts/freescale/imx93-icore-mx93-edimm2.dts | 356 ++++++++++++++++++
> >  2 files changed, 357 insertions(+)
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
> > index 000000000000..75cac97d919c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> > @@ -0,0 +1,356 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2022 NXP
> > + * Copyright 2024 Engicam s.r.l.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/usb/pd.h>
> > +#include "imx93-icore-mx93.dtsi"
> > +
> > +/ {
> > +	model = "Engicam i.Core MX93 - EDIMM 2 Starterkit";
> > +	compatible = "engicam,icore-mx93-edimm2", "engicam,icore-mx93",
> > +		     "fsl,imx93";
> > +
> > +	aliases {
> > +		rtc1= &bbnsm_rtc;
> 
> Missing pace before =
> 
> > +	};
> > +
> > +	bt_reg_on: regulator-btregon {
> > +		compatible = "regulator-gpio";
> > +		regulator-name = "BT_REG_ON";
> > +		pinctrl-names = "default";
> > +		regulator-min-microvolt = <100000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		states = <3300000 0x1>,
> > +				 <100000 0x0>;
> 
> Misaligned indentation
> 
> > +		gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &lpuart1;
> > +	};
> > +
> > +	reg_1v8_sgtl: reg_1v8_sgtl_regulator {
> 
> Do not use underscores in node names. I am pretty sure you got this
> comment before.
> 
> Also, you have confusing naming scheme - sometimes prefix reg, sometimes
> regulator. Keep nodes ordered.

thanks, will submit a v2 patchset

kr,

fabio

> 
> 
> 
> Best regards,
> Krzysztof
> 

