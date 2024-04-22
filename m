Return-Path: <linux-kernel+bounces-153310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D48ACC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192AB1F241EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA4146A60;
	Mon, 22 Apr 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rURjD30t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE2146D76;
	Mon, 22 Apr 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786623; cv=none; b=GeqO1wxWOvslFHGeBLxs2iscE8gXXNAIMVGy+IHOyJqYqxXvdcCZu+0m+4OpMDSM123LYHb3dddrLB7xePls7hnC+2p4J+7KH6xodBoXaI6HnjS8kopGRkhEPMQ7BBw4OpZ09ijTdQE3Xu3vmsOSTRwLwiba+OZXz1LJ29ojPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786623; c=relaxed/simple;
	bh=YS917ueHwtBqt9TiFEnAUZ8trcpY/y+Y3C0bGNm08oc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Kj2ODrXo6/xxd6ajn4pUc8ZmRlDfLPR9UP7bNU7o/qnQ/BEYioJIB4yu8mAdJizy/Wf/EkcLP1pox1GcrH1wa6W+rJrlxggMK0H3VKtpCvBj7zd4VwNuYbOyX+uI72oMkgOrGFV7lzTAGmYWP+Qq7WX/cZJQxqTi48b59f2UH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rURjD30t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F134C113CC;
	Mon, 22 Apr 2024 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713786622;
	bh=YS917ueHwtBqt9TiFEnAUZ8trcpY/y+Y3C0bGNm08oc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rURjD30tresfVvBDhALNF39w6T3y5FlfiOPc3mKx02RqAYXlbTp1KRdDiNUxo6yp9
	 GGkF+Y1BBEPDWYBsVdXE0ZWLZQg+Gss9tn3jgS+T9DmQelpy7+Wnuhg5HQ25jJfMlA
	 3x6ZvYlZebkargiU6qV/sK+BUhLffQXyyDM6R4GzTX30XCnMpKol4OPS7X4knwoJL8
	 PkCvCJLFw4AF7K54E7xN0cIRSALmWSZ9RG/v9TqmIK3G4h2RHe+KeqcPnly+R3trK/
	 4H10kbeOv5vu3MIgwrwDRviQrav7Oghq/XzSrLsoLdWHm/pv32kZJ5EXnTM5qQqx4o
	 gqGNCeA5KqUEg==
Date: Mon, 22 Apr 2024 06:50:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Yow-shin Liou <yow-shin.liou@mediatek.com>, 
 Jason-ch Chen <Jason-ch.Chen@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Bear Wang <bear.wang@mediatek.com>, linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20240422093926.15392-1-macpaul.lin@mediatek.com>
References: <20240422093926.15392-1-macpaul.lin@mediatek.com>
Message-Id: <171378646243.749127.4216494442345691988.robh@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt8390-genio-700-evk: update
 regulator names


On Mon, 22 Apr 2024 17:39:24 +0800, Macpaul Lin wrote:
> Update regulator names to match schematics, replacing generic terms.
> 1. Add system wide 'reg_vsys' node for 4.2V power rail.
> 2. Add 'reg_vsys' node as 'vin-supply' for the following nodes
>  - common_fixed_5v, edp_panel_fixed_3v3, gpio_fixed_3v3, sdio_fixed_3v3,
>    touch0_fixed_3v3, usb_hub_fixed_3v3, usb_p0_vbus, and usb_p1_vbus.
> 3. Update regulator names according to the stable output name on
>    schematics.
>  - vdd_5v, vedp_3v3, ext_3v3, vio18_conn, wifi_3v3, vio33_tp1, vhub_3v3,
>    vbus_p0, vbus_p1.
>  - vcn18_pmu, vcn33_2_pmu, dvdd_proc_l, dvdd_core, vpa_pmu, dvdd_adsp,
>    va12_abb2_pmu, vsim1_pmu, vufs18_pmu.
> 4. Remove usb_hub_reset_1v8. Use 'hub' node to probe USB HUB
>    in subsequent patches.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../dts/mediatek/mt8390-genio-700-evk.dts     | 65 ++++++++++++-------
>  1 file changed, 42 insertions(+), 23 deletions(-)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8390-genio-700-evk.dtb' for 20240422093926.15392-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts:925.3-13: Warning (reg_format): /soc/usb@11200000/hub@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts:933.3-13: Warning (reg_format): /soc/usb@11200000/hub@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts:923.17-929.4: Warning (avoid_default_addr_size): /soc/usb@11200000/hub@1: Relying on default #address-cells value
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts:923.17-929.4: Warning (avoid_default_addr_size): /soc/usb@11200000/hub@1: Relying on default #size-cells value
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts:931.17-937.4: Warning (avoid_default_addr_size): /soc/usb@11200000/hub@2: Relying on default #address-cells value
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts:931.17-937.4: Warning (avoid_default_addr_size): /soc/usb@11200000/hub@2: Relying on default #size-cells value
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: /soc/pwrap@10024000/pmic/keys: failed to match any schema with compatible: ['mediatek,mt6359-keys']
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: typec-mux@48: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/usb/ite,it5205.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: i2c@11e01000: pinctrl-names: ['default', 'default'] has non-unique elements
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: rt1715@4e: 'vbus-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: rt1715@4e: 'connector' is a required property
	from schema $id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#






