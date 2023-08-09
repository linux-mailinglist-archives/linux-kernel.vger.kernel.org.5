Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D87762F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjHIOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjHIOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:48:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E792109;
        Wed,  9 Aug 2023 07:48:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379ElvTd075458;
        Wed, 9 Aug 2023 09:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691592477;
        bh=FA4/N3BPMi47AegHjOawBnnPBdpcUKxkN36L5vwxAvU=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Kgrm3EMYNj4iznfrFoS4AzovBqo7bx5K/xGqMYX6Hocp6yGfyHJPM3s6LBPE/KHvR
         kGZV73FYyI47CaeEKWxSI0gyc5QsyCKXXHf38+YrrPAIYJddNrV2lvmp46GS5RTMlW
         KEqCtMIgilNutsPXJanflaGomlgqg4CiKSO7jvnE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Elv9t110085
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 09:47:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 09:47:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 09:47:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Eluv1036926;
        Wed, 9 Aug 2023 09:47:56 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 9 Aug 2023 20:17:06 +0530
Subject: [PATCH v5 5/6] arm64: dts: ti: k3-j784s4-evm: Add support for
 TPS6594 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230809-tps6594-v5-5-485fd3d63670@ti.com>
References: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
In-Reply-To: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=pRH7YiPIujR0yk9CVapeYTQXzr7FSA9cyHUS4NHsk0g=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk06cZ3mmWSeUKV3fOQJ7QfcOXccwSzv9dVdu/S
 Ztp1zOoD7iJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNOnGQAKCRBD3pH5JJpx
 RQCRD/948sKbev5h4IbMjxsfSv8VPjbGepUIdw0AbX2JF7ZMZrnuPrrg3LW49MC9n9/TZqnnJSf
 aLp3MtZQqKB8kjScWADAoGh7u56UqDPeGbCuZg0tvGTwbKZ9KRg0IfJAeheNPydBOO6aqA5pmUj
 M6UlthjES6JmPuB68h4wakEBfe2LlUhTUoyM8E6O+nxD82R72KDhCrDhJLpq2UxfDlZGsNHquBJ
 Eohymyemgl2cWiVIrX+8Alc0+io1oDbDforjdNcEik5snav6f44ZXVqB1WC/u5A5TrOzlxvb+Uw
 NDarTNgq6YnmvDx1MpQ/Ds78NekkbYbfWGh2TGCIr1CoNPWBBHsuYGu6TUhzMPibUDnndu7DhMP
 qME0dB1NRq1uiMwe5soUIkSbdE4pfTpFnSmUiPLT8SLnlY+MWn3Vtbx2JXdrk1GkJlnio7P0sgc
 V78WZzM8w3reDIIiAAzZ5FH5NZCyAP/rSbZwU5fT6tRnAcNmOq8xilnXyXFb9ov1d7AjbznZ3mB
 kAj+WoxEENrNivJYKy4QRIGpdcGplJZgUEGv9x2/BGJDcij58jDfbsfN+SpWzdLSFempbQd3F7n
 y7lPHAyz5nveNuRll4mZ7MZD0oPXhBS18zVPx8P0r5X2/bSdsUXa35Snkj5r20mW4tM+1td27ud
 FgLfiwewCN3maGg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
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

From: Jerome Neanne <jneanne@baylibre.com>

This patch adds support for TPS6593 PMIC on wkup I2C0 bus.
This device provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 104 +++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index edc1009b2d1e..0dee14d4620e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -251,6 +251,10 @@ vdd_sd_dv: regulator-TLV71033 {
 	};
 };
 
+&wkup_gpio0 {
+	status = "okay";
+};
+
 &main_pmx0 {
 	main_uart8_pins_default: main-uart8-default-pins {
 		pinctrl-single,pins = <
@@ -365,6 +369,17 @@ J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 	};
 };
 
+&wkup_pmx1 {
+	status = "okay";
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
+		>;
+	};
+};
+
 &wkup_pmx0 {
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
@@ -423,6 +438,95 @@ eeprom@50 {
 		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
+
+	tps659413: pmic@48 {
+		compatible = "ti,tps6594-q1";
+		reg = <0x48>;
+		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		ti,primary-pmic;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck12-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			bucka12: buck12 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3: buck3 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka4: buck4 {
+				regulator-name = "vdd_io_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka5: buck5 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1: ldo1 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2: ldo2 {
+				regulator-name = "vdd_mcuio_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3: ldo3 {
+				regulator-name = "vds_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4: ldo4 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &mcu_uart0 {

-- 
2.41.0

