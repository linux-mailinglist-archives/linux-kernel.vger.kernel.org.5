Return-Path: <linux-kernel+bounces-124064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9908911BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95A21C24750
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383833CCF;
	Fri, 29 Mar 2024 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAqOeYyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ECE11182;
	Fri, 29 Mar 2024 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680288; cv=none; b=AOOb3awqmKrjG+xauSArmHQm8y7mmzXHONJra00ldYyn4k1fJDnl4zYTDDbpPjq+CEoX8R/sAbfqp/qq8exIC/dp0Wc/9bsvQInnUE6WVwyLGwrdjrZdqA+u1KgXZosAUcL9ymdap6NqymMp/suBBCv/hf+z4jx2Mk5YTvzG3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680288; c=relaxed/simple;
	bh=NsaG2fTktCpn6iX0GuW5RaElcG6IHu4jh7ScjLVF8VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHgaHYUq3LCuZGHIVZR++Vko71OhIvntROoL/obLjqA+mvYF9CiI5ufVTx0bu1ht6o/DhjjnYXq9d8kjJuJZE22d9mrYo1boipS9GoCYuZH0O+ZKmUXzlRMnEq26q1p5y7yjJhHdsVKT+jqL2tlHo+vOOYaXzltC2uHmNmNdfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAqOeYyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86224C433C7;
	Fri, 29 Mar 2024 02:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711680287;
	bh=NsaG2fTktCpn6iX0GuW5RaElcG6IHu4jh7ScjLVF8VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAqOeYygA1B/WtOa6YPHZmLZAELGFuT1VJVR4kGLsOUHTnf7b6kCc05+fZJKOMQ18
	 FcgiCYmR82kP/dxuek6elAIa+OKD+wOkrMpXpQMhlyMVxVH3nT7jH4nsyhQa80aT1C
	 6Bnf73TWFDwyniCvJj7Po15caL0RgCUAIFZDWtaJQJqOqT+D+emfysUts+hSDqX34e
	 iFP7/F5P/5UZ5dZrvMewadj2MTMNZKyXlYhQFBLIFnJAaYPKErbozqy6YlXDp+BFFT
	 v9whr3xEV2wNFCwJAjSF7oYjYw9dQHIuYIxFPvyRkb5xUPF7dMosBVV92GVJAy7PiV
	 rSwSzlCYIJH7Q==
Date: Fri, 29 Mar 2024 10:31:18 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <ZgYn9t4akccWuHyf@xhacker>
References: <20240131132600.4067-1-jszhang@kernel.org>
 <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud>
 <43918921-0d05-41d3-a19b-f137314e868d@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43918921-0d05-41d3-a19b-f137314e868d@canonical.com>

On Thu, Mar 28, 2024 at 10:28:28PM +0100, Heinrich Schuchardt wrote:
> On 2/6/24 20:13, Conor Dooley wrote:
> > On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
> > > The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> > > The board features:
> > > 
> > > - JH7110 SoC
> > > - 1/2/4/8 GiB LPDDR4 DRAM
> > > - AXP15060 PMIC
> > > - 40 pin GPIO header
> > > - 3x USB 3.0 host port
> > > - 1x USB 2.0 host port
> > > - 1x M.2 E-Key
> > > - 1x eMMC slot
> > > - 1x MicroSD slot
> > > - 1x QSPI Flash
> > > - 1x 1Gbps Ethernet port
> > > - 1x HDMI port
> > > - 1x 2-lane DSI and 1x 4-lane DSI
> > > - 1x 2-lane CSI
> > > 
> > > Add the devicetree file describing the currently supported features,
> > > namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > Got a dtbs_check issue in the patchwork CI:
> > 
> >    +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-clock: 'clock-frequency' is a required property
> >    +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> >    +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-clock: 'clock-frequency' is a required property
> >    +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > 
> > Can you fix that please? Also, I applied some patches the other day that
> > seem to conflict quite a bit with the common board dts patch. Would you
> > please do a rebase on top of that please?
> > 
> > Cheers,
> > Conor.
> > 
> > > ---
> > >   arch/riscv/boot/dts/starfive/Makefile         |  1 +
> > >   .../boot/dts/starfive/jh7110-milkv-mars.dts   | 35 +++++++++++++++++++
> > >   2 files changed, 36 insertions(+)
> > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> > > 
> > > diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> > > index 0141504c0f5c..2fa0cd7f31c3 100644
> > > --- a/arch/riscv/boot/dts/starfive/Makefile
> > > +++ b/arch/riscv/boot/dts/starfive/Makefile
> > > @@ -8,5 +8,6 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
> > >   dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
> > >   dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
> > > +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
> > >   dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
> > >   dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> > > diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> > > new file mode 100644
> > > index 000000000000..de600e799e7d
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> > > @@ -0,0 +1,35 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "jh7110-visionfive2-mars-common.dtsi"
> > > +
> > > +/ {
> > > +	model = "Milk-V Mars";
> > > +	compatible = "milkv,mars", "starfive,jh7110";
> > > +};
> > > +
> > > +&gmac0 {
> > > +	starfive,tx-use-rgmii-clk;
> > > +	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> > > +	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> > > +};
> > > +
> > > +
> > > +&phy0 {
> > > +	motorcomm,tx-clk-adj-enabled;
> > > +	motorcomm,tx-clk-10-inverted;
> > > +	motorcomm,tx-clk-100-inverted;
> > > +	motorcomm,tx-clk-1000-inverted;
> > > +	motorcomm,rx-clk-drv-microamp = <3970>;
> > > +	motorcomm,rx-data-drv-microamp = <2910>;
> > > +	rx-internal-delay-ps = <1500>;
> > > +	tx-internal-delay-ps = <1500>;
> > > +};
> > > +
> > > +&mmc1 {
> > > +	disable-wp;
> 
> Due to which difference is 'disable-wp' necessary for the Mars board and not
> necessary for the VisionFive 2 board?

Mars doesn't have wp pin, but dunno vf2 case since I don't have a VF2
board ;)
> 
> > > +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> 
> On my VisionFive 2 1.2B, and 1.3A boards GPIO 41 reflects if an SD-card is
> inserted (as shown in U-Boot by gpio status -a). So shouldn't this value be
> moved to the common include "jh7110-visionfive2-mars-common.dtsi" and
> broken-cd removed from the VisionFive2 board?

I tested the CD pin and can confirm it works on Mars, but I dunno whether
this works on VF2 since I have no VF2 board.
Could you please check whether it works or not on VF2?

> 
> https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf
> has a line
> 
>     GPIO41 | SD_SDIO0_CD_GPIO41 | Micro SD：J10
> 
> Best regards
> 
> Heinrich
> 
> > > +};
> > > -- 
> > > 2.43.0
> 

