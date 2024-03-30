Return-Path: <linux-kernel+bounces-125812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A5892C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0221F21D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA264AEDF;
	Sat, 30 Mar 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q0jvgQ+k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4741C73;
	Sat, 30 Mar 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823372; cv=none; b=IyXttRZrRg8DrKdGTWZFOO9uPbp8iNnLPhjkSRU3L0gxVM8CzMlUdWqNyeK+1HoC5zssVOHOyO91woB9MIHe7FHaYD9y/PYahLUG5ePU9u9shR9nrr68X0UhtYIDSHMjsA7f8sBlD6LSvdu/bIe5kxhhQb+C5CST1WWOTb5BlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823372; c=relaxed/simple;
	bh=TTraymcZMKSjpxwroxBIVQa8pYTfWSLF+1OPvi7/yes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdE8V33Vp4l6wEEjGEOqen5iou5c9kGBWehEJm6LeMgbAM8NfNKR3AGz7EXZThtd6pEmgX4ZDczTNdHQu33FTmV0YDT6Z4bA4ZatOEkf/M6RrZWIaOCJ9yLjNSQ4gwmbapXy1TK/HxyEbWXGJLvtmcAmc/MCzKucbbgaKTiUyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q0jvgQ+k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42UI3xgt021576;
	Sat, 30 Mar 2024 18:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cuOK2o72VftTJ3Z+TgyfyKAuI/u25CVHD4a9cOlg+FQ=; b=Q0
	jvgQ+klLahLErIq3+OE4CZ6prIlRGqF99ZiSQTkMk9jEhNgsTQhgyp7D0dMZzTmZ
	+M5tXMEUDaAY37KTgnmH/phB+QtUbsN5jIsiZ1T5fRdLRHdPibCJah2UZC9EILK9
	P3SeDmWPGAoK9J6NGB9QzxntWrx6U7DTQHRBSxWOaCeJHVZLnqx0stARv76HgOx0
	51AooHHMhb6qAuoBMbp9P6+dU+FaDQfXf3/Vrl5zasZFcfH6WzE+fX26Tho1kvwg
	jG+mUN446GmYXxihlDAy/3qyoLq7HKjfkvBan6JoH9IkGMhgymi86oqUBkM67I7T
	Yw/KDfUf553EqbQuKriA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6ab3s7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42UITPrr024315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:25 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 11:29:20 -0700
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
Subject: [PATCH 4/7] dt-bindings: clock: qcom: Add CAMCC clocks for SM4450
Date: Sat, 30 Mar 2024 23:58:14 +0530
Message-ID: <20240330182817.3272224-5-quic_ajipan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rskmi8ZlajXFCyCfq-jVdQZqX-0KXaPy
X-Proofpoint-GUID: rskmi8ZlajXFCyCfq-jVdQZqX-0KXaPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403300151

Add support for qcom camera clock controller bindings
for SMM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
 .../bindings/clock/qcom,sm4450-camcc.yaml     |  63 +++++++++++
 include/dt-bindings/clock/qcom,sm4450-camcc.h | 106 ++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
