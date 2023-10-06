Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B67BB10D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJFEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjJFEyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:54:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25CE181;
        Thu,  5 Oct 2023 21:54:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3964iVhc008306;
        Fri, 6 Oct 2023 04:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tWBLtMiBnfislLmNpklT2fvoD4Wg1XhMm9DoZei9BDo=;
 b=F7ZlqXe8MqN3ZpTc29p3CpwhCLriqm3ICMCQerxdpwSjzppw+1IG7AWCgd5wBEtWVijD
 FtjrPSGesOdafcsFxMDdSV4TFAbjLBmqN2fS/qQ0GfE0TNAaxg/rspJN4n1Oezw5xk4y
 +j/f4MMzo6jUAu/iHRAUf4Y/n2nk0AZwi1odhQ5ih3AExpf216izkd4xRU8MIaALN2SU
 8h/jrK2Ez7LMjoG+LCdbbdY7+ZEKy27SoR03exhaXXfTnGso+IFXVMqQry7Aeb4nfvmG
 FDljNhknRU3ExK2iQZ/yMJw7j3E/wKdlWikMqUxuEXQsY2+BxRC4T604ey1kwVdAgYXm yQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tj9bxg6d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 04:54:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3964rkCV025465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 04:53:46 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 21:53:41 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: mfd: qcom,tcsr: Extend simple-mfd & pwm support for IPQ targets
Date:   Fri, 6 Oct 2023 10:23:15 +0530
Message-ID: <20231006045317.1056625-3-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kQrUq-kBSyOQek41nm0AuSm4l88-6KSv
X-Proofpoint-ORIG-GUID: kQrUq-kBSyOQek41nm0AuSm4l88-6KSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_01,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=988 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend simple-mfd and pwm support for IPQ5332 & IPQ9574 SoCs.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index f836b973e382..1e1e25df4ee3 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -33,10 +33,8 @@ properties:
               - qcom,sm8450-tcsr
               - qcom,tcsr-apq8064
               - qcom,tcsr-apq8084
-              - qcom,tcsr-ipq5332
               - qcom,tcsr-ipq8064
               - qcom,tcsr-ipq8074
-              - qcom,tcsr-ipq9574
               - qcom,tcsr-mdm9615
               - qcom,tcsr-msm8226
               - qcom,tcsr-msm8660
@@ -47,7 +45,10 @@ properties:
               - qcom,tcsr-msm8996
           - const: syscon
       - items:
-          - const: qcom,tcsr-ipq6018
+          - enum:
+              - qcom,tcsr-ipq5332
+              - qcom,tcsr-ipq6018
+              - qcom,tcsr-ipq9574
           - const: syscon
           - const: simple-mfd
 
@@ -78,7 +79,9 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,tcsr-ipq5332
                 - qcom,tcsr-ipq6018
+                - qcom,tcsr-ipq9574
     then:
       patternProperties:
         "pwm@[a-f0-9]+$": false
-- 
2.34.1

