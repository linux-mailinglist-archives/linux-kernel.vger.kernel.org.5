Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497787EB6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjKNS4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjKNS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:56:45 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD8102;
        Tue, 14 Nov 2023 10:56:37 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AEIuRxD092020;
        Tue, 14 Nov 2023 12:56:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699988187;
        bh=miS453cW3mvsSG8TAJhbwZDNGAa9es8w1UdeNybZcz4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PSiANbGiGa6JKbE2GERiTRc5OC/osicGcIpmkEyk6jfNSdA24q64zs+fZo4JUCweJ
         TJhmuAeYxAnkMmlnoRv9yYvKNVKbpGd0dIxghfam7IfssdWwq9v3xEPjvliILajxv2
         wW9TgUAoYwPMyrMbwjdYsxs7bfKjMbLjHdpq6u4A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AEIuR6U039105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Nov 2023 12:56:27 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 12:56:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 12:56:27 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AEIuOAN088527;
        Tue, 14 Nov 2023 12:56:26 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 4/4] dt-bindings: dma: Convert ti-edma.txt to YAML
Date:   Tue, 14 Nov 2023 12:56:13 -0600
Message-ID: <20231114185613.322570-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114185613.322570-1-afd@ti.com>
References: <20231114185613.322570-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ti-edma.txt to ti/ti,edma3-tpcc.yaml and
ti/ti,edma3-tptc.yaml.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../devicetree/bindings/dma/ti-edma.txt       | 238 ------------------
 .../bindings/dma/ti/ti,edma3-tpcc.yaml        | 142 +++++++++++
 .../bindings/dma/ti/ti,edma3-tptc.yaml        |  63 +++++
 MAINTAINERS                                   |   1 -
 4 files changed, 205 insertions(+), 239 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
