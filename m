Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD307773CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjHHQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjHHQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB332698;
        Tue,  8 Aug 2023 08:45:52 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3784AWL9029671;
        Tue, 8 Aug 2023 05:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=qRmf3o+fKgscWD3LK1ByvSr2BxrPRLI9qgP7yXyf7f4=;
 b=T2+CwlwP7p7RnRp2HNei5UYRcwFyc0P/my5+/TKEIOvyxvgwjXXq7rCHBgY2xkr9NxLr
 JQ/QCeo+NPMnIm2SdFJhQK/jlMiX6cjJlV/xLt6/y6my2Hb7gKaIYL2ZMfHDPoBAa1nu
 DvEbZFuv3PxjywoeIk37DywPDqH1n8gzaPRePRFkEToE9d1ORyaQW4rRypqr84MOO1N3
 X9FhdRloGnSc0osKJrg9k+Rjlrrlfrk3tcFaMKxUGKvcPQLDZFmD32B+twOT2QiFFGUH
 bTpMFjzlDpyWheDlGgOYrPWWfeMQjQv9uMMAJOUpHITIoKUpac0bH87xc6nuSLYNf0xg Qg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb9pqrhvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 05:14:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3785Er8q015328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 05:14:53 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 22:14:48 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: clock: qcom: Add ECPRICC clocks for QDU1000 and QRU1000
Date:   Tue, 8 Aug 2023 10:44:04 +0530
Message-ID: <20230808051407.647395-2-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808051407.647395-1-quic_imrashai@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yt8sGtrB947NSWCClvhOvIhsCH6qABOs
X-Proofpoint-ORIG-GUID: yt8sGtrB947NSWCClvhOvIhsCH6qABOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for qcom ecpri clock controller on QDU1000 and
QRU1000 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 .../bindings/clock/qcom,qdu1000-ecpricc.yaml  |  68 +++++++
 .../dt-bindings/clock/qcom,qdu1000-ecpricc.h  | 192 ++++++++++++++++++
 2 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
