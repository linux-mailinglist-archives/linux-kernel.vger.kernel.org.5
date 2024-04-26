Return-Path: <linux-kernel+bounces-160141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B18B39C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8961B2356B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356314884B;
	Fri, 26 Apr 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa+5l68A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7C13C9A3;
	Fri, 26 Apr 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141364; cv=none; b=D+mYvUxOaQtfeVob/xcTSVFGdxpnoa9AonZMM74maTdg1DAkXAx3wm09X4gZ5H+pT8NNo/e0BN023VHigxQwuJfnlM1f9PNnor0jcBCmarA1xWq+v1tmBeHqDgKcuymBvjrKLrxR2xq24K7NyRlm6QyGQqKGR53TzKXdKyGV2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141364; c=relaxed/simple;
	bh=WVO28hpowwFH2f2s6FH1FticL951DDo70f/XJDupeUQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TogeAwbW7cJfa0xrvNWO+ahPzU8jVgX09fcUmo2tSBTnbpf8DeNtACwj9QdL3sLZHEOj6SZSRFVqw8C+rehEKaGhTvZznOHzr4m9WYC8JeALeCNEOQuDUe4+R2f1q9aXczZbqLD8xVI4OS/cEWfUZ1tTzmQecWxA1JAeMDe6Re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa+5l68A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF39AC113CD;
	Fri, 26 Apr 2024 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141364;
	bh=WVO28hpowwFH2f2s6FH1FticL951DDo70f/XJDupeUQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Sa+5l68AwwfwUcltgOFkY5s12X3Ak94zL8ZodzWNEsC6zn0Dj+XSr60Q5AlfAw5g8
	 p8Ac134WGBZZ8XQi+YnPSwGjaY2LEiZeqCB5KS9LZYeIGJnR2XCYc0ZpmieWLhqqhi
	 JvPWMswnwSXT2v2bKwEeEoOmgakyJ9dkm4YXdaqMC6EUXYiJIvFentPdWXCY3t/KSw
	 6A2Ew4TMkk+GsdtsGA9IZ+1zATb9DI8pCfhadn+5qTedvon7d5es1IDKu6yx68B6xy
	 c//x3vHJy7GnhBepTv+2okmibPq/XUdGzMP2acymgUUp4/8J8NrDiyIxkX9HxK3zLR
	 V3nv4p1RvvK+w==
Date: Fri, 26 Apr 2024 09:22:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, 
 Jose Abreu <joabreu@synopsys.com>, Jakub Kicinski <kuba@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Marek Vasut <marex@denx.de>, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Message-Id: <171414068246.1496656.8837914641064924461.robh@kernel.org>
Subject: Re: [PATCH v2 00/11] Series to deliver Ethernets for STM32MP13


On Fri, 26 Apr 2024 14:56:56 +0200, Christophe Roullier wrote:
> STM32MP13 is STM32 SOC with 2 GMACs instances
> This board have 2 RMII phy:
>   -Ethernet1: RMII with crystal
>   -Ethernet2: RMII without crystal
> Rework dwmac glue to simplify management for next stm32
> Add support for PHY regulator
> 
> V2: - Remark from Rob Herring (add Krzysztof's ack in patch 02/11, update in yaml)
>       Remark from Serge Semin (upate commits msg)
> 
> Christophe Roullier (11):
>   dt-bindings: net: add STM32MP13 compatible in documentation for stm32
>   dt-bindings: net: add phy-supply property for stm32
>   net: stmmac: dwmac-stm32: rework glue to simplify management
>   net: stmmac: dwmac-stm32: add management of stm32mp13
>   net: stmmac: dwmac-stm32: update config management for phy wo cristal
>   net: stmmac: dwmac-stm32: clean the way to manage wol irqwake
>   net: stmmac: dwmac-stm32: support the phy-supply regulator binding
>   ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
>   ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
>   ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
>   ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
> 
>  .../devicetree/bindings/net/stm32-dwmac.yaml  |  79 +++++-
>  arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++
>  arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
>  arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  48 ++++
>  arch/arm/configs/multi_v7_defconfig           |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 235 ++++++++++++------
>  7 files changed, 416 insertions(+), 79 deletions(-)
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y st/stm32mp135f-dk.dtb' for 20240426125707.585269-1-christophe.roullier@foss.st.com:

arch/arm/boot/dts/st/stm32mp135f-dk.dtb: ethernet@5800e000: Unevaluated properties are not allowed ('st,ext-phyclk' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#






