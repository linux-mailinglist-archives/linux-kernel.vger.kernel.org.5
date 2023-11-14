Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EB7EB8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjKNV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjKNV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:29:28 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53F9D;
        Tue, 14 Nov 2023 13:29:23 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AELTIEg075117;
        Tue, 14 Nov 2023 15:29:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699997358;
        bh=qlJleWEtN0/MdcN3nmgasTh8mkJEXMI2ZAg8qTNFdQA=;
        h=From:To:CC:Subject:Date;
        b=TcPyRMGLJt+jYAgsd+OdQbmMQayRfUv82rzBRkRz13hd+DmbzWzHogIv/dNeNrWCC
         zEzYvQYxKUWytcqYeyrh7velTfvk/x2+V/Szskk9uDLQYV8Nvv7QuzjyJxdbT+FLN6
         R0w+9lZnHgx1+Bnt7695nIrnD8fnsBH/O7A8vVQM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AELTIZx010609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Nov 2023 15:29:18 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 15:29:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 15:29:18 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AELTIwn088933;
        Tue, 14 Nov 2023 15:29:18 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/4] dt-bindings: spi: Convert spi-davinci.txt to YAML
Date:   Tue, 14 Nov 2023 15:29:08 -0600
Message-ID: <20231114212911.429951-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert spi-davinci.txt to ti,dm6441-spi.yaml.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Fix typo s/dm6446/dm6441

 .../devicetree/bindings/spi/spi-davinci.txt   | 100 ------------------
 .../bindings/spi/ti,dm6441-spi.yaml           |  76 +++++++++++++
 2 files changed, 76 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
 create mode 100644 Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
deleted file mode 100644
index f012888656eca..0000000000000
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-Davinci SPI controller device bindings
-
-Links on DM:
-Keystone 2 - https://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf
-dm644x - https://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
-OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
-
-Required properties:
-- #address-cells: number of cells required to define a chip select
-	address on the SPI bus. Should be set to 1.
-- #size-cells: should be zero.
-- compatible:
-	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
-	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
-	- "ti,keystone-spi" for SPI used similar to that on Keystone2 SoC
-		family
-- reg: Offset and length of SPI controller register space
-- num-cs: Number of chip selects. This includes internal as well as
-	GPIO chip selects.
-- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
-	IP to the interrupt controller within the SoC. Possible values
-	are 0 and 1. Manual says one of the two possible interrupt
-	lines can be tied to the interrupt controller. Set this
-	based on a specific SoC configuration.
-- interrupts: interrupt number mapped to CPU.
-- clocks: spi clk phandle
-          For 66AK2G this property should be set per binding,
-          Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
-
-SoC-specific Required Properties:
-
-The following are mandatory properties for Keystone 2 66AK2G SoCs only:
-
-- power-domains:	Should contain a phandle to a PM domain provider node
-			and an args specifier containing the SPI device id
-			value. This property is as per the binding,
-
-Optional:
-- cs-gpios: gpio chip selects
-	For example to have 3 internal CS and 2 GPIO CS, user could define
-	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
-	where first three are internal CS and last two are GPIO CS.
-
-Optional properties for slave devices:
-SPI slave nodes can contain the following properties.
-Not all SPI Peripherals from Texas Instruments support this.
-Please check SPI peripheral documentation for a device before using these.
-
-- ti,spi-wdelay : delay between transmission of words
-	(SPIFMTn.WDELAY, SPIDAT1.WDEL) must be specified in number of SPI module
-	clock periods.
-
-	delay = WDELAY * SPI_module_clock_period + 2 * SPI_module_clock_period
-
-Below is timing diagram which shows functional meaning of
-"ti,spi-wdelay" parameter.
-
-             +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
-SPI_CLK      | | | | | | | | | |                           | | | | | |
-  +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-
-
-SPI_SOMI/SIMO+-----------------+                           +-----------
-  +----------+ word1           +---------------------------+word2
-             +-----------------+                           +-----------
-                                          WDELAY
-                                <-------------------------->
-
-Example of a NOR flash slave device (n25q032) connected to DaVinci
-SPI controller device over the SPI bus.
-
-spi0:spi@20bf0000 {
-	#address-cells			= <1>;
-	#size-cells			= <0>;
-	compatible			= "ti,dm6446-spi";
-	reg				= <0x20BF0000 0x1000>;
-	num-cs				= <4>;
-	ti,davinci-spi-intr-line	= <0>;
-	interrupts			= <338>;
-	clocks				= <&clkspi>;
-
-	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "st,m25p32";
-		spi-max-frequency = <25000000>;
-		reg = <0>;
-		ti,spi-wdelay = <8>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "test";
-			reg = <0x80000 0x380000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml b/Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml
new file mode 100644
index 0000000000000..a71e51fb87e4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ti,dm6441-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Davinci SPI Controller
+
+description:
+  SPI controllers on TI Davinci, OMAP-L138, and Keystone2 SoCs.
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,dm6441-spi # for SPI used on DM644x SoC family
+          - ti,da830-spi # for SPI used on DA8xx SoC family
+          - ti,keystone-spi # for SPI used on Keystone2 SoC family
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ti,davinci-spi-intr-line:
+    description:
+      Interrupt line used to connect the SPI IP to the interrupt controller
+        within the SoC. Possible values are 0 and 1. Manual says one of the
+        two possible interrupt lines can be tied to the interrupt controller.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@20bf0000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "ti,dm6441-spi";
+        reg = <0x20bf0000 0x1000>;
+        interrupts = <338>;
+        clocks = <&clkspi>;
+
+        num-cs = <4>;
+        ti,davinci-spi-intr-line = <0>;
+
+        flash@0 {
+            compatible = "st,m25p32";
+            spi-max-frequency = <50000000>;
+            reg = <0>;
+            ti,spi-wdelay = <8>;
+        };
+    };
-- 
2.39.2

