Return-Path: <linux-kernel+bounces-86312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E486C3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F9C1F22C62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806820312;
	Thu, 29 Feb 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="ZxtNsvT5"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371B5337A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195840; cv=none; b=pAr+1PVfbO8umO/ecM2htCqYKnaTq2ivkuOaSj4TCbf50uKaiuDM4UPvnMmvvQNyKlCbIOy72nAUOjq5iS+Vl0MV8wV6q/dsX5NJUoKPP++aQWHB6pMG8sEgk76M27ykKeA8+OHgY9EVf/8sfRUlJjua026kxEso+O4otsOGLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195840; c=relaxed/simple;
	bh=ZFn/kKszJGJ+hZv439HEvXPN0ZEFAeizsC4LEBDDlco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJn/bsjhkLSWZFUAnJ9OTe675VO3Rv2WG9Q72HbpAec4LZf7gATSFoHT1vXOqwiOFnj1zDUZFLpFjb2/o4YkdpyXIfwTsiCdaPtN837OM1JRIXfMSvI6Us0W4+CSUdm3rrndAuOJkAjdrlWnFjgh5sFX4wE7Nq+jcXdgatBN13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=ZxtNsvT5; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id fafAreZDCQr4SfbunrGwp2; Thu, 29 Feb 2024 08:37:17 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id fbujrBqq7VgR0fbukrDZ34; Thu, 29 Feb 2024 08:37:15 +0000
X-Authority-Analysis: v=2.4 cv=N50vFX9B c=1 sm=1 tr=0 ts=65e0423c
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8
 a=UXIAUNObAAAA:8 a=AaZsPGPmsafA2eLmkNAA:9 a=QEXdDO2ut3YA:10 a=bFq2RbqkfqsA:10
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AnNK+AIrGk4ngQV5dAeJdqR4QKuqPbrScoRu615KNKM=; b=ZxtNsvT5ZVcsX295+OZjSW1VfU
	SJD+TKqRbNTcqzXBmoIGQBH5GA4mtQJuORffJ8B0oLO/uCYYzycp5LyCwghtjdLQDExyoTXrTTRUJ
	wQxoO/Ao7CUaMRF2PoP3+zuGz5Lf1Pz2AEB61vYOnSl30/T1p5WS1SgVFSzmM06sNXwhfTKznoDxL
	GyDtFe9ev+vt7P2lYDjqO2KiXvmb7R7A/Sqrbhq6UQOcmnJzdmRGe2JdYTwWxyCJMPbG/EsYYAWYd
	SglWvHXxiXAdzVNBVwgWNfcIryzGoMKfRhYrdKb5irzh8Ns8YqaC9/0GEpNXpv8ZkL19GQTnFJkOc
	A1C6XdFg==;
Received: from [122.165.245.213] (port=45048 helo=[192.168.1.101])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1rfbug-001KT2-26;
	Thu, 29 Feb 2024 14:07:10 +0530
Message-ID: <4f8287ae-acfa-447b-b9d0-d26d84d24b2d@linumiz.com>
Date: Thu, 29 Feb 2024 14:07:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mm: add support for compulab iot gateway
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Parthiban <parthiban@linumiz.com>
References: <20230512055230.811421-1-parthiban@linumiz.com>
 <e24e877e-4065-35b4-bbd2-edbbc694edf6@linaro.org>
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <e24e877e-4065-35b4-bbd2-edbbc694edf6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rfbug-001KT2-26
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.101]) [122.165.245.213]:45048
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 26
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMkNRzp4wGcZcNJpSxVoTO3D97p17WaAdE/LEpx5gp5qRXs+Y8oTMRKQrwqlrDH9bYhcd5Qy0EdsLIYASCxIo5l3XPg5bm/AwsG3P4SJYbYIbwxq/awZ
 03dx2loRH4Fa+IMTIyx71HiRSTi3q0ZUOdq8bhNOSE/5fMGYbZUoBpJVb4PAyzdDWVFkqqsRTzCHfapxZtrOZ/7Rv2LrfGxXcaU=

Thanks for the review Krzysztof. I will send v2 after fixing the review comments.

Thanks,
Parthiban N

