Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6380720D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378830AbjLFOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378733AbjLFOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:15:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19133181;
        Wed,  6 Dec 2023 06:15:23 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B63vqle028777;
        Wed, 6 Dec 2023 14:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=v5XQsm6qK7trqasAoR7vL+GslmEW4eUn8t0EdQ7fJrk=;
 b=Oo+Be9VpVPw5dIyfECDT9IIY+JJlQh/CMfoZLgvgSmgJFtTur74eECCPbJSbIDgtS6e5
 X0sOCIPZ356fEnKuK2qoo6BSDiyCAqSkWQoy8Y4Qtc/gTlnR/D/lBwHIRdUC7YRlqNTh
 k/r7aqA3GiR7lFMDiSbNK/9TPBNgx/YC6kYXZDt1Y9qm713P/UWmIlPFzHPy4DKgY8e5
 GXWvh5pebNbD5fLjTu+s//BSlKfCw1ZnLLvhe3JFDiFpnAlxQdOl9fyhhREJw7xg2Cnq
 G0N0qdh1rl1qkIp7m8zD7SuhSumAXrJR+ZmMThhwISOTPN90hc8tdemjW0YzUkS4qtNb Vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdadsxch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 14:15:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6EFFRS023246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 14:15:15 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 06:15:14 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>
Subject: [PATCH v3 1/4] dt-bindings: arm: Add remote etm dt-binding
Date:   Wed, 6 Dec 2023 06:14:56 -0800
Message-ID: <20231206141502.27016-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206141502.27016-1-quic_jinlmao@quicinc.com>
References: <20231206141502.27016-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LdEiVCkRIL57D-FOcw4JlYK-vxLphdRn
X-Proofpoint-ORIG-GUID: LdEiVCkRIL57D-FOcw4JlYK-vxLphdRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_11,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=710 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote ETM(Embedded Trace Macrocell) is to capture information of
the executed processor instructions of remote processors like modem.
Add new coresight-remote-etm.yaml file describing the bindings
required to define coresight remote etm in the device trees.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../arm/qcom,coresight-remote-etm.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
new file mode 100644
index 000000000000..6ef4a572c52d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-remote-etm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Coresight Remote ETM(Embedded Trace Macrocell)
+
+maintainers:
+  - Jinlong Mao <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
+
+description:
+  Support for ETM trace collection on remote processor using coresight
+  framework. Enabling this will allow turning on ETM tracing on remote
+  processor like modem processor via sysfs and collecting the trace
+  via coresight TMC sinks.
+
+properties:
+  compatible:
+    const: qcom,coresight-remote-etm
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Output connection to the CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    etm {
+          compatible = "qcom,coresight-remote-etm";
+
+          out-ports {
+              port {
+                  modem_etm0_out_funnel_modem: endpoint {
+                      remote-endpoint = <&funnel_modem_in_modem_etm0>;
+                  };
+              };
+          };
+    };
+...
-- 
2.41.0

