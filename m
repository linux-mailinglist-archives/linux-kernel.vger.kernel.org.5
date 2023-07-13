Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD07526DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjGMP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjGMP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:26:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6930C0;
        Thu, 13 Jul 2023 08:26:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DBtWVO012033;
        Thu, 13 Jul 2023 15:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=UByQpPtD2NBvFufwbTHf+X6dlLXb8n7XftXc2X2+MnE=;
 b=QqXlr/8pPwnCVpiMSm+pq7OaiZkW0svyZlIHfvcNOoqDHsnMfUzjNTLb4xq0hwUz4GXy
 4tVuBZfE1xFdLQAn0bm/gsw6TbY4Xor4N4vW7fb10qYukgC/Keu6Ca+XqZJ23xna7gPV
 ol5E6dkOvp/BGFnbYa3BrrjTev0LMKnM/JE9oR5yB2fV1qhzztG4YyaqoPW5l//Jun6m
 8tPWf4vyqlX6V1uYS5pLGGlR5UxokwqlCN9z4Y2rk1GPYLyxj7gZL4m/8hOojlEpCCJo
 ZSg2wSXh/DhRCRP7k5kB+KiPqTAmrl87nk/GaSt2z7H0FMycsmt84oha+UUnMBhTMMxH rA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtfah8mx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:26:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DFQCFh006174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:26:12 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 08:26:08 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: document AL01-C1 board based on IPQ9574 family
Date:   Thu, 13 Jul 2023 20:55:21 +0530
Message-ID: <20230713152522.1063154-2-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713152522.1063154-1-quic_sridsn@quicinc.com>
References: <20230713152522.1063154-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A0xrfMp9ws1Vj4zp5dBMSrHXqHzUEEjj
X-Proofpoint-ORIG-GUID: A0xrfMp9ws1Vj4zp5dBMSrHXqHzUEEjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130135
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the AL01-C1 (Reference Design Platform 417) board based on IPQ9574
family of SoCs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
changes in v2:
	- Picked up the Acked-by tag

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

