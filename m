Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A691875C7A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGUNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjGUNVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:21:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A023A99;
        Fri, 21 Jul 2023 06:21:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36LDKcoe067589;
        Fri, 21 Jul 2023 08:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689945638;
        bh=pZDURQKtcBx1w8wrYyx1ZyTb+OFUyAyb4ftIUwDqyfI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VLF+RYGECuxa5pbiZMrOpjqp3a1dMA7SpZLDFlpSJdKlTPERPhBoq2L6iQVnZqysW
         sVfErvfqHXgZ2HOGTjlGHawuBxcxy7KZfvEiEIvrf085EYGUvxo9aZV+ew2Zj3oLyl
         AgkJDkV6NG5U+Yh4s0zl5wi5DN+TauH/FhFRGx/o=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36LDKcDr022862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 08:20:38 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jul 2023 08:20:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jul 2023 08:20:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36LDKb56024714;
        Fri, 21 Jul 2023 08:20:37 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <s-vadapalli@ti.com>, <a-bhatia1@ti.com>,
        <r-ravikumar@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v6 5/5] arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0
Date:   Fri, 21 Jul 2023 18:50:29 +0530
Message-ID: <20230721132029.123881-6-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721132029.123881-1-j-choudhary@ti.com>
References: <20230721132029.123881-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul T R <r-ravikumar@ti.com>

Enable display for J784S4 EVM.

Add assigned clocks for DSS, DT node for DisplayPort PHY and pinmux for
DP HPD. Add the clock frequency for serdes_refclk.

Add the endpoint nodes to describe connection from:
DSS => MHDP => DisplayPort connector.

Also add the GPIO expander-4 node and pinmux for main_i2c4 which is
required for controlling DP power. Set status for all required nodes
for DP-0 as "okay".

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
[j-choudhary@ti.com: move all the changes together to enable DP-0 in EVM]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 117 +++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 1e2a26ac9c65..12d032b41bf0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -249,6 +249,28 @@ vdd_sd_dv: regulator-TLV71033 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	dp0_pwr_3v3: regulator-dp0-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp0-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	dp0: dp0-connector {
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
 };
 
 &main_pmx0 {
@@ -310,6 +332,19 @@ vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 		>;
 	};
+
+	dp0_pins_default: dp0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0cc, PIN_INPUT, 12) /* (AM37) SPI0_CS0.DP0_HPD */
+		>;
+	};
+
+	main_i2c4_pins_default: main-i2c4-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
+			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -875,3 +910,85 @@ &main_cpsw1_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&main_phy0>;
 };
+
+&serdes_refclk {
+	status = "okay";
+	clock-frequency = <100000000>;
+};
+
+&dss {
+	status = "okay";
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
+	port {
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+};
+
+&main_i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <400000>;
+
+	exp4: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&dp0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp0_connector_in>;
+		};
+	};
+};
-- 
2.25.1

