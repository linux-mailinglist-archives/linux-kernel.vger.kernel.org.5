Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2587CEF28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjJSFkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjJSFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:40:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64FA130;
        Wed, 18 Oct 2023 22:40:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J5eYeQ089725;
        Thu, 19 Oct 2023 00:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697694034;
        bh=OJwJczYEBzzPpNVwb8s8CngqmcOB5tHxnM+BVrR1Dqk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yqY6CULtb9LXw7Qa6vjfxQh3Pcgs7oiCTPqYWVWF2G8QxO99/HMNDzGTfwerKTyJe
         TvS13LCChSWJGN3BmVXZvx+C56bBoM6wLNO9guCh8DTWUnv0B5rG+cK82daoYVoBIi
         lBZhpl7EXle1lTmBeYTX+8L7tnCzmrIT7Lra0v/8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J5eYwi083628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 00:40:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 00:40:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 00:40:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J5eXCk020430;
        Thu, 19 Oct 2023 00:40:33 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <a-bhatia1@ti.com>,
        <rogerq@kernel.org>
CC:     <afd@ti.com>, <s-vadapalli@ti.com>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v12 5/5] arm64: dts: ti: k3-am69-sk: Add DP and HDMI support
Date:   Thu, 19 Oct 2023 11:10:22 +0530
Message-ID: <20231019054022.175163-6-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231019054022.175163-1-j-choudhary@ti.com>
References: <20231019054022.175163-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 starter kit features an HDMI port and an eDP port.

Add assigned clocks for DSS, DT node for DisplayPort PHY,
pinmux for HDMI hotplug and power down, mcu_i2c1 and dss_vout
for HDMI.
Also enable Serdes4 settings for DP display.

Add the endpoint nodes to describe connection from:
DSS => MHDP => DisplayPort connector
DSS => TI TFP410 DPI-to-DVI Bridge => HDMI connector

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
[j-choudhary@ti.com: Fix dvi-bridge, dss, mhdp and serdes-refclk]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 232 ++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index bc1d21ff6d03..9868c7049bfb 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -251,6 +251,76 @@ vdd_sd_dv: regulator-tlv71033 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	dp0_pwr_3v3: regulator-dp0-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "dp0-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_pwr_en_pins_default>;
+		gpio = <&main_gpio0 4 0>;	/* DP0_3V3 _EN */
+		enable-active-high;
+	};
+
+	dp0: connector-dp0 {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp0_pwr_3v3>;
+
+		port {
+			dp0_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
+
+	connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_pins_default>;
+		ddc-i2c-bus = <&mcu_i2c1>;
+		hpd-gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;	/* HDMI_HPD */
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_pdn_pins_default>;
+		powerdown-gpios = <&wkup_gpio0 14 GPIO_ACTIVE_LOW>;	/* HDMI_PDn */
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
+					remote-endpoint = <&dpi1_out0>;
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
@@ -308,6 +378,57 @@ J784S4_IOPAD(0x008, PIN_INPUT, 7) /* (AJ33) MCAN12_RX.GPIO0_2 */
 			J784S4_IOPAD(0x004, PIN_INPUT, 7) /* (AG36) MCAN12_TX.GPIO0_1 */
 		>;
 	};
+
+	dp0_pins_default: dp0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x014, PIN_INPUT, 13) /* (AG33) MCAN14_TX.DP0_HPD */
+		>;
+	};
+
+	dp_pwr_en_pins_default: dp-pwr-en-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x010, PIN_INPUT, 7) /* (AH33) MCAN13_RX.GPIO0_4 */
+		>;
+	};
+
+	dss_vout0_pins_default: dss-vout0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x074, PIN_OUTPUT, 2) /* (AC33) MCAN2_TX.VOUT0_DATA0 */
+			J784S4_IOPAD(0x070, PIN_OUTPUT, 2) /* (AH38) MCAN1_RX.VOUT0_DATA1 */
+			J784S4_IOPAD(0x07c, PIN_OUTPUT, 2) /* (AJ38) MCASP0_AXR3.VOUT0_DATA2 */
+			J784S4_IOPAD(0x068, PIN_OUTPUT, 2) /* (AE38) MCAN0_RX.VOUT0_DATA3 */
+			J784S4_IOPAD(0x064, PIN_OUTPUT, 2) /* (AF38) MCAN0_TX.VOUT0_DATA4 */
+			J784S4_IOPAD(0x060, PIN_OUTPUT, 2) /* (AE36) MCASP2_AXR1.VOUT0_DATA5 */
+			J784S4_IOPAD(0x05c, PIN_OUTPUT, 2) /* (AC36) MCASP2_AXR0.VOUT0_DATA6 */
+			J784S4_IOPAD(0x058, PIN_OUTPUT, 2) /* (AE37) MCASP2_AFSX.VOUT0_DATA7 */
+			J784S4_IOPAD(0x054, PIN_OUTPUT, 2) /* (AD37) MCASP2_ACLKX.VOUT0_DATA8 */
+			J784S4_IOPAD(0x050, PIN_OUTPUT, 2) /* (AC37) MCASP1_AXR2.VOUT0_DATA9 */
+			J784S4_IOPAD(0x04c, PIN_OUTPUT, 2) /* (AC32) MCASP1_AXR1.VOUT0_DATA10 */
+			J784S4_IOPAD(0x048, PIN_OUTPUT, 2) /* (AK33) MCASP0_AXR2.VOUT0_DATA11 */
+			J784S4_IOPAD(0x044, PIN_OUTPUT, 2) /* (AG37) MCASP0_AXR1.VOUT0_DATA12 */
+			J784S4_IOPAD(0x040, PIN_OUTPUT, 2) /* (AF37) MCASP0_AXR0.VOUT0_DATA13 */
+			J784S4_IOPAD(0x03c, PIN_OUTPUT, 2) /* (AK38) MCASP0_AFSX.VOUT0_DATA14 */
+			J784S4_IOPAD(0x038, PIN_OUTPUT, 2) /* (AK35) MCASP0_ACLKX.VOUT0_DATA15 */
+			J784S4_IOPAD(0x0c8, PIN_OUTPUT, 2) /* (AJ32) EXT_REFCLK1.VOUT0_DATA16 */
+			J784S4_IOPAD(0x030, PIN_OUTPUT, 2) /* (AK37) GPIO0_12.VOUT0_DATA17 */
+			J784S4_IOPAD(0x02c, PIN_OUTPUT, 2) /* (AL32) GPIO0_11.VOUT0_DATA18 */
+			J784S4_IOPAD(0x028, PIN_OUTPUT, 2) /* (AE33) MCAN16_RX.VOUT0_DATA19 */
+			J784S4_IOPAD(0x024, PIN_OUTPUT, 2) /* (AH34) MCAN16_TX.VOUT0_DATA20 */
+			J784S4_IOPAD(0x020, PIN_OUTPUT, 2) /* (AJ35) MCAN15_RX.VOUT0_DATA21 */
+			J784S4_IOPAD(0x01c, PIN_OUTPUT, 2) /* (AG34) MCAN15_TX.VOUT0_DATA22 */
+			J784S4_IOPAD(0x018, PIN_OUTPUT, 2) /* (AK36) MCAN14_RX.VOUT0_DATA23 */
+			J784S4_IOPAD(0x084, PIN_OUTPUT, 2) /* (AG38) MCASP0_AXR5.VOUT0_DE */
+			J784S4_IOPAD(0x080, PIN_OUTPUT, 2) /* (AK34) MCASP0_AXR4.VOUT0_HSYNC */
+			J784S4_IOPAD(0x078, PIN_OUTPUT, 2) /* (AH37) MCAN2_RX.VOUT0_PCLK */
+			J784S4_IOPAD(0x088, PIN_OUTPUT, 2) /* (AF36) MCASP0_AXR6.VOUT0_VSYNC */
+		>;
+	};
+
+	hdmi_hpd_pins_default: hdmi-hpd-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) EXTINTN.GPIO0_0 */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -382,6 +503,21 @@ J784S4_WKUP_IOPAD(0x064, PIN_INPUT, 7) /* (J36) WKUP_GPIO0_3 */
 			J784S4_WKUP_IOPAD(0x11c, PIN_INPUT, 7) /* (M34) WKUP_GPIO0_67 */
 		>;
 	};
