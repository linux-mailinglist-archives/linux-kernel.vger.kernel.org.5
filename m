Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13DA7C00D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjJJPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjJJPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:53:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD78A7;
        Tue, 10 Oct 2023 08:53:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEOI1c026900;
        Tue, 10 Oct 2023 15:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FzLL87SJ190U6pNr9AjGvg/r3hyVqbdFxXodkt/2MWo=;
 b=efxhgCPek/e791WTJG8tqEkmUcBoatDW7oiiJFYZR3/AfDWBxLjmYvFh/q8ek6a9PNID
 9uZmQjXyOsS2q43PFg836eGVCSgjLXx5AfSAe7+bXHcVP8nL11qmAKOg8QdITSu5slEt
 QQ4UcY1C0GVbWy928N3WTFnxb33hIRUCRxI5tjW/1FRJzCIZsAIG960B743Cuu1qkCjQ
 OMoeasXeFdJWdXPZUxEEMapvQKLiXqF/Nh5U3KmmAQ8zGFT54R3dyIqAiDEEen+klBCP
 yfQUIp7iF3TP7OBy02iOYrz+7oG24+WYCVidSDboKRFCIkAIPckjHXWkjhESMTLw8Jqe Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmw3j1g8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:50:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AFntkM022702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:49:55 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 08:49:50 -0700
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>
Subject: [PATCH V1 1/4] dt-bindings: ufs: qcom: Add qos property
Date:   Tue, 10 Oct 2023 21:19:04 +0530
Message-ID: <1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
References: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wsINolfMNBSY-OKbdSKEqhkvk7UIVfUb
X-Proofpoint-ORIG-GUID: wsINolfMNBSY-OKbdSKEqhkvk7UIVfUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=888
 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310100117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for per-cpu QoS for QCOM UFS. This improves random io
performance by 20% for QCOM UFS.

Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5..d8b807e 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -76,6 +76,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle to the Inline Crypto Engine node
 
+  qos:
+    minItems: 2
+    maxItems: 2
+    cpumask:
+     description: list of CPUs under CPU group
+    vote:
+     description: vote value for QoS CPU group
+
   reg:
     minItems: 1
     maxItems: 2
@@ -318,5 +326,13 @@ examples:
                             <0 0>,
                             <0 0>;
             qcom,ice = <&ice>;
+            qos0 {
+                cpumask = <0x0f>;
+                vote = <44>;
+            };
+            qos1 {
+                cpumask = <0xf0>;
+                vote = <44>;
+            };
         };
     };
-- 
2.7.4

