Return-Path: <linux-kernel+bounces-83615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD20869C49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEBF1F224AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A31DFD6;
	Tue, 27 Feb 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lk+vdFlk"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CF249EE;
	Tue, 27 Feb 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051790; cv=none; b=FT2kqj2EP9n1PRCdQmzpdpApcuu4e4QFn5Alv4wwQiP33uz0s+iQ0FbEVWE+JH7C2ZeKAFO5ABhskDNSv6KZYxOBoI+EQ8en8Ra6XbAsndYbAMKoU8in75MfoU+D9jaDRAnsae2ymYy0o/Eqh1rtNFYQfohFp+q1agy6TpHOJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051790; c=relaxed/simple;
	bh=9iq97HWcmCoTBXP6eMMJq8y9Em2ni06xkSEPi2bvfhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixM1TeMJqISCSb1zN9w8OaLBIA8MKYdijff6PHuil5JRsxKT0CgEpWJ7E7cJlu1hDzH4Aqo/e7v9lBN5qx844mKsxW60FN4BdArqr5RwQrprdNUnl13+hdxO5kR4YZ5PzLIbQV3VezdW3OXD4CHZy7kym5RjsKuRMbJKXzDUCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lk+vdFlk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E59B20007;
	Tue, 27 Feb 2024 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709051786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1HjaL0N4MQbpBEM8c6K7nKarXSwAV7+wRWAqTEQw6nQ=;
	b=Lk+vdFlkAOtang21DjVUcPqXZ4xGmhzcxrPvzUf24IYp4biewuQduaZWoOtjhyxNcN62Rr
	rwxOMoCoIRZX8wclegXOQ76VXTHyjapTr9IsP2t6ODUtGaiqRsLJbUwI44+vvfEXexbb94
	9/bAnwyQ9P3XE+Euu4f/yR4u4RGs3y9WzvKTTIxXUmjR9YpE0MFyeN/1jw0p+Ze7kGCnuc
	ldhXELyC5r7hPxbHFBp0ACq9Wy+swSTwc84hn7yW8M/Jmp37LYLF68PK2vHN8r1Z5B0iFn
	/GIEHqOOyOX3wHmJ4ik/OXScGHoUIg1Cf9QcVlv/TtrPEjZgCwaeT5tqz5m43Q==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, huziji@marvell.com,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: enachman@marvell.com
Subject: Re: [PATCH v2 2/2] arm64: dts: ac5: add mmc node and clock
In-Reply-To: <20240103172803.1826113-3-enachman@marvell.com>
References: <20240103172803.1826113-1-enachman@marvell.com>
 <20240103172803.1826113-3-enachman@marvell.com>
Date: Tue, 27 Feb 2024 17:36:25 +0100
Message-ID: <871q8xkgom.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hi Elad Nachman,

> From: Elad Nachman <enachman@marvell.com>
>
> Add mmc and mmc clock nodes to ac5 and ac5x device tree files
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 31 ++++++++++++++++++-
>  .../boot/dts/marvell/ac5-98dx35xx-rd.dts      |  4 +++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> index b5e042b8e929..5591939e057b 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> @@ -77,7 +77,6 @@ soc {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
> -		dma-ranges;
>  
>  		internal-regs@7f000000 {
>  			#address-cells = <1>;
> @@ -204,6 +203,30 @@ gpio1: gpio@18140 {
>  			};
>  		};
>  
> +		mmc_dma: bus@80500000 {
> +				compatible = "simple-bus";
> +				ranges;
> +				#address-cells = <0x2>;
> +				#size-cells = <0x2>;
> +				reg = <0x0 0x80500000 0x0 0x100000>;
> +				dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> +				dma-coherent;
> +
> +				sdhci: mmc@805c0000 {
> +					compatible = "marvell,ac5-sdhci",
> +						     "marvell,armada-ap806-sdhci";
> +					reg = <0x0 0x805c0000 0x0 0x1000>;
> +					interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&emmc_clock>, <&cnm_clock>;
> +					clock-names = "core", "axi";
> +					bus-width = <8>;
> +					non-removable;
> +					mmc-ddr-1_8v;
> +					mmc-hs200-1_8v;
> +					mmc-hs400-1_8v;
> +				};
> +		};
> +
>  		/*
>  		 * Dedicated section for devices behind 32bit controllers so we
>  		 * can configure specific DMA mapping for them
> @@ -335,5 +358,11 @@ nand_clock: nand-clock {
>  			#clock-cells = <0>;
>  			clock-frequency = <400000000>;
>  		};
> +
> +		emmc_clock: emmc-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts b/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
> index f0ebdb84eec9..0c973d7a215a 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
> @@ -99,3 +99,7 @@ parition@2 {
>  		};
>  	};
>  };
> +
> +&sdhci {
> +	status = "okay";
> +};
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