+
+	mcu_i2c1_pins_default: mcu-i2c1-default-pins {
+		pinctrl-single,pins = <
+			/* (L35) WKUP_GPIO0_8.MCU_I2C1_SCL */
+			J784S4_WKUP_IOPAD(0x078, PIN_INPUT_PULLUP, 0)
+			/* (L34) WKUP_GPIO0_9.MCU_I2C1_SDA */
+			J784S4_WKUP_IOPAD(0x07c, PIN_INPUT_PULLUP, 0)
+		>;
+	};
+
+	hdmi_pdn_pins_default: hdmi-pdn-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 7) /* (H37) WKUP_GPIO0_14 */
+		>;
+	};
 };
 
 &wkup_pmx3 {
@@ -666,3 +802,99 @@ &c71_3 {
 	memory-region = <&c71_3_dma_memory_region>,
 			<&c71_3_memory_region>;
 };
+
+&wkup_gpio_intr {
+	status = "okay";
+};
+
+&mcu_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c1_pins_default>;
+	clock-frequency = <100000>;
+};
+
+&serdes_refclk {
+	status = "okay";
+	clock-frequency = <100000000>;
+};
+
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_vout0_pins_default>;
+	assigned-clocks = <&k3_clks 218 2>,
+			  <&k3_clks 218 5>,
+			  <&k3_clks 218 14>,
+			  <&k3_clks 218 18>;
+	assigned-clock-parents = <&k3_clks 218 3>,
+				 <&k3_clks 218 7>,
+				 <&k3_clks 218 16>,
+				 <&k3_clks 218 22>;
+};
+
+&serdes_wiz4 {
+	status = "okay";
+};
+
+&serdes4 {
+	status = "okay";
+	serdes4_dp_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <4>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
+			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
+	};
+};
+
+&mhdp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
+	phys = <&serdes4_dp_link>;
+	phy-names = "dpphy";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* DP */
+	port@0 {
+		reg = <0>;
+
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+
+	/* HDMI */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out0: endpoint {
+			remote-endpoint = <&tfp410_in>;
+		};
+	};
+};
+
+&dp0_ports {
+
+	port@0 {
+		reg = <0>;
+
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+
+		dp0_out: endpoint {
+			remote-endpoint = <&dp0_connector_in>;
+		};
+	};
+};
-- 
2.25.1

