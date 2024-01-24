Return-Path: <linux-kernel+bounces-36988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CC83A9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C62A1C21E66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A797A735;
	Wed, 24 Jan 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WerqKHpc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46877F19;
	Wed, 24 Jan 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099609; cv=none; b=bHi90UIbL8vgJwpSmX14bxxAW7y4Rld8R/Mjt3nWdNvXN3g56wtzUfnGLK1wABPmbBybGP45LeuA+aGoqV3UsK4F+fjJiwYHfm/rNbXYxJXMWxowF1vuUvtVeFay1yiCULoqK6AOUHW5xFQbjuUyOIymhRUNgxi4qviztyrBrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099609; c=relaxed/simple;
	bh=ZMh7iqIZgYI902YIRrVcFsxLdtDLtRhbiBT/Ncsnml8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCln79Ufw5W3OQqp9g9zg4Y1yARwfKDP1jHHTROq2nL5CknLK/MjUR3Z8ZltrgQBgx/7mdjaD2P8Uze7JZinx5niUEbJ7N/XRgyXSf32EK4ME+1o+sExqG/3++N+KnnazKQ/lwKxN4f47K5hquCKO7j/zqH90xkX7ceZdz9TMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WerqKHpc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706099599;
	bh=ZMh7iqIZgYI902YIRrVcFsxLdtDLtRhbiBT/Ncsnml8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WerqKHpc45Lp24f8eTua8oih5ZL9z1gcOG2ODNaWNOFzUfASve9em1n64H1F+l6x6
	 73dfgZQm3x9qGAW13N6liRMSxmQkXNVjs2noqqzXzT9MiRX0Y7nHyu55k+4VZlKtXe
	 YgUs9Opr0bfXzXHKMmSFMucgK4O2ivclSQBn8Gx/rATyYHAecgJUFZR0DSORUK754S
	 dzD0lyDypgDzvL1Xy0aVwiR6WzxTFIBHN0LXRDRsDKAzHNbPHLhGTR5P/QptSjF3av
	 INd2FDogojLmsndck7v9meID/NOA/6NgdWe+I3sMPiHhuN9vRVgVaCezEGlikaAaZ7
	 i1YXF4Pfz9lcQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CCBFE378207B;
	Wed, 24 Jan 2024 12:33:18 +0000 (UTC)
Message-ID: <62fca33c-eb1a-42ad-b7f7-31b14f0aa446@collabora.com>
Date: Wed, 24 Jan 2024 13:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: media: convert Mediatek consumer IR to the
 json-schema
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240124095230.25704-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240124095230.25704-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/01/24 10:52, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Reworded title
> 2. Added required #include-s and adjusted "reg" in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../bindings/media/mediatek,mt7622-cir.yaml   | 81 +++++++++++++++++++
>   .../devicetree/bindings/media/mtk-cir.txt     | 28 -------
>   2 files changed, 81 insertions(+), 28 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
>   delete mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
> new file mode 100644
> index 000000000000..a2d0eed33292
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek consumer IR on-SoC controller

title: MediaTek Consumer Infrared Receiver on-SoC Controller

> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
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
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: clk
> +      - const: bus

The driver says:

	ir->bus = devm_clk_get(dev, "bus");
	if (IS_ERR(ir->bus)) {
		/*
		 * For compatibility with older device trees try unnamed
		 * ir->bus uses the same clock as ir->clock.
		 */
		ir->bus = ir->clk;
	}

This makes me think that requiring *one* clock on MT7623 would be a mistake
and the devicetree should use clk, bus - CLK_INFRA_IRRX_PD, CLK_TOP_F10M_REF_SEL.

Seen that - I'm sure that setting maxItems: 1 on mediatek,mt7623-cir would as
well be a mistake.

> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: rc.yaml#
> +  - if:

The solution would be to simply delete those if branches and, to keep compatibility
with the already present mt7623.dtsi file, keep min/max items to 1 and 2 (of course
in the case of clock-names, maxItems shall not be declared, as it's dictated by the
consts).

> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt7622-cir
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +
> +        clock-names:
> +          minItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt7623-cir
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          maxItems: 1
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ir@10013000 {

Please use a common generic name, as seen in gpio-ir-receiver.yaml and in
amlogic,meson6-ir.yaml:

ir-receiver@10013000 {

Cheers,
Angelo


