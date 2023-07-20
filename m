Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1103675A817
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGTHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGTHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:43:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819E2128;
        Thu, 20 Jul 2023 00:43:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7dVPM029427;
        Thu, 20 Jul 2023 07:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rKAxcQM/1XY9fRkTmUHW3qxzpUY87N5stMyOlukxUVc=;
 b=XQBGpZMOp7+d8J9o38duKevh+JBPv5AqZE+lE6neDQqTDodRVrGZSHqPcuHQkqhUlgk5
 Tha4BGtPk4x06/ssVpy44CwUUz0682JyfWVoXaxF0CPhngWTrIrdgPg3fzQ9C56DgLs9
 yJ5LDC3qFoVUyfkdGrhzXX+wIZjXOva3H/bscwSRY/Q2sUFaaZ2mCBMLgVt+ZODgOPdj
 xjmoKKznN0LTeJHIkp/yBssmSfjgcyUjaWqFC3dZ3kwmBVwzcILuWwVMA+LJxdfmiWWD
 b3mR/7z5L/JgzOvl/K7DRQNMD0qLdoQb38GRLiAb/xYHW0m0yM2rFJCPhavcMkTObZY5 EQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv08et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:43:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K7hYNv011730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:43:34 GMT
Received: from harihk-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:43:29 -0700
From:   Hariharan K <quic_harihk@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_harihk@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq5018: add support for the RDP404 variant
Date:   Thu, 20 Jul 2023 13:13:02 +0530
Message-ID: <20230720074302.13585-3-quic_harihk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720074302.13585-1-quic_harihk@quicinc.com>
References: <20230720074302.13585-1-quic_harihk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ETpccRpKzok7XUqmmNfqHAervdj6S-uy
X-Proofpoint-GUID: ETpccRpKzok7XUqmmNfqHAervdj6S-uy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 404 based on IPQ5018 family of SoC. This patch carries
the support for Console UART and eMMC.

Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile           |  1 +
 arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts | 49 +++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6334e552b7c1..f2f5e70ba431 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp404.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts
new file mode 100644
index 000000000000..3f8b34f7b2ea
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * IPQ5018 MP03.1-C2 board device tree source
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq5018-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03.1-C2";
+	compatible = "qcom,ipq5018-ap-mp03.1-c2", "qcom,ipq5018";
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc_default_state>;
+	pinctrl-names = "default";
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <192000000>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&tlmm {
+	sdc_default_state: sdc-default-state {
+		clk-pins {
+			pins = "gpio9";
+			function = "sdc1_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "gpio8";
+			function = "sdc1_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio4", "gpio5", "gpio6", "gpio7";
+			function = "sdc1_data";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+};
-- 
2.17.1

