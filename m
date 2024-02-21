Return-Path: <linux-kernel+bounces-74495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2913485D51F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66472871D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88BD3FB19;
	Wed, 21 Feb 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ibcIOx9k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C13FB0C;
	Wed, 21 Feb 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509650; cv=none; b=NARYdkmyqpPOa8BUWV51qI2R4OrmEAXg8FnM1GWDFaAQ6x8OJ2KVFeQDn0xtB9B8rWCvZJsQ1ngHbzKqG5oWOyf0bk8cli20D0Dc7fkxmHdIbdc07cHG6tEOWUMu2RyqQ/CoVkEgf8E4ZmNmENWGWZ4Hpwf4nJEM/P3LWRijUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509650; c=relaxed/simple;
	bh=wcF4f8oB66/zilBylgZvCVlgJPjo9n+Rs862VHuPPtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnIEClPgvfhnuTXqa8BWZjGguOLOCV1q7zUUiKFDv2eyx9nFOQ4N/PuHCK/Jqu8HYSYyU+kz5NferE+pzZIGLW3kcnhyjZ+eH46P5JCyV/Ni9v4LU74oawjR3ZYJFp3zNCsdLadtaSbOo0/ZAmOIALDOoApUbrjz0ST9x2prabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ibcIOx9k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708509646;
	bh=wcF4f8oB66/zilBylgZvCVlgJPjo9n+Rs862VHuPPtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ibcIOx9khG/HibZOQuADQzzX0BqkCDivppWffmnMYxNslmqkpFm4o7N7PSjEXpZ+G
	 Xkdg1M6DbzGGnluOboEfBBz6dgGonmZt8Vz6i/lpF+UaPao1G5aEhqUTAp5CqpLBFC
	 7ZcopzX8/GZGhqzB3/JNcM/Ti4BS7Giq6lr0tyuK1sQiYXvUNwENPtHCChZn3Z0pDr
	 Y4UCiCgo/6gwEHwz07zjY5tP+23KdmbN3DX/rLDIA8EN4lDzOdo6kj1EIZXPHmy5nm
	 8Jj09w1Yn8pqWutpt+q4W1c5Tkjc3MRHBeHMIejmpoh37n7En5xTC0aMcKkauIjoku
	 kr1ftJPjRQhtg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7292237820C8;
	Wed, 21 Feb 2024 10:00:45 +0000 (UTC)
Message-ID: <770b23ec-7199-4202-888d-6a22b7f4af74@collabora.com>
Date: Wed, 21 Feb 2024 11:00:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt7981: add pinctrl
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240221073524.20947-1-zajec5@gmail.com>
 <20240221073524.20947-4-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240221073524.20947-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/02/24 08:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 contains on-SoC PIN controller that is also a GPIO provider.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 37 +++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 4feff3d1c5f4..fdd5c22cfc9c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -86,6 +86,43 @@ pwm@10048000 {
>   			#pwm-cells = <2>;
>   		};
>   
> +		pio: pinctrl@11d00000 {
> +			compatible = "mediatek,mt7981-pinctrl";
> +			reg = <0 0x11d00000 0 0x1000>,
> +			      <0 0x11c00000 0 0x1000>,
> +			      <0 0x11c10000 0 0x1000>,
> +			      <0 0x11d20000 0 0x1000>,
> +			      <0 0x11e00000 0 0x1000>,
> +			      <0 0x11e20000 0 0x1000>,
> +			      <0 0x11f00000 0 0x1000>,
> +			      <0 0x11f10000 0 0x1000>,
> +			      <0 0x1000b000 0 0x1000>;
> +			reg-names = "gpio", "iocfg_rt", "iocfg_rm", "iocfg_rb", "iocfg_lb",
> +				    "iocfg_bl", "iocfg_tm", "iocfg_tl", "eint";
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&gic>;
> +			gpio-ranges = <&pio 0 0 56>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			#interrupt-cells = <2>;
> +
> +			mdio-pins {
> +				mux {

That's board specific. MDIO and SPI0 pins can be used as GPIO instead of,
respectively, ETH and SPI.

Must go to your board devicetree, not here: please move both.

Cheers,
Angelo

> +					function = "eth";
> +					groups = "smi_mdc_mdio";
> +				};
> +			};
> +
> +			spi0-pins {
> +				mux {
> +					function = "spi";
> +					groups = "spi0", "spi0_wp_hold";
> +				};
> +			};
> +
> +		};
> +
>   		clock-controller@15000000 {
>   			compatible = "mediatek,mt7981-ethsys", "syscon";
>   			reg = <0 0x15000000 0 0x1000>;