new file mode 100644
index 000000000000..db54052bf360
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,qdu1000-ecpricc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ECPRI Clock & Reset Controller for QDU1000 and QRU1000
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Imran Shaik <quic_imrashai@quicinc.com>
+
+description: |
+  Qualcomm ecpri clock control module which supports the clocks, resets
+  on QDU1000 and QRU1000
+
+  See also:: include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,qdu1000-ecpricc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 source from GCC
+      - description: GPLL1 source from GCC
+      - description: GPLL2 source from GCC
+      - description: GPLL3 source from GCC
+      - description: GPLL4 source from GCC
+      - description: GPLL5 source from GCC
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@280000 {
+      compatible = "qcom,qdu1000-ecpricc";
+      reg = <0x00280000 0x31c00>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_ECPRI_CC_GPLL0_CLK_SRC>,
+               <&gcc GCC_ECPRI_CC_GPLL1_EVEN_CLK_SRC>,
+               <&gcc GCC_ECPRI_CC_GPLL2_EVEN_CLK_SRC>,
+               <&gcc GCC_ECPRI_CC_GPLL3_CLK_SRC>,
+               <&gcc GCC_ECPRI_CC_GPLL4_CLK_SRC>,
+               <&gcc GCC_ECPRI_CC_GPLL5_EVEN_CLK_SRC>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/qcom,qdu1000-ecpricc.h b/include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
new file mode 100644
index 000000000000..45ff0f264613
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_ECPRI_CC_QDU1000_H
+#define _DT_BINDINGS_CLK_QCOM_ECPRI_CC_QDU1000_H
+
+/* ECPRI_CC clocks */
+#define ECPRI_CC_PLL0						0
+#define ECPRI_CC_PLL1						1
+#define ECPRI_CC_ECPRI_CG_CLK					2
+#define ECPRI_CC_ECPRI_CLK_SRC					3
+#define ECPRI_CC_ECPRI_DMA_CLK					4
+#define ECPRI_CC_ECPRI_DMA_CLK_SRC				5
+#define ECPRI_CC_ECPRI_DMA_NOC_CLK				6
+#define ECPRI_CC_ECPRI_FAST_CLK					7
+#define ECPRI_CC_ECPRI_FAST_CLK_SRC				8
+#define ECPRI_CC_ECPRI_FAST_DIV2_CLK				9
+#define ECPRI_CC_ECPRI_FAST_DIV2_CLK_SRC			10
+#define ECPRI_CC_ECPRI_FAST_DIV2_NOC_CLK			11
+#define ECPRI_CC_ECPRI_FR_CLK					12
+#define ECPRI_CC_ECPRI_ORAN_CLK_SRC				13
+#define ECPRI_CC_ECPRI_ORAN_DIV2_CLK				14
+#define ECPRI_CC_ETH_100G_C2C0_HM_FF_CLK_SRC			15
+#define ECPRI_CC_ETH_100G_C2C0_UDP_FIFO_CLK			16
+#define ECPRI_CC_ETH_100G_C2C1_UDP_FIFO_CLK			17
+#define ECPRI_CC_ETH_100G_C2C_0_HM_FF_0_CLK			18
+#define ECPRI_CC_ETH_100G_C2C_0_HM_FF_1_CLK			19
+#define ECPRI_CC_ETH_100G_C2C_HM_FF_0_DIV_CLK_SRC		20
+#define ECPRI_CC_ETH_100G_C2C_HM_FF_1_DIV_CLK_SRC		21
+#define ECPRI_CC_ETH_100G_C2C_HM_MACSEC_CLK			22
+#define ECPRI_CC_ETH_100G_C2C_HM_MACSEC_CLK_SRC			23
+#define ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_0_CLK			24
+#define ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_0_DIV_CLK_SRC		25
+#define ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_1_CLK			26
+#define ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_1_DIV_CLK_SRC		27
+#define ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_CLK_SRC			28
+#define ECPRI_CC_ETH_100G_DBG_C2C_UDP_FIFO_CLK			29
+#define ECPRI_CC_ETH_100G_FH0_HM_FF_CLK_SRC			30
+#define ECPRI_CC_ETH_100G_FH0_MACSEC_CLK_SRC			31
+#define ECPRI_CC_ETH_100G_FH1_HM_FF_CLK_SRC			32
+#define ECPRI_CC_ETH_100G_FH1_MACSEC_CLK_SRC			33
+#define ECPRI_CC_ETH_100G_FH2_HM_FF_CLK_SRC			34
+#define ECPRI_CC_ETH_100G_FH2_MACSEC_CLK_SRC			35
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_0_CLK			36
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_0_DIV_CLK_SRC		37
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_1_CLK			38
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_1_DIV_CLK_SRC		39
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_2_CLK			40
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_2_DIV_CLK_SRC		41
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_3_CLK			42
+#define ECPRI_CC_ETH_100G_FH_0_HM_FF_3_DIV_CLK_SRC		43
+#define ECPRI_CC_ETH_100G_FH_0_UDP_FIFO_CLK			44
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_0_CLK			45
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_0_DIV_CLK_SRC		46
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_1_CLK			47
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_1_DIV_CLK_SRC		48
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_2_CLK			49
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_2_DIV_CLK_SRC		50
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_3_CLK			51
+#define ECPRI_CC_ETH_100G_FH_1_HM_FF_3_DIV_CLK_SRC		52
+#define ECPRI_CC_ETH_100G_FH_1_UDP_FIFO_CLK			53
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_0_CLK			54
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_0_DIV_CLK_SRC		55
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_1_CLK			56
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_1_DIV_CLK_SRC		57
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_2_CLK			58
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_2_DIV_CLK_SRC		59
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_3_CLK			60
+#define ECPRI_CC_ETH_100G_FH_2_HM_FF_3_DIV_CLK_SRC		61
+#define ECPRI_CC_ETH_100G_FH_2_UDP_FIFO_CLK			62
+#define ECPRI_CC_ETH_100G_FH_MACSEC_0_CLK			63
+#define ECPRI_CC_ETH_100G_FH_MACSEC_1_CLK			64
+#define ECPRI_CC_ETH_100G_FH_MACSEC_2_CLK			65
+#define ECPRI_CC_ETH_100G_MAC_C2C_HM_REF_CLK			66
+#define ECPRI_CC_ETH_100G_MAC_C2C_HM_REF_CLK_SRC		67
+#define ECPRI_CC_ETH_100G_MAC_DBG_C2C_HM_REF_CLK		68
+#define ECPRI_CC_ETH_100G_MAC_DBG_C2C_HM_REF_CLK_SRC		69
+#define ECPRI_CC_ETH_100G_MAC_FH0_HM_REF_CLK			70
+#define ECPRI_CC_ETH_100G_MAC_FH0_HM_REF_CLK_SRC		71
+#define ECPRI_CC_ETH_100G_MAC_FH1_HM_REF_CLK			72
+#define ECPRI_CC_ETH_100G_MAC_FH1_HM_REF_CLK_SRC		73
+#define ECPRI_CC_ETH_100G_MAC_FH2_HM_REF_CLK			74
+#define ECPRI_CC_ETH_100G_MAC_FH2_HM_REF_CLK_SRC		75
+#define ECPRI_CC_ETH_DBG_NFAPI_AXI_CLK				76
+#define ECPRI_CC_ETH_DBG_NOC_AXI_CLK				77
+#define ECPRI_CC_ETH_PHY_0_OCK_SRAM_CLK				78
+#define ECPRI_CC_ETH_PHY_0_OCK_SRAM_MUX_CLK_SRC			79
+#define ECPRI_CC_ETH_PHY_1_OCK_SRAM_CLK				80
+#define ECPRI_CC_ETH_PHY_1_OCK_SRAM_MUX_CLK_SRC			81
+#define ECPRI_CC_ETH_PHY_2_OCK_SRAM_CLK				82
+#define ECPRI_CC_ETH_PHY_2_OCK_SRAM_MUX_CLK_SRC			83
+#define ECPRI_CC_ETH_PHY_3_OCK_SRAM_CLK				84
+#define ECPRI_CC_ETH_PHY_3_OCK_SRAM_MUX_CLK_SRC			85
+#define ECPRI_CC_ETH_PHY_4_OCK_SRAM_CLK				86
+#define ECPRI_CC_ETH_PHY_4_OCK_SRAM_MUX_CLK_SRC			87
+#define ECPRI_CC_MSS_EMAC_CLK					88
+#define ECPRI_CC_MSS_EMAC_CLK_SRC				89
+#define ECPRI_CC_MSS_ORAN_CLK					90
+#define ECPRI_CC_PHY0_LANE0_RX_CLK				91
+#define ECPRI_CC_PHY0_LANE0_RX_CLK_SRC				92
+#define ECPRI_CC_PHY0_LANE0_TX_CLK				93
+#define ECPRI_CC_PHY0_LANE0_TX_CLK_SRC				94
+#define ECPRI_CC_PHY0_LANE1_RX_CLK				95
+#define ECPRI_CC_PHY0_LANE1_RX_CLK_SRC				96
+#define ECPRI_CC_PHY0_LANE1_TX_CLK				97
+#define ECPRI_CC_PHY0_LANE1_TX_CLK_SRC				98
+#define ECPRI_CC_PHY0_LANE2_RX_CLK				99
+#define ECPRI_CC_PHY0_LANE2_RX_CLK_SRC				100
+#define ECPRI_CC_PHY0_LANE2_TX_CLK				101
+#define ECPRI_CC_PHY0_LANE2_TX_CLK_SRC				102
+#define ECPRI_CC_PHY0_LANE3_RX_CLK				103
+#define ECPRI_CC_PHY0_LANE3_RX_CLK_SRC				104
+#define ECPRI_CC_PHY0_LANE3_TX_CLK				105
+#define ECPRI_CC_PHY0_LANE3_TX_CLK_SRC				106
+#define ECPRI_CC_PHY1_LANE0_RX_CLK				107
+#define ECPRI_CC_PHY1_LANE0_RX_CLK_SRC				108
+#define ECPRI_CC_PHY1_LANE0_TX_CLK				109
+#define ECPRI_CC_PHY1_LANE0_TX_CLK_SRC				110
+#define ECPRI_CC_PHY1_LANE1_RX_CLK				111
+#define ECPRI_CC_PHY1_LANE1_RX_CLK_SRC				112
+#define ECPRI_CC_PHY1_LANE1_TX_CLK				113
+#define ECPRI_CC_PHY1_LANE1_TX_CLK_SRC				114
+#define ECPRI_CC_PHY1_LANE2_RX_CLK				115
+#define ECPRI_CC_PHY1_LANE2_RX_CLK_SRC				116
+#define ECPRI_CC_PHY1_LANE2_TX_CLK				117
+#define ECPRI_CC_PHY1_LANE2_TX_CLK_SRC				118
+#define ECPRI_CC_PHY1_LANE3_RX_CLK				119
+#define ECPRI_CC_PHY1_LANE3_RX_CLK_SRC				120
+#define ECPRI_CC_PHY1_LANE3_TX_CLK				121
+#define ECPRI_CC_PHY1_LANE3_TX_CLK_SRC				122
+#define ECPRI_CC_PHY2_LANE0_RX_CLK				123
+#define ECPRI_CC_PHY2_LANE0_RX_CLK_SRC				124
+#define ECPRI_CC_PHY2_LANE0_TX_CLK				125
+#define ECPRI_CC_PHY2_LANE0_TX_CLK_SRC				126
+#define ECPRI_CC_PHY2_LANE1_RX_CLK				127
+#define ECPRI_CC_PHY2_LANE1_RX_CLK_SRC				128
+#define ECPRI_CC_PHY2_LANE1_TX_CLK				129
+#define ECPRI_CC_PHY2_LANE1_TX_CLK_SRC				130
+#define ECPRI_CC_PHY2_LANE2_RX_CLK				131
+#define ECPRI_CC_PHY2_LANE2_RX_CLK_SRC				132
+#define ECPRI_CC_PHY2_LANE2_TX_CLK				133
+#define ECPRI_CC_PHY2_LANE2_TX_CLK_SRC				134
+#define ECPRI_CC_PHY2_LANE3_RX_CLK				135
+#define ECPRI_CC_PHY2_LANE3_RX_CLK_SRC				136
+#define ECPRI_CC_PHY2_LANE3_TX_CLK				137
+#define ECPRI_CC_PHY2_LANE3_TX_CLK_SRC				138
+#define ECPRI_CC_PHY3_LANE0_RX_CLK				139
+#define ECPRI_CC_PHY3_LANE0_RX_CLK_SRC				140
+#define ECPRI_CC_PHY3_LANE0_TX_CLK				141
+#define ECPRI_CC_PHY3_LANE0_TX_CLK_SRC				142
+#define ECPRI_CC_PHY3_LANE1_RX_CLK				143
+#define ECPRI_CC_PHY3_LANE1_RX_CLK_SRC				144
+#define ECPRI_CC_PHY3_LANE1_TX_CLK				145
+#define ECPRI_CC_PHY3_LANE1_TX_CLK_SRC				146
+#define ECPRI_CC_PHY3_LANE2_RX_CLK				147
+#define ECPRI_CC_PHY3_LANE2_RX_CLK_SRC				148
+#define ECPRI_CC_PHY3_LANE2_TX_CLK				149
+#define ECPRI_CC_PHY3_LANE2_TX_CLK_SRC				150
+#define ECPRI_CC_PHY3_LANE3_RX_CLK				151
+#define ECPRI_CC_PHY3_LANE3_RX_CLK_SRC				152
+#define ECPRI_CC_PHY3_LANE3_TX_CLK				153
+#define ECPRI_CC_PHY3_LANE3_TX_CLK_SRC				154
+#define ECPRI_CC_PHY4_LANE0_RX_CLK				155
+#define ECPRI_CC_PHY4_LANE0_RX_CLK_SRC				156
+#define ECPRI_CC_PHY4_LANE0_TX_CLK				157
+#define ECPRI_CC_PHY4_LANE0_TX_CLK_SRC				158
+#define ECPRI_CC_PHY4_LANE1_RX_CLK				159
+#define ECPRI_CC_PHY4_LANE1_RX_CLK_SRC				160
+#define ECPRI_CC_PHY4_LANE1_TX_CLK				161
+#define ECPRI_CC_PHY4_LANE1_TX_CLK_SRC				162
+#define ECPRI_CC_PHY4_LANE2_RX_CLK				163
+#define ECPRI_CC_PHY4_LANE2_RX_CLK_SRC				164
+#define ECPRI_CC_PHY4_LANE2_TX_CLK				165
+#define ECPRI_CC_PHY4_LANE2_TX_CLK_SRC				166
+#define ECPRI_CC_PHY4_LANE3_RX_CLK				167
+#define ECPRI_CC_PHY4_LANE3_RX_CLK_SRC				168
+#define ECPRI_CC_PHY4_LANE3_TX_CLK				169
+#define ECPRI_CC_PHY4_LANE3_TX_CLK_SRC				170
+
+/* ECPRI_CC resets */
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ECPRI_SS_BCR		0
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_C2C_BCR		1
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_FH0_BCR		2
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_FH1_BCR		3
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_FH2_BCR		4
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_WRAPPER_TOP_BCR	5
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_MODEM_BCR			6
+#define ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_NOC_BCR			7
+
+#endif
-- 
2.25.1

