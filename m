Return-Path: <linux-kernel+bounces-49615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA4B846CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716DA282D12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C477653;
	Fri,  2 Feb 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcsYYEuZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F5FDD3;
	Fri,  2 Feb 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867451; cv=none; b=ox6S2lIyfmk2Yvy5apXZO8+wC5/022PQfBRB59mpE5w/UbXwpJmtIud6JoB8C7MLqXuc1WZd+9hgszt2l5SIz4h/2BP4Z0h904t7cfkkF40JKUhkqTnH2m0RSYYasGWtjoH18ajaPigy6NetnPQ2g2cYqT4mCHjjfx9UfLkLfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867451; c=relaxed/simple;
	bh=UOv9WAUGo6DdvUWTEevdtBG7+uDQpU9zejiXNAWE2SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjK3lv08v6Fh1L9S/msTP8vXppIdZSIDeRyBYvgLMzTUWo/7aC4kb3iA2k1gbZQ9pBrw6V7fj4rOIjkgVunS+5CwhvCMelMuzuaQVvSh5mUWPLali0aw0Jyirfiy4NBCzHS7J7nM14tXHU30C8ZTICWTVQdGDN0ZIeyni8GOIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcsYYEuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39313C433F1;
	Fri,  2 Feb 2024 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706867451;
	bh=UOv9WAUGo6DdvUWTEevdtBG7+uDQpU9zejiXNAWE2SQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TcsYYEuZ7l1QCEZntExjJ94bXFMnEaNIxLX6Qr25qXgq+Yip2galckpy4o2QUgAz+
	 6cuXLDGqKxe+CgWLd7SA1vanGv8BVgQUBVm+K8QUR2RoGrfSuNkHnlx5Q1Hh7Svav1
	 0+hbU/2ze31D36CfZW4FYcN8GzMrxWNoMNfsy+QLcaX3NEVLE2ayQvel/pPPX+Ptx6
	 FqAsk8Mk4d3IY2DcUHu0+dO09vYFUoXie9LlDqsiX6OeoluQSQQdsOY4uNLMRKKMHY
	 bmv118fteCTYyhqOOLacOQEJjBZnzWnjWLXLz2fRTnDlWe0q96+haS6AfYxloez+w3
	 F7rBrv28oqHGA==
Message-ID: <0c44863b-7a3e-48bc-bdc8-1069df6d79bd@kernel.org>
Date: Fri, 2 Feb 2024 11:50:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/13] arm64: dts: ti: k3-am62p: Add missing
 properties for MMC
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, devicetree@vger.kernel.org,
 Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <20240131003714.2779593-12-jm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240131003714.2779593-12-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 02:37, Judith Mendez wrote:
> Add missing properties to enable HS200 timing for MMC0 and
> SDR104 timing for MMC1 according to the datasheet [0] for
> AM62p device, refer to Table 7-79 for MMC0 and Table 7-97
> for MMC1/MMC2.
> 
> [0] https://www.ti.com/lit/ds/symlink/am625.pdf
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 44 +++++++++++++++++++++--
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   |  6 ++--
>  2 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 4c51bae06b57..f743700dd5bd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -534,7 +534,21 @@ sdhci0: mmc@fa10000 {
>  		clock-names = "clk_ahb", "clk_xin";
>  		assigned-clocks = <&k3_clks 57 2>;
>  		assigned-clock-parents = <&k3_clks 57 4>;
> -		ti,otap-del-sel-legacy = <0x0>;
> +		bus-width = <8>;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		mmc-hs400-1_8v;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,strobe-sel = <0x77>;
> +		ti,trm-icp = <0x8>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-mmc-hs = <0x1>;
> +		ti,otap-del-sel-ddr52 = <0x6>;
> +		ti,otap-del-sel-hs200 = <0x8>;
> +		ti,otap-del-sel-hs400 = <0x5>;
> +		ti,itap-del-sel-legacy = <0x10>;
> +		ti,itap-del-sel-mmc-hs = <0xa>;
> +		ti,itap-del-sel-ddr52 = <0x3>;
>  		status = "disabled";
>  	};
>  
> @@ -545,7 +559,19 @@ sdhci1: mmc@fa00000 {
>  		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>  		clock-names = "clk_ahb", "clk_xin";
> -		ti,otap-del-sel-legacy = <0x8>;
> +		bus-width = <4>;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-sdr12 = <0xf>;
> +		ti,otap-del-sel-sdr25 = <0xf>;
> +		ti,otap-del-sel-sdr50 = <0xc>;
> +		ti,otap-del-sel-ddr50 = <0x9>;
> +		ti,otap-del-sel-sdr104 = <0x6>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
>  		status = "disabled";
>  	};
>  
> @@ -556,7 +582,19 @@ sdhci2: mmc@fa20000 {
>  		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
>  		clock-names = "clk_ahb", "clk_xin";
> -		ti,otap-del-sel-legacy = <0x8>;
> +		bus-width = <4>;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-sdr12 = <0xf>;
> +		ti,otap-del-sel-sdr25 = <0xf>;
> +		ti,otap-del-sel-sdr50 = <0xc>;
> +		ti,otap-del-sel-ddr50 = <0x9>;
> +		ti,otap-del-sel-sdr104 = <0x6>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
>  		status = "disabled";
>  	};
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 1773c05f752c..10156a04a92c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -410,13 +410,17 @@ &main_i2c2 {
>  };
>  
>  &sdhci0 {
> +	/* eMMC */
> +	bootph-all;
>  	status = "okay";
> +	non-removable;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
>  };
>  
>  &sdhci1 {
>  	/* SD/MMC */
> +	bootph-all;
>  	status = "okay";
>  	vmmc-supply = <&vdd_mmc1>;
>  	vqmmc-supply = <&vddshv_sdio>;
> @@ -424,8 +428,6 @@ &sdhci1 {
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
> -	no-1-8-v;

Why was 'no-1-8-v' removed?

> -	bootph-all;
>  };
>  
>  &cpsw3g {

-- 
cheers,
-roger

