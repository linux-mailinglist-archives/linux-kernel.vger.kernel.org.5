Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887CE75FC70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGXQos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGXQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:44:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C5E54;
        Mon, 24 Jul 2023 09:44:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OG6hCb030483;
        Mon, 24 Jul 2023 16:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ykZqGMEVAM5lz9k7Jzivh1u/oFybj2pnen+yuWhAAok=;
 b=lgmrsKTZ6Kmur/luSPq+m43jqUiOuGVEzXwMXAJz6iWcNpEoU4KggMdGG4DfMArNMT2H
 VoqzxL9O6ciN4iDyeQ7g8p9zLltr8MnjoSzwXQQVetvRlRjVNhU+xc2Nphuh3RBWvTvv
 YM7m77m9x1rcaVhSjqz6+dI/UQcJz452rbPUmIcJS9/IZCIcalGA2zzWhqC0T/QE4P8P
 U72fwvN9WfTME9Dl13jpb4MQjBuWrRjnjCvph3Hw47rbDhKpsilSYOwAatd9PtGmKbr5
 rKBB7NbJyjIt7yt6v9C/gb4wMJ4QuyCU560wYqATir9xcH8GxPVVPvo896r7Oi3yOfHK fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8g3qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:44:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OGiaqM005679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:44:36 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 09:44:35 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: convert nested if-else construct to allOf
Date:   Mon, 24 Jul 2023 09:44:17 -0700
Message-ID: <20230724164419.16092-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230724164419.16092-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230724164419.16092-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nPihbNRvrsFry-rJIq7CeZqghfpc96HG
X-Proofpoint-GUID: nPihbNRvrsFry-rJIq7CeZqghfpc96HG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested if-else construct is not scalable therefore, convert
it to allOf:if-else.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
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

