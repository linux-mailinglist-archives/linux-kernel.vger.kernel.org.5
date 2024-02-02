Return-Path: <linux-kernel+bounces-49619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE5846D48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9969BB2B67F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D778B78;
	Fri,  2 Feb 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQQe/mrQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B6487A7;
	Fri,  2 Feb 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867691; cv=none; b=YIC8885s62yG4lvC+gkmzYScdpQ13LCq0DnzOyQjwoENicyn2B84vgpDFb7Eb2rjhA4m+FHdlvPHsy7RjomuTTCaN0COlFsSAvzfcBrPvpzQsEZq+CHJrnBJMq7rRqcRAKCQe5Lcy+2amQYxf+GGptbI/Te/K/7rhCctMQpi/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867691; c=relaxed/simple;
	bh=Wp6H4kX1lKHyIutWo3Ze/1OUO6DOsMZfBQQlx0oszbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLjJ+YuGLrZL4Vq6wfEyvphACZtCv+hVzIr6B9GCCbLq0x1Q433MbLw0fmjelUHJQM8Au4CVAw9EKaO01BM0YGFdg5niMRFe5oQkXk1tKP0XyOfUawaXPcgwPwXo9+NHpzjyLeFlGOjTqLaE2A0eWnlZoDza6crxCzZAHsDY+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQQe/mrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7D4C433C7;
	Fri,  2 Feb 2024 09:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706867691;
	bh=Wp6H4kX1lKHyIutWo3Ze/1OUO6DOsMZfBQQlx0oszbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQQe/mrQpxV6NU8EfEV2i0f5+F4mG4EE9YbFprtwRFZUxzud0ouYvBc0Eor9fOsR5
	 S+Zqmunx9hHksCkAeEvt6oOXySfLSUs+4DV5iF2GxJUGJsd3goP7ZdLbx7BI94AV5y
	 ou1XSyiSm0TBd61DcGEKCFm+Q/SclZgek9Rm6tGEg2srosk3BHkCaGTuo2KLhw3T5R
	 1kMXuh44XEHfgrLJqwioOdRs7afKykqvzLdOSADp9FWCPow+RCIXtj7+j8bw6OP/DJ
	 +Cc6niIVMhqVbRJ41wu3Eeh7uppvXWpdbBqaUuS1DL74EqgEwnRfhigNaxK/XFfwS0
	 6bQ290loxcnXg==
Message-ID: <9c78f4b5-8580-4679-ae65-60878221e00b@kernel.org>
Date: Fri, 2 Feb 2024 11:54:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/13] arm64: dts: ti: k3-am6*: Reorganize MMC
 properties
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
 <20240131003714.2779593-14-jm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240131003714.2779593-14-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 02:37, Judith Mendez wrote:
