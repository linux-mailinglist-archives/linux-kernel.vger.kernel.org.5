Return-Path: <linux-kernel+bounces-56494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3BA84CAD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71ECD287158
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108F76053;
	Wed,  7 Feb 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNePkl8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6915A0FE;
	Wed,  7 Feb 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309741; cv=none; b=twU3X0NIVz89Liw2q4oWyT5X97opfs84PDmMSznD8H17axQmODsUoLclDO2EfxGzuAMVzWWfUz0EwjbKuF+QYHULrLVfXsmeMIdRHAGXNk3I2KbSJYQnECZaRxxGasbE4MWKSzaWDdy03T6uDjWmxky2iQux2szAOGKF3mjGb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309741; c=relaxed/simple;
	bh=NC/M4lBc3klYSGIi2NaiARJesFYei1g1w2rS9yFOXuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN5k004L5lE0ske5knrOm5p72zInC3SDI94yg/1pvI6ZoWakQqhOWdW2IQPKnHNEAf9LTj2S8322unhfs3o2ffs1/voOrlXoRxWmdSijW4BENyyV1/tuB3t5Mbqr4vJ2TBcD3ng4OUX+34im/UZysyGeB3/qJXrmUQURDG9PVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNePkl8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC6AC433C7;
	Wed,  7 Feb 2024 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707309740;
	bh=NC/M4lBc3klYSGIi2NaiARJesFYei1g1w2rS9yFOXuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bNePkl8UG2rG5iD3165+0CEWxyn1b5Ixd1hZvgdAotnzJWqnwPvts0rabBRjFi//B
	 KBA8ULajSIp1mKJayMH48Hs2O27/8g2S2wOtlj9IEjwk7rFVzL37r4Iml6jcqHmKAG
	 NGZTH2QUasjHMV0pdUu/vLBUiEywBcuAvOh+8GmycrfnoVwtzXllwnexdN7JOcPQgf
	 zO8MmNdf8s9TKCREJmNrqokQwd8B+7b4qUFgatkqeQYw/5IseVm3eedCvaTUBmfwRD
	 mvNay/xdB/H7sfdRFB2Zwol6WshPO9fqWvuOxDRUa9ujd93KDhGXbY2wGjKAvtSncM
	 QAiKFxIGyCCww==
Message-ID: <db95dba7-c749-48d3-bbba-01a45dfb9815@kernel.org>
Date: Wed, 7 Feb 2024 14:42:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am62p: add the USB sub-system
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, srk@ti.com, r-gunasekaran@ti.com, b-liu@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240205135908.54656-1-rogerq@kernel.org>
 <20240205135908.54656-4-rogerq@kernel.org>
 <45a0ed98-8dd2-4c5b-8e89-40c70e3fe831@ti.com>
 <77f7b127-e609-45e3-90aa-67aa7838ce6b@kernel.org>
 <8f9e8ec5-fc78-4b51-b36f-3ba06768ce62@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <8f9e8ec5-fc78-4b51-b36f-3ba06768ce62@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/02/2024 19:34, Andrew Davis wrote:
