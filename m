Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614427D9A15
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjJ0Ngh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjJ0NgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:36:02 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB510F7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:35:45 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202310271334427166bf601c6e338f16
        for <linux-kernel@vger.kernel.org>;
        Fri, 27 Oct 2023 15:34:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7c2mWS3F93AM6SkJnd8UYheoA+Ehx15s7XTf+937SM0=;
 b=dKpY8l8UJ932pSykrSDMAYcX070nAFZCCkftUuoCUD3Iur3Y8z1jxZsp1TvRYjhRiMnk27
 oP5joYWBWfysC+sBWE2w6hDEGc61K0jHRAVfDbYawZI1zd38PbVU9meqcN60mMUcDmjatQH0
 NXANMW/WIRaH4BbYFZM69nZ5iSQAg=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH 7/7] arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices
Date:   Fri, 27 Oct 2023 15:34:38 +0200
Message-Id: <b6a4dcecb2408c804106a2677ed070dab081aaac.1698413678.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1698413678.git.jan.kiszka@siemens.com>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the required nodes to enable ICSSG SR2.0 based prueth networking.

As the driver still needs to be extended for SR1.0 support, keep related
nodes disabled on PG1 devices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |  10 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 132 ++++++++++++++++++
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
index 51f902fa35a7..1d1979859583 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) Siemens AG, 2021
+ * Copyright (c) Siemens AG, 2021-2023
  *
  * Authors:
  *   Jan Kiszka <jan.kiszka@siemens.com>
