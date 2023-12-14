Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4C0812B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjLNJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjLNJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:03:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F011B;
        Thu, 14 Dec 2023 01:04:01 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5dNL9017365;
        Thu, 14 Dec 2023 09:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=mpb9J/YO/uB0jlf1r6qW5LJVCkw1qcvSyKfD0EbExOg=; b=J8
        EvZKV1XAXmqTBTF2ofTudI92S3DKYaN96LOjjHZWemqocTiJ9QceaX7RGol/wjoE
        K+JQHCNf9gOZoDwpaHDskhjnZsGi2s7knOOwXO9BZeT7cyYY78jIErbmsHvvgWBF
        Rmj6PU1TGlCBFrM7vIucilBrQty12yEq9wdoGp96DqBlMGwKsvX5zBtkCdUNLqFj
        tgObWmOGt7aTirqT03s8Vr6OPw2ZqOZTZh1xEVNMJwVQM+gSpScbihCdQBPLS6MA
        eA5OGo/gfiUi6WUyeDgZCH9qUKZSgbUeBh6ctuq2BJuKBts3B4Nz9J4bFz+cLNWO
        /HkyQdlYzQNP9fAKVAyw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp4xh0b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE93nJU028629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:49 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:03:44 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332 platform
Date:   Thu, 14 Dec 2023 17:03:04 +0800
Message-ID: <20231214090304.16884-6-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214090304.16884-1-quic_luoj@quicinc.com>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8trfveeldZpNI5eRxpVi3PUoZy7LshOx
X-Proofpoint-ORIG-GUID: 8trfveeldZpNI5eRxpVi3PUoZy7LshOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the yaml file for the new DTS properties.

1. cmn-reference-clock for the CMN PLL source clock select.
2. clock-frequency for MDIO clock frequency config.
3. add uniphy AHB & SYS GCC clocks.
4. add reset-gpios for MDIO bus level reset.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../bindings/net/qcom,ipq4019-mdio.yaml       | 143 +++++++++++++++++-
 1 file changed, 139 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 3407e909e8a7..79f8513739e7 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -20,6 +20,8 @@ properties:
           - enum:
               - qcom,ipq6018-mdio
               - qcom,ipq8074-mdio
+              - qcom,ipq9574-mdio
+              - qcom,ipq5332-mdio
           - const: qcom,ipq4019-mdio
 
   "#address-cells":
@@ -30,19 +32,77 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 2
+    maxItems: 5
     description:
-      the first Address and length of the register set for the MDIO controller.
-      the second Address and length of the register for ethernet LDO, this second
-      address range is only required by the platform IPQ50xx.
+      the first Address and length of the register set for the MDIO controller,
+      the optional second, third and fourth address and length of the register
+      for ethernet LDO, these three address range are required by the platform
+      IPQ50xx/IPQ5332, the last address and length is for the CMN clock to
+      select the reference clock.
+
+  reg-names:
+    minItems: 1
+    maxItems: 5
 
   clocks:
+    minItems: 1
     items:
       - description: MDIO clock source frequency fixed to 100MHZ
+      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
+      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
+      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
+      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
 
   clock-names:
+    minItems: 1
     items:
       - const: gcc_mdio_ahb_clk
+      - const: uniphy0_ahb
+      - const: uniphy1_ahb
+      - const: uniphy0_sys
+      - const: uniphy1_sys
+
+  cmn-reference-clock:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    oneOf:
+      - items:
+          - enum:
+              - 0   # CMN PLL reference internal 48MHZ
+              - 1   # CMN PLL reference external 25MHZ
+              - 2   # CMN PLL reference external 31250KHZ
+              - 3   # CMN PLL reference external 40MHZ
+              - 4   # CMN PLL reference external 48MHZ
+              - 5   # CMN PLL reference external 50MHZ
+              - 6   # CMN PLL reference internal 96MHZ
+
+  clock-frequency:
+    oneOf:
+      - items:
+          - enum:
+              - 12500000
+              - 6250000
+              - 3125000
+              - 1562500
+              - 781250
+              - 390625
+    description:
+      The MDIO bus clock that must be output by the MDIO bus hardware,
+      only the listed frequencies above can be supported, other frequency
+      will cause malfunction. If absent, the default hardware value 0xff
+      is used, which means the default MDIO clock frequency 390625HZ, The
+      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
+      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
+      register, there is higher clock frequency requirement on the normal
+      working case where the MDIO slave devices support high clock frequency.
+
+  reset-gpios:
+    maxItems: 1
+
+  reset-assert-us:
+    maxItems: 1
+
+  reset-deassert-us:
+    maxItems: 1
 
 required:
   - compatible
@@ -61,6 +121,8 @@ allOf:
               - qcom,ipq5018-mdio
               - qcom,ipq6018-mdio
               - qcom,ipq8074-mdio
+              - qcom,ipq5332-mdio
+              - qcom,ipq9574-mdio
     then:
       required:
         - clocks
@@ -70,6 +132,20 @@ allOf:
         clocks: false
         clock-names: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-mdio
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        reg-names:
+          minItems: 4
+
 unevaluatedProperties: false
 
 examples:
@@ -100,3 +176,62 @@ examples:
         reg = <4>;
       };
     };
+
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio@90000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "qcom,ipq5332-mdio",
+                   "qcom,ipq4019-mdio";
+      cmn-reference-clock = <0>;
+      clock-frequency = <6250000>;
+
+      reset-gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
+      reset-assert-us = <100000>;
+      reset-deassert-us = <100000>;
+
+      reg = <0x90000 0x64>,
+            <0x9B000 0x800>,
+            <0x7A00610 0x4>,
+            <0x7A10610 0x4>;
+
+      reg-names = "mdio",
+                  "cmn_blk",
+                  "eth_ldo1",
+                  "eth_ldo2";
+
+      clocks = <&gcc GCC_MDIO_AHB_CLK>,
+               <&gcc GCC_UNIPHY0_AHB_CLK>,
+               <&gcc GCC_UNIPHY1_AHB_CLK>,
+               <&gcc GCC_UNIPHY0_SYS_CLK>,
+               <&gcc GCC_UNIPHY1_SYS_CLK>;
+
+      clock-names = "gcc_mdio_ahb_clk",
+                    "uniphy0_ahb",
+                    "uniphy1_ahb",
+                    "uniphy0_sys",
+                    "uniphy1_sys";
+
+      qca8kphy0: ethernet-phy@1 {
+        compatible = "ethernet-phy-id004d.d180";
+        reg = <1>;
+      };
+
+      qca8kphy1: ethernet-phy@2 {
+        compatible = "ethernet-phy-id004d.d180";
+        reg = <2>;
+      };
+
+      qca8kphy2: ethernet-phy@3 {
+        compatible = "ethernet-phy-id004d.d180";
+        reg = <3>;
+      };
+
+      qca8kphy3: ethernet-phy@4 {
+        compatible = "ethernet-phy-id004d.d180";
+        reg = <4>;
+      };
+    };
-- 
2.42.0

