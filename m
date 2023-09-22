Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359FB7AB14F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjIVLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:51:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E32CFB;
        Fri, 22 Sep 2023 04:51:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MBV4gS023156;
        Fri, 22 Sep 2023 11:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=Jjjgz8MACMd8B2zKOIgVDJNTV1kC7yF/rOsLr3aK6vo=;
 b=jFkIwQtjs9QQ8Zq3RIqxzEnpIO33+Z5OgkT/gd6YFfD5uCy2dvKqx7V8/sAm7BFa3C2A
 FPxiLBK624tkbqKYdS0xtclkeHgm+L1vRjIwz9ohQ7TQoAsfLIxXQpIEKeoGa4DDfIf4
 RUPSmhfvapa0oXCub5Ipc5gf5K6lEW4gAiItu1YRhlPKq/ZWbB8OKU5WPmGg23ymp6fy
 lU954/60vKNihFoOtj5SbXJZ/+QB/PlSj+hbJ9rlk55jELdDO3bLBJlVz8yZb1Go9fe5
 cBROphyrw9s6gyAM8Z1uanutDTHTbk0JmbqY6goa0doUjWA3Rzmt4YQm5puJWuWaQRM0 +A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9a3e81dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38MBjX0E022921;
        Fri, 22 Sep 2023 11:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3t55emanc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MBob7V027216;
        Fri, 22 Sep 2023 11:51:17 GMT
Received: from win-platform-upstream01.qualcomm.com (win-platform-upstream01.qualcomm.com [10.242.182.84])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 38MBpHYB027853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:17 +0000
Received: by win-platform-upstream01.qualcomm.com (Postfix, from userid 330701)
        id 866E751B; Fri, 22 Sep 2023 17:21:16 +0530 (IST)
From:   Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
Subject: [PATCH V3 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date:   Fri, 22 Sep 2023 17:21:13 +0530
Message-Id: <20230922115116.2748804-2-srichara@win-platform-upstream01.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kr7YLUkVJpHAlbTr-0VS3DbxTVCV8Gjv
X-Proofpoint-GUID: kr7YLUkVJpHAlbTr-0VS3DbxTVCV8Gjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1034
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=916 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v3] Added the tsens-ipq5018 as  new binding without rpm

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 27e9e16e6455..a02829deeb24 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -44,6 +44,10 @@ properties:
               - qcom,qcs404-tsens
           - const: qcom,tsens-v1
 
+      - description: v1 of TSENS without rpm
+        enum:
+          - qcom,ipq5018-tsens
+
       - description: v2 of TSENS
         items:
           - enum:
-- 
2.34.1

