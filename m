Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63257E01DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377625AbjKCKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377623AbjKCKtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:49:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F61213E;
        Fri,  3 Nov 2023 03:49:25 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3AfjCT007327;
        Fri, 3 Nov 2023 10:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=D/ip2igUaqT5q8X2/fMvDv1y0Nm1o6wFUX4WDzyWlbU=;
 b=K3MtycnZS+s/HKxFLvxUAc1iFFbWMHJPGuXoDq5b8429Xwvfsg5HD+BPU89K/GywjSyJ
 ZBaqoNGseGKVUfZj3XWHeEu7nGiXiu4GJ0Dk2wzK0ZddIcjENj0UGoHLmZprXollyib3
 rLiJ40jSqZy82nZg24HFtuAb3I4+5iZKIQDMd3v0Fhl+LqVehq5QVM3aK66p6daSPoqC
 UAJhf9giDk7uu2F2edn4in/9bwffVRwWT182bhZAoZJ0XMXBbRpDn/k6C0NgauHYG6dd
 vJAK8Cn4oSUHQsNq5z7mtKSv9Kry0qhu7K6hnRbeSPZMA+kW4s4G19tE2FY9ZRy5dLhD dg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4qfygx2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 10:49:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3An8f4003647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 10:49:08 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 03:49:05 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v11 2/4] dt-bindings: clock: add qca8386/qca8084 clock and reset definitions
Date:   Fri, 3 Nov 2023 18:48:44 +0800
Message-ID: <20231103104846.30875-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103104846.30875-1-quic_luoj@quicinc.com>
References: <20231103104846.30875-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EqejWWIr9Xni43K-sRg3ZI-vrttCp1_w
X-Proofpoint-GUID: EqejWWIr9Xni43K-sRg3ZI-vrttCp1_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA8386/QCA8084 includes the clock & reset controller that is
accessed by MDIO bus. Two work modes are supported, qca8386 works
as switch mode, qca8084 works as PHY mode.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/qcom,qca8k-nsscc.yaml      |  79 ++++++++++++++
 include/dt-bindings/clock/qcom,qca8k-nsscc.h  | 101 ++++++++++++++++++
 include/dt-bindings/reset/qcom,qca8k-nsscc.h  |  75 +++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
 create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