On 5/12/23 11:47, Krzysztof Kozlowski wrote:
> On 12/05/2023 07:52, Parthiban Nallathambi wrote:
>> Add support for compulab for imx8mm IoT gateway with
>> UCM-iMX8M-Mini SoM. IoT gateway comes with dual ethernet,
>> USB and IO expansion.
>>
>> WLAN, Bluetooth can be part of SoM or extended over PCIE.
>>
>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>> ---
>>  .../devicetree/bindings/arm/fsl.yaml          |   2 +
>>  .../bindings/net/microchip,lan95xx.yaml       |   1 +
>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>  .../freescale/imx8mm-compulab-iot-gate.dts    | 315 +++++++++++
>>  .../dts/freescale/imx8mm-compulab-ucm.dtsi    | 532 ++++++++++++++++++
>>  5 files changed, 851 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-compulab-iot-gate.dts
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-compulab-ucm.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 15d411084065..d2425c5ed4b7 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -895,6 +895,8 @@ properties:
>>        - description: i.MX8MM based Boards
>>          items:
>>            - enum:
>> +              - compulab,imx8mm-ucm-som   # UCM-iMX8M-Mini Compulab SoM
>> +              - compulab,iot-gate-imx8    # iMX8M IoT Compulab Gateway with UCM-iMX8M-Mini
> 
> Bindings are always separate patches.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Checkpatch
> tells you this, so you apparently did not run it.
> 
> 
>>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>>                - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
>>                - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
>> diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
>> index 0b97e14d947f..86279724695e 100644
>> --- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
>> +++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
>> @@ -22,6 +22,7 @@ properties:
>>        - enum:
>>            - usb424,9500   # SMSC9500 USB Ethernet Device
>>            - usb424,9505   # SMSC9505 USB Ethernet Device
>> +          - usb424,9514   # SMSC9514 USB Ethernet Device
> 
> No, really, I could understand squashing board bindings here but
> changing drivers in the same patch is clearly too much.
> 
>>            - usb424,9530   # SMSC LAN9530 USB Ethernet Device
>>            - usb424,9730   # SMSC LAN9730 USB Ethernet Device
>>            - usb424,9900   # SMSC9500 USB Ethernet Device (SAL10)
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index ef7d17aef58f..2a613c576d29 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
>>  
>>  dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-compulab-iot-gate.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-compulab-iot-gate.dts b/arch/arm64/boot/dts/freescale/imx8mm-compulab-iot-gate.dts
>> new file mode 100644
>> index 000000000000..678a9022549f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-compulab-iot-gate.dts
>> @@ -0,0 +1,315 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright 2018 Compulab
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx8mm-compulab-ucm.dtsi"
>> +
>> +/ {
>> +	model = "CompuLab IOT-GATE-iMX8 board";
>> +	compatible = "compulab,iot-gate-imx8", "compulab,imx8mm-ucm-som", "fsl,imx8mm";
>> +
>> +	regulator-usbhub-ena {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usbhub_ena";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio4 28 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	regulator-usbhub-rst {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usbhub_rst";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio3 24 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	regulator-uart1-mode {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "uart1_mode";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio4 26 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		regulator-always-on;
>> +	};
>> +
>> +	regulator-uart1-duplex {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "uart1_duplex";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	regulator-uart1-shdn {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "uart1_shdn";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	regulator-uart1-trmen {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "uart1_trmen";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio4 25 GPIO_ACTIVE_LOW>;
>> +		regulator-always-on;
>> +		enable-active-low;
>> +	};
>> +
>> +	regulator-usdhc2_v {
> 
> No underscores in node names. Fix it everywhere.
> 
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usdhc2_v";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	reg_usdhc2_rst: regulator-usdhc2_rst {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reg_usdhc2_rst>;
>> +		regulator-name = "usdhc2_rst";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>> +		startup-delay-us = <100>;
>> +		off-on-delay-us = <12000>;
>> +		enable-active-high;
>> +	};
>> +
>> +	regulator-mpcie2_rst {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "mpcie2_rst";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	regulator-mpcie2lora_dis {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "mpcie2lora_dis";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio3 21 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	pcie0_refclk: pcie0-refclk {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <100000000>;
>> +	};
>> +};
>> +
>> +&ethphy0 {
>> +	status = "okay";
>> +};
>> +
>> +&fec1 {
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_gpio>;
>> +	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
>> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
>> +	linux,rs485-enabled-at-boot-time;
>> +	rts-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	status = "disabled";
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "okay";
>> +
>> +	eeprom@54 {
>> +		compatible = "atmel,24c08";
>> +		reg = <0x54>;
>> +		pagesize = <16>;
>> +	};
>> +};
>> +
>> +&ecspi1 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	fsl,spi-num-chipselects = <1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
>> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +	dr_mode = "host";
>> +	disable-over-current;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg2 {
>> +	dr_mode = "host";
>> +	disable-over-current;
>> +	status = "okay";
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	usb9514@1 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
>> +		compatible = "usb424,9514";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usb9514>;
>> +		reg = <1>;
> 
> reg is always after compatible.
> 
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethernet: usbether@1 {
>> +			compatible = "usb424,ec00";
>> +			reg = <1>;
>> +		};
>> +	};
>> +};
>> +
>> +&usdhc1 {
>> +	status = "disabled";
>> +};
>> +
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	bus-width = <4>;
>> +	mmc-ddr-1_8v;
>> +	non-removable;
>> +	vmmc-supply = <&reg_usdhc2_rst>;
>> +	status = "okay";
>> +};
>> +
>> +&pcie0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pcie0>;
>> +	reset-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
>> +	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>,
>> +		 <&clk IMX8MM_CLK_PCIE1_AUX>,
>> +		 <&clk IMX8MM_CLK_PCIE1_PHY>,
>> +		 <&pcie0_refclk>;
>> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
>> +	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
>> +			  <&clk IMX8MM_CLK_PCIE1_PHY>,
>> +			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
>> +	assigned-clock-rates = <10000000>, <100000000>, <250000000>;
>> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
>> +				 <&clk IMX8MM_SYS_PLL2_100M>,
>> +				 <&clk IMX8MM_SYS_PLL2_250M>;
>> +	ext_osc = <1>;
>> +	status = "disabled";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_hog_sb_iotgimx8>;
>> +
>> +	sb-iotgimx8 {
>> +		pinctrl_hog_sb_iotgimx8: hoggrp_sb-iotgimx8 {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 
>> +			fsl,pins = <
>> +				/* mPCIe2 */
>> +				MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21	0x140 /* LORA_DISABLE */
>> +				MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x140 /* PERSTn */
>> +			>;
>> +		};
>> +
>> +		pinctrl_uart1: uart1grp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX	0x140
>> +				MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX	0x140
>> +				MX8MM_IOMUXC_SAI2_TXFS_GPIO4_IO24	0x140 /* RTS */
>> +				MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B	0x140 /* CTS */
>> +			>;
>> +		};
>> +
>> +		pinctrl_uart1_gpio: uart1gpiogrp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26	0x000 /* RS_485_232_SEL */
>> +				MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x140 /* RS_485_H/F_SEL */
>> +				MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x140 /* SHDN */
>> +				MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25	0x140 /* RS_485_TRMEN */
>> +			>;
>> +		};
>> +
>> +		pinctrl_i2c1: i2c1grp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
>> +				MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
>> +			>;
>> +		};
>> +
>> +		pinctrl_ecspi1: ecspi1grp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x82
>> +				MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x82
>> +				MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x82
>> +			>;
>> +		};
>> +
>> +		pinctrl_ecspi1_cs: ecspi1cs {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 
> I guess you did not test it at all.
> 
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x40000
>> +			>;
>> +		};
>> +
>> +		pinctrl_usb9514: usb9514grp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x140 /* USB_PS_EN */
>> +				MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24	0x140 /* HUB_RSTn */
>> +			>;
>> +		};
>> +
>> +		pinctrl_usdhc2: usdhc2grp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
>> +				MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
>> +				MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
>> +				MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
>> +				MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
>> +				MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
>> +				MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4	0x1d0 /* SD2_VSEL */
>> +			>;
>> +		};
>> +
>> +		pinctrl_reg_usdhc2_rst: usdhc2rst {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41  /* EMMC_RST */
>> +			>;
>> +		};
>> +
>> +		pinctrl_pcie0: pcie0grp {
>> +			fsl,pins = <
>> +				MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20	0x140
>> +			>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-compulab-ucm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-compulab-ucm.dtsi
>> new file mode 100644
>> index 000000000000..d6cdf833744e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-compulab-ucm.dtsi
>> @@ -0,0 +1,532 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright 2018 Compulab
>> + */
>> +
>> +#include "imx8mm.dtsi"
>> +
>> +/ {
>> +	model = "Compulab i.MX8M-Mini UCM SoM";
>> +	compatible = "compulab,imx8mm-ucm-som", "fsl,imx8mm";
>> +
>> +	aliases {
>> +		rtc0 = &rtc0;
>> +		rtc1 = &snvs_rtc;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpio_led>;
>> +
>> +		heartbeat-led {
>> +			label = "Heartbeat";
>> +			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +	};
>> +
>> +	pmic_osc: clock-pmic {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <32768>;
>> +		clock-output-names = "pmic_osc";
>> +	};
>> +
>> +	reg_ethphy: regulator-ethphy {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reg_eth>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-name = "On-module +V3.3_ETH";
>> +		startup-delay-us = <500>;
>> +	};
>> +
>> +	reg_usdhc3_vmmc: regulator-usdhc3-vmmc {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reg_usdhc3>;
>> +		regulator-always-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-name = "On-module +V3.3_USDHC";
>> +	};
>> +
>> +	usdhc1_pwrseq: usdhc1_pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
>> +
>> +&fec1 {
>> +	fsl,magic-packet;
>> +	fsl,rgmii_rxc_dly;
>> +	phy-handle = <&ethphy0>;
>> +	phy-mode = "rgmii-id";
>> +	phy-supply = <&reg_ethphy>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_fec1>;
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy0: ethernet-phy@0 {
>> +			compatible = "ethernet-phy-ieee802.3-c22";
>> +			micrel,led-mode = <0>;
>> +			reg = <0>;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	status = "okay";
>> +
>> +	rtc0: rtc@69 {
>> +		compatible = "abracon,ab1805";
>> +		reg = <0x69>;
>> +	};
>> +
>> +	pmic: bd71837@4b {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> 
> Best regards,
> Krzysztof
> 

