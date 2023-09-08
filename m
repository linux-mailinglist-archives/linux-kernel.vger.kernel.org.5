Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E137982E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjIHG7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjIHG7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:59:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCC19AE;
        Thu,  7 Sep 2023 23:59:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3886xVxd025708;
        Fri, 8 Sep 2023 06:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dDYPy2xYcNpnMcyFI86iiz7uvtDs9XNxUStRRdAn4+A=;
 b=C9KTVz+pI/CRDvFl5uTL6QDvEN8Z4e4o1Ll/BwI/c0mntL90tDZvza6wVkbjJi6dRobv
 vyOWnIDoQQHagcwCYnmhgPt0XzbAzKODbnxp+rYJXEO1jUb2WoHF1DGLAdlnOEkS5vBY
 plOWXYAmkTQQOXkW4L5FBgA9EIcAfdGNRVJ6hH0kNJBgby8FfhCCE04P6zbraKeo+lTb
 LA6JQ3Jdm0vedrfAPX/4VDcu7tAaCXHgv/vB5i1ygaK+U6tVHb+dFdxpRMLRxP5F1J31
 RknDBxeRyEvCznJ7PysEgJt9XxrJjkP6UCFFxBJC0IdgA3vpp00WxdWahAS3fb/gskh3 hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy50db47d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:59:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886xTE3021886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:59:29 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:59:22 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <lee@kernel.org>
CC:     <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <quic_bjorande@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 2/6] dt-bindings: mfd: qcom,tcsr: Add compatible for sm4450
Date:   Fri, 8 Sep 2023 14:58:43 +0800
Message-ID: <20230908065847.28382-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230908065847.28382-1-quic_tengfan@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xjJQFmpyqQuRkDjhtRD6TbYu-xfFLAKJ
X-Proofpoint-GUID: xjJQFmpyqQuRkDjhtRD6TbYu-xfFLAKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=854 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcom,sm4450-tcsr compatible.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 5ad9d5deaaf8..33c3d023a106 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,sdm845-tcsr
           - qcom,sdx55-tcsr
           - qcom,sdx65-tcsr
+          - qcom,sm4450-tcsr
           - qcom,sm8150-tcsr
           - qcom,sm8450-tcsr
           - qcom,tcsr-apq8064
-- 
2.17.1

