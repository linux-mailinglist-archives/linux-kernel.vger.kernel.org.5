Return-Path: <linux-kernel+bounces-19488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED079826DAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC8D1C223DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE0D3FE5F;
	Mon,  8 Jan 2024 12:21:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B043FE54;
	Mon,  8 Jan 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rMod7-0004sJ-33;
	Mon, 08 Jan 2024 12:21:23 +0000
Date: Mon, 8 Jan 2024 12:21:15 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 3/3] arm64: dts: mediatek: mt7988: add clock
 controllers
Message-ID: <ZZvou6RXPcXZS72s@makrotopia.org>
References: <20240108085228.4727-1-zajec5@gmail.com>
 <20240108085228.4727-4-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108085228.4727-4-zajec5@gmail.com>

On Mon, Jan 08, 2024 at 09:52:28AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Add bindings of on-SoC clocks.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> V2: New PATCH in the series thanks to Daniel's bindings work
> 
>  arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 41 ++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 5a778188ac21..bba97de4fb44 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -78,12 +78,51 @@ gic: interrupt-controller@c000000 {
>  			#interrupt-cells = <3>;
>  		};
>  
> -		watchdog@1001c000 {
> +		clock-controller@10001000 {
> +			compatible = "mediatek,mt7988-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		clock-controller@1001b000 {
> +			compatible = "mediatek,mt7988-topckgen", "syscon";
> +			reg = <0 0x1001b000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		watchdog: watchdog@1001c000 {
>  			compatible = "mediatek,mt7988-wdt";
>  			reg = <0 0x1001c000 0 0x1000>;
>  			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>  			#reset-cells = <1>;
>  		};
> +
> +		clock-controller@1001e000 {
> +			compatible = "mediatek,mt7988-apmixedsys";
> +			reg = <0 0x1001e000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		clock-controller@11f40000 {
> +			compatible = "mediatek,mt7988-xfi-pll";
> +			reg = <0 0x11f40000 0 0x1000>;
> +			resets = <&watchdog 16>;
> +			#clock-cells = <1>;
> +		};
> +
> +		clock-controller@15000000 {
> +			compatible = "mediatek,mt7988-ethsys", "syscon";
> +			reg = <0 0x15000000 0 0x1000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		clock-controller@15031000 {
> +			compatible = "mediatek,mt7988-ethwarp";
> +			reg = <0 0x15031000 0 0x1000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.35.3
> 

