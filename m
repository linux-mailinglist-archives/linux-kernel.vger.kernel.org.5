Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB66792806
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbjIEQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354276AbjIEKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:31:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1562CE8;
        Tue,  5 Sep 2023 03:30:58 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3859GJvl020272;
        Tue, 5 Sep 2023 10:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=sjI78r/3r3qjGhnVneYrGC+ayXPDVe/k7BOLmZbuPs8=;
 b=kDhQ5TBW8YbfYpSQ7gQjiTMhi+133Rtlg7ybjJ2cWfFcMtV5w62780i4vCDm//Is6Ikw
 WwbMY14C9SnNKoopb8EZpUz1Y+UKb1nzT+sDEN/FdU/7LDYVg6/8CZ943l2dEUMngwfy
 scM8sASAk2OkssqS8+b2wlqHsXeNX4D0KzgEjbuVJlCkEAhKFWSGdhHJmV+PVLJsWQgF
 ws69QPJhheUIPG3AP0/xscrEFOXVkIhnwp8AqZWQELv+JoKDne+cT3vxBzq2DGbsfGZP
 KVohvz5lME7hA/6bHYFrs0ymvz8NV5IVSpXvhncFYAJ7XmHVcsJUHJXESPa+AF4eBodl bw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swsp58vh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 10:30:44 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 385AUehD018105;
        Tue, 5 Sep 2023 10:30:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sux4km16r-1;
        Tue, 05 Sep 2023 10:30:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385AUeHM018094;
        Tue, 5 Sep 2023 10:30:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 385AUevn018087;
        Tue, 05 Sep 2023 10:30:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id D790E1D1E; Tue,  5 Sep 2023 16:00:39 +0530 (+0530)
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
Subject: [PATCH v2 2/5] dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY
Date:   Tue,  5 Sep 2023 16:00:35 +0530
Message-Id: <1693909838-6682-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d_FpHIomEwaq70fC11UIPiL6yvUWFGzW
X-Proofpoint-GUID: d_FpHIomEwaq70fC11UIPiL6yvUWFGzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=913 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050093
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for USB3 PHY found on Qualcomm SDX75.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 40 ++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index f99fbbc..5725620 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,qcm2290-qmp-usb3-phy
       - qcom,sa8775p-qmp-usb3-uni-phy
       - qcom,sc8280xp-qmp-usb3-uni-phy
+      - qcom,sdx75-qmp-usb3-uni-phy
       - qcom,sm6115-qmp-usb3-phy
 
   reg:
@@ -38,9 +39,7 @@ properties:
     maxItems: 2
 
   reset-names:
-    items:
-      - const: phy
-      - const: phy_phy
+    maxItems: 2
 
   vdda-phy-supply: true
 
@@ -75,6 +74,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq9574-qmp-usb3-phy
+              - qcom,sdx75-qmp-usb3-uni-phy
     then:
       properties:
         clock-names:
@@ -122,6 +122,40 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-qmp-usb3-phy
+              - qcom,qcm2290-qmp-usb3-phy
+              - qcom,sa8775p-qmp-usb3-uni-phy
+              - qcom,sc8280xp-qmp-usb3-uni-phy
+              - qcom,sm6115-qmp-usb3-phy
+    then:
+      properties:
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: phy
+            - const: phy_phy
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdx75-qmp-usb3-uni-phy
+    then:
+      properties:
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: phy
+            - const: common
+
 additionalProperties: false
 
 examples:
-- 
2.7.4

