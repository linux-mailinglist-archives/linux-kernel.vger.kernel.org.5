Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D167CB90F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjJQDMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjJQDLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF20F7;
        Mon, 16 Oct 2023 20:11:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H1D07V031644;
        Tue, 17 Oct 2023 03:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Luk9Ud2tLTRXw0KmA6WPexK8kOoHsWs52V3XvQyeKsA=;
 b=cc3sdNvjT53lTkPL2kp6krjUsxM3Y/x8xVHuXWK9BNv6HvKBO4ir3aoeRrifVjNbRLcE
 wHZ52C3cjccXXtjdAJeIh84G48hItVHM8ZDIvQIWr6pPl/LpUhztqQxvIS1svvgBbtZn
 bGRpOADKGrc+hAvEBmrPy921VxyukGEvQj73k+xyn7+9AS+GO2WiYef58xNQEcF+EjwJ
 sqNWj21c/ipb6qoLtsF6zCbwoId+qgalkPGJAF1LNi1ARt9iwMH9ahvcWr0669xe2GDx
 OTGiN5uuNecpbb9S5dtyEDWfV6hsitXlG78WALey+KvgiN9bnQf8vl2VCDOja6+rpbV7 lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tryn12k9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BT9X004301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:29 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:28 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:17 -0700
Subject: [PATCH 09/12] dt-bindings: usb: qcom,dwc3: Rename to "glue"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-9-ab4a84165470@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=3277;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=xWAH8OFdsEJDszKWRHBmLofJhtWagjJNkxDzScaUmMg=;
 b=/4sC46w0QXsDTHkWZtWK2/Gv6xmzsvIh4NqdJsMNszN9uEpovi00709WwuFq4Qzzua2rAISkN6Gd
 9MpjM/2FAfHhv/DUh5G8um2Ow698cIGIcndQCpCPwBbGtZSKAKUN
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MQQSFvg5VBkvb4I4yWlGEp31zRsdARqB
X-Proofpoint-ORIG-GUID: MQQSFvg5VBkvb4I4yWlGEp31zRsdARqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm USB block consists of three intertwined parts, the XHCI,
the DWC3 core and the Qualcomm DWC3 glue. The exsting binding represents
the Qualcomm glue part, with the other two represented as in a child
node.

Rename the qcom,dwc3 binding, to represent that this is indeed only the
glue part, to make room for a combined binding.

The large "select" is included to avoid the schema to be selected for
validation with the upcoming flattened binding - which includes
snps,dwc3 in the compatible.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../usb/{qcom,dwc3.yaml => qcom,dwc3-glue.yaml}    | 54 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3-glue.yaml
similarity index 89%
rename from Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
rename to Documentation/devicetree/bindings/usb/qcom,dwc3-glue.yaml
index 727abe41c422..bec0151b41d2 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3-glue.yaml
@@ -1,14 +1,64 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
+$id: http://devicetree.org/schemas/usb/qcom,dwc3-glue.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm SuperSpeed DWC3 USB SoC controller
+title: Qualcomm SuperSpeed DWC3 USB SoC controller glue
+
+description:
+  This describes the Qualcomm glue-section of the SuperSpeed DWC3 USB
+  controller found in many Qualcomm platforms, with the XHCI and DWC3 core
+  portions described as a separate child device.
+  The combined representation, defined by qcom,dwc3.yaml is preferred.
 
 maintainers:
   - Wesley Cheng <quic_wcheng@quicinc.com>
 
+select:
+  properties:
+    compatible:
+      items:
+        - enum:
+            - qcom,ipq4019-dwc3
+            - qcom,ipq5018-dwc3
+            - qcom,ipq5332-dwc3
+            - qcom,ipq6018-dwc3
+            - qcom,ipq8064-dwc3
+            - qcom,ipq8074-dwc3
+            - qcom,ipq9574-dwc3
+            - qcom,msm8953-dwc3
+            - qcom,msm8994-dwc3
+            - qcom,msm8996-dwc3
+            - qcom,msm8998-dwc3
+            - qcom,qcm2290-dwc3
+            - qcom,qcs404-dwc3
+            - qcom,sa8775p-dwc3
+            - qcom,sc7180-dwc3
+            - qcom,sc7280-dwc3
+            - qcom,sc8180x-dwc3
+            - qcom,sc8280xp-dwc3
+            - qcom,sc8280xp-dwc3-mp
+            - qcom,sdm660-dwc3
+            - qcom,sdm670-dwc3
+            - qcom,sdm845-dwc3
+            - qcom,sdx55-dwc3
+            - qcom,sdx65-dwc3
+            - qcom,sdx75-dwc3
+            - qcom,sm4250-dwc3
+            - qcom,sm6115-dwc3
+            - qcom,sm6125-dwc3
+            - qcom,sm6350-dwc3
+            - qcom,sm6375-dwc3
+            - qcom,sm8150-dwc3
+            - qcom,sm8250-dwc3
+            - qcom,sm8350-dwc3
+            - qcom,sm8450-dwc3
+            - qcom,sm8550-dwc3
+        - const: qcom,dwc3
+  required:
+    - compatible
+
 properties:
   compatible:
     items:

-- 
2.25.1

