Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9476B3D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjHALwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjHALwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:52:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD2C7;
        Tue,  1 Aug 2023 04:52:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Ahb47000769;
        Tue, 1 Aug 2023 11:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Ucs/AIcc42iyIhwla04Sf5HkBqkmEeFUieVvFoDw0Yw=;
 b=TBu/LUe2+V6T7iDl7GHHroAB3fHbLXHqR8arOEHKce1NFECCEvaopXl9S54FU4dONFn2
 AkuzRMboMXepvyk6lfSnQIrBS4ld8hi79ZSI2UqOCVlaYoDO/WQsq5wcf5ZqcuWGxPrF
 dPr2SbfIu3TmADwxeVerWPSuDjFNraGNLvE3F/V6FuVh3Kv2pVldaj1W6gDdZmW0g+D3
 PcVEeoYigHDxcA9oRjWvTATmsxj9Boj4xpWQngybzGiBfutbwQjBEWAyarI1QR2Cj+pR
 xJIZeqV7VdChc6QpcVvK3JcDsg9wE9ZVITk+d+62KCXSQNYb0vnSsoKsh4CGgBYpVA9t 0w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d0mu1p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 11:52:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371Bq7rI003024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 11:52:07 GMT
Received: from hu-ajainp-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 04:52:03 -0700
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Anvesh Jain P <quic_ajainp@quicinc.com>
Subject: [PATCH] bindings: mfd: qcom-pm8xxx: add a property for rtc-pm8xxx
Date:   Tue, 1 Aug 2023 17:21:43 +0530
Message-ID: <20230801115143.27738-1-quic_ajainp@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WwutmcfvYV2MI7ac2_IvBsbc1n3C4iMU
X-Proofpoint-ORIG-GUID: WwutmcfvYV2MI7ac2_IvBsbc1n3C4iMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=580 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update rtc-pm8xxx bindings with disable-alarm-wakeup property.

Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
---
 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 9c51c1b19067..e4f1d2ff02b6 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -42,6 +42,9 @@ properties:
 
   interrupt-controller: true
 
+  disable-alarm-wakeup:
+    description: optional, disable alarm wake up capability.
+
 patternProperties:
   "led@[0-9a-f]+$":
     type: object

base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
-- 
2.17.1

