Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5C80EB18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjLLL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346389AbjLLL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:59:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F8C3;
        Tue, 12 Dec 2023 03:59:31 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBgEhA029961;
        Tue, 12 Dec 2023 11:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=B+sgRFv5yp3Rlr3nFlR9pT+L2BHT0szx2DeDHoUL8MA=; b=oE
        oZIln8pjgk/O5iJY1FWn37F0dq+BJ/BQG15jxX8afwBJDcbY9md3ZdIuoU+L6VTw
        T4ZmtYPs5FDGUivQ8UKYYe/iVJB1x/B2ckx5UoAOfsz8bzk7FB7pNW/REDXn1CB6
        XkWgnDzyWMO8ICKip4uVciBm+dtPYkgMphmn6YKEYUQS4f+Bd4o0wlt9+L/AHHbi
        t0ErZ+Wkg27MP9cC/yBeQm7mWjbLfihkkjGLK082ufWILa8rhTrdCueuFHp+iXsj
        7KrJV8vahzzW5FGXKgiefsJbG4zXhv7822SXbUbIfCOr+CDrdupayp/wGNdmrNAl
        QJgBWXnqYcVEIZuk24vw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxgbb0xw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:59:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBxIMa025475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:59:18 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:59:08 -0800
From:   Suraj Jaiswal <quic_jsuraj@quicinc.com>
To:     <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Rob Herring <robh@kernel.org>
CC:     <kernel@quicinc.com>
Subject: [PATCH net-next v6 1/3] dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for sa8775p
Date:   Tue, 12 Dec 2023 17:28:39 +0530
Message-ID: <20231212115841.3800241-2-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
References: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bm0dyaX7Thdojr3nNLZWVD5qYGUn9S3Y
X-Proofpoint-ORIG-GUID: Bm0dyaX7Thdojr3nNLZWVD5qYGUn9S3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for safety IRQ. The safety IRQ will be
triggered for ECC(error correction code), DPP(data path
parity), FSM(finite state machine) error.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 9 ++++++---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 7bdb412a0185..69a337c7e345 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -37,12 +37,14 @@ properties:
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when HW safety error triggered
 
   interrupt-names:
     minItems: 1
     items:
       - const: macirq
-      - const: eth_lpi
+      - enum: [eth_lpi, sfty]
+      - const: sfty
 
   clocks:
     maxItems: 4
@@ -89,8 +91,9 @@ examples:
                <&gcc GCC_ETH_PTP_CLK>,
                <&gcc GCC_ETH_RGMII_CLK>;
       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-names = "macirq", "eth_lpi";
+                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_lpi", "sfty";
 
       rx-fifo-depth = <4096>;
       tx-fifo-depth = <4096>;
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..9b04e2ed7c18 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -107,13 +107,15 @@ properties:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when HW safety error triggered
 
   interrupt-names:
     minItems: 1
     items:
       - const: macirq
-      - enum: [eth_wake_irq, eth_lpi]
-      - const: eth_lpi
+      - enum: [eth_wake_irq, eth_lpi, sfty]
+      - enum: [eth_wake_irq, eth_lpi, sfty]
+      - enum: [eth_wake_irq, eth_lpi, sfty]
 
   clocks:
     minItems: 1
-- 
2.25.1

