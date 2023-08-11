Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E947792AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjHKPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjHKPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:17:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627630CD;
        Fri, 11 Aug 2023 08:17:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BFGxUc074388;
        Fri, 11 Aug 2023 10:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691767019;
        bh=/OVaNQT/t1vyFUb6lFg3Ou5Gv2V1D1mBs8svi+7JKd0=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=JNu5afRodRmEdT7VO6jr3wrX2cXtMYJUF18QLtGY3mJIuUER++L+FfzjRt5i5ncfo
         hjXt59iDxnwytFEibMrf4jPdWHxRLkB6yR4j0QbO0qc7GYUDxUS4KvNDk6NPDawF5T
         KjJBxTqmyUTpqJ/JsLS7Y2HVknhU2AdJzLBrbAMw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BFGxvu007524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 10:16:59 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 10:16:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 10:16:59 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BFGicf121323;
        Fri, 11 Aug 2023 10:16:56 -0500
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
Subject: [PATCH v4 3/3] arm64: dts: ti: k3-am69-sk: Add phase tags marking
Date:   Fri, 11 Aug 2023 20:46:44 +0530
Message-ID: <20230811151644.3216621-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811151644.3216621-1-a-nandan@ti.com>
References: <20230811151644.3216621-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
That's why add it also to Linux to be aligned with bootloader requirement.

wkup_uart0, wkup_i2c0, mcu_uart0, main_uart8, main_sdhci0 and main_sdhci1
are required for bootloader operation on TI K3 AM69-SK EVM. These IPs
along with pinmuxes need to be marked for all bootloader phases, hence add
bootph-all to these nodes in kernel dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index d282c2c633c1..2302d55c3fe7 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -110,7 +110,9 @@ vdd_sd_dv: regulator-tlv71033 {
 };
 
 &main_pmx0 {
+	bootph-all;
 	main_uart8_pins_default: main-uart8-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x0d0, PIN_INPUT, 11) /* (AP38) SPI0_CS1.UART8_RXD */
 			J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
@@ -125,6 +127,7 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x104, PIN_INPUT, 0) /* (AB38) MMC1_CLK */
 			J784S4_IOPAD(0x108, PIN_INPUT, 0) /* (AB36) MMC1_CMD */
@@ -164,7 +167,9 @@ J784S4_IOPAD(0x004, PIN_INPUT, 7) /* (AG36) MCAN12_TX.GPIO0_1 */
 };
 
 &wkup_pmx2 {
+	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
 			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
@@ -174,6 +179,7 @@ J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
@@ -181,6 +187,7 @@ J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (K38) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J784S4_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (J37) WKUP_GPIO0_12.MCU_UART0_TXD */
@@ -242,6 +249,7 @@ J784S4_WKUP_IOPAD(0x0, PIN_INPUT, 7) /* (M33) WKUP_GPIO0_49 */
 };
 
 &wkup_uart0 {
+	bootph-all;
 	/* Firmware usage */
 	status = "reserved";
 	pinctrl-names = "default";
@@ -249,6 +257,7 @@ &wkup_uart0 {
 };
 
 &wkup_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
@@ -268,6 +277,7 @@ &wkup_gpio0 {
 };
 
 &mcu_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
@@ -281,6 +291,7 @@ &mcu_i2c0 {
 };
 
 &main_uart8 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
@@ -307,6 +318,7 @@ exp1: gpio@21 {
 };
 
 &main_sdhci0 {
+	bootph-all;
 	/* eMMC */
 	status = "okay";
 	non-removable;
@@ -315,6 +327,7 @@ &main_sdhci0 {
 };
 
 &main_sdhci1 {
+	bootph-all;
 	/* SD card */
 	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-- 
2.34.1

