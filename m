Return-Path: <linux-kernel+bounces-125809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9737C892C79
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F17B21EB6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED041AAB;
	Sat, 30 Mar 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PviGMKeT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2442AB7;
	Sat, 30 Mar 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823369; cv=none; b=radfX8h2lxa6jC/bjXbU2KfzAXdp7xQgGtpsD8hjB44twdzmHmpnLYEU2NKVtWb3IAO2001R1E1topRyc3Bw6PAYM1wUPh0qLjo+9I0yi29JQgc6x7AZc4igKbZvf+Zfw1qaY3FX3eAbu+uHoGUSZtMAtlbWVhqozLNoS7LeCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823369; c=relaxed/simple;
	bh=WmRuJRq4/t+RJ7I8QLLI0zVtLVakAMGbTgTI6jux/VM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUvzMXhVqTrsz3S+6bTKk1icPTAbmeYwS9enRLPT/2dQN0pkTiO8bQT0DOAsI2yeiI8xNRl7xHjPwhCKRwdqo+XT5N0QA6XxivcrKkOaXYOEAFutTlnJ4Mc5xcRyvV/Ummn1X/Nqq+JE8xwm0L4+Kf6t4PYdrpzlclu+xZ00xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PviGMKeT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42UIPb3w010127;
	Sat, 30 Mar 2024 18:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RWBKoYhcleWz4ahThc0+c2IRIo3y3Pswq6HEqZ0fXow=; b=Pv
	iGMKeTVwFcKsA7JUb0l56FbWNZWN2GSNWdt6m6+3OJ6J2HxSfbW7V3UPThBSFsjc
	9yDzIOaYjJ1qjLW+c91mgdZOV3iMbxUpOEcGW5Xj7LYbaTEWBt3Dnj1X3YE7WPIb
	olLTUMFn9RYUSDbX2qk4JhH4VjHggsUQ+/z01Rd5ljbOBdHWpUO5qRx2ncli5csq
	/uy5SkC/mFRRYUfnArsBcDlOvq1o2t3aKq19X0Ab6wA4vLu24tutS8KIcdk6DJ26
	0OsYVdEL+uXcaxtvX5rAv6rfvCVwzxTysij6azrj9bpIPjK+FHHK+EmS8nU3f01B
	Ze3DYM/PEQFVzdC756Wg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x68ejhdmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42UITF7b008427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:15 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 11:29:10 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH 2/7] dt-bindings: clock: qcom: Add DISPCC clocks for SM4450
Date: Sat, 30 Mar 2024 23:58:12 +0530
Message-ID: <20240330182817.3272224-3-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g5Hxh0EeOnT5ivNLCMxYBt2VhD35AlGi
X-Proofpoint-GUID: g5Hxh0EeOnT5ivNLCMxYBt2VhD35AlGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403300151

Add support for qcom display clock controller bindings
for SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
 .../bindings/clock/qcom,sm4450-dispcc.yaml    | 71 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm4450-dispcc.h    | 51 +++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-dispcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
new file mode 100644
index 000000000000..098a4fc8c208
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm4450-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller on SM4450
+
+maintainers:
+  - Ajit Pandey <quic_ajipan@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm display clock control module provides the clocks, resets and power
+  domains on SM4450
+
+  See also:: include/dt-bindings/clock/qcom,sm4450-dispcc.h
+
+properties:
+  compatible:
+    const: qcom,sm4450-dispcc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Display AHB clock source from GCC
+      - description: sleep clock source
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,sm4450-gcc.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sm4450-dispcc";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&gcc GCC_DISPLAY_AHB_CLK>;
+               <&sleep_clk>,
+               <&dsi0_phy_pll_out_byteclk>,
+               <&dsi0_phy_pll_out_dsiclk>,
+      #power-domain-cells = <1>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm4450-dispcc.h b/include/dt-bindings/clock/qcom,sm4450-dispcc.h
new file mode 100644
index 000000000000..ca6f2ef90157
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm4450-dispcc.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM4450_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM4450_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_AHB1_CLK					0
+#define DISP_CC_MDSS_AHB_CLK					1
+#define DISP_CC_MDSS_AHB_CLK_SRC				2
+#define DISP_CC_MDSS_BYTE0_CLK					3
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				4
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				6
+#define DISP_CC_MDSS_ESC0_CLK					7
+#define DISP_CC_MDSS_ESC0_CLK_SRC				8
+#define DISP_CC_MDSS_MDP1_CLK					9
+#define DISP_CC_MDSS_MDP_CLK					10
+#define DISP_CC_MDSS_MDP_CLK_SRC				11
+#define DISP_CC_MDSS_MDP_LUT1_CLK				12
+#define DISP_CC_MDSS_MDP_LUT_CLK				13
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				14
+#define DISP_CC_MDSS_PCLK0_CLK					15
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				16
+#define DISP_CC_MDSS_ROT1_CLK					17
+#define DISP_CC_MDSS_ROT_CLK					18
+#define DISP_CC_MDSS_ROT_CLK_SRC				19
+#define DISP_CC_MDSS_RSCC_AHB_CLK				20
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				21
+#define DISP_CC_MDSS_VSYNC1_CLK					22
+#define DISP_CC_MDSS_VSYNC_CLK					23
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				24
+#define DISP_CC_PLL0						25
+#define DISP_CC_PLL1						26
+#define DISP_CC_SLEEP_CLK					27
+#define DISP_CC_SLEEP_CLK_SRC					28
+#define DISP_CC_XO_CLK						29
+#define DISP_CC_XO_CLK_SRC					30
+
+/* DISP_CC power domains */
+#define DISP_CC_MDSS_CORE_GDSC					0
+#define DISP_CC_MDSS_CORE_INT2_GDSC				1
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+#endif
-- 
2.25.1


