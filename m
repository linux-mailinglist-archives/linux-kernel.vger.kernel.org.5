Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BAF8085FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378651AbjLGJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjLGJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:28:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4724D57;
        Thu,  7 Dec 2023 01:28:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B76vBRd020623;
        Thu, 7 Dec 2023 09:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qHgyOtHa9caY3pnGex6BgHtXiXVaSjJWcbpbXaByubo=;
 b=ZKgjBXL3S7YYj2UYGUnbBuUOjikzhPFsSYQXiOH7IGZ37EnD6DdYRf0x1cSWIzjyvV99
 nn45jheXwpta/AVUrY1k8Pe3EhDHGFeWsQ2zYTaROouD9bbvMws4g3k0BzGZ5QJBWfFO
 bRVaD7PA7pqodNOzQO85jaZj7hJb+x45DpdL+QRVoBBqGs3HG7761oqe9XNpKB28wKP3
 5D7YlvFYVuvn7r3KjyJFEBlN6ZkBkgZ+m0uDpGSpqJvnCyxI7NIBPEn/4AjR3ZciBgCu
 HzVyhCpZDJa/AKkqvcxzQKh8lFrcai7jtP53UXQkqqiQrlo5jEGFqps1Kb2iLG4p6ntp Iw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utt70abfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:28:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B79SY7d019529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 09:28:34 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 01:28:27 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 1/7] dt-bindings: arm: qcom: Document qcs8550 SoC and board
Date:   Thu, 7 Dec 2023 17:27:55 +0800
Message-ID: <20231207092801.7506-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231207092801.7506-1-quic_tengfan@quicinc.com>
References: <20231207092801.7506-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xwC2lHVLJjUJkPQbLEvsIB_e0mb5hIIz
X-Proofpoint-GUID: xwC2lHVLJjUJkPQbLEvsIB_e0mb5hIIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=763 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312070076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcs8550 SoC and the AIM300 AIoT board bindings.
AIM300 Series is a highly optimized family of modules designed to support
AIoT applications. The Module is mounted onto Qualcomm AIoT carrier board
to support verification, evaluation and development.
AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index e09745a802fd..f6cb413fff4d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -49,6 +49,7 @@ description: |
         msm8996
         msm8998
         qcs404
+        qcs8550
         qcm2290
         qcm6490
         qdu1000
@@ -904,6 +905,12 @@ properties:
           - const: qcom,qcs404-evb
           - const: qcom,qcs404
 
+      - items:
+          - enum:
+              - qcom,qcs8550-aim300-aiot
+          - const: qcom,qcs8550-aim300
+          - const: qcom,qcs8550
+
       - items:
           - enum:
               - qcom,sa8155p-adp
-- 
2.17.1

