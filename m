Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31D7D2E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjJWJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjJWJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:21:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA3EE5;
        Mon, 23 Oct 2023 02:21:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N9LDPG004726;
        Mon, 23 Oct 2023 09:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0Cnir9Am8qWxXKRc3LW3pMOLVgwJooj3tBJ4CFq+93M=;
 b=K2AM2o0KfrntlyaP6LN+o2vUT/RtW6Q+44V7vxMHlwuYW1fjvz3nrxEHo2j95ATRF+XG
 H1Eo+zwdLQK/4TG3kpYq6L5HB999bBZY6ooptnF/Xg8MWVGfCu/1ugVP1YbWfYSGY54c
 3hC7Q9m0oEBysbAAMpGaM79H5gdKzKemZE+lLPEyle/bVT3llTrcZuUm6yITjUMKezpY
 hkfsF0PQVfNzOW+EKehdlpIh/d4344d2yM84oey24ASR0E6YOOdS7gtaHb+zkBW7giXW
 VKgwcGXqaGooO5KhHgmBYZNUd3mRiBQ8+hzulS+IkGnGJGkV9l67bbFLCHiTA/dxch28 eQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twp3vg02w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9LLNv002219
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:21 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 02:21:16 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v1 1/5] dt-bindings: soc: qcom: Add memory_dump driver bindings
Date:   Mon, 23 Oct 2023 17:20:53 +0800
Message-ID: <1698052857-6918-2-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QbXPCt9RCrhwsTqtYRnQu7oDKbecljkg
X-Proofpoint-ORIG-GUID: QbXPCt9RCrhwsTqtYRnQu7oDKbecljkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=843
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the QCOM Memory Dump driver providing debug
facilities. Firmware dumps system cache, internal memory,
peripheral registers to reserved DDR as per the table which
populated by the driver, after crash and warm reset.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 .../bindings/soc/qcom/qcom,mem-dump.yaml           | 42 +++++++++++++++++++++
 .../devicetree/bindings/sram/qcom,imem.yaml        | 44 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
new file mode 100644
index 0000000..87f8f51
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,mem-dump.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm memory dump
+
+description: |
+  Qualcomm memory dump driver dynamically reserves memory and provides hints(id and size)
+  of debugging information based on specified protocols with firmware. Firmware then does
+  the real data capture. The debugging information includes cache contents, internal
+  memory, registers. After crash and warm reboot, firmware scans ids,
+  sizes and stores contents into reserved memory accordingly. Firmware then enters into full
+  dump mode which dumps whole DDR to PC through USB.
+
+maintainers:
+  - Zhenhua Huang <quic_zhenhuah@quicinc.com>
+
+properties:
+  compatible:
+    const: qcom,mem-dump
+
+  memory-region:
+    maxItems: 1
+    description: phandle to memory reservation for qcom,mem-dump region.
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  # minimum memory dump definition.
+  - |
+    mem-dump {
+        compatible = "qcom,mem-dump";
+        memory-region = <&dump_mem>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 8025a85..e9eaa7a 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -52,6 +52,40 @@ patternProperties:
     $ref: /schemas/remoteproc/qcom,pil-info.yaml#
     description: Peripheral image loader relocation region
 
+patternProperties:
+  "^mem-dump-table@[0-9a-f]+$":
+    type: object
+    description: Used to store dump table base addr
+    properties:
+      compatible:
+        const: "qcom,qcom-imem-mem-dump-table"
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+patternProperties:
+  "^mem-dump-table-size@[0-9a-f]+$":
+    type: object
+    description: Used to store dump table size
+    properties:
+      compatible:
+        const: "qcom,qcom-imem-mem-dump-table-size"
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -76,5 +110,15 @@ examples:
                 compatible = "qcom,pil-reloc-info";
                 reg = <0x94c 0xc8>;
             };
+
+            mem-dump-table@10 {
+                compatible = "qcom,qcom-imem-mem-dump-table";
+                reg = <0x10 0x8>;
+            };
+
+	    mem-dump-table-size@724 {
+		compatible = "qcom,qcom-imem-mem-dump-table-size";
+		reg = <0x724 0x8>;
+            };
         };
     };
-- 
2.7.4

