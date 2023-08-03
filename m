Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B576E2E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjHCIYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjHCIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:24:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156137DA4;
        Thu,  3 Aug 2023 01:18:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3738I5GJ121786;
        Thu, 3 Aug 2023 03:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691050685;
        bh=FLZIfZxajI6mZ3PHxXWZxOPl85RK8oQS8cZPML2k/3Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=StDIZ+BhSDhv0JycnS3Wixa6hvfSxr3fajV5Su0OyAb6xNjRSqhsjVV8uWIERPzXk
         +j/8OXIJNikIqWjFBlbnxnIJKvPWuPdOlSBZ0qipoGETlAa/zZdzhQCtsOf/HNiZX6
         3qNts/4ASASDHL6k7uXUkh+ItdGKvUI81YID4e1Q=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3738I5wJ027270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 03:18:05 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 03:18:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 03:18:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3738I4SC012880;
        Thu, 3 Aug 2023 03:18:04 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support
Date:   Thu, 3 Aug 2023 13:48:00 +0530
Message-ID: <20230803081800.368582-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803081800.368582-1-j-choudhary@ti.com>
References: <20230803081800.368582-1-j-choudhary@ti.com>
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

AM68-SK has an HDMI port. The bridge used is TI-TFP410.
Add support to enable the connection:
DSS => TI TFP410 DPI-to-DVI Bridge => HDMI connector

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 21ad49cfa7ee..56caa4ee6554 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -122,6 +122,52 @@ transceiver4: can-phy3 {
 		#phy-cells = <0>;
 		max-bitrate = <5000000>;
 	};
