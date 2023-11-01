Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F47DDBC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjKAECM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKAECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:02:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367ADF;
        Tue, 31 Oct 2023 21:02:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A11vpbZ031127;
        Wed, 1 Nov 2023 04:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=7hxHgKStLp4kLx/Vn0TFARVQ9iOgMIJxkdR3hYP1PNk=;
 b=VVJxvFz7FP6tXhettQd5y8Zm93H/W+8iJfM8lbzo5LXNSSQSpG6j6DXv69qFw7CV3KrM
 d5PifuQG7cAY9GoJMb9sxbt3sZ/nhXESGVAP7sx6OQqItk99OHe+3VOCStW6Ox0CFuvH
 vaM50Z8J75vliCowf37YDpW/nTH5DNi+j1W/YlSGQOUa1F1teyWDHIIjT/51UXpjC4kg
 ygWJ8wH3C2pocXVk8RoWKQM3DjAyfUX136T3cwXPYCPGYyAwf3bq2+mgjLaQSon3TzVI
 V5mF0h0s/YD1tbR28cm9BjHXvXsZadNomDzw5vP5ZzSOZVZYMz8lxLFTKB7y65RZQHtE hg== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3ayvrkkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 04:01:21 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A141IIT013366;
        Wed, 1 Nov 2023 04:01:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3u0ucma7sr-1;
        Wed, 01 Nov 2023 04:01:18 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A141IP5013361;
        Wed, 1 Nov 2023 04:01:18 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3A141HUt013360;
        Wed, 01 Nov 2023 04:01:18 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id DBB4853F5; Wed,  1 Nov 2023 12:01:16 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt-bindings: ufs: qcom: Add msi-parent for UFS MCQ
Date:   Wed,  1 Nov 2023 12:01:09 +0800
Message-Id: <1698811270-76312-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y0Ppfrsa43hIFi2NT0_LbgRnd-ns4l8x
X-Proofpoint-ORIG-GUID: Y0Ppfrsa43hIFi2NT0_LbgRnd-ns4l8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=736
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010032
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Message Signaled Interrupt (MSI) has been used
by UFS driver since the MCQ be enabled. Hence in UFS
DT node, we need to give the msi-parent property that
point to the hardware entity that serves as the MSI
controller for this UFS controller.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5..d2f505a 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -103,6 +103,8 @@ properties:
     description:
       GPIO connected to the RESET pin of the UFS memory device.
 
+  msi-parent: true
+
 required:
   - compatible
   - reg
@@ -318,5 +320,6 @@ examples:
                             <0 0>,
                             <0 0>;
             qcom,ice = <&ice>;
+            msi-parent = <&gic_its 0x60>;
         };
     };
-- 
2.7.4

