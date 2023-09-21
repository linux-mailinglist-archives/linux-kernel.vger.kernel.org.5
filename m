Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8A7A98D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIURxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjIURwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:52:51 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AEF53664;
        Thu, 21 Sep 2023 10:16:49 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38LATD9I031087;
        Thu, 21 Sep 2023 17:06:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=k2ysNniZTiB3pUaxQW8Vb1XOTlrzCqvDMX27IlP7ezU=; b=Yf
        dPOovkR+EKH2JR+hywe9DaeX7HlDuJkzAPuYPPIb64nlzt9EYhXZvadmYXjJ/lSt
        k6i8Ht0R72NTaov2ViMccUtPLQ5ma/N+gEiIz1MBURj+EO3DT7Wn6Z/pmbsZeEhz
        dSbT21AuK2GrdgkJi+4HnN3CQB3sd5U5mJE123ahZ0CVUvoe29SvHQUUywwlGZAM
        WpctJi/E3pqkiUTp3PYtbBu+jz4dRPURZHrt6+L3aUOZJEBalLUgfs+BShdV8fDP
        51FAmDo5OHCIowDW/k7VQMYWN519TSv9IKvUKMH3yJlqvXgMs6xWbSnBRUh81JWB
        c8+Hokw/YYX3zlU16ecA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t51sfn3gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:06:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8668F100058;
        Thu, 21 Sep 2023 17:06:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A461252250;
        Thu, 21 Sep 2023 17:06:50 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 17:06:49 +0200
From:   Christophe Roullier <christophe.roullier@foss.st.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] dt-bindings: net: add STM32MP13 compatible in documentation for stm32
Date:   Thu, 21 Sep 2023 17:06:16 +0200
Message-ID: <20230921150622.599232-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921150622.599232-1-christophe.roullier@foss.st.com>
References: <20230921150622.599232-1-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../devicetree/bindings/net/stm32-dwmac.yaml  | 140 +++++++++++++++---
 1 file changed, 118 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index fc8c96b08d7d..75836916c38c 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -22,15 +22,17 @@ select:
         enum:
           - st,stm32-dwmac
           - st,stm32mp1-dwmac
+          - st,stm32mp13-dwmac
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - st,stm32mp13-dwmac
+          - const: snps,dwmac-4.20a
       - items:
           - enum:
               - st,stm32mp1-dwmac
@@ -72,27 +74,69 @@ properties:
         - eth-ck
         - ptp_ref
 
-  st,syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: phandle to the syscon node which encompases the glue register
-          - description: offset of the control register
+  phy-supply:
+    description: PHY regulator
+
+  st,ext-phyclk:
     description:
-      Should be phandle/offset pair. The phandle to the syscon node which
-      encompases the glue register, and the offset of the control register
+      set this property in RMII mode when you have PHY without crystal 50MHz and want to
+      select RCC clock instead of ETH_REF_CLK. or in RGMII mode when you want to select
+      RCC clock instead of ETH_CLK125.
+    type: boolean
 
   st,eth-clk-sel:
+    deprecated: true
     description:
       set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
     type: boolean
 
   st,eth-ref-clk-sel:
+    deprecated: true
     description:
       set this property in RMII mode when you have PHY without crystal 50MHz and want to
       select RCC clock instead of ETH_REF_CLK.
     type: boolean
 
+allOf:
+  - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp1-dwmac
+              - st,stm32-dwmac
+    then:
+      properties:
+        st,syscon:
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+          items:
+            - items:
+                - description: phandle to the syscon node which encompases the glue register
+                - description: offset of the control register
+          description:
+            Should be phandle/offset pair. The phandle to the syscon node which
+            encompases the glue register, and the offset of the control register
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp13-dwmac
+    then:
+      properties:
+        st,syscon:
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+          items:
+            - items:
+                - description: phandle to the syscon node which encompases the glue register
+                - description: offset of the control register
+                - description: field to set mask in register
+          description:
+            Should be phandle/offset pair. The phandle to the syscon node which
+            encompases the glue register, the offset of the control register and
+            the mask to set bitfield in control register
+
 required:
   - compatible
   - clocks
@@ -112,24 +156,36 @@ examples:
            compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
            reg = <0x5800a000 0x2000>;
            reg-names = "stmmaceth";
-           interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-           interrupt-names = "macirq";
+           interrupts-extended = <&intc GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+                                 <&exti 70 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "macirq",
+                             "eth_wake_irq";
            clock-names = "stmmaceth",
-                     "mac-clk-tx",
-                     "mac-clk-rx",
-                     "ethstp",
-                     "eth-ck";
+                         "mac-clk-tx",
+                         "mac-clk-rx",
+                         "eth-ck",
+                         "ptp_ref",
+                         "ethstp";
            clocks = <&rcc ETHMAC>,
-                <&rcc ETHTX>,
-                <&rcc ETHRX>,
-                <&rcc ETHSTP>,
-                <&rcc ETHCK_K>;
+                    <&rcc ETHTX>,
+                    <&rcc ETHRX>,
+                    <&rcc ETHCK_K>,
+                    <&rcc ETHPTP_K>,
+                    <&rcc ETHSTP>;
            st,syscon = <&syscfg 0x4>;
+           snps,mixed-burst;
            snps,pbl = <2>;
+           snps,en-tx-lpi-clockgating;
            snps,axi-config = <&stmmac_axi_config_0>;
            snps,tso;
            phy-mode = "rgmii";
-       };
+
+           stmmac_axi_config_0: stmmac-axi-config {
+                                snps,wr_osr_lmt = <0x7>;
+                                snps,rd_osr_lmt = <0x7>;
+                                snps,blen = <0 0 0 0 16 8 4>;
+           };
+     };
 
   - |
     //Example 2 (MCU example)
@@ -161,3 +217,43 @@ examples:
            snps,pbl = <8>;
            phy-mode = "mii";
        };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    #include <dt-bindings/mfd/stm32h7-rcc.h>
+    //Example 4
+     ethernet3: ethernet@5800a000 {
+           compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+           reg = <0x5800a000 0x2000>;
+           reg-names = "stmmaceth";
+           interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+                                 <&exti 68 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "macirq",
+                             "eth_wake_irq";
+           clock-names = "stmmaceth",
+                         "mac-clk-tx",
+                         "mac-clk-rx",
+                         "eth-ck",
+                         "ptp_ref",
+                         "ethstp";
+           clocks = <&rcc ETHMAC>,
+                    <&rcc ETHTX>,
+                    <&rcc ETHRX>,
+                    <&rcc ETHCK_K>,
+                    <&rcc ETHPTP_K>,
+                    <&rcc ETHSTP>;
+           st,syscon = <&syscfg 0x4 0xff0000>;
+           snps,mixed-burst;
+           snps,pbl = <2>;
+           snps,axi-config = <&stmmac_axi_config_1>;
+           snps,tso;
+           phy-mode = "rmii";
+
+           stmmac_axi_config_1: stmmac-axi-config {
+                                snps,wr_osr_lmt = <0x7>;
+                                snps,rd_osr_lmt = <0x7>;
+                                snps,blen = <0 0 0 0 16 8 4>;
+           };
+     };
-- 
2.25.1

