Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6F7C95E4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjJNSUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjJNSUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:20:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1638D7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:20:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so5413440a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697307607; x=1697912407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEd5JAdwoWbnbfWI9ZMh38QiojqTPoc3XzE3CzLAESk=;
        b=Pkoesfa3oxocrnKIcD7NlCZeVDIeGvEj2o3YPpQc8WBXloJUyjSrtVQ70XrYaNPr7h
         pHKakbHIZTp4brjS5AWwagB1I9faFr8YobUqtK76s0cQcnlE/nbYrnzJy/W7ZuYYujgl
         F26Eoz7gMckrNaezvG3D2DIPlEUdIziLMStfOS3x2SvMpFn6NFhn37Msh3JnsNUIipxW
         g2nbTmeecAfHbnQ1JwnOHuH5l+xVChDzzDbQESRffuNrOcX4MZfzHh/b2U9JTOiRF7ab
         B1hj0mILgFNWAL1SlsZCBKPVA4HwbGAZOGae96bdqhQrm4uyQemTSMGG5q37t8s2VVJr
         Cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307607; x=1697912407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEd5JAdwoWbnbfWI9ZMh38QiojqTPoc3XzE3CzLAESk=;
        b=YzNa6J36dWEqHZhkExsZmyRI1nJveB9OD8yziFF/VcIuuA7cBW82+NWRYD5egxKJde
         F3TnxVRLy31HrIZHzeCrLJze8yptVLR/pnFO8OPyIpKP6/PmWT/SG84DNh25R4xcFfQM
         FrSiI/FEoCgNsIkNapTbTmeeSHKF2Cagl5A9NwTdRmUz3lBWwGHzdEF7TgzWVmVfVw2r
         cDRYCQMV3lC7EqDGooq4wsEzVfomPZGWdbOopywjDZxzkYbP++QVm1sliJoIIP2l/fVT
         Pod4b5obK2UDtaHz3skt38OtKOiT1suj9ApB0Xadlg+HP7kagTf4ow53p3y/OPQLsv+b
         9Gmw==
X-Gm-Message-State: AOJu0Yzhb/SSSOs99pLcAuwbbQfM8RpEEsVqtO8sG1mvVU1gkBz4qBxL
        OyUcCGlgC3qbWj95UEskbDV6/A==
X-Google-Smtp-Source: AGHT+IEujxdLwjOGEeCP+hd5rDiO7RVHUPnxwhLULr9ow3mkBt1dt/Jl0pGIKYSuS4vGMmeHZRlzyQ==
X-Received: by 2002:a50:8e58:0:b0:53e:327c:7bbc with SMTP id 24-20020a508e58000000b0053e327c7bbcmr5084053edx.16.1697307606993;
        Sat, 14 Oct 2023 11:20:06 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b005231e3d89efsm13032574edx.31.2023.10.14.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 11:20:06 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Sat, 14 Oct 2023 20:19:41 +0200
Subject: [PATCH v4 1/3] dt-bindings: clock: si5351: convert to yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231014-alvin-clk-si5351-no-pll-reset-v4-1-a3567024007d@bang-olufsen.dk>
References: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
In-Reply-To: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The following additional properties are described:

  - clock-names
  - clock-frequency of the clkout child nodes

In order to suppress warnings from the DT schema validator, the clkout
child nodes are prescribed names clkout@[0-7] rather than clkout[0-7].

The example is refined as follows:

  - correct the usage of property pll-master -> silabs,pll-master
  - give an example of how the silabs,pll-reset property can be used

I made myself maintainer of the file as I cannot presume that anybody
else wants the responsibility.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../devicetree/bindings/clock/silabs,si5351.txt    | 126 -----------
 .../devicetree/bindings/clock/silabs,si5351.yaml   | 245 +++++++++++++++++++++
 2 files changed, 245 insertions(+), 126 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.txt b/Documentation/devicetree/bindings/clock/silabs,si5351.txt
