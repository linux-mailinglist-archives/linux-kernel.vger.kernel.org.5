Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B08127F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjLNG3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjLNG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:29:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE775B9;
        Wed, 13 Dec 2023 22:29:25 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE6O3lW004599;
        Thu, 14 Dec 2023 06:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=B8DEEb6RlwnVITJEQM5PUFk9W/h80Pp8iAtLBC8Gsoo=; b=XH
        J8N0TLetrE18Ii2O6fxXN/KCeL2AsBbIkysZoOElc5gQRWSUFFQ74b+7VSd/wt6z
        Jnkcv8ScnnYFPRK+MGqgMRDcSqm7a0Ih46cuCZ98fACbFoMD4vzgdhzYvk4laKoG
        xrF1YPxVbsvHTEDxYtnb+Gnxf4BJs24xGLe417Fidnb5czD+yFb8/XR2wAv6mfjc
        dNDvl1fm2oEig8GaOyCnSpbARBRxqsNQKFQ4UkGNWFQ0KnBpIWs847JfmcwGQJtR
        +H5xWz5w1QC4Pk0EkKEA3jvPPWGOfZZ9xe9OZDJ8k+MW58Cg8x1fR9xQLp2I8PAw
        CTkHal/uveOqx/uc5K6g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp4xgqef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 06:29:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6TGhc016097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 06:29:16 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:29:08 -0800
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC:     <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 01/10] dt-bindings: clock: Add separate clocks for PCIe and USB for Combo PHY
Date:   Thu, 14 Dec 2023 11:58:38 +0530
Message-ID: <20231214062847.2215542-2-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jtjZ0YZrLMdW4_sZYz0WxqrTZio88GSu
X-Proofpoint-ORIG-GUID: jtjZ0YZrLMdW4_sZYz0WxqrTZio88GSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm IPQ5332 has a combo PHY for PCIe and USB. Either one of the
interface (PCIe/USB) can use this combo PHY and the PHY drivers are
different for PCIe and USB. Hence separate the PCIe and USB pipe clock
source from DT, and individual driver node can be used as a clock source
separately in the gcc. Change the dt-bindings accordingly.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,ipq5332-gcc.yaml         | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
index 718fe0625424..b22643037119 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
@@ -28,7 +28,8 @@ properties:
       - description: Sleep clock source
       - description: PCIE 2lane PHY pipe clock source
       - description: PCIE 2lane x1 PHY pipe clock source (For second lane)
-      - description: USB PCIE wrapper pipe clock source
+      - description: PCIE wrapper pipe clock source
+      - description: USB wrapper pipe clock source
 
 required:
   - compatible
@@ -45,7 +46,8 @@ examples:
                <&sleep_clk>,
                <&pcie_2lane_phy_pipe_clk>,
                <&pcie_2lane_phy_pipe_clk_x1>,
-               <&usb_pcie_wrapper_pipe_clk>;
+               <&pcie_wrapper_pipe_clk>,
+               <&usb_wrapper_pipe_clk>;
       #clock-cells = <1>;
       #power-domain-cells = <1>;
       #reset-cells = <1>;
-- 
2.34.1

