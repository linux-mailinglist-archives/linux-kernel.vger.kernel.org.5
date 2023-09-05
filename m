Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E60792AE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjIEQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348623AbjIEEoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:44:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283C1B9;
        Mon,  4 Sep 2023 21:44:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3854P2Yg030219;
        Tue, 5 Sep 2023 04:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=FMbRPrDf59qmugisH2Imhj/oST47qaA/zUfNV7t6V8o=;
 b=Xf5cEAVbDtc7/9RZRPFZHcnUf4ngdB8IIE8K9saTOUhrUB8BFQe1kl632hGkKv/262Lq
 EiYH14iAxZvh5mmJLm9AhgHKBReVgLJUs/G4Tn3PlvNpabM8dBqnl9IjC7xAwCAX7hts
 kQSBKk67SaUecnyWEHdtKIlgeCMgbux9ZpIe6WW1XLYfJz9/Zt2IAjkHz9fn9Jd9fVli
 MHnZYkboaH65KLqNRws9ESd5ema3xhnGeCsVU3vFXEyRTo9g3jl0Hg0gxa+YF12hYeRS
 L/SzcSN6OxjCDrhXp7hxrYXfN/yaJzydJjeIZKnrgk431QFpJ+iLLY/kBOs9ttIJ9sM9 kw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swsp58a7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:43:55 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3854hp6F013097;
        Tue, 5 Sep 2023 04:43:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kav1a-1;
        Tue, 05 Sep 2023 04:43:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3854hpBA013090;
        Tue, 5 Sep 2023 04:43:51 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3854hpp9013086;
        Tue, 05 Sep 2023 04:43:51 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E3CE41D0C; Tue,  5 Sep 2023 10:13:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: phy: qcom,snps-eusb2-phy: Add compatible for SDX75
Date:   Tue,  5 Sep 2023 10:13:44 +0530
Message-Id: <1693889028-6485-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nn8MwlWSUSCYu99Uapcwf94xCrR_OgiI
X-Proofpoint-GUID: Nn8MwlWSUSCYu99Uapcwf94xCrR_OgiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_02,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=747 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050039
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-bindings compatible string for the SDX75 SoC that
uses Synopsis eUSB2 PHY.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
index c53bab1..c958286 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
@@ -14,7 +14,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,sm8550-snps-eusb2-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sdx75-snps-eusb2-phy
+          - const: qcom,sm8550-snps-eusb2-phy
+      - const: qcom,sm8550-snps-eusb2-phy
 
   reg:
     maxItems: 1
-- 
2.7.4

