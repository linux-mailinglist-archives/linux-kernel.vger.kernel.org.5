Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BBD75A9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGTI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjGTIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:47:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0702686;
        Thu, 20 Jul 2023 01:47:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K59DOf028550;
        Thu, 20 Jul 2023 08:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MxbhnSAzwskrGx4pgnsP77v/3ERZSHATXzmuEKmoQUE=;
 b=kfBsiGdLOayOvofwgUDSimqAVDHykyfLGVy2xjtxYJIC/DDKBW4pDwzvjlWergGqPBzb
 3jAiPgBBEdTDN5qgQjZmtlES1e6b2SuPLDTnaZ8u3BqKjDWvrhE6Qa0quKDzZBmjsgwo
 VmrTTsbFhRnAmXWFA9Sfx9ADTr9GdRb9scXTwA75yOATCR+IFYCcy2hbdYBq5546m0aF
 FAe3Kk8FlQB9Z/8jTQyk1toRjvLKfXcHtTdlT7wt0fVRCHEUGwc/6A0/P4iewRYCr2g6
 KYWjQtyntMcFY9SPDsnhoayYBSvocigvep3k/LzmDmO6OZHw5lInVquUXG6aGtEho44A Lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxt188t2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:47:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K8l8Vw032234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:47:08 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 01:47:04 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for various RDPs
Date:   Thu, 20 Jul 2023 14:15:34 +0530
Message-ID: <20230720084534.6461-3-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720084534.6461-1-quic_sridsn@quicinc.com>
References: <20230720084534.6461-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MnEBXSedAANvCGwFfQPfHpRuIDjtiuVF
X-Proofpoint-GUID: MnEBXSedAANvCGwFfQPfHpRuIDjtiuVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDPs) 433-mht-phy,433-mht-switch,437,455,456,457,458,459
461,467,469 based on IPQ9574 family of SoC.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
This patch depends on below patchset:
https://lore.kernel.org/lkml/20230713105909.14209-2-quic_anusha@quicinc.com/

 arch/arm64/boot/dts/qcom/Makefile             | 11 ++++
 .../boot/dts/qcom/ipq9574-rdp433-mht-phy.dts  | 62 +++++++++++++++++++
 .../dts/qcom/ipq9574-rdp433-mht-switch.dts    | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts   | 62 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts   | 15 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts   | 16 +++++
 12 files changed, 278 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-phy.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-switch.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 9c30344d08c1..81699082d838 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -15,9 +15,20 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp417.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433-mht-phy.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433-mht-switch.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp437.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp455.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp456.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp457.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp458.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp459.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp461.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp467.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp469.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-phy.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-phy.dts
new file mode 100644
index 000000000000..a0e75225051a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-phy.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 ipq9574-rdp433-mht-phy board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
+	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc_default_state>;
+	pinctrl-names = "default";
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	max-frequency = <384000000>;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&tlmm {
+	sdc_default_state: sdc-default-state {
+		clk-pins {
+			pins = "gpio5";
+			function = "sdc_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "gpio4";
+			function = "sdc_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2",
+			       "gpio3", "gpio6", "gpio7",
+			       "gpio8", "gpio9";
+			function = "sdc_data";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		rclk-pins {
+			pins = "gpio10";
+			function = "sdc_rclk";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-switch.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-switch.dts
new file mode 100644
index 000000000000..47220a31f228
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-switch.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP433-mht-switch board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C10";
+	compatible = "qcom,ipq9574-ap-al02-c10", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts
new file mode 100644
index 000000000000..f3020f87f587
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP437 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C3";
+	compatible = "qcom,ipq9574-ap-al02-c3", "qcom,ipq9574";
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc_default_state>;
+	pinctrl-names = "default";
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	max-frequency = <384000000>;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&tlmm {
+	sdc_default_state: sdc-default-state {
+		clk-pins {
+			pins = "gpio5";
+			function = "sdc_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "gpio4";
+			function = "sdc_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2",
+			       "gpio3", "gpio6", "gpio7",
+			       "gpio8", "gpio9";
+			function = "sdc_data";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		rclk-pins {
+			pins = "gpio10";
+			function = "sdc_rclk";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts
new file mode 100644
index 000000000000..d604ad9a7a2c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP455 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C12";
+	compatible = "qcom,ipq9574-ap-al02-c12", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts
new file mode 100644
index 000000000000..22d69ec8912f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP456 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C16";
+	compatible = "qcom,ipq9574-ap-al02-c16", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts
new file mode 100644
index 000000000000..801cd9f9e672
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP457 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C15";
+	compatible = "qcom,ipq9574-ap-al02-c15", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts
new file mode 100644
index 000000000000..388a75dc1181
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP458 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL03-C2";
+	compatible = "qcom,ipq9574-ap-al03-c2", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts
new file mode 100644
index 000000000000..d445caf6fe11
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP459 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C13";
+	compatible = "qcom,ipq9574-ap-al02-c13", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts
new file mode 100644
index 000000000000..9f0f2dba81ac
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP461 board device tree source
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C19";
+	compatible = "qcom,ipq9574-ap-al02-c19", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts
new file mode 100644
index 000000000000..cba3747da2c6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP467 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C11";
+	compatible = "qcom,ipq9574-ap-al02-c11", "qcom,ipq9574";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts
new file mode 100644
index 000000000000..0e8a7cfdfe69
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP469 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C17";
+	compatible = "qcom,ipq9574-ap-al02-c17", "qcom,ipq9574";
+};
-- 
2.17.1

