Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085D77F274
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349110AbjHQIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349104AbjHQItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:49:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1BB173F;
        Thu, 17 Aug 2023 01:49:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37H8nd45027168;
        Thu, 17 Aug 2023 03:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692262179;
        bh=9/1zVkt0Uc4647JH/xL2/pdUKVhgKbsLyxCL+xVTvzo=;
        h=From:To:CC:Subject:Date;
        b=NufiTqkTFRKt0tuAwaKyErN5QvuUulj7Ye4U0zWhF2amMwnqT2YgDhj3Z5F0DvSBx
         J9dbVOOmQZBEtIwSlJJEbA9krX8loiVJ0J98Kb59WREv8LQZUYPOobbWidzMtGvY0R
         /WtNtiHPcKaXLBBGUyOH//IrKYAgAhymCKDnB7SY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37H8ndHT018959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 03:49:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 03:49:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 03:49:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37H8nbpU029220;
        Thu, 17 Aug 2023 03:49:37 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <b-kapoor@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Add support for MCAN interfaces
Date:   Thu, 17 Aug 2023 14:19:36 +0530
Message-ID: <20230817084936.31020-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.39.2
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

There are 2 MCAN instances in the mcu domain and 4 MCAN instances in the
main domain. Add support for both MCAN nodes present in the mcu domain
and MCAN16 that is present in the main domain and isn't muxed.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Changelog v1->v2:
 - Fixed issue with referencing mcu_mcan0 node that was causeing errors

Link to v1 : https://lore.kernel.org/all/20230816193533.25722-1-b-kapoor@ti.com/

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 430b8a2c5df5..9fce3ce89507 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -249,6 +249,31 @@ vdd_sd_dv: regulator-TLV71033 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 69 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver3: can-phy2 {
+		/* standby pin has been grounded by default */
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
 };
 
 &main_pmx0 {
@@ -286,6 +311,13 @@ vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 		>;
 	};
+
+	main_mcan16_pins_default: main-mcan16-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x028, PIN_INPUT, 0) /* (AE33) MCAN16_RX */
+			J784S4_IOPAD(0x024, PIN_OUTPUT, 0) /* (AH34) MCAN16_TX */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -363,6 +395,32 @@ J784S4_WKUP_IOPAD(0x16c, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
 			J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (K33) MCU_MCAN0_TX */
+			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (F38) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
+			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x040, PIN_INPUT, 7) /* (J38) MCU_SPI0_D1.WKUP_GPIO0_69 */
+		>;
+	};
+
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (J35) WKUP_GPIO0_2 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -827,3 +885,32 @@ adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
+
+&wkup_gpio_intr {
+	status = "okay";
+};
+
+&wkup_gpio0 {
+	status = "okay";
+};
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan16 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan16_pins_default>;
+	phys = <&transceiver3>;
+};
-- 
2.39.2

