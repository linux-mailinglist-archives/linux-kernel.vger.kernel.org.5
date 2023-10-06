Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D77BB101
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJFEyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjJFEyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:54:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70144DE;
        Thu,  5 Oct 2023 21:53:59 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3963d9U6022421;
        Fri, 6 Oct 2023 04:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ym7AeYADiKI1I2XUjRkhj44BrtRJQi/RAV/mHmnnS8w=;
 b=YfWwVWWy+5XGdWi0Z1TxwcR/qxgV2LhSJOBTjHknmAxEDJ46xOR2fSayrBEot6ewgdQd
 PGkOS6KGvB2fIvA+K9zhVixZYXqAXuXbCTPkXB/PjXIrBnskZGVwx/oy5iTkdbq3VVyb
 rGwhsPpwKNd1gsmo1HrnB4cyfbtdoTkKNX7GfHW3IPIRmF2ergLh1D1FInkBwWW8wBm3
 4AX+Hisygy34uOP2CgNtgRWlIoMP5ntuuTTkw3yr1aov42YgUNppA5+ab0VQWHmYVYFh
 GEWUA7Z7Nrxz5uajPOV9p6EmrskA8gkycNCKvaDB/jIW3ZOg6HqDDxQskeZ9WAgLHyTJ rw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thj6gk3dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 04:53:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3964rfEa003753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 04:53:41 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 21:53:36 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: pwm: Document the pwm compatible for ipq5332 & ipq9574
Date:   Fri, 6 Oct 2023 10:23:14 +0530
Message-ID: <20231006045317.1056625-2-quic_devipriy@quicinc.com>
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
X-Proofpoint-GUID: ZRqsp0yTo9oVO1J5rFcOmC9pa9Svk0yP
X-Proofpoint-ORIG-GUID: ZRqsp0yTo9oVO1J5rFcOmC9pa9Svk0yP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_01,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ipq6018 as the fallback for ipq5332 & ipq9574 and document its compatibles.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml        | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
index 6d0d7ed271f7..8335c2952c2a 100644
--- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -11,7 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,ipq6018-pwm
+    oneOf:
+      - items:
+          - enum:
+              - qcom,ipq5332-pwm
+              - qcom,ipq9574-pwm
+          - const: qcom,ipq6018-pwm
+      - enum:
+          - qcom,ipq6018-pwm
 
   reg:
     description: Offset of PWM register in the TCSR block.
-- 
2.34.1

