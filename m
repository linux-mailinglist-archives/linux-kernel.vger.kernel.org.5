Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DFD7EFDB3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 05:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjKRE2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 23:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 23:28:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D17D72;
        Fri, 17 Nov 2023 20:27:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI4NvC3022202;
        Sat, 18 Nov 2023 04:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3tOGsdnCHhXR37Mn+CVjGB15eJXQEnFosnZ9luUtAKk=;
 b=BZAhX+eOrlBs+Ck9ENxwQDbxGOgOGPWpK60NOaJubXKUNJ1wt0NW9PlgQgKr+NM0ZhU/
 cOAZnKgedJkX3B6O1A16Ovcmd/1Jk2haa2i2UsTggp/lSuuAuazqFHny6mEfRMSv3JoO
 rTPZGoN1p6T4X/+pr+t2r2PyYTIBgFzyCnYhyDa/rH8CB//AZFqk34g7RuAHNfaxUHyy
 /Swkf67Lyxqx38utfRX+4QeVEmaMa+vx6uTi4OslWRUEBtt26KNZvl4GZDpLZOVDMXor
 OgHZ/Dpb7aSxGn2ds+PPeD2fek47moBv7rlWiQ3a+KOC5HpeSoW/T7c0QwDDVIfVsEl5 TA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udt8bua23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 04:27:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI4RgAa032721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 04:27:42 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 20:27:42 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC:     <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: iommu: Add Translation Buffer Unit bindings
Date:   Fri, 17 Nov 2023 20:27:25 -0800
Message-ID: <20231118042730.2799-2-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
References: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rpe9wBd5FE9bWcuLzGWdcjkgEQPBO4g2
X-Proofpoint-GUID: rpe9wBd5FE9bWcuLzGWdcjkgEQPBO4g2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_02,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
of the SMMU-500, that consists of a single TCU (Translation Control
Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
being described in the generic SMMU DT schema. Add also bindings for
the TBUs to describe their properties and resources that needs to be
managed in order to operate them.

In this DT schema, the TBUs are modelled as child devices of the TCU
and each of them is described with it's register space, clocks, power
domains, interconnects etc.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 25 ++++++
 .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 89 +++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index aa9e1c0895a5..f7f89be5f7a3 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -231,6 +231,18 @@ properties:
       enabled for any given device.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+patternProperties:
+  "^tbu@[0-9a-f]*":
+    type: object
+
 required:
   - compatible
   - reg
@@ -453,6 +465,19 @@ allOf:
             - description: Voter clock required for HLOS SMMU access
             - description: Interface clock required for register access
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,smmu-500
+    then:
+      patternProperties:
+        "^tbu@[0-9a-f]*":
+          $ref: qcom,qsmmuv500-tbu.yaml
+          unevaluatedProperties: false
+      properties:
+        ranges: true
+
   # Disallow clocks for all other platforms with specific compatibles
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
new file mode 100644
index 000000000000..4dc9d0ca33c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TBU (Translation Buffer Unit)
+
+maintainers:
+  - Georgi Djakov <quic_c_gdjako@quicinc.com>
+
+description:
+  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
+  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
+  debug features to trace and trigger debug transactions. There are multiple TBU
+  instances distributes with each client core.
+
+properties:
+  $nodename:
+    pattern: "^tbu@[0-9a-f]+$"
+
+  compatible:
+    const: qcom,qsmmuv500-tbu
+
+  reg:
+    items:
+      - description: Address and size of the TBU's register space.
+
+  reg-names:
+    items:
+      - const: base
+
+  clocks:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  qcom,stream-id-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Stream ID range (address and size) that is assigned by the TBU
+    items:
+      minItems: 2
+      maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interconnects
+  - qcom,stream-id-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    apps_smmu: iommu@15000000 {
+        compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
+        reg = <0x15000000 0x80000>;
+        ranges = <0 0 0 0 0xffffffff>;
+        #iommu-cells = <2>;
+        #global-interrupts = <1>;
+        interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        anoc_1_pcie_tbu: tbu@150e1000 {
+            compatible = "qcom,qsmmuv500-tbu";
+            reg = <0x0 0x150e1000 0x0 0x1000>;
+            reg-names = "base";
+            clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+            interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+            power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+            qcom,stream-id-range = <0x1c00 0x400>;
+        };
+    };
+
+...
