Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24CB7AA82A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjIVFMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIVFM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:12:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFCC18F;
        Thu, 21 Sep 2023 22:12:22 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M51ngV008240;
        Fri, 22 Sep 2023 05:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=kIXT93jtSG7Dcf7+1ZpE4PRl3rCSTipTWKODSpQmGGY=;
 b=Wv3jiOocOfDn/tog4rDUS5Sr2m0EAQQ7cjtBb+i4Vblb1sMz2OXP5dVO7aEDGyBg1pon
 PKz88sL4KbHY5TJSElbpDrpHbDrZ/G3XdEpIiGWnSfS73pZK/Nn8DZkvjOpVpVweXbMp
 m+Zm/o6adwynAps81k/DAbD6cOwPHW0mhak0dp+SGwh8mro5p/T6N3hfbJhvlqKGk/TV
 +ue/HkBT8vXb+Q73h6K0AyfTTwdqnou63e6WTaAkC5JK3qi0YAWopNUYmywKAZlVNQAV
 ZReCs8MsOQUsbVmodI/JhHGh2Hzp/A/vjLtpYJQ3yP+x4RoNJqZqixlMo65rODdF3dZy ig== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8uknrxd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 05:12:12 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38M57QYg012560;
        Fri, 22 Sep 2023 05:12:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3t55em90v1-1;
        Fri, 22 Sep 2023 05:12:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38M5C7BY018616;
        Fri, 22 Sep 2023 05:12:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38M5C8v7018637;
        Fri, 22 Sep 2023 05:12:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 9A5C11E49; Fri, 22 Sep 2023 10:42:07 +0530 (+0530)
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
Subject: [PATCH v4 3/5] dt-bindings: usb: qcom,dwc3: Fix SDX65 clocks
Date:   Fri, 22 Sep 2023 10:42:03 +0530
Message-Id: <1695359525-4548-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9pWl3IZNXiWpKqBfP8xmOu-ahIIs359u
X-Proofpoint-ORIG-GUID: 9pWl3IZNXiWpKqBfP8xmOu-ahIIs359u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_03,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=731 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220045
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

