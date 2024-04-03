Return-Path: <linux-kernel+bounces-129927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C989721E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A99428DB07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886CA149017;
	Wed,  3 Apr 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRe3iJk+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8E168BD;
	Wed,  3 Apr 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153748; cv=none; b=kVeVpROPMoYriXWnY2B2Oq1VJLSRCTuyD8MaEULbyUX1JQLvZ30vj2IL0F+KOk3C6knGXmNe95kOTYD7agfktRVMfZ11bZZWwe6y9Yvza8yIgF4r5YoGjbhkmO1WqFS/H3PUKHxSCXh1vjcNyZWd9THwaX45Krzcqj5armbIWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153748; c=relaxed/simple;
	bh=D3r5+wFBx1FLrlvAY8cNuumj/f9OxZ2xeveSM5Ic+Y8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XYY8TqWkoHdfSmvP2IpO+Kqx8yd88IYiC6+MYY8xhdagO+quGXPXg8LMEJ59WCJyy3v75Fe04GaQRbp/qinWqBc5T2OR7kdgwtquB8zwPBQZ8nWUZC6m/MvRvuinEQRpYAZ5bbvykRhUxEMJ2GGXKoF6f9Q38HfZXDGLl0Uh9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRe3iJk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A84C433F1;
	Wed,  3 Apr 2024 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153748;
	bh=D3r5+wFBx1FLrlvAY8cNuumj/f9OxZ2xeveSM5Ic+Y8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LRe3iJk+8YCak/5bwJM3P3gLRlEXJOTKZYHHnMrJWFxQIg0m9w4kLJDI/NYTg7GiQ
	 eMQ0i5WpbhkKCVqLCvidz/Z1o8OEtdfO0UHFSdCUbxh3BMIb6e6aJB30cLdAryemRJ
	 QSu1pOf0O3fimpsvJYiktMVyNRcK0Jxgm5CwWu6+8a6YRhHyf7DCAC8uuKRVo0Qk+v
	 y+1B6BxxEg4t9Sj2+M87kObm6IEYmbtWig732v80KMuWaiM45V4lg+6+hI0k+/1WKH
	 1nLCmEqaVGYsgW0dvQ5Bn+4RkH7LCSWnC5akB+NaEcT/FuD6LGvUouMZingeGqMgva
	 LotgRe8x7+0MQ==
Date: Wed, 03 Apr 2024 09:15:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240402193512.240417-1-hiagofranco@gmail.com>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
Message-Id: <171215356139.3498982.1934989893138550223.robh@kernel.org>
Subject: Re: [PATCH v1 0/4] arm64: dts: freescale: Add Toradex Colibri
 iMX8DX


On Tue, 02 Apr 2024 16:35:08 -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This patch series introduces support for Colibri iMX8DX SoM and its
> carrier boards, where the board can be mated with: Aster, Evaluation Board
> v3, Iris v2, and Iris v1. This SoM is a variant of the already supported
> Colibri iMX8QXP, utilizing an NXP i.MX8DX SoC instead of i.MX8QXP.
> Therefore, this patch series also adds support for the i.MX8DX processor.
> 
> Hiago De Franco (4):
>   arm64: dts: freescale: Add i.MX8DX dtsi
>   dt-bindings: arm: fsl: remove reduntant toradex,colibri-imx8x
>   dt-bindings: arm: fsl: Add Colibri iMX8DX
>   arm64: dts: freescale: Add Toradex Colibri iMX8DX
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml   |  7 ++++---
>  arch/arm64/boot/dts/freescale/Makefile           |  4 ++++
>  .../boot/dts/freescale/imx8dx-colibri-aster.dts  | 16 ++++++++++++++++
>  .../dts/freescale/imx8dx-colibri-eval-v3.dts     | 16 ++++++++++++++++
>  .../dts/freescale/imx8dx-colibri-iris-v2.dts     | 16 ++++++++++++++++
>  .../boot/dts/freescale/imx8dx-colibri-iris.dts   | 16 ++++++++++++++++
>  .../arm64/boot/dts/freescale/imx8dx-colibri.dtsi | 11 +++++++++++
>  arch/arm64/boot/dts/freescale/imx8dx.dtsi        | 13 +++++++++++++
>  8 files changed, 96 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dx.dtsi
> 
> --
> 2.39.2
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


New warnings running 'make CHECK_DTBS=y freescale/imx8dx-colibri-aster.dtb freescale/imx8dx-colibri-eval-v3.dtb freescale/imx8dx-colibri-iris-v2.dtb freescale/imx8dx-colibri-iris.dtb' for 20240402193512.240417-1-hiagofranco@gmail.com:

arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: jpegenc@58450000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: jpegenc@58450000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: jpegenc@58450000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: jpegenc@58450000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@591f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@591f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@591f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@599f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@591f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@591f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@591f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@599f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@591f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@591f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@599f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@599f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@5a1f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@5a1f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/spi@5a020000/can@0: failed to match any schema with compatible: ['microchip,mcp2515']
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@5a1f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@5a1f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@5a1f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@5a1f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: touchscreen@2c: adi,first-conversion-delay: b'\x03' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: touchscreen@2c: adi,acquisition-time: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: touchscreen@2c: adi,median-filter-size: b'\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: touchscreen@2c: adi,averaging: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: touchscreen@2c: adi,conversion-interval: b'\xff' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@5a1f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@5a1f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: /bus@5a000000/i2c@5a800000/touchscreen@2c: failed to match any schema with compatible: ['adi,ad7879-1']
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: touchscreen@2c: adi,first-conversion-delay: b'\x03' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: touchscreen@2c: adi,acquisition-time: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: touchscreen@2c: adi,median-filter-size: b'\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: touchscreen@2c: adi,averaging: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: touchscreen@2c: adi,conversion-interval: b'\xff' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@5a9f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/i2c@5a800000/touchscreen@2c: failed to match any schema with compatible: ['adi,ad7879-1']
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: dma-controller@5a9f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: touchscreen@2c: adi,first-conversion-delay: b'\x03' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: touchscreen@2c: adi,acquisition-time: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: touchscreen@2c: adi,median-filter-size: b'\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: touchscreen@2c: adi,averaging: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: touchscreen@2c: adi,conversion-interval: b'\xff' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: /bus@5a000000/i2c@5a800000/touchscreen@2c: failed to match any schema with compatible: ['adi,ad7879-1']
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: touchscreen@2c: adi,first-conversion-delay: b'\x03' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: touchscreen@2c: adi,acquisition-time: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: touchscreen@2c: adi,median-filter-size: b'\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: touchscreen@2c: adi,averaging: b'\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: touchscreen@2c: adi,conversion-interval: b'\xff' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: /bus@5a000000/i2c@5a800000/touchscreen@2c: failed to match any schema with compatible: ['adi,ad7879-1']
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@5a9f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: dma-controller@5a9f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@5a9f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: dma-controller@5a9f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@5a9f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: dma-controller@5a9f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#






