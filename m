Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5CE7721C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjHGLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjHGLXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:23:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F62C30D4;
        Mon,  7 Aug 2023 04:20:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377BJNuu113037;
        Mon, 7 Aug 2023 06:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691407163;
        bh=L7wDzWX1fRjMSwSi9/AB/f7MFWEZs9Zt+qjNX+t2biw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QNVTaobIRU8jP5Kt4tWDS2b8jHvFKMJZtUGCF0el5ZuGDEPCEcXYyyZxKqMgqiutS
         60aW/IqmAH+nneqbWbjv8DiJRVa3sEBSG8pUluRSeU0FTLaXEGNQL6x3d33wSM0217
         HtUso1+qrRvusP+ufgId8YxS1eY9SdReaCaKqJPQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377BJNuv083731
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 06:19:23 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:19:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:19:22 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377BJMZw091038;
        Mon, 7 Aug 2023 06:19:22 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377BJL4A031108;
        Mon, 7 Aug 2023 06:19:22 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: [PATCH RFC 3/3] arm64: dts: ti: am654-base-board: add ICSSG2 Ethernet support
Date:   Mon, 7 Aug 2023 16:48:55 +0530
Message-ID: <20230807111855.2614761-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807111855.2614761-1-danishanwar@ti.com>
References: <20230807111855.2614761-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICSSG2 provides dual Gigabit Ethernet support.

