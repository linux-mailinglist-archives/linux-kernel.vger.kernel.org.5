Return-Path: <linux-kernel+bounces-167704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA08BADB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C898F1F22ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4861153826;
	Fri,  3 May 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QohNH+5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C621A06;
	Fri,  3 May 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742787; cv=none; b=YYI5IsfDV7zy3B+Tp/zGXLMJUvxPmmQ44tGCzMjS2phYYfmg6uZuraoMB3EzhEKdWWJNPYc4lkPez6etC8gbmISBuXa0R0xMnS4my7Gaj+kD+9eIKn489AsUZhC+xF66RZbnP7QkO//KRMr1WjqROoI/I0Bfr99315hERB0E+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742787; c=relaxed/simple;
	bh=FzJmLJEAfWbfxoDrGzOyw0EXb6lj4tCCnC3PFnqsC+8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ULAItGzEw8a+4zx5lvDr5VYl/gpBe0IUGA6o4+rvuHXao21MhNzk8ZMAqj/Z5ub1KA8uATgP3vewhsmEpmdaIQpTu4mr5eBFEZOg0llAxJXulqvfl3BHuNqytR3ItatYnx4ARtJz+2UT7tMKYibMgWSq4BHmZWzdGeAg2AUbO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QohNH+5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CA4C116B1;
	Fri,  3 May 2024 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714742786;
	bh=FzJmLJEAfWbfxoDrGzOyw0EXb6lj4tCCnC3PFnqsC+8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QohNH+5ACzoqeSQBk3VonpvWlJw8iyUIYzpZ+b2IrA5H7UkLmHu7+eMluTFHH4Xl+
	 8nzyy4Z/u9inj0mdTpo5579ZQpvuOi4Jwy7rOmlKH5N+6Tz4P9O0nJ+DhwpX2rozjG
	 gh1tbgOZHDqCqFniDir6nvtaaKSF04vlALRjofWeRBREG+iWs9teyZy8/gg7SYHmSf
	 Xr/oZhE41aeiawkv3kqXWky5oQwpTX1s4W6u75Ckr6BPKa8go5a7QEB/vcx30UXzLH
	 2QB0iizPbib7MR7lC5WFD9HMFl/+ccspoIF2iDD5rlr3oMpprpbCJPaxRgXxOqQc4k
	 IWTbcqgzj2OTQ==
Date: Fri, 03 May 2024 08:26:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev, 
 Conor Dooley <conor.dooley@microchip.com>, Shawn Guo <shawnguo@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
References: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
Message-Id: <171474271031.624119.6280624703185299261.robh@kernel.org>
Subject: Re: [PATCH v4 0/3] arm64: dts: add i.MX95 and EVK board


On Fri, 03 May 2024 09:37:10 +0800, Peng Fan (OSS) wrote:
> Add a minimal i.MX95 dtsi and EVK board dts.
> i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
> driver still not ready for i.MX95, so we count on bootloader to
> configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
> driver ready, we could move to use scmi pinctrl.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v4:
> - Sort nodes by address
> - Drop coresight nodes
> - Align clock rates for SDHC1-3
> - Drop wdog3 board specific property
> - Link to v3: https://lore.kernel.org/r/20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com
> 
> Changes in v3:
> - Drop irqsteer node because binding not accepted
> - Pass dtbs_check
> - Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com
> 
> Changes in v2:
> - Addressed Rob and Krzysztof's comments, and fix dts_check issue
>   To pass the dtbs_check, need apply:
>   https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/
> 
> - Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com
> 
> ---
> Peng Fan (3):
>       dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
>       arm64: dts: freescale: add i.MX95 basic dtsi
>       arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  112 +++
>  arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
>  arch/arm64/boot/dts/freescale/imx95-power.h       |   55 ++
>  arch/arm64/boot/dts/freescale/imx95.dtsi          | 1049 +++++++++++++++++++++
>  6 files changed, 1410 insertions(+)
> ---
> base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
> change-id: 20240428-imx95-dts-v3-bee59f0e559b
> 
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
> 
> 
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


New warnings running 'make CHECK_DTBS=y freescale/imx95-19x19-evk.dtb' for 20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com:

arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: mmc@428b0000: 'assigned-clocks' is a dependency of 'assigned-clock-parents'
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: mmc@428b0000: 'assigned-clocks' is a dependency of 'assigned-clock-rates'
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






