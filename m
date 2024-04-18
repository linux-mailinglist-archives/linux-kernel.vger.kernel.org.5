Return-Path: <linux-kernel+bounces-150630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57B8AA20C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916EB1C21541
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57917AD6D;
	Thu, 18 Apr 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Jh2LsH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4E176FD2;
	Thu, 18 Apr 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464984; cv=none; b=oo7ASA//YC9hR6/6RNMSCMLtc0YgGQEhYPgnAAPZhPKMEwWmqRaZ2NiIEyRH5AAQS/mqKeimtp7g/lbt1YRIS05CQj4wn/4Xn6o+Ir3gLWF9YozvmMpbkd7bbSyySj+YCGpoC/P9mF1TzWl4xdTTskZWT5Wq0MCtW16/tJWeboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464984; c=relaxed/simple;
	bh=O8GQPhIx4kTFIET9bwlPStvr9H9F3wcwWCLjZ5QysXs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GwTgSy5+DYZcag4VbHm9S6bI3/yCMu/5R8DmPAVLVk27QfABmekNej+xO2Rkqs4ATfCG4HwU1xPCRC6HL3lkjW+SHjdW5hdgfpbgDaT/RamhqO+0a1RDLTz7QqAA2NuUnxawznJWoWUaX6VxPGmyzkQD0G++J8xTPZTPXRdpbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Jh2LsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0347AC113CC;
	Thu, 18 Apr 2024 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713464984;
	bh=O8GQPhIx4kTFIET9bwlPStvr9H9F3wcwWCLjZ5QysXs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=h1Jh2LsHFnS9RuufuGll1YExdQ4NuFS17W5CnxtDnCmPYXaJuJtynDDNahAjT8cXq
	 srHufFyO+8/ZgpWvPVf3RyN0EU6Ipvj/rs+NZ2gzD19gPMQ1JI42VsXZ7h1619dT20
	 RaEhL4zD9XHFyOivDfsdAHe6cZisTzJeIqHbv8WSi0f49iOq4CCG8v59znRC6QGyO8
	 toUHLVm+9vq+ixa/c44/pkaiG+E0YVqEeD4CCDte5tjLiNDFcoLezw9Rl9wrnjh1tm
	 edeq8LobON4+caPn/1/XzDJxOU/6Zc11kdrASYW50p6kRPsAPR4OuBf69sOvE1ByzD
	 0w55oaEsLSN0w==
Date: Thu, 18 Apr 2024 13:29:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 imx@lists.linux.dev
In-Reply-To: <20240418133923.3705-1-fabio.aiuto@engicam.com>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
Message-Id: <171346492597.2679649.7866044200094982080.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0
 board


On Thu, 18 Apr 2024 15:39:20 +0200, Fabio Aiuto wrote:
> Hello all,
> 
> this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
> a SoM + Evaluation Board combination from Engicam.
> 
> The number of patch has diminished to 3, for I dropped the
> patch introducing a change in nxp,pca9450 binding which has
> been already submitted in regulator tree.
> 
> (Dropped also regulator tree maintainers as recipients for
> they aren't anymore involved in this patchset)
> 
> Thanks in advance,
> 
> fabio
> ---
> v1 ---> v2:
> 	- dropped patch updating nxp,pca9450 binding
> 	- fixed indentation issue
> 	- fixed missing space issue
> 	- improved naming of regulator nodes
> 	- removed unneeded include
> 	- fixed email recipients
> 
> Fabio Aiuto (3):
>   dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
>   arm64: dts: imx93: add Engicam i.Core MX93 SoM
>   arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   7 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-icore-mx93-edimm2.dts | 354 ++++++++++++++++++
>  .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 270 +++++++++++++
>  4 files changed, 632 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y freescale/imx93-icore-mx93-edimm2.dtb' for 20240418133923.3705-1-fabio.aiuto@engicam.com:

arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: codec@a: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/sgtl5000.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: codec@a: 'assigned-clocks' is a dependency of 'assigned-clock-rates'
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: micfil@44520000: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: regulator-btregon: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: regulator-1v8-sgtl: Unevaluated properties are not allowed ('always-on' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: regulator-3v3-avdd-sgtl: Unevaluated properties are not allowed ('always-on' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: regulator-3v3-sgtl: Unevaluated properties are not allowed ('always-on' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dtb: regulator-wlregon: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#






