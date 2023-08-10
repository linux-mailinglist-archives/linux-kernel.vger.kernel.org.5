Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA4778090
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjHJSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjHJSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:43:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351926B7;
        Thu, 10 Aug 2023 11:43:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIhE6V130408;
        Thu, 10 Aug 2023 13:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691692994;
        bh=FLhchQ2m+WzhpqN55+mc2NN5USfwYopLY3T+X5JxIUA=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=sTE7JrDaD5DEyv3Ty3tM78q0N4Z288D35/AlD6uBkAJYHs2Ptbgfv/9ImYzlxBCvH
         oYxUAtwtdZDmnJ4Bi1s/JmREB0QZZizxUWCYitUukjXORPJ6exEVUm+seAqNEZ/rBd
         Nr5ImBr1SPySsCvLaO/QoZ7oRWDFXV6Rc9GaAim4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIhEs5031759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:43:14 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:43:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:43:13 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIh2P1025724;
        Thu, 10 Aug 2023 13:43:10 -0500
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
Subject: [PATCH v3 2/3] arm64: dts: ti: k3-j784s4-evm: Add bootph-all property
Date:   Fri, 11 Aug 2023 00:13:01 +0530
Message-ID: <20230810184302.3097829-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810184302.3097829-1-a-nandan@ti.com>
References: <20230810184302.3097829-1-a-nandan@ti.com>
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

Add bootph-all property for all the nodes that are used in SPL stage
along with later boot stages.

These bootph-all properties will be synced later to u-boot j784s4 dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index edc1009b2d1e..47d41d60e49a 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -252,7 +252,9 @@ vdd_sd_dv: regulator-TLV71033 {
 };
 
 &main_pmx0 {
+	bootph-all;
 	main_uart8_pins_default: main-uart8-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
 			J784S4_IOPAD(0x044, PIN_OUTPUT, 14) /* (AG37) MCASP0_AXR1.UART8_RTSn */
@@ -269,6 +271,7 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x104, PIN_INPUT, 0) /* (AB38) MMC1_CLK */
 			J784S4_IOPAD(0x108, PIN_INPUT, 0) /* (AB36) MMC1_CMD */
@@ -289,7 +292,9 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 };
 
 &wkup_pmx2 {
+	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
 			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
@@ -299,6 +304,7 @@ J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
@@ -306,6 +312,7 @@ J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (H37) WKUP_GPIO0_14.MCU_UART0_CTSn */
 			J784S4_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (K37) WKUP_GPIO0_15.MCU_UART0_RTSn */
@@ -366,7 +373,9 @@ J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 };
 
 &wkup_pmx0 {
+	bootph-all;
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
 			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
@@ -384,7 +393,9 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
 };
 
 &wkup_pmx1 {
+	bootph-all;
 	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
 			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
@@ -392,6 +403,7 @@ J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
 	};
 
 	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
 			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
@@ -406,6 +418,7 @@ J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
 };
 
 &wkup_uart0 {
+	bootph-all;
 	/* Firmware usage */
 	status = "reserved";
 	pinctrl-names = "default";
@@ -413,6 +426,7 @@ &wkup_uart0 {
 };
 
 &wkup_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
@@ -426,12 +440,14 @@ eeprom@50 {
 };
 
 &mcu_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart8 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
@@ -442,15 +458,18 @@ &ufs_wrapper {
 };
 
 &fss {
+	bootph-all;
 	status = "okay";
 };
 
 &ospi0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
 
 	flash@0 {
+		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -498,6 +517,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-all;
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
@@ -506,11 +526,13 @@ partition@3fc0000 {
 };
 
 &ospi1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
 	flash@0 {
+		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
@@ -558,6 +580,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-all;
 				label = "qspi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
@@ -602,6 +625,7 @@ exp2: gpio@22 {
 };
 
 &main_sdhci0 {
+	bootph-all;
 	/* eMMC */
 	status = "okay";
 	non-removable;
@@ -610,6 +634,7 @@ &main_sdhci0 {
 };
 
 &main_sdhci1 {
+	bootph-all;
 	/* SD card */
 	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-- 
2.34.1

