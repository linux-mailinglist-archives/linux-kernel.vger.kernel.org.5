Return-Path: <linux-kernel+bounces-110810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FF88642F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D361C21D71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD693BB29;
	Thu, 21 Mar 2024 23:59:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F93232;
	Thu, 21 Mar 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065580; cv=none; b=L0Gp21EQLR1e+f9CRyERjflWsgDlQZYsNMrU/PQ9YJxzIucbygI3kVF5R/CF1uhmWU8yB6szMfW0vnIQWrgBX3WzZPI+2zqIHC9rqiNWKAxBSQjulXGez0eLRDHC5WoWphrr8C1B4bPZPiW2zmHiwWHdIeVsi4yKVgvNgdBSCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065580; c=relaxed/simple;
	bh=E+LpOx8pQNhgwqAc3magzlEX4PjQi7OMb+7ANa97yBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+80gaV+5d8znNqkTylLPfFgY7EJxGmgf6/2RslodUILdeB2cJAELZH1p/L4YJmPJZJUJDRwoDtsqaawx+Bb/bw5f0IbgB5OUeaiwPzmMrjflMZpm35cs74etHnhyXu0PkL4fpAOnK5ogGZ1pMJf9GpqDhudQyusi1etw26d1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F9B1007;
	Thu, 21 Mar 2024 17:00:10 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9793D3F64C;
	Thu, 21 Mar 2024 16:59:34 -0700 (PDT)
Date: Thu, 21 Mar 2024 23:59:27 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: allwinner: drop underscore in node
 names
Message-ID: <20240321235927.273c4010@minigeek.lan>
In-Reply-To: <20240317184130.157695-2-krzysztof.kozlowski@linaro.org>
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
	<20240317184130.157695-2-krzysztof.kozlowski@linaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 19:41:28 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi Krzysztof,

> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  Use also generic name for pwrseq
> node, because generic naming is favored by Devicetree spec.  All the
> clocks affected by this change use clock-output-names, so resulting
> clock name should not change.  Functional impact checked with comparing
> before/after DTBs with dtx_diff and fdtdump.

