Return-Path: <linux-kernel+bounces-136981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E289DAA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E3F1F23A09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC945131E59;
	Tue,  9 Apr 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLE4L7AA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AA13173E;
	Tue,  9 Apr 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669936; cv=none; b=PFTKYiGHQ/+coxn1z+cD8qVUAzrH11RWVwDQ+ZIRGnYxNCt+zdYvoaERIP2e856p6Gpkrd1vB0o9S5CrMxAPCBeeVIhyIrZZnTTB7UayLUpbugksHdpncNJxPZxUFzt4UhL7BDHW5sENTBVa0nHNUd3mtefUu9ovp7nvltgv0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669936; c=relaxed/simple;
	bh=bjFXS0RsfnGrGuGvSpuQ1Azl09QUNfG1I4fgBjCN/4Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ULeBBFjwnaRhhblzhe+vtKoiVTO4Xfe6OllgAeuhgVXlLt+4anibJabICzgg9ZhHZxcTcaIy2s13GJNy3sgp2yo1+yTwQtFGuKmihQM3sVoI3cqUorrCedury23CjvqSQUn3xrDmGE7imjylsMsoh+aRnfIjniJPsl+gIum2hEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLE4L7AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E9EC43390;
	Tue,  9 Apr 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669935;
	bh=bjFXS0RsfnGrGuGvSpuQ1Azl09QUNfG1I4fgBjCN/4Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MLE4L7AA4udXHhLmWp3bq7pdOMWGWUfV7x1mUC7vw3qTQJcg+oOXh3/aInm2hTr6R
	 ngRePtBRq8K61P+WZpPoz1bpEvbjNd6gFOZU6xRliH9auIgDNnDeNthbUPHHix3Foh
	 RsP7QoY5ap6saJIJNfa9Ii4TcVMS5NANyiwD4DBxdnEauJ/i37zDIlK6gLClGCrUMT
	 UvT+9kfTvuuX7CA8f6KuWNgLDaR100d2XLDhG2i3dWgoR6843gwEcf2culJrI/0wlS
	 FA/wLshPDuecAMusTHQUJ3fa21snJ71wCLWa1pMuglAhLEzO8nK9ujmiTxCg6t85sX
	 2Yr790JRZjfFQ==
Date: Tue, 09 Apr 2024 08:38:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240408124005.182565-1-amadeus@jmu.edu.cn>
References: <20240408124005.182565-1-amadeus@jmu.edu.cn>
Message-Id: <171266958458.1032566.5437781512082910340.robh@kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable onboard spi flash for
 rock-3a


On Mon, 08 Apr 2024 20:40:05 +0800, Chukun Pan wrote:
> There is a mx25u12835f spi flash on this board, enable it.
> 
> [    2.525805] spi-nor spi4.0: mx25u12835f (16384 Kbytes)
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-rock-3a.dtb' for 20240408124005.182565-1-amadeus@jmu.edu.cn:

arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts:765.3-15: Warning (reg_format): /spi@fe300000/flash@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk356x.dtsi:1091.20-1100.4: Warning (spi_bus_bridge): /spi@fe300000: incorrect #address-cells for SPI bus
  also defined at arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts:760.6-770.3
arch/arm64/boot/dts/rockchip/rk356x.dtsi:1091.20-1100.4: Warning (spi_bus_bridge): /spi@fe300000: incorrect #size-cells for SPI bus
  also defined at arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts:760.6-770.3
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts:763.10-769.4: Warning (avoid_default_addr_size): /spi@fe300000/flash@0: Relying on default #address-cells value
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts:763.10-769.4: Warning (avoid_default_addr_size): /spi@fe300000/flash@0: Relying on default #size-cells value






