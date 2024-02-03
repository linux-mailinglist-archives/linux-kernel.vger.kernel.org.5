Return-Path: <linux-kernel+bounces-51087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A886848653
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C082B213BE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4764E1D2;
	Sat,  3 Feb 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRQov7XJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AC1AAD7;
	Sat,  3 Feb 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964581; cv=none; b=Us9n6GOTFWiUsWDxbAPS9hpS+MACJrXwDp+BvhqQEr6mS22YrW4VpvgJf5LGk5tx6E98k2XYI614ORA9zdVEaNg/F9ozp3LJxy89I15yBEDl2wDhgehfcI1KqsmauufLszG29a0oyxGIo0pRmysEnxnlpDOLfXKm+LCemqt4yjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964581; c=relaxed/simple;
	bh=6kjbl1g7BDMcRDmouRbEqBe7/mwlwpaki1999XL76Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JevQEGyQ8yTlWUvNw1Qw+OC1lmgJXglSST+SgWJFoC8zxEFHLbjWj5veTZ/f/g/hGdgtq8F+kLc1AT1dmNezTq/zfRYvwbNjh+LL89L7ij5j2DcZCbuzAjdPfXcANxZtXu1pa0oBHiZRYyaFdJz5kQ82G4GF1ihb0QdR+5nrEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRQov7XJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4C6C433F1;
	Sat,  3 Feb 2024 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706964580;
	bh=6kjbl1g7BDMcRDmouRbEqBe7/mwlwpaki1999XL76Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRQov7XJJaoO1pTdZYIANiPOhqu5OfpbYQjaxkhAssDFUdcEjK//Ayr0Zd3hgYElJ
	 E4ran6/wk6VBGQnJZ58/uxbecM/YNLTY4daybqrZSKEoc0qC4rO0i0Voo5lQLwv9ro
	 AGuCeNSOeXXIvVekI9F5PlxO+C960yMlWjx0syW6xnugsNM4rQsXpx/lwg6yZv3ard
	 VA2n4uJAM3k0BM8LR/MG6baw5UBjdokk74RUVqot5cUL3pjpK6vqJQ4Sh1i+m9yL9n
	 AuOGSF5lYGlt2hOeQEQ7k8FPcw11zKPk8U49UEyDpZuW8Sy+o9iuKDWskJl4Cms/Fh
	 OnSQY66IPnyuQ==
Date: Sat, 3 Feb 2024 20:36:42 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h616: Add Sipeed Longan SoM
 3H and Pi 3H board support
Message-ID: <Zb4zWsfzgJkZa2KQ@xhacker>
References: <20231228145647.1470-1-jszhang@kernel.org>
 <20231228145647.1470-3-jszhang@kernel.org>
 <2589997.Lt9SDvczpP@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2589997.Lt9SDvczpP@jernej-laptop>

On Tue, Jan 09, 2024 at 09:37:03PM +0100, Jernej Škrabec wrote:
> Hi Jisheng,

Hi Jernej,

> 
> Andre gave you thorough review already, so just one additional comment
> below.
> 
> Dne četrtek, 28. december 2023 ob 15:56:47 CET je Jisheng Zhang napisal(a):
> > The Sipeed Longan SoM 3H is a system on module based on the Allwinner
> > H618 SoC. The SoM features:
> > 
> > - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> > - 2/4 GiB LPDDR4 DRAM SoMs
> > - AXP313a PMIC
> > - eMMC
> > 
> > The Sipeed Longan PI 3H is a development board based on the above SoM.
> > The board features:
> > - Longan SoM 3H
> > - Raspberry-Pi-1 compatible GPIO header
> > - 2 USB 2.0 host port
> > - 1 USB 2.0 type C port (power supply + OTG)
> > - MicroSD slot
> > - 1Gbps Ethernet port (via RTL8211 PHY)
> > - HDMI port
> > - WiFi/BT chip
> > 
> > Add the devicetree file describing the currently supported features,
> > namely PMIC, LEDs, UART, SD card, eMMC, USB and Ethernet.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../sun50i-h618-longan-module-3h.dtsi         |  82 +++++++++++
> >  .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 133 ++++++++++++++++++
> >  3 files changed, 216 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index 3aca6787a167..00db504a9b8c 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -42,4 +42,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> > new file mode 100644
> > index 000000000000..88a7d287b73c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616.dtsi"
> > +
> > +/ {
> > +	model = "Sipeed Longan Module 3H";
> > +	compatible = "sipeed,longan-module-3h", "allwinner,sun50i-h618";
> > +};
> > +
> > +&mmc2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc2_pins>;
> > +	vmmc-supply = <&reg_dldo1>;
> > +	vqmmc-supply = <&reg_aldo1>;
> > +	bus-width = <8>;
> > +	non-removable;
> > +	cap-mmc-hw-reset;
> > +	mmc-ddr-1_8v;
> 
> I think above is superfluous if hs200 is also defined.

I read the mmc code again, IMHO, mmc-ddr-1_8v and mmc-hs200-1_8v
are for different caps, the former is for MMC_CAP_1_8V_DDR and
the later is for MMC_CAP2_HS200_1_8V_SDR, I must admit that
mmc-hs200-1_8v does imply mmc-ddr-1_8v in normal host controllers
but they are different, and I found other dts files also contain
both, so I kept this as is in v2.

Thanks

> 
> > +	mmc-hs200-1_8v;
> > +	status = "okay";
> > +};
> > +
 