> On 2/6/24 6:30 AM, Roger Quadros wrote:
>>
>>
>> On 05/02/2024 19:34, Andrew Davis wrote:
>>> On 2/5/24 7:59 AM, Roger Quadros wrote:
>>>> There are two USB instances available on the am62p5 starter kit. Include
>>>> and enable them for use on the board.
>>>>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>
>>>> Notes:
>>>>       Changelog:
>>>>            v4 - no change
>>>>            v3 - no change
>>>>       https://lore.kernel.org/all/20240201120332.4811-4-rogerq@kernel.org/
>>>>            v2:
>>>>       - added USB PHY CTRL node changes here
>>>>       - changed USB wrapper node names to usb@
>>>>       - changed Type-C chip node name to usb-power-control@
>>>>
>>>>    arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 46 ++++++++++++++
>>>>    arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 +++
>>>>    arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 67 +++++++++++++++++++++
>>>>    3 files changed, 123 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>>> index 4c51bae06b57..17d28390d587 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>>> @@ -560,6 +560,52 @@ sdhci2: mmc@fa20000 {
>>>>            status = "disabled";
>>>>        };
>>>>    +    usbss0: usb@f900000 {
>>>> +        compatible = "ti,am62-usb";
>>>> +        reg = <0x00 0x0f900000 0x00 0x800>;
>>>> +        clocks = <&k3_clks 161 3>;
>>>> +        clock-names = "ref";
>>>> +        ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
>>>> +        ranges;
>>>> +        status = "disabled";
>>>> +
>>>> +        usb0: usb@31000000 {
>>>> +            compatible = "snps,dwc3";
>>>> +            reg = <0x00 0x31000000 0x00 0x50000>;
>>>> +            interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
>>>> +            <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
>>>> +            interrupt-names = "host", "peripheral";
>>>> +            maximum-speed = "high-speed";
>>>> +            dr_mode = "otg";
>>>> +        };
>>>> +    };
>>>> +
>>>> +    usbss1: usb@f910000 {
>>>> +        compatible = "ti,am62-usb";
>>>> +        reg = <0x00 0x0f910000 0x00 0x800>;
>>>> +        clocks = <&k3_clks 162 3>;
>>>> +        clock-names = "ref";
>>>> +        ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
>>>> +        ranges;
>>>> +        status = "disabled";
>>>> +
>>>> +        usb1: usb@31100000 {
>>>> +            compatible = "snps,dwc3";
>>>> +            reg = <0x00 0x31100000 0x00 0x50000>;
>>>> +            interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
>>>> +            <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
>>>> +            interrupt-names = "host", "peripheral";
>>>> +            maximum-speed = "high-speed";
>>>> +            dr_mode = "otg";
>>>> +        };
>>>> +    };
>>>> +
>>>>        fss: bus@fc00000 {
>>>>            compatible = "simple-bus";
>>>>            reg = <0x00 0x0fc00000 0x00 0x70000>;
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>>> index 19f42b39394e..00dd38b02a52 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>>> @@ -18,6 +18,16 @@ chipid: chipid@14 {
>>>>                reg = <0x14 0x4>;
>>>>                bootph-all;
>>>>            };
>>>> +
>>>> +        usb0_phy_ctrl: syscon@4008 {
>>>> +            compatible = "ti,am62-usb-phy-ctrl", "syscon";
>>>> +            reg = <0x4008 0x4>;
>>>> +        };
>>>> +
>>>> +        usb1_phy_ctrl: syscon@4018 {
>>>> +            compatible = "ti,am62-usb-phy-ctrl", "syscon";
>>>> +            reg = <0x4018 0x4>;
>>>> +        };
>>>>        };
>>>>          wkup_uart0: serial@2b300000 {
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> index 1773c05f752c..80be56c0a4e0 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> @@ -27,6 +27,8 @@ aliases {
>>>>            spi0 = &ospi0;
>>>>            ethernet0 = &cpsw_port1;
>>>>            ethernet1 = &cpsw_port2;
>>>> +        usb0 = &usb0;
>>>> +        usb1 = &usb1;
>>>>        };
>>>>          chosen {
>>>> @@ -297,6 +299,12 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
>>>>            bootph-all;
>>>>        };
>>>>    +    main_usb1_pins_default: main-usb1-default-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
>>>> +        >;
>>>> +    };
>>>> +
>>>>        main_wlirq_pins_default: main-wlirq-default-pins {
>>>>            pinctrl-single,pins = <
>>>>                AM62PX_IOPAD(0x0128, PIN_INPUT, 7) /* (K25) MMC2_SDWP.GPIO0_72 */
>>>> @@ -340,6 +348,36 @@ AM62PX_IOPAD(0x0124, PIN_INPUT, 7) /* (J25) MMC2_SDCD.GPIO0_71 */
>>>>        };
>>>>    };
>>>>    +&main_i2c0 {
>>>> +    status = "okay";
>>>> +    pinctrl-names = "default";
>>>> +    pinctrl-0 = <&main_i2c0_pins_default>;
>>>> +    clock-frequency = <400000>;
>>>> +
>>>> +    typec_pd0: usb-power-controller@3f {
>>>> +        compatible = "ti,tps6598x";
>>>> +        reg = <0x3f>;
>>>> +
>>>> +        connector {
>>>> +            compatible = "usb-c-connector";
>>>> +            label = "USB-C";
>>>> +            self-powered;
>>>> +            data-role = "dual";
>>>> +            power-role = "sink";
>>>> +            ports {
>>>> +                #address-cells = <1>;
>>>> +                #size-cells = <0>;
>>>> +                port@0 {
>>>> +                    reg = <0>;
>>>> +                    usb_con_hs: endpoint {
>>>> +                        remote-endpoint = <&usb0_hs_ep>;
>>>> +                    };
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>>    &main_i2c1 {
>>>>        status = "okay";
>>>>        pinctrl-names = "default";
>>>> @@ -460,6 +498,35 @@ cpsw3g_phy1: ethernet-phy@1 {
>>>>        };
>>>>    };
>>>>    +&usbss0 {
>>>> +    status = "okay";
>>>> +    ti,vbus-divider;
>>>> +};
>>>> +
>>>> +&usbss1 {
>>>> +    status = "okay";
>>>> +    ti,vbus-divider;
>>>> +};
>>>> +
>>>> +&usb0 {
>>>> +    usb-role-switch;
>>>> +    #address-cells = <1>;
>>>> +    #size-cells = <0>;
>>>> +
>>>> +    port@0 {
>>>> +        reg = <0>;
>>>> +        usb0_hs_ep: endpoint {
>>>> +            remote-endpoint = <&usb_con_hs>;
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>> +&usb1 {
>>>> +    dr_mode = "host";
>>>> +    pinctrl-names = "default";
>>>> +    pinctrl-0 = <&main_usb1_pins_default>;
>>>
>>> I'm not super familiar with USB, but I see this pinmux for the
>>> "DRVVBUS" pin is usually added the the parent USB subsystem node (usbss).
>>> Does this pin belong to the subsystem or the specific USB instance?
>>>
>> There is only 1 USB instance per USB sub-system.
>> The "DRVVBUS" pin is a control signal to enable the VBUS regulator
>> while in host mode.
>>
>> Just probing the usbss1 driver has no use of "DRVVBUS".
>> I think usb1 is the right place as it is used there.
>>
> 
> Seems reasonable, so if there ever was more than 1 instance
> per sub-system, each instance would need its own pin?

Yes.

> 
> We should move these pinctrl to the instance node in the other
> dts files at some point then.
> 
> Reviewed-by: Andrew Davis <afd@ti.com>

Thanks!

> 
>>> Andrew
>>>
>>>> +};
>>>> +
>>>>    &mcasp1 {
>>>>        status = "okay";
>>>>        #sound-dai-cells = <0>;
>>

-- 
cheers,
-roger

