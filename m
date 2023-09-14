Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4E79FCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjINHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjINHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:06:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A32ECCD;
        Thu, 14 Sep 2023 00:06:54 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E4eWEO019692;
        Thu, 14 Sep 2023 07:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9aOOk9ynVAmWGU7p1tgp3K1zQoP/ZtPSYFChk1O2lX0=;
 b=KJLouSjkTlYSkwYFEeMHa/Zkickw51+euU1PyaJTMhMLSnPNIRu1bCYYQ1m1App4VAH5
 QtseUDvpElqJI/Cx6Nj4ae3EuRq9a+VG1IRUts64kJ6dxE+UWQx7M8vi++UKNtqQ6nII
 L77JH/azkmeZaw3hvQcY11ZnF3H1w10X8hjWE34Gau9x/UlGNu8y1k8G3K7MY/I/F15B
 sz6LUaikZTgIkyv3pSwe5+ezpDYnk5wO/Lh8lGTHKuOp6cuojbbcRipcvUTdlxwTMa1u
 H91cL2vSrhxLyVEraUzan3XLlxBx41/V+kN2ro90K7w2gpPbh3lciAuNgWEyNni86jdy Kg== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ds4282j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:06:33 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38E76UW5009468;
        Thu, 14 Sep 2023 07:06:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3t0hsknfsy-1;
        Thu, 14 Sep 2023 07:06:30 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38E76UER009463;
        Thu, 14 Sep 2023 07:06:30 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 38E76TbY009462;
        Thu, 14 Sep 2023 07:06:30 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id BD19B4E55; Thu, 14 Sep 2023 15:06:28 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com
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
Subject: [PATCH v2] scsi: ufs: qcom: dt-bindings: Add MCQ properties
Date:   Thu, 14 Sep 2023 15:05:57 +0800
Message-Id: <1694675158-38301-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i5uueF1biYhGaabLagsYIGNaMsfNM_ab
X-Proofpoint-GUID: i5uueF1biYhGaabLagsYIGNaMsfNM_ab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=475 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the maxItem limitation to property 'reg',
and add description for the property 'msi-parent'.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index bdfa86a..5ec2717 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -77,7 +77,13 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 2
+    description:
+      Register base addresses and lengths of the UFS areas.
+
+  reg-names:
+    minItems: 1
+    description:
+      Names of the reg areas to use during resource lookup.
 
   required-opps:
     maxItems: 1
@@ -97,6 +103,10 @@ properties:
     description:
       GPIO connected to the RESET pin of the UFS memory device.
 
+  msi-parent:
+    description:
+      Pointer to the hardware entity that serves as the MSI controller for thi UFS controller.
+
 required:
   - compatible
   - reg
-- 
2.7.4