new file mode 100644
index 000000000000..21e7c4150b6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,qca8k-nsscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm NSS Clock & Reset Controller on QCA8386/QCA8084
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Luo Jie <quic_luoj@quicinc.com>
+
+description: |
+  Qualcomm NSS clock control module provides the clocks and resets
+  on QCA8386(switch mode)/QCA8084(PHY mode)
+
+  See also::
+    include/dt-bindings/clock/qcom,qca8k-nsscc.h
+    include/dt-bindings/reset/qcom,qca8k-nsscc.h
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,qca8084-nsscc
+      - items:
+          - enum:
+              - qcom,qca8082-nsscc
+              - qcom,qca8085-nsscc
+              - qcom,qca8384-nsscc
+              - qcom,qca8385-nsscc
+              - qcom,qca8386-nsscc
+          - const: qcom,qca8084-nsscc
+
+  clocks:
+    items:
+      - description: Chip XO source
+      - description: UNIPHY0 RX 312P5M/125M clock source
+      - description: UNIPHY0 TX 312P5M/125M clock source
+      - description: UNIPHY1 RX 312P5M/125M clock source
+      - description: UNIPHY1 TX 312P5M/125M clock source
+      - description: UNIPHY1 RX 312P5M clock source
+      - description: UNIPHY1 TX 312P5M clock source
+
+  reg:
+    items:
+      - description: MDIO bus address for Clock & Reset Controller register
+
+required:
+  - compatible
+  - clocks
+  - reg
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      clock-controller@18 {
+        compatible = "qcom,qca8084-nsscc";
+        reg = <0x18>;
+        clocks = <&qca8k_xo>,
+                 <&qca8k_uniphy0_rx>,
+                 <&qca8k_uniphy0_tx>,
+                 <&qca8k_uniphy1_rx>,
+                 <&qca8k_uniphy1_tx>,
+                 <&qca8k_uniphy1_rx312p5m>,
+                 <&qca8k_uniphy1_tx312p5m>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+      };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,qca8k-nsscc.h b/include/dt-bindings/clock/qcom,qca8k-nsscc.h
new file mode 100644
index 000000000000..0ac3e4c69a1a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,qca8k-nsscc.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_QCA8K_NSS_CC_H
+#define _DT_BINDINGS_CLK_QCOM_QCA8K_NSS_CC_H
+
+#define NSS_CC_SWITCH_CORE_CLK_SRC				0
+#define NSS_CC_SWITCH_CORE_CLK					1
+#define NSS_CC_APB_BRIDGE_CLK					2
+#define NSS_CC_MAC0_TX_CLK_SRC					3
+#define NSS_CC_MAC0_TX_DIV_CLK_SRC				4
+#define NSS_CC_MAC0_TX_CLK					5
+#define NSS_CC_MAC0_TX_SRDS1_CLK				6
+#define NSS_CC_MAC0_RX_CLK_SRC					7
+#define NSS_CC_MAC0_RX_DIV_CLK_SRC				8
+#define NSS_CC_MAC0_RX_CLK					9
+#define NSS_CC_MAC0_RX_SRDS1_CLK				10
+#define NSS_CC_MAC1_TX_CLK_SRC					11
+#define NSS_CC_MAC1_TX_DIV_CLK_SRC				12
+#define NSS_CC_MAC1_SRDS1_CH0_XGMII_RX_DIV_CLK_SRC		13
+#define NSS_CC_MAC1_SRDS1_CH0_RX_CLK				14
+#define NSS_CC_MAC1_TX_CLK					15
+#define NSS_CC_MAC1_GEPHY0_TX_CLK				16
+#define NSS_CC_MAC1_SRDS1_CH0_XGMII_RX_CLK			17
+#define NSS_CC_MAC1_RX_CLK_SRC					18
+#define NSS_CC_MAC1_RX_DIV_CLK_SRC				19
+#define NSS_CC_MAC1_SRDS1_CH0_XGMII_TX_DIV_CLK_SRC		20
+#define NSS_CC_MAC1_SRDS1_CH0_TX_CLK				21
+#define NSS_CC_MAC1_RX_CLK					22
+#define NSS_CC_MAC1_GEPHY0_RX_CLK				23
+#define NSS_CC_MAC1_SRDS1_CH0_XGMII_TX_CLK			24
+#define NSS_CC_MAC2_TX_CLK_SRC					25
+#define NSS_CC_MAC2_TX_DIV_CLK_SRC				26
+#define NSS_CC_MAC2_SRDS1_CH1_XGMII_RX_DIV_CLK_SRC		27
+#define NSS_CC_MAC2_SRDS1_CH1_RX_CLK				28
+#define NSS_CC_MAC2_TX_CLK					29
+#define NSS_CC_MAC2_GEPHY1_TX_CLK				30
+#define NSS_CC_MAC2_SRDS1_CH1_XGMII_RX_CLK			31
+#define NSS_CC_MAC2_RX_CLK_SRC					32
+#define NSS_CC_MAC2_RX_DIV_CLK_SRC				33
+#define NSS_CC_MAC2_SRDS1_CH1_XGMII_TX_DIV_CLK_SRC		34
+#define NSS_CC_MAC2_SRDS1_CH1_TX_CLK				35
+#define NSS_CC_MAC2_RX_CLK					36
+#define NSS_CC_MAC2_GEPHY1_RX_CLK				37
+#define NSS_CC_MAC2_SRDS1_CH1_XGMII_TX_CLK			38
+#define NSS_CC_MAC3_TX_CLK_SRC					39
+#define NSS_CC_MAC3_TX_DIV_CLK_SRC				40
+#define NSS_CC_MAC3_SRDS1_CH2_XGMII_RX_DIV_CLK_SRC		41
+#define NSS_CC_MAC3_SRDS1_CH2_RX_CLK				42
+#define NSS_CC_MAC3_TX_CLK					43
+#define NSS_CC_MAC3_GEPHY2_TX_CLK				44
+#define NSS_CC_MAC3_SRDS1_CH2_XGMII_RX_CLK			45
+#define NSS_CC_MAC3_RX_CLK_SRC					46
+#define NSS_CC_MAC3_RX_DIV_CLK_SRC				47
+#define NSS_CC_MAC3_SRDS1_CH2_XGMII_TX_DIV_CLK_SRC		48
+#define NSS_CC_MAC3_SRDS1_CH2_TX_CLK				49
+#define NSS_CC_MAC3_RX_CLK					50
+#define NSS_CC_MAC3_GEPHY2_RX_CLK				51
+#define NSS_CC_MAC3_SRDS1_CH2_XGMII_TX_CLK			52
+#define NSS_CC_MAC4_TX_CLK_SRC					53
+#define NSS_CC_MAC4_TX_DIV_CLK_SRC				54
+#define NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_DIV_CLK_SRC		55
+#define NSS_CC_MAC4_SRDS1_CH3_RX_CLK				56
+#define NSS_CC_MAC4_TX_CLK					57
+#define NSS_CC_MAC4_GEPHY3_TX_CLK				58
+#define NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_CLK			59
+#define NSS_CC_MAC4_RX_CLK_SRC					60
+#define NSS_CC_MAC4_RX_DIV_CLK_SRC				61
+#define NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_DIV_CLK_SRC		62
+#define NSS_CC_MAC4_SRDS1_CH3_TX_CLK				63
+#define NSS_CC_MAC4_RX_CLK					64
+#define NSS_CC_MAC4_GEPHY3_RX_CLK				65
+#define NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_CLK			66
+#define NSS_CC_MAC5_TX_CLK_SRC					67
+#define NSS_CC_MAC5_TX_DIV_CLK_SRC				68
+#define NSS_CC_MAC5_TX_SRDS0_CLK				69
+#define NSS_CC_MAC5_TX_CLK					70
+#define NSS_CC_MAC5_RX_CLK_SRC					71
+#define NSS_CC_MAC5_RX_DIV_CLK_SRC				72
+#define NSS_CC_MAC5_RX_SRDS0_CLK				73
+#define NSS_CC_MAC5_RX_CLK					74
+#define NSS_CC_MAC5_TX_SRDS0_CLK_SRC				75
+#define NSS_CC_MAC5_RX_SRDS0_CLK_SRC				76
+#define NSS_CC_AHB_CLK_SRC					77
+#define NSS_CC_AHB_CLK						78
+#define NSS_CC_SEC_CTRL_AHB_CLK					79
+#define NSS_CC_TLMM_CLK						80
+#define NSS_CC_TLMM_AHB_CLK					81
+#define NSS_CC_CNOC_AHB_CLK					82
+#define NSS_CC_MDIO_AHB_CLK					83
+#define NSS_CC_MDIO_MASTER_AHB_CLK				84
+#define NSS_CC_SYS_CLK_SRC					85
+#define NSS_CC_SRDS0_SYS_CLK					86
+#define NSS_CC_SRDS1_SYS_CLK					87
+#define NSS_CC_GEPHY0_SYS_CLK					88
+#define NSS_CC_GEPHY1_SYS_CLK					89
+#define NSS_CC_GEPHY2_SYS_CLK					90
+#define NSS_CC_GEPHY3_SYS_CLK					91
+#endif
diff --git a/include/dt-bindings/reset/qcom,qca8k-nsscc.h b/include/dt-bindings/reset/qcom,qca8k-nsscc.h
new file mode 100644
index 000000000000..79121a513823
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,qca8k-nsscc.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_QCA8K_NSS_CC_H
+#define _DT_BINDINGS_RESET_QCOM_QCA8K_NSS_CC_H
+
+#define NSS_CC_SWITCH_CORE_ARES				1
+#define NSS_CC_APB_BRIDGE_ARES				2
+#define NSS_CC_MAC0_TX_ARES				3
+#define NSS_CC_MAC0_TX_SRDS1_ARES			4
+#define NSS_CC_MAC0_RX_ARES				5
+#define NSS_CC_MAC0_RX_SRDS1_ARES			6
+#define NSS_CC_MAC1_SRDS1_CH0_RX_ARES			7
+#define NSS_CC_MAC1_TX_ARES				8
+#define NSS_CC_MAC1_GEPHY0_TX_ARES			9
+#define NSS_CC_MAC1_SRDS1_CH0_XGMII_RX_ARES		10
+#define NSS_CC_MAC1_SRDS1_CH0_TX_ARES			11
+#define NSS_CC_MAC1_RX_ARES				12
+#define NSS_CC_MAC1_GEPHY0_RX_ARES			13
+#define NSS_CC_MAC1_SRDS1_CH0_XGMII_TX_ARES		14
+#define NSS_CC_MAC2_SRDS1_CH1_RX_ARES			15
+#define NSS_CC_MAC2_TX_ARES				16
+#define NSS_CC_MAC2_GEPHY1_TX_ARES			17
+#define NSS_CC_MAC2_SRDS1_CH1_XGMII_RX_ARES		18
+#define NSS_CC_MAC2_SRDS1_CH1_TX_ARES			19
+#define NSS_CC_MAC2_RX_ARES				20
+#define NSS_CC_MAC2_GEPHY1_RX_ARES			21
+#define NSS_CC_MAC2_SRDS1_CH1_XGMII_TX_ARES		22
+#define NSS_CC_MAC3_SRDS1_CH2_RX_ARES			23
+#define NSS_CC_MAC3_TX_ARES				24
+#define NSS_CC_MAC3_GEPHY2_TX_ARES			25
+#define NSS_CC_MAC3_SRDS1_CH2_XGMII_RX_ARES		26
+#define NSS_CC_MAC3_SRDS1_CH2_TX_ARES			27
+#define NSS_CC_MAC3_RX_ARES				28
+#define NSS_CC_MAC3_GEPHY2_RX_ARES			29
+#define NSS_CC_MAC3_SRDS1_CH2_XGMII_TX_ARES		30
+#define NSS_CC_MAC4_SRDS1_CH3_RX_ARES			31
+#define NSS_CC_MAC4_TX_ARES				32
+#define NSS_CC_MAC4_GEPHY3_TX_ARES			33
+#define NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_ARES		34
+#define NSS_CC_MAC4_SRDS1_CH3_TX_ARES			35
+#define NSS_CC_MAC4_RX_ARES				36
+#define NSS_CC_MAC4_GEPHY3_RX_ARES			37
+#define NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_ARES		38
+#define NSS_CC_MAC5_TX_ARES				39
+#define NSS_CC_MAC5_TX_SRDS0_ARES			40
+#define NSS_CC_MAC5_RX_ARES				41
+#define NSS_CC_MAC5_RX_SRDS0_ARES			42
+#define NSS_CC_AHB_ARES					43
+#define NSS_CC_SEC_CTRL_AHB_ARES			44
+#define NSS_CC_TLMM_ARES				45
+#define NSS_CC_TLMM_AHB_ARES				46
+#define NSS_CC_CNOC_AHB_ARES				47
+#define NSS_CC_MDIO_AHB_ARES				48
+#define NSS_CC_MDIO_MASTER_AHB_ARES			49
+#define NSS_CC_SRDS0_SYS_ARES				50
+#define NSS_CC_SRDS1_SYS_ARES				51
+#define NSS_CC_GEPHY0_SYS_ARES				52
+#define NSS_CC_GEPHY1_SYS_ARES				53
+#define NSS_CC_GEPHY2_SYS_ARES				54
+#define NSS_CC_GEPHY3_SYS_ARES				55
+#define NSS_CC_SEC_CTRL_ARES				56
+#define NSS_CC_SEC_CTRL_SENSE_ARES			57
+#define NSS_CC_SLEEP_ARES				58
+#define NSS_CC_DEBUG_ARES				59
+#define NSS_CC_GEPHY0_ARES				60
+#define NSS_CC_GEPHY1_ARES				61
+#define NSS_CC_GEPHY2_ARES				62
+#define NSS_CC_GEPHY3_ARES				63
+#define NSS_CC_DSP_ARES					64
+#define NSS_CC_GLOBAL_ARES				65
+#define NSS_CC_XPCS_ARES				66
+#endif
-- 
2.42.0

