Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E326779696
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjHKR5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjHKR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:57:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3CA2D70;
        Fri, 11 Aug 2023 10:57:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BE4v42027553;
        Fri, 11 Aug 2023 17:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mi+xMMZfbqMADnJGJ0QFgmIXamVRysXxN19hN2cy6go=;
 b=C+GZ2uNK6LR9U3ACr8Gkmgm4k+9UyWYsmesAS31rreEIoNTHhmfT2bnABGopRKY9AFQg
 xqWKg5DK3UU9K5csmwm4FlX56F0dQ8rR9kivuk12ZxrXSqQ54G1w5xOFseKI49XrhUXE
 AXVXsTDA4gZcGw+tX1t/YxaitIszSP2iZ3o0OUK/8gUrVq5/ZQVBP++fDpc06x3ycdSr
 l4DdEyKXyc96aBsheQVCuDfasZaEwVAVx38G6kORmaGt6x7Ukjspa/eKF889A6Kx5KBz
 LD/5uyIKxyA4DnPM7mbAlBTIJhc/YpUSiWSRTCCsnOtzWzqvudBxHIKVYJ4zMI51ZKjE AA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yaaegm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:57:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BHvb8S027995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:57:37 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 10:57:36 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: convert nested if-else construct to allOf
Date:   Fri, 11 Aug 2023 10:57:17 -0700
Message-ID: <20230811175719.28378-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811175719.28378-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230811175719.28378-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yodBgaxF1Y0kuNgrjE_IDK11qetbAR-e
X-Proofpoint-ORIG-GUID: yodBgaxF1Y0kuNgrjE_IDK11qetbAR-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested if-else construct is not scalable therefore, convert
it to allOf:if-else.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/firmware/arm,scmi.yaml           | 55 +++++++++----------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index b138f3d23df8..8d54ea768d38 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -284,35 +284,34 @@ $defs:
 required:
   - compatible
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: arm,scmi
-then:
-  properties:
-    interrupts: false
-    interrupt-names: false
-
-  required:
-    - mboxes
-    - shmem
-
-else:
-  if:
-    properties:
-      compatible:
-        contains:
-          enum:
-            - arm,scmi-smc
-            - arm,scmi-smc-param
-  then:
-    required:
-      - arm,smc-id
-      - shmem
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,scmi
+    then:
+      properties:
+        interrupts: false
+        interrupt-names: false
+
+      required:
+        - mboxes
+        - shmem
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - arm,scmi-smc
+              - arm,scmi-smc-param
+    then:
+      required:
+        - arm,smc-id
+        - shmem
 
-  else:
-    if:
+  - if:
       properties:
         compatible:
           contains:
-- 
2.17.1

