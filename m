Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931C752088
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjGML4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjGML4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:56:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CC119;
        Thu, 13 Jul 2023 04:56:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DAjrbq030238;
        Thu, 13 Jul 2023 11:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=dvgOEz+ZeLBgI/fjLT15JoSVGrYHtwRJKaTJ09QpQZo=;
 b=KhQtjyhX8pNMLoWHmW2xXQbBOi3ycwCQ8BzPOu5euIU1wLOoU1Hi71rPvzZAFvXSC1Zj
 5uOaWdj8CNltbuyZBicbFC+5o2f2VToIxvySZ99KigDZbd16ekp9Bl67fqsfY/xcw6JW
 86lSgb1KtdpgML/xcPg5Pus1NY2icZjvE352KUn4r1M/HrDGShyiTnJGn1mytkQq+S/Y
 jFBCyA2NkB5P4Q1fF94lt0V/thWafUfS5kjHv/DD2CTXSHuItCEMcv+VCBKUnpRgAFuu
 BehgBMsNfgvh3ez3AbwowKP95/0KANnbWvSQDRTz5q8ELfCKauetPMao3ECiEt30QXXz 3A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtayj0nmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:56:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DBuF5f027659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:56:15 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 04:56:11 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document AL01-C1 board based on IPQ9574 family
Date:   Thu, 13 Jul 2023 17:25:43 +0530
Message-ID: <20230713115544.953998-2-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713115544.953998-1-quic_sridsn@quicinc.com>
References: <20230713115544.953998-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aBPDAZlSCBQuElrIkMFrbAGA3Ep9Rbf8
X-Proofpoint-ORIG-GUID: aBPDAZlSCBQuElrIkMFrbAGA3Ep9Rbf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the AL01-C1 (Reference Design Platform 417) board based on IPQ9574
family of SoCs.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..dd66fd872c31 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -87,6 +87,7 @@ description: |
   The 'board' element must be one of the following strings:
 
         adp
+        ap-al01-c1
         ap-al02-c2
         ap-al02-c6
         ap-al02-c7
@@ -362,6 +363,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,ipq9574-ap-al01-c1
               - qcom,ipq9574-ap-al02-c2
               - qcom,ipq9574-ap-al02-c6
               - qcom,ipq9574-ap-al02-c7
-- 
2.34.1

