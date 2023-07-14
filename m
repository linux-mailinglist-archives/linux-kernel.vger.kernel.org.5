Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69475369B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjGNJcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjGNJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEB30C8;
        Fri, 14 Jul 2023 02:31:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E2vWVm019143;
        Fri, 14 Jul 2023 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jqB/M0SvgpNVOytyj0EUvs9YFMXWLmfEWxnrFzJvpLs=;
 b=n5ASPxrsmJQ9SIisE9iziWHllKOPNGzXXQ/Z/t9KpSnkZaMXK4mPjQB3+gTE8XPo1F4I
 /irHA6QaO7x3AHm1S/8FDGSIU210LzFKF/xvpWxrA5Rp1HaeFctDqyiSSUXRvUs/DQWU
 RalRen8VR2fCDODlfvZiA3T63s495unCQofE5rXlQUdn5xKBDxGbsRYX673rgfdmN9Tv
 R+hz1hiRiEFr3Gp06cH09Fh5bEokiTf3WnQPv7byirkGItuoAp1SVerpxOmvsGFeRTyx
 t1l+pm/TFWKCJMo/Qt1QUXtfHFMa7ZoEZt9O5hsutNEGzu32Apezdh941wXB4JYGhwAz QQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpub9bwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:30:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E9UtM4027790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:30:56 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 02:30:50 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <thara.gopinath@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <bhupesh.sharma@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH V4] dt-bindings: crypto: qcom-qce: add SoC compatible string for ipq9574
Date:   Fri, 14 Jul 2023 15:00:32 +0530
Message-ID: <20230714093032.22400-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: za5omIAvPWGg_SjU_bW2tmONizKv29Q4
X-Proofpoint-GUID: za5omIAvPWGg_SjU_bW2tmONizKv29Q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=817 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for ipq9574.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
NOTE: This change was added as part of the series below
https://lore.kernel.org/linux-arm-msm/20230526161129.1454-1-quic_anusha@quicinc.com/
Since the dts change is picked, this patch is required
to resolve CHECK_DTBS issue

 Changes in V4:
        - Updated subject prefix to include subsystem crypto.
        - Picked up Acked-by tag.
        - Picked up Reviewed-by tag.

 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index bb828068c3b8..8e665d910e6e 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -34,6 +34,7 @@ properties:
           - enum:
               - qcom,ipq6018-qce
               - qcom,ipq8074-qce
+              - qcom,ipq9574-qce
               - qcom,msm8996-qce
               - qcom,qcm2290-qce
               - qcom,sdm845-qce

base-commit: 40b055fe7f276cf2c1da47316c52f2ff9255a68a
-- 
2.17.1

