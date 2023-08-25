Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7907883DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjHYJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbjHYJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:36:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF21FD4;
        Fri, 25 Aug 2023 02:36:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P82rbW001203;
        Fri, 25 Aug 2023 09:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=g+HyQdbah2fCy1rJl66+/0IoUDzGvL5GuT59ChWAtz8=;
 b=nEvHH//KXzXAoyWVDHQu1NH8uk80nRULtYft4O6StzgFmZa5/pERCbTv6oq1mPs+gebT
 Aj9LJk9DVOm37HEDmSHHl6vnpaXERCF0i8KQrA0pDLI54JUDHDlm1dqiVxmxNvFM4+J+
 bj/hbu6tKNeeovDgkgBF4NXgZW3LF22s3ZZ09y7uIb7YJtYPNkXvp40SIYAeb0fX0+LY
 J6sLkZRQsxzroiML+vCT4xFzTgULjqaJnqCaAbgkXw2zIYXtgvgzC5bqigtxQ0eumEHe
 Zt412Q7OD0RNDrJDtbFi5IGZem7Gc2aPWb2JAUBGMQmJy/pm4ZsTvGJ47gSVupNkn1GZ tw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spnm80ge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:36:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37P9aCgn020558
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:36:12 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 25 Aug 2023 02:36:07 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
Date:   Fri, 25 Aug 2023 15:05:27 +0530
Message-ID: <20230825093531.7399-2-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825093531.7399-1-quic_nsekar@quicinc.com>
References: <20230825093531.7399-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9T0nTKZZy4jQbABCKO-z3kyA8KQZ9o0d
X-Proofpoint-GUID: 9T0nTKZZy4jQbABCKO-z3kyA8KQZ9o0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=828
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 qcom,m31 phy driver can support IPQ5018.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
index 2671a048c926..e77576d06c0e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
@@ -17,7 +17,9 @@ description:
 properties:
   compatible:
     items:
-      - const: qcom,ipq5332-usb-hsphy
+      - enum:
+          - qcom,ipq5018-usb-hsphy
+          - qcom,ipq5332-usb-hsphy
 
   "#phy-cells":
     const: 0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

