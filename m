Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9979EABC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjIMOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbjIMOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:14:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430E5FD4;
        Wed, 13 Sep 2023 07:11:12 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBo2Lj011668;
        Wed, 13 Sep 2023 14:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=w1pOJP290lRzLyQvRfScUs84cKyWbW1WfCZWOXIqzZ4=;
 b=bpolpPSbcPg40mpmXvLOxwXIdXcXeSA02aywnzPexYn2aCVISxvyMb96enqKLI2jO31I
 SrjfsjK1Yp5LjOWO86FtZf61Lz1RgQrrbiKZaxdxiCjT157IcHiSSofWjIHwsLTwivV7
 kcSIwzCYgvW4/7mJqkHAw29VMwKu53ncg07sQPcDBbb6pKBkIQkFj2gJOoCn5XU48vDJ
 Dwt9boWM935Mu/wqqRhpuAphX/6osv91RxSBQ52q9pk6QaVQM6953f+wCS0OvwoCJmbs
 Dr00LFqaBv9ab/3/JpdhOCjaxGMqRV7wHhadTvgU5JL7c/lNr0G9IninF/lAVqvqHAaD aw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8q1qc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 14:11:02 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38DE63BZ002094;
        Wed, 13 Sep 2023 14:10:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t0hskt7mp-1;
        Wed, 13 Sep 2023 14:10:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DEAweU007623;
        Wed, 13 Sep 2023 14:10:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38DEAwDQ007621;
        Wed, 13 Sep 2023 14:10:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C39281D65; Wed, 13 Sep 2023 19:40:57 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add compatibles for SDX75
Date:   Wed, 13 Sep 2023 19:40:55 +0530
Message-Id: <1694614256-24109-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694614256-24109-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1694614256-24109-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LfSKx2jTGIqxVQcgZVu2GwgB--679GYz
X-Proofpoint-GUID: LfSKx2jTGIqxVQcgZVu2GwgB--679GYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings compatibles and interconnect IDs for
Qualcomm SDX75 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,sdx75-rpmh.yaml     |  92 +++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sdx75.h      | 102 +++++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
new file mode 100644
index 0000000..71cf7e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdx75-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SDX75
+
+maintainers:
+  - Rohit Agarwal <quic_rohiagar@quicinc.com>
+
+description:
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdx75-clk-virt
+      - qcom,sdx75-dc-noc
+      - qcom,sdx75-gem-noc
+      - qcom,sdx75-mc-virt
+      - qcom,sdx75-pcie-anoc
+      - qcom,sdx75-system-noc
+
+  '#interconnect-cells': true
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
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
+              - qcom,sdx75-clk-virt
+              - qcom,sdx75-mc-virt
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
+              - qcom,sdx75-clk-virt
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC QPIC Clock
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
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    clk_virt: interconnect-0 {
+            compatible = "qcom,sdx75-clk-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+            clocks = <&rpmhcc RPMH_QPIC_CLK>;
+    };
+
+    system_noc: interconnect@1640000 {
+            compatible = "qcom,sdx75-system-noc";
+            reg = <0x1640000 0x4b400>;
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sdx75.h b/include/dt-bindings/interconnect/qcom,sdx75.h
new file mode 100644
index 0000000..e903f5f
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdx75.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
+
+#define MASTER_QPIC_CORE		0
+#define MASTER_QUP_CORE_0		1
+#define SLAVE_QPIC_CORE			2
+#define SLAVE_QUP_CORE_0		3
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI1			1
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LAGG_CFG			1
+#define SLAVE_MCCC_MASTER		2
+#define SLAVE_GEM_NOC_CFG		3
+#define SLAVE_SNOOP_BWMON		4
+
+#define MASTER_SYS_TCU			0
+#define MASTER_APPSS_PROC		1
+#define MASTER_GEM_NOC_CFG		2
+#define MASTER_MSS_PROC			3
+#define MASTER_ANOC_PCIE_GEM_NOC	4
+#define MASTER_SNOC_SF_MEM_NOC		5
+#define MASTER_GIC			6
+#define MASTER_IPA_PCIE			7
+#define SLAVE_GEM_NOC_CNOC		8
+#define SLAVE_LLCC			9
+#define SLAVE_MEM_NOC_PCIE_SNOC		10
+#define SLAVE_SERVICE_GEM_NOC		11
+
+#define MASTER_PCIE_0			0
+#define MASTER_PCIE_1			1
+#define MASTER_PCIE_2			2
+#define SLAVE_ANOC_PCIE_GEM_NOC		3
+
+#define MASTER_AUDIO			0
+#define MASTER_GIC_AHB			1
+#define MASTER_PCIE_RSCC		2
+#define MASTER_QDSS_BAM			3
+#define MASTER_QPIC			4
+#define MASTER_QUP_0			5
+#define MASTER_ANOC_SNOC		6
+#define MASTER_GEM_NOC_CNOC		7
+#define MASTER_GEM_NOC_PCIE_SNOC	8
+#define MASTER_SNOC_CFG			9
+#define MASTER_PCIE_ANOC_CFG		10
+#define MASTER_CRYPTO			11
+#define MASTER_IPA			12
+#define MASTER_MVMSS			13
+#define MASTER_EMAC_0			14
+#define MASTER_EMAC_1			15
+#define MASTER_QDSS_ETR			16
+#define MASTER_QDSS_ETR_1		17
+#define MASTER_SDCC_1			18
+#define MASTER_SDCC_4			19
+#define MASTER_USB3_0			20
+#define SLAVE_ETH0_CFG			21
+#define SLAVE_ETH1_CFG			22
+#define SLAVE_AUDIO			23
+#define SLAVE_CLK_CTL			24
+#define SLAVE_CRYPTO_0_CFG		25
+#define SLAVE_IMEM_CFG			26
+#define SLAVE_IPA_CFG			27
+#define SLAVE_IPC_ROUTER_CFG		28
+#define SLAVE_CNOC_MSS			29
+#define SLAVE_ICBDI_MVMSS_CFG		30
+#define SLAVE_PCIE_0_CFG		31
+#define SLAVE_PCIE_1_CFG		32
+#define SLAVE_PCIE_2_CFG		33
+#define SLAVE_PCIE_RSC_CFG		34
+#define SLAVE_PDM			35
+#define SLAVE_PRNG			36
+#define SLAVE_QDSS_CFG			37
+#define SLAVE_QPIC			38
+#define SLAVE_QUP_0			39
+#define SLAVE_SDCC_1			40
+#define SLAVE_SDCC_4			41
+#define SLAVE_SPMI_VGI_COEX		42
+#define SLAVE_TCSR			43
+#define SLAVE_TLMM			44
+#define SLAVE_USB3			45
+#define SLAVE_USB3_PHY_CFG		46
+#define SLAVE_A1NOC_CFG			47
+#define SLAVE_DDRSS_CFG			48
+#define SLAVE_SNOC_GEM_NOC_SF		49
+#define SLAVE_SNOC_CFG			50
+#define SLAVE_PCIE_ANOC_CFG		51
+#define SLAVE_IMEM			52
+#define SLAVE_SERVICE_PCIE_ANOC		53
+#define SLAVE_SERVICE_SNOC		54
+#define SLAVE_PCIE_0			55
+#define SLAVE_PCIE_1			56
+#define SLAVE_PCIE_2			57
+#define SLAVE_QDSS_STM			58
+#define SLAVE_TCU			59
+
+#endif
-- 
2.7.4

