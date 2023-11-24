Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5395B7F70EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbjKXKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbjKXKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:09:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2A10E6;
        Fri, 24 Nov 2023 02:09:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO8f786006188;
        Fri, 24 Nov 2023 10:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QG7QbvcoFmQQG8HsO2lzOqmrQhyiCb3Jh1bIClVtbFg=;
 b=CawoYmjboo9pOtfk/FhfKLm7WQa3cGIvKY+E+Z9xzrTeCxIxS6sLGYnBY77HuRpCDjun
 K/9AfTjjM6BiO15FrOcMp/yfpsZZX2XzpfCvG6ZG6tIpehIZ7WfAo8QXiZ//lDukCPeU
 Bs1k3AzyzPSFb8Kr5DGzvojScIh0v8yU9VPDFISszB+n/Urm+9HJ5P8LJKyEU2JOwJMr
 hM5BFJFpUymkfO2e0S8f4xbo2jdx3k4lGe72Wj+CWZ6UQP4KuibyIcx3/ZgyT5lSLqwK
 k2yH0E1asBrSUAVpWmmLNjEEukfNSDsWlReSSj8IrNWEMj3n5zKfDz5gJIJTeEGHAsW6 lA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj6emt4se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:09:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOA9C44012381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:09:12 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 02:09:06 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <agross@kernel.org>, <vkoul@kernel.org>, <quic_gurus@quicinc.com>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <iommu@lists.linux.dev>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 5/5] dt-bindings: interrupt-controller: qcom,pdc: document pdc on X1E80100
Date:   Fri, 24 Nov 2023 15:36:08 +0530
Message-ID: <20231124100608.29964-6-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vZAhyOENSMSkhwiag__iiIxs5Z-9ArVB
X-Proofpoint-GUID: vZAhyOENSMSkhwiag__iiIxs5Z-9ArVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=875 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1E80100 SoC includes a PDC, document it.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3
* Rebased to the latest lnext. [Krzysztof]

 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8473afffce63..2f7320a5537e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -42,6 +42,7 @@ properties:
           - qcom,sm8350-pdc
           - qcom,sm8450-pdc
           - qcom,sm8550-pdc
+          - qcom,x1e80100-pdc
       - const: qcom,pdc
 
   reg:
-- 
2.17.1

