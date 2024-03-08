Return-Path: <linux-kernel+bounces-97109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AD8765A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF821C21449
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2093BBE9;
	Fri,  8 Mar 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ERDSAHkK"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FA1DA5F;
	Fri,  8 Mar 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905871; cv=none; b=m+6uMD2zwWMzc+4bHhPAeirpCjEhvZRQ89u32kj1GMcwv3RXN5TX99gLCAR4H4U//IQeooXRPGAliAP2qshiVrh6whCdda0/iHQV/ESGmeyMgrX3k7GBgOSr+Zs60NQ8eM2tCz95AC5DhfiotIY8OnG5EbUgLTbs3xlTrpFye68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905871; c=relaxed/simple;
	bh=oouL9FB478gAMv3XsJnrsRJKmuT/dhzUHeO7PMync0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7NGDE1zN07qpkqOBI4LRn3tT3Vtz7x4C0G+WujPvN8TQ4ZqAibamDj2s16EQYkSIMWqcYSVtWzOPhKLO2eZvof1m5diMosdIQIxdeKkvXX6xQYSRQwsPJR52BH9ZX2qCSpVl2zAI3tFpYMqs0c2zxOABkBxRy8IsDiUwlKLhjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ERDSAHkK; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 727CC6000F;
	Fri,  8 Mar 2024 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709905866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAEC4Dub2/B8+gKqX6uXa9E3HnjRHGOxZ7CagoI5Uzs=;
	b=ERDSAHkKO3hIThuHgHrC1TNON12OSbX3ZEEoP0YMdqGSFwSOmUv/5xDozhBEaZ4ezlWbBM
	q7X8K1p83AZtR9NXCDbsftrs3KkdFI3W8VhIhP8Wk02iKgTt/qOMDIfBEt8jS+eALkuaFZ
	2D9rTxaW133tA7ij30sSXF3E87bT4OfbgPNG0u62eYcZ5clSPtKMZCl+7br7ouh2pj6Y7e
	Kkyjks4O+oUk+ciPhuA/VcWKQACi+ENxpZrTNunstFCL8MiHe0xGhU8AIRsp2BLvWU9GQa
	mFRKUgIOhfS2+Hsw25eecPkmEQBN8mtsPGWx9J4T8mtgVxDMztnWpOOdVnNr+Q==
Message-ID: <55f6ee5c-84af-4976-a66c-63800f733f8f@arinc9.com>
Date: Fri, 8 Mar 2024 16:50:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mips: dts: ralink: mt7621: add serial1 and serial2
 nodes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za>
 <20240307190408.23443-3-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240307190408.23443-3-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 7.03.2024 22:04, Justin Swartz wrote:
> Add serial1 and serial2 nodes to define the existence of
> the MT7621's second and third UARTs.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 28 +++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 3ad4e2343..5a89f0b8c 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -124,6 +124,34 @@ serial0: serial@c00 {
>   			pinctrl-0 = <&uart1_pins>;
>   		};
>   
> +		serial1: serial@d00 {
> +			compatible = "ns16550a";
> +			reg = <0xd00 0x100>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			clocks = <&sysc MT7621_CLK_UART2>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;
> +			no-loopback-test;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart2_pins>;
> +			status = "disabled";
> +		};

I would group this:

		serial1: serial@d00 {
			compatible = "ns16550a";
			reg = <0xd00 0x100>;

			reg-io-width = <4>;
			reg-shift = <2>;

			clocks = <&sysc MT7621_CLK_UART2>;

			interrupt-parent = <&gic>;
			interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;

			no-loopback-test;

			pinctrl-names = "default";
			pinctrl-0 = <&uart2_pins>;

			status = "disabled";
		};

Same goes for patch 2.

Arınç

