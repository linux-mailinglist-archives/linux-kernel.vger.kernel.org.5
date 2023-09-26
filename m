Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958C87AEE93
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjIZOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjIZOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:18:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB9101;
        Tue, 26 Sep 2023 07:18:38 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QEISjs056926;
        Tue, 26 Sep 2023 09:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695737908;
        bh=1dy5yM8yoUL1bkfMYrYwW1LQmhZqRTk186kAw6Iq51g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=yddBs9gCsvLNc4iPYjoMKZf76ecUzfkhccWSv74C4JgrG4Ge4aHPU5GNCrpNTcov/
         z100hbvqQ/ZD0fSJGtBJQPz7Qt7DeqMBbXMjEVlCWiAmPQfkTrVtPip1sAlv2GpUad
         eajBfDB7oi7FJP0zRRqAOAgFPTrnab4wMojP9bPA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QEISHR029600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 09:18:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 09:18:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 09:18:27 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QEIRq7122731;
        Tue, 26 Sep 2023 09:18:27 -0500
Message-ID: <9f3f39fc-e456-11f4-e567-393cfc3629b5@ti.com>
Date:   Tue, 26 Sep 2023 09:18:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/4] arm64: dts: ti: k3-am654-base-board: add ICSSG2
 Ethernet support
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20230926045337.1248276-1-danishanwar@ti.com>
 <20230926045337.1248276-3-danishanwar@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230926045337.1248276-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 11:53 PM, MD Danish Anwar wrote:
> ICSSG2 provides dual Gigabit Ethernet support.
> 
> For support SR2.0 ICSSG Ethernet firmware:
> - provide different firmware blobs and use TX_PRU.
> - IEP0 is used as PTP Hardware Clock and can only be used for one port.
> - TX timestamp notification comes via INTC interrupt.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

