Return-Path: <linux-kernel+bounces-59157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A469984F241
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C414B27C51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6F67E60;
	Fri,  9 Feb 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FK2SHU92"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABF664C9;
	Fri,  9 Feb 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470703; cv=none; b=CXRqTw73gnh1IZo00XR/wP+dj+C5DqvUOj/g4ct+lpE4n5aahiJ9bcmcrl+hAwtL8yiaqzr3b5k0sMgC2dZ92pcPgp4UVCVHolOOCa3IShMQ37cDq8CTU/xRF1RByB26bcTJAA+DtPuwvaZ7PIXvXumumvH/InXLIMIqcad/6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470703; c=relaxed/simple;
	bh=sKhHl6jhkzY2ubfjApNOMunSMfubTCqnhOeVufRe1LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkIssbX/sgyrt9ldU/CRPU48H2W0760i3RZczqX8NN3vhhWLgQNZXyVf/UeR4Awt8bN0VF2FeNAskVq9RkJ4l/52mO3tF6YECfulWBxTRgN+Chl7RQHjbsirtnlqwSnaV6s9Vbft2eGWGKCQC4ptTjxBxy/D4ZYRlHVW5zeO5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FK2SHU92; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707470699;
	bh=sKhHl6jhkzY2ubfjApNOMunSMfubTCqnhOeVufRe1LU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FK2SHU92+qUDn4rAMQZxyOYZ/CgLhp3w39srHrPMlum1nIdJz/pEIwyvQXewZ1SOl
	 yBboWGqWi/OD/ECNSP9cY2s9foHFHXEqiwqXu5Iyw6ywHMgnICiWRnNJ5GM8RqrFA+
	 ZxSLwpaE3G11qrJniCws0Jrn7kRTQo2gYyeooNsTgwWMvOsl+3JPXxpBXO14HWm9kq
	 A/As26nFbSuX4lWjo3fKouVsa2eFjzRKaelKTs3Aya9iHOBqa2kk1wJYV1yNPvFQEL
	 x3x7NxZXiVdsMcqKVnZR1IXDiy2sNq/5TMy7Yb90M09IFmECFxa/4tGQBp4+gOz5m1
	 vrO9GeFlFr8WQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CF09537811F4;
	Fri,  9 Feb 2024 09:24:58 +0000 (UTC)
Message-ID: <76d31dea-2fcf-46ce-8d73-2d84edab797a@collabora.com>
Date: Fri, 9 Feb 2024 10:24:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: media: convert Mediatek consumer IR to
 the json-schema
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240209085616.1062-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240209085616.1062-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/02/24 09:56, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Reworded title
> 2. Made "bus" clock required on MT7623 as well
> 3. Added required #include-s and adjusted "reg" & clocks in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Extended "IR" in title
>      Made "bus" required at MT7623 needs it as well
>      Updated example
> 
> Thanks AngeloGioacchino!

You're welcome :-)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
>   .../bindings/media/mediatek,mt7622-cir.yaml   | 55 +++++++++++++++++++
>   .../devicetree/bindings/media/mtk-cir.txt     | 28 ----------
>   2 files changed, 55 insertions(+), 28 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
>   delete mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
> new file mode 100644
> index 000000000000..c01210e053f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Consumer Infrared Receiver on-SoC Controller
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +allOf:
> +  - $ref: rc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7622-cir
> +      - mediatek,mt7623-cir
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: clk
> +      - const: bus
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ir@10013000 {
> +        compatible = "mediatek,mt7623-cir";
> +        reg = <0x10013000 0x1000>;
> +        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&infracfg CLK_INFRA_IRRX>, <&topckgen CLK_TOP_AXI_SEL>;
> +        clock-names = "clk", "bus";
> +        linux,rc-map-name = "rc-rc6-mce";
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mtk-cir.txt b/Documentation/devicetree/bindings/media/mtk-cir.txt
> deleted file mode 100644
> index 5e18087ce11f..000000000000
> --- a/Documentation/devicetree/bindings/media/mtk-cir.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Device-Tree bindings for Mediatek consumer IR controller
> -found in Mediatek SoC family
> -
> -Required properties:
> -- compatible	    : Should be
> -			"mediatek,mt7623-cir": for MT7623 SoC
> -			"mediatek,mt7622-cir": for MT7622 SoC
> -- clocks	    : list of clock specifiers, corresponding to
> -		      entries in clock-names property;
> -- clock-names	    : should contain
> -			- "clk" entries: for MT7623 SoC
> -			- "clk", "bus" entries: for MT7622 SoC
> -- interrupts	    : should contain IR IRQ number;
> -- reg		    : should contain IO map address for IR.
> -
> -Optional properties:
> -- linux,rc-map-name : see rc.txt file in the same directory.
> -
> -Example:
> -
> -cir: cir@10013000 {
> -	compatible = "mediatek,mt7623-cir";
> -	reg = <0 0x10013000 0 0x1000>;
> -	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> -	clocks = <&infracfg CLK_INFRA_IRRX>;
> -	clock-names = "clk";
> -	linux,rc-map-name = "rc-rc6-mce";
> -};


