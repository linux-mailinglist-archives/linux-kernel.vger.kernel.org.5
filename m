Return-Path: <linux-kernel+bounces-44584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955378424A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D9CB2D74B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B567E83;
	Tue, 30 Jan 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+8jDO25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553367A10;
	Tue, 30 Jan 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616610; cv=none; b=aoTl/vprViuC6qNkB1eW8U5el6VFwcVL9+PMap8uI4J5G46p04dqPvKBSjpXIk4VgnRr7ct032I5RDEtGO1fhtZXyzHaq49dxK8O7fTaR1XqE9cX2o8SFT7Ode4uPKGIOuRqL6Y+by15IRlqjaaBT/OjzS96wOrAkBqVd6bfkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616610; c=relaxed/simple;
	bh=Rf/2bGcKWqfTSjgtmsaV3E5nuVmMnoGUoJPbVEXxFeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4sxZEnSQuCdk1742zDOHRyPCcP9Vtdyq5HOWxA1VK1V2iRm/QEbtrdxfBJx5b3AssTQkkAVjOU8hLNuuTcfSsMonfmkLhvrbFsDYyx1Zuk4j9IkQIaTb3dsPpO66Bn8CTt/mFzFDg5kxOoOLL/OGpABkAsbeTsNvly2Mm7TEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+8jDO25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F052C433F1;
	Tue, 30 Jan 2024 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706616609;
	bh=Rf/2bGcKWqfTSjgtmsaV3E5nuVmMnoGUoJPbVEXxFeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X+8jDO25v2bvERaOl4vwaKHzBrnOmKobZ/+ZmePShNGyf0ideGDJnp64b1Qu2vs2p
	 EE1ilgNTQvaxik/9Axb9WMAzkb5Wa1zkTJFpxUJD9aKllfZ3yeqC6m0ETXND4vZaWJ
	 Eg/ujl9CzT7lcV3wDgpwH6RexeZ8+puCvRS/5oS1t/YdefW4Grse2txtNloTsaN4Kb
	 z5F5FoB/feoxCUAspsSZYdTSFM3R3YRISlY+CBkBMPBrGG4RTO+F7qTL3x5cvTBr0V
	 /i51XP/uxTWl1mt6PsZlyo82BNknt7lCnkC/asNT9h/TSruINLU1HwzmdSEUZqSiDv
	 fGBilTMvtcbCA==
Message-ID: <30f0154c-37c7-468c-911e-027c51c8d69b@kernel.org>
Date: Tue, 30 Jan 2024 14:10:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62p: add the USB sub-system
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, nm@ti.com,
 vigneshr@ti.com
Cc: afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126125951.18585-1-rogerq@kernel.org>
 <20240126125951.18585-3-rogerq@kernel.org>
 <0bc7081f-f279-4741-b14e-198b2d00d5d0@linaro.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0bc7081f-f279-4741-b14e-198b2d00d5d0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/01/2024 17:11, Krzysztof Kozlowski wrote:
> On 26/01/2024 13:59, Roger Quadros wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> There are two USB instances available on the am62p5 starter kit. Include
>> and enable them for use on the board.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 46 ++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   | 67 +++++++++++++++++++++++
>>  2 files changed, 113 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> index 4c51bae06b57..7e7cd749d9a5 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> @@ -560,6 +560,52 @@ sdhci2: mmc@fa20000 {
>>  		status = "disabled";
>>  	};
>>  
>> +	usbss0: dwc3-usb@f900000 {
> 
> usb@

OK.
> 
>> +		compatible = "ti,am62-usb";
>> +		reg = <0x00 0x0f900000 0x00 0x800>;
>> +		clocks = <&k3_clks 161 3>;
>> +		clock-names = "ref";
>> +		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
>> +		ranges;
>> +		status = "disabled";
>> +
>> +		usb0: usb@31000000 {
>> +			compatible = "snps,dwc3";
>> +			reg = <0x00 0x31000000 0x00 0x50000>;
>> +			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
>> +			<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
>> +			interrupt-names = "host", "peripheral";
>> +			maximum-speed = "high-speed";
>> +			dr_mode = "otg";
>> +		};
>> +	};
>> +
>> +	usbss1: dwc3-usb@f910000 {
> 
> usb@
> 
>> +		compatible = "ti,am62-usb";
>> +		reg = <0x00 0x0f910000 0x00 0x800>;
>> +		clocks = <&k3_clks 162 3>;
>> +		clock-names = "ref";
>> +		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
>> +		ranges;
>> +		status = "disabled";
>> +
>> +		usb1: usb@31100000 {
>> +			compatible = "snps,dwc3";
>> +			reg = <0x00 0x31100000 0x00 0x50000>;
>> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
>> +			<GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
>> +			interrupt-names = "host", "peripheral";
>> +			maximum-speed = "high-speed";
>> +			dr_mode = "otg";
>> +		};
>> +	};
>> +
>>  	fss: bus@fc00000 {
>>  		compatible = "simple-bus";
>>  		reg = <0x00 0x0fc00000 0x00 0x70000>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> index 1773c05f752c..7a16e7a8ac66 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -27,6 +27,8 @@ aliases {
>>  		spi0 = &ospi0;
>>  		ethernet0 = &cpsw_port1;
>>  		ethernet1 = &cpsw_port2;
>> +		usb0 = &usb0;
>> +		usb1 = &usb1;
>>  	};
>>  
>>  	chosen {
>> @@ -297,6 +299,12 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
>>  		bootph-all;
>>  	};
>>  
>> +	main_usb1_pins_default: main-usb1-default-pins {
>> +		pinctrl-single,pins = <
>> +			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
>> +		>;
>> +	};
>> +
>>  	main_wlirq_pins_default: main-wlirq-default-pins {
>>  		pinctrl-single,pins = <
>>  			AM62PX_IOPAD(0x0128, PIN_INPUT, 7) /* (K25) MMC2_SDWP.GPIO0_72 */
>> @@ -340,6 +348,36 @@ AM62PX_IOPAD(0x0124, PIN_INPUT, 7) /* (J25) MMC2_SDCD.GPIO0_71 */
>>  	};
>>  };
>>  
>> +&main_i2c0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +
>> +	typec_pd0: tps6598x@3f {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

got it. Thanks!

> 
>> +		compatible = "ti,tps6598x";
>> +		reg = <0x3f>;
>> +
>> +		connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			self-powered;
>> +			data-role = "dual";
>> +			power-role = "sink";
>> +			ports {
> 
> 
> Best regards,
> Krzysztof
> 

-- 
cheers,
-roger

