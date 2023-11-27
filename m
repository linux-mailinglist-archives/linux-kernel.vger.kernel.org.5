Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152FC7F9F52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjK0MOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjK0MO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:14:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F007810F;
        Mon, 27 Nov 2023 04:14:34 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARBLrkv022755;
        Mon, 27 Nov 2023 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=GnHgs/oiZbsBfML8eUHTU9zqWhlGG3/cogQIaRxrnsQ=;
 b=BkNrg9Ln+OVm09eL4y1o9817oudkE3BEyXW10a8HzllPgOLfZXYm2MY5HKtDQc+QopfH
 3dgF3HooxLTlHVc1SgZwzgEuFHKPjcf+HWJ8GXsQbKFkTsChao0q+wibSal4yinJCcOM
 tpunsvKBMexFIiOPOQpxMWJTEOLDaMEFtyAN8OFE+qJHqm8p/p2vCCiNyjXwcx5vfduG
 UB9Ph9eWCPoJYwV2FFADkMqv1XUtmUA21iNgzk1WrPNnovxlmJWqUkD6K/H+XZOWIOOE
 FpWOyYnHVWUABSXqs/T4adR0qwv1bLvjkPcy0G4nyiY2Ol/uog+qUfuo0xQudjIMGsi4 rg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt63036g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARCERp6014923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:27 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 04:14:22 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Mon, 27 Nov 2023 17:43:49 +0530
Subject: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-refclk_always_on-v3-1-26d969fa8f1d@quicinc.com>
References: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
In-Reply-To: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701087256; l=1195;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=b3DOMQj6Bhju4h0J8NhBRIj6lknp3jleEt1YDn8qkHE=;
 b=vsA26FIK+JfF4MRQu9PTq7Xt79VhZ2FfN/C0746c2kFg5c2JrgVU1r1fUn9U4j4GnYEDYpVLI
 dnF5u5C6hewAZH9HhrZAMwWUbKVJesfKLSnXm0aCnZRm2BvK/c/OEhD
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AUwF9-XudjQ4gTtbjP2KqU4U0ZhK30MU
X-Proofpoint-ORIG-GUID: AUwF9-XudjQ4gTtbjP2KqU4U0ZhK30MU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270083
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
index 2c3d6553a7ba..c747c9f35795 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -93,6 +93,13 @@ properties:
   "#phy-cells":
     const: 0
 
+  qcom,refclk-always-on:
+    type: boolean
+    description: In some platform where PCIe switch is connected, pcie switch due to some design
+      limitation fails to propage clkreq signal to the host and due to that host will not send
+      refclk, which  results in linkdown in L1.2 or L1.1 exit initiated by EP.
+      This property if set keeps refclk always on even in Low power states.
+
 required:
   - compatible
   - reg

-- 
2.42.0

