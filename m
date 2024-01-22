Return-Path: <linux-kernel+bounces-32367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E34835AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B679B1C212E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A016439;
	Mon, 22 Jan 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="en+DUOJ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41316427;
	Mon, 22 Jan 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903070; cv=none; b=fXuBA5NRTTaO1M9fzF/0X87GQirifhF7zIAQsBdIIW8vNEUfpU9SsQIt8sRQACvUWvtS5jM8cQUzxmvCC4zhiQ3uo3HZJ8iT7duk0t4RaDN72X+rFmB04SqBHUfC6sa7XYOwO5ONoRmNuwHE4iWi6Jb5Ip9jTa3/PdXHsYhOcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903070; c=relaxed/simple;
	bh=TlOOGex7i6ZmGuP/qIWvEDkZY4CEG+9b1L4Ou6+Teeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hrtMQ+fPQeOuFBlf/WI7Mx2wmznNPnsPayqBBktz5S4OuaeykNuDViEcnei+EonLexW32aSyR8jdDgIEYb41c7P55aJUYJ/GFeyz04VOz9b7bJss1nEBTxi5xOZCgLSqyzmWCrWeO/gfjAqG31RjTDbFG4ANm0vwedbl75Mo9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=en+DUOJ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M3OgIO017666;
	Mon, 22 Jan 2024 05:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=vQfuc+IXRzUFsiQ0nflayngNlRsyjF9MFicrPvzYJTE
	=; b=en+DUOJ3qLVSHItEJdwEi5qbXfgOaazv7mf4Qk8da3RrVyi7TibPNQ2W1Es
	1I92rulY7eo5yErfYAafj4qjTFn7+K+zI5P+GA9aZaKZGWW+YOVfGZn86lmDRvq1
	B8xy9V1ePF6llm/qwquzRjYeq0JFTx+HxfRyNBsjQWk8YbGR+urL1ysI8EHcuHZD
	XwX+1nuJcXeFagFbgHtEgEj8GiMQTMvsVZvRcbZjsc7c3rMGigp+4bboeDyXBHHn
	p3zjv5cPFQeDhK6Jt5rR5tHgUChBBRyvPcnZyE01L36woOLugDOXQH2r2LRylmmx
	j8bMqE6iY7VicCQAfVpzGi7/wtg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7bqjxek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5vau0020347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:36 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:30 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 22 Jan 2024 11:27:01 +0530
Subject: [PATCH v4 5/8] dt-bindings: clock: add Qualcomm IPQ5332 NSSCC
 clock and reset definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240122-ipq5332-nsscc-v4-5-19fa30019770@quicinc.com>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
In-Reply-To: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=6036;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=TlOOGex7i6ZmGuP/qIWvEDkZY4CEG+9b1L4Ou6+Teeg=;
 b=+sJ7HhNeW5qWw65KRH8EGoApj32lhCLKLzOotr11IK0aCdTvpryRviH+MZo9pa2d5bNWIByA2
 vewGS4/OrWBCvxoGRNlJ11E/idJ1Jstl4xd8ug/ZJExn4ci+0Y1m+fK
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FUO7rkfzUnvIZUQuFf4HmbyKYMvfnuYM
X-Proofpoint-ORIG-GUID: FUO7rkfzUnvIZUQuFf4HmbyKYMvfnuYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220041

Add NSSCC clock and reset definitions for Qualcomm IPQ5332.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 .../bindings/clock/qcom,ipq5332-nsscc.yaml         | 60 +++++++++++++++
 include/dt-bindings/clock/qcom,ipq5332-nsscc.h     | 86 ++++++++++++++++++++++
 2 files changed, 146 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml
