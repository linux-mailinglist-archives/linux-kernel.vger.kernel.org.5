Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511807EBBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjKOD0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjKOD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:26:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF57C3;
        Tue, 14 Nov 2023 19:26:21 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AENg479027751;
        Wed, 15 Nov 2023 03:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=AQpWJyQavn2ZQqxdC8CNOkUtvM8ck18GRwWMCErMJ1s=;
 b=YiRYMVtSm1bOe8Z6f604G93v+UtgZ67e6IdLQRiqpqS+cq5dlRCpxHQJWVj0hLTViqzJ
 /qCQ573My7SLvgBUeiNPo9buCInrQaIQ+L4z92q1CMt/Wm3v6R36swlsiu++mVkK7cvq
 VtR1RRmRkqDSC5m/e2O+J438udcT0U8hxSjQZNF4AjDMhT3mXm4cZgF98hooYYh7cQ6L
 GxuoRtZayeZe5ocrSZTM26HuBUF/c/ft8ZYs0G9MwCRAq2B50SIZumrno4yZQITsP3ki
 Int7NfFh+feh77Iq6c/XoXjIAAl7FxbpXmWg99zq2CLFF0LJYmvjK1rbFtxKl87/22fT 4Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfke0tmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:26:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3Q8so027100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:26:08 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:26:03 -0800
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
Subject: [PATCH 9/9] dt-bindings: net: ipq4019-mdio: Document ipq5332 platform
Date:   Wed, 15 Nov 2023 11:25:15 +0800
Message-ID: <20231115032515.4249-10-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115032515.4249-1-quic_luoj@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bOk5oRJxc54QUcI3xmGN9Nx9uw3jSauR
X-Proofpoint-ORIG-GUID: bOk5oRJxc54QUcI3xmGN9Nx9uw3jSauR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platform IPQ5332, the MDIO address of qca8084 can be programed
when the device tree property "fixup" defined, the clock sequence
needs to be completed before the PHY probeable.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../bindings/net/qcom,ipq4019-mdio.yaml       | 138 +++++++++++++++++-
 1 file changed, 130 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 3407e909e8a7..7ff92be14ee1 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -15,11 +15,13 @@ properties:
       - enum:
           - qcom,ipq4019-mdio
           - qcom,ipq5018-mdio
+          - qcom,ipq5332-mdio
 
       - items:
           - enum:
               - qcom,ipq6018-mdio
               - qcom,ipq8074-mdio
+              - qcom,ipq9574-mdio
           - const: qcom,ipq4019-mdio
 
   "#address-cells":
@@ -30,19 +32,47 @@ properties:
 
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
-    items:
-      - description: MDIO clock source frequency fixed to 100MHZ
+    minItems: 1
+    maxItems: 5
+    description:
+      MDIO system clock frequency fixed to 100MHZ, and the GCC uniphy
+      clocks enabled for resetting ethernet PHY.
 
   clock-names:
-    items:
-      - const: gcc_mdio_ahb_clk
+    minItems: 1
+    maxItems: 5
+
+  phy-reset-gpio:
+    minItems: 1
+    maxItems: 3
+    description:
+      GPIO used to reset the PHY, each GPIO is for resetting the connected
+      ethernet PHY device.
+
+  phyaddr-fixup:
+    description: Register address for programing MDIO address of PHY devices
+
+  pcsaddr-fixup:
+    description: Register address for programing MDIO address of PCS devices
+
+  mdio-clk-fixup:
+    description: The initialization clocks to be configured
+
+  fixup:
+    description: The MDIO address of PHY/PCS device to be programed
 
 required:
   - compatible
@@ -61,6 +91,8 @@ allOf:
               - qcom,ipq5018-mdio
               - qcom,ipq6018-mdio
               - qcom,ipq8074-mdio
+              - qcom,ipq5332-mdio
+              - qcom,ipq9574-mdio
     then:
       required:
         - clocks
@@ -70,6 +102,29 @@ allOf:
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
+          items:
+            - description: MDIO clock source frequency fixed to 100MHZ
+            - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
+            - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
+            - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
+            - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
+        clock-names:
+          items:
+            - const: gcc_mdio_ahb_clk
+            - const: gcc_uniphy0_ahb_clk
+            - const: gcc_uniphy0_sys_clk
+            - const: gcc_uniphy1_ahb_clk
+            - const: gcc_uniphy1_sys_clk
+
 unevaluatedProperties: false
 
 examples:
@@ -100,3 +155,70 @@ examples:
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
+      compatible = "qcom,ipq5332-mdio";
+      reg = <0x90000 0x64>, <0x7A00610 0x4>, <0x7A10610 0x4>, <0x9B000 0x800>;
+      reg-names = "mdio", "eth_ldo1", "eth_ldo2", "cmn_blk";
+
+      clocks = <&gcc GCC_MDIO_AHB_CLK>,
+               <&gcc GCC_UNIPHY0_AHB_CLK>,
+               <&gcc GCC_UNIPHY0_SYS_CLK>,
+               <&gcc GCC_UNIPHY1_AHB_CLK>,
+               <&gcc GCC_UNIPHY1_SYS_CLK>;
+
+      clock-names = "gcc_mdio_ahb_clk",
+                    "gcc_uniphy0_ahb_clk",
+                    "gcc_uniphy0_sys_clk",
+                    "gcc_uniphy1_ahb_clk",
+                    "gcc_uniphy1_sys_clk";
+
+      phy-reset-gpio = <&tlmm 51 GPIO_ACTIVE_LOW>;
+      phyaddr-fixup = <0xC90F018>;
+      pcsaddr-fixup = <0xC90F014>;
+      mdio-clk-fixup;
+
+      qca8kphy0: ethernet-phy@1 {
+        reg = <1>;
+        fixup;
+      };
+
+      qca8kphy1: ethernet-phy@2 {
+        reg = <2>;
+        fixup;
+      };
+
+      qca8kphy2: ethernet-phy@3 {
+        reg = <3>;
+        fixup;
+      };
+
+      qca8kphy3: ethernet-phy@4 {
+        reg = <4>;
+        fixup;
+      };
+
+      qca8kpcs0: pcsphy0@5 {
+        compatible = "qcom,qca8k_pcs";
+        reg = <5>;
+        fixup;
+        };
+
+      qca8kpcs1: pcsphy1@6 {
+        compatible = "qcom,qca8k_pcs";
+        reg = <6>;
+        fixup;
+        };
+
+      qca8kxpcs: xpcsphy@7 {
+        compatible = "qcom,qca8k_pcs";
+        reg = <7>;
+        fixup;
+        };
+    };
-- 
2.42.0

