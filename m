Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172FB7D331B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjJWL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjJWL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:26:47 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A76D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:26:44 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:375d:2b56:c03f:d72d])
        by xavier.telenet-ops.be with bizsmtp
        id 1PSb2B00A3CbNjd01PSbRR; Mon, 23 Oct 2023 13:26:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qut4m-007K8B-8v;
        Mon, 23 Oct 2023 13:26:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1quqre-005cBC-NP;
        Mon, 23 Oct 2023 11:04:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: regulator: dlg,da9210: Convert to json-schema
Date:   Mon, 23 Oct 2023 11:04:45 +0200
Message-Id: <bfd1cf9d620a8229f5a5e62e6fe9e59c153d0830.1698051619.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Dialog Semiconductor DA9210 Multi-Phase 12A DC-DC Buck
Converter Device Tree binding documentation to json-schema.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/regulator/da9210.txt  | 29 -----------
 .../bindings/regulator/dlg,da9210.yaml        | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/da9210.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9210.yaml

diff --git a/Documentation/devicetree/bindings/regulator/da9210.txt b/Documentation/devicetree/bindings/regulator/da9210.txt
deleted file mode 100644
index 58065ca9e3b46892..0000000000000000
--- a/Documentation/devicetree/bindings/regulator/da9210.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Dialog Semiconductor DA9210 Multi-phase 12A DCDC BUCK Converter
-
-Required properties:
-
-- compatible:	must be "dlg,da9210"
-- reg:		the i2c slave address of the regulator. It should be 0x68.
-
-Optional properties:
-
-- interrupts:	a reference to the DA9210 interrupt, if available.
-
-Any standard regulator properties can be used to configure the single da9210
-DCDC.
-
-Example:
-
-	da9210@68 {
-		compatible = "dlg,da9210";
-		reg = <0x68>;
-
-		interrupt-parent = <...>;
-		interrupts = <...>;
-
-		regulator-min-microvolt = <300000>;
-		regulator-max-microvolt = <1570000>;
-		regulator-min-microamp = <1600000>;
-		regulator-max-microamp = <4600000>;
-		regulator-boot-on;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9210.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9210.yaml
new file mode 100644
index 0000000000000000..81f23de36de4c2f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9210.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/dlg,da9210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9210 Multi-Phase 12A DC-DC Buck Converter
+
+maintainers:
+  - Support Opensource <support.opensource@diasemi.com>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: dlg,da9210
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@68 {
+            compatible = "dlg,da9210";
+            reg = <0x68>;
+
+            interrupt-parent = <&irqc0>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1570000>;
+            regulator-min-microamp = <1600000>;
+            regulator-max-microamp = <4600000>;
+            regulator-boot-on;
+        };
+    };
-- 
2.34.1

