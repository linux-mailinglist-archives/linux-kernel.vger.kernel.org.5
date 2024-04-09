Return-Path: <linux-kernel+bounces-136984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B589DAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D426BB26C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D3134723;
	Tue,  9 Apr 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlTWQ+py"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67A135A51;
	Tue,  9 Apr 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669943; cv=none; b=fMOrQDb6lqJfI2IqgVxJOe9D2IUWBxLHuDXfJwJ2gpG/PR/K1vV0WhGe8/0jf8AFRj3zwDf5wgqS5TgvpyT34ye9hrKwLUd7Lq9ync5A1L08WR/8khABAWGS2IzMd11Mo4Y+XLq4XNKpaw9uJ0dbfG8HwcW958PiXps4Bqp+v94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669943; c=relaxed/simple;
	bh=OnuzSH8LAPQvSQO3KHP6BnMusdFNbbSnJDLXb0C2oog=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=A3Qz32eKNuvN24wbczwDCek1sfRgYah7C32tpL4NV5UD8FMTucsNShH0UVxRcCJr71vykvojimUCBu4M8k79y8mTOXqUXlJPKwbOEej5j19mjfSgq2b0zWVZ9DtXNZrqUJNVSQhaNd8BLt23AeoQqt0vjW3yNkqrh+Cp0DfoR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlTWQ+py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDDDC433C7;
	Tue,  9 Apr 2024 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669942;
	bh=OnuzSH8LAPQvSQO3KHP6BnMusdFNbbSnJDLXb0C2oog=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rlTWQ+pyJHr/UrKeCWYzsZ6ZPqc88jOcRa4I2DQWf8hUrTw8MMRRnWBwnXp1WT+Av
	 NY9GpB0QG40V8M/mYNmYO4/hxI42U/z/ie79e4Rqr5wwe8+GPAfq0EuU7mjneOLFsC
	 u1rZCjh9nCfSVWPLmzHZNV7ekOTXbsG5GaCjd8/d/omnFY1lpRb78J8GfsavD9h9iZ
	 NhRsv6b2Mwr8o38huDnnURds06BQXN+KIGpQcEIR4sNFxkeEZ9kSeOORhedmP4kw8f
	 S1QviPf4iw4VrLwp6a1h3ikJLLc1DSIAdEcQeqj+sHPXf1rP1a1N9F8rwVb9AYwYfD
	 3jLQ7kaiRrHWw==
Date: Tue, 09 Apr 2024 08:39:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dianders@chromium.org
In-Reply-To: <20240409095239.627000-1-wenst@chromium.org>
References: <20240409095239.627000-1-wenst@chromium.org>
Message-Id: <171266958532.1032636.2034668017701925023.robh@kernel.org>
Subject: Re: [PATCH RFC] arm64: dts: mediatek: mt8183-kodama: Split into
 base and overlays


On Tue, 09 Apr 2024 17:52:38 +0800, Chen-Yu Tsai wrote:
> All the SKUs of Kodama share much of their .dts, as evident of the
> inclusion of a common .dtsi file. However this scheme builds each
> .dtb file as a complete device tree.
> 
> To deduplicate this, make the common .dtsi file a .dts file, and the
> SKU specific .dts files into .dtso overlay source files. Have the build
> system assemble the SKU specific .dtb files from these components.
> 
> The final composite .dtb files increase in size by around 54 kB, or 22.5%,
> due to the inclusion of symbols and fixup tables, and extra phandle
> properties. This could be slightly reduced by dropping the symbol and
> fixup tables after the overlays are fully applied if desired.
> 
> However if the bootloader can assemble the end .dtb using the base .dtb
> and overlays, and only those are counted, then the combined size
> decreases by around 165 kB, or 68.7%.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Hi,
> 
> This is part of the work I'm looking into and will present at EOSS 2024
> in Seattle [1].
> 
> The idea is to reorganize device trees so that devices within a common
> family, instead of having a common .dtsi file, will share a base DTB
> and apply one or more overlays on top. This allows an upstream [2] or
> downstream [3] bundling script to be able to deduplicate the base DTB
> and get some space savings, however minor they are compared to the
> kernel binary executable.
> 
> This patch gives a simple conversion, but we could even look into
> converting the entire MT8183 Kukui family, which are all based on the
> "Kukui" hardware reference design.
> 
> There are some issues, hence the RFC:
> 
> 1. The base .dtb doesn't have a valid board compatible string sequence
>    yet. Suppose we used the sequence
> 
>      "google,kodama", "mediatek,mt8183"
> 
>    for the base .dtb in this conversion, would that be acceptable? The
>    base .dtb would act like a fallback.
> 
> 2. The composite .dtb files grow in size substantially, due to the base
>    .dtb file being built with overlay support. The symbols and fixup
>    tables could be trimmed out with `fdtput`, but there will still be
>    extra phandles, and also nodes with /omit-if-no-ref/ that would
>    have been removed.
>    For this I could maybe come up with a program to minify the DTB. That
>    would also work for existing composite .dtb files in-tree.
> 
> 3. Such a scheme would require more awareness on the maintainer's part,
>    and of the .dtbo authors. The maintainer needs to be aware of how
>    the composite .dtb files are assembled. The authors need to know that
>    certain constructs, such as /delete-property/ or /delete-node/, won't
>    work.
> 
> [1] https://eoss24.sched.com/event/1aBGe/second-source-component-probing-on-device-tree-platforms-chen-yu-tsai-google-llc
> [2] https://lore.kernel.org/linux-arm-kernel/20240329032836.141899-1-sjg@chromium.org/
> [3] https://crrev.com/c/5412876
> 
>  arch/arm64/boot/dts/mediatek/Makefile                       | 6 ++++++
>  ...ukui-kodama-sku16.dts => mt8183-kukui-kodama-sku16.dtso} | 4 ++--
>  ...ui-kodama-sku272.dts => mt8183-kukui-kodama-sku272.dtso} | 4 ++--
>  ...ui-kodama-sku288.dts => mt8183-kukui-kodama-sku288.dtso} | 4 ++--
>  ...ukui-kodama-sku32.dts => mt8183-kukui-kodama-sku32.dtso} | 4 ++--
>  .../{mt8183-kukui-kodama.dtsi => mt8183-kukui-kodama.dts}   | 0
>  6 files changed, 14 insertions(+), 8 deletions(-)
>  rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku16.dts => mt8183-kukui-kodama-sku16.dtso} (90%)
>  rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku272.dts => mt8183-kukui-kodama-sku272.dtso} (90%)
>  rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku288.dts => mt8183-kukui-kodama-sku288.dtso} (90%)
>  rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku32.dts => mt8183-kukui-kodama-sku32.dtso} (90%)
>  rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama.dtsi => mt8183-kukui-kodama.dts} (100%)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8183-kukui-kodama.dtb' for 20240409095239.627000-1-wenst@chromium.org:

arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt8183'] is too short
	'mediatek,mt8183' is not one of ['mediatek,mt2701-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt2712-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt6580-evbp1']
	'mediatek,mt8183' is not one of ['prestigio,pmt5008-3g']
	'mediatek,mt8183' is not one of ['fairphone,fp1', 'mundoreader,bq-aquaris5']
	'mediatek,mt8183' is not one of ['mediatek,mt6592-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt6755-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt6765-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt6779-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt6795-evb', 'sony,xperia-m5']
	'mediatek,mt8183' is not one of ['archermind,mt6797-x20-dev', 'mediatek,mt6797-evb']
	'mediatek,mt8183' is not one of ['bananapi,bpi-r64', 'mediatek,mt7622-rfb1']
	'mediatek,mt8183' is not one of ['mediatek,mt7623a-rfb-emmc', 'mediatek,mt7623a-rfb-nand', 'mediatek,mt7623n-rfb-emmc', 'bananapi,bpi-r2']
	'mediatek,mt8183' is not one of ['mediatek,mt7629-rfb']
	'mediatek,mt8183' is not one of ['cudy,wr3000-v1', 'xiaomi,ax3000t']
	'mediatek,mt8183' is not one of ['acelink,ew-7886cax', 'bananapi,bpi-r3', 'mediatek,mt7986a-rfb']
	'mediatek,mt8183' is not one of ['mediatek,mt7986b-rfb']
	'mediatek,mt8183' is not one of ['bananapi,bpi-r4']
	'mediatek,mt8183' is not one of ['mediatek,mt8127-moose']
	'mediatek,mt8183' is not one of ['mediatek,mt8135-evbp1']
	'mediatek,mt8183' is not one of ['mediatek,mt8167-pumpkin']
	'google,elm-rev8' was expected
	'google,hana-rev6' was expected
	'google,hana-rev7' was expected
	'mediatek,mt8183' is not one of ['mediatek,mt8173-evb']
	'google,burnet' was expected
	'google,cozmo' was expected
	'google,damu' was expected
	'mediatek,mt8183' is not one of ['google,fennel-sku0', 'google,fennel-sku1', 'google,fennel-sku2', 'google,fennel-sku6', 'google,fennel-sku7']
	'mediatek,mt8183' is not one of ['google,juniper-sku16', 'google,juniper-sku17']
	'google,kakadu-rev3' was expected
	'google,kakadu-rev3-sku22' was expected
	'google,kappa' was expected
	'mediatek,mt8183' is not one of ['google,katsu-sku32', 'google,katsu-sku38']
	'mediatek,mt8183' is not one of ['google,kodama-sku16', 'google,kodama-sku272', 'google,kodama-sku288', 'google,kodama-sku32']
	'mediatek,mt8183' is not one of ['google,krane-sku0', 'google,krane-sku176']
	'mediatek,mt8183' is not one of ['google,makomo-sku0', 'google,makomo-sku1']
	'mediatek,mt8183' is not one of ['google,pico-sku1', 'google,pico-sku2']
	'mediatek,mt8183' is not one of ['google,willow-sku0', 'google,willow-sku1']
	'mediatek,mt8183' is not one of ['mediatek,mt8183-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt8183-pumpkin']
	'google,steelix-sku393219' was expected
	'google,steelix-sku393220' was expected
	'google,steelix-sku393221' was expected
	'google,steelix-sku196609' was expected
	'mediatek,mt8183' is not one of ['google,steelix-sku131072', 'google,steelix-sku131073']
	'google,tentacruel-sku262147' was expected
	'google,tentacruel-sku262151' was expected
	'google,tentacruel-sku327681' was expected
	'google,tentacruel-sku327683' was expected
	'mediatek,mt8183' is not one of ['mediatek,mt8186-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt8188-evb']
	'google,hayato-rev1' was expected
	'google,hayato-rev5-sku2' was expected
	'google,spherion-rev3' was expected
	'google,spherion-rev4' was expected
	'mediatek,mt8183' is not one of ['mediatek,mt8192-evb']
	'mediatek,mt8183' is not one of ['google,tomato-rev2', 'google,tomato-rev1']
	'google,tomato-rev4' was expected
	'mediatek,mt8183' is not one of ['mediatek,mt8195-demo', 'mediatek,mt8195-evb']
	'mediatek,mt8183' is not one of ['mediatek,mt8365-evk']
	'mediatek,mt8183' is not one of ['mediatek,mt8390-evk']
	'mediatek,mt8183' is not one of ['mediatek,mt8395-evk', 'radxa,nio-12l']
	'mediatek,mt8183' is not one of ['mediatek,mt8516-pumpkin']
	from schema $id: http://devicetree.org/schemas/arm/mediatek.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@c530000: failed to match any schema with compatible: ['mediatek,mt8183-mcucfg', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc0-pins-default:pins-clk:mediatek,pull-down-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc0-pins-uhs:pins-clk:mediatek,pull-down-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc0-pins-uhs:pins-ds:mediatek,pull-down-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc1-pins-default:pins-cmd-dat:mediatek,pull-up-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc1-pins-default:pins-clk:mediatek,pull-down-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc1-pins-uhs:pins-cmd-dat:mediatek,pull-up-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: mmc1-pins-uhs:pins-clk:mediatek,pull-down-adv:0:0: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: panel-pins-default: 'panel-reset' does not match any of the regexes: '^pins', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: uart1-pins-default:pins-rts: 'output-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: uart1-pins-sleep:pins-rts: 'output-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: pinctrl@10005000: 'audiopins', 'audiotdmoutoff', 'audiotdmouton', 'ec-ap-int-odl', 'gpio-line-names', 'h1-int-od-l', 'i2c0', 'i2c1', 'i2c2', 'i2c3', 'i2c4', 'i2c5', 'i2c6', 'pp1800-lcd-en', 'ppvarn-lcd-en', 'ppvarp-lcd-en', 'pwm0-pin-default', 'scp', 'spi0', 'spi1', 'spi2', 'spi3', 'spi4', 'spi5', 'touchdefault', 'ts3a227e_pins' do not match any of the regexes: '-pins(-[a-z]+)?$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6358']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/pwrap@1000d000/pmic/mt6358codec: failed to match any schema with compatible: ['mediatek,mt6358-sound']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/audio-controller@11220000: failed to match any schema with compatible: ['mediatek,mt8183-audiosys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/audio-controller@11220000/mt8183-afe-pcm: failed to match any schema with compatible: ['mediatek,mt8183-audio']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@13000000: failed to match any schema with compatible: ['mediatek,mt8183-mfgcfg', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: dsi@14014000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: dsi@14014000: Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@15020000: failed to match any schema with compatible: ['mediatek,mt8183-imgsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@16000000: failed to match any schema with compatible: ['mediatek,mt8183-vdecsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@17000000: failed to match any schema with compatible: ['mediatek,mt8183-vencsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@19000000: failed to match any schema with compatible: ['mediatek,mt8183-ipu_conn', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@19010000: failed to match any schema with compatible: ['mediatek,mt8183-ipu_adl', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@19180000: failed to match any schema with compatible: ['mediatek,mt8183-ipu_core0', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@19280000: failed to match any schema with compatible: ['mediatek,mt8183-ipu_core1', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /soc/syscon@1a000000: failed to match any schema with compatible: ['mediatek,mt8183-camsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: thermal-zones: 'tboard1', 'tboard2', 'tzts1', 'tzts2', 'tzts3', 'tzts4', 'tzts5', 'tztsABB' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: /mt8183-sound: failed to match any schema with compatible: ['mediatek,mt8183_mt6358_ts3a227_max98357']
arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtb: bt-sco: '#sound-dai-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sound/linux,bt-sco.yaml#






