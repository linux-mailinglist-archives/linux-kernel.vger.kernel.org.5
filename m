Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51FA78DE75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbjH3TDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbjH3K5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:57:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7391BF;
        Wed, 30 Aug 2023 03:57:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UA9Ho9008407;
        Wed, 30 Aug 2023 10:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yQraFZLceyDLNtwoD79g6otydNPhFws0Uc28A8hi9co=;
 b=NpqzbyG4OnDUsmD0/3Sb0Jbhp1BuesBrP81yvd8z4zW74H0Y2oM8yny5Kp0IaNWffKL7
 NacCcu9nOv9DnBhtaL6rOVJLTRZMqJFwf8U5tBp5DbdEZup6cgt32aAo7axNObbK3mLl
 3YZiKzZZeXTTryX8WF1A64Ib8h/OGQOZKcS40TtU6mJ4wUcLmJyIu9TlD5bKe3MYWK/q
 3labm5DTkWpjbWidRIEIdzJ5KIMZ73q28wGhVtVA8aonnIyXF6ya/6E3jIM5iILwII7b
 gjacv3oYxqtUYZZSh51JLVqPwBDbCcye973nAu/UyYrFFYPQvtU+RyxnLaJC4swxo6kK 7g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q0fun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UAvNYO011311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:23 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 03:57:19 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/6] dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000
Date:   Wed, 30 Aug 2023 16:26:49 +0530
Message-ID: <20230830105654.28057-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: plGxWrdMRIMmBC9C-pV0V_C346UoLNH0
X-Proofpoint-GUID: plGxWrdMRIMmBC9C-pV0V_C346UoLNH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxlogscore=920 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC compatible for QDU1000/QRU1000 SoCs and add optional
nvmem-cells and nvmem-cell-names properties to support multiple
configurations for multi channel DDR.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 44892aa589fd..580f9a97ddf7 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -20,6 +20,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,qdu1000-llcc
       - qcom,sc7180-llcc
       - qcom,sc7280-llcc
       - qcom,sc8180x-llcc
@@ -44,6 +45,14 @@ properties:
   interrupts:
     maxItems: 1

+  nvmem-cells:
+    items:
+      - description: Reference to an nvmem node for multi channel DDR
+
+  nvmem-cell-names:
+    items:
+      - const: multi-chan-ddr
+
 required:
   - compatible
   - reg
@@ -92,6 +101,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qdu1000-llcc
               - qcom,sc8180x-llcc
               - qcom,sc8280xp-llcc
     then:
--
2.41.0