Seems reasonable to me,

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm64/boot/dts/ti/Makefile               |   2 +
>   ...se-board.dts => k3-am654-common-board.dts} |   0
>   arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso   | 145 ++++++++++++++++++
>   3 files changed, 147 insertions(+)
>   rename arch/arm64/boot/dts/ti/{k3-am654-base-board.dts => k3-am654-common-board.dts} (100%)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e7b8e2e7f083..8f5c9515777e 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -42,12 +42,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
>   
>   # Boards with AM65x SoC
> +k3-am654-base-board-dtbs := k3-am654-common-board.dtb k3-am654-icssg2.dtbo
>   k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am654-common-board.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-common-board.dts
> similarity index 100%
> rename from arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> rename to arch/arm64/boot/dts/ti/k3-am654-common-board.dts
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> new file mode 100644
> index 000000000000..7b7d32282668
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT overlay for IDK application board on AM654 EVM
> + *
> + * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	aliases {
> +		ethernet1 = &icssg2_emac0;
> +		ethernet2 = &icssg2_emac1;
> +	};
> +
> +	/* Ethernet node on PRU-ICSSG2 */
> +	icssg2_eth: icssg2-eth {
> +		compatible = "ti,am654-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&icssg2_rgmii_pins_default>;
> +		sram = <&msmc_ram>;
> +		ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
> +			<&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> +
> +		ti,pruss-gp-mux-sel = <2>,      /* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +
> +		ti,mii-g-rt = <&icssg2_mii_g_rt>;
> +		ti,mii-rt = <&icssg2_mii_rt>;
> +		ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
> +
> +		interrupt-parent = <&icssg2_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;
> +		interrupt-names = "tx_ts0", "tx_ts1";
> +
> +		dmas = <&main_udmap 0xc300>, /* egress slice 0 */
> +		       <&main_udmap 0xc301>, /* egress slice 0 */
> +		       <&main_udmap 0xc302>, /* egress slice 0 */
> +		       <&main_udmap 0xc303>, /* egress slice 0 */
> +		       <&main_udmap 0xc304>, /* egress slice 1 */
> +		       <&main_udmap 0xc305>, /* egress slice 1 */
> +		       <&main_udmap 0xc306>, /* egress slice 1 */
> +		       <&main_udmap 0xc307>, /* egress slice 1 */
> +		       <&main_udmap 0x4300>, /* ingress slice 0 */
> +		       <&main_udmap 0x4301>; /* ingress slice 1 */
> +
> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			icssg2_emac0: port@0 {
> +				reg = <0>;
> +				phy-handle = <&icssg2_phy0>;
> +				phy-mode = "rgmii-id";
> +				ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +			icssg2_emac1: port@1 {
> +				reg = <1>;
> +				phy-handle = <&icssg2_phy1>;
> +				phy-mode = "rgmii-id";
> +				ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +
> +	icssg2_mdio_pins_default: icssg2-mdio-default-pins {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x0094, PIN_INPUT, 2) /* (AC19) PRG2_PRU0_GPO7.PRG2_MDIO0_MDIO */
> +			AM65X_IOPAD(0x00c8, PIN_OUTPUT, 2) /* (AE15) PRG2_PRU1_GPO7.PRG2_MDIO0_MDC */
> +		>;
> +	};
> +
> +	icssg2_rgmii_pins_default: icssg2-rgmii-default-pins {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x00ac, PIN_INPUT, 2) /* (AH15) PRG2_PRU1_GPO0.PRG2_RGMII2_RD0 */
> +			AM65X_IOPAD(0x00b0, PIN_INPUT, 2) /* (AC16) PRG2_PRU1_GPO1.PRG2_RGMII2_RD1 */
> +			AM65X_IOPAD(0x00b4, PIN_INPUT, 2) /* (AD17) PRG2_PRU1_GPO2.PRG2_RGMII2_RD2 */
> +			AM65X_IOPAD(0x00b8, PIN_INPUT, 2) /* (AH14) PRG2_PRU1_GPO3.PRG2_RGMII2_RD3 */
> +			AM65X_IOPAD(0x00cc, PIN_OUTPUT, 2) /* (AD15) PRG2_PRU1_GPO8.PRG2_RGMII2_TD0 */
> +			AM65X_IOPAD(0x00d0, PIN_OUTPUT, 2) /* (AF14) PRG2_PRU1_GPO9.PRG2_RGMII2_TD1 */
> +			AM65X_IOPAD(0x00d4, PIN_OUTPUT, 2) /* (AC15) PRG2_PRU1_GPO10.PRG2_RGMII2_TD2 */
> +			AM65X_IOPAD(0x00d8, PIN_OUTPUT, 2) /* (AD14) PRG2_PRU1_GPO11.PRG2_RGMII2_TD3 */
> +			AM65X_IOPAD(0x00dc, PIN_INPUT, 2) /* (AE14) PRG2_PRU1_GPO16.PRG2_RGMII2_TXC */
> +			AM65X_IOPAD(0x00c4, PIN_OUTPUT, 2) /* (AC17) PRG2_PRU1_GPO6.PRG2_RGMII2_TX_CTL */
> +			AM65X_IOPAD(0x00c0, PIN_INPUT, 2) /* (AG15) PRG2_PRU1_GPO5.PRG2_RGMII2_RXC */
> +			AM65X_IOPAD(0x00bc, PIN_INPUT, 2) /* (AG14) PRG2_PRU1_GPO4.PRG2_RGMII2_RX_CTL */
> +
> +			AM65X_IOPAD(0x0078, PIN_INPUT, 2) /* (AF18) PRG2_PRU0_GPO0.PRG2_RGMII1_RD0 */
> +			AM65X_IOPAD(0x007c, PIN_INPUT, 2) /* (AE18) PRG2_PRU0_GPO1.PRG2_RGMII1_RD1 */
> +			AM65X_IOPAD(0x0080, PIN_INPUT, 2) /* (AH17) PRG2_PRU0_GPO2.PRG2_RGMII1_RD2 */
> +			AM65X_IOPAD(0x0084, PIN_INPUT, 2) /* (AG18) PRG2_PRU0_GPO3.PRG2_RGMII1_RD3 */
> +			AM65X_IOPAD(0x0098, PIN_OUTPUT, 2) /* (AH16) PRG2_PRU0_GPO8.PRG2_RGMII1_TD0 */
> +			AM65X_IOPAD(0x009c, PIN_OUTPUT, 2) /* (AG16) PRG2_PRU0_GPO9.PRG2_RGMII1_TD1 */
> +			AM65X_IOPAD(0x00a0, PIN_OUTPUT, 2) /* (AF16) PRG2_PRU0_GPO10.PRG2_RGMII1_TD2 */
> +			AM65X_IOPAD(0x00a4, PIN_OUTPUT, 2) /* (AE16) PRG2_PRU0_GPO11.PRG2_RGMII1_TD3 */
> +			AM65X_IOPAD(0x00a8, PIN_INPUT, 2) /* (AD16) PRG2_PRU0_GPO16.PRG2_RGMII1_TXC */
> +			AM65X_IOPAD(0x0090, PIN_OUTPUT, 2) /* (AE17) PRG2_PRU0_GPO6.PRG2_RGMII1_TX_CTL */
> +			AM65X_IOPAD(0x008c, PIN_INPUT, 2) /* (AF17) PRG2_PRU0_GPO5.PRG2_RGMII1_RXC */
> +			AM65X_IOPAD(0x0088, PIN_INPUT, 2) /* (AG17) PRG2_PRU0_GPO4.PRG2_RGMII1_RX_CTL */
> +		>;
> +	};
> +};
> +
> +&icssg2_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&icssg2_mdio_pins_default>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	icssg2_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +	};
> +
> +	icssg2_phy1: ethernet-phy@3 {
> +		reg = <3>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +	};
> +};
