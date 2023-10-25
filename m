Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BEF7D6D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjJYNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjJYNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:41:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7566B131;
        Wed, 25 Oct 2023 06:41:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCM40d023900;
        Wed, 25 Oct 2023 13:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ayeXE2kcwAkv2Ihp9/GajyrmPCMq8eMYUy69YUtiBGs=;
 b=GPCQ4xeOSQ7x2zPDUkGfIOsfvxNuZ6PYbi0JPCmA/WdypdTCWKptfrmmV4qLGBpMi2yd
 dDJJGrKAVlcVMoPGbTiZXfXd2EaS5qwe4qiRPzvxXJ7UKUT/KfBOlTZIr0bvYoNsvxqc
 OlGgqUU6CKrptlj540wivPZZa4y/AfpMSCijwHo5ksp1W2ZwmPIvEs1kFRVwsplyJFp6
 EI/v/s4DhNlpWvVW1yw3PIXNBS6aayb0BEKwXoDTxpQfFGaAi+WmLTha4TyA4b0lnQ/2
 MB7+5yIJdVI+sk2QS6nwFWsJa88tXLA4G7oDxQx6eXwB+jczMgzAnw/7QRp+/K6FZ+Wh Dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty0tu0d5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:41:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PDfDK3009871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:41:13 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 06:41:08 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SC8380XP SoC
Date:   Wed, 25 Oct 2023 19:10:48 +0530
Message-ID: <20231025134049.9734-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025134049.9734-1-quic_sibis@quicinc.com>
References: <20231025134049.9734-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lnrlp4XsVmxwdajyz0lUg1MW6pmnjPrJ
X-Proofpoint-GUID: lnrlp4XsVmxwdajyz0lUg1MW6pmnjPrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310250118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <quic_rjendra@quicinc.com>

The Qualcomm SC8380XP SoC has several bus fabrics that could be controlled
and tuned dynamically according to the bandwidth demand.

Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../interconnect/qcom,sc8380xp-rpmh.yaml      |  83 +++++++
 .../interconnect/qcom,sc8380xp-rpmh.h         | 207 ++++++++++++++++++
 2 files changed, 290 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8380xp-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sc8380xp-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8380xp-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8380xp-rpmh.yaml
