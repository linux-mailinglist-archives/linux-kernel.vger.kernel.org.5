Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3C751811
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjGMF2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGMF2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:28:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4F2102;
        Wed, 12 Jul 2023 22:28:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D5GkIB001473;
        Thu, 13 Jul 2023 05:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=e4vLQvehiXtvPBxhw4pjTq2KLu/HY1UlxEjGIYTg1FI=;
 b=oHaAF+RA6X3uY2ZF4kPhDnFbJ2STVq8RoeD/OnEWgkQLTRXZCNK6lylCeSinnatNiL55
 EJKmWowi2ZAduGGX0UkRcdsjSEE7vpXud1RzuqA7jnp/dSP+4Hc/ZuImY9dt+Oz57+y2
 4wXgjO9EcqfcObzjabLtLcZU7gfT+YmafosMxljf5iwo6jRH1GFOiSu/FS5XuYglICJb
 eDmuvXEmtlKlDx0dIGYSnMMFmPJKmflbwH0+tnVcvoq9Cg42+SKpyznhV+OpvWbo11hr
 xRl3d+EvvLXLhi71RU7uEOvUokLdity/R6eouzdnfltO7re3x5Dhz4Cv+l19gcOP+rip 5Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt73tgces-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 05:28:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D5S74u027576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 05:28:07 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 22:28:02 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH v3 2/5] dt-bindings: thermal: tsens: Add ipq5332 compatible
Date:   Thu, 13 Jul 2023 10:57:29 +0530
Message-ID: <20230713052732.787853-3-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
References: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U9ThKUnfySK-HxNpb26Tni9qLXkT_C35
X-Proofpoint-GUID: U9ThKUnfySK-HxNpb26Tni9qLXkT_C35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
available in the SoC, hence adding new compatible to have the
sensor enablement and calibration function.

This patch also adds nvmem-cell-names for ipq5332

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
[v3]:
	No changes.
[v2]:
	Followed the order for ipq5332 and added nvmem-cell-names.

 .../devicetree/bindings/thermal/qcom-tsens.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 27e9e16e6455..cca115906762 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -69,6 +69,7 @@ properties:
 
       - description: v2 of TSENS with combined interrupt
         enum:
+          - qcom,ipq5332-tsens
           - qcom,ipq8074-tsens
 
       - description: v2 of TSENS with combined interrupt
@@ -205,6 +206,15 @@ properties:
           - const: s9_p2_backup
           - const: s10_p1_backup
           - const: s10_p2_backup
+      - items:
+          - const: mode
+          - const: base0
+          - const: base1
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
 
   "#qcom,sensors":
     description:
@@ -266,6 +276,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
               - qcom,ipq8074-tsens
     then:
       properties:
@@ -281,6 +292,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
               - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

