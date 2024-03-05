Return-Path: <linux-kernel+bounces-91922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57387187A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF9284442
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4A4E1C1;
	Tue,  5 Mar 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXtfW3zO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385014DA08;
	Tue,  5 Mar 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628194; cv=none; b=JbkMOBeQeKPyTTv+wG896XNKe4AWmKlw3RK2Wqn11vb1wL70o3QHHQ7RTHqVoy8TLPj/zcpkI2vrmJzjhqTH7zDIMzjnRKmxJyEkICd+JX/DqQnK+nTdH/muMaq8G5qH7XGT5rLHRITHISKkGcfBwM+3QLjDGiZF10dOhn3o/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628194; c=relaxed/simple;
	bh=YoRGIhBI/uVoHBDeB10elS2x0rLV4TT1npUgzbACoQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsI2nLb4qn2kL5dE4ffvHIRG9HNQYJPJuBEfBK7M4BnOkPJmAFkKiL8Aw70QrWy6QuiBsTypzrsonhqZBEm602RtJWiU9N6bt+ZQzSk9cUb2zokSjszeUeoogInAjn//K7AtCW5yE+W2JW5Vql6qF9exgoPHiJRXbdxMQ43Mdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXtfW3zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A450DC433C7;
	Tue,  5 Mar 2024 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709628193;
	bh=YoRGIhBI/uVoHBDeB10elS2x0rLV4TT1npUgzbACoQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mXtfW3zOLWyJIufHuEHOeuKIYo4rdCAezj47ir0F/N6IfTV51b3YuOwlT7s7ygVMA
	 MHBenP+5Lp+MZX0m6Dn3gPhXUxdccbwHxGM3iej0/ts12442jIY6XoS9NFnIJY38zW
	 AEPvwrhPS/zKqKalGmiSt2Q1Z6lg9Zv8ckgYpZ1SOdSPbYlNVAj3njhWm10oFVpU1B
	 /axJSIsa57FIHU0kwh3XNWdpGuLfzvA15Pbi3pw0uay+LqeTaPVbUpDHwsLCfJ7Svg
	 WNkrY6iLogv2YMhKy1UeB2/vWwbHR5vjzEiaXUguWB6VIv98ApAEzYcZkr33zhoqYE
	 NaOkzu53+Sqsg==
Message-ID: <a4188e72-533c-4e1e-9733-e0e8afc03526@kernel.org>
Date: Tue, 5 Mar 2024 10:43:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org>
 <bfd9b146-061b-4f82-a703-3bd32ffc09b7@kernel.org>
 <c75d35c1-13f8-4f79-bf96-9a73e88d1b19@kernel.org>
 <392def9d-5e02-4ca6-8838-c4252ccd4c54@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <392def9d-5e02-4ca6-8838-c4252ccd4c54@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/03/2024 06:24, Vignesh Raghavendra wrote:
> Hi Roger,
> 
> On 02/03/24 02:59, Roger Quadros wrote:
>>
>>
>> On 01/03/2024 22:58, Roger Quadros wrote:
>>>
>>>
>>> On 29/02/2024 18:25, Roger Quadros wrote:
>>>> The RESET GPIO pinmux should be part of MDIO bus node
>>>> so that they can be in the right state before the PHY
>>>> can be probed via MDIO bus scan.
>>>>
>>>> Add GPIO reset for the Gigabit Ethernet PHY. As per
>>>> RTL8211F datasheet, reset assert width is 10ms and
>>>> PHY registers can be access accessed after 50ms of
>>>> reset deassert.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>>> index a34e0df2ab86..77240cf3ae4d 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>>>> @@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
>>>>  		pinctrl-single,pins = <
>>>>  			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
>>>>  			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
>>>> +			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
>>>
>>> This should be PIN_OUTPUT.
>>> Will fix in next spin.
>>
>> Actually PIN_INPUT is correct else we won't be able to read the correct GPIO pin status
>> on gpio read.
>> I observe this issue on u-boot at least.
>>
>>>
>>>> +			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
>>
>> This one needs to be fixed to PIN_INPUT.
> 
> While at it, please fix the $subject prefix:
> 
> arm64: dts: ti: beagleplay: ...

Right.

> 
> Do we need a Fixes: Tag too?

Sure, I'll add.

> 
>>
>>>>  		>;
>>>>  	};
>>>>  
>>>> @@ -383,7 +385,6 @@ AM62X_IOPAD(0x017c, PIN_INPUT, 1) /* (AD22) RGMII2_RX_CTL.RMII2_RX_ER */
>>>>  			AM62X_IOPAD(0x016c, PIN_INPUT, 1) /* (Y18) RGMII2_TD0.RMII2_TXD0 */
>>>>  			AM62X_IOPAD(0x0170, PIN_INPUT, 1) /* (AA18) RGMII2_TD1.RMII2_TXD1 */
>>>>  			AM62X_IOPAD(0x0164, PIN_INPUT, 1) /* (AA19) RGMII2_TX_CTL.RMII2_TX_EN */
>>>> -			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
>>>>  			AM62X_IOPAD(0x0190, PIN_INPUT, 7) /* (AE22) RGMII2_RD3.GPIO1_6 */
>>>>  			AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
>>>>  		>;
>>>> @@ -597,6 +598,9 @@ &cpsw3g_mdio {
>>>>  
>>>>  	cpsw3g_phy0: ethernet-phy@0 {
>>>>  		reg = <0>;
>>>> +		reset-gpios = <&main_gpio0 15 GPIO_ACTIVE_LOW>;
>>>> +		reset-assert-us = <10000>;
>>>> +		reset-deassert-us = <50000>;
>>>>  	};
>>>>  
>>>>  	cpsw3g_phy1: ethernet-phy@1 {
>>>> @@ -615,7 +619,7 @@ &main_gpio0 {
>>>>  		"USR0", "USR1", "USR2", "USR3", "", "", "USR4",	/* 3-9 */
>>>>  		"EEPROM_WP",					/* 10 */
>>>>  		"CSI2_CAMERA_GPIO1", "CSI2_CAMERA_GPIO2",	/* 11-12 */
>>>> -		"CC1352P7_BOOT", "CC1352P7_RSTN", "", "", "",	/* 13-17 */
>>>> +		"CC1352P7_BOOT", "CC1352P7_RSTN", "GBE_RSTN", "", "",	/* 13-17 */
>>>>  		"USR_BUTTON", "", "", "", "", "", "", "", "",	/* 18-26 */
>>>>  		"", "", "", "", "", "", "", "", "", "HDMI_INT",	/* 27-36 */
>>>>  		"", "VDD_WLAN_EN", "", "", "WL_IRQ", "GBE_INTN",/* 37-42 */
>>>>
>>>> ---
>>>> base-commit: bbef42084cc170cbfc035bf784f2ff055c939d7e
>>>> change-id: 20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-098f274fbf15
>>>>
>>>> Best regards,
>>>
>>
> 

-- 
cheers,
-roger

