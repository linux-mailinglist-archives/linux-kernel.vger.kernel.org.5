Return-Path: <linux-kernel+bounces-86759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14B86CA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1651D2847A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE7786241;
	Thu, 29 Feb 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GADYM1DU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE94B5DA;
	Thu, 29 Feb 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213702; cv=none; b=sw/lgtBbPE6jnhKcf5X5L/8Hrvp3lljdSX6bgXQNTyGR5Z+wuFa7l3v2ErLXYs08wCWthLni9UKjC2ah7b5dA+jSlLtiBbyWzdsnOWjiu+5qRGUG+PtOh1/SHzNV1vHsrzOW/d9YZ4Nq20rH90Hd3DiJejyrJFVG+t/u7F2LAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213702; c=relaxed/simple;
	bh=f1sgVZlHzxptTG/GV8t+8VNxUkgQiyQmAL6v/mwTcHI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=pDvwkTQG0vGKnkfKVy8dXkyXMLCLT6dZnU7XfhrwTiTEqcxmtVqeZPWvpJi+KeETuaEx4Kz1vw+dmhZWK4NP9H3+mCptGc/7tGjq4/SBqBsoT7fp/y0M7WEPaVEtWtut49+DZHpmEfESfYXS617gn/duXgIoZdVo9rdjwZmk3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GADYM1DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DADC433F1;
	Thu, 29 Feb 2024 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709213702;
	bh=f1sgVZlHzxptTG/GV8t+8VNxUkgQiyQmAL6v/mwTcHI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GADYM1DUa1e1ZZDBTSqyT1rgUB8FpJhOc2k3b5YwhJEvJgelOITEKQklqy06MY33T
	 IASu0gjF80aZkcmC5zBL3vWPAIg96swnFnHdLv4AoTBQPtKmGBxJAMBDH5x+5JOi6F
	 Wqk02KHiobqhKY469NLo3A9FSFgpv2p45duN9Q4DmyZTmGrOl9j3aMFuJRatPAD1bS
	 kzyi/O2hLC4KSx/bG1mNb/L92e0m0kfdZA6usSMUNuUEb2850cKhaQEQm4BZr75iqc
	 DKkMyqUTUCarxL1ujwQSAnQsJVcHPW5IY7/XJUt05P3cBeiTfiKC6z5TQb3S4vOkh0
	 Hx/vvo6BcNQAw==
Date: Thu, 29 Feb 2024 07:35:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
Message-Id: <170921330946.3211963.3147957291854433103.robh@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: imx8: add cm40 and cm40_uart


On Wed, 28 Feb 2024 14:54:56 -0500, Frank Li wrote:
> Add cm40 subsystem.
> Add cm40_lpuart and lpurt1 for 8dxl evk boards.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Alice Guo (1):
>       arm64: dts: imx8dxl: add lpuart device in cm40 subsystem
> 
> Dong Aisheng (1):
>       arm64: dts: imx8: add cm40 subsystem dtsi
> 
> Frank Li (2):
>       arm64: dts: imx8dxl: update cm40 irq number informaiton
>       dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
> 
>  arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 92 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts   | 50 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi      | 13 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
>  4 files changed, 156 insertions(+)
> ---
> base-commit: 62a517a071e93c650cc847ce300b04a94b0cb7f2
> change-id: 20240228-m4_lpuart-30791c032f2a
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 
> 
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx8dxl-evk.dtb' for 20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com:

arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /: fixedregulator@101: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: bus@34000000: clock-cm40-ipg: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], 'clock-frequency': [[132000000]], 'clock-output-names': ['cm40_ipg_clk'], 'phandle': [[15]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: intmux@37400000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a070000: Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /modem-reset: failed to match any schema with compatible: ['gpio-reset']






