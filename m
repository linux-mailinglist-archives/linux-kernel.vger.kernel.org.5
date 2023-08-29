Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D078C6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjH2OAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbjH2N7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:59:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2DD7;
        Tue, 29 Aug 2023 06:59:34 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TDo1DQ010097;
        Tue, 29 Aug 2023 13:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=kIlejBzYsF/A84csXRL0l0tfSiqE/VUEexcW3bCS9js=;
 b=VA9RiYRRdoIsMF1Agjsi3tWHli9mzvpSm7IaenTodNUXs39208BbvrOEN1xLIpLHWwZM
 c+MIq8+PdHxTDrH+TW8ZYnEli0TJHdI2/iHqVDiN8LZAl6jPDmY82kxQ+J6BjeewC+kM
 s+PYQhAd9T3zUT9RAH6clXaQjkVUSwVFcLNjWUVon1OtShyoeA2gYWjNofuqkPRc/waq
 /UMcAvjxqNkk6NNgp9XRXUkcRWQP+JQpTKh0ILHhcafRhURrvxoojwdEzjTNSXViOsp4
 o4eFY2zeVd3Ymz5OPKexQBAvzIFzcBCj8Xz7Av6B4c+JmykMtRwnBNtnRuxjiQIcOX5w TQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss6j89ea6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:59:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDx7Sf002142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:59:07 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 29 Aug 2023 06:59:00 -0700
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
Subject: [PATCH 4/9] dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS UNIPHY
Date:   Tue, 29 Aug 2023 19:28:13 +0530
Message-ID: <20230829135818.2219438-5-quic_ipkumar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0kxMqG8lnk9vjZcGmfl46xnO_KmeIYHo
X-Proofpoint-GUID: 0kxMqG8lnk9vjZcGmfl46xnO_KmeIYHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ipq5332 USB3 SS UNIPHY support.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,uniphy.yaml  | 117 +++++++++++++++++-
 1 file changed, 114 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
index cbe2cc820009..17ba661b3d9b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
@@ -19,21 +19,53 @@ properties:
     enum:
       - qcom,usb-ss-ipq4019-phy
       - qcom,usb-hs-ipq4019-phy
+      - qcom,ipq5332-usb-ssphy
 
   reg:
     maxItems: 1
 
+  reg-names:
+    items:
+      - const: phy_base
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    maxItems: 3
+
+  "#clock-cells":
+    const: 0
+
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
-    items:
-      - const: por_rst
-      - const: srif_rst
+    minItems: 1
+    maxItems: 2
+
+  clock-output-names:
+    maxItems: 1
 
   "#phy-cells":
     const: 0
 
+  qcom,phy-mux-sel:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      PHY Mux Selection for used to select which interface is going to use the
+      combo PHY.
+    items:
+      - items:
+          - description: phandle to TCSR syscon region
+          - description: offset to the PHY Mux selection register
+          - description: value to write on the PHY Mux selection register
+
+  vdd-supply:
+    description:
+      Phandle to 5V regulator supply to PHY digital circuit.
+
 required:
   - compatible
   - reg
@@ -41,6 +73,68 @@ required:
   - reset-names
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-usb-ssphy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: pipe
+            - const: phy_cfg_ahb
+            - const: phy_ahb
+
+        "#clock-cells":
+          const: 0
+
+        clock-output-names:
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: por_rst
+
+        vdda-supply:
+          description:
+            Phandle to 5V regulator supply to PHY digital circuit.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,usb-ss-ipq4019-phy
+    then:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: por_rst
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,usb-hs-ipq4019-phy
+    then:
+      properties:
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: por_rst
+            - const: srif_rst
+
 additionalProperties: false
 
 examples:
@@ -55,3 +149,20 @@ examples:
                <&gcc USB2_HSPHY_S_ARES>;
       reset-names = "por_rst", "srif_rst";
     };
+
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+
+    ssuniphy@4b0000 {
+      #phy-cells = <0>;
+      #clock-cells = <0>;
+      compatible = "qcom,ipq5332-usb-ssphy";
+      reg = <0x4b0000 0x800>;
+      clocks = <&gcc GCC_USB0_PIPE_CLK>,
+               <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+               <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
+      clock-names = "pipe", "phy_cfg_ahb", "phy_ahb";
+
+      resets = <&gcc GCC_USB0_PHY_BCR>;
+      reset-names = "por_rst";
+    };
-- 
2.34.1

