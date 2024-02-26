Return-Path: <linux-kernel+bounces-81989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C06867D63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C4C28B943
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564612F36E;
	Mon, 26 Feb 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxDANL8s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0513A267;
	Mon, 26 Feb 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966480; cv=none; b=oQqVSQqP+RpIp3RAOjjnxO7bvOOU9ykQbpoBF1Hn0lFk1NyLS1wv6QdzX8gK/CugBbaFrEZLpoqSMkwQ50nmCPLn+CMHp1zvPSJjIlfC6seT7aD78xdFLRu90+12KAsT/bHAD3irD601aYs9ZTT+OGLrOtl3Aa3e2oaashHF51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966480; c=relaxed/simple;
	bh=26oXoCu2TWD6rAB32lk2X2SDok2PFCj8u4grH07Yj/w=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MDrikRWiRfXF3V74gvR9At6Pe3UH7O5CX/rHePlTsKrkk3m+QMpsT8/uP1FxatAiWLC9TNNwToxCUh2Ihu7H0bv+kXHZWoOaA6LWPSRzSUG9qr810zAKhLFEjq0Pr0vBZF9g4mHPflU1U9Au7ZKvyEzBYGiW7ev94nES6sTo630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxDANL8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC856C433C7;
	Mon, 26 Feb 2024 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966480;
	bh=26oXoCu2TWD6rAB32lk2X2SDok2PFCj8u4grH07Yj/w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SxDANL8s8d9cR/idKfpCI7YSq0UEn6JDVrVBYV/iqycwfZlQkWmpJFYwTVZqhflOQ
	 btoDEqXVzVIr5nK3jXMOE+SAkRQf9o6mmx8CkmEtchoHyUBn2hrQZXbNDXfwA8T45h
	 tpdHcx5hzDveJ4nN7DW7EFH0/AEumHIdKlPiW2nHfyK1YBWuchLCmS9CXcp8MpIIHj
	 CAzcCkmGSscQJY+9+S1zOZxkh9vpxhVzlbnE66ukigQ4PU5BVv8C6dPdYNslsK7HXX
	 8cHlRTH84KhibtFQ1vKnGnS1AF18tmZxInUGqjfm9zmN6XkIV/F1rwcr23hkdO84ZF
	 jG8ptX0dVkZqw==
Date: Mon, 26 Feb 2024 10:54:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 NXP Linux Team <linux-imx@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
References: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
Message-Id: <170896502357.859096.11059996215054413497.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: add i.MX95 and EVK board


On Mon, 26 Feb 2024 21:20:15 +0800, Peng Fan (OSS) wrote:
> Add a minimal i.MX95 dtsi and EVK board dts.
> i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
> driver still not ready for i.MX95, so we count on bootloader to
> configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
> driver ready, we could move to use scmi pinctrl.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Addressed Rob and Krzysztof's comments, and fix dts_check issue
>   To pass the dtbs_check, need apply:
>    https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
>    https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
>    https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
>    https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
>    https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/
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
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  115 ++
>  arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
>  arch/arm64/boot/dts/freescale/imx95-power.h       |   55 +
>  arch/arm64/boot/dts/freescale/imx95.dtsi          | 1177 +++++++++++++++++++++
>  6 files changed, 1541 insertions(+)
> ---
> base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
> change-id: 20240218-imx95-dts-aae4316671a7
> 
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
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


New warnings running 'make CHECK_DTBS=y freescale/imx95-19x19-evk.dtb' for 20240226-imx95-dts-v2-0-00e36637b07e@nxp.com:

arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/mailbox@42430000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/mailbox@42730000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@42530000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/i2c@42530000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@42540000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/i2c@42540000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@426b0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/i2c@426b0000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@426c0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/i2c@426c0000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@426d0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/i2c@426d0000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@426e0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@42000000/i2c@426e0000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/mailbox@44220000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/mailbox@445b0000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/mailbox@445d0000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/mailbox@445f0000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/mailbox@44630000: failed to match any schema with compatible: ['fsl,imx95-mu']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@44340000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/i2c@44340000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: i2c@44350000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long
	'fsl,imx95-lpi2c' is not one of ['fsl,imx7ulp-lpi2c']
	'fsl,imx95-lpi2c' is not one of ['fsl,imx8qxp-lpi2c', 'fsl,imx8dxl-lpi2c', 'fsl,imx8qm-lpi2c', 'fsl,imx8ulp-lpi2c', 'fsl,imx93-lpi2c']
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx-lpi2c.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/bus@44000000/i2c@44350000: failed to match any schema with compatible: ['fsl,imx95-lpi2c', 'fsl,imx7ulp-lpi2c']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: adc@44530000: interrupts: [[0, 199, 4], [0, 200, 4], [0, 201, 4]] is too short
	from schema $id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47520000: failed to match any schema with compatible: ['fsl,imx95-mu-ele']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47530000: failed to match any schema with compatible: ['fsl,imx95-mu-ele']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47540000: failed to match any schema with compatible: ['fsl,imx95-mu-ele']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47550000: failed to match any schema with compatible: ['fsl,imx95-mu-ele']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47560000: failed to match any schema with compatible: ['fsl,imx95-mu-ele']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47570000: failed to match any schema with compatible: ['fsl,imx95-mu-ele']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47350000: failed to match any schema with compatible: ['fsl,imx95-mu-v2x']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: /soc/mailbox@47320000: failed to match any schema with compatible: ['fsl,imx95-mu-v2x']
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: interrupt-controller@4b0b0000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#






