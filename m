Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D307536E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjGNJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjGNJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:45:09 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E811993;
        Fri, 14 Jul 2023 02:45:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E9ika7037564;
        Fri, 14 Jul 2023 04:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689327886;
        bh=smVydxMalxHgouncgyjQ283GOG2TDd6zuCo8jnW7iGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WNrV0XiEeheCJUDw1IuKnEXYgk7lu/EOL+BPfh8eZRhZbkO8Tgr1mj1mc0lDJUsdv
         tqNzYJofmZ3ZpREO2BWN2uurQ0/FM+dgw7opZtisVZqw9JVEbyiE7qBQlg0zjKIAG2
         nX+7QmPheOldNCLEeFl3TdoETGU0Ycv/JgrHz/BQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E9ikPd061516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 04:44:46 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 04:44:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 04:44:46 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E9ikRl026963;
        Fri, 14 Jul 2023 04:44:46 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 36E9ij3H005787;
        Fri, 14 Jul 2023 04:44:45 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 1/2] dt-bindings: net: Add ICSSG Ethernet
Date:   Fri, 14 Jul 2023 15:14:31 +0530
Message-ID: <20230714094432.1834489-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714094432.1834489-1-danishanwar@ti.com>
References: <20230714094432.1834489-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a YAML binding document for the ICSSG Programmable real time unit
based Ethernet hardware. The ICSSG driver uses the PRU and PRUSS consumer
APIs to interface the PRUs and load/run the firmware for supporting
ethernet functionality.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../bindings/net/ti,icssg-prueth.yaml         | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
new file mode 100644
index 000000000000..8ec30b3eb760
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ICSSG PRUSS Ethernet
+
+maintainers:
+  - Md Danish Anwar <danishanwar@ti.com>
+
+description:
+  Ethernet based on the Programmable Real-Time Unit and Industrial
+  Communication Subsystem.
+
+allOf:
+  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-icssg-prueth  # for AM65x SoC family
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to MSMC SRAM node
+
+  dmas:
+    maxItems: 10
+
+  dma-names:
+    items:
+      - const: tx0-0
+      - const: tx0-1
+      - const: tx0-2
+      - const: tx0-3
+      - const: tx1-0
+      - const: tx1-1
+      - const: tx1-2
+      - const: tx1-3
+      - const: rx0
+      - const: rx1
+
+  ti,mii-g-rt:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to MII_G_RT module's syscon regmap.
+
+  ti,mii-rt:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to MII_RT module's syscon regmap
+
+  interrupts:
+    maxItems: 2
+    description:
+      Interrupt specifiers to TX timestamp IRQ.
+
+  interrupt-names:
+    items:
+      - const: tx_ts0
+      - const: tx_ts1
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      ^port@[0-1]$:
+        type: object
+        description: ICSSG PRUETH external ports
+        $ref: ethernet-controller.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            items:
+              - enum: [0, 1]
+            description: ICSSG PRUETH port number
+
+          interrupts:
+            maxItems: 1
+
+          ti,syscon-rgmii-delay:
+            items:
+              - items:
+                  - description: phandle to system controller node
+                  - description: The offset to ICSSG control register
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              phandle to system controller node and register offset
+              to ICSSG control register for RGMII transmit delay
+
+        required:
+          - reg
+    anyOf:
+      - required:
+          - port@0
+      - required:
+          - port@1
+
+required:
+  - compatible
+  - sram
+  - dmas
+  - dma-names
+  - ethernet-ports
+  - ti,mii-g-rt
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* Example k3-am654 base board SR2.0, dual-emac */
+    pruss2_eth: ethernet {
+        compatible = "ti,am654-icssg-prueth";
+        pinctrl-names = "default";
+        pinctrl-0 = <&icssg2_rgmii_pins_default>;
+        sram = <&msmc_ram>;
+
+        ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
+                  <&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
+        firmware-name = "ti-pruss/am65x-pru0-prueth-fw.elf",
+                        "ti-pruss/am65x-rtu0-prueth-fw.elf",
+                        "ti-pruss/am65x-txpru0-prueth-fw.elf",
+                        "ti-pruss/am65x-pru1-prueth-fw.elf",
+                        "ti-pruss/am65x-rtu1-prueth-fw.elf",
+                        "ti-pruss/am65x-txpru1-prueth-fw.elf";
+        ti,pruss-gp-mux-sel = <2>,      /* MII mode */
+                              <2>,
+                              <2>,
+                              <2>,      /* MII mode */
+                              <2>,
+                              <2>;
+        dmas = <&main_udmap 0xc300>, /* egress slice 0 */
+               <&main_udmap 0xc301>, /* egress slice 0 */
+               <&main_udmap 0xc302>, /* egress slice 0 */
+               <&main_udmap 0xc303>, /* egress slice 0 */
+               <&main_udmap 0xc304>, /* egress slice 1 */
+               <&main_udmap 0xc305>, /* egress slice 1 */
+               <&main_udmap 0xc306>, /* egress slice 1 */
+               <&main_udmap 0xc307>, /* egress slice 1 */
+               <&main_udmap 0x4300>, /* ingress slice 0 */
+               <&main_udmap 0x4301>; /* ingress slice 1 */
+        dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+                    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+                    "rx0", "rx1";
+        ti,mii-g-rt = <&icssg2_mii_g_rt>;
+        interrupt-parent = <&icssg2_intc>;
+        interrupts = <24 0 2>, <25 1 3>;
+        interrupt-names = "tx_ts0", "tx_ts1";
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            pruss2_emac0: port@0 {
+                reg = <0>;
+                phy-handle = <&pruss2_eth0_phy>;
+                phy-mode = "rgmii-id";
+                interrupts-extended = <&icssg2_intc 24>;
+                ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
+                /* Filled in by bootloader */
+                local-mac-address = [00 00 00 00 00 00];
+            };
+
+            pruss2_emac1: port@1 {
+                reg = <1>;
+                phy-handle = <&pruss2_eth1_phy>;
+                phy-mode = "rgmii-id";
+                interrupts-extended = <&icssg2_intc 25>;
+                ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
+                /* Filled in by bootloader */
+                local-mac-address = [00 00 00 00 00 00];
+            };
+        };
+    };
-- 
2.34.1

