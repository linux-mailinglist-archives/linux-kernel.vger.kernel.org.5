Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0151B77A74F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHMPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHMPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:13:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61165E54;
        Sun, 13 Aug 2023 08:13:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DFDPpX010939;
        Sun, 13 Aug 2023 15:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uYFop0ruipBRsExiKi1C8NXTppfsfTWx20AaFrcURUs=;
 b=i9c+tid0+nve4htucz0Fxs4/rLM+b+l4nrJtoG12r1fWLPEvFkkB5ActcgtUS+iuKjD9
 TYRKzrPAYquTGnTa3Pgguk6kcyZytL/PsmUBptgsEjYN/PV6xzXSEMUjFvgSQJAZp7pD
 5QNo4hw7ecNgOmxfdYRzk4kK3ehLG2Rtb54eg/iMu9xp0RSNotYIWP0tQuSD2nQ+rvzY
 j3xW4TIemIwAm1KJpHalTh3ZTSYD6DVlCah/s7RQunKvBrHHT1o/T6+woLMmdMNGxcVO
 c2Uqvh1o/u2QXjY4QNS5bVhtoXX0wGwWnDZypY9uFLOcr+4ULoNcgCRNmPX6+kpRdk10 /g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3srssrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37DFDO21029271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:24 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 13 Aug 2023 08:13:19 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: Adds CoreSight CSR hardware definitions
Date:   Sun, 13 Aug 2023 23:12:52 +0800
Message-ID: <20230813151253.38128-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
References: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UPM36FqdDuj5fw0XqnoHYq5CYw51cSST
X-Proofpoint-ORIG-GUID: UPM36FqdDuj5fw0XqnoHYq5CYw51cSST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxlogscore=738 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308130143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new coresight-csr.yaml file describing the bindings required
to define csr in the device trees.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-csr.yaml      | 130 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 include/dt-bindings/arm/coresight-csr-dt.h    |  12 ++
 3 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
 create mode 100644 include/dt-bindings/arm/coresight-csr-dt.h

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
new file mode 100644
index 000000000000..de4baa335fdb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CoreSight Slave Register - CSR
+
+description: |
+  CoreSight Slave Register block hosts miscellaneous configuration registers.
+  Those configuration registers can be used to control, various coresight
+  configurations.
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Hao Zhang <quic_hazha@quicinc.com>
+
+properties:
+  $nodename:
+    pattern: "^csr(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-csr
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  # size cells and address cells required if assoc_device node present.
+  "#size-cells":
+    const: 0
+
+  "#address-cells":
+    const: 1
+
+patternProperties:
+  '^assoc_device@([0-9]+)$':
+    type: object
+    description:
+      A assocated device child node which describes the required configs
+      between this CSR and another hardware device. This device may be ETR or
+      TPDM device.
+
+    properties:
+      reg:
+        maxItems: 1
+
+      arm,cs-dev-assoc:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          defines a phandle reference to an associated CoreSight trace device.
+          When the associated trace device is enabled, then the respective CSR
+          will be enabled. If the associated device has not been registered
+          then the node name will be stored as the assocated name for later
+          resolution.
+
+      qcom,cs-dev-type:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Device type of the Assocated device. Types are in coresight-csr-dt.h.
+
+      qcom,csr-bytecntr-offset:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The ETR irqctrl register offset. If the assocated device is ETR
+          device and there are more than one ETR devices, this property need
+          to be added.
+
+      interrupts:
+        minItems: 1
+
+      interrupt-names:
+        minItems: 1
+
+    required:
+      - reg
+      - qcom,cs-dev-type
+      - qcom,cs-dev-assoc
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  # minimum CSR definition.
+  - |
+    csr@10001000 {
+      compatible = "qcom,coresight-csr";
+      reg = <0 0x10001000 0 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+    };
+  # Assocated with ETR device
+  - |
+    #include <dt-bindings/arm/coresight-csr-dt.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    csr@10001000 {
+      compatible = "qcom,coresight-csr";
+      reg = <0 0x10001000 0 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+      assoc_device@0 {
+        reg = <0>;
+        qcom,cs-dev-type = <CSR_ASSOC_DEV_ETR>;
+        qcom,cs-dev-assoc = <&tmc_etr>;
+        qcom,csr-bytecntr-offset = <0x6c>;
+        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "byte-cntr-irq";
+      };
+    };
+...
+
diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..3ed81a8fd1d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2042,7 +2042,7 @@ F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
 F:	Documentation/devicetree/bindings/arm/qcom,coresight-*.yaml
 F:	Documentation/trace/coresight/*
 F:	drivers/hwtracing/coresight/*
-F:	include/dt-bindings/arm/coresight-cti-dt.h
+F:	include/dt-bindings/arm/coresight-*.h
 F:	include/linux/coresight*
 F:	samples/coresight/*
 F:	tools/perf/arch/arm/util/auxtrace.c
diff --git a/include/dt-bindings/arm/coresight-csr-dt.h b/include/dt-bindings/arm/coresight-csr-dt.h
new file mode 100644
index 000000000000..804b9bbeb2bd
--- /dev/null
+++ b/include/dt-bindings/arm/coresight-csr-dt.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * This header provides constants for the defined device
+ * types on CoreSight CSR.
+ */
+
+#ifndef _DT_BINDINGS_ARM_CORESIGHT_CSR_DT_H
+#define _DT_BINDINGS_ARM_CORESIGHT_CSR_DT_H
+
+#define CSR_ASSOC_DEV_ETR	1
+
+#endif /*_DT_BINDINGS_ARM_CORESIGHT_CSR_DT_H */
-- 
2.17.1

