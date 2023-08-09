Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7247762F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjHIOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjHIOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:48:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F55210C;
        Wed,  9 Aug 2023 07:48:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379ElwnA018297;
        Wed, 9 Aug 2023 09:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691592478;
        bh=5AszA36xVEfKOvD4+ewUOX1iGQ1kgAmMCYkyvxLmuY4=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=R7pouKHBIEtW1TCEBt1gRl3qRbYvb3L25/gMwwtPz+KkOfO+NAOFHB8DlydeMWcfz
         YKC0DZIvyXzw5Lo5bHlaDxje57m8Yt8WQg1lcXoNBUxKW2p6PmkLFFTXEOcFhgxHp8
         9DKcf9TPSUygbBwvKT1Hf2FSPQxYnot1sGHdlI24=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Elw8x022968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 09:47:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 09:47:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 09:47:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379ElvG9030809;
        Wed, 9 Aug 2023 09:47:58 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 9 Aug 2023 20:17:07 +0530
Subject: [PATCH v5 6/6] arm64: dts: ti: k3-am62a7-sk: Add support for
 TPS6593 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230809-tps6594-v5-6-485fd3d63670@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=QrE/y89VoIsfeJV7G4YIq5vjUnmA2ManvidYaXOX+nE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk06cafRk4dvI5qWv0PmcU9KoWwc+48B/8GQB9E
 XSTv2nSCvGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNOnGgAKCRBD3pH5JJpx
 RdQYD/9O79DvwbiqSS+nh1JKACuq6r+OIVgHQy4R89nB0gSsYgEVgpbpVMEw23X+KRxlpA7finX
 eokP5xbEUpWmBUZ2dfMGsMkuzTJEZ6zY6PDQxuojch+bDlCOtTmARqXKCHXVTb7J6G1wAlMi3lC
 NcFrLuVeSLQxZ8RY4AUGcW9YiWkPX1JPbRwd7M86MTWnrKAQOPdKiSBK9D9ka8b1H4ChFAnQe1n
 MUtZ8ctC4KTDO7P2/dIMQGqp/3OgStQcXEuh7iUsyjMSRe5EvZLE/twPTO/AKLXA2VhYTQVlnam
 +9d09QV3Ht4dMDZ5Ua7ZEhtVbYggd8vwxce4UtlyYBKwkHFY+jOyvRUWbLxJ/OSMLcPQnIejPlc
 aPRPg9ZfddmsZCCpU7/TrWgW2Z7kvrTAWHgGhqbSvMhGMj2L1MfZ+5WSwe0X7Br/Fe+I9cBiN5d
 rw1M6GF9I//zie75iM93baaDnB+TjmqpN88gg+pSyHwCMFvRl+2XiMEyNOG53KmuNruNrGyMbX3
 hfMa6f5gxLrmEJ18sFDQ/H7ufKmSn2ERZig/w/Y7OJW5zEPX0e/wpv/9apuiWQgZPOTkVCqoc0q
 5ZSV7qK35thdAo/52ont1pMn9ux0NXl5Qu95stXm5MVyL0fX54XczdnTlQiuuarVFd0fwh6fp5r
 hulroFFOUDD9UKg==
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

From: Julien Panis <jpanis@baylibre.com>

This patch adds support for TPS6593 PMIC on main I2C0 bus.
This device provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 95 +++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index cff283c75f8e..abc77759c1a0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -221,6 +221,20 @@ AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
 	};
 };
 
+&mcu_pmx0 {
+	status = "okay";
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
+		>;
+	};
+};
+
+&mcu_gpio0 {
+	status = "okay";
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -244,6 +258,87 @@ usb_con_hs: endpoint {
 			};
 		};
 	};
+
+	tps659312: pmic@48 {
+		compatible = "ti,tps6593-q1";
+		reg = <0x48>;
+		ti,primary-pmic;
+		system-power-controller;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+		buck123-supply = <&vcc_3v3_sys>;
+		buck4-supply = <&vcc_3v3_sys>;
+		buck5-supply = <&vcc_3v3_sys>;
+		ldo1-supply = <&vcc_3v3_sys>;
+		ldo2-supply = <&vcc_3v3_sys>;
+		ldo3-supply = <&buck5>;
+		ldo4-supply = <&vcc_3v3_sys>;
+
+		regulators {
+			buck123: buck123 {
+				regulator-name = "vcc_core";
+				regulator-min-microvolt = <715000>;
+				regulator-max-microvolt = <895000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: buck4 {
+				regulator-name = "vcc_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: buck5 {
+				regulator-name = "vcc_1v8_sys";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: ldo1 {
+				regulator-name = "vddshv5_sdio";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: ldo2 {
+				regulator-name = "vpp_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: ldo3 {
+				regulator-name = "vcc_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: ldo4 {
+				regulator-name = "vdda_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &main_i2c1 {

-- 
2.41.0

