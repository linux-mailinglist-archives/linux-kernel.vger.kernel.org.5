Return-Path: <linux-kernel+bounces-129930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B19897229
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57801C2658E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11A149E11;
	Wed,  3 Apr 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt4dzPJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E4149DF6;
	Wed,  3 Apr 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153756; cv=none; b=nerZFYIyKBhB2/DHYw9p9lQ+AMiT/heQoTcOPz3fsVi0j/IWMg8f5Gfuy1fbg5jKmXIRtI6q6Aqo/AbbS4lp26fa6Ec6EchNjWrAyrH6/fYDXASKhVYRxh6hxFJiu+C9nQg6RWxJaiyYeeWlmt/ISfmOEOuPddhWFs8VLuswCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153756; c=relaxed/simple;
	bh=uXhbNM1scU/Wew4vIo6yeu9/fsBFikN97N/zS6AiMuw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qxQv7GTYmcS2VHEjtjwvn8kvGFNdd0SWTqQvmMPJ8L/auFU2N8RuZCi2LkvnGMnmKrrUhzd1gS463ZodB7N/SnshHTNWq9P8khKV4Ug75gpJ6yct2Sc8v/dpL9M8aPRVnB8AbXfDAjfmXe1ff62JaLoMGh2yd6tNzfyTJ+Tku38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt4dzPJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B27C43390;
	Wed,  3 Apr 2024 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153755;
	bh=uXhbNM1scU/Wew4vIo6yeu9/fsBFikN97N/zS6AiMuw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Qt4dzPJ0pSD1cnKfqHlbP/bzMSA8e+e2sNau8t584+oDQilQk4q0UcRkhbo6ZOWo0
	 6/z2G8xNVYEyIA2XlJWAshHBIjUbI8tjIOxweL4dT2VkhAuCmk+14GEELl6f2yOwSj
	 lv3/DvMj8aOk5Po28h8xRA8oh56Xw5DJsXFbKZSuAWb4/f8bUdTey/zEJrhOtJ8ftO
	 kXDjOUbcQk6ZnsGnhkuaTtHZRlhDmE5ll75nTW0rjoM/OXZR2qwVenebCMrKDCFWjv
	 cFtYGBtQ9tHUte0uBCgSL6tToUEiObb96hM396ivJK2Qt/FMS960s7SeF9GuuA1EL5
	 CSgA8EaQoCmxA==
Date: Wed, 03 Apr 2024 09:15:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240403083812.3898480-1-mwalle@kernel.org>
References: <20240403083812.3898480-1-mwalle@kernel.org>
Message-Id: <171215356282.3499087.15685152271673414665.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: sl28: split variant 3/ads2
 carrier


On Wed, 03 Apr 2024 10:38:12 +0200, Michael Walle wrote:
> The devicetree files can be (re-)used in u-boot now, they are imported
> on a regular basis (see OF_UPSTREAM option) there. Up until now, it
> didn't matter for linux and there was just a combined devicetree
> "-var3-ads2" (with ads2 being the carrier board). But if the devicetree
> files are now reused in u-boot, we need to have an individual "-var3"
> variant, because the bootloader is just using the bare "varN" devicetree
> files. Split the "var3" off of the "-var3-ads2" devicetree.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile         |  1 +
>  .../fsl-ls1028a-kontron-sl28-var3-ads2.dts     |  2 +-
>  .../fsl-ls1028a-kontron-sl28-var3.dts          | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dts
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


New warnings running 'make CHECK_DTBS=y freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb freescale/fsl-ls1028a-kontron-sl28-var3.dtb' for 20240403083812.3898480-1-mwalle@kernel.org:

arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: interrupt-controller@6000000: msi-controller@6020000: '#msi-cells' is a required property
	from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v3.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: thermal-zones: 'core-cluster', 'ddr-controller' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: syscon@1e60000: compatible: 'anyOf' conditional failed, one must be fixed:
	['syscon'] is too short
	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'amd,pensando-elba-syscon', 'brcm,cru-clkset', 'freecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93-wakeupmix-syscfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', '
 rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62-usb-phy-ctrl', 'ti,am654-dss-oldi-io-ctrl', 'ti,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)
	from schema $id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/clock-controller@1300000: failed to match any schema with compatible: ['fsl,ls1028a-clockgen']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2100000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2110000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/spi@2120000: failed to match any schema with compatible: ['fsl,ls1028a-dspi', 'fsl,ls1021a-v1.0-dspi']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/mmc@2140000: failed to match any schema with compatible: ['fsl,ls1028a-esdhc', 'fsl,esdhc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/mmc@2140000: failed to match any schema with compatible: ['fsl,ls1028a-esdhc', 'fsl,esdhc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/mmc@2150000: failed to match any schema with compatible: ['fsl,ls1028a-esdhc', 'fsl,esdhc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/mmc@2150000: failed to match any schema with compatible: ['fsl,ls1028a-esdhc', 'fsl,esdhc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2300000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2310000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/gpio@2320000: failed to match any schema with compatible: ['fsl,ls1028a-gpio', 'fsl,qoriq-gpio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/usb@3100000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/usb@3110000: failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1028a-ahci']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@3400000: failed to match any schema with compatible: ['fsl,ls1028a-pcie']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie-ep@3400000: failed to match any schema with compatible: ['fsl,ls1028a-pcie-ep', 'fsl,ls-pcie-ep']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie-ep@3400000: failed to match any schema with compatible: ['fsl,ls1028a-pcie-ep', 'fsl,ls-pcie-ep']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@3500000: failed to match any schema with compatible: ['fsl,ls1028a-pcie']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie-ep@3500000: failed to match any schema with compatible: ['fsl,ls1028a-pcie-ep', 'fsl,ls-pcie-ep']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie-ep@3500000: failed to match any schema with compatible: ['fsl,ls1028a-pcie-ep', 'fsl,ls-pcie-ep']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: dma-controller@8380000: '#dma-cells' is a required property
	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/dma-controller@8380000: failed to match any schema with compatible: ['fsl,ls1028a-qdma', 'fsl,ls1021a-qdma']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/dma-controller@8380000: failed to match any schema with compatible: ['fsl,ls1028a-qdma', 'fsl,ls1021a-qdma']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: audio-controller@f100000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: audio-controller@f110000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: audio-controller@f120000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: audio-controller@f130000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: audio-controller@f140000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: audio-controller@f150000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,0:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,1:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,2:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: mdio@0,3:compatible: ['fsl,enetc-mdio'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,4:compatible: ['fsl,enetc-ptp'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet-switch@0,5:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet-switch@0,5:interrupts:0: [0, 95, 4] is too long
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,6:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: rcec@1f,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: rcec@1f,0:interrupts:0: [0, 94, 4] is too long
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-range', 'device_type', 'ethernet-switch@0,5', 'ethernet@0,0', 'ethernet@0,1', 'ethernet@0,2', 'ethernet@0,4', 'ethernet@0,6', 'mdio@0,3', 'msi-map', 'ranges', 'rcec@1f,0' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,0:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,1:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,2:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: mdio@0,3:compatible: ['fsl,enetc-mdio'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,4:compatible: ['fsl,enetc-ptp'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet-switch@0,5:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet-switch@0,5:interrupts:0: [0, 95, 4] is too long
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: ethernet@0,6:compatible: ['fsl,enetc'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: rcec@1f,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: pcie@1f0000000: rcec@1f,0:interrupts:0: [0, 94, 4] is too long
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@1f0000000/ethernet@0,0: failed to match any schema with compatible: ['fsl,enetc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@1f0000000/ethernet@0,1: failed to match any schema with compatible: ['fsl,enetc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@1f0000000/ethernet@0,2: failed to match any schema with compatible: ['fsl,enetc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@1f0000000/mdio@0,3: failed to match any schema with compatible: ['fsl,enetc-mdio']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@1f0000000/ethernet@0,4: failed to match any schema with compatible: ['fsl,enetc-ptp']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pcie@1f0000000/ethernet@0,6: failed to match any schema with compatible: ['fsl,enetc']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/ierb@1f0800000: failed to match any schema with compatible: ['fsl,ls1028a-enetc-ierb']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2800000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2810000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2820000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2830000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2840000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2850000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2860000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/pwm@2870000: failed to match any schema with compatible: ['fsl,vf610-ftm-pwm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: power-controller@1e34040: '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,ls1028a-rcpm', 'fsl,qoriq-rcpm-2.1+']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/power-controller@1e34040: failed to match any schema with compatible: ['fsl,ls1028a-rcpm', 'fsl,qoriq-rcpm-2.1+']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/timer@2800000: failed to match any schema with compatible: ['fsl,ls1028a-ftm-alarm']
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dtb: /soc/timer@2810000: failed to match any schema with compatible: ['fsl,ls1028a-ftm-alarm']