+
+	connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_pins_default>;
+		ddc-i2c-bus = <&mcu_i2c1>;
+		/* HDMI_HPD */
+		hpd-gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	bridge-dvi {
+		compatible = "ti,tfp410";
+		/* HDMI_PDn */
+		powerdown-gpios = <&exp2 0 GPIO_ACTIVE_LOW>;
+		ti,deskew = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint {
+					remote-endpoint = <&dpi_out0>;
+					pclk-sample = <1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -202,6 +248,45 @@ J721S2_IOPAD(0x0cc, PIN_INPUT, 7) /* (AE27) SPI0_CS0.GPIO0_51 */
 			J721S2_IOPAD(0x08c, PIN_INPUT, 7) /* (T25) MCASP0_AXR7.GPIO0_35 */
 		>;
 	};
+
+	dss_vout0_pins_default: dss-vout0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x074, PIN_OUTPUT, 2) /* (R28) MCAN2_TX.VOUT0_DATA0 */
+			J721S2_IOPAD(0x070, PIN_OUTPUT, 2) /* (R27) MCAN1_RX.VOUT0_DATA1 */
+			J721S2_IOPAD(0x04c, PIN_OUTPUT, 2) /* (V27) MCASP1_AXR1.VOUT0_DATA10 */
+			J721S2_IOPAD(0x048, PIN_OUTPUT, 2) /* (AB27) MCASP0_AXR2.VOUT0_DATA11 */
+			J721S2_IOPAD(0x044, PIN_OUTPUT, 2) /* (Y26) MCASP0_AXR1.VOUT0_DATA12 */
+			J721S2_IOPAD(0x040, PIN_OUTPUT, 2) /* (AC28) MCASP0_AXR0.VOUT0_DATA13 */
+			J721S2_IOPAD(0x03c, PIN_OUTPUT, 2) /* (U27) MCASP0_AFSX.VOUT0_DATA14 */
+			J721S2_IOPAD(0x038, PIN_OUTPUT, 2) /* (AB28) MCASP0_ACLKX.VOUT0_DATA15 */
+			J721S2_IOPAD(0x0c8, PIN_OUTPUT, 2) /* (AD28) EXT_REFCLK1.VOUT0_DATA16 */
+			J721S2_IOPAD(0x030, PIN_OUTPUT, 2) /* (T26) GPIO0_12.VOUT0_DATA17 */
+			J721S2_IOPAD(0x02c, PIN_OUTPUT, 2) /* (V23) GPIO0_11.VOUT0_DATA18 */
+			J721S2_IOPAD(0x028, PIN_OUTPUT, 2) /* (AB24) MCAN16_RX.VOUT0_DATA19 */
+			J721S2_IOPAD(0x07c, PIN_OUTPUT, 2) /* (T27) MCASP0_AXR3.VOUT0_DATA2 */
+			J721S2_IOPAD(0x024, PIN_OUTPUT, 2) /* (Y28) MCAN16_TX.VOUT0_DATA20 */
+			J721S2_IOPAD(0x020, PIN_OUTPUT, 2) /* (AA23) MCAN15_RX.VOUT0_DATA21 */
+			J721S2_IOPAD(0x01c, PIN_OUTPUT, 2) /* (Y24) MCAN15_TX.VOUT0_DATA22 */
+			J721S2_IOPAD(0x018, PIN_OUTPUT, 2) /* (W23) MCAN14_RX.VOUT0_DATA23 */
+			J721S2_IOPAD(0x068, PIN_OUTPUT, 2) /* (U28) MCAN0_RX.VOUT0_DATA3 */
+			J721S2_IOPAD(0x064, PIN_OUTPUT, 2) /* (W28) MCAN0_TX.VOUT0_DATA4 */
+			J721S2_IOPAD(0x060, PIN_OUTPUT, 2) /* (AC27) MCASP2_AXR1.VOUT0_DATA5 */
+			J721S2_IOPAD(0x05c, PIN_OUTPUT, 2) /* (AA26) MCASP2_AXR0.VOUT0_DATA6 */
+			J721S2_IOPAD(0x058, PIN_OUTPUT, 2) /* (AA27) MCASP2_AFSX.VOUT0_DATA7 */
+			J721S2_IOPAD(0x054, PIN_OUTPUT, 2) /* (Y27) MCASP2_ACLKX.VOUT0_DATA8 */
+			J721S2_IOPAD(0x050, PIN_OUTPUT, 2) /* (W27) MCASP1_AXR2.VOUT0_DATA9 */
+			J721S2_IOPAD(0x084, PIN_OUTPUT, 2) /* (AA28) MCASP0_AXR5.VOUT0_DE */
+			J721S2_IOPAD(0x080, PIN_OUTPUT, 2) /* (U26) MCASP0_AXR4.VOUT0_HSYNC */
+			J721S2_IOPAD(0x078, PIN_OUTPUT, 2) /* (Y25) MCAN2_RX.VOUT0_PCLK */
+			J721S2_IOPAD(0x088, PIN_OUTPUT, 2) /* (AD27) MCASP0_AXR6.VOUT0_VP0_VSYNC */
+		>;
+	};
+
+	hdmi_hpd_pins_default: hdmi-hpd-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x000, PIN_INPUT, 7) /* (AG24) EXTINTN.GPIO0_0  */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -373,6 +458,23 @@ &mcu_i2c0 {
 	clock-frequency = <400000>;
 };
 
+&mcu_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c1_pins_default>;
+	/* i2c1 is used for DVI DDC, so we need to use 100kHz */
+	clock-frequency = <100000>;
+
+	exp2: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "HDMI_PDn","HDMI_LS_OE",
+				  "DP0_3V3_EN","eDP_ENABLE";
+	};
+};
+
 &main_sdhci0 {
 	/* Unused */
 	status = "disabled";
@@ -433,3 +535,39 @@ &main_mcan7 {
 	pinctrl-0 = <&main_mcan7_pins_default>;
 	phys = <&transceiver4>;
 };
+
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_vout0_pins_default>;
+	/*
+	 * These clock assignments are chosen to enable the following outputs:
+	 *
+	 * VP0 - DisplayPort SST
+	 * VP1 - DPI0
+	 * VP2 - DSI
+	 * VP3 - DPI1
+	 */
+	assigned-clocks = <&k3_clks 158 2>,
+			  <&k3_clks 158 5>,
+			  <&k3_clks 158 14>,
+			  <&k3_clks 158 18>;
+	assigned-clock-parents = <&k3_clks 158 3>,
+				 <&k3_clks 158 7>,
+				 <&k3_clks 158 16>,
+				 <&k3_clks 158 22>;
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* HDMI */
+	port@1 {
+		reg = <1>;
+
+		dpi_out0: endpoint {
+			remote-endpoint = <&tfp410_in>;
+		};
+	};
+};
-- 
2.25.1

