Return-Path: <linux-kernel+bounces-86760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14F86CA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C69284810
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC1012AAEC;
	Thu, 29 Feb 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewBmccIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3B86266;
	Thu, 29 Feb 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213704; cv=none; b=TZVNe9JDKL8NbmgqowGp8ypH7prxzzO0hsH08mHnWeFc3P9Rlsm7e2YvULq6zJqrcC9dqWzMn+2RuZEggP8SjIRS/KpD3JMx14L2yV/emhmhk5TDa2LkzxYGpOBeO8bQB3kGsmyTtfWI2NLSK8I48AZZyBVdYDgj0z5LwnOeHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213704; c=relaxed/simple;
	bh=aBrhvIlGKSzS4/ibsxpIQXy9kXn4vS1wQM/4kWF4tYE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=luamrkgNCgEeVR/OzLYCcFZ3CjQVHKvaMKT82U4sXsT9A0LvfNab1mUOYKwx/N1DKxGy4y/P592GvBKTGn3StqIJsaJLPtLliXnTjAY8PGp9GgyAD9MiMIVKWQOnmWVLAbtw9i8RY8QfXcu+OgL/Am7+lK93hWYF9YZeB04pO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewBmccIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A86C433C7;
	Thu, 29 Feb 2024 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709213704;
	bh=aBrhvIlGKSzS4/ibsxpIQXy9kXn4vS1wQM/4kWF4tYE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ewBmccIKFppNSXMYGJ/JOaa4BPZyUV8y/hdJI4UT9n9PB8qg2GSNqLJcNVVyU55Cr
	 Z7/Jxeg4aRkXh7PgD0WGTqSW8g8BcE2iifnYg5zuwTzQOGx+QnxBiKPSmuNUAbkx/7
	 DcahcrQpYW/y83huysLcX2A3qCAnr911YxiKeICvprNvmU79LIUv5YXShAiwLTEm8i
	 UvpPzZ5FErGgCUquBFs6Cyc6ramQrom6kY8mZMzr1xIlKRVgtzygHhmxKkm9tNv/m9
	 fYfVsto97Q/NGmLWiyjkwEC1gnZzN/w36sYcuq5+sx11hdMXOYQWKzCTTnvPZaomfU
	 RD5WDXt59Hhhg==
Date: Thu, 29 Feb 2024 07:35:03 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: robh+dt@kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, shawnguo@kernel.org, devicetree@vger.kernel.org, 
 festevam@gmail.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240229082337.3090778-1-parthiban@linumiz.com>
References: <20240229082337.3090778-1-parthiban@linumiz.com>
Message-Id: <170921330970.3211978.15088255449645039046.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Seeed studio NPi based
 boards


On Thu, 29 Feb 2024 13:53:36 +0530, Parthiban Nallathambi wrote:
> NPi i.MX6ULL eMMC/NAND is Seed Studios SoM using i.MX6ULL.
> Development baords can be either based on NAND or eMMC
> SoM.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb' for 20240229082337.3090778-1-parthiban@linumiz.com:

arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2000000/touchscreen@2040000: failed to match any schema with compatible: ['fsl,imx6ul-tsc']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2000000/touchscreen@2040000: failed to match any schema with compatible: ['fsl,imx6ul-tsc']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2000000/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6ul-anatop', 'fsl,imx6q-anatop', 'syscon', 'simple-mfd']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2000000/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6ul-anatop', 'fsl,imx6q-anatop', 'syscon', 'simple-mfd']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2000000/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6ul-anatop', 'fsl,imx6q-anatop', 'syscon', 'simple-mfd']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2000000/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6ul-anatop', 'fsl,imx6q-anatop', 'syscon', 'simple-mfd']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6ul-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6ul-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2000000/iomuxc-gpr@20e4000: failed to match any schema with compatible: ['fsl,imx6ul-iomuxc-gpr', 'fsl,imx6q-iomuxc-gpr', 'syscon']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2000000/iomuxc-gpr@20e4000: failed to match any schema with compatible: ['fsl,imx6ul-iomuxc-gpr', 'fsl,imx6q-iomuxc-gpr', 'syscon']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2000000/iomuxc-gpr@20e4000: failed to match any schema with compatible: ['fsl,imx6ul-iomuxc-gpr', 'fsl,imx6q-iomuxc-gpr', 'syscon']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2000000/iomuxc-gpr@20e4000: failed to match any schema with compatible: ['fsl,imx6ul-iomuxc-gpr', 'fsl,imx6q-iomuxc-gpr', 'syscon']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dtb: /soc/bus@2200000/pinctrl@2290000: failed to match any schema with compatible: ['fsl,imx6ull-iomuxc-snvs']
arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dtb: /soc/bus@2200000/pinctrl@2290000: failed to match any schema with compatible: ['fsl,imx6ull-iomuxc-snvs']






