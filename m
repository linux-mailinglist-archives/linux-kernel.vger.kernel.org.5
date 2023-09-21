Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF94D7AA440
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjIUWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjIUWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:03:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BD137;
        Thu, 21 Sep 2023 14:49:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LKjbbP031840;
        Thu, 21 Sep 2023 21:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vqgnZdckmuHqwFaC8TZurCxmlWYXa/Ehk007pmQMbZ8=;
 b=RLqeTvYK8NDf70WL110kS3Kmpn4vXDYKGCWuHGU/zYoowJ3GJLD9ozxOr87Bg16eN9Wq
 Zd+JAuDmK5emcvQreXD3dHiXdCqVpWdu/2a+mqfIIv9PQY6ezM3fUlZWQB3wAqynNxVU
 8nmwtweVUnC3XSZCFu/o2PR54BYI+mitnInf3YiEimMe4+JWKAjeQBfrCbCAheX3OfbN
 KDSNmBVbTC59NYPqrasWebIhO5j3vAcxCeKjDbv2kzLD93Ovbpq8h0gmSCkjFDD5u/3U
 6zjVgq6YVIzt359S+B4BiIt9jMifxXZsYKqrkjVjHvP2kUFnpaplHqDfSERLzx1zEuMs nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8uknr96u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:49:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LLmv5M032099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:48:57 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 14:48:56 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v7 13/33] dt-bindings: usb: dwc3: Limit num-hc-interrupters definition
Date:   Thu, 21 Sep 2023 14:48:23 -0700
Message-ID: <20230921214843.18450-14-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ycws4Fa1Gky-xCbGcyQosTgpE310_DID
X-Proofpoint-ORIG-GUID: ycws4Fa1Gky-xCbGcyQosTgpE310_DID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=603 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the number of XHCI secondary interrupters defined for a DWC3
based implementation is limited to 8.  XHCI in general can potentially
support up to 1024 interrupters.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index a696f23730d3..1be78be1805b 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -376,6 +376,10 @@ properties:
     items:
       enum: [1, 4, 8, 16, 32, 64, 128, 256]
 
+  num-hc-interrupters:
+    maximum: 8
+    default: 1
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
