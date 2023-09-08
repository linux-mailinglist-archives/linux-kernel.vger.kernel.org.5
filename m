Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C7798294
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbjIHGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbjIHGpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:45:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EB1BDA;
        Thu,  7 Sep 2023 23:45:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885UOmh022263;
        Fri, 8 Sep 2023 06:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ywqql9ZtmQwyapHOQUYuvTKhIphYXgenezy78NLhZ1Q=;
 b=CmHjpGffqEpK/d/u/+sQMNHu/tk7sMp7GXH5alOxupA6Q70G2tW8zkeASvLoab/qQ6ZG
 9F0dWsFTJVPA4gLUekzGTzMV2iJpqSXC7oMzeImW/ISLg3sHSJgJMeFKj9XVQXRB1ZJH
 +8vk8WHLAaucu5ZW0S5Xc+ZEeeWmKsKeNIu+sPwPCrlJmmGu3BVMinLb8u1Nh7i1Poc7
 9/NPpamHQGTtJlEurFjrZN6EVLBGAu8jX/b3J7UM7EgpT6Xsv6+3F4+te4Ovz/PrJrNs
 iguIpl/LylNygZngb0kJ8NxyfjF9jnSKubwsjtTBeRO8x0iPkB/OhQ4sFfTEioWgJPyc VQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy50db3e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:45:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886j94O012591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:45:09 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:45:00 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
Date:   Fri, 8 Sep 2023 14:44:25 +0800
Message-ID: <20230908064427.26999-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230908064427.26999-1-quic_tengfan@quicinc.com>
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wBRmY1Wg6GZZHVTysnm9incAUyMNoY1n
X-Proofpoint-GUID: wBRmY1Wg6GZZHVTysnm9incAUyMNoY1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
and tuned dynamically according to the bandwidth demand.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 .../interconnect/qcom,sm4450-rpmh.yaml        | 133 ++++++++++++++
 .../dt-bindings/interconnect/qcom,sm4450.h    | 163 ++++++++++++++++++
 2 files changed, 296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm4450.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
