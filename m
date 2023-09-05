Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B97926BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbjIEQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348572AbjIEEoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:44:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D731B9;
        Mon,  4 Sep 2023 21:44:07 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3854OJee026425;
        Tue, 5 Sep 2023 04:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yVvaRKqMJlk3UqpP5cZkj/ICa0vGp4lU78SSR0qx4m0=;
 b=BShcjV7/woXTvChHx25U4Z+UIDhv6f2y6/s0Dm8K4MqCgrVWWMifuvXMr9QXp1a2O2KL
 7vQnBmLXDyn0Vq8e6ZD+sz8dhB9LAnm08XqLlPU+9X/14yoUPb9keP0Htv/0wpHv/BnF
 yZO7Z47E8uCQv+2QI/eT/u5J9GkOvP1aYctPkmPDZ0WIhc+u1BlsbVYsRq3oGHp+uHBj
 8oL+tDTIYuKSOplNEX0dpY9Ci2oHJ84kGiarjd0ZJ0b6bOmWcShv2ZZQ9O8QYelvqWhR
 DI51y8Kr67ld7mAvAo97R9dLFN23rGDyc9eFpml3akr4KDhrYTSx1P/40rEHTvTIwzmQ hg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swfae1g7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:43:56 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3854hqu0013110;
        Tue, 5 Sep 2023 04:43:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kav1g-1;
        Tue, 05 Sep 2023 04:43:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3854hqnT013104;
        Tue, 5 Sep 2023 04:43:52 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3854hpCl013099;
        Tue, 05 Sep 2023 04:43:52 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 69BC31D04; Tue,  5 Sep 2023 10:13:51 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/5] dt-bindings: phy: Add qcom,sdx75-qmp-usb3-uni schema file
Date:   Tue,  5 Sep 2023 10:13:45 +0530
Message-Id: <1693889028-6485-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPJMKl6kyAFe1sOYpP8Y0jxTOP-Pr_Tl
X-Proofpoint-ORIG-GUID: EPJMKl6kyAFe1sOYpP8Y0jxTOP-Pr_Tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050041
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-binding schema for SDX75 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 .../bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml  | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml
new file mode 100644
index 0000000..2ae0710
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP PHY controller (USB, SDX75)
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description:
+  The QMP PHY controller supports physical layer functionality for a number of
+  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdx75-qmp-usb3-uni-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg_ahb
+      - const: ref
+      - const: pipe
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: common
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+  - "#clock-cells"
+  - clock-output-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdx75.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    phy@ff6000 {
+      compatible = "qcom,sdx75-qmp-usb3-uni-phy";
+      reg = <0x0ff6000 0x2000>;
+
+      clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+               <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+               <&gcc GCC_USB2_CLKREF_EN>,
+               <&gcc GCC_USB3_PHY_PIPE_CLK>;
+      clock-names = "aux",
+                    "cfg_ahb",
+                    "ref",
+                    "pipe";
+
+      power-domains = <&gcc GCC_USB3_PHY_GDSC>;
+
+      resets = <&gcc GCC_USB3PHY_PHY_BCR>,
+               <&gcc GCC_USB3_PHY_BCR>;
+      reset-names = "phy",
+                    "common";
+
+      vdda-phy-supply = <&vreg_l4b_0p88>;
+      vdda-pll-supply = <&vreg_l1b_1p2>;
+
+      #clock-cells = <0>;
+      clock-output-names = "usb3_uni_phy_pipe_clk_src";
+
+      #phy-cells = <0>;
+    };
-- 
2.7.4

