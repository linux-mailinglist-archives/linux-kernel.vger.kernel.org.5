Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3D779697
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjHKR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbjHKR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:57:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908422D70;
        Fri, 11 Aug 2023 10:57:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BE8C7A006459;
        Fri, 11 Aug 2023 17:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=J8UvNZ2JRwjvVe7BNnNBXOHC4G/9l+4kzlFuGMgNlf0=;
 b=YuL56SH44/pGuX4Q8DeMFmMsgosCK59NOar7vxshTTPeF2qnikeepx3mllEN3IpW7Vn4
 68EvF8fOTVbpfQ0zCnUYMrMvZndMPMuwEXn8ZULPa/SauOoVfOaRdMzHfm0e4znJadU6
 06UgiCy7+xNO3kq1zpiyyllHvWwMJ5s4pMfXKyBkhF6C/ZAGbst8WmmwP1SMsqGa4Tge
 B4wXJ4TmRFwCPogJTkrL+gXzUk1MBPmDFOT9mrYk6SAU4bFSbqo8BLbxxsh2n25pkils
 ODz2z2JjZ4JJtKIFX48BSX16xGhayhFpNn/+Z/umhwznTwyxpmactI3pkpOuJk+cWNd2 bA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd904teu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:57:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BHvcKn029245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:57:38 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 10:57:38 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3 2/3] dt-bindings: arm: Add qcom specific hvc transport for SCMI
Date:   Fri, 11 Aug 2023 10:57:18 -0700
Message-ID: <20230811175719.28378-3-quic_nkela@quicinc.com>
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
X-Proofpoint-GUID: Tp1ByOj6GzmT-iclO5HuqO7-AhcZMCNY
X-Proofpoint-ORIG-GUID: Tp1ByOj6GzmT-iclO5HuqO7-AhcZMCNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "qcom,scmi-hvc-shmem" for SCMI
transport channel for Qualcomm virtual platforms.
The compatible mandates a shared memory channel.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 8d54ea768d38..4090240f45b1 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -45,6 +45,9 @@ properties:
       - description: SCMI compliant firmware with OP-TEE transport
         items:
           - const: linaro,scmi-optee
+      - description: SCMI compliant firmware with Qualcomm hvc/shmem transport
+        items:
+          - const: qcom,scmi-hvc-shmem
 
   interrupts:
     description:
@@ -320,6 +323,15 @@ allOf:
       required:
         - linaro,optee-channel-id
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,scmi-hvc-shmem
+    then:
+      required:
+        - shmem
+
 examples:
   - |
     firmware {
-- 
2.17.1

