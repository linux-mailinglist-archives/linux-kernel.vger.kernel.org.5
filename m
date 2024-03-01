Return-Path: <linux-kernel+bounces-89127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99786EAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8761C21950
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9F56774;
	Fri,  1 Mar 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNOZKr75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05355798;
	Fri,  1 Mar 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326692; cv=none; b=YPZoZuvYNGmHIo2lpGTr50fP09Poo0y82bH8V1rfubbwQvVK8Atc1wSynx32JC4lEOuAx5izA2uixmSwTHeZEc8mht42RgrLO5zuZ81ZFPtw3T2F3Q2EraYo0eO54pVCt2TlF2QwrLpTtPCzP6upN36pEIwH7jcGBYBnxLn9mgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326692; c=relaxed/simple;
	bh=QfXWjisJCygjup8FEhMSH3v5ABlr9rqnOWNDyoIelKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuJOoArxJt6zwAJhGOzbpPdPF08t6i+Ms6kMfFffNzecRG9RoaB84BASB9WZWZ2ZT5KKsakt6JUcAYUbuMPQYmIQy14wf7wSQcgHQ80XNWsjg8Kpy0nKO2jt+iTzQ2xKMD9TBEQ61XEwKv/TCkF7N/kH8MSa5ZN3byWR3ycudJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNOZKr75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607E0C433C7;
	Fri,  1 Mar 2024 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709326692;
	bh=QfXWjisJCygjup8FEhMSH3v5ABlr9rqnOWNDyoIelKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QNOZKr75BVzdEIv9+HSIaXn+vdlkEuu1zndVwMXTo70hWkQGnDqmyibYVPC0daMFP
	 aPbEdcJfBEQmwJNYkJ2eNwsDJaS/2g9Mod5BNZDDCP9J9EcDBvZ07MoqsZufvicBma
	 LXh9WHgIALYr3HzTbEy/Tj3Bz/lgQMEa6dEe/9SLS4Ak89cNHgXw1pPDTU37UZ8HRV
	 LH0pT4I2ALoq6KVpKNRfk1G7pGPzxmJvkOyKT2fgGHkuE8mPUIZGcD9oH9NQYP1/MW
	 a0Z/uTAEQpINp3PjhxkVantakZuQ9i8E3yTrHUI0euaYxpi/9XSV7PHbd/UmaLZ/Lg
	 8OvcObG98k30g==
Message-ID: <bfd9b146-061b-4f82-a703-3bd32ffc09b7@kernel.org>
Date: Fri, 1 Mar 2024 22:58:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/02/2024 18:25, Roger Quadros wrote:
> The RESET GPIO pinmux should be part of MDIO bus node
> so that they can be in the right state before the PHY
> can be probed via MDIO bus scan.
> 
> Add GPIO reset for the Gigabit Ethernet PHY. As per
> RTL8211F datasheet, reset assert width is 10ms and
> PHY registers can be access accessed after 50ms of
> reset deassert.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index a34e0df2ab86..77240cf3ae4d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
>  		pinctrl-single,pins = <
>  			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
>  			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
> +			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */

This should be PIN_OUTPUT.
Will fix in next spin.

> +			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
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

