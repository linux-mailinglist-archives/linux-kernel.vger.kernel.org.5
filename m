Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797E17FE621
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjK3Bgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjK3Bgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:36:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0AC10C3;
        Wed, 29 Nov 2023 17:36:51 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU0lcWQ013528;
        Thu, 30 Nov 2023 01:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wtDz8jYvfZSuBDlejFLc3nevjEx5ypCtHtLOwsUEBZ8=;
 b=EBGdkDFJkMVWeCKKGflUoM41RhBkMvUiwjNrbNk69r26udsdMZc+zKSdlnNtd9KuVUmH
 bViyv+4kd8ALApifn5Wo2vBKFVIVFmoWrawR0JGUkxkI0GsevaAjcWzRtLmSEU6Qmni6
 zc5kAQ4UaLcGhfexf5LR9koOXUuAM5hl1XG0ra0LHixJaRcnaCNHMSVutNAe2V6fL+uy
 vtKrXy5J5rwW2ujhNtZXrAaGqp9JD1MrtieaSf/62ejrprZCygVCJm9dsl8+u3Sb6tdv
 9WSf6ZKx9F0JuYI1+0go1Qmzwcp6DhTVdCnLLIUhQA2wdZcQkT6VShDVqTtahjTYmP7p hA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up5e8sug8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:36:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU1adqB018707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:36:39 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 17:36:39 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v7 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
Date:   Wed, 29 Nov 2023 17:36:10 -0800
Message-ID: <20231130013615.14287-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130013615.14287-1-quic_amelende@quicinc.com>
References: <20231130013615.14287-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fCS_fnnP7oWC5ZaZ1eENGxgCUgCvXNz1
X-Proofpoint-ORIG-GUID: fCS_fnnP7oWC5ZaZ1eENGxgCUgCvXNz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=814 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update leds-qcom-lpg binding to support LPG PPG.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../bindings/leds/leds-qcom-lpg.yaml          | 82 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index ea84ad426df1..6649ca2ec805 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: >
   The Qualcomm Light Pulse Generator consists of three different hardware blocks;
-  a ramp generator with lookup table, the light pulse generator and a three
+  a ramp generator with lookup table (LUT), the light pulse generator and a three
   channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
 
 properties:
@@ -63,6 +63,29 @@ properties:
         - description: dtest line to attach
         - description: flags for the attachment
 
+  nvmem:
+    description: >
+      This property is required for PMICs that supports PPG, which is when a
+      PMIC stores LPG per-channel data and pattern LUT in SDAM modules instead
+      of in a LUT peripheral. For PMICs, such as PM8350C, per-channel data
+      and pattern LUT is separated into 2 SDAM modules. In that case, phandles
+      to both SDAM modules need to be specified.
+    minItems: 1
+    maxItems: 2
+
+  nvmem-names:
+    minItems: 1
+    items:
+      - const: lpg_chan_sdam
+      - const: lut_sdam
+
+  qcom,pbs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      Phandle of the Qualcomm Programmable Boot Sequencer node (PBS).
+      PBS node is used to trigger LPG pattern sequences for PMICs that support
+      single SDAM PPG.
+
   multi-led:
     type: object
     $ref: leds-class-multicolor.yaml#
@@ -106,6 +129,32 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pmi632-lpg
+    then:
+      properties:
+        nvmem:
+          maxItems: 1
+        nvmem-names:
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8350c-pwm
+              - qcom,pm8550-pwm
+    then:
+      properties:
+        nvmem:
+          minItems: 2
+        nvmem-names:
+          minItems: 2
+
 examples:
   - |
     #include <dt-bindings/leds/common.h>
@@ -191,4 +240,35 @@ examples:
       compatible = "qcom,pm8916-pwm";
       #pwm-cells = <2>;
     };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi632-lpg";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #pwm-cells = <2>;
+      nvmem-names = "lpg_chan_sdam";
+      nvmem = <&pmi632_sdam_7>;
+      qcom,pbs = <&pmi632_pbs_client3>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_RED>;
+        label = "red";
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        label = "green";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_BLUE>;
+        label = "blue";
+      };
+    };
+
 ...
-- 
2.41.0

