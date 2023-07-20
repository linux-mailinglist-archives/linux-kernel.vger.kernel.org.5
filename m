Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174175A816
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGTHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGTHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:43:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3D269A;
        Thu, 20 Jul 2023 00:43:33 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K67c8g021541;
        Thu, 20 Jul 2023 07:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xsJPVqTEo2QRokT16XvgIIKHj5BCzhvXEMm8s16lCH0=;
 b=SXvyjzWiM8LdpRugrrT9oRpmYjbAdAf4Hy3A+aF+UmE7Dwk6ttI9OIGZOD//6dZbU7zb
 aPVtj+l8eoXUPJqGZ2rHJmYhHmoUmidVf7EA56iq24wkYTphGWOyMz01diR3aG1yhNCJ
 X2ZQ3+p35ivvBPfuYoI+bfLLCGINKs70ZRWGXmb5fo9k9uXzSJuOPsVP+tWqUbo70Fg2
 lfhSdrlnDBNEns7PPIT+3bR+7xD3YOK2QMlIROlySqTlnmoqLF3W3tA85CCYY8yuahsb
 wcyHVp5TRAoSFryXE3QQNd0BWrXQnguKE7E7JSGGMMm9PlVOeB4XhUitFlqtzgEBowIN jA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxxv87n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:43:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K7hT9e011688
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:43:29 GMT
Received: from harihk-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:43:23 -0700
From:   Hariharan K <quic_harihk@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_harihk@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Document MP03.1-C2 board based on IPQ5018 family
Date:   Thu, 20 Jul 2023 13:13:01 +0530
Message-ID: <20230720074302.13585-2-quic_harihk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720074302.13585-1-quic_harihk@quicinc.com>
References: <20230720074302.13585-1-quic_harihk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QUgT9ZUhIfbPZRtmIoAgvEC7-L5p586t
X-Proofpoint-ORIG-GUID: QUgT9ZUhIfbPZRtmIoAgvEC7-L5p586t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=957 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the MP03.1-C2 (Reference Design Platform 404) board
based on IPQ5018 family of SoCs.

Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 922feb912594..f62bfac4cccf 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -97,6 +97,7 @@ description: |
         ap-mi01.3
         ap-mi01.6
         ap-mi01.9
+        ap-mp03.1-c2
         ap-mp03.5-c2
         cdp
         cp01-c1
@@ -343,6 +344,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,ipq5018-ap-mp03.1-c2
               - qcom,ipq5018-ap-mp03.5-c2
           - const: qcom,ipq5018
 
-- 
2.17.1

