Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6747E3E86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjKGMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbjKGMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:38:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8744A4;
        Tue,  7 Nov 2023 04:26:36 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7BnJZW000452;
        Tue, 7 Nov 2023 12:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=uPsoinHeDoc7N25qpGvTTRb3DieCiuKixzBcb2JUxEY=;
 b=Ej6ztT02wys9rROH4uDNhE8BrHVGL3MRP7DNd7qcKv5XtyKtIG5t+vhzR4ONnzb4Sc+0
 bosZ/1xmhKtK5Q1yDLwAtp2VN/ML5tc/Qg1BYVEuBqI+c4c6OYOSqkYKRXAYmct6l+RB
 3Jw7LLL1zqonAdpixk/RzYUYCL5CdlPEWMrTxny1PIWQpt8ZLobdiMRbZLCXM+WfykeF
 84wzATlMfJT840duP/i5+VESWSiPRibNwP0qdBKiEKmY9G30s2qpLPzBTaTlBAhnV+7o
 ITWkQUF2Qh+tYjv+EzY8YNcJPW9MsmZIQ651OGvJ839E25GmPCj33bwFNTQh4ABQycv7 4w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7agf1d33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:26:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A7CQVrb016331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 12:26:31 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 7 Nov 2023 04:26:26 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Tue, 7 Nov 2023 17:56:13 +0530
Subject: [PATCH v2 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231107-refclk_always_on-v2-1-de23962fc4b3@quicinc.com>
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com>
In-Reply-To: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699359980; l=1150;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=bGcOGQ7/h7qizeQy9acT6JrbtM+JoTZYnjuCaZCveSc=;
 b=v78gfvPYj6eIqYYNow+q37ESn/P1x0tzxOFV7+xY4Y524mws+wf19XWY9soaE1EAlv0c1wzBO
 yGIpdpWJ+RICtZ7WI+swailZ1h2JvkQ+vCHMMd4T16zTDOhn8bSlYm8
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2qnfMQfejQE6CU_RqsIY046FQ8nzKfww
X-Proofpoint-GUID: 2qnfMQfejQE6CU_RqsIY046FQ8nzKfww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_02,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document qcom,refclk-always-on property which is needed in some platforms
to supply refclk even in PCIe low power states.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c3d6553a7ba..263291447a5b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -93,6 +93,13 @@ properties:
   "#phy-cells":
     const: 0
 
+  qcom,refclk-always-on:
+    type: boolean
+    description: If there is some issues in platform with clkreq signal
+      propagation to the host and due to that host will not send refclk, which
+      results in linkdown in L1.2 or L1.1 exit initiated by EP. This property
+      if set keeps refclk always on even in Low power states (optional).
+
 required:
   - compatible
   - reg

-- 
2.42.0

