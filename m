Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E272772E53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHGS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjHGS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:57:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD6C1BC0;
        Mon,  7 Aug 2023 11:57:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377Iv2fj030831;
        Mon, 7 Aug 2023 13:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691434622;
        bh=w5YF8t5/AGI7RJ4NmAAvsHTFwqUck4gOdSoZjFlW+GM=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=QefX9mSMUkg6WaE0KFNa1AFY8A6zCJI8xygkI/hh+qBcfKuPUv8YQzpXZ4/63bxCx
         GZ/8JoDjm6xyQ+Dx0M5gc3hAVYQUwwn5WMBwqxcm5J4EFmSzUNMtSCOQo1CoyC7M2G
         CEiRRcSId9gUf7SZrNB9K36eE9NDOUFTT1QZhkSc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377Iv2LA027293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 13:57:02 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 13:57:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 13:57:01 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Iuj1t013364;
        Mon, 7 Aug 2023 13:56:57 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-j784s4-evm: Add bootph-pre-ram property for SPL nodes
Date:   Tue, 8 Aug 2023 00:26:44 +0530
Message-ID: <20230807185645.128751-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807185645.128751-1-a-nandan@ti.com>
References: <20230807185645.128751-1-a-nandan@ti.com>
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

Add bootph-pre-ram property for all the nodes used in SPL stage,
for syncing it later to u-boot j784s4 dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index cb852031c802..35933551e6be 100644
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
@@ -384,7 +393,9 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
 };
 
 &wkup_pmx1 {
+	bootph-pre-ram;
 	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
 			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
@@ -392,6 +403,7 @@ J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
 	};
 
 	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
 			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
@@ -406,6 +418,7 @@ J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
 };
 
 &wkup_uart0 {
+	bootph-pre-ram;
 	/* Firmware usage */
 	status = "reserved";
 	pinctrl-names = "default";
@@ -413,6 +426,7 @@ &wkup_uart0 {
 };
 
 &wkup_i2c0 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
@@ -426,27 +440,32 @@ eeprom@50 {
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
 };
 
 &fss {
+	bootph-pre-ram;
 	status = "okay";
 };
 
 &ospi0 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
 
 	flash@0 {
+		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -494,6 +513,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-pre-ram;
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
@@ -502,11 +522,13 @@ partition@3fc0000 {
 };
 
 &ospi1 {
+	bootph-pre-ram;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
 	flash@0{
+		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
@@ -554,6 +576,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-pre-ram;
 				label = "qspi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
@@ -598,6 +621,7 @@ exp2: gpio@22 {
 };
 
 &main_sdhci0 {
+	bootph-pre-ram;
 	/* eMMC */
 	status = "okay";
 	non-removable;
@@ -606,6 +630,7 @@ &main_sdhci0 {
 };
 
 &main_sdhci1 {
+	bootph-pre-ram;
 	/* SD card */
 	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-- 
2.34.1

