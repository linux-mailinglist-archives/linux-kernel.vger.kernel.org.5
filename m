Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43B7E206F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjKFLxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:53:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E05CC;
        Mon,  6 Nov 2023 03:53:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A66sYKI020278;
        Mon, 6 Nov 2023 11:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=iCRPVgoSfTPphK6nYKNnwtDm6/nq4BYyS9rWUi1mo4w=;
 b=cigVpHgNM1i1unJ5sywfHUt4l/3MAzoM+alkz5oU2ogt+EoijvEEej76X0cGWR4U3y6r
 0w+/YsAiO2E3Kg4CkWKEJ/eunpuwYgSuE88MVS532/MSEumgMhLCJR830kTK7RBF4oon
 tU5+6rfsgjWxRK4HobIs+3HxGyTzkoOU5X6Na5FsLG4zg2axd2gXnbOoi7lUawCbN5ZM
 Spb0u7GI+jdkunbLdWp2V1ABGVDbcv+WBu6Sunr9b4hMqslqostKU8aKYCS6ImTk1MvK
 s/8Pnxctg+DXsidXWqkkX2+yHhc0L3c+NIq2nRwKAWH0KUMGKO8/EG5X0C/HEIWuT38K Kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5efym37v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 11:52:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6BquSX014855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 11:52:56 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 03:52:50 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Mon, 6 Nov 2023 17:22:34 +0530
Subject: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231106-refclk_always_on-v1-1-17a7fd8b532b@quicinc.com>
References: <20231106-refclk_always_on-v1-0-17a7fd8b532b@quicinc.com>
In-Reply-To: <20231106-refclk_always_on-v1-0-17a7fd8b532b@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699271565; l=957;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=clnxNjj6kIAlRoVkvSUkZ2Yc60o0/wKFBKk4hr9cUVM=;
 b=Sb4ZQnUgZ3SumeV6YGPLsxZ9iGFsdbmxTwyb/zNi3GaYjCUatd9y0ZmZuJSRgNjorPyDBfwYz
 9qJUjbdxQUqBA/LiDZCOcUqCZ9AjBGjODi33yx+XHJFIh6VekHKRbfS
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tFYyU2c4dGf0T6y9RQyJtKaMQ55ncGzc
X-Proofpoint-ORIG-GUID: tFYyU2c4dGf0T6y9RQyJtKaMQ55ncGzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document qcom,refclk-always-on property which is needed in some platforms
to supply refclk even in PCIe low power states.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c3d6553a7ba..9daf0556ed3b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -93,6 +93,11 @@ properties:
   "#phy-cells":
     const: 0
 
+  qcom,refclk-always-on:
+    type: boolean
+    description: A boolean property indicating the refclk is
+      always on even in Low power states (optional)
+
 required:
   - compatible
   - reg

-- 
2.42.0

