Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB297C0143
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjJJQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjJJQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:09:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B70123;
        Tue, 10 Oct 2023 09:09:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ACQTlc011774;
        Tue, 10 Oct 2023 16:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=52qlLiHeZes94cIO745mAEYaJm9Wm90if+QtQZ7BS4E=;
 b=UnK7JBPygeq/h+M88Swhd45Ovs7uPJSNbyoTtnGI/76DqcPixre/7ShU+4BbLTBuowhW
 XXcwdNE7YCP4Uggkzi2awONKo6TAP0xZMWAa/VfBG8crPZY0XCHAmbkXEcMAucDbtzQY
 HMePsAMd3yOVgsWSsC+2avEJr0tFbgF1FNOitg5F1GESFQ/IgxlHUa2VrOMOTr6Qftlx
 05xDHuCIK8jqUD7Aweuw9A1U6iTFestcvxYn+9bT0jcV5n5QPdgJw9PYV30PsiO/DFZX
 9+VreGqS1oCSZxBOfdVckqz3FA/4xicUfr3hlCV7ZH0YrOroeulbqTRL6bablM5X1MfJ DQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmj0db0pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 16:09:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AG9aCB019012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 16:09:36 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 09:09:33 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8{2|3|5}50
Date:   Tue, 10 Oct 2023 21:39:15 +0530
Message-ID: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5p7XBYqiuhHmkpIhXPpTc6HiHYzeq0f3
X-Proofpoint-ORIG-GUID: 5p7XBYqiuhHmkpIhXPpTc6HiHYzeq0f3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_11,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=679 malwarescore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for sm8{2|3|5}50 SoCs.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 33c3d023a106..f328ddd6c566 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -29,7 +29,10 @@ properties:
           - qcom,sdx65-tcsr
           - qcom,sm4450-tcsr
           - qcom,sm8150-tcsr
+          - qcom,sm8250-tcsr
+          - qcom,sm8350-tcsr
           - qcom,sm8450-tcsr
+          - qcom,sm8550-tcsr
           - qcom,tcsr-apq8064
           - qcom,tcsr-apq8084
           - qcom,tcsr-ipq5332
-- 
2.7.4

