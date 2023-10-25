Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070FD7D6DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjJYOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjJYOA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:00:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B3186;
        Wed, 25 Oct 2023 07:00:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDQ8G7007063;
        Wed, 25 Oct 2023 14:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JXlBZNY8x/Vghyv5/U65nn2G5hF4fnM3KxnkEeLzBv4=;
 b=cME7vN+FDPGd7putNPfHo9hKWjYgcV1wK5vCqYdX+ib2A0RQc/waASVxbtHDLc/4Qu3p
 3iGWu39URvF1QJ653M+A5/UTtwIu2321CjKkWvB72JYjD+OzFLvav/XF6N36PHYblNK8
 65hQqfM+QFp3xVoKq/c7CcoBpsuy/joiXGE/8UiM0kUbzomVWYWhX0SLX8LlHIlpAYye
 r/MoqRAkxoV0Tx2u8LL/2Y8Uy+hYJf2SWoSmxofTIwzJpgPuIOvU1yRCqLq6LlcsFlvR
 XVDAnH5nWmzhX8mbpHYfSi/ObT+9Z2toIN3hB8IRto8R0emx2zlFcZXh1c4vSLykrZc5 eQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txpj5hfe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:00:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PE0Jo4030531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:00:19 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 07:00:14 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/3] dt-bindings: power: rpmpd: Add SC8380XP support
Date:   Wed, 25 Oct 2023 19:29:42 +0530
Message-ID: <20231025135943.13854-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025135943.13854-1-quic_sibis@quicinc.com>
References: <20231025135943.13854-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vazshF2j6IjzZaHXLd9R0PDvb8LeJ6eO
X-Proofpoint-GUID: vazshF2j6IjzZaHXLd9R0PDvb8LeJ6eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=867 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add compatible and constants for the power domains exposed by the RPMH
in the Qualcomm SC8380XP platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index d38c762e1280..6bca9c6c377f 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,sc7280-rpmhpd
           - qcom,sc8180x-rpmhpd
           - qcom,sc8280xp-rpmhpd
+          - qcom,sc8380xp-rpmhpd
           - qcom,sdm660-rpmpd
           - qcom,sdm670-rpmhpd
           - qcom,sdm845-rpmhpd
-- 
2.17.1

