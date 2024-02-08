Return-Path: <linux-kernel+bounces-58033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2B84E07A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AD8285290
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92F71B50;
	Thu,  8 Feb 2024 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDPuHIxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83F71B41;
	Thu,  8 Feb 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394451; cv=none; b=LIqNxOt1HHv9ROjTTl/7DfHgj8Vh9WIRvFDJhsHJA6pRQlPVC5tA1dptu4GvQoUtcINFzbwz2K9v6Oj/pFdTkYD65PIpy0ahiXvvK18QwKaiRNPze6ClfMChUe7Mw0rxXKOCA0WXN+NTkbiPa7pdv1UTK1P0lvpEo9SbLBV40Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394451; c=relaxed/simple;
	bh=zjtkOe2cugeGmcRyM/zpknBqUAd2EbvZfuhd4DjjtQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6AZ6IkUeD9cZfTnQUXxnsUBpHGPulPtU+sYtV88J9qVdpP7IaalT8P7eTcdoSpLE36y7GTM2K8SF6R9NGVoj/MOuw7Y+EkHcwH1lEy5MQa1zZGxBinMmozYTbw9/X90GB85ty3HvaK5jHAWK1iZSvrZ1lzTB0lux36HwBJhAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDPuHIxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB59DC433F1;
	Thu,  8 Feb 2024 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394450;
	bh=zjtkOe2cugeGmcRyM/zpknBqUAd2EbvZfuhd4DjjtQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VDPuHIxIrAosGiYGdETmKtYzVVUsiVsurTz2ZxPNcfvl1C40lcmKrHUIYjjsroCmT
	 iA3MpZIeZM3I/SwzUF+j29MavcKdwr/rs7/UXmvFmvwqqTBK+J4YwGjzIm2MGIRLoh
	 eFB5G0ZFsr7J6yoCURXVx2vsDv3JjxOrSzC3/Lh/PG3qTOqu/whCAECzAri7/TNmlm
	 SjGedj61i0znkqaSnxH0Q8qTixkg16vpk7tCOUCCd9a83uFpmimP+XsWN4Yemo3X3B
	 I0IJhcbIHGiIH1Okj/VWzymCKNURuivkBgl5vTmjbeoh2mHrZi0ikUbzq6lj3siB2x
	 rMoTfxTQU8wsQ==
Message-ID: <93f6ed54-2173-453e-8b57-373a303d725b@kernel.org>
Date: Thu, 8 Feb 2024 14:14:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, srk@ti.com, r-gunasekaran@ti.com
References: <20240205090546.4000446-1-danishanwar@ti.com>
 <20240205090546.4000446-3-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240205090546.4000446-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/02/2024 11:05, MD Danish Anwar wrote:
> ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.
> 
> The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
> MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
> CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
> bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
> port is kept disable and ICSSG1 is enabled in single MAC mode by
> default.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 97 +++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 8c5651d2cf5d..6b97e447c486 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -32,6 +32,7 @@ aliases {
>  		mmc1 = &sdhci1;
>  		ethernet0 = &cpsw_port1;
>  		ethernet1 = &cpsw_port2;
> +		ethernet2 = &icssg1_emac0;
>  	};
>  
>  	memory@80000000 {
> @@ -229,6 +230,66 @@ transceiver2: can-phy1 {
>  		max-bitrate = <5000000>;
>  		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	icssg1_eth: icssg1-eth {
> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
> +		sram = <&oc_sram>;
> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
> +		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
> +
> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
> +		ti,mii-rt = <&icssg1_mii_rt>;
> +		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
> +		interrupt-parent = <&icssg1_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;
> +		interrupt-names = "tx_ts0", "tx_ts1";
> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			icssg1_emac0: port@0 {
> +				reg = <0>;
> +				phy-handle = <&icssg1_phy1>;
> +				phy-mode = "rgmii-id";
> +				ti,syscon-rgmii-delay = <&main_conf 0x4110>;

"syscon" compatible will be eventually dropped from the main_conf node.
It is not there on other platforms e.g. am62p

One solution is to add a device tree node in main_conf and reference to
that.
e.g.
https://lore.kernel.org/all/20240205135908.54656-3-rogerq@kernel.org/

> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +			icssg1_emac1: port@1 {
> +				reg = <1>;
> +				ti,syscon-rgmii-delay = <&main_conf 0x4114>;

here too

> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +				status = "disabled";
> +			};
> +		};
> +	};
>  };
>  
>  &main_pmx0 {
> @@ -383,6 +444,30 @@ ddr_vtt_pins_default: ddr-vtt-default-pins {
>  			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
>  		>;
>  	};
> +
> +	icssg1_mdio1_pins_default: icssg1-mdio1-default-pins {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* (Y6) PRG1_MDIO0_MDC */
> +			AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* (AA6) PRG1_MDIO0_MDIO */
> +		>;
> +	};
> +
> +	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins{
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
> +			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
> +			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
> +			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
> +			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
> +			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
> +			AM64X_IOPAD(0x00e4, PIN_INPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
> +			AM64X_IOPAD(0x00e8, PIN_INPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
> +			AM64X_IOPAD(0x00ec, PIN_INPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
> +			AM64X_IOPAD(0x00f0, PIN_INPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
> +			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
> +			AM64X_IOPAD(0x00f4, PIN_INPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
> +		>;
> +	};
>  };
>  
>  &main_uart0 {
> @@ -731,3 +816,15 @@ &main_mcan1 {
>  	pinctrl-0 = <&main_mcan1_pins_default>;
>  	phys = <&transceiver2>;
>  };
> +
> +&icssg1_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&icssg1_mdio1_pins_default>;
> +
> +	icssg1_phy1: ethernet-phy@f {
> +		reg = <0xf>;
> +		tx-internal-delay-ps = <250>;
> +		rx-internal-delay-ps = <2000>;
> +	};
> +};

-- 
cheers,
-roger

