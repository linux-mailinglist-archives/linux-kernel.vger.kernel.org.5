Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D180A2A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573624AbjLHLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjLHLuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:50:04 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD689198C;
        Fri,  8 Dec 2023 03:49:57 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B8BnqMS032102;
        Fri, 8 Dec 2023 05:49:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702036192;
        bh=aorlw7q/8CKBF4RcNluxucTHfYZ4j4qeFpE43ZjmI5Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sY+PzUGTFLunncXDOSRWWlSYtOFkqHFiu7lJgcP7EUGPZTR/IqhBawK6G94SJknjD
         0EZZoP2Ts0RatBPj/tEfR1pIZGHJR7JABNKsvrlLrw/uCgs0NDf5Wwt1o5R9DEw8Dj
         UW1Cf6SQRU0zcePEPbdTBvSZGS3ijuyq2OXC39DU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B8Bnq8x034147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Dec 2023 05:49:52 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Dec 2023 05:49:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Dec 2023 05:49:51 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B8BnJPQ085375;
        Fri, 8 Dec 2023 05:49:47 -0600
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
        <devarsht@ti.com>, <n-francis@ti.com>
Subject: [PATCH v10 5/7] arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC
Date:   Fri, 8 Dec 2023 17:19:17 +0530
Message-ID: <20231208114919.3429562-6-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208114919.3429562-1-n-francis@ti.com>
References: <20231208114919.3429562-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for TPS6594 PMIC on wkup I2C0 bus. This device
provides regulators (bucks and LDOs), but also GPIOs, a RTC, a watchdog,
an ESM (Error Signal Monitor) which monitors the SoC error output
signal, and a PFSM (Pre-configurable Finite State Machine) which manages
the operational modes of the PMIC.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 94 +++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index d6a7ae086244..8da591579868 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -433,6 +433,13 @@ J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) EXTINTN.GPIO0_0 */
 
 &wkup_pmx2 {
 	bootph-all;
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			/* (AA37) MCU_ADC1_AIN4.WKUP_GPIO0_83 */
+			J784S4_WKUP_IOPAD(0x0fc, PIN_INPUT, 7)
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -631,6 +638,93 @@ eeprom@51 {
 		compatible = "atmel,24c512";
 		reg = <0x51>;
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
+		gpio-controller;
+		#gpio-cells = <2>;
+		ti,primary-pmic;
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
 
 &wkup_gpio0 {
-- 
2.34.1