Many thanks for cleaning this up!
I checked that this indeed just renames the pwrseq node names and the
clock node names. I can confirm that the clock names didn't change, also
the SDIO pwrseq still worked as before: boot tested on a BananaPi-M64,
which is affected by both changes.
Also the other changes look fine: the RTL8189 node names and CPU trip
point node names. So:

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> 
> ---
> 
> Not tested on hardware.
> ---
>  .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     |  2 +-
>  .../arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts |  2 +-
>  .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts     |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts  |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts   |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi          | 10 +++++-----
>  .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts  |  2 +-
>  .../boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts     |  4 ++--
>  .../boot/dts/allwinner/sun50i-h5-orangepi-prime.dts    |  2 +-
>  .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts     |  2 +-
>  .../dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  2 +-
>  .../arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts |  2 +-
>  .../boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts    |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi  |  2 +-
>  .../boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts  |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts   |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi           |  2 +-
>  .../dts/allwinner/sun50i-h618-transpeed-8k618-t.dts    |  2 +-
>  .../boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts    |  2 +-
>  22 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index e6d5bc0f7a61..d1f415acd7b5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -53,7 +53,7 @@ led-2 {
>  		};
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  		clocks = <&rtc CLK_OSC32K_FANOUT>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> index 0af6dcdf7515..dec9960a7440 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -41,7 +41,7 @@ led {
>  		};
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		clocks = <&rtc CLK_OSC32K_FANOUT>;
>  		clock-names = "ext_clock";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index bfb806cf6d7a..fd3794678c33 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -52,7 +52,7 @@ reg_usb1_vbus: usb1-vbus {
>  		status = "okay";
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index 4f8529d5ac00..c8303a66438d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -68,7 +68,7 @@ reg_usb1_vbus: usb1-vbus {
>  		status = "okay";
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
>  		clocks = <&rtc CLK_OSC32K_FANOUT>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 50ed2e9f10ed..6c65d5bc16ba 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -79,7 +79,7 @@ reg_vcc5v0: vcc5v0 {
>  		enable-active-high;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> index 0a5607f73049..c6007df99938 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> @@ -98,7 +98,7 @@ vdd_bl: regulator {
>  		enable-active-high;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  		post-power-on-delay-ms = <200>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index 1128030e4c25..b407e1dd08a7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -74,7 +74,7 @@ reg_usb1_vbus: usb1-vbus {
>  		status = "okay";
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 57ac18738c99..7b01f68cf7f0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -120,14 +120,14 @@ opp-432000000 {
>  		};
>  	};
>  
> -	osc24M: osc24M_clk {
> +	osc24M: osc24M-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <24000000>;
>  		clock-output-names = "osc24M";
>  	};
>  
> -	osc32k: osc32k_clk {
> +	osc32k: osc32k-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <32768>;
> @@ -216,21 +216,21 @@ map1 {
>  			};
>  
>  			trips {
> -				cpu_alert0: cpu_alert0 {
> +				cpu_alert0: cpu-alert0 {
>  					/* milliCelsius */
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_alert1: cpu_alert1 {
> +				cpu_alert1: cpu-alert1 {
>  					/* milliCelsius */
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "hot";
>  				};
>  
> -				cpu_crit: cpu_crit {
> +				cpu_crit: cpu-crit {
>  					/* milliCelsius */
>  					temperature = <110000>;
>  					hysteresis = <2000>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> index 4c3921ac236c..b69032c44557 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> @@ -68,7 +68,7 @@ vdd_cpux: gpio-regulator {
>  		states = <1100000 0>, <1300000 1>;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>  		post-power-on-delay-ms = <200>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> index a3e040da38a0..3a7ee44708a2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> @@ -103,7 +103,7 @@ vdd_cpux: gpio-regulator {
>  		states = <1100000 0x0>, <1300000 0x1>;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>  		post-power-on-delay-ms = <200>;
> @@ -170,7 +170,7 @@ &mmc1 {
>  	non-removable;
>  	status = "okay";
>  
> -	rtl8189etv: sdio_wifi@1 {
> +	rtl8189etv: wifi@1 {
>  		reg = <1>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> index d7f8bad6bb98..b699bb900e13 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> @@ -85,7 +85,7 @@ reg_usb0_vbus: usb0-vbus {
>  		status = "okay";
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&pio 2 14 GPIO_ACTIVE_LOW>; /* PC14 */
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> index 7ec5ac850a0d..ae85131aac9c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> @@ -97,7 +97,7 @@ &mmc1 {
>  	 * Explicitly define the sdio device, so that we can add an ethernet
>  	 * alias for it (which e.g. makes u-boot set a mac-address).
>  	 */
> -	rtl8189ftv: sdio_wifi@1 {
> +	rtl8189ftv: wifi@1 {
>  		reg = <1>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index 22530ace12d5..734481e998b8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> @@ -52,7 +52,7 @@ reg_vcc3v3: vcc3v3 {
>  		regulator-max-microvolt = <3300000>;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
>  		post-power-on-delay-ms = <200>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 381d58cea092..3be1e8c2fdb9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -34,7 +34,7 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>  
> -	ext_osc32k: ext_osc32k_clk {
> +	ext_osc32k: ext-osc32k-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <32768>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index 6fc65e8db220..6c3bfe3d09d9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -33,7 +33,7 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>  
> -	ext_osc32k: ext_osc32k_clk {
> +	ext_osc32k: ext-osc32k-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <32768>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
> index fb31dcb1cb6d..a3f65a45bd26 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
> @@ -11,7 +11,7 @@ aliases {
>  		serial1 = &uart1; /* BT-UART */
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		clocks = <&rtc CLK_OSC32K_FANOUT>;
>  		clock-names = "ext_clock";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> index 92745128fcfe..13b07141c334 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> @@ -32,7 +32,7 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>  
> -	ext_osc32k: ext_osc32k_clk {
> +	ext_osc32k: ext-osc32k-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <32768>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index 1b6e5595ac6e..66fe03910d5e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -11,7 +11,7 @@ / {
>  	model = "Pine H64 model B";
>  	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
>  		post-power-on-delay-ms = <200>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index 1ffd68f43f87..3910393be1f9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -22,7 +22,7 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	ext_osc32k: ext_osc32k_clk {
> +	ext_osc32k: ext-osc32k-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <32768>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index d11e5041bae9..8a8591c4e7dd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -68,7 +68,7 @@ de: display-engine {
>  		status = "disabled";
>  	};
>  
> -	osc24M: osc24M_clk {
> +	osc24M: osc24M-clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <24000000>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> index ac0a2b7ea6f3..a1d0cac4d244 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> @@ -41,7 +41,7 @@ reg_vcc3v3: vcc3v3 {
>  		regulator-always-on;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		clocks = <&rtc CLK_OSC32K_FANOUT>;
>  		clock-names = "ext_clock";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> index b6e3c169797f..c204dd43c726 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
> @@ -42,7 +42,7 @@ reg_vcc5v: regulator-5v {
>  		regulator-always-on;
>  	};
>  
> -	wifi_pwrseq: wifi_pwrseq {
> +	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  		post-power-on-delay-ms = <200>;


