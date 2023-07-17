Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73394755BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGQGhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGQGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:37:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7783393;
        Sun, 16 Jul 2023 23:37:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5TnJQ015101;
        Mon, 17 Jul 2023 06:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=r3fML3pK532WUxA07U/gAYgpG1jCYzJPxPWmPFF4inw=;
 b=Cbn74wtt+kOiiHQaQP1baaBfpDvH0VFfXY+RA66yBCDFmEL3Kt8wM6I8XO7kPgaKQy1Y
 QRGiYlWY+ot80SEYcy9u4hvo/gzT+zWeBA/tsRGYzsGuRWV+VMV34Qmgw3hTBsH/ot/A
 O93cHRh45IUBG3JVwia1kCL/2H1WjxHdpEY1s1OAOMj54Dw1yzQZQfKWcCQqb64tuKoX
 cHUSczb1/3z0DBOQFff9dznaquKu87S5cWEaLXvj4tFeRFnAFaJv74zRkXywYsVtEsx9
 c12EXw2c0vHGtvJ6Rriv7cGf9+sP5muQ4KRyKbo5D+vvtVxXlOY1eViEM1mXMURisaSM 7A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0etk9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 06:26:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H6QcSB010348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 06:26:38 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 23:26:34 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>
Subject: [PATCH v1 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC support
Date:   Mon, 17 Jul 2023 14:25:46 +0800
Message-ID: <20230717062547.2086869-2-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717062547.2086869-1-quic_fenglinw@quicinc.com>
References: <20230717062547.2086869-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nS5jJjDx4VK7sD5gmIqoBV8gL-jL_g-W
X-Proofpoint-ORIG-GUID: nS5jJjDx4VK7sD5gmIqoBV8gL-jL_g-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=858
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for vibrator module inside Qualcomm PMI632, PM7250B, PM7325B
and PM7550BA PMICs.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
index c8832cd0d7da..642408e2b35f 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
@@ -15,6 +15,10 @@ properties:
       - qcom,pm8058-vib
       - qcom,pm8916-vib
       - qcom,pm8921-vib
+      - qcom,pmi632-vib
+      - qcom,pm7250b-vib
+      - qcom,pm7325b-vib
+      - qcom,pm7550ba-vib
 
   reg:
     maxItems: 1
-- 
2.25.1

