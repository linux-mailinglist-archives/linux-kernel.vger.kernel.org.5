Return-Path: <linux-kernel+bounces-55027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315584B68B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C0B1C24526
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A9130E44;
	Tue,  6 Feb 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbUXbPnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F8130AFA;
	Tue,  6 Feb 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226582; cv=none; b=qAySPMXxAxuQAEtUJtim/dUrumz0kh76NaIIyH3Kh/X9RQYvPnIqa3dejfVR/pEID5o8AKg/A50KZt/dLQvJ+UYl9S8XvdX0PC3k1nlZBZU9IYGxd4ZZdpV8sQX330EPfeBrrtaRZmLsrnXE4MeRKXK6c1VV4AEJGDJTKdu6bCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226582; c=relaxed/simple;
	bh=u2h5FSf3oBFHa+ypIHsBqsa2CYbhLvIW27ibx9+2oP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqavyIRHwSG2ZhQKq5WekD+iud/6RveHhP4KxQzHSqB3SZbyYb9LbZsCqCsOMC7e5Yol1UydbKYf1fNZZnR3x8wZblxuMvPUugqCjO2EUNIhnlo0ahTt5iY7UPP0WlvRY/gZImDd22YSf/MfXbNc7Orry9bqrI8HS3Y7Sh3Wihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbUXbPnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F09FC433C7;
	Tue,  6 Feb 2024 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226582;
	bh=u2h5FSf3oBFHa+ypIHsBqsa2CYbhLvIW27ibx9+2oP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pbUXbPnpPSfzDwgLy50QJ7TGYqrz0UToDVivjjMDrp108G/OwwYUz0lzfO474Yqwz
	 8X9P0NkpimEsUIsWQ/2d4x9Meg92fxfzOp/tSJo+DOZExjkM+5miBT0Rrjf83JKhQw
	 q2EcTjAj2ggNo1VieLlv4Bks6Xq+yYcUsYUqnGhZT3lxzzVMwKQMn4iUUtCB4hf/1n
	 YbCnaAUSvADhYencXgAjHwLtAypUskOqRmXpi9b6utDAeYuR+yjAp4Yr7ZyqaeKh6q
	 YkX8h+qJW1bTvWOm0XNi7fhyVZT7ProkZhKeruyuoT40QRJqo5fe0W1NVG9YjnVKyM
	 Pq7/Q+fzNcI+A==
Message-ID: <a576961e-b737-49a8-80a5-65c87fff845d@kernel.org>
Date: Tue, 6 Feb 2024 15:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: Add DT overlay for PCIe + USB3.0
 SERDES personality card
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com
Cc: afd@ti.com, a-bhatia1@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
References: <20240126114530.40913-1-rogerq@kernel.org>
 <20240126114530.40913-4-rogerq@kernel.org>
 <547d7069-3457-4ee3-ad1c-fedc9db5da62@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <547d7069-3457-4ee3-ad1c-fedc9db5da62@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/02/2024 16:46, Vignesh Raghavendra wrote:
> 
> 
> On 26/01/24 17:15, Roger Quadros wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
> 
> [...]
> 
>>  # Boards with J7200 SoC
>>  k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
>> new file mode 100644
>> index 000000000000..c63b7241c005
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/**
>> + * DT overlay for SERDES personality card: 1lane PCIe + USB3.0 DRD on AM654 EVM
>> + *
>> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/phy/phy-am654-serdes.h>
>> +
>> +#include "k3-pinctrl.h"
>> +
>> +&serdes1 {
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_rc {
>> +	num-lanes = <1>;
>> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
>> +	phy-names = "pcie-phy0";
>> +	reset-gpios = <&pca9555 5 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_ep {
>> +	num-lanes = <1>;
>> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
>> +	phy-names = "pcie-phy0";
>> +};
>> +
>> +&main_pmx0 {
>> +	usb0_pins_default: usb0_pins_default {
> 
> No underscores in node-name and also should end with -pins
> 
>> +		pinctrl-single,pins = <
>> +			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
>> +		>;
>> +	};
>> +};
>> +
>> +&serdes0 {
>> +	status = "okay";
>> +	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
>> +	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>> +	assigned-clock-parents = <&k3_clks 151 4>,      /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>> +	<&k3_clks 151 8>;      /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
>> +	phys = <&serdes0 PHY_TYPE_USB3 0>;
>> +	phy-names = "usb3-phy";
>> +};
>> +
>> +&usb0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb0_pins_default>;
>> +	dr_mode = "host";
>> +	maximum-speed = "super-speed";
>> +	snps,dis-u1-entry-quirk;
>> +	snps,dis-u2-entry-quirk;
>> +};
>> +
>> +&usb0_phy {
>> +	status = "okay";
>> +};
> 
> 
> BTW, this breaks build on 6.8-rc1
> 
> 
>   DTOVL   arch/arm64/boot/dts/ti/k3-am654-gp-evm.dtb
> 
> Failed to apply 'arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtbo': FDT_ERR_NOTFOUND
> 
> 

It builds fine for me. Did the 3rd patch apply cleanly for you?

-- 
cheers,
-roger

