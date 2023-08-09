Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A9776915
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjHITr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjHITrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:47:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937F2108;
        Wed,  9 Aug 2023 12:47:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl4MH086096;
        Wed, 9 Aug 2023 14:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691610424;
        bh=VB+r5z/W4Lii6r8oAhIOL+FU2R1kBLQG0ya0jHBEvqo=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=BmvMDoMbrm7T9OErrushRI3WeMZeOgH0a3zUU5lA4FPVpR+e3rNoRmW2LZgVCEKFC
         OegnVm7XhU4tkAImP0n49/6Ug3bVdMZ6X8+w/aCdT29TPDi0s96ZMTJgKmwTpQQy48
         JCMg55Mhvsj9jlkbasZu4U4KqtgJJjS6KdSlMSnI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Jl4uH032322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:47:04 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:47:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:47:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl3wV065302;
        Wed, 9 Aug 2023 14:47:03 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 10 Aug 2023 01:16:24 +0530
Subject: [PATCH v6 6/7] arm64: dts: ti: k3-am62a7-sk: Add support for
 TPS6593 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230810-tps6594-v6-6-2b2e2399e2ef@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=9kPfYgmoW8UezAiz/SVq0i+GIR4xFjfYwAcDxuvSWTU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk0+0zYKTlEL1CDDWVt0zWsjeYIJkHGG61cjbVk
 WOGlAIYYaqJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNPtMwAKCRBD3pH5JJpx
 RVDdD/4u78YxoHpO5m6eZLEcHcxXzM7zNsPVhuQ6Gq9s15G+AdEGIsGlnLmuydruGPoXKIMAf00
 iwX17TVzzymQVw8ij/3cyObRdpSa1c6hDkGp573PYpN0LP0jJu4EIRG8gTg4G5qH/IPuR9fmvv7
 6zfr5N3fj2u5IzwTjh1TcWYxmuW5c+lP7jUasNbPgnf1Bmshp7wAq/Y7U7QapvA+rdzIvn4NdU1
 yxT4QzGX+anYKczLIDaDMU70vw5ZJU43Zfi0+p7nwQmQWqrMCM77q4EAEoXqONXpQVm5OYFfzth
 471LauanBulhmp0TNVYNkHV4npBZWhIScsm/TyAWcvjNU6IeHFs7vvSeu5s4zGwc1WQy8fw5GqT
 wy13ypP1kTL07mlU/6aKaeq9P3YD3sJPqjXiPbaZEPVMXIkj34ghXHH5m4vjIqX4gzUfBX2mcZC
 KXJBbzXovfDDZ3FYR6xyVWKwBtAnRVbIc9ZVnJ+D4mfpl77nHs8fbdy+lDBjAojztQGSDOgtXsl
 5dOM5s7LKqWbbPZ3yKIptEZPKRD3Sx7/Cy/TwS53IwjTRGLhxOEfUM21dfxurqP5Y5VOMahB+ut
 7LEzpbnA+JgPDvnJX/qLZMYd0QdLZyiSWaLnZ+nZCiQLL+KsXwkEYXcs9zNBlQTajaxCVdmTsp6
 F9+VaX22ys/R3Pw==
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
index cff283c75f8e..2616acab8c0e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -221,6 +221,20 @@ AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
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

