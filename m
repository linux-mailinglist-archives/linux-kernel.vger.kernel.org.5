Return-Path: <linux-kernel+bounces-136985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75089DAB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AFA1C2354C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6813665E;
	Tue,  9 Apr 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEOHTdUf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93852135A6D;
	Tue,  9 Apr 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669945; cv=none; b=lF3dH1HmPKkrNUIxEExif3RSEOR4xB1P9BCb2mCk2EOIxipz0VsWKD9YqNIg5Q5i1VoXWBhWGy1IZcvR1b3NBrjLR9pLweg562NWj8OQSN2D7rGA6rrjpF4774mLgddtem4r1cw2jT82UZCF4KVgi1slpXK3mk8HpAx9ytcgEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669945; c=relaxed/simple;
	bh=7hrNrvhSRHtyZ6X1D6pysKCJsCiJsdLaYXC8yh0wAUM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ABxHq51penHKXuPMuqrxHv9HatQln4WJdLdAUykWlPHAYiMoMnLyUTtUH2+5Ka16szTwKZ8jlQhL0torGHOrx+774w4vRiYbOl8w82i9TJzuAlgsEKT2y+rYoTSqjb/1tftW3pkQjI2upEarPTvIDI8HsV64fRmiblxAV+D/NOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEOHTdUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F34C43399;
	Tue,  9 Apr 2024 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669945;
	bh=7hrNrvhSRHtyZ6X1D6pysKCJsCiJsdLaYXC8yh0wAUM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HEOHTdUfT40MII2SsTPC3kxPREzZm2W/lVyEe9od6xbqeWv+E+CnLbDZ4XpYgcJvS
	 NGI8fSoLiC6wAKLnSlvi2QosYG5cKatT8ATrPC+Gxnl5uWX8ov14lzpj+X4GqfNh9U
	 RUtx+AYrx9o7CTLirh6h10eh+hJRy9k3aU2iPezhwGymSkIyL6oTIT543hHDjbC1q9
	 jMo4X+2mUz8rvpXKXGTei/TMySmwQJxzli35BeyfxLwgA5fF6S1Sio9ZupIHzUeufa
	 xW3V5AqNVXfLZk7+xw+fILjgw+zgISok7gWaUSEW1IGzOKJkYq6E4Zj0g+ZnCZlYd0
	 DN4xtgiXsi4qQ==
Date: Tue, 09 Apr 2024 08:39:04 -0500
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
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, matthias.bgg@gmail.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
References: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
Message-Id: <171266958557.1032651.3727332046208008120.robh@kernel.org>
Subject: Re: [PATCH 0/5] Radxa NIO-12L: Supplies for CPU/GPU and
 improvements


On Tue, 09 Apr 2024 13:42:06 +0200, AngeloGioacchino Del Regno wrote:
> This series performs various improvements and enables PHYs and USB Role
> Switching for proper PM support and to stop relying on the bootloader's
> pre-boot configuration.
> USB Role Switching doesn't include Alternate Modes yet, as this needs
> some more work.
> 
> As for the regulator nodes, those were not probing correctly, producing
> unability to resume after PM suspend.
> 
> AngeloGioacchino Del Regno (5):
>   arm64: dts: mediatek: mt8395-nio-12l: Fix MT6360 regulator nodes names
>   arm64: dts: medaitek: mt8395-nio-12l: Set i2c6 pins to bias-disable
>   arm64: dts: mediatek: mt8395-nio-12l: Define RSEL in microamperes
>   arm64: dts: mediatek: mt8395-nio-12l: Enable PHYs and USB role switch
>   arm64: dts: mediatek: mt8395-nio-12l: Add power supplies for CPU/GPU
>     scaling
> 
>  .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 106 ++++++++++++++++--
>  1 file changed, 94 insertions(+), 12 deletions(-)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8395-radxa-nio-12l.dtb' for 20240409114211.310462-1-angelogioacchino.delregno@collabora.com:

arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: soc: jpgdec-master: {'compatible': ['mediatek,mt8195-jpgdec'], 'power-domains': [[47, 24]], 'iommus': [[137, 621], [137, 622], [137, 626], [137, 627], [137, 628], [137, 629]], '#address-cells': [[2]], '#size-cells': [[2]], 'ranges': True, 'jpgdec@1a040000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 436469760, 0, 65536]], 'iommus': [[137, 621], [137, 622], [137, 626], [137, 627], [137, 628], [137, 629]], 'interrupts': [[0, 343, 4, 0]], 'clocks': [[38, 3]], 'clock-names': ['jpgdec'], 'power-domains': [[47, 23]]}, 'jpgdec@1a050000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 436535296, 0, 65536]], 'iommus': [[137, 621], [137, 622], [137, 626], [137, 627], [137, 628], [137, 629]], 'interrupts': [[0, 344, 4, 0]], 'clocks': [[38, 4]], 'clock-names': ['jpgdec'], 'power-domains': [[47, 24]]}, 'jpgdec@1b040000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 453246976, 0, 65536]], 'iommus': [[119,
  653], [119, 654], [119, 658], [119, 659], [119, 660], [119, 661]], 'interrupts': [[0, 348, 4, 0]], 'clocks': [[32, 3]], 'clock-names': ['jpgdec'], 'power-domains': [[47, 25]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: soc: jpgenc-master: {'compatible': ['mediatek,mt8195-jpgenc'], 'power-domains': [[47, 27]], 'iommus': [[119, 647], [119, 648], [119, 649], [119, 652]], '#address-cells': [[2]], '#size-cells': [[2]], 'ranges': True, 'jpgenc@1a030000': {'compatible': ['mediatek,mt8195-jpgenc-hw'], 'reg': [[0, 436404224, 0, 65536]], 'iommus': [[137, 615], [137, 616], [137, 617], [137, 620]], 'interrupts': [[0, 342, 4, 0]], 'clocks': [[38, 2]], 'clock-names': ['jpgenc'], 'power-domains': [[47, 26]]}, 'jpgenc@1b030000': {'compatible': ['mediatek,mt8195-jpgenc-hw'], 'reg': [[0, 453181440, 0, 65536]], 'iommus': [[119, 647], [119, 648], [119, 649], [119, 652]], 'interrupts': [[0, 347, 4, 0]], 'clocks': [[32, 2]], 'clock-names': ['jpgenc'], 'power-domains': [[47, 27]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: pmic@34: charger: 'usb-otg-vbus' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6360.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: charger: 'usb-otg-vbus' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/supply/mt6360_charger.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: regulator: 'BUCK1', 'BUCK2', 'LDO1', 'LDO2', 'LDO3', 'LDO5', 'LDO6', 'LDO7' do not match any of the regexes: '^buck[12]$', '^ldo[123567]$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/regulator/mt6360-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: display@14f06000: clocks: [[34, 14], [34, 43], [34, 44]] is too long
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,split.yaml#






