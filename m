Return-Path: <linux-kernel+bounces-142576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16A8A2D54
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415331F24008
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D8254FAD;
	Fri, 12 Apr 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CasIk1oU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FA5478B;
	Fri, 12 Apr 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921185; cv=none; b=GQ4VuOUhzf1vqRtj6VRJ58u9IrO/jnwWGQCBM12CYnhNuJOicEB75NMq0GGckSmEYVO1UXn8C35MckeSs19Cx4MBXs83mTIkRA1bBL/lYKV8eEKNBWAZGxYMzKR+JbXfielq3qJFVPqYHleNSHEb1/sf1Z/ZEFG8Fi7Iruj8XEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921185; c=relaxed/simple;
	bh=cf+9acvqV2baUaHRsKZuq4lKdIkB1KKqIBIIHYYkN4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyBzDvgdrvqGDYGFJkSMqIIvshFVPVZnrS2gMKPwiJSOtq/978udCF3vQ/QbthDyi1WqXOcU6g3V6TXU6wCi05hTy/D+oFRAMdeeAITC3BiGglgBkPoynMyeS9wLcbt85rzbHzOWHZQUlQb8wRJHrRz0xVIReLpkDRFVoyZnO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CasIk1oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE1C2BD11;
	Fri, 12 Apr 2024 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921185;
	bh=cf+9acvqV2baUaHRsKZuq4lKdIkB1KKqIBIIHYYkN4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CasIk1oU0cpM9fe3xe6ZxDA+6otQcfrT/tj8gnC+V/aq9vwdm46GuOEGkF1YEhvsJ
	 IP4Z12ukzQGc9NZVIVBj9J65hUpCAdfRl+E9OBRrhxxYhTtKUK13DXHET2IVWstp0C
	 iDgyRgfvGL6nXylvANyfaHBf9wm0Z4OUpw+wjTM6oaYYFteTS61WtFlMjrjteDmtWI
	 33On5pqpw/5Sus0C35haU3MJ+jw6YBNB9JyMvi6hIYRofRQ6eV/fHzmzbngWsOCdsH
	 GVEPa/eqc+y+JrBCzVKn5fnWPfXdaDi6oMRmbqQPCbVqzXQKHEOaQvdwW++0nx4GSx
	 eVniaswAbICHg==
Message-ID: <ced83bf0-e334-4020-be45-ef512fe3cd59@kernel.org>
Date: Fri, 12 Apr 2024 14:26:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET
 GPIOs
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240305-b4-for-v6-9-am65-beagleplay-ethernet-reset-v2-1-2bf463a7bf13@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240305-b4-for-v6-9-am65-beagleplay-ethernet-reset-v2-1-2bf463a7bf13@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vignesh & Nishanth,

On 05/03/2024 15:15, Roger Quadros wrote:
> The RESET GPIO pinmux should be part of MDIO bus node
> so that they can be in the right state before the PHY
> can be probed via MDIO bus scan.
> 
> The GPIO pin should be setup with PIN_INPUT so that
> input circuitry is enabled in case software wants to
> check pin status. Without this, incorrect status is shown
> in /sys/kernel/debug/gpio.
> 
> Add GPIO reset for the Gigabit Ethernet PHY. As per
> RTL8211F datasheet, reset assert width is 10ms and
> PHY registers can be access accessed after 50ms of
> reset deassert.
> 
> Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Could you please pick this for -next.
It should apply cleanly. Thanks!

> ---
> Changes in v2:
> - Fix Subject to "arm64"
> - Enable PIN_INPUT for SPE_RESET to fix GPIO status.
> - Add Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org
> ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index a34e0df2ab86..8ab838f1697c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
>  		pinctrl-single,pins = <
>  			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
>  			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
> +			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
> +			AM62X_IOPAD(0x018c, PIN_INPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
>  		>;
>  	};
>  
> @@ -383,7 +385,6 @@ AM62X_IOPAD(0x017c, PIN_INPUT, 1) /* (AD22) RGMII2_RX_CTL.RMII2_RX_ER */
>  			AM62X_IOPAD(0x016c, PIN_INPUT, 1) /* (Y18) RGMII2_TD0.RMII2_TXD0 */
>  			AM62X_IOPAD(0x0170, PIN_INPUT, 1) /* (AA18) RGMII2_TD1.RMII2_TXD1 */
>  			AM62X_IOPAD(0x0164, PIN_INPUT, 1) /* (AA19) RGMII2_TX_CTL.RMII2_TX_EN */
> -			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
>  			AM62X_IOPAD(0x0190, PIN_INPUT, 7) /* (AE22) RGMII2_RD3.GPIO1_6 */
>  			AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
>  		>;
> @@ -597,6 +598,9 @@ &cpsw3g_mdio {
>  
>  	cpsw3g_phy0: ethernet-phy@0 {
>  		reg = <0>;
> +		reset-gpios = <&main_gpio0 15 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <50000>;
>  	};
>  
>  	cpsw3g_phy1: ethernet-phy@1 {
> @@ -615,7 +619,7 @@ &main_gpio0 {
>  		"USR0", "USR1", "USR2", "USR3", "", "", "USR4",	/* 3-9 */
>  		"EEPROM_WP",					/* 10 */
>  		"CSI2_CAMERA_GPIO1", "CSI2_CAMERA_GPIO2",	/* 11-12 */
> -		"CC1352P7_BOOT", "CC1352P7_RSTN", "", "", "",	/* 13-17 */
> +		"CC1352P7_BOOT", "CC1352P7_RSTN", "GBE_RSTN", "", "",	/* 13-17 */
>  		"USR_BUTTON", "", "", "", "", "", "", "", "",	/* 18-26 */
>  		"", "", "", "", "", "", "", "", "", "HDMI_INT",	/* 27-36 */
>  		"", "VDD_WLAN_EN", "", "", "WL_IRQ", "GBE_INTN",/* 37-42 */
> 
> ---
> base-commit: bbef42084cc170cbfc035bf784f2ff055c939d7e
> change-id: 20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-098f274fbf15
> 
> Best regards,

-- 
cheers,
-roger

