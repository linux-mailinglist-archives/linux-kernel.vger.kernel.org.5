Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD575A9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGTI4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGTIrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:47:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D32115;
        Thu, 20 Jul 2023 01:47:08 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K6v7BC031893;
        Thu, 20 Jul 2023 08:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sEfodpm9gTgzEFt9vebVYKFhSUyFBMLKXCmm5kMDBU4=;
 b=SlZGJPyoqMnIimagcfiY26Jm9G0Cay0y5bGoVVAsRrnjaz2yFFfzf0ytNWztal3IHR6T
 WlsHOMKrb70XrGAfrra6pAjsPbh6cXpED4LbicAwGl6aXeBPhpP43g/XynRnRn78JNN9
 B10047eZYhwWYxPQPwRdD+flZ1zc0JzKmOJzk7Yh/3RctXHRhxVabBsEYJB4AkpAd9L9
 avdC8jNFs/chshix0QLzRNnp1D95jZ3PqhIIdHXJIrWVekq7d5ZA28p5GWfyn5UJFrle
 WhQKkkBnQFj2KWWNrvywq1mSnN0M7rqQ7HkFzs/pQEDcJziNCZb7T0K0LbW/pkvJgT85 /Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx728u91u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:47:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K8l4av019243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:47:04 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 01:47:00 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-Cx and AL03-C2 boards based on IPQ9574 family
Date:   Thu, 20 Jul 2023 14:15:33 +0530
Message-ID: <20230720084534.6461-2-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720084534.6461-1-quic_sridsn@quicinc.com>
References: <20230720084534.6461-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hFsq_ZRCW0l2WROnMkliliE-2ohJgH0I
X-Proofpoint-ORIG-GUID: hFsq_ZRCW0l2WROnMkliliE-2ohJgH0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the below listed (Reference Design Platform) RDP boards based on IPQ9574
family of SoCs.

AL02-C3  - rdp437
AL02-C7  - rdp433-mht-phy
AL02-C10 - rdp433-mht-switch
AL02-C11 - rdp467
AL02-C12 - rdp455
AL02-C13 - rdp459
AL02-C15 - rdp457
AL02-C16 - rdp456
AL02-C17 - rdp469
AL02-C19 - rdp461
AL03-C2  - rdp458

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
 .../devicetree/bindings/arm/qcom.yaml         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index dd66fd872c31..d992261da691 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -89,10 +89,20 @@ description: |
         adp
         ap-al01-c1
         ap-al02-c2
+        ap-al02-c3
         ap-al02-c6
         ap-al02-c7
         ap-al02-c8
         ap-al02-c9
+        ap-al02-c10
+        ap-al02-c11
+        ap-al02-c12
+        ap-al02-c13
+        ap-al02-c15
+        ap-al02-c16
+        ap-al02-c17
+        ap-al02-c19
+        ap-al03-c2
         ap-mi01.2
         ap-mi01.3
         ap-mi01.6
@@ -365,10 +375,20 @@ properties:
           - enum:
               - qcom,ipq9574-ap-al01-c1
               - qcom,ipq9574-ap-al02-c2
+              - qcom,ipq9574-ap-al02-c3
               - qcom,ipq9574-ap-al02-c6
               - qcom,ipq9574-ap-al02-c7
               - qcom,ipq9574-ap-al02-c8
               - qcom,ipq9574-ap-al02-c9
+              - qcom,ipq9574-ap-al02-c10
+              - qcom,ipq9574-ap-al02-c11
+              - qcom,ipq9574-ap-al02-c12
+              - qcom,ipq9574-ap-al02-c13
+              - qcom,ipq9574-ap-al02-c15
+              - qcom,ipq9574-ap-al02-c16
+              - qcom,ipq9574-ap-al02-c17
+              - qcom,ipq9574-ap-al02-c19
+              - qcom,ipq9574-ap-al03-c2
           - const: qcom,ipq9574
 
       - description: Sierra Wireless MangOH Green with WP8548 Module
-- 
2.17.1

