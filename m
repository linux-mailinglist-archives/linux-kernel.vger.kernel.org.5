Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D478C697
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjH2N7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbjH2N7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:59:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75BE194;
        Tue, 29 Aug 2023 06:59:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TDRvpE016081;
        Tue, 29 Aug 2023 13:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3HgZxPAJblzo/qZMT7g5J9cAGY7s56PVzrFj7VikI9s=;
 b=Q7bRrSh57tYwu3T5hv1yVn1KpmMWrsJXlCPbsLCJN+JKO6sneDy04aMTKVcSXb/pu/p3
 fLjunPf/ubmuX+cA+/HJj5VZLmVdhFOsqH93XuwkC2aP5umLWD7rLDSjiIBCG7TLM3e8
 QaFOPDGiy9F+NO3ZIhin0TLsOAhEsbJsSGFQ9zciHl9mjjr1uPRLSncN/WgXn53RLvr8
 nKCiSALrSUJxRWNZYjUwcKmV8WiaCz0CWUOK1TfQ1WaKff38aos2lJUykFP05Ob5CAVU
 hDEwJaPKtOVWlXuGnVGOwZ5KYr1vINCs6Rcw1sDdbVgMaukXXUMTp+2SEvObJe/8Qjcx QA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4g6hm78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:58:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDwjh8012090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:58:45 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 29 Aug 2023 06:58:37 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <quic_ipkumar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 1/9] dt-bindings: phy: qcom,uniphy: Rename ipq4019 usb PHY to UNIPHY
Date:   Tue, 29 Aug 2023 19:28:10 +0530
Message-ID: <20230829135818.2219438-2-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wGzCsaMfpelEDBJx5F8UP2QxKaaASrLP
X-Proofpoint-GUID: wGzCsaMfpelEDBJx5F8UP2QxKaaASrLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNIPHY / Combo PHY used on various qualcomm SoC's are very similar to
ipq4019 PHY. Hence renaming this dt-binding to uniphy dt-binding and
can be used for other qualcomm SoCs which are having similar UNIPHY.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 .../phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml}  | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml} (78%)

diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
similarity index 78%
rename from Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
index 09c614952fea..cbe2cc820009 100644
--- a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
@@ -1,13 +1,18 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#
+$id: http://devicetree.org/schemas/phy/qcom,uniphy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcom IPQ40xx Dakota HS/SS USB PHY
+title: Qualcomm UNIPHY
 
 maintainers:
   - Robert Marko <robert.marko@sartura.hr>
+  - Praveenkumar I <quic_ipkumar@quicinc.com>
+
+description:
+  UNIPHY / COMBO PHY supports physical layer functionality for USB and PCIe on
+  Qualcomm chipsets.
 
 properties:
   compatible:
-- 
2.34.1