deleted file mode 100644
index f719e1612b0a5..0000000000000
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ /dev/null
@@ -1,238 +0,0 @@
-Texas Instruments eDMA
-
-The eDMA3 consists of two components: Channel controller (CC) and Transfer
-Controller(s) (TC). The CC is the main entry for DMA users since it is
-responsible for the DMA channel handling, while the TCs are responsible to
-execute the actual DMA tansfer.
-
-------------------------------------------------------------------------------
-eDMA3 Channel Controller
-
-Required properties:
---------------------
-- compatible:	Should be:
-		- "ti,edma3-tpcc" for the channel controller(s) on OMAP,
-		  AM33xx and AM43xx SoCs.
-		- "ti,k2g-edma3-tpcc", "ti,edma3-tpcc" for the
-		  channel controller(s) on 66AK2G.
-- #dma-cells:	Should be set to <2>. The first number is the DMA request
-		number and the second is the TC the channel is serviced on.
-- reg:		Memory map of eDMA CC
-- reg-names:	"edma3_cc"
-- interrupts:	Interrupt lines for CCINT, MPERR and CCERRINT.
-- interrupt-names: "edma3_ccint", "edma3_mperr" and "edma3_ccerrint"
-- ti,tptcs:	List of TPTCs associated with the eDMA in the following form:
-		<&tptc_phandle TC_priority_number>. The highest priority is 0.
-
-SoC-specific Required properties:
---------------------------------
-The following are mandatory properties for OMAP, AM33xx and AM43xx SoCs only:
-- ti,hwmods:	Name of the hwmods associated to the eDMA CC.
-
-The following are mandatory properties for 66AK2G SoCs only:
-- power-domains:Should contain a phandle to a PM domain provider node
-		and an args specifier containing the device id
-		value. This property is as per the binding,
-		Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
-
-Optional properties:
--------------------
-- ti,edma-memcpy-channels: List of channels allocated to be used for memcpy, iow
-		these channels will be SW triggered channels. See example.
-- ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
-		the driver, they are allocated to be used by for example the
-		DSP. See example.
-- dma-channel-mask: Mask of usable channels.
-		Single uint32 for EDMA with 32 channels, array of two uint32 for
-		EDMA with 64 channels. See example and
-		Documentation/devicetree/bindings/dma/dma-common.yaml
-
-
-------------------------------------------------------------------------------
-eDMA3 Transfer Controller
-
-Required properties:
---------------------
-- compatible:	Should be:
-		- "ti,edma3-tptc" for the transfer controller(s) on OMAP,
-		  AM33xx and AM43xx SoCs.
-		- "ti,k2g-edma3-tptc", "ti,edma3-tptc" for the
-		  transfer controller(s) on 66AK2G.
-- reg:		Memory map of eDMA TC
-- interrupts:	Interrupt number for TCerrint.
-
-SoC-specific Required properties:
---------------------------------
-The following are mandatory properties for OMAP, AM33xx and AM43xx SoCs only:
-- ti,hwmods:	Name of the hwmods associated to the eDMA TC.
-
-The following are mandatory properties for 66AK2G SoCs only:
-- power-domains:Should contain a phandle to a PM domain provider node
-		and an args specifier containing the device id
-		value. This property is as per the binding,
-		Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
-
-Optional properties:
--------------------
-- interrupt-names: "edma3_tcerrint"
-
-------------------------------------------------------------------------------
-Examples:
-
-1.
-edma: edma@49000000 {
-	compatible = "ti,edma3-tpcc";
-	ti,hwmods = "tpcc";
-	reg =	<0x49000000 0x10000>;
-	reg-names = "edma3_cc";
-	interrupts = <12 13 14>;
-	interrupt-names = "edma3_ccint", "edma3_mperr", "edma3_ccerrint";
-	dma-requests = <64>;
-	#dma-cells = <2>;
-
-	ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 7>, <&edma_tptc2 0>;
-
-	/* Channel 20 and 21 is allocated for memcpy */
-	ti,edma-memcpy-channels = <20 21>;
-	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
-	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
-	/* The following channels are reserved: 35-44 */
-	dma-channel-mask = <0xffffffff /* Channel 0-31 */
-			    0xffffe007>; /* Channel 32-63 */
-};
-
-edma_tptc0: tptc@49800000 {
-	compatible = "ti,edma3-tptc";
-	ti,hwmods = "tptc0";
-	reg =	<0x49800000 0x100000>;
-	interrupts = <112>;
-	interrupt-names = "edm3_tcerrint";
-};
-
-edma_tptc1: tptc@49900000 {
-	compatible = "ti,edma3-tptc";
-	ti,hwmods = "tptc1";
-	reg =	<0x49900000 0x100000>;
-	interrupts = <113>;
-	interrupt-names = "edm3_tcerrint";
-};
-
-edma_tptc2: tptc@49a00000 {
-	compatible = "ti,edma3-tptc";
-	ti,hwmods = "tptc2";
-	reg =	<0x49a00000 0x100000>;
-	interrupts = <114>;
-	interrupt-names = "edm3_tcerrint";
-};
-
-sham: sham@53100000 {
-	compatible = "ti,omap4-sham";
-	ti,hwmods = "sham";
-	reg = <0x53100000 0x200>;
-	interrupts = <109>;
-	/* DMA channel 36 executed on eDMA TC0 - low priority queue */
-	dmas = <&edma 36 0>;
-	dma-names = "rx";
-};
-
-mcasp0: mcasp@48038000 {
-	compatible = "ti,am33xx-mcasp-audio";
-	ti,hwmods = "mcasp0";
-	reg = <0x48038000 0x2000>,
-		<0x46000000 0x400000>;
-	reg-names = "mpu", "dat";
-	interrupts = <80>, <81>;
-	interrupt-names = "tx", "rx";
-	/* DMA channels 8 and 9 executed on eDMA TC2 - high priority queue */
-	dmas = <&edma 8 2>,
-	       <&edma 9 2>;
-	dma-names = "tx", "rx";
-};
-
-2.
-edma1: edma@2728000 {
-	compatible = "ti,k2g-edma3-tpcc", "ti,edma3-tpcc";
-	reg =	<0x02728000 0x8000>;
-	reg-names = "edma3_cc";
-	interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
-			<GIC_SPI 219 IRQ_TYPE_EDGE_RISING>,
-			<GIC_SPI 220 IRQ_TYPE_EDGE_RISING>;
-	interrupt-names = "edma3_ccint", "emda3_mperr",
-			  "edma3_ccerrint";
-	dma-requests = <64>;
-	#dma-cells = <2>;
-
-	ti,tptcs = <&edma1_tptc0 7>, <&edma1_tptc1 0>;
-
-	/*
-	 * memcpy is disabled, can be enabled with:
-	 * ti,edma-memcpy-channels = <12 13 14 15>;
-	 * for example.
-	 */
-
-	power-domains = <&k2g_pds 0x4f>;
-};
-
-edma1_tptc0: tptc@27b0000 {
-	compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
-	reg =	<0x027b0000 0x400>;
-	power-domains = <&k2g_pds 0x4f>;
-};
-
-edma1_tptc1: tptc@27b8000 {
-	compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
-	reg =	<0x027b8000 0x400>;
-	power-domains = <&k2g_pds 0x4f>;
-};
-
-mmc0: mmc@23000000 {
-	compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
-	reg = <0x23000000 0x400>;
-	interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
-	dmas = <&edma1 24 0>, <&edma1 25 0>;
-	dma-names = "tx", "rx";
-	bus-width = <4>;
-	ti,needs-special-reset;
-	no-1-8-v;
-	max-frequency = <96000000>;
-	power-domains = <&k2g_pds 0xb>;
-	clocks = <&k2g_clks 0xb 1>, <&k2g_clks 0xb 2>;
-	clock-names = "fck", "mmchsdb_fck";
-};
-
-------------------------------------------------------------------------------
-DEPRECATED binding, new DTS files must use the ti,edma3-tpcc/ti,edma3-tptc
-binding.
-
-Required properties:
-- compatible : "ti,edma3"
-- #dma-cells: Should be set to <1>
-              Clients should use a single channel number per DMA request.
-- reg: Memory map for accessing module
-- interrupts: Exactly 3 interrupts need to be specified in the order:
-              1. Transfer completion interrupt.
-              2. Memory protection interrupt.
-              3. Error interrupt.
-Optional properties:
-- ti,hwmods: Name of the hwmods associated to the EDMA
-- ti,edma-xbar-event-map: Crossbar event to channel map
-
-Deprecated properties:
-Listed here in case one wants to boot an old kernel with new DTB. These
-properties might need to be added to the new DTS files.
-- ti,edma-regions: Number of regions
-- ti,edma-slots: Number of slots
-- dma-channels: Specify total DMA channels per CC
-
-Example:
-
-edma: edma@49000000 {
-	reg = <0x49000000 0x10000>;
-	interrupt-parent = <&intc>;
-	interrupts = <12 13 14>;
-	compatible = "ti,edma3";
-	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
-	#dma-cells = <1>;
-	ti,edma-xbar-event-map = /bits/ 16 <1 12
-					    2 13>;
-};
diff --git a/Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.yaml b/Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.yaml
new file mode 100644
index 0000000000000..6c14b3367dd8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,edma3-tpcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments eDMA3 Channel Controller
+
+description: |
+  The eDMA3 consists of two components, Channel controller (CC) and Transfer
+  Controller(s) (TC). The CC is the main entry for DMA users since it is
+  responsible for the DMA channel handling, while the TCs are responsible to
+  execute the actual DMA tansfer. This documents the Channel Controller.
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,edma3-tpcc # OMAP, AM33xx, and AM43xx
+      - items:
+          - const: ti,k2g-edma3-tpcc # 66AK2G
+          - const: ti,edma3-tpcc
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: edma3_cc
+
+  interrupts:
+    items:
+      - description: CCINT Interrupt
+      - description: MPERR Interrupt
+      - description: CCERRINT Interrupt
+
+  interrupt-names:
+    items:
+      - const: edma3_ccint
+      - const: edma3_mperr
+      - const: edma3_ccerrint
+
+  "#dma-cells":
+    const: 2
+    description: |
+      The first cell is the DMA request number.
+      The second cell is the TC the channel is serviced on.
+
+  ti,tptcs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of TPTCs associated with the eDMA in the following form,
+      <&tptc_phandle TC_priority_number>. The highest priority is 0.
+
+  power-domains:
+    maxItems: 1
+
+  ti,edma-memcpy-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      List of channels allocated to be used for memcpy, iow
+      these channels will be SW triggered channels.
+
+  ti,edma-reserved-slot-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      PaRAM slot ranges which should not be used by the driver,
+      they are allocated to be used by for example the DSP.
+
+  dma-channel-mask:
+    description: |
+      Mask of usable channels. Single uint32 for EDMA with 32 channels,
+      array of two uint32 for EDMA with 64 channels.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - "#dma-cells"
+  - ti,tptcs
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ti,k2g-edma3-tptc
+then:
+  required:
+    - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-controller@49000000 {
+        compatible = "ti,edma3-tpcc";
+        reg = <0x49000000 0x10000>;
+        reg-names = "edma3_cc";
+        interrupts = <12 13 14>;
+        interrupt-names = "edma3_ccint", "edma3_mperr", "edma3_ccerrint";
+        dma-requests = <64>;
+        #dma-cells = <2>;
+
+        ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 7>, <&edma_tptc2 0>;
+
+        /* Channel 20 and 21 is allocated for memcpy */
+        ti,edma-memcpy-channels = <20 21>;
+        /* The following PaRAM slots are reserved: 35-44 and 100-109 */
+        ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
+        /* The following channels are reserved: 35-44 */
+        dma-channel-mask = <0xffffffff /* Channel 0-31 */
+                            0xffffe007>; /* Channel 32-63 */
+    };
+
+    sham@53100000 {
+        compatible = "ti,omap4-sham";
+        reg = <0x53100000 0x200>;
+        interrupts = <109>;
+        /* DMA channel 36 executed on eDMA TC0 - low priority queue */
+        dmas = <&edma 36 0>;
+        dma-names = "rx";
+    };
+
+    mcasp@48038000 {
+        compatible = "ti,am33xx-mcasp-audio";
+        reg = <0x48038000 0x2000>,
+              <0x46000000 0x400000>;
+        reg-names = "mpu", "dat";
+        interrupts = <80>, <81>;
+        interrupt-names = "tx", "rx";
+        /* DMA channels 8 and 9 executed on eDMA TC2 - high priority queue */
+        dmas = <&edma 8 2>,
+               <&edma 9 2>;
+        dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.yaml b/Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.yaml
new file mode 100644
index 0000000000000..b73db3283f577
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,edma3-tptc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments eDMA3 Transfer Controller
+
+description: |
+  The eDMA3 consists of two components, Channel controller (CC) and Transfer
+  Controller(s) (TC). The CC is the main entry for DMA users since it is
+  responsible for the DMA channel handling, while the TCs are responsible to
+  execute the actual DMA tansfer. This documents the Transfer Controller.
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,edma3-tptc # OMAP, AM33xx, and AM43xx
+      - items:
+          - const: ti,k2g-edma3-tptc # 66AK2G
+          - const: ti,edma3-tptc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt number for TCerrint
+    maxItems: 1
+
+  interrupt-names:
+    const: edma3_tcerrint
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ti,k2g-edma3-tptc
+then:
+  required:
+    - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    tptc@49800000 {
+        compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
+        reg = <0x49800000 0x100000>;
+        interrupts = <112>;
+        interrupt-names = "edm3_tcerrint";
+        power-domains = <&k2g_pds 0xb>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cfd..b19cfac762b42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21515,7 +21515,6 @@ M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
-F:	Documentation/devicetree/bindings/dma/ti-edma.txt
 F:	Documentation/devicetree/bindings/dma/ti/
 F:	drivers/dma/ti/
 F:	include/linux/dma/k3-psil.h
-- 
2.39.2

