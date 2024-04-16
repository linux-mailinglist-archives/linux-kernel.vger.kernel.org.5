Return-Path: <linux-kernel+bounces-146704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0555B8A6992
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FE71F21F29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58091292D7;
	Tue, 16 Apr 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZMtk6Ax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8D6D1BC;
	Tue, 16 Apr 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266804; cv=none; b=VPG1H4PnBtRsXvh+hYqg4/JGBOF4EtvE9gmTXIus49dWg+viI9zuUQzkxgzBksSKYHdUeerDmSo4Nx6GgaBEZ7SE7AOt3o4qpfCYhp8nf0ywYdSYV5LozCCC4gXr+Ld68sFlaxDIFgDAt4FBgQ8po6uu5FO3GA9s2nhi+oQRPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266804; c=relaxed/simple;
	bh=jinWfPJk3/OTABs9+MqTy+eTXirJ2lwng/pPgUtjUhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL2Mhbv6o6yfTPTUq0u+DHGFxqDmETmsY2YPImpzcV66xa9Tw60WlsJH/1GpSRuEWF3Tlu8deD/6teu/ks8+tb0Dh9QU0DBLj93jFh3+PimwwqCWj65Dd6UQI4cZJ8t+b6vrHEjQYayPDEVaUaMO5NHcxeC55tkn4JmkJYkkDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZMtk6Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78ABC2BD10;
	Tue, 16 Apr 2024 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713266801;
	bh=jinWfPJk3/OTABs9+MqTy+eTXirJ2lwng/pPgUtjUhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZMtk6Axgd9o3aITOuDYguiqxCx9bnmcY+4/Qwv83S57yzq3F6ug0Jx5tnoX6jTwC
	 FjNnlZu6XOJH+jqjARwFpXktgHNfdZBOC4uE8xQFop+NpG3GEfVO20eWr+gw8BMRAo
	 JfaMdQmWzzD/9nPDqHSNWHAJWD5qaSCESF01W3iP2h7r0VMU9As+nyJH/26z7EGY3k
	 EUkHNCw1H+mdtc1xQ2ENzsowMy7K6ta9vXWzrmh8+FWncC50zGrhjB6qCmHA2vBnT9
	 +Zwc0V7sjXDagQ7O+Oocnls5CC4IYEiaMOwWGhjdSlnN14VvUlxpnzJ++n8YDEFB6t
	 nNBdP/7CvAnQg==
Message-ID: <43994879-bc23-47d5-8f95-491b531271a0@kernel.org>
Date: Tue, 16 Apr 2024 14:26:35 +0300
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

Could you please pick this in the v6.9-rc cycle?
This patch should still apply cleanly.

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

