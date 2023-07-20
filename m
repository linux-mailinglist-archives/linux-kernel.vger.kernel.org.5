Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3675A7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjGTHab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjGTHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:30:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20F26AA;
        Thu, 20 Jul 2023 00:30:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K6xpSi019634;
        Thu, 20 Jul 2023 07:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=gHFUgL9j5qD0T3UpfF5tyClG5nlh5aGBEUOMqnKT0Iw=;
 b=pK0x/sLesE8QHCJIQTtsw84M+B8azxvR+HuXAXDwRDLHMOVZh4FJIgwddtMJWkOMKqA8
 QPRpMexK9/eBT3pXWOuMLFd1GrQ8y5duyd4LnSaEL/NKRZ4t+l7SYWO+DUVLW4zFxOMO
 AW6VYm1Q6lvsE5KTGQeDIwPUs96FuXHgoxQhl9L7//bQ8TYrBL6gLUyw5dktbdcsKsnl
 UvVoTD2cy1kOCR9CSTSlC1okU0c9vrwftmSfn3+n2VL2f95uIue/oY54I/vWv8LRzlxe
 QZcerUnqSAOBWqBZKIrWTrR4dE1yacTSfCWl9dg9jAmYP+whxCuLeVzWYkdsue17Pq8s pA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxummrhpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:30:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K7U9Po026470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:30:09 GMT
Received: from harihk-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:30:04 -0700
From:   Hariharan K <quic_harihk@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq5018: Add common RDP dtsi file
Date:   Thu, 20 Jul 2023 12:59:38 +0530
Message-ID: <20230720072938.31546-3-quic_harihk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720072938.31546-1-quic_harihk@quicinc.com>
References: <20230720072938.31546-1-quic_harihk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NANYYStjgKDFBJBFYmzfbPHYXCkqzgqH
X-Proofpoint-GUID: NANYYStjgKDFBJBFYmzfbPHYXCkqzgqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=773
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dtsi file to include interfaces that are common
across RDPs.

Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
---
 .../boot/dts/qcom/ipq5018-rdp-common.dtsi     | 35 +++++++++++++++++++
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 30 +++-------------
 2 files changed, 39 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp-common.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5018-rdp-common.dtsi
new file mode 100644
index 000000000000..c288e508c8f6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp-common.dtsi
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ5018 RDP board common device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq5018.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&blsp1_uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&xo_board_clk {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index e636a1cb9b77..90b6a98471f5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -1,31 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
 /*
- * IPQ5018 MP03.1-C2 board device tree source
+ * IPQ5018 MP03.5-C2 board device tree source
  *
  * Copyright (c) 2023 The Linux Foundation. All rights reserved.
  */
 
 /dts-v1/;
 
-#include "ipq5018.dtsi"
+#include "ipq5018-rdp-common.dtsi"
 
 / {
-	model = "Qualcomm Technologies, Inc. IPQ5018/AP-RDP432.1-C2";
-	compatible = "qcom,ipq5018-rdp432-c2", "qcom,ipq5018";
-
-	aliases {
-		serial0 = &blsp1_uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_uart1 {
-	pinctrl-0 = <&uart1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
+	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03.5-C2";
+	compatible = "qcom,ipq5018-ap-mp03.5-c2", "qcom,ipq5018";
 };
 
 &sdhc_1 {
@@ -38,10 +24,6 @@
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &tlmm {
 	sdc_default_state: sdc-default-state {
 		clk-pins {
@@ -66,7 +48,3 @@
 		};
 	};
 };
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
-};
-- 
2.17.1

