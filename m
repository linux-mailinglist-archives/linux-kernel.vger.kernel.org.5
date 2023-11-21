Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43C77F30E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjKUOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjKUOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:31:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61964D79;
        Tue, 21 Nov 2023 06:31:52 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE2D4Q003264;
        Tue, 21 Nov 2023 14:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=VwiNzGdTdnwCbcRY81Cl9TFayroNcUS9nnEWOaqRuPA=;
 b=ZVXaaKBdNR4hAUijo0P2E1jlQ6PNrbf/0o/b9kqp+XwhS0f9thLqih90U6Q+9TAa7HOH
 TMw9FBsx9kIJeE9pN3FXardApzkEbfEH2SZE4FCaXEsVNnMVamxvUQ3FU0exmDapUSte
 FnfCnCM1WcCFTs0qqrtUVVjJSvNXCp1gOYEdZELLt8/CcO3VyDKwPuuOny1SUxK78Gvw
 6rEOtG/Wvaz9wnBTjXXm1SeG775JIagZWBI4k5/p7AVXVHU8jrzaqjBphvnRMCAVBDcb
 G/Z0h9IXdR8qBakxTHN5NzzA8AwBIqQJtn8F76g2J8cZtErOUkR+7oqgtuBAN6QHqghf KQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugu548vqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALEVf9m027936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:41 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 06:31:35 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Tue, 21 Nov 2023 20:00:48 +0530
Subject: [PATCH v2 6/9] dt-bindings: clock: add Qualcomm IPQ5332 NSSCC
 clock and reset definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231121-ipq5332-nsscc-v2-6-a7ff61beab72@quicinc.com>
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
In-Reply-To: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700577061; l=6077;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=TSmKmZiK3DLZt0Zbx5+7IbVFU37ciFfHI89bN4e1Mzw=;
 b=Tgl5yUbwa5g7hop+nVqj7R9YFcPFP2E/1n+QnJz+3N+644JcBPbKbskha2/34WzIi22dN4G0E
 NKKheWr9/n5D0yzvoPFya+qI0LyPDqV5330rFFFu24I7oPd5Hryio/O
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HPNWwj_8GhrDdv-vHHqVzf6nhA-PkyT7
X-Proofpoint-ORIG-GUID: HPNWwj_8GhrDdv-vHHqVzf6nhA-PkyT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NSSCC clock and reset definitions for Qualcomm IPQ5332.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Pick up R-b tag
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

