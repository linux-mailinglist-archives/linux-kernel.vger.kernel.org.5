Return-Path: <linux-kernel+bounces-104599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5A87D0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2198EB2269E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BC40859;
	Fri, 15 Mar 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvuPrbXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B144D9FD;
	Fri, 15 Mar 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517851; cv=none; b=H6Z29NroCGFFlNIjSsamegSrFaH4O3yE+M9eXxKPx0xf5Jm34Z+fUFb/tKwgqBUF2wAVAezsIvP56JcJN/4Uqd/rQuQQ3DWRLJx1WWk+LmEfWiq/qcRSIh3L+ewGpyyGFM8YCsexvqxYZMG3gvwp9DMiAvNheRJaEDjNRryn0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517851; c=relaxed/simple;
	bh=7a2Hm3pXFDdr5XBE0kbmXjURCAgqL5QaBK1DuRiWk9U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tIFEYHp5mj3PQEq9g66HqMBT6NBV5q1twuqSKtAvDdDGo6WHrRiltKdSZ9tgYjTDUehzjDd0lAbtGwCf6p0dleLX3X9yC/dCNE6FUi29NlbFxLQxicvkW7pHn/ZkA4mWVuRpkAXbx0UP5xSf/w8UxyoJ2HJIlvSW8jSZ3PGvvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvuPrbXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694C2C433C7;
	Fri, 15 Mar 2024 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517851;
	bh=7a2Hm3pXFDdr5XBE0kbmXjURCAgqL5QaBK1DuRiWk9U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pvuPrbXTfOndaQEzFFp666MD+A1WudAqkzua//+PVFT8JbWkmfgXD3e0ekIusUTfQ
	 xYz/WXmpd2AKN95kwGT89SomtK4TNbzF2xKC3F7N7ni5fNFbzgRSkOcjuLEz2ovl7h
	 s+UwmwPq0Ol12u2CXGRAosLNGFZtJDD0XTBKL1JZlxfvgoLalAqKVlIeEYREbqKph3
	 teLHiLDznyB1ndJTnbNrQCMKiBThklX6MbtC/Dsn2cfYte/JixzTKW3wk+jxx+diMY
	 boW0gAxTsPNWvuSb1DnIOJB/2SNqT3TTfTuRotegToupeAZ1vHN6IIbkl355ol70Ii
	 pXoMXMQOljVEA==
Date: Fri, 15 Mar 2024 09:50:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, wenst@chromium.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 jenneron@protonmail.com, devicetree@vger.kernel.org, matthias.bgg@gmail.com
In-Reply-To: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
References: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
Message-Id: <171051663323.1379909.15085873286971472306.robh@kernel.org>
Subject: Re: [PATCH 0/2] MediaTek: Add HP Chromebook x360 13b-ca0002sa


On Thu, 14 Mar 2024 11:34:58 +0100, AngeloGioacchino Del Regno wrote:
> This series adds support for the HP Chromebook x360 13b-ca0002sa,
> Cherry platform, codename Dojo.
> 
> There are very few differences with Tomato, and specifically:
>  - Different touchscreen controller (still HID over I2C, different addr)
>  - Different (dual MAX98390) speaker amplifier
>  - Slightly different keyboard top row keymap
>  - NVMe storage over PCIe0
> 
> This series depends on [1] the ASoC MTK cleanup, and was tested working
> by PostmarketOS community members.
> 
> As for the changes in mt8195-cherry.dtsi: personally tested on MT8195
> Cherry Tomato, no issues.
> 
> [1]: https://lore.kernel.org/r/20240313110147.1267793-1-angelogioacchino.delregno@collabora.com
> 
> AngeloGioacchino Del Regno (2):
>   dt-bindings: arm: mediatek: Add MT8195 HP Chromebook x360 13b-ca0002sa
>   arm64: mediatek: mt8195-cherry: Introduce the MT8195 Dojo Chromebook
> 
>  .../devicetree/bindings/arm/mediatek.yaml     |   8 ++
>  arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>  .../dts/mediatek/mt8195-cherry-dojo-r1.dts    | 114 ++++++++++++++++++
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
>  4 files changed, 128 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
> 
> --
> 2.44.0
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8195-cherry-dojo-r1.dtb' for 20240314103500.93158-1-angelogioacchino.delregno@collabora.com:

arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: mt8195-sound: 'audio-routing', 'spk-playback-dai-link' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/mt8195-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: soc: jpgdec-master: {'compatible': ['mediatek,mt8195-jpgdec'], 'power-domains': [[51, 24]], 'iommus': [[142, 621], [142, 622], [142, 626], [142, 627], [142, 628], [142, 629]], '#address-cells': 2, '#size-cells': 2, 'ranges': True, 'jpgdec@1a040000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 436469760, 0, 65536]], 'iommus': [[142, 621], [142, 622], [142, 626], [142, 627], [142, 628], [142, 629]], 'interrupts': [[0, 343, 4, 0]], 'clocks': [[41, 3]], 'clock-names': ['jpgdec'], 'power-domains': [[51, 23]]}, 'jpgdec@1a050000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 436535296, 0, 65536]], 'iommus': [[142, 621], [142, 622], [142, 626], [142, 627], [142, 628], [142, 629]], 'interrupts': [[0, 344, 4, 0]], 'clocks': [[41, 4]], 'clock-names': ['jpgdec'], 'power-domains': [[51, 24]]}, 'jpgdec@1b040000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 453246976, 0, 65536]], 'iommus': [[124, 653], 
 [124, 654], [124, 658], [124, 659], [124, 660], [124, 661]], 'interrupts': [[0, 348, 4, 0]], 'clocks': [[35, 3]], 'clock-names': ['jpgdec'], 'power-domains': [[51, 25]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: soc: jpgenc-master: {'compatible': ['mediatek,mt8195-jpgenc'], 'power-domains': [[51, 27]], 'iommus': [[124, 647], [124, 648], [124, 649], [124, 652]], '#address-cells': 2, '#size-cells': 2, 'ranges': True, 'jpgenc@1a030000': {'compatible': ['mediatek,mt8195-jpgenc-hw'], 'reg': [[0, 436404224, 0, 65536]], 'iommus': [[142, 615], [142, 616], [142, 617], [142, 620]], 'interrupts': [[0, 342, 4, 0]], 'clocks': [[41, 2]], 'clock-names': ['jpgenc'], 'power-domains': [[51, 26]]}, 'jpgenc@1b030000': {'compatible': ['mediatek,mt8195-jpgenc-hw'], 'reg': [[0, 453181440, 0, 65536]], 'iommus': [[124, 647], [124, 648], [124, 649], [124, 652]], 'interrupts': [[0, 347, 4, 0]], 'clocks': [[35, 2]], 'clock-names': ['jpgenc'], 'power-domains': [[51, 27]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: syscon@10001000: compatible: ['mediatek,mt8195-infracfg_ao', 'syscon', 'simple-mfd'] is too long
	from schema $id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: /soc/pwrap@10024000/pmic: failed to match any schema with compatible: ['mediatek,mt6359']
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: /soc/pwrap@10024000/pmic/mt6359rtc: failed to match any schema with compatible: ['mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: infra-iommu@10315000: interrupts: [[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long
	from schema $id: http://devicetree.org/schemas/iommu/mediatek,iommu.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: ec@0: 'keyboard-backlight' does not match any of the regexes: '^extcon[0-9]*$', '^i2c-tunnel[0-9]*$', '^regulator@[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: pwm@1100e000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: pmic@34: #interrupt-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6360.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: codec@1a: Unevaluated properties are not allowed ('VBAT-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5682s.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: codec@1a: 'DBVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5682s.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: codec@1a: 'LDO1-IN-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/realtek,rt5682s.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: amplifier@38: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: amplifier@39: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: t-phy@11e30000: 'power-domains' does not match any of the regexes: '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/mediatek,tphy.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: display@14f06000: clocks: [[37, 14], [37, 43], [37, 44]] is too long
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,split.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c015000: clock-names:0: 'pixel' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c015000: clock-names:1: 'engine' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: mutex@1c101000: 'clock-names', 'reg-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mutex.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000: clock-names:0: 'pixel' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000: clock-names:1: 'engine' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000: Additional properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: edp-tx@1c500000: 'aux-bus' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: rt1019p: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/realtek,rt1015p.yaml#