new file mode 100644
index 000000000000..2744e4b285b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm4450-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM4450
+
+maintainers:
+  - Tengfei Fan <quic_tengfan@quicinc.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sm4450.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm4450-aggre1-noc
+      - qcom,sm4450-aggre2-noc
+      - qcom,sm4450-clk-virt
+      - qcom,sm4450-cnoc2
+      - qcom,sm4450-cnoc3
+      - qcom,sm4450-gem-noc
+      - qcom,sm4450-lpass-ag-noc
+      - qcom,sm4450-mc-virt
+      - qcom,sm4450-mmss-noc
+      - qcom,sm4450-pcie-anoc
+      - qcom,sm4450-system-noc
+      - qcom,sm4450-video-aggre-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-clk-virt
+              - qcom,sm4450-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe 0 AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+            - description: aggre-NOC USB3 AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-aggre1-noc
+              - qcom,sm4450-aggre2-noc
+              - qcom,sm4450-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm4450.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    interconnect-0 {
+        compatible = "qcom,sm4450-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@1700000 {
+        compatible = "qcom,sm4450-aggre2-noc";
+        reg = <0 0x01700000 0 0x31080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&rpmhcc RPMH_IPA_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm4450.h b/include/dt-bindings/interconnect/qcom,sm4450.h
new file mode 100644
index 000000000000..92aa5454809f
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm4450.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM4450_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM4450_H
+
+#define MASTER_QUP_0				0
+#define MASTER_A1NOC_CFG			1
+#define MASTER_SDCC_2				2
+#define SLAVE_A1NOC_SNOC			3
+#define SLAVE_SERVICE_A1NOC			4
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_1				1
+#define MASTER_A2NOC_CFG			2
+#define MASTER_CNOC_A2NOC			3
+#define MASTER_CRYPTO				4
+#define MASTER_IPA				5
+#define MASTER_WLAN				6
+#define MASTER_QDSS_ETR				7
+#define MASTER_QDSS_ETR_1			8
+#define MASTER_SDCC_1				9
+#define MASTER_UFS_MEM				10
+#define MASTER_USB3_0				11
+#define SLAVE_A2NOC_SNOC			12
+#define SLAVE_SERVICE_A2NOC			13
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+#define MASTER_CNOC3_CNOC2			0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_SOUTH			2
+#define SLAVE_AHB2PHY_NORTH			3
+#define SLAVE_ANOC_THROTTLE_CFG			4
+#define SLAVE_CAMERA_CFG			5
+#define SLAVE_CLK_CTL				6
+#define SLAVE_RBCPR_CX_CFG			7
+#define SLAVE_RBCPR_MX_CFG			8
+#define SLAVE_CRYPTO_0_CFG			9
+#define SLAVE_CX_RDPM				10
+#define SLAVE_DISPLAY_CFG			11
+#define SLAVE_GFX3D_CFG				12
+#define SLAVE_IMEM_CFG				13
+#define SLAVE_IPA_CFG				14
+#define SLAVE_IPC_ROUTER_CFG			15
+#define SLAVE_LPASS				16
+#define SLAVE_CNOC_MSS				17
+#define SLAVE_MX_RDPM				18
+#define SLAVE_PCIE_0_CFG			19
+#define SLAVE_PDM				20
+#define SLAVE_PIMEM_CFG				21
+#define SLAVE_PMU_WRAPPER_CFG			22
+#define SLAVE_PRNG				23
+#define SLAVE_QUP_0				24
+#define SLAVE_QUP_1				25
+#define SLAVE_SDC1				26
+#define SLAVE_SDCC_2				27
+#define SLAVE_TCSR				28
+#define SLAVE_TLMM				29
+#define SLAVE_UFS_MEM_CFG			30
+#define SLAVE_USB3_0				31
+#define SLAVE_VENUS_CFG				32
+#define SLAVE_VSENSE_CTRL_CFG			33
+#define SLAVE_A1NOC_CFG				34
+#define SLAVE_A2NOC_CFG				35
+#define SLAVE_CNOC2_CNOC3			36
+#define SLAVE_CNOC_MNOC_CFG			37
+#define SLAVE_PCIE_ANOC_CFG			38
+#define SLAVE_SNOC_CFG				39
+#define SLAVE_VIDEO_ANOC_CFG			40
+
+#define MASTER_CNOC2_CNOC3			0
+#define MASTER_GEM_NOC_CNOC			1
+#define MASTER_GEM_NOC_PCIE_SNOC		2
+#define SLAVE_AOSS				3
+#define SLAVE_APPSS				4
+#define SLAVE_QDSS_CFG				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_WLAN				7
+#define SLAVE_CNOC3_CNOC2			8
+#define SLAVE_CNOC_A2NOC			9
+#define SLAVE_BOOT_IMEM				10
+#define SLAVE_IMEM				11
+#define SLAVE_PIMEM				12
+#define SLAVE_PCIE_0				13
+#define SLAVE_QDSS_STM				14
+#define SLAVE_TCU				15
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_MSS_PROC				4
+#define MASTER_MNOC_HF_MEM_NOC			5
+#define MASTER_MNOC_SF_MEM_NOC			6
+#define MASTER_ANOC_PCIE_GEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC			8
+#define MASTER_SNOC_SF_MEM_NOC			9
+#define MASTER_WLAN_Q6				10
+#define SLAVE_GEM_NOC_CNOC			11
+#define SLAVE_LLCC				12
+#define SLAVE_MEM_NOC_PCIE_SNOC			13
+#define MASTER_MNOC_HF_MEM_NOC_DISP		14
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		15
+#define SLAVE_LLCC_DISP				16
+
+#define MASTER_CNOC_LPASS_AG_NOC		0
+#define MASTER_LPASS_PROC			1
+#define SLAVE_LPASS_CORE_CFG			2
+#define SLAVE_LPASS_LPI_CFG			3
+#define SLAVE_LPASS_MPU_CFG			4
+#define SLAVE_LPASS_TOP_CFG			5
+#define SLAVE_LPASS_SNOC			6
+#define SLAVE_SERVICES_LPASS_AML_NOC		7
+#define SLAVE_SERVICE_LPASS_AG_NOC		8
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CNOC_MNOC_CFG			4
+#define MASTER_VIDEO_P0_MMNOC			5
+#define MASTER_VIDEO_PROC_MMNOC			6
+#define SLAVE_MNOC_HF_MEM_NOC			7
+#define SLAVE_MNOC_SF_MEM_NOC			8
+#define SLAVE_SERVICE_MNOC			9
+#define MASTER_MDP_DISP				10
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		11
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
+#define SLAVE_SERVICE_PCIE_ANOC			3
+
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_LPASS_ANOC			3
+#define MASTER_SNOC_CFG				4
+#define MASTER_PIMEM				5
+#define MASTER_GIC				6
+#define SLAVE_SNOC_GEM_NOC_GC			7
+#define SLAVE_SNOC_GEM_NOC_SF			8
+#define SLAVE_SERVICE_SNOC			9
+
+#define MASTER_VIDEO_ANOC_CFG			0
+#define MASTER_VIDEO_P0				1
+#define MASTER_VIDEO_PROC			2
+#define SLAVE_VIDEO_0_ANOC_MMNOC		3
+#define SLAVE_VIDEO_1_ANOC_MMNOC		4
+#define SLAVE_SERVICE_SRVC_VIDEO_ANOC		5
+
+#endif
-- 
2.17.1