@@ -44,3 +44,11 @@ &tx_pru2_0 {
 &tx_pru2_1 {
 	status = "disabled";
 };
+
+&icssg0_eth {
+	status = "disabled";
+};
+
+&icssg0_mdio {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index bc77ba58d8f9..1a558851ea96 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -11,6 +11,7 @@
 
 #include "k3-am654.dtsi"
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	aliases {
@@ -27,6 +28,8 @@ aliases {
 		spi0 = &mcu_spi0;
 		mmc0 = &sdhci1;
 		mmc1 = &sdhci0;
+		ethernet1 = &icssg0_emac0;
+		ethernet2 = &icssg0_emac1;
 	};
 
 	chosen {
@@ -111,6 +114,80 @@ dp_refclk: clock {
 		#clock-cells = <0>;
 		clock-frequency = <19200000>;
 	};
+
+	/* Dual Ethernet application node on PRU-ICSSG0 */
+	icssg0_eth: icssg0-eth {
+		compatible = "ti,am654-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg0_rgmii_pins_default>;
+		sram = <&msmc_ram>;
+
+		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>,
+			<&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
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
+		ti,mii-g-rt = <&icssg0_mii_g_rt>;
+		ti,mii-rt = <&icssg0_mii_rt>;
+		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
+
+		interrupt-parent = <&icssg0_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_udmap 0xc100>, /* egress slice 0 */
+		       <&main_udmap 0xc101>, /* egress slice 0 */
+		       <&main_udmap 0xc102>, /* egress slice 0 */
+		       <&main_udmap 0xc103>, /* egress slice 0 */
+		       <&main_udmap 0xc104>, /* egress slice 1 */
+		       <&main_udmap 0xc105>, /* egress slice 1 */
+		       <&main_udmap 0xc106>, /* egress slice 1 */
+		       <&main_udmap 0xc107>, /* egress slice 1 */
+
+		       <&main_udmap 0x4100>, /* ingress slice 0 */
+		       <&main_udmap 0x4101>, /* ingress slice 1 */
+		       <&main_udmap 0x4102>, /* mgmnt rsp slice 0 */
+		       <&main_udmap 0x4103>; /* mgmnt rsp slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1",
+			    "rxmgm0", "rxmgm1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg0_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg0_eth0_phy>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&scm_conf 0x4100>;
+				ti,half-duplex-capable;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			icssg0_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg0_eth1_phy>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&scm_conf 0x4104>;
+				ti,half-duplex-capable;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
 };
 
 &wkup_pmx0 {
@@ -944,6 +1021,43 @@ AM65X_IOPAD(0x0074, PIN_INPUT,  5)  /* (T27) I2C2_SCL */
 			AM65X_IOPAD(0x0070, PIN_INPUT,  5)  /* (R25) I2C2_SDA */
 		>;
 	};
+
+	icssg0_mdio_pins_default: icssg0-mdio-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0294, PIN_INPUT, 0) /* (AE26) PRG0_MDIO0_MDIO */
+			AM65X_IOPAD(0x0298, PIN_OUTPUT, 0) /* (AE28) PRG0_MDIO0_MDC */
+		>;
+	};
+
+	icssg0_rgmii_pins_default: icssg0-rgmii-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0244, PIN_INPUT, 2) /* (AB28) PRG0_PRU1_GPO0.PRG0_RGMII2_RD0 */
+			AM65X_IOPAD(0x0248, PIN_INPUT, 2) /* (AC28) PRG0_PRU1_GPO1.PRG0_RGMII2_RD1 */
+			AM65X_IOPAD(0x024c, PIN_INPUT, 2) /* (AC27) PRG0_PRU1_GPO2.PRG0_RGMII2_RD2 */
+			AM65X_IOPAD(0x0250, PIN_INPUT, 2) /* (AB26) PRG0_PRU1_GPO3.PRG0_RGMII2_RD3 */
+			AM65X_IOPAD(0x0274, PIN_OUTPUT, 2) /* (AC25) PRG0_PRU1_GPO12.PRG0_RGMII2_TD0 */
+			AM65X_IOPAD(0x0278, PIN_OUTPUT, 2) /* (AD25) PRG0_PRU1_GPO13.PRG0_RGMII2_TD1 */
+			AM65X_IOPAD(0x027c, PIN_OUTPUT, 2) /* (AD24) PRG0_PRU1_GPO14.PRG0_RGMII2_TD2 */
+			AM65X_IOPAD(0x0280, PIN_OUTPUT, 2) /* (AE27) PRG0_PRU1_GPO15.PRG0_RGMII2_TD3 */
+			AM65X_IOPAD(0x0284, PIN_INPUT, 2) /* (AC24) PRG0_PRU1_GPO16.PRG0_RGMII2_TXC */
+			AM65X_IOPAD(0x0270, PIN_OUTPUT, 2) /* (AB24) PRG0_PRU1_GPO11.PRG0_RGMII2_TX_CTL */
+			AM65X_IOPAD(0x025c, PIN_INPUT, 2) /* (AB27) PRG0_PRU1_GPO6.PRG0_RGMII2_RXC */
+			AM65X_IOPAD(0x0254, PIN_INPUT, 2) /* (AA25) PRG0_PRU1_GPO4.PRG0_RGMII2_RX_CTL */
+
+			AM65X_IOPAD(0x01f4, PIN_INPUT, 2) /* (V24) PRG0_PRU0_GPO0.PRG0_RGMII1_RD0 */
+			AM65X_IOPAD(0x01f8, PIN_INPUT, 2) /* (W25) PRG0_PRU0_GPO1.PRG0_RGMII1_RD1 */
+			AM65X_IOPAD(0x01fc, PIN_INPUT, 2) /* (W24) PRG0_PRU0_GPO2.PRG0_RGMII1_RD2 */
+			AM65X_IOPAD(0x0200, PIN_INPUT, 2) /* (AA27) PRG0_PRU0_GPO3.PRG0_RGMII1_RD3 */
+			AM65X_IOPAD(0x0224, PIN_OUTPUT, 2) /* (AD27) PRG0_PRU0_GPO12.PRG0_RGMII1_TD0 */
+			AM65X_IOPAD(0x0228, PIN_OUTPUT, 2) /* (AC26) PRG0_PRU0_GPO13.PRG0_RGMII1_TD1 */
+			AM65X_IOPAD(0x022c, PIN_OUTPUT, 2) /* (AD26) PRG0_PRU0_GPO14.PRG0_RGMII1_TD2 */
+			AM65X_IOPAD(0x0230, PIN_OUTPUT, 2) /* (AA24) PRG0_PRU0_GPO15.PRG0_RGMII1_TD3 */
+			AM65X_IOPAD(0x0234, PIN_INPUT, 2) /* (AD28) PRG0_PRU0_GPO16.PRG0_RGMII1_TXC */
+			AM65X_IOPAD(0x0220, PIN_OUTPUT, 2) /* (AB25) PRG0_PRU0_GPO11.PRG0_RGMII1_TX_CTL */
+			AM65X_IOPAD(0x020c, PIN_INPUT, 2) /* (Y25) PRG0_PRU0_GPO6.PRG0_RGMII1_RXC */
+			AM65X_IOPAD(0x0204, PIN_INPUT, 2) /* (Y24) PRG0_PRU0_GPO4.PRG0_RGMII1_RX_CTL */
+		>;
+	};
 };
 
 &main_pmx1 {
@@ -1322,3 +1436,21 @@ &mcu_r5fss0_core1 {
 			<&mcu_r5fss0_core1_memory_region>;
 	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
 };
+
+&icssg0_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg0_mdio_pins_default>;
+
+	icssg0_eth0_phy: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+
+	icssg0_eth1_phy: ethernet-phy@1 {
+		reg = <1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
-- 
2.35.3

