Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1097854AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjHWJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjHWJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:48:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201230FF;
        Wed, 23 Aug 2023 02:18:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N5JWmS004038;
        Wed, 23 Aug 2023 09:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Oydt5gLBPQjsDIrttRFYl9R2uTjPyMcbYR88t//A2u8=;
 b=CYM4V3TcX/1+9xMGPY3QJmfZfYj5QJmtMT+qzLqYuy0eHsv8Mwfkw2lVQVX3XB4h2YKA
 1ID5fsttGanPNWWbjNqSdqby3pg183GVYv+Sy5lqkDHbswG6ZueAj5SQObGsq+BJQZNC
 jfj18ZRvUYUgYsQ2uJT3AozYJ4feNTtT9PW5G3gL/ZMuxdmahLKYYPrcLc6c1p7YKbzL
 fCutpX9S1vpOIiH3Koaakbs9pwsEb6vGEI+GV7JllYsnd1fkfq1NmAHo6ZUabUFtR8kN
 WS7xYOYAQW4R/2Ms77OUzahFMBGe7tO7ulI6F2lNzAMPYPoicjaBtQyKrsXlZGWwMAXW zA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn208hnpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 09:18:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37N9I1VY018331;
        Wed, 23 Aug 2023 09:18:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sjptkpxta-1;
        Wed, 23 Aug 2023 09:18:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37N9I1Hr018296;
        Wed, 23 Aug 2023 09:18:01 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37N9I0hc018292;
        Wed, 23 Aug 2023 09:18:01 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 543275000AA; Wed, 23 Aug 2023 14:48:00 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V3 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
Date:   Wed, 23 Aug 2023 14:47:56 +0530
Message-Id: <20230823091757.31311-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
References: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3cZcNVyrEt0zz2tiGAfwmlyvUm_XESoQ
X-Proofpoint-ORIG-GUID: 3cZcNVyrEt0zz2tiGAfwmlyvUm_XESoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230084
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP UFS PHY compatible for SC7280.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index d981d77e82e4..19140ee1f889 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sa8775p-qmp-ufs-phy
+      - qcom,sc7280-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
       - qcom,sdm845-qmp-ufs-phy
@@ -99,6 +100,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc7280-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
--
2.17.1

