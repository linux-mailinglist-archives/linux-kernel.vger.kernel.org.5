Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA70776913
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjHITrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHITrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:47:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472A2100;
        Wed,  9 Aug 2023 12:47:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl1JI011922;
        Wed, 9 Aug 2023 14:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691610421;
        bh=7088h8X7s0covVaq45Tpol1RjrF9Tnavd64QUD8UpnQ=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=TEjpWaFQrQDHtJ/a+N6Q3htNwX4ZUVxNHWftq0MPG4AcAAGbuuczRBJt0P09TeN30
         IPQxhvK+OZCJbbqwXzVz06h3pBbJJsZPp7g4LuoMefyvKyjzxLlcL5blJ9nZ1IMNYf
         Q4m/nBqPL7kBknpDEVERMZv2iXF7QjDKKe82MZJM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Jl1ia032227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:47:01 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:46:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:46:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Jkx9J050920;
        Wed, 9 Aug 2023 14:46:59 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 10 Aug 2023 01:16:21 +0530
Subject: [PATCH v6 3/7] arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family
 PMICs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230810-tps6594-v6-3-2b2e2399e2ef@ti.com>
References: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
In-Reply-To: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Hari Nagalla <hnagalla@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5390; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=6ytm+I/61w+Cti00xxMFIg2KdbZYmvKL4QcyqU6u35s=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk0+0vpEUVKqyXFl2Ea8bz6sTNT1Kz5fbmxUbCM
 C3z7jHenmCJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNPtLwAKCRBD3pH5JJpx
 RaSpD/9ZW1fJczTYS5slQX7xSU/hkE138uYPvBkYfK9pODSx1NJDhXSx9dwrIyLJyuH+A3Lq1yl
 J1yt+Qb/7MvZ0imJ8p+owZydQBHvfDSHYzyvO+AKNwFrr8sqKJT51MW+lXWuaXBDNTMROeNCo0z
 cQRN+Zgc7wZIr+IQakqdZKk8Osa6hVY9c+eGw2EyFVV/MT5f3uw5Wm5Dx0vt79RN+sLYKsXenix
 Fj1ASxuECIFgGp0Q04RPuaN/tEaxb4MXUF7e6aB1ETg/Uomi8MYZvJGA3LDao0rTOjh1So6dfnm
 m6aZvZrZ3hj3JMO7N8O6t2J7e+5nHuvYvoIhXefvNW7IG0fmKtcf48XdS/AHmh4x3kBKzNMPNDd
 zs6qnlxhMx2rRf5zKK1NEzxH7faVEU5iPeMirKhlrnEUeWoCu1Tl5FXKV4+yifGpTM0l7XP60pp
 PuIQssf8rf3FShSPRBC9FKgMHwm0qdln+y85Z36fjmavPZacF2ipWEiwBYPS9//mJ1u0vSAYUWD
 BTzvULDt/ENg8Zr38BBbV93VbCH1bsMEjqZJJZ/+fggqtluzDX0OUpkcrbtjnkqJramigmY/25o
 wyhcpUh+AI/GraeGo/hC+jEqasKilo3jY9yOI5zFzJqndbLDqctm61+KXXE8iooNBJ7vXjUxr/R
 s6uFz2kUA0Yycpw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Neanne <jneanne@baylibre.com>

This patch adds support for TPS6594 PMIC family on wakup I2C0 bus.
Theses devices provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 163 ++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e90e43202546..21f350cd9a45 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -152,6 +152,12 @@ J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
 	};
 
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0d4, PIN_INPUT, 7) /* (G26) WKUP_GPIO0_9 */
+		>;
+	};
+
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
@@ -199,6 +205,163 @@ eeprom@50 {
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
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
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
+				regulator-name = "vdd_cpu_avs";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3: buck3 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka4: buck4 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka5: buck5 {
+				regulator-name = "vdd_phyio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1: ldo1 {
+				regulator-name = "vdd1_lpddr4_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2: ldo2 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3: ldo3 {
+				regulator-name = "vdda_dll_0v8";
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
+
+	tps659411: pmic@4c {
+		compatible = "ti,tps6594-q1";
+		reg = <0x4c>;
+		system-power-controller;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck1234-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			buckb1234: buck1234 {
+				regulator-name = "vdd_core_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb5: buck5 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob1: ldo1 {
+				regulator-name = "vdd_sd_dv";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob2: ldo2 {
+				regulator-name = "vdd_usb_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob3: ldo3 {
+				regulator-name = "vdd_io_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob4: ldo4 {
+				regulator-name = "vda_pll_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &ospi0 {

-- 
2.41.0