new file mode 100644
index 000000000000..b98734b87c83
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8380xp-rpmh.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc8380xp-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SC8380XP
+
+maintainers:
+  - Rajendra Nayak <quic_rjendra@quicinc.com>
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also:: include/dt-bindings/interconnect/qcom,sc8380xp-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8380xp-aggre1-noc
+      - qcom,sc8380xp-aggre2-noc
+      - qcom,sc8380xp-clk-virt
+      - qcom,sc8380xp-cnoc-cfg
+      - qcom,sc8380xp-cnoc-main
+      - qcom,sc8380xp-gem-noc
+      - qcom,sc8380xp-lpass-ag-noc
+      - qcom,sc8380xp-lpass-lpiaon-noc
+      - qcom,sc8380xp-lpass-lpicx-noc
+      - qcom,sc8380xp-mc-virt
+      - qcom,sc8380xp-mmss-noc
+      - qcom,sc8380xp-nsp-noc
+      - qcom,sc8380xp-pcie-center-anoc
+      - qcom,sc8380xp-pcie-north-anoc
+      - qcom,sc8380xp-pcie-south-anoc
+      - qcom,sc8380xp-system-noc
+      - qcom,sc8380xp-usb-center-anoc
+      - qcom,sc8380xp-usb-north-anoc
+      - qcom,sc8380xp-usb-south-anoc
+
+  reg:
+    maxItems: 1
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8380xp-clk-virt
+              - qcom,sc8380xp-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clk_virt: interconnect-0 {
+      compatible = "qcom,sc8380xp-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,sc8380xp-aggre1-noc";
+      reg = <0x016e0000 0x14400>;
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sc8380xp-rpmh.h b/include/dt-bindings/interconnect/qcom,sc8380xp-rpmh.h
new file mode 100644
index 000000000000..93f1e05c2f70
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sc8380xp-rpmh.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC8380XP_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SC8380XP_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_SDCC_4				2
+#define MASTER_UFS_MEM				3
+#define SLAVE_A1NOC_SNOC			4
+
+#define MASTER_QUP_0				0
+#define MASTER_QUP_2				1
+#define MASTER_CRYPTO				2
+#define MASTER_SP				3
+#define MASTER_QDSS_ETR				4
+#define MASTER_QDSS_ETR_1			5
+#define MASTER_SDCC_2				6
+#define SLAVE_A2NOC_SNOC			7
+
+#define MASTER_DDR_PERF_MODE			0
+#define MASTER_QUP_CORE_0			1
+#define MASTER_QUP_CORE_1			2
+#define MASTER_QUP_CORE_2			3
+#define SLAVE_DDR_PERF_MODE			4
+#define SLAVE_QUP_CORE_0			5
+#define SLAVE_QUP_CORE_1			6
+#define SLAVE_QUP_CORE_2			7
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_AHB2PHY_2				3
+#define SLAVE_AV1_ENC_CFG			4
+#define SLAVE_CAMERA_CFG			5
+#define SLAVE_CLK_CTL				6
+#define SLAVE_CRYPTO_0_CFG			7
+#define SLAVE_DISPLAY_CFG			8
+#define SLAVE_GFX3D_CFG				9
+#define SLAVE_IMEM_CFG				10
+#define SLAVE_IPC_ROUTER_CFG			11
+#define SLAVE_PCIE_0_CFG			12
+#define SLAVE_PCIE_1_CFG			13
+#define SLAVE_PCIE_2_CFG			14
+#define SLAVE_PCIE_3_CFG			15
+#define SLAVE_PCIE_4_CFG			16
+#define SLAVE_PCIE_5_CFG			17
+#define SLAVE_PCIE_6A_CFG			18
+#define SLAVE_PCIE_6B_CFG			19
+#define SLAVE_PCIE_RSC_CFG			20
+#define SLAVE_PDM				21
+#define SLAVE_PRNG				22
+#define SLAVE_QDSS_CFG				23
+#define SLAVE_QSPI_0				24
+#define SLAVE_QUP_0				25
+#define SLAVE_QUP_1				26
+#define SLAVE_QUP_2				27
+#define SLAVE_SDCC_2				28
+#define SLAVE_SDCC_4				29
+#define SLAVE_SMMUV3_CFG			30
+#define SLAVE_TCSR				31
+#define SLAVE_TLMM				32
+#define SLAVE_UFS_MEM_CFG			33
+#define SLAVE_USB2				34
+#define SLAVE_USB3_0				35
+#define SLAVE_USB3_1				36
+#define SLAVE_USB3_2				37
+#define SLAVE_USB3_MP				38
+#define SLAVE_USB4_0				39
+#define SLAVE_USB4_1				40
+#define SLAVE_USB4_2				41
+#define SLAVE_VENUS_CFG				42
+#define SLAVE_LPASS_QTB_CFG			43
+#define SLAVE_CNOC_MNOC_CFG			44
+#define SLAVE_NSP_QTB_CFG			45
+#define SLAVE_QDSS_STM				46
+#define SLAVE_TCU				47
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_TME_CFG				3
+#define SLAVE_APPSS				4
+#define SLAVE_CNOC_CFG				5
+#define SLAVE_BOOT_IMEM				6
+#define SLAVE_IMEM				7
+#define SLAVE_PCIE_0				8
+#define SLAVE_PCIE_1				9
+#define SLAVE_PCIE_2				10
+#define SLAVE_PCIE_3				11
+#define SLAVE_PCIE_4				12
+#define SLAVE_PCIE_5				13
+#define SLAVE_PCIE_6A				14
+#define SLAVE_PCIE_6B				15
+
+#define MASTER_GPU_TCU				0
+#define MASTER_PCIE_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_APPSS_PROC			3
+#define MASTER_GFX3D				4
+#define MASTER_LPASS_GEM_NOC			5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC			10
+#define MASTER_GIC2				11
+#define SLAVE_GEM_NOC_CNOC			12
+#define SLAVE_LLCC				13
+#define SLAVE_MEM_NOC_PCIE_SNOC			14
+#define MASTER_MNOC_HF_MEM_NOC_DISP		15
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		16
+#define SLAVE_LLCC_DISP				17
+#define MASTER_ANOC_PCIE_GEM_NOC_PCIE		18
+#define SLAVE_LLCC_PCIE				19
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+#define MASTER_LLCC_PCIE			4
+#define SLAVE_EBI1_PCIE				5
+
+#define MASTER_AV1_ENC				0
+#define MASTER_CAMNOC_HF			1
+#define MASTER_CAMNOC_ICP			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_EVA				4
+#define MASTER_MDP				5
+#define MASTER_VIDEO				6
+#define MASTER_VIDEO_CV_PROC			7
+#define MASTER_VIDEO_V_PROC			8
+#define MASTER_CNOC_MNOC_CFG			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+#define MASTER_MDP_DISP				13
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_NORTH			0
+#define MASTER_PCIE_SOUTH			0
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define MASTER_PCIE_NORTH_PCIE			4
+#define MASTER_PCIE_SOUTH_PCIE			5
+#define SLAVE_ANOC_PCIE_GEM_NOC_PCIE		6
+
+#define MASTER_PCIE_3				0
+#define MASTER_PCIE_4				1
+#define MASTER_PCIE_5				2
+#define SLAVE_PCIE_NORTH			3
+#define MASTER_PCIE_3_PCIE			4
+#define MASTER_PCIE_4_PCIE			5
+#define MASTER_PCIE_5_PCIE			6
+#define SLAVE_PCIE_NORTH_PCIE			7
+
+#define MASTER_PCIE_0				0
+#define MASTER_PCIE_1				1
+#define MASTER_PCIE_2				2
+#define MASTER_PCIE_6A				3
+#define MASTER_PCIE_6B				4
+#define SLAVE_PCIE_SOUTH			5
+#define MASTER_PCIE_0_PCIE			6
+#define MASTER_PCIE_1_PCIE			7
+#define MASTER_PCIE_2_PCIE			8
+#define MASTER_PCIE_6A_PCIE			9
+#define MASTER_PCIE_6B_PCIE			10
+#define SLAVE_PCIE_SOUTH_PCIE			11
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_GIC1				2
+#define MASTER_USB_NOC_SNOC			3
+#define SLAVE_SNOC_GEM_NOC_SF			4
+
+#define MASTER_AGGRE_USB_NORTH			0
+#define MASTER_AGGRE_USB_SOUTH			1
+#define SLAVE_USB_NOC_SNOC			2
+
+#define MASTER_USB2				0
+#define MASTER_USB3_MP				1
+#define SLAVE_AGGRE_USB_NORTH			2
+
+#define MASTER_USB3_0				0
+#define MASTER_USB3_1				1
+#define MASTER_USB3_2				2
+#define MASTER_USB4_0				3
+#define MASTER_USB4_1				4
+#define MASTER_USB4_2				5
+#define SLAVE_AGGRE_USB_SOUTH			6
+
+#endif
-- 
2.17.1