deleted file mode 100644
index bfda6af76bee..000000000000
--- a/Documentation/devicetree/bindings/clock/silabs,si5351.txt
+++ /dev/null
@@ -1,126 +0,0 @@
-Binding for Silicon Labs Si5351a/b/c programmable i2c clock generator.
-
-Reference
-[1] Si5351A/B/C Data Sheet
-    https://www.skyworksinc.com/-/media/Skyworks/SL/documents/public/data-sheets/Si5351-B.pdf
-
-The Si5351a/b/c are programmable i2c clock generators with up to 8 output
-clocks. Si5351a also has a reduced pin-count package (MSOP10) where only
-3 output clocks are accessible. The internal structure of the clock
-generators can be found in [1].
-
-==I2C device node==
-
-Required properties:
-- compatible: shall be one of the following:
-	"silabs,si5351a" - Si5351a, QFN20 package
-	"silabs,si5351a-msop" - Si5351a, MSOP10 package
-	"silabs,si5351b" - Si5351b, QFN20 package
-	"silabs,si5351c" - Si5351c, QFN20 package
-- reg: i2c device address, shall be 0x60 or 0x61.
-- #clock-cells: from common clock binding; shall be set to 1.
-- clocks: from common clock binding; list of parent clock
-  handles, shall be xtal reference clock or xtal and clkin for
-  si5351c only. Corresponding clock input names are "xtal" and
-  "clkin" respectively.
-- #address-cells: shall be set to 1.
-- #size-cells: shall be set to 0.
-
-Optional properties:
-- silabs,pll-source: pair of (number, source) for each pll. Allows
-  to overwrite clock source of pll A (number=0) or B (number=1).
-
-==Child nodes==
-
-Each of the clock outputs can be overwritten individually by
-using a child node to the I2C device node. If a child node for a clock
-output is not set, the eeprom configuration is not overwritten.
-
-Required child node properties:
-- reg: number of clock output.
-
-Optional child node properties:
-- silabs,clock-source: source clock of the output divider stage N, shall be
-  0 = multisynth N
-  1 = multisynth 0 for output clocks 0-3, else multisynth4
-  2 = xtal
-  3 = clkin (si5351c only)
-- silabs,drive-strength: output drive strength in mA, shall be one of {2,4,6,8}.
-- silabs,multisynth-source: source pll A(0) or B(1) of corresponding multisynth
-  divider.
-- silabs,pll-master: boolean, multisynth can change pll frequency.
-- silabs,pll-reset: boolean, clock output can reset its pll.
-- silabs,disable-state : clock output disable state, shall be
-  0 = clock output is driven LOW when disabled
-  1 = clock output is driven HIGH when disabled
-  2 = clock output is FLOATING (HIGH-Z) when disabled
-  3 = clock output is NEVER disabled
-
-==Example==
-
-/* 25MHz reference crystal */
-ref25: ref25M {
-	compatible = "fixed-clock";
-	#clock-cells = <0>;
-	clock-frequency = <25000000>;
-};
-
-i2c-master-node {
-
-	/* Si5351a msop10 i2c clock generator */
-	si5351a: clock-generator@60 {
-		compatible = "silabs,si5351a-msop";
-		reg = <0x60>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#clock-cells = <1>;
-
-		/* connect xtal input to 25MHz reference */
-		clocks = <&ref25>;
-		clock-names = "xtal";
-
-		/* connect xtal input as source of pll0 and pll1 */
-		silabs,pll-source = <0 0>, <1 0>;
-
-		/*
-		 * overwrite clkout0 configuration with:
-		 * - 8mA output drive strength
-		 * - pll0 as clock source of multisynth0
-		 * - multisynth0 as clock source of output divider
-		 * - multisynth0 can change pll0
-		 * - set initial clock frequency of 74.25MHz
-		 */
-		clkout0 {
-			reg = <0>;
-			silabs,drive-strength = <8>;
-			silabs,multisynth-source = <0>;
-			silabs,clock-source = <0>;
-			silabs,pll-master;
-			clock-frequency = <74250000>;
-		};
-
-		/*
-		 * overwrite clkout1 configuration with:
-		 * - 4mA output drive strength
-		 * - pll1 as clock source of multisynth1
-		 * - multisynth1 as clock source of output divider
-		 * - multisynth1 can change pll1
-		 */
-		clkout1 {
-			reg = <1>;
-			silabs,drive-strength = <4>;
-			silabs,multisynth-source = <1>;
-			silabs,clock-source = <0>;
-			pll-master;
-		};
-
-		/*
-		 * overwrite clkout2 configuration with:
-		 * - xtal as clock source of output divider
-		 */
-		clkout2 {
-			reg = <2>;
-			silabs,clock-source = <2>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
new file mode 100644
index 000000000000..16d1142c4a2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
@@ -0,0 +1,245 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/silabs,si5351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Labs Si5351A/B/C programmable I2C clock generators
+
+description: |
+  The Silicon Labs Si5351A/B/C are programmable I2C clock generators with up to
+  8 outputs. Si5351A also has a reduced pin-count package (10-MSOP) where only 3
+  output clocks are accessible. The internal structure of the clock generators
+  can be found in [1].
+
+  [1] Si5351A/B/C Data Sheet
+      https://www.skyworksinc.com/-/media/Skyworks/SL/documents/public/data-sheets/Si5351-B.pdf
+
+maintainers:
+  - Alvin Šipraga <alsi@bang-olufsen.dk>
+
+properties:
+  compatible:
+    enum:
+      - silabs,si5351a      # Si5351A, 20-QFN package
+      - silabs,si5351a-msop # Si5351A, 10-MSOP package
+      - silabs,si5351b      # Si5351B, 20-QFN package
+      - silabs,si5351c      # Si5351C, 20-QFN package
+
+  reg:
+    enum:
+      - 0x60
+      - 0x61
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#clock-cells":
+    const: 1
+
+  clocks: true
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: xtal
+      - const: clkin
+
+  silabs,pll-source:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      A list of cell pairs containing a PLL index and its source. Allows to
+      overwrite clock source of the internal PLLs.
+    items:
+      items:
+        - description: PLL A (0) or PLL B (1)
+          enum: [ 0, 1 ]
+        - description: PLL source, XTAL (0) or CLKIN (1, Si5351C only).
+          enum: [ 0, 1 ]
+
+patternProperties:
+  "^clkout@[0-7]$":
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        description: Clock output number.
+
+      clock-frequency: true
+
+      silabs,clock-source:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Source clock of the this output's divider stage.
+
+          0 - use multisynth N for this output, where N is the output number
+          1 - use either multisynth 0 (if output number is 0-3) or multisynth 4
+              (otherwise) for this output
+          2 - use XTAL for this output
+          3 - use CLKIN for this output (Si5351C only)
+
+      silabs,drive-strength:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 2, 4, 6, 8 ]
+        description: Output drive strength in mA.
+
+      silabs,multisynth-source:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1 ]
+        description:
+          Source PLL A (0) or B (1) for the corresponding multisynth divider.
+
+      silabs,pll-master:
+        type: boolean
+        description: |
+          The frequency of the source PLL is allowed to be changed by the
+          multisynth when setting the rate of this clock output.
+
+      silabs,pll-reset:
+        type: boolean
+        description: Reset the source PLL when enabling this clock output.
+
+      silabs,disable-state:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2, 3 ]
+        description: |
+          Clock output disable state. The state can be one of:
+
+          0 - clock output is driven LOW when disabled
+          1 - clock output is driven HIGH when disabled
+          2 - clock output is FLOATING (HIGH-Z) when disabled
+          3 - clock output is never disabled
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: silabs,si5351a-msop
+        then:
+          properties:
+            reg:
+              maximum: 2
+        else:
+          properties:
+            reg:
+              maximum: 7
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: silabs,si5351c
+        then:
+          properties:
+            silabs,clock-source:
+              enum: [ 0, 1, 2, 3 ]
+        else:
+          properties:
+            silabs,clock-source:
+              enum: [ 0, 1, 2 ]
+
+    required:
+      - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - silabs,si5351a
+              - silabs,si5351a-msop
+              - silabs,si5351b
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
+required:
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      clock-generator@60 {
+        compatible = "silabs,si5351a-msop";
+        reg = <0x60>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #clock-cells = <1>;
+
+        /* Connect XTAL input to 25MHz reference */
+        clocks = <&ref25>;
+        clock-names = "xtal";
+
+        /* Use XTAL input as source of PLL0 and PLL1 */
+        silabs,pll-source = <0 0>, <1 0>;
+
+        /*
+         * Overwrite CLK0 configuration with:
+         * - 8 mA output drive strength
+         * - PLL0 as clock source of multisynth 0
+         * - Multisynth 0 as clock source of output divider
+         * - Multisynth 0 can change PLL0
+         * - Set initial clock frequency of 74.25MHz
+         */
+        clkout@0 {
+          reg = <0>;
+          silabs,drive-strength = <8>;
+          silabs,multisynth-source = <0>;
+          silabs,clock-source = <0>;
+          silabs,pll-master;
+          clock-frequency = <74250000>;
+        };
+
+        /*
+         * Overwrite CLK1 configuration with:
+         * - 4 mA output drive strength
+         * - PLL1 as clock source of multisynth 1
+         * - Multisynth 1 as clock source of output divider
+         * - Multisynth 1 can change PLL1
+         * - Reset PLL1 when enabling this clock output
+         */
+        clkout@1 {
+          reg = <1>;
+          silabs,drive-strength = <4>;
+          silabs,multisynth-source = <1>;
+          silabs,clock-source = <0>;
+          silabs,pll-master;
+          silabs,pll-reset;
+        };
+
+        /*
+         * Overwrite CLK2 configuration with:
+         * - XTAL as clock source of output divider
+         */
+        clkout@2 {
+          reg = <2>;
+          silabs,clock-source = <2>;
+        };
+      };
+    };

-- 
2.42.0

