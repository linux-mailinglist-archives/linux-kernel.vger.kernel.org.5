Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2230378B816
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjH1TT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjH1TTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:19:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCF110;
        Mon, 28 Aug 2023 12:19:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SGhGYC002321;
        Mon, 28 Aug 2023 19:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PsndlhTYaRJQt7IIFP4JWV3rao/7ZOb7mUBQ4oj7m00=;
 b=TL03OQNO3BcypcLxYzQ583c2YpTm86vuG2AIyFhPHtsKAK1Hgo38c4H/fg3rFNT8uZrb
 wS+0Fy5pWsFdhLlWzdmLTWSeoNlxXOXug5WfVhtX3gVRZWmQS5K8vaoBiukxFOTPjF1R
 TMn3RdiaIldSZZMRH0notvdfj+AEaSks/FifqXkQIM4J6TKDqy8q57xuEIq18uA/1DzU
 bLiyV5mIDrr9DPLkUs8kPPX7ElWP9VH2vUW0rJnvDxk59J6A1T3h72F8zTlnuxzeKMEt
 xvcToFc1HyyxFCZhCvU13DxXJnJJ6Cd63A2MRQ170cyNG0XktFsfQ8NI4Q6cNk/fah8y 2w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybq8b97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 19:19:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SJJTmw003302
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 19:19:29 GMT
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 12:18:51 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH 1/7] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date:   Tue, 29 Aug 2023 00:48:21 +0530
Message-ID: <1693250307-8910-2-git-send-email-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DTzPe1bNEBukIZK1yi5sIWyyvN_hHaKy
X-Proofpoint-GUID: DTzPe1bNEBukIZK1yi5sIWyyvN_hHaKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_16,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280168
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
 .../bindings/thermal/qcom-tsens.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 27e9e16e6455..2309bb6dce1b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -42,6 +42,7 @@ properties:
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens
+              - qcom,ipq5018-tsens
           - const: qcom,tsens-v1
 
       - description: v2 of TSENS
@@ -409,4 +410,22 @@ examples:
            #qcom,sensors = <16>;
            #thermal-sensor-cells = <1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 5 (for any IPQ5018 based SoC-s):
+    tsens5: thermal-sensor@4a9000 {
+           compatible = "qcom,ipq5018-tsens", "qcom,tsens-v1";
+           reg = <0x4a9000 0x1000>, /* TM */
+                 <0x4a8000 0x1000>; /* SORT */
+
+           nvmem-cells = <&tsens_calib>;
+           nvmem-cell-names = "calib";
+
+           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "uplow";
+
+           #qcom,sensors = <5>;
+           #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.34.1