For support SR2.0 ICSSG Ethernet firmware:
- provide different firmware blobs and use TX_PRU.
- IEP0 is used as PTP Hardware Clock and can only be used for one port.
- TX timestamp notification comes via INTC interrupt.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 973a89b04a22..ca9402c3d9c7 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -25,6 +25,8 @@ aliases {
 		ethernet0 = &cpsw_port1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
+		ethernet1 = &icssg2_emac0;
+		ethernet2 = &icssg2_emac1;
 	};
 
 	chosen {
@@ -144,6 +146,72 @@ vtt_supply: regulator-3 {
 		vin-supply = <&vcc3v3_io>;
 		gpio = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
 	};
+
+	/* Dual Ethernet application node on PRU-ICSSG2 */
+	icssg2_eth: icssg2-eth {
+		compatible = "ti,am654-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg2_rgmii_pins_default>;
+		sram = <&msmc_ram>;
+		ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
+			<&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,      /* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ti,mii-g-rt = <&icssg2_mii_g_rt>;
+		ti,mii-rt = <&icssg2_mii_rt>;
+		ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
+
+		interrupt-parent = <&icssg2_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_udmap 0xc300>, /* egress slice 0 */
+		       <&main_udmap 0xc301>, /* egress slice 0 */
+		       <&main_udmap 0xc302>, /* egress slice 0 */
+		       <&main_udmap 0xc303>, /* egress slice 0 */
+		       <&main_udmap 0xc304>, /* egress slice 1 */
+		       <&main_udmap 0xc305>, /* egress slice 1 */
+		       <&main_udmap 0xc306>, /* egress slice 1 */
+		       <&main_udmap 0xc307>, /* egress slice 1 */
+		       <&main_udmap 0x4300>, /* ingress slice 0 */
+		       <&main_udmap 0x4301>; /* ingress slice 1 */
+
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg2_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg2_phy0>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+			icssg2_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg2_phy1>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
 };
 
 &wkup_pmx0 {
@@ -300,6 +368,43 @@ usb1_pins_default: usb1-default-pins {
 			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0) /* (AC8) USB1_DRVVBUS */
 		>;
 	};
+
+	icssg2_mdio_pins_default: icssg2-mdio-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0094, PIN_INPUT, 2) /* (AC19) PRG2_PRU0_GPO7.PRG2_MDIO0_MDIO */
+			AM65X_IOPAD(0x00c8, PIN_OUTPUT, 2) /* (AE15) PRG2_PRU1_GPO7.PRG2_MDIO0_MDC */
+		>;
+	};
+
+	icssg2_rgmii_pins_default: icssg2-rgmii-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x00ac, PIN_INPUT, 2) /* (AH15) PRG2_PRU1_GPO0.PRG2_RGMII2_RD0 */
+			AM65X_IOPAD(0x00b0, PIN_INPUT, 2) /* (AC16) PRG2_PRU1_GPO1.PRG2_RGMII2_RD1 */
+			AM65X_IOPAD(0x00b4, PIN_INPUT, 2) /* (AD17) PRG2_PRU1_GPO2.PRG2_RGMII2_RD2 */
+			AM65X_IOPAD(0x00b8, PIN_INPUT, 2) /* (AH14) PRG2_PRU1_GPO3.PRG2_RGMII2_RD3 */
+			AM65X_IOPAD(0x00cc, PIN_OUTPUT, 2) /* (AD15) PRG2_PRU1_GPO8.PRG2_RGMII2_TD0 */
+			AM65X_IOPAD(0x00d0, PIN_OUTPUT, 2) /* (AF14) PRG2_PRU1_GPO9.PRG2_RGMII2_TD1 */
+			AM65X_IOPAD(0x00d4, PIN_OUTPUT, 2) /* (AC15) PRG2_PRU1_GPO10.PRG2_RGMII2_TD2 */
+			AM65X_IOPAD(0x00d8, PIN_OUTPUT, 2) /* (AD14) PRG2_PRU1_GPO11.PRG2_RGMII2_TD3 */
+			AM65X_IOPAD(0x00dc, PIN_INPUT, 2) /* (AE14) PRG2_PRU1_GPO16.PRG2_RGMII2_TXC */
+			AM65X_IOPAD(0x00c4, PIN_OUTPUT, 2) /* (AC17) PRG2_PRU1_GPO6.PRG2_RGMII2_TX_CTL */
+			AM65X_IOPAD(0x00c0, PIN_INPUT, 2) /* (AG15) PRG2_PRU1_GPO5.PRG2_RGMII2_RXC */
+			AM65X_IOPAD(0x00bc, PIN_INPUT, 2) /* (AG14) PRG2_PRU1_GPO4.PRG2_RGMII2_RX_CTL */
+
+			AM65X_IOPAD(0x0078, PIN_INPUT, 2) /* (AF18) PRG2_PRU0_GPO0.PRG2_RGMII1_RD0 */
+			AM65X_IOPAD(0x007c, PIN_INPUT, 2) /* (AE18) PRG2_PRU0_GPO1.PRG2_RGMII1_RD1 */
+			AM65X_IOPAD(0x0080, PIN_INPUT, 2) /* (AH17) PRG2_PRU0_GPO2.PRG2_RGMII1_RD2 */
+			AM65X_IOPAD(0x0084, PIN_INPUT, 2) /* (AG18) PRG2_PRU0_GPO3.PRG2_RGMII1_RD3 */
+			AM65X_IOPAD(0x0098, PIN_OUTPUT, 2) /* (AH16) PRG2_PRU0_GPO8.PRG2_RGMII1_TD0 */
+			AM65X_IOPAD(0x009c, PIN_OUTPUT, 2) /* (AG16) PRG2_PRU0_GPO9.PRG2_RGMII1_TD1 */
+			AM65X_IOPAD(0x00a0, PIN_OUTPUT, 2) /* (AF16) PRG2_PRU0_GPO10.PRG2_RGMII1_TD2 */
+			AM65X_IOPAD(0x00a4, PIN_OUTPUT, 2) /* (AE16) PRG2_PRU0_GPO11.PRG2_RGMII1_TD3 */
+			AM65X_IOPAD(0x00a8, PIN_INPUT, 2) /* (AD16) PRG2_PRU0_GPO16.PRG2_RGMII1_TXC */
+			AM65X_IOPAD(0x0090, PIN_OUTPUT, 2) /* (AE17) PRG2_PRU0_GPO6.PRG2_RGMII1_TX_CTL */
+			AM65X_IOPAD(0x008c, PIN_INPUT, 2) /* (AF17) PRG2_PRU0_GPO5.PRG2_RGMII1_RXC */
+			AM65X_IOPAD(0x0088, PIN_INPUT, 2) /* (AG17) PRG2_PRU0_GPO4.PRG2_RGMII1_RX_CTL */
+		>;
+	};
 };
 
 &main_pmx1 {
@@ -618,3 +723,29 @@ &cpsw_port1 {
 &dss {
 	status = "disabled";
 };
+
+&icssg0_mdio {
+	status = "disabled";
+};
+
+&icssg1_mdio {
+	status = "disabled";
+};
+
+&icssg2_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg2_mdio_pins_default>;
+
+	icssg2_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+
+	icssg2_phy1: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
-- 
2.34.1

