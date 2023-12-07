Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1181280892E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441917AbjLGN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441899AbjLGN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:28:46 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4910C2;
        Thu,  7 Dec 2023 05:28:50 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7DSg8U088476;
        Thu, 7 Dec 2023 07:28:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701955722;
        bh=/5NiPeOwKeZeuXHPBA3DDOgaR5OojWTWXq4pk+eKwtE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hPuqZeCVagrSbPixUnZXekOTKmg/P4JgOV4UZy8nbVK5vv7u2xI58rt4BiEanMc+w
         th0KkpV3b4RGpub96Viiz1j6PZbvBuk2W7F0Jhtf0v5+P6ayE8FcMuiU8RCiJmvung
         yT1XUUNf/j5la48jdTXaWmamMU6yauzOEZKejJ+4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7DSglL062799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 07:28:42 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 07:28:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 07:28:41 -0600
Received: from [10.249.135.225] ([10.249.135.225])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7DSbS2010715;
        Thu, 7 Dec 2023 07:28:38 -0600
Message-ID: <f83f21c0-3f5f-4069-abab-2b47e371d3bd@ti.com>
Date:   Thu, 7 Dec 2023 18:58:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20231207081917.340167-1-danishanwar@ti.com>
 <20231207081917.340167-3-danishanwar@ti.com>
 <20231207131818.3n7z64ve6izatlvs@unchanged>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20231207131818.3n7z64ve6izatlvs@unchanged>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2023 6:48 PM, Nishanth Menon wrote:
> On 13:49-20231207, MD Danish Anwar wrote:
>> ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.
>>
>> The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
>> MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
>> CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
>> bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
>> port is kept disable and ICSSG1 is enabled in single MAC mode by
>> default.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 105 ++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> index 8c5651d2cf5d..04d1c0602d31 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> @@ -34,6 +34,11 @@ aliases {
>>  		ethernet1 = &cpsw_port2;
>>  	};
>>  
>> +	aliases {
>> +		ethernet2 = &icssg1_emac0;
>> +		ethernet3 = &icssg1_emac1;
>> +	};
> 
> Why another aliases section?
> 

Sorry, My bad. I had created these patches a while back when there was
no alias section in this dts file, and applied them directly here. I
didn't notice the already existing alias section. I will remove this
aliases section and move these two aliases two the above section in v2.

>> +
>>  	memory@80000000 {
>>  		bootph-all;
>>  		device_type = "memory";
>> @@ -229,6 +234,70 @@ transceiver2: can-phy1 {
>>  		max-bitrate = <5000000>;
>>  		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
>>  	};
>> +
>> +	icssg1_eth: icssg1-eth {
>> +		compatible = "ti,am642-icssg-prueth";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
>> +
>> +		sram = <&oc_sram>;
>> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
>> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
>> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
>> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
>> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
>> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
>> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> 
> Umm... am65x??? is that a typo? I'd rather keep it am64x here and drop
> that sr2 thing. Tomorrow there will be a custom bug on am64 and then we
> will have to respin this again.
> 

No Nishant, this is not a typo. Both AM64x and AM65x use the same ICSSG
firmwares. We only have am65x-sr2-* firmwares and they are used by both
AM64x and AM65x and that is why I have kept the firmware-name here in dt
same as the files that we load on the pru cores.

>> +
>> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
>> +				      <2>,
>> +				      <2>,
>> +				      <2>,	/* MII mode */
>> +				      <2>,
>> +				      <2>;
>> +
>> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
>> +		ti,mii-rt = <&icssg1_mii_rt>;
>> +		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
>> +
>> +		interrupt-parent = <&icssg1_intc>;
>> +		interrupts = <24 0 2>, <25 1 3>;
>> +		interrupt-names = "tx_ts0", "tx_ts1";
>> +
>> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
>> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
>> +		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
>> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
>> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>> +			    "rx0", "rx1";
>> +
>> +		ethernet-ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			icssg1_emac0: port@0 {
>> +				reg = <0>;
>> +				phy-handle = <&icssg1_phy1>;
>> +				phy-mode = "rgmii-id";
>> +				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
>> +				/* Filled in by bootloader */
>> +				local-mac-address = [00 00 00 00 00 00];
>> +			};
>> +			icssg1_emac1: port@1 {
>> +				reg = <1>;
>> +				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
>> +				/* Filled in by bootloader */
>> +				local-mac-address = [00 00 00 00 00 00];
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>>  };
>>  
>>  &main_pmx0 {
>> @@ -383,6 +452,30 @@ ddr_vtt_pins_default: ddr-vtt-default-pins {
>>  			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
>>  		>;
>>  	};
>> +
>> +	icssg1_mdio1_pins_default: icssg1-mdio1-default-pins {
>> +		pinctrl-single,pins = <
>> +			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* (Y6) PRG1_MDIO0_MDC */
>> +			AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* (AA6) PRG1_MDIO0_MDIO */
>> +		>;
>> +	};
>> +
>> +	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins{
>> +		pinctrl-single,pins = <
>> +			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
>> +			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
>> +			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
>> +			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
>> +			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
>> +			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
>> +			AM64X_IOPAD(0x00e4, PIN_INPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
>> +			AM64X_IOPAD(0x00e8, PIN_INPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
>> +			AM64X_IOPAD(0x00ec, PIN_INPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
>> +			AM64X_IOPAD(0x00f0, PIN_INPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
>> +			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
>> +			AM64X_IOPAD(0x00f4, PIN_INPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
>> +		>;
>> +	};
>>  };
>>  
>>  &main_uart0 {
>> @@ -731,3 +824,15 @@ &main_mcan1 {
>>  	pinctrl-0 = <&main_mcan1_pins_default>;
>>  	phys = <&transceiver2>;
>>  };
>> +
>> +&icssg1_mdio {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&icssg1_mdio1_pins_default>;
>> +
>> +	icssg1_phy1: ethernet-phy@0 {
>> +		reg = <0xf>;
>> +		tx-internal-delay-ps = <250>;
>> +		rx-internal-delay-ps = <2000>;
>> +	};
>> +};
>> -- 
>> 2.34.1
>>
> 

-- 
Thanks and Regards,
Md Danish Anwar
