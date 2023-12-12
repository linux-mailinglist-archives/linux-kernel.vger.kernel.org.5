Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33E80F3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjLLQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjLLQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:58:46 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94895;
        Tue, 12 Dec 2023 08:58:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGwjSC014951;
        Tue, 12 Dec 2023 10:58:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702400325;
        bh=nwXqIk6Cxa750SX5lymVvW2lC5NV4wzqqraG3WfwMpE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VddEFdfvPlOqZ2Zb+tLkG9UXxaC7WpcCm69GdXQRt0ZZGKb2AVmcDtZti0tMxwkth
         43Qik7N/SC8dDiHS/Esnew1jBVb9beb/wD7EBRs2I4kI3hYQgNLxeUNyi/S+LCBYQo
         tAqIfqnFjHHqKyc6iEKqm2vdRW864deavMRGXhRI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCGwjtl037494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 10:58:45 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 10:58:45 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 10:58:45 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGwjxs004781;
        Tue, 12 Dec 2023 10:58:45 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BCGwipI018975;
        Tue, 12 Dec 2023 10:58:44 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <afd@ti.com>, <andrew@lunn.ch>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
Date:   Tue, 12 Dec 2023 22:28:31 +0530
Message-ID: <20231212165832.3933335-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212165832.3933335-1-danishanwar@ti.com>
References: <20231212165832.3933335-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.

The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
port is kept disable and ICSSG1 is enabled in single MAC mode by
default.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 8c5651d2cf5d..c08b0223be52 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -32,6 +32,8 @@ aliases {
 		mmc1 = &sdhci1;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
+		ethernet2 = &icssg1_emac0;
+		ethernet3 = &icssg1_emac1;
 	};
 
 	memory@80000000 {
@@ -229,6 +231,70 @@ transceiver2: can-phy1 {
 		max-bitrate = <5000000>;
 		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
 	};
+
+	icssg1_eth: icssg1-eth {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
+
+		sram = <&oc_sram>;
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
+
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg1_phy1>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				status = "disabled";
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -383,6 +449,30 @@ ddr_vtt_pins_default: ddr-vtt-default-pins {
 			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 		>;
 	};
+
+	icssg1_mdio1_pins_default: icssg1-mdio1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* (Y6) PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* (AA6) PRG1_MDIO0_MDIO */
+		>;
+	};
+
+	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins{
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00e4, PIN_INPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e8, PIN_INPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00ec, PIN_INPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00f0, PIN_INPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+			AM64X_IOPAD(0x00f4, PIN_INPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -731,3 +821,15 @@ &main_mcan1 {
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&icssg1_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg1_mdio1_pins_default>;
+
+	icssg1_phy1: ethernet-phy@f {
+		reg = <0xf>;
+		tx-internal-delay-ps = <250>;
+		rx-internal-delay-ps = <2000>;
+	};
+};
-- 
2.34.1

