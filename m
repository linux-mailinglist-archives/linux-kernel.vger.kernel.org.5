Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E4792BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjIERDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348575AbjIEEoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:44:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B851B9;
        Mon,  4 Sep 2023 21:44:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853hVJs002466;
        Tue, 5 Sep 2023 04:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gIy5E9rIIyEzpZAAV0U85csG1L5snZkzgv67shoXEC8=;
 b=p5fDCdIirj43MbZD2bpvTWsru3rB5ZZh6rId6zEeBTC4W9LNkxTWSbh1uAI/xUAICxyY
 +zczgdjj+H3I3/bfB4EHvlDC0Sb9mS8CGWWUVgidgYiL+7j9ohAnt2+RQEM+W0boTbre
 L/N3tEjOpRiOK4FJIS6rmNkNdzph2yPVDZU6IV6awUTrOG2sT7PNrnU1i/+pX4KJTaVx
 4E5yMnM0QMBIwM4+gAQpTvRSRWrw26rXdwygK3iffQE8tV8oX27pQL6H8owkPT0n3CAt
 f0b0BfSPioVwQhO7d8yZ+h62DoyKNHKZDfPHYbQjkHtHa9QN/QjQSQK0DQFlwgRpgmbC nQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sweb51f3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:43:56 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3854hrgU013135;
        Tue, 5 Sep 2023 04:43:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kav1q-1;
        Tue, 05 Sep 2023 04:43:53 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3854hqnX013104;
        Tue, 5 Sep 2023 04:43:52 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3854hpCp013099;
        Tue, 05 Sep 2023 04:43:52 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 384A51D16; Tue,  5 Sep 2023 10:13:52 +0530 (+0530)
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
Subject: [PATCH 4/5] dt-bindings: usb: dwc3: Add SDX75 compatible
Date:   Tue,  5 Sep 2023 10:13:47 +0530
Message-Id: <1693889028-6485-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wwsfLwJo_TV7Cjcc95jsA4OK2-Zc0tgL
X-Proofpoint-GUID: wwsfLwJo_TV7Cjcc95jsA4OK2-Zc0tgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_02,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=557 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050040
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SDX75 dwc3 compatible.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index fa51f50..30b2e20 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,sdm845-dwc3
           - qcom,sdx55-dwc3
           - qcom,sdx65-dwc3
+          - qcom,sdx75-dwc3
           - qcom,sm4250-dwc3
           - qcom,sm6115-dwc3
           - qcom,sm6125-dwc3
@@ -187,6 +188,7 @@ allOf:
               - qcom,sdm845-dwc3
               - qcom,sdx55-dwc3
               - qcom,sdx65-dwc3
+              - qcom,sdx75-dwc3
               - qcom,sm6350-dwc3
     then:
       properties:
@@ -361,6 +363,7 @@ allOf:
               - qcom,sdm845-dwc3
               - qcom,sdx55-dwc3
               - qcom,sdx65-dwc3
+              - qcom,sdx75-dwc3
               - qcom,sm4250-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm6350-dwc3
-- 
2.7.4

