Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875E7A546A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjIRUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRUvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:51:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B510F;
        Mon, 18 Sep 2023 13:50:55 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IKSUK2019490;
        Mon, 18 Sep 2023 20:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/0w/Pw6MVxUYguEpGa13mcoGmQZJerEttp10SyJr+RI=;
 b=BUB0SifRpdZR/X5bOQniKCRTnoZ6GcGPkeqRxehmmRUEMkPNAKKsRAC2KqXE+Bp771wl
 cKBfS5LZrftsHKy7UxlA8kIM/Yd5ytjR8x0BECOibbWI8XC5HN9lrU+F/rJwNsdaHLeY
 xg2JglPOgg7coYabqL7fb08PECz2i1XYyXsbfdJcqLVKQY0VIwasDP8TECByiE3g06yP
 cnCcJ7Ypsn+dP3Hwga1hdITbE4J/NnQhHg24wj02syVeJZ/wJ+fMjzPnxw418vKgFVy6
 u+fe7clUPnXeBvdWke5nkrY1Ev4luG+rhNfDCAfOkyYSRQvpignieXa5H773/LN3//+a 8w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t53ybc0n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 20:50:44 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38IKofCj001958;
        Mon, 18 Sep 2023 20:50:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3t55ekpd96-1;
        Mon, 18 Sep 2023 20:50:41 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38IKofE9001952;
        Mon, 18 Sep 2023 20:50:41 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38IKoeR7001949;
        Mon, 18 Sep 2023 20:50:41 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 1CA165000AB; Tue, 19 Sep 2023 02:20:40 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V4 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
Date:   Tue, 19 Sep 2023 02:20:36 +0530
Message-Id: <20230918205037.25658-2-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918205037.25658-1-quic_nitirawa@quicinc.com>
References: <20230918205037.25658-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YZp--x0Gb1Tk_u-Jo-GvM6RjnNtOw8Oo
X-Proofpoint-ORIG-GUID: YZp--x0Gb1Tk_u-Jo-GvM6RjnNtOw8Oo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_09,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=955
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180180
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP UFS PHY compatible for SC7280.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index d981d77e82e4..f3a3296c811c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sa8775p-qmp-ufs-phy
+      - qcom,sc7280-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
       - qcom,sdm845-qmp-ufs-phy
@@ -85,6 +86,7 @@ allOf:
           contains:
             enum:
               - qcom,sa8775p-qmp-ufs-phy
+              - qcom,sc7280-qmp-ufs-phy
               - qcom,sm8450-qmp-ufs-phy
     then:
       properties:
--
2.17.1