> Reorganize various MMC properties for MMC nodes to be
> more uniform across devices.
> 
> Add ti,clkbuf-sel to MMC nodes that are missing this property.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 5 +++--
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 --
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 ++
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 7 +++++--
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 3 +--
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
>  7 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index ca825088970f..32a8a68f1311 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -559,9 +559,9 @@ sdhci0: mmc@fa10000 {
>  		clock-names = "clk_ahb", "clk_xin";
>  		assigned-clocks = <&k3_clks 57 6>;
>  		assigned-clock-parents = <&k3_clks 57 8>;
> +		bus-width = <8>;

Is bus-width fix for this instance? If not then we don't really know here what
bus-width is used by the board implementation. And it should come in the
board DTS file.

>  		mmc-ddr-1_8v;
>  		mmc-hs200-1_8v;
> -		bus-width = <8>;
>  		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-mmc-hs = <0x0>;
> @@ -576,8 +576,8 @@ sdhci1: mmc@fa00000 {
>  		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>  		clock-names = "clk_ahb", "clk_xin";
> -		ti,clkbuf-sel = <0x7>;
>  		bus-width = <4>;
> +		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-sd-hs = <0x0>;
>  		ti,otap-del-sel-sdr12 = <0xf>;
> @@ -599,6 +599,7 @@ sdhci2: mmc@fa20000 {
>  		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
>  		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
>  		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-sd-hs = <0x0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index f69dbf9b8406..0422615e4d98 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -836,7 +836,6 @@ &sdhci1 {
>  	bootph-all;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd_pins_default>;
> -
>  	vmmc-supply = <&vdd_3v3_sd>;
>  	vqmmc-supply = <&vdd_sd_dv>;
>  	disable-wp;
> @@ -850,7 +849,6 @@ &sdhci2 {
>  	vmmc-supply = <&wlan_en>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
> -	bus-width = <4>;

I wouldn't remove this from here if bus-width is variable for this
instance of MMC controller.

>  	non-removable;
>  	ti,fails-without-test-cd;
>  	cap-power-off-card;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index db5a7746c82e..88b112e657c8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -561,6 +561,8 @@ sdhci1: mmc@fa00000 {
>  		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>  		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
> +		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-sd-hs = <0x0>;
>  		ti,otap-del-sel-sdr12 = <0xf>;
> @@ -572,8 +574,6 @@ sdhci1: mmc@fa00000 {
>  		ti,itap-del-sel-sd-hs = <0x0>;
>  		ti,itap-del-sel-sdr12 = <0x0>;
>  		ti,itap-del-sel-sdr25 = <0x0>;
> -		ti,clkbuf-sel = <0x7>;
> -		bus-width = <4>;
>  		no-1-8-v;
>  		status = "disabled";
>  	};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 6dd48c826f74..2b4c10b35db1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -407,10 +407,12 @@ &main_i2c2 {
>  };
>  
>  &sdhci0 {
> +	/* eMMC */
>  	bootph-all;
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_mmc0_pins_default>;
> +	non-removable;
>  	disable-wp;
>  };
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 1842f05ac351..34706ab9f5fb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -626,9 +626,11 @@ sdhci0: mmc@fa10000 {
>  		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 57 0>, <&k3_clks 57 1>;
>  		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <8>;
>  		mmc-ddr-1_8v;
>  		mmc-hs200-1_8v;
> -		ti,trm-icp = <0x2>;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,trm-icp = <0x8>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-mmc-hs = <0x0>;
>  		ti,otap-del-sel-ddr52 = <0x6>;
> @@ -646,6 +648,8 @@ sdhci1: mmc@fa00000 {
>  		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
>  		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
> +		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-sd-hs = <0x0>;
>  		ti,otap-del-sel-sdr12 = <0xf>;
> @@ -653,7 +657,6 @@ sdhci1: mmc@fa00000 {
>  		ti,otap-del-sel-sdr50 = <0xc>;
>  		ti,otap-del-sel-sdr104 = <0x6>;
>  		ti,otap-del-sel-ddr50 = <0x9>;
> -		ti,clkbuf-sel = <0x7>;
>  		ti,itap-del-sel-legacy = <0x0>;
>  		ti,itap-del-sel-sd-hs = <0x0>;
>  		ti,itap-del-sel-sdr12 = <0x0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 0583ec3a9b52..572b98a217a6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -493,8 +493,8 @@ eeprom@0 {
>  
>  /* eMMC */
>  &sdhci0 {
> +	bootph-all;
>  	status = "okay";
> -	bus-width = <8>;
>  	non-removable;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
> @@ -506,7 +506,6 @@ &sdhci1 {
>  	status = "okay";
>  	vmmc-supply = <&vdd_mmc1>;
>  	pinctrl-names = "default";
> -	bus-width = <4>;
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	disable-wp;
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index c3a77f6282cb..600056105874 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -469,7 +469,6 @@ &sdhci1 {
>  	status = "okay";
>  	vmmc-supply = <&vdd_mmc1>;
>  	pinctrl-names = "default";
> -	bus-width = <4>;
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	disable-wp;
>  };

-- 
cheers,
-roger

