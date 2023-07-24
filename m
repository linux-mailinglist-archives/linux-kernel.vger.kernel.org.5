Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4A75EDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGXIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGXIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:39:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92723E76;
        Mon, 24 Jul 2023 01:39:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O5g47V020734;
        Mon, 24 Jul 2023 08:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=F6K60CXYccnRUPtPhfRYUjzooRfZTTopkeYZFwXQVDQ=;
 b=JInvDZWF2aomulkBfIGKFqavahVzzaCVc+xj71qnv2ZVBeuWUKud1IruZAWFYKTgAbOB
 3mvNj0V5pP1rBDNI72mHbnJqIchL3b4CTTcT8eZDsl8ktdkwY+6VPW97dnEnw4Iacp5r
 03ZfbUEU968HKA3+sUNcYHUnNSgeKj1MxPVbhSGr4TiSjcfaowdBIZ+rdmF4dLrPpRvy
 LOzeQaTER5KDt1yauOlh+MMjVVFiU8gp73AiWDkaE+nimU2pk7Csy5fkLEtYsvnKkT+c
 3MTGGlVaOxuPXsn7IGdd2//975Ynn1b2Yq50JSMMwqwuu6mK8jTWaW/hJzONY5+uYL/I 7A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s06q9at0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:39:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O8dHxh001989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:39:17 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 01:39:13 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
Date:   Mon, 24 Jul 2023 14:08:48 +0530
Message-ID: <20230724083849.8277-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k2LvG51O9_QlR_Ojt4KBjvPD4Cmd7HBr
X-Proofpoint-GUID: k2LvG51O9_QlR_Ojt4KBjvPD4Cmd7HBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=759
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for secure qfprom found in QCOM SOCs.
Secure QFPROM driver is based on simple nvmem framework.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 .../bindings/nvmem/qcom,sec-qfprom.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
new file mode 100644
index 000000000000..1425ced36fdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, Secure QFPROM Efuse
+
+maintainers:
+  - Komal Bajaj <quic_kbajaj@quicinc.com>
+
+description: |
+  For some of the Qualcomm SoC's, it is possible that
+  the qfprom region is protected from non-secure access.
+  In such situations, linux will have to use secure calls
+  to read the region.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,qdu1000-sec-qfprom
+      - const: qcom,sec-qfprom
+
+  reg:
+    items:
+      - description: The secure qfprom corrected region.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      efuse@221c8000 {
+        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
+        reg = <0 0x221c8000 0 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        multi_chan_ddr: multi-chan-ddr@12b {
+          reg = <0x12b 0x1>;
+          bits = <0 2>;
+        };
+      };
+    };
+
--
2.40.1

