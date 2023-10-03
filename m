Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E967B6515
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbjJCJMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbjJCJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:12:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07932AB;
        Tue,  3 Oct 2023 02:12:07 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3939Bvmo023098;
        Tue, 3 Oct 2023 04:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696324317;
        bh=THpNGIXD7z+n0ObTIdk4Tqnh5fvfLcLedV5S/VNCL18=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=WNbPW+n/ru9S54/xlRqC8kmB0+GL7T/niKB4Q47TOXWiAvh2oMKjtege1RdWdKqCk
         iepR68uu+ZAAfKFH/Jwk54fykVJ9syYB6EQc3Nw2fMMBSJxRoe+mnb4y/8AuneHWqi
         mXpd9BKB8nRb5U2ffK0dVNnRtlRlKnzKHYLzRrzA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3939BvBc034717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 04:11:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 04:11:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 04:11:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3939BuqB021429;
        Tue, 3 Oct 2023 04:11:56 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 3 Oct 2023 14:41:33 +0530
Subject: [PATCH v3 4/6] arm64: dts: ti: k3-am62a7-sk: Add support for
 TPS6593 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231003-mcasp_am62a-v3-4-2b631ff319ca@ti.com>
References: <20231003-mcasp_am62a-v3-0-2b631ff319ca@ti.com>
In-Reply-To: <20231003-mcasp_am62a-v3-0-2b631ff319ca@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=NG7CqYlIdoR8vAY96Pg9KSVZ+tMqM4J5Aya65nAaIic=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlG9rQ8gmDP8CuOTVqmB6M4NWqH5UxXf4TMY3PU
 OT34Sm86OeJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZRva0AAKCRBD3pH5JJpx
 RUEPEADGLHS6u7cn2GVibdFvSQo5D7OEwFoGHXggSF0XLb/x2fVDZhGRJRntOhWYDAPUyfUN0wA
 rHbHEFnhKw5gSuR7RhehoIIDqEgdVkRJCRHsF390jxxwvfS5v5J1KV+Gvmmg4rFLcaOdtrWLnOF
 87ZtwNkbS/4LZu24LKLeQ+EyqfYagZm6k8SlkcT0Qnldw1o9QvqsmAG+G4GvUlIV5zl3L1ZdmCb
 SbCmONVosQN7bFh52hrGqBt/qwep2lThmJTBi7vt9KNVDL+XAJDm0P7ZgS3VQUCU4fckI6qyyaL
 oH6Diz4c+vF2kpKdC3nMC+jPKzH0nY58CAmW3PWJQCmc1RkelkLzYcnA18nF9v/tvgIiV//NIXR
 IFyJ8FLUEzscqWhIaLsK4M48z1pHa18iqNMQqgS+CC73RmHYQMIAKRWC9MEliupWPqXKMUfByMZ
 NMotCC5kGTV7Vzm7guJfJUBy8UZ5PYUrg0cnSG5gXCj+RNN5veAYk9UsVRTtvV6LNP3EJllQfE4
 phcgvvLPJY6GpOoPZIhRYbSmS86BWhnHnlkEvDPfT+wD+XzlQBfO20U9FxoqrKPCTt0pBhuoFzP
 92VR9uza7yC63KeODTuSpaJc+HSybX91SW2ZXxOwFf2A4+j6tPSRiEvELJUq6nNQEbZSDZwTSh2
 qwpCEjVvAhs8n7A==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
index 866b2725f775..377ab823bbcc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -232,6 +232,20 @@ AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
 	};
 };
 
+&mcu_pmx0 {
+	status = "okay";
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
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
@@ -255,6 +269,87 @@ usb_con_hs: endpoint {
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
2.42.0

