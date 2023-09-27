Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B967AFB43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0Gnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjI0Gnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:43:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2277A3;
        Tue, 26 Sep 2023 23:43:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R51XU1010592;
        Wed, 27 Sep 2023 06:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=kjMPjJO5S/jM/ruXD2zMcv5MymD4dubVz8mz75OjG+c=;
 b=UCXQ/BSEqx8yz4H/RUZBrCb++RZopdkUcKB8V2PJbOJMI8TBfiKPnKSsEVVfG/lMiuT4
 ZxoNztO9tW9FRIgVzypYNp89IUQa6GvPddeSf7yan7zRdkfh+IzQQDIdRy4csao85nv/
 60LSzynfYOPUIG3cmf02KEdlUM6dqfRCfa2jdIxjGijiCB2RJ9Ekzs76PlOG/nb6bqg9
 EMucImy9PFjE1Fc3VNVpvx8TFx0zI42WybHImhHVzYtoyWpzT3/bNV5FflRZsfprq4U4
 nb/UuY34r8eiXZYJTgC9mYgLoY9YQgmzPPQ1lrczJ3fA/l9zbW+pJQxCPOTX+BnYMJhZ yg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc8v48kh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:43:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6hYRl031675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:43:34 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 23:43:30 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 27 Sep 2023 12:13:18 +0530
Subject: [PATCH v3 1/2] arm64: dts: qcom: ipq9574: Add common RDP dtsi file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230927-common-rdp-v3-1-3d07b3ff6d42@quicinc.com>
References: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
In-Reply-To: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695797006; l=14762;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=5q3+uY+HfjMpVimtH+bsMbJiaGbrHdqJJyvUiqzOJCA=;
 b=tT8HaVxjFohBSc7sSolWNiCaIJCAyaEqSz2+hyDSD04JhuQYQs9shh4LeE85QyA8iiPlhC1Cw
 SZoC2FHYbMpCodK0KY9wnX/EsGr6PlrVG1HWF8Bb0JMgtrx2+JrhWa5
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: isbRpJsGYnV7U0zVF2Yk0Ap3HT_XPRG2
X-Proofpoint-ORIG-GUID: isbRpJsGYnV7U0zVF2Yk0Ap3HT_XPRG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=833 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anusha Rao <quic_anusha@quicinc.com>

Add a dtsi file to include interfaces that are common
across RDPs.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 Changes in V3:
	- Fixed the indentation issue in TLMM node

 Changes in V2:
	- RDP418 and RDP433 supports shdc. Removed sdhc related nodes
	  from common dtsi and added to corresponding rdp dts.
	- Moved USB and regulator related nodes to common.dtsi.
	- Updated rdp454 dts to use common.dtsi.
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 125 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts      |  63 +-----------
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts      |  91 +----------------
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts      |  65 +-----------
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts      |  65 +-----------
 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts      |  66 +-----------
 6 files changed, 130 insertions(+), 345 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
new file mode 100644
index 000000000000..40a7aefd0540
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP board common device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	regulator_fixed_3p3: s3300 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-name = "fixed_3p3";
+	};
+
+	regulator_fixed_0p925: s0925 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <925000>;
+		regulator-max-microvolt = <925000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-name = "fixed_0p925";
+	};
+};
+
+&blsp1_spi0 {
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&blsp1_uart2 {
+	pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-mp5496-regulators";
+
+		ipq9574_s1: s1 {
+		/*
+		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
+		 * During regulator registration, kernel not knowing the initial voltage,
+		 * considers it as zero and brings up the regulators with minimum supported voltage.
+		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
+		 * the regulators are brought up with 725mV which is sufficient for all the
+		 * corner parts to operate at 800MHz
+		 */
+			regulator-min-microvolt = <725000>;
+			regulator-max-microvolt = <1075000>;
+		};
+
+		mp5496_l2: l2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&tlmm {
+	spi_0_pins: spi-0-state {
+		pins = "gpio11", "gpio12", "gpio13", "gpio14";
+		function = "blsp0_spi";
+		drive-strength = <8>;
+		bias-disable;
+	};
+};
+
+&usb_0_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_0_qmpphy {
+	vdda-pll-supply = <&mp5496_l2>;
+	vdda-phy-supply = <&regulator_fixed_0p925>;
+
+	status = "okay";
+};
+
+&usb_0_qusbphy {
+	vdd-supply = <&regulator_fixed_0p925>;
+	vdda-pll-supply = <&mp5496_l2>;
+	vdda-phy-dpdm-supply = <&regulator_fixed_3p3>;
+
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
index 2b093e02637b..f4f9199d4ab1 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
@@ -8,58 +8,12 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C2";
 	compatible = "qcom,ipq9574-ap-al02-c2", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
 };
 
 &sdhc_1 {
@@ -74,10 +28,6 @@ &sdhc_1 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &tlmm {
 	sdc_default_state: sdc-default-state {
 		clk-pins {
@@ -110,15 +60,4 @@ rclk-pins {
 			bias-pull-down;
 		};
 	};
-
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 877026ccc6e2..1bb8d96c9a82 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -8,69 +8,11 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
 	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
-
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	regulator_fixed_3p3: s3300 {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-name = "fixed_3p3";
-	};
-
-	regulator_fixed_0p925: s0925 {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <925000>;
-		regulator-max-microvolt = <925000>;
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-name = "fixed_0p925";
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-
-		mp5496_l2: l2 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-	};
 };
 
 &sdhc_1 {
@@ -85,10 +27,6 @@ &sdhc_1 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &tlmm {
 	sdc_default_state: sdc-default-state {
 		clk-pins {
@@ -122,30 +60,3 @@ rclk-pins {
 		};
 	};
 };
-
-&usb_0_dwc3 {
-	dr_mode = "host";
-};
-
-&usb_0_qmpphy {
-	vdda-pll-supply = <&mp5496_l2>;
-	vdda-phy-supply = <&regulator_fixed_0p925>;
-
-	status = "okay";
-};
-
-&usb_0_qusbphy {
-	vdd-supply = <&regulator_fixed_0p925>;
-	vdda-pll-supply = <&mp5496_l2>;
-	vdda-phy-dpdm-supply = <&regulator_fixed_3p3>;
-
-	status = "okay";
-};
-
-&usb3 {
-	status = "okay";
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
index c8fa54e1a62c..d36d1078763e 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
@@ -8,73 +8,10 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C6";
 	compatible = "qcom,ipq9574-ap-al02-c6", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
index f01de6628c3b..c30c9fbedf26 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
@@ -8,73 +8,10 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
 	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
index 6efae3426cb8..0dc382f5d5ec 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
@@ -8,73 +8,9 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9";
 	compatible = "qcom,ipq9574-ap-al02-c9", "qcom,ipq9574";
-
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };

-- 
2.34.1

