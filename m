Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C51771626
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjHFQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjHFQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:49:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020F1733;
        Sun,  6 Aug 2023 09:49:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 376Gmsej006540;
        Sun, 6 Aug 2023 11:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691340534;
        bh=JPRORifvGrUrwDZIN/iGzlfeEl6AVt2arl7a65Q6VzE=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=WLA6OcoXxT+uCPp3wZFmohvOketKmXWuIdGkHD/QtmcI1xosngtp69dCOlwLOI8r4
         zJ9cVJyneexZuSLiBXfk9nXk1vpBtvhBJJuT3SBmhymsoBSMlVisZfevnB1vfG+OjA
         15/a/ncV+YYjuo2GpN04rOwVEpjb+BnEdrolMNwE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 376GmsXM074078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 6 Aug 2023 11:48:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Aug 2023 11:48:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Aug 2023 11:48:53 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 376GmdMa009591;
        Sun, 6 Aug 2023 11:48:50 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4-evm: Add bootph-pre-ram property for SPL nodes
Date:   Sun, 6 Aug 2023 22:18:38 +0530
Message-ID: <20230806164838.18088-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806164838.18088-1-a-nandan@ti.com>
References: <20230806164838.18088-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bootph-pre-ram property for all the nodes used in SPL stage,
for syncing it later to u-boot j784s4 dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 1e38a8f1bec5..12455baf68b0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -252,7 +252,9 @@ vdd_sd_dv: regulator-TLV71033 {
 };
 
 &main_pmx0 {
+	bootph-pre-ram;
 	main_uart8_pins_default: main-uart8-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
 			J784S4_IOPAD(0x044, PIN_OUTPUT, 14) /* (AG37) MCASP0_AXR1.UART8_RTSn */
@@ -269,6 +271,7 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x104, PIN_INPUT, 0) /* (AB38) MMC1_CLK */
 			J784S4_IOPAD(0x108, PIN_INPUT, 0) /* (AB36) MMC1_CMD */
@@ -289,7 +292,9 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 };
 
 &wkup_pmx2 {
+	bootph-pre-ram;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
 			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
@@ -299,6 +304,7 @@ J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
@@ -306,6 +312,7 @@ J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (H37) WKUP_GPIO0_14.MCU_UART0_CTSn */
 			J784S4_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (K37) WKUP_GPIO0_15.MCU_UART0_RTSn */
@@ -366,7 +373,9 @@ J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 };
 
 &wkup_pmx0 {
+	bootph-pre-ram;
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
 			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
@@ -385,6 +394,7 @@ J784S4_WKUP_IOPAD(0x038, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_CSn2.MCU_OSPI0_RESET_
 	};
 
 	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
 			J784S4_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
@@ -399,6 +409,7 @@ J784S4_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
 };
 
 &wkup_uart0 {
+	bootph-pre-ram;
 	/* Firmware usage */
 	status = "reserved";
 	pinctrl-names = "default";
@@ -406,6 +417,7 @@ &wkup_uart0 {
 };
 
 &wkup_i2c0 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
@@ -419,12 +431,14 @@ eeprom@50 {
 };
 
 &mcu_uart0 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart8 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
@@ -435,15 +449,18 @@ &ufs_wrapper {
 };
 
 &fss {
+	bootph-pre-ram;
 	status = "okay";
 };
 
 &ospi0 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
 	flash@0 {
+		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -491,6 +508,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-pre-ram;
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
@@ -499,11 +517,13 @@ partition@3fc0000 {
 };
 
 &ospi1 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
 	flash@0 {
+		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
@@ -551,6 +571,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-pre-ram;
 				label = "qspi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
@@ -595,6 +616,7 @@ exp2: gpio@22 {
 };
 
 &main_sdhci0 {
+	bootph-pre-ram;
 	/* eMMC */
 	status = "okay";
 	non-removable;
@@ -603,6 +625,7 @@ &main_sdhci0 {
 };
 
 &main_sdhci1 {
+	bootph-pre-ram;
 	/* SD card */
 	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-- 
2.34.1

