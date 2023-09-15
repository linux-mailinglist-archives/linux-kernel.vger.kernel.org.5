Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53F37A1E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjIOMQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjIOMP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:15:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D129C2121;
        Fri, 15 Sep 2023 05:15:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FBNGQ9008957;
        Fri, 15 Sep 2023 12:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=goGu9DoFW5xZSxMHHa/hQ84rHqaVmllKSc2ih5rLSpk=;
 b=cBQmKJdUXBucnf1iLRHJhn3oNRXG4Ef5rdPogWvEagaDRo+4cjBcy7URDDuzEuPgtxqY
 SI970Bnbh4uTYkKvcpWWTu3titEaKyZkxUeyp3HIEUcM3rd+7ZUK7KlMRuBbzXp9xGpD
 23gk5vOVTP4JoKjSqWPmcp7GehCcmukcE/U/G1kL1ejtrCnrbG4oJoRbJFekYYZcaNoK
 KaZY80Feu+rkdFdj1tiJWjTxkYAPf4skhHlwu2laJ6ncMAYMNvesR+jvso00ZBx3GHAu
 XuKmB8zFeipKE6pGXCSGu3MfoabkAvW9CM76iPdtpyLWPr6A0SSzV2EQSraVCHVAYbaX Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g5tgvw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FCFfYN004513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:41 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 05:15:36 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH V2 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date:   Fri, 15 Sep 2023 17:45:01 +0530
Message-ID: <20230915121504.806672-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915121504.806672-1-quic_srichara@quicinc.com>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DSOgm1WqeqO2yL4oojFvakGOBfDssPkv
X-Proofpoint-GUID: DSOgm1WqeqO2yL4oojFvakGOBfDssPkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=873 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2] Sorted the compatible and removed example

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 27e9e16e6455..c9586b2fbba4 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,ipq5018-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens
-- 
2.34.1

