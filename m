Return-Path: <linux-kernel+bounces-7995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FF81B04B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6DB214BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCDA168B4;
	Thu, 21 Dec 2023 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HCi0BcX+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m127221.xmail.ntesmail.com (mail-m127221.xmail.ntesmail.com [115.236.127.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9A16413;
	Thu, 21 Dec 2023 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=HCi0BcX+AC7B4AgoDl/J5TK0Skglexk44ccX7VksVs/iWo5fj+HWu23ot6bNCxkUhKh2kUp6/Xcyo7UbiIjgAp/vMu6vyhUp7tYonRtGsdktuUIUG0muA25DSNii4tPMWf9TGHap8P/XGdt9c0lfkSyaRwmbu5IvCDXLNABJmnE=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=CCZtHSraIcQI4h16aoe3thSXX0dYZCleQkv8NS73xEQ=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 6921C7801AE;
	Thu, 21 Dec 2023 16:28:29 +0800 (CST)
Message-ID: <de5080a3-c4a7-492f-92c1-cbcfc80d471d@rock-chips.com>
Date: Thu, 21 Dec 2023 16:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: restyle emac nodes"
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>, Andy Yan <andyshrk@163.com>,
 heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 david.wu@rock-chips.com, romain.perier@gmail.com
References: <20231220103334.2665543-1-andyshrk@163.com>
 <406ba492-8f6b-26aa-55cf-2efa8d52ebaf@gmail.com>
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <406ba492-8f6b-26aa-55cf-2efa8d52ebaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkYSlZOS0waQxoeQx5IH0NVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8c8b7d8a95b24fkuuu6921c7801ae
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6Aww6Tzw9IxooGDIXNzJR
	NUoKCxRVSlVKTEtISk9MSEpLSEtIVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSkpLSUs3Bg++

Hi Johan,

On 12/20/23 19:58, Johan Jonker wrote:
> 
> 
> On 12/20/23 11:33, Andy Yan wrote:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> When try to run rk3036 kylin board with mainline,
>> I found the emac ethernet probe failed:
>>
>> [    2.324583] loop: module loaded
>> [    2.328435] SPI driver spidev has no spi_device_id for rockchip,spidev
>> [    2.338688] tun: Universal TUN/TAP device driver, 1.6
>> [    2.345397] rockchip_emac 10200000.ethernet: no regulator found
>> [    2.351892] rockchip_emac 10200000.ethernet: ARC EMAC detected with id: 0x7fd02
>> [    2.359331] rockchip_emac 10200000.ethernet: IRQ is 43
>> [    2.364719] rockchip_emac 10200000.ethernet: MAC address is now e6:58:d6:ec:d9:7c
>> [    2.396993] mdio_bus Synopsys MII Bus: mdio has invalid PHY address
>> [    2.403306] mdio_bus Synopsys MII Bus: scan phy mdio at address 0
>> [    2.508656] rockchip_emac 10200000.ethernet: of_phy_connect() failed
>> [    2.516334] rockchip_emac 10200000.ethernet: failed to probe arc emac (-19)
>>
>> This reverts commit 1dabb74971b3 ("ARM: dts: rockchip: restyle emac nodes")
>> make emac on rk3036 kylin board probe right again:
>> [    1.920385] CAN device driver interface
>> [    1.925499] rockchip_emac 10200000.ethernet: no regulator found
>> [    1.932535] rockchip_emac 10200000.ethernet: ARC EMAC detected with id: 0x7fd02
>> [    1.940735] rockchip_emac 10200000.ethernet: IRQ is 42
>> [    1.946743] rockchip_emac 10200000.ethernet: MAC address is now 96:7d:4f:0a:69:b3
>> [    2.581340] rockchip_emac 10200000.ethernet: connected to Generic PHY phy with id 0xffffc816
>> [    2.592560] e1000e: Intel(R) PRO/1000 Network Driver
>> [    2.598136] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>>
>> Fixes: 1dabb74971b3 ("ARM: dts: rockchip: restyle emac nodes")
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>   arch/arm/boot/dts/rockchip/rk3036-evb.dts     | 16 ++++++----------
>>   arch/arm/boot/dts/rockchip/rk3036-kylin.dts   | 16 ++++++----------
>>   arch/arm/boot/dts/rockchip/rk3036.dtsi        |  2 ++
>>   .../boot/dts/rockchip/rk3066a-marsboard.dts   | 17 +++++++----------
>>   .../boot/dts/rockchip/rk3066a-rayeager.dts    | 15 +++++----------
>>   .../boot/dts/rockchip/rk3188-radxarock.dts    | 19 ++++++++-----------
>>   arch/arm/boot/dts/rockchip/rk3xxx.dtsi        |  2 ++
>>   7 files changed, 36 insertions(+), 51 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rockchip/rk3036-evb.dts b/arch/arm/boot/dts/rockchip/rk3036-evb.dts
>> index becdc0b664bf..94216f870b57 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3036-evb.dts
>> +++ b/arch/arm/boot/dts/rockchip/rk3036-evb.dts
>> @@ -15,20 +15,16 @@ memory@60000000 {
>>   };
>>   
>>   &emac {
>> -	phy = <&phy0>;
>> -	phy-reset-duration = <10>; /* millisecond */
>> -	phy-reset-gpios = <&gpio2 RK_PC6 GPIO_ACTIVE_LOW>; /* PHY_RST */
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&emac_xfer>, <&emac_mdio>;
>> -	status = "okay";
>> +	phy = <&phy0>;
>> +	phy-reset-gpios = <&gpio2 RK_PC6 GPIO_ACTIVE_LOW>; /* PHY_RST */
>> +	phy-reset-duration = <10>; /* millisecond */
> 
> 
>>   
>> -	mdio {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> +	status = "okay";
>>   
>> -		phy0: ethernet-phy@0 {
>> -			reg = <0>;
>> -		};
>> +	phy0: ethernet-phy@0 {
>> +		reg = <0>;
>>   	};
> 
> Sorry, didn't have the hardware when changing that binding.
> A little bit background info:
> 
> The rk3036 TRM states:
> Management Interface (MDIO) state machine for easy real-time communication with the
> PHY
> 
> A revert of the DT must also match a binding. But...
> Bindings must describe the hardware as close as possible.
> So when the phy is called over the mdio we must add phy as part of a mdio node.(Is that correct? Ask a expert!)
> Somehow the old emac driver doesn't support this sub node setup.
> First request would be have a look to make the driver work as it should.

Because I lack of knowledge about net driver, I am not sure if the mdio is mandatory.
I post this revert also want to have some suggestion from the net expert.
 From some grep:
emac_rockchip is based on arc-emac, but the example of arc_emac does not have a mdio node[0]
thera are also other platforms use the same way[1]

[0] Documentation/devicetree/bindings/net/arc_emac.txt
[1]arch/arm/boot/dts/hisilicon/hisi-x5hd2-dkb.dts


> 
> Johan
> 
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
>> index 67e1e04139e7..e817eba8c622 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
>> +++ b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
>> @@ -80,20 +80,16 @@ &acodec {
>>   };
>>   
>>   &emac {
>> -	phy = <&phy0>;
>> -	phy-reset-duration = <10>; /* millisecond */
>> -	phy-reset-gpios = <&gpio2 RK_PC6 GPIO_ACTIVE_LOW>; /* PHY_RST */
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&emac_xfer>, <&emac_mdio>;
>> -	status = "okay";
>> +	phy = <&phy0>;
>> +	phy-reset-gpios = <&gpio2 RK_PC6 GPIO_ACTIVE_LOW>; /* PHY_RST */
>> +	phy-reset-duration = <10>; /* millisecond */
>>   
>> -	mdio {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> +	status = "okay";
>>   
>> -		phy0: ethernet-phy@0 {
>> -			reg = <0>;
>> -		};
>> +	phy0: ethernet-phy@0 {
>> +		reg = <0>;
>>   	};
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> index 78686fc72ce6..e240b89b0b35 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> @@ -228,6 +228,8 @@ emac: ethernet@10200000 {
>>   		compatible = "rockchip,rk3036-emac";
>>   		reg = <0x10200000 0x4000>;
>>   		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>>   		rockchip,grf = <&grf>;
>>   		clocks = <&cru HCLK_MAC>, <&cru SCLK_MACREF>, <&cru SCLK_MAC>;
>>   		clock-names = "hclk", "macref", "macclk";
>> diff --git a/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts b/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
>> index f6e8d49a02ef..e3d6f0e81330 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
>> +++ b/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
>> @@ -150,21 +150,18 @@ vcc28_cif: regulator@12 {
>>   #include "../tps65910.dtsi"
>>   
>>   &emac {
>> +	status = "okay";
>> +
>>   	phy = <&phy0>;
>>   	phy-supply = <&vcc_rmii>;
>> +
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&phy_int>;
>> -	status = "okay";
>> -
>> -	mdio {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>>   
>> -		phy0: ethernet-phy@0 {
>> -			reg = <0>;
>> -			interrupt-parent = <&gpio1>;
>> -			interrupts = <RK_PD2 IRQ_TYPE_LEVEL_LOW>;
>> -		};
>> +	phy0: ethernet-phy@0 {
>> +		reg = <0>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <RK_PD2 IRQ_TYPE_LEVEL_LOW>;
>>   	};
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts b/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
>> index 29d8e5bf88f5..096616324c2d 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
>> +++ b/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
>> @@ -142,20 +142,15 @@ &cpu1 {
>>   };
>>   
>>   &emac {
>> -	phy = <&phy0>;
>> -	phy-supply = <&vcc_rmii>;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&rmii_rst>;
>> +	phy = <&phy0>;
>> +	phy-supply = <&vcc_rmii>;
>>   	status = "okay";
>>   
>> -	mdio {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -
>> -		phy0: ethernet-phy@0 {
>> -			reg = <0>;
>> -			reset-gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
>> -		};
>> +	phy0: ethernet-phy@0 {
>> +		reg = <0>;
>> +		reset-gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
>>   	};
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts b/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
>> index 118deacd38c4..239d2ec37fdc 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
>> +++ b/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
>> @@ -126,21 +126,18 @@ vsys: vsys-regulator {
>>   };
>>   
>>   &emac {
>> -	phy = <&phy0>;
>> -	phy-supply = <&vcc_rmii>;
>> +	status = "okay";
>> +
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&phy_int>;
>> -	status = "okay";
>>   
>> -	mdio {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> +	phy = <&phy0>;
>> +	phy-supply = <&vcc_rmii>;
>>   
>> -		phy0: ethernet-phy@0 {
>> -			reg = <0>;
>> -			interrupt-parent = <&gpio3>;
>> -			interrupts = <RK_PD2 IRQ_TYPE_LEVEL_LOW>;
>> -		};
>> +	phy0: ethernet-phy@0 {
>> +		reg = <0>;
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <RK_PD2 IRQ_TYPE_LEVEL_LOW>;
>>   	};
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
>> index cb4e42ede56a..17e89d30de78 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
>> @@ -193,6 +193,8 @@ emac: ethernet@10204000 {
>>   		compatible = "snps,arc-emac";
>>   		reg = <0x10204000 0x3c>;
>>   		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>>   
>>   		rockchip,grf = <&grf>;
>>   

