Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A066B804C57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbjLEI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:29:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136AD3;
        Tue,  5 Dec 2023 00:29:37 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B589DvT025762;
        Tue, 5 Dec 2023 08:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4+jFZk3wOHriTAMwHwz1K9rKLnBzZeujgPEFVzfEoEc=;
 b=av1GxG/uF7+tpLH3L022Nk/xn66XUxHzxQZoZ7yY5lJ8Z60NBx6pQcIX/FENzL4zy+OZ
 pdNpDiOWKD+4RWvj/BBZWc9OF1w4MYxzh86IgVztBJRHUfVvQb9CdwMO0ejDhHyDuYBs
 OsntiADmGEJpmOmKQRp6HBJcNGYCQpvfCKRXWRmkqfO4jKuor3QUNyucapZAUUoXb7rz
 dlTNPhUnclYvBdpdac/5phcvNnUm/+cGrORi/14jU7WM5t30N0Ceh+JwnmLyGJDKfbBk
 ETbo/swje/1UQKPMhfu0cdwxVAyoO2/21GxOITMRPCTCH6zfYHmJ/xC0cMr3t//NlHhj xQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usfu7a647-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 08:29:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B58TXZt028117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 08:29:33 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 00:29:33 -0800
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
Subject: [PATCH v2 1/4] dt-bindings: arm: Add remote etm dt-binding
Date:   Tue, 5 Dec 2023 00:29:16 -0800
Message-ID: <20231205082922.32149-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205082922.32149-1-quic_jinlmao@quicinc.com>
References: <20231205082922.32149-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2vfNNuk8BaKHYhAyBYrRR1rnBo2CW9LO
X-Proofpoint-ORIG-GUID: 2vfNNuk8BaKHYhAyBYrRR1rnBo2CW9LO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=2 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=717 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../arm/qcom,coresight-remote-etm.yaml        | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
new file mode 100644
index 000000000000..bc76cda33620
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
@@ -0,0 +1,60 @@
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
+  qcom,inst-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Each kind of remote ETM has its unique instance id. The remote etm will
+      be enabled/disabled on remote processor based on the id send from
+      ap processor.
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
+  - qcom,inst-id
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    modem-etm0 {
+          compatible = "qcom,coresight-remote-etm";
+          qcom,inst-id = <2>;
+
+          out-ports {
+              port {
+                  modem_etm0_out_funnel_modem: endpoint {
+                  remote-endpoint = <&funnel_modem_in_modem_etm0>;
+                  };
+              };
+          };
+    };
+...
-- 
2.41.0