new file mode 100644
index 000000000000..f54ce865880d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm4450-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on SM4450
+
+maintainers:
+  - Ajit Pandey <quic_ajipan@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and power
+  domains on SM4450
+
+  See also:: include/dt-bindings/clock/qcom,sm4450-camcc.h
+
+properties:
+  compatible:
+    const: qcom,sm4450-camcc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Camera AHB clock source from GCC
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
+    clock-controller@ade0000 {
+      compatible = "qcom,sm4450-camcc";
+      reg = <0x0ade0000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_CAMERA_AHB_CLK>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm4450-camcc.h b/include/dt-bindings/clock/qcom,sm4450-camcc.h
new file mode 100644
index 000000000000..bf077951bf1c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm4450-camcc.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_SM4450_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_SM4450_H
+
+/* CAM_CC clocks */
+#define CAM_CC_BPS_AHB_CLK					0
+#define CAM_CC_BPS_AREG_CLK					1
+#define CAM_CC_BPS_CLK						2
+#define CAM_CC_BPS_CLK_SRC					3
+#define CAM_CC_CAMNOC_ATB_CLK					4
+#define CAM_CC_CAMNOC_AXI_CLK					5
+#define CAM_CC_CAMNOC_AXI_CLK_SRC				6
+#define CAM_CC_CAMNOC_AXI_HF_CLK				7
+#define CAM_CC_CAMNOC_AXI_SF_CLK				8
+#define CAM_CC_CCI_0_CLK					9
+#define CAM_CC_CCI_0_CLK_SRC					10
+#define CAM_CC_CCI_1_CLK					11
+#define CAM_CC_CCI_1_CLK_SRC					12
+#define CAM_CC_CORE_AHB_CLK					13
+#define CAM_CC_CPAS_AHB_CLK					14
+#define CAM_CC_CPHY_RX_CLK_SRC					15
+#define CAM_CC_CRE_AHB_CLK					16
+#define CAM_CC_CRE_CLK						17
+#define CAM_CC_CRE_CLK_SRC					18
+#define CAM_CC_CSI0PHYTIMER_CLK					19
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				20
+#define CAM_CC_CSI1PHYTIMER_CLK					21
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				22
+#define CAM_CC_CSI2PHYTIMER_CLK					23
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				24
+#define CAM_CC_CSIPHY0_CLK					25
+#define CAM_CC_CSIPHY1_CLK					26
+#define CAM_CC_CSIPHY2_CLK					27
+#define CAM_CC_FAST_AHB_CLK_SRC					28
+#define CAM_CC_ICP_ATB_CLK					29
+#define CAM_CC_ICP_CLK						30
+#define CAM_CC_ICP_CLK_SRC					31
+#define CAM_CC_ICP_CTI_CLK					32
+#define CAM_CC_ICP_TS_CLK					33
+#define CAM_CC_MCLK0_CLK					34
+#define CAM_CC_MCLK0_CLK_SRC					35
+#define CAM_CC_MCLK1_CLK					36
+#define CAM_CC_MCLK1_CLK_SRC					37
+#define CAM_CC_MCLK2_CLK					38
+#define CAM_CC_MCLK2_CLK_SRC					39
+#define CAM_CC_MCLK3_CLK					40
+#define CAM_CC_MCLK3_CLK_SRC					41
+#define CAM_CC_OPE_0_AHB_CLK					42
+#define CAM_CC_OPE_0_AREG_CLK					43
+#define CAM_CC_OPE_0_CLK					44
+#define CAM_CC_OPE_0_CLK_SRC					45
+#define CAM_CC_PLL0						46
+#define CAM_CC_PLL0_OUT_EVEN					47
+#define CAM_CC_PLL0_OUT_ODD					48
+#define CAM_CC_PLL1						49
+#define CAM_CC_PLL1_OUT_EVEN					50
+#define CAM_CC_PLL2						51
+#define CAM_CC_PLL2_OUT_EVEN					52
+#define CAM_CC_PLL3						53
+#define CAM_CC_PLL3_OUT_EVEN					54
+#define CAM_CC_PLL4						55
+#define CAM_CC_PLL4_OUT_EVEN					56
+#define CAM_CC_SLOW_AHB_CLK_SRC					57
+#define CAM_CC_SOC_AHB_CLK					58
+#define CAM_CC_SYS_TMR_CLK					59
+#define CAM_CC_TFE_0_AHB_CLK					60
+#define CAM_CC_TFE_0_CLK					61
+#define CAM_CC_TFE_0_CLK_SRC					62
+#define CAM_CC_TFE_0_CPHY_RX_CLK				63
+#define CAM_CC_TFE_0_CSID_CLK					64
+#define CAM_CC_TFE_0_CSID_CLK_SRC				65
+#define CAM_CC_TFE_1_AHB_CLK					66
+#define CAM_CC_TFE_1_CLK					67
+#define CAM_CC_TFE_1_CLK_SRC					68
+#define CAM_CC_TFE_1_CPHY_RX_CLK				69
+#define CAM_CC_TFE_1_CSID_CLK					70
+#define CAM_CC_TFE_1_CSID_CLK_SRC				71
+
+/* CAM_CC power domains */
+#define CAM_CC_CAMSS_TOP_GDSC					0
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR						0
+#define CAM_CC_CAMNOC_BCR					1
+#define CAM_CC_CAMSS_TOP_BCR					2
+#define CAM_CC_CCI_0_BCR					3
+#define CAM_CC_CCI_1_BCR					4
+#define CAM_CC_CPAS_BCR						5
+#define CAM_CC_CRE_BCR						6
+#define CAM_CC_CSI0PHY_BCR					7
+#define CAM_CC_CSI1PHY_BCR					8
+#define CAM_CC_CSI2PHY_BCR					9
+#define CAM_CC_ICP_BCR						10
+#define CAM_CC_MCLK0_BCR					11
+#define CAM_CC_MCLK1_BCR					12
+#define CAM_CC_MCLK2_BCR					13
+#define CAM_CC_MCLK3_BCR					14
+#define CAM_CC_OPE_0_BCR					15
+#define CAM_CC_TFE_0_BCR					16
+#define CAM_CC_TFE_1_BCR					17
+
+#endif
-- 
2.25.1


