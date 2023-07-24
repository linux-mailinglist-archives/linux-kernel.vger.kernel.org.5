Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97775ED9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGXIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGXIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:30:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDCE67;
        Mon, 24 Jul 2023 01:30:26 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O7drDq006813;
        Mon, 24 Jul 2023 08:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=F6K60CXYccnRUPtPhfRYUjzooRfZTTopkeYZFwXQVDQ=;
 b=Ouz+ZnSpIDT48ZEx/yH69go3l9xoHcqugx0qLqMidtPAYTtIkKLuBke6b+PgNwu1Iehi
 DvQSzP0UDxlytLKaw/pJHiHIiTFmt81n/3aCBxnatvqR7kWn9+u0bF0ZliPnRd7S2cVa
 O6OWLjnxLClS/fW672LFDUOB3o7dC9c3EOPPOUHmeLmG5zStSKhsbE76WdecdgsaH0jo
 KMmSKnVoBfl6fOgGe5zL/y2Pke06ICOyxhpaANlrZIhdKovLmF05d1Yfi+H/fhdZ3oBR
 oxelyXC8ZVjM0OY8PsteDc1WNUkR9paen32XWbNy3VUkXShPrEoiKnlUB4vgQuPZLKNt MA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s07gd2rm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:30:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O8ULFN023877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:30:21 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 01:30:17 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
Date:   Mon, 24 Jul 2023 13:59:45 +0530
Message-ID: <20230724082946.7441-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724082946.7441-1-quic_kbajaj@quicinc.com>
References: <20230724082946.7441-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: riZrJ0WVnRaw3L75ziwT_ko-oWx-HHr5
X-Proofpoint-ORIG-GUID: riZrJ0WVnRaw3L75ziwT_ko-oWx-HHr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=759
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240074
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

