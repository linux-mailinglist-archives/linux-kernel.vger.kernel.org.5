Return-Path: <linux-kernel+bounces-44582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646C84247E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F138D289B23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593E6A010;
	Tue, 30 Jan 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak4ydx1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28267E83;
	Tue, 30 Jan 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616490; cv=none; b=Ux52nuK2Tmwgh5XaJJ38oq/jYTEj++EwHUkkQY4xlhKxKLvmRgDTfH/cLOfYiP1Rt28LDiPhJlG9M/4K748ee9SYBKoM04Azn5Rb9GXUoDz2L0ZC7NL3rmc2UPzk3TEcwjyuEucfHTm9t5s7KwhuWuez71r5vmtHepedfjidrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616490; c=relaxed/simple;
	bh=BnJrPQVLkba0Biy+oBkZ/bQzFl/sT8qYCF/AwC7a9yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzOOWCtkb3rCR403u9ZkFJTShDkP/HSMlwHFsCFf7K+SBBcrK98r8Uf4XD/s2enodQ2zFVX7Na61jgisEhTVwdYWgjODSl0LoYqVqTW6GPlTDjy2Ac5u9g5u6hixl2WVwGZowAkammXcv7HHYpDllpuXVjMw4xHfX/+YXPVzImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak4ydx1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E735C433C7;
	Tue, 30 Jan 2024 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706616490;
	bh=BnJrPQVLkba0Biy+oBkZ/bQzFl/sT8qYCF/AwC7a9yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ak4ydx1feFLqRsn8ZyTvNuHX5IlmHGr6Lw2x4MOFHOP6mnDqfKdhqBQ/Er+Lp25kS
	 bsRLngzQ68i+aoR1A5zq65kwWp6wVrWuX1OpUxMLndr8hF4ap9AZscu1yRWjCZuzs7
	 ZIIx4hsLvPolYTTcslwpeF26za3ABevrOMRkRJiCNmbQmmWmNQ3iqklM+YkY+1Ld6G
	 WGSdIzY1Yk8em0w//5DzjZhOkj3qQzv/Qv3AQN5riGZuO0cgZVfBbygYpBtFAO9p/M
	 1iz6SyrtVpJsbvdNUNnEL3ZKCfn4iJNP24KQ9k3NUIcWL+o6FHjYbpKNxIaLuOz76k
	 tPLVFfg//+YqA==
Message-ID: <af43a3ef-318a-4b7a-8b33-4897fe5a90d9@kernel.org>
Date: Tue, 30 Jan 2024 14:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62/a/p: use sub-node for
 USB_PHY_CTRL registers
To: Andrew Davis <afd@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240126125951.18585-1-rogerq@kernel.org>
 <20240126125951.18585-2-rogerq@kernel.org>
 <16473ecf-c837-4424-a279-e5d921c2a588@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <16473ecf-c837-4424-a279-e5d921c2a588@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/01/2024 17:00, Andrew Davis wrote:
> On 1/26/24 6:59 AM, Roger Quadros wrote:
>> Exposing the entire CTRL_MMR space to syscon is not a good idea.
>> Add sub-nodes for USB0_PHY_CTRL and USB1_PHY_CTRL and use them
>> in the USB0/USB1 nodes.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 ++--
>>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 ++++++++++
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 ++--
>>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 ++++++++++
>>   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 ++++++++++
>>   5 files changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index 464b7565d085..9432ed344d52 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -625,7 +625,7 @@ usbss0: dwc3-usb@f900000 {
>>           reg = <0x00 0x0f900000 0x00 0x800>;
>>           clocks = <&k3_clks 161 3>;
>>           clock-names = "ref";
>> -        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
>> +        ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
>> @@ -648,7 +648,7 @@ usbss1: dwc3-usb@f910000 {
>>           reg = <0x00 0x0f910000 0x00 0x800>;
>>           clocks = <&k3_clks 162 3>;
>>           clock-names = "ref";
>> -        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
>> +        ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>> index fef76f52a52e..bd09662a3c29 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>> @@ -19,6 +19,16 @@ chipid: chipid@14 {
>>               compatible = "ti,am654-chipid";
>>               reg = <0x14 0x4>;
>>           };
>> +
>> +        usb0_phy_ctrl: syscon@4008 {
>> +            compatible = "syscon";
> 
> You'll want to add a binding for this to the simple syscon list.
> See this patch for an example[0]. Otherwise this gives a DT check
> warning.

Thanks for the hint. Will fix.

> 
> Also, adding the new nodes for AM62p should be moved to the
> next patch in this series. Fixing AM62 and AM62a should be
> a standalone patch.

Agreed.

> 
> Andrew
> 
> [0] commit cb523495ee2a ("dt-bindings: mfd: syscon: Add ti,am654-dss-oldi-io-ctrl compatible")
> 
>> +            reg = <0x4008 0x4>;
>> +        };
>> +
>> +        usb1_phy_ctrl: syscon@4018 {
>> +            compatible = "syscon";
>> +            reg = <0x4018 0x4>;
>> +        };
>>       };
>>         wkup_uart0: serial@2b300000 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index f0b8c9ab1459..8311c7c44cd3 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -566,7 +566,7 @@ usbss0: dwc3-usb@f900000 {
>>           reg = <0x00 0x0f900000 0x00 0x800>;
>>           clocks = <&k3_clks 161 3>;
>>           clock-names = "ref";
>> -        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
>> +        ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
>> @@ -589,7 +589,7 @@ usbss1: dwc3-usb@f910000 {
>>           reg = <0x00 0x0f910000 0x00 0x800>;
>>           clocks = <&k3_clks 162 3>;
>>           clock-names = "ref";
>> -        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
>> +        ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
>> index 4e8279fa01e1..26e9fd9da78f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
>> @@ -17,6 +17,16 @@ chipid: chipid@14 {
>>               compatible = "ti,am654-chipid";
>>               reg = <0x14 0x4>;
>>           };
>> +
>> +        usb0_phy_ctrl: syscon@4008 {
>> +            compatible = "syscon";
>> +            reg = <0x4008 0x4>;
>> +        };
>> +
>> +        usb1_phy_ctrl: syscon@4018 {
>> +            compatible = "syscon";
>> +            reg = <0x4018 0x4>;
>> +        };
>>       };
>>         wkup_uart0: serial@2b300000 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>> index 19f42b39394e..0893e63c399a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>> @@ -18,6 +18,16 @@ chipid: chipid@14 {
>>               reg = <0x14 0x4>;
>>               bootph-all;
>>           };
>> +
>> +        usb0_phy_ctrl: syscon@4008 {
>> +            compatible = "syscon";
>> +            reg = <0x4008 0x4>;
>> +        };
>> +
>> +        usb1_phy_ctrl: syscon@4018 {
>> +            compatible = "syscon";
>> +            reg = <0x4018 0x4>;
>> +        };
>>       };
>>         wkup_uart0: serial@2b300000 {

-- 
cheers,
-roger

