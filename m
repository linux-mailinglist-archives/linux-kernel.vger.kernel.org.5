Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05C79BBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjIKVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbjIKTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:44:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC918D;
        Mon, 11 Sep 2023 12:44:31 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BHilZZ017083;
        Mon, 11 Sep 2023 19:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mi+xMMZfbqMADnJGJ0QFgmIXamVRysXxN19hN2cy6go=;
 b=g5pa3v7lyh84KXopfAjb3HmrdogYrWk9HbY3Kn9GBcFBBY3znSeun5rOZHFpyBS/pXhr
 pCGvfSEeMmtXnzwgrtlEsH1bsuOI+0GBS5zFmz8pMKJxbGRr7FxWfO8TV4h+uX1Z94TS
 5hDiE2fSKoO24gL7c1o8HuRX7tJztv1wd2m3Ftf/NdOBDejwFSmYd5HwpribxeuIG0mL
 G5WnoD949kfRJtOslF6XT/pxjha8yO7I0Rrzq2gGe6dfhNyKJCruiJbs8oDQASfnzO96
 16k7kF9hCSELN5a3iT0h1pHgg6MUmf9k9JcsouauLpoPvR/JDkfWIkbpMBlg2x+lL3zq mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t20yy18eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BJiMZs015309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:22 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 12:44:21 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 2/4] dt-bindings: arm: convert nested if-else construct to allOf
Date:   Mon, 11 Sep 2023 12:43:57 -0700
Message-ID: <20230911194359.27547-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230911194359.27547-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gK5mL4YjAYKfgFLs6p9j8mCfnrvkyiCk
X-Proofpoint-GUID: gK5mL4YjAYKfgFLs6p9j8mCfnrvkyiCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