new file mode 100644
index 000000000000..59f8d1e99229
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5332-nsscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ5332
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm networking sub system clock control module provides the clocks,
+  resets and power domains on IPQ5332
+
+  See also::
+    include/dt-bindings/clock/qcom,ipq5332-nsscc.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq5332-nsscc
+
+  clocks:
+    items:
+      - description: Common PLL nss clock 200M source
+      - description: Common PLL nss clock 300M source
+      - description: GCC GPLL0 out aux clock source
+      - description: Uniphy0 NSS Rx clock source
+      - description: Uniphy0 NSS Tx clock source
+      - description: Uniphy1 NSS Rx clock source
+      - description: Uniphy1 NSS Tx clock source
+      - description: Board XO source
+
+required:
+  - compatible
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-controller@39b00000 {
+      compatible = "qcom,ipq5332-nsscc";
+      reg = <0x39b00000 0x80000>;
+      clocks = <&bias_pll_cc_clk>,
+               <&bias_pll_nss_noc_clk>,
+               <&gcc_gpll0_out_aux>,
+               <&uniphy 0>,
+               <&uniphy 1>,
+               <&uniphy 2>,
+               <&uniphy 3>,
+               <&xo_board_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,ipq5332-nsscc.h b/include/dt-bindings/clock/qcom,ipq5332-nsscc.h
new file mode 100644
index 000000000000..c077cde7f57d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5332-nsscc.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_NSS_CC_IPQ5332_H
+#define _DT_BINDINGS_CLK_QCOM_NSS_CC_IPQ5332_H
+
+/* NSS_CC clocks */
+#define NSS_CC_CE_APB_CLK					0
+#define NSS_CC_CE_AXI_CLK					1
+#define NSS_CC_CE_CLK_SRC					2
+#define NSS_CC_CFG_CLK_SRC					3
+#define NSS_CC_DEBUG_CLK					4
+#define NSS_CC_EIP_BFDCD_CLK_SRC				5
+#define NSS_CC_EIP_CLK						6
+#define NSS_CC_NSS_CSR_CLK					7
+#define NSS_CC_NSSNOC_CE_APB_CLK				8
+#define NSS_CC_NSSNOC_CE_AXI_CLK				9
+#define NSS_CC_NSSNOC_EIP_CLK					10
+#define NSS_CC_NSSNOC_NSS_CSR_CLK				11
+#define NSS_CC_NSSNOC_PPE_CFG_CLK				12
+#define NSS_CC_NSSNOC_PPE_CLK					13
+#define NSS_CC_PORT1_MAC_CLK					14
+#define NSS_CC_PORT1_RX_CLK					15
+#define NSS_CC_PORT1_RX_CLK_SRC					16
+#define NSS_CC_PORT1_RX_DIV_CLK_SRC				17
+#define NSS_CC_PORT1_TX_CLK					18
+#define NSS_CC_PORT1_TX_CLK_SRC					19
+#define NSS_CC_PORT1_TX_DIV_CLK_SRC				20
+#define NSS_CC_PORT2_MAC_CLK					21
+#define NSS_CC_PORT2_RX_CLK					22
+#define NSS_CC_PORT2_RX_CLK_SRC					23
+#define NSS_CC_PORT2_RX_DIV_CLK_SRC				24
+#define NSS_CC_PORT2_TX_CLK					25
+#define NSS_CC_PORT2_TX_CLK_SRC					26
+#define NSS_CC_PORT2_TX_DIV_CLK_SRC				27
+#define NSS_CC_PPE_CLK_SRC					28
+#define NSS_CC_PPE_EDMA_CFG_CLK					29
+#define NSS_CC_PPE_EDMA_CLK					30
+#define NSS_CC_PPE_SWITCH_BTQ_CLK				31
+#define NSS_CC_PPE_SWITCH_CFG_CLK				32
+#define NSS_CC_PPE_SWITCH_CLK					33
+#define NSS_CC_PPE_SWITCH_IPE_CLK				34
+#define NSS_CC_UNIPHY_PORT1_RX_CLK				35
+#define NSS_CC_UNIPHY_PORT1_TX_CLK				36
+#define NSS_CC_UNIPHY_PORT2_RX_CLK				37
+#define NSS_CC_UNIPHY_PORT2_TX_CLK				38
+#define NSS_CC_XGMAC0_PTP_REF_CLK				39
+#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC			40
+#define NSS_CC_XGMAC1_PTP_REF_CLK				41
+#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC			42
+
+#define NSS_CC_CE_APB_CLK_ARES					0
+#define NSS_CC_CE_AXI_CLK_ARES					1
+#define NSS_CC_DEBUG_CLK_ARES					2
+#define NSS_CC_EIP_CLK_ARES					3
+#define NSS_CC_NSS_CSR_CLK_ARES					4
+#define NSS_CC_NSSNOC_CE_APB_CLK_ARES				5
+#define NSS_CC_NSSNOC_CE_AXI_CLK_ARES				6
+#define NSS_CC_NSSNOC_EIP_CLK_ARES				7
+#define NSS_CC_NSSNOC_NSS_CSR_CLK_ARES				8
+#define NSS_CC_NSSNOC_PPE_CLK_ARES				9
+#define NSS_CC_NSSNOC_PPE_CFG_CLK_ARES				10
+#define NSS_CC_PORT1_MAC_CLK_ARES				11
+#define NSS_CC_PORT1_RX_CLK_ARES				12
+#define NSS_CC_PORT1_TX_CLK_ARES				13
+#define NSS_CC_PORT2_MAC_CLK_ARES				14
+#define NSS_CC_PORT2_RX_CLK_ARES				15
+#define NSS_CC_PORT2_TX_CLK_ARES				16
+#define NSS_CC_PPE_BCR						17
+#define NSS_CC_PPE_EDMA_CLK_ARES				18
+#define NSS_CC_PPE_EDMA_CFG_CLK_ARES				19
+#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES				20
+#define NSS_CC_PPE_SWITCH_CLK_ARES				21
+#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES				22
+#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES				23
+#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES				24
+#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES				25
+#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES				26
+#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES				27
+#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES				28
+#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES				29
+
+#endif

-- 
2.34.1


