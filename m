Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD87A978C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjIURZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjIURZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED11301F3;
        Thu, 21 Sep 2023 10:06:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L9IKlk017017;
        Thu, 21 Sep 2023 10:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=kIXT93jtSG7Dcf7+1ZpE4PRl3rCSTipTWKODSpQmGGY=;
 b=Fo2ecvcQg1S55+3w/uUe1NX0oDGtN9S47sC8fx3m6SqLkD0KvinzDAklwHFX8BEqMQnk
 cYalGIAtJUStvIl8RS5JcEV+h5RReqP5/OT9Fj69/wUxLRW7l+C8d5cE5Y3OfFCk7wYf
 4FPkfN/HvylQGxtKPvR0SOgZ9ssMjWtB61Kx8uQP0nRm6wVpgMIx1K8++8E9Ao+AnnFJ
 0GeTZFnj8hDY8DjWz6vnZQw/5mv/lMRgKGAqLr9Pf5FJQ1F9FGa8xQnpkX50a1aoVBtF
 +q3X2zB+YAh7MxBi2ZeNLIxc19oqlkleVmNqB5uSwAIPhQ+XHYu7mqJhYY3GQ7AcXNRK 3Q== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8hb8gc7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 10:21:41 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38LALcWF023145;
        Thu, 21 Sep 2023 10:21:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t55ekq7p6-1;
        Thu, 21 Sep 2023 10:21:38 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LALcHT023148;
        Thu, 21 Sep 2023 10:21:38 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38LALb61023116;
        Thu, 21 Sep 2023 10:21:38 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id D39551E4D; Thu, 21 Sep 2023 15:51:36 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com, dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 3/5] dt-bindings: usb: qcom,dwc3: Fix SDX65 clocks
Date:   Thu, 21 Sep 2023 15:51:30 +0530
Message-Id: <1695291692-18850-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695291692-18850-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1695291692-18850-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: efJRcUpAxL4l9QtAofmGWvoUwq_1-yKN
X-Proofpoint-GUID: efJRcUpAxL4l9QtAofmGWvoUwq_1-yKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_07,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=724 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDX65 has 5 clocks so mention in the bindings.

Fixes: 16946a60715c ("dt-bindings: usb: qcom,dwc3: fix clock matching")
Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 6759105..018117b 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -180,6 +180,7 @@ allOf:
               - qcom,sdm670-dwc3
               - qcom,sdm845-dwc3
               - qcom,sdx55-dwc3
+              - qcom,sdx65-dwc3
               - qcom,sm6350-dwc3
     then:
       properties:
-- 
2.7.4

