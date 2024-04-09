Return-Path: <linux-kernel+bounces-136980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9989DAA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A474C29013E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAD131BB2;
	Tue,  9 Apr 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoSJeDDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0813173E;
	Tue,  9 Apr 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669931; cv=none; b=LP8Kk9O83t1P85HcHGDqSOSAwPnCTN+QtyRDiGjmyuJm4Jxyp/X2zzW5EBem9Wl+nRYHD+frr1TJt+vqrED6gOX/SARJL2NyVuLdKoWz9c2XDLAtd78eIXVchjl3oYJBGGkCzXED41C9g9SuCjipWKidixwuXHVrrvaAfa6PjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669931; c=relaxed/simple;
	bh=vx0BqNfIb8F4lDx/iXeS8NQx1kj2f2ZQ4T6UWr5MvSU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UE+xiYACSqiiupLfltxYy4MxRLlsomPesPKxd1v0QZTxQhF3OaSSepEwXfB9rQMQni3VR7cWsarIqRysC1Kx+rt8PACga5pptgDKN4m6BCsrH2Zho1cWfEAsi8AVDlr22y4G+hCAJ7f8PkNYwMUzYmW+eN194Idup93Mx8JEqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoSJeDDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940F7C433C7;
	Tue,  9 Apr 2024 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669930;
	bh=vx0BqNfIb8F4lDx/iXeS8NQx1kj2f2ZQ4T6UWr5MvSU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IoSJeDDwI+KW/z9/tKVlMtK0X5cwXlpLp5tXMyETc76qJvZlRXAKiAUB04IBAA3Xt
	 CmXi0pLFz5ZEVvvnZuCdlWNjVrf17d59sOySGB3CbnlaTO+VDyKzdcRxy4oXCyxA+B
	 NwQiZN3olbmTxEW2pPZLgQibV/kZaaFKfwogZXXleoQFgN2rDM+SvlCWodj8NDxYm0
	 EBTgXkqhyVOAQ9nHiJFfEkZS2kMrqQWqXeF1f56MRBIgS07CGHC9tMflrlJoImZg7E
	 RVFrLZDC9GxVSxhdGmx0GvB92qkU60pa5RsCiiqn5cmSquttNyoLGAn+e3nYC/s39s
	 1TPw03FVwfqYw==
Date: Tue, 09 Apr 2024 08:38:49 -0500
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240408080816.4134370-1-mwalle@kernel.org>
References: <20240408080816.4134370-1-mwalle@kernel.org>
Message-Id: <171266958413.1032531.2798711513331001834.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200


On Mon, 08 Apr 2024 10:08:15 +0200, Michael Walle wrote:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v4:
>  - rebase to latest next
> 
> v3:
>  - drop description and add to mt8395 existing entry
> 
> v2:
>  - convert enum to const as there is only one specific board
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8395-kontron-3-5-sbc-i1200.dtb' for 20240408080816.4134370-1-mwalle@kernel.org:

arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: soc: jpgdec-master: {'compatible': ['mediatek,mt8195-jpgdec'], 'power-domains': [[43, 24]], 'iommus': [[130, 621], [130, 622], [130, 626], [130, 627], [130, 628], [130, 629]], '#address-cells': [[2]], '#size-cells': [[2]], 'ranges': True, 'jpgdec@1a040000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 436469760, 0, 65536]], 'iommus': [[130, 621], [130, 622], [130, 626], [130, 627], [130, 628], [130, 629]], 'interrupts': [[0, 343, 4, 0]], 'clocks': [[34, 3]], 'clock-names': ['jpgdec'], 'power-domains': [[43, 23]]}, 'jpgdec@1a050000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 436535296, 0, 65536]], 'iommus': [[130, 621], [130, 622], [130, 626], [130, 627], [130, 628], [130, 629]], 'interrupts': [[0, 344, 4, 0]], 'clocks': [[34, 4]], 'clock-names': ['jpgdec'], 'power-domains': [[43, 24]]}, 'jpgdec@1b040000': {'compatible': ['mediatek,mt8195-jpgdec-hw'], 'reg': [[0, 453246976, 0, 65536]], 'iommus'
 : [[112, 653], [112, 654], [112, 658], [112, 659], [112, 660], [112, 661]], 'interrupts': [[0, 348, 4, 0]], 'clocks': [[28, 3]], 'clock-names': ['jpgdec'], 'power-domains': [[43, 25]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: soc: jpgenc-master: {'compatible': ['mediatek,mt8195-jpgenc'], 'power-domains': [[43, 27]], 'iommus': [[112, 647], [112, 648], [112, 649], [112, 652]], '#address-cells': [[2]], '#size-cells': [[2]], 'ranges': True, 'jpgenc@1a030000': {'compatible': ['mediatek,mt8195-jpgenc-hw'], 'reg': [[0, 436404224, 0, 65536]], 'iommus': [[130, 615], [130, 616], [130, 617], [130, 620]], 'interrupts': [[0, 342, 4, 0]], 'clocks': [[34, 2]], 'clock-names': ['jpgenc'], 'power-domains': [[43, 26]]}, 'jpgenc@1b030000': {'compatible': ['mediatek,mt8195-jpgenc-hw'], 'reg': [[0, 453181440, 0, 65536]], 'iommus': [[112, 647], [112, 648], [112, 649], [112, 652]], 'interrupts': [[0, 347, 4, 0]], 'clocks': [[28, 2]], 'clock-names': ['jpgenc'], 'power-domains': [[43, 27]]}} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: syscon@10001000: compatible: ['mediatek,mt8195-infracfg_ao', 'syscon', 'simple-mfd'] is too long
	from schema $id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: /soc/pwrap@10024000/pmic: failed to match any schema with compatible: ['mediatek,mt6359']
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: /soc/pwrap@10024000/pmic/mt6359rtc: failed to match any schema with compatible: ['mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: infra-iommu@10315000: interrupts: [[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long
	from schema $id: http://devicetree.org/schemas/iommu/mediatek,iommu.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: ethernet@11021000: Unevaluated properties are not allowed ('snps,rxpbl', 'snps,txpbl' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/mediatek-dwmac.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: regulator: 'BUCK1', 'BUCK2', 'LDO1', 'LDO2', 'LDO3', 'LDO5', 'LDO6', 'LDO7' do not match any of the regexes: '^buck[12]$', '^ldo[123567]$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/regulator/mt6360-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: t-phy@11e30000: 'power-domains' does not match any of the regexes: '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/mediatek,tphy.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: display@14f06000: clocks: [[30, 14], [30, 43], [30, 44]] is too long
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,split.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: dp-intf@1c015000: clock-names:0: 'pixel' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: dp-intf@1c015000: clock-names:1: 'engine' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: mutex@1c101000: 'clock-names', 'reg-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mutex.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: dp-intf@1c113000: clock-names:0: 'pixel' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: dp-intf@1c113000: clock-names:1: 'engine' was expected
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: dp-intf@1c113000: Additional properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#






