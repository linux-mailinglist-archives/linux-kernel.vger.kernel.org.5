Return-Path: <linux-kernel+bounces-89149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0286EB26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA631C2303B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FB5822C;
	Fri,  1 Mar 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL2nG3xa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19E58209;
	Fri,  1 Mar 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328566; cv=none; b=uzby13Jo5DFukkPCd5UkfBV+ERIiM6i26LG483rsQDIwjl+e2CKmR/IDj107Kfw3wBcfBIEzUwLP8MzNFfAxtq5vp6JZnWIcNfKtgNngNem+tTzCqlM9CIRaJpk0QbtFbK3cqVVX/Ae/GbBZueGVvzNzHPnOjFLPvUUvErUuKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328566; c=relaxed/simple;
	bh=vj5xEH7fjHnCsUaWPp/rfGTkYmisd9/pyhsPrZI9JiU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O8xIopO66I2nWXC+wnWfX9BDTLsdVz+O39TR1kwnK53t3pz+F4/IXlCzfOvxrQM1+EWKmstVLK1W6svi/cearZ3VLWAUeWcXVWlMzYbndKRXpW6JD+d270PEvmd4JkW0dLr7g/sxW9TeLP1cvm5aUvdudws0QgIGbDLXHkkivHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL2nG3xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D890C433C7;
	Fri,  1 Mar 2024 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328566;
	bh=vj5xEH7fjHnCsUaWPp/rfGTkYmisd9/pyhsPrZI9JiU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uL2nG3xal35mWb0HMMwfMhRyxrm7y8/1u2N0RGpyIA7BdpuW8uokla19vF/+dS6t/
	 8hPSLC+Huzu9kiEsxmmJnO4XHR8dTGrp2Hk2V7ZBJ9ZgrcgtylTkAUbK1aUJuan6vj
	 YZaw2MsINK3X/oM1Dlwavne5RNddHYeGRfzKMBYjPJtUCiYA+PJxhud38kIMuJYFkE
	 bIgUfBrV5s4n3ryKIglWE93yOVMfF6mOcUvBKp0+3VvbR3c/+7quBapeLn8TJ14sZK
	 3k8t3Nnq7Ja8/cPXYBhJVHjBzkjHM3wcFbXB/ZlGape3EIpZHVYBnJQjHKPlbT6pGd
	 zcNiU4EJrJBlA==
Message-ID: <c75d35c1-13f8-4f79-bf96-9a73e88d1b19@kernel.org>
Date: Fri, 1 Mar 2024 23:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org>
 <bfd9b146-061b-4f82-a703-3bd32ffc09b7@kernel.org>
In-Reply-To: <bfd9b146-061b-4f82-a703-3bd32ffc09b7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/03/2024 22:58, Roger Quadros wrote:
> 
> 
> On 29/02/2024 18:25, Roger Quadros wrote:
>> The RESET GPIO pinmux should be part of MDIO bus node
>> so that they can be in the right state before the PHY
>> can be probed via MDIO bus scan.
>>
>> Add GPIO reset for the Gigabit Ethernet PHY. As per
>> RTL8211F datasheet, reset assert width is 10ms and
>> PHY registers can be access accessed after 50ms of
>> reset deassert.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> index a34e0df2ab86..77240cf3ae4d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>> @@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
>>  		pinctrl-single,pins = <
>>  			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
>>  			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
>> +			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
> 
> This should be PIN_OUTPUT.
> Will fix in next spin.

Actually PIN_INPUT is correct else we won't be able to read the correct GPIO pin status
on gpio read.
I observe this issue on u-boot at least.

> 
>> +			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */

This one needs to be fixed to PIN_INPUT.

>>  		>;
>>  	};
>>  
>> @@ -383,7 +385,6 @@ AM62X_IOPAD(0x017c, PIN_INPUT, 1) /* (AD22) RGMII2_RX_CTL.RMII2_RX_ER */
>>  			AM62X_IOPAD(0x016c, PIN_INPUT, 1) /* (Y18) RGMII2_TD0.RMII2_TXD0 */
>>  			AM62X_IOPAD(0x0170, PIN_INPUT, 1) /* (AA18) RGMII2_TD1.RMII2_TXD1 */
>>  			AM62X_IOPAD(0x0164, PIN_INPUT, 1) /* (AA19) RGMII2_TX_CTL.RMII2_TX_EN */
>> -			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
>>  			AM62X_IOPAD(0x0190, PIN_INPUT, 7) /* (AE22) RGMII2_RD3.GPIO1_6 */
>>  			AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
>>  		>;
>> @@ -597,6 +598,9 @@ &cpsw3g_mdio {
>>  
>>  	cpsw3g_phy0: ethernet-phy@0 {
>>  		reg = <0>;
>> +		reset-gpios = <&main_gpio0 15 GPIO_ACTIVE_LOW>;
>> +		reset-assert-us = <10000>;
>> +		reset-deassert-us = <50000>;
>>  	};
>>  
>>  	cpsw3g_phy1: ethernet-phy@1 {
>> @@ -615,7 +619,7 @@ &main_gpio0 {
>>  		"USR0", "USR1", "USR2", "USR3", "", "", "USR4",	/* 3-9 */
>>  		"EEPROM_WP",					/* 10 */
>>  		"CSI2_CAMERA_GPIO1", "CSI2_CAMERA_GPIO2",	/* 11-12 */
>> -		"CC1352P7_BOOT", "CC1352P7_RSTN", "", "", "",	/* 13-17 */
>> +		"CC1352P7_BOOT", "CC1352P7_RSTN", "GBE_RSTN", "", "",	/* 13-17 */
>>  		"USR_BUTTON", "", "", "", "", "", "", "", "",	/* 18-26 */
>>  		"", "", "", "", "", "", "", "", "", "HDMI_INT",	/* 27-36 */
>>  		"", "VDD_WLAN_EN", "", "", "WL_IRQ", "GBE_INTN",/* 37-42 */
>>
>> ---
>> base-commit: bbef42084cc170cbfc035bf784f2ff055c939d7e
>> change-id: 20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-098f274fbf15
>>
>> Best regards,
> 

-- 
cheers,
-roger

