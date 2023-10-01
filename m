Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE667B4784
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjJANGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjJANGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:06:15 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C19AC;
        Sun,  1 Oct 2023 06:06:10 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 1B139836AB;
        Sun,  1 Oct 2023 15:06:08 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sun, 01 Oct 2023 15:05:43 +0200
Subject: [PATCH] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr>
X-B4-Tracking: v=1; b=H4sIAKZuGWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwND3YKKRENLIwvd0uIk3crE3BxdCwNLUzMTAwsjIxNDJaC2gqLUtMw
 KsJHRsbW1AK6be61iAAAA
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3570;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=I+pbp2+i8AspnSOzhEB7DM4scts9Z1G4HFcpQJwppxo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlGW66YEEOs7V4Nt7C6695WePETUl6I4sGxSPXM
 TO4kVoEI3yJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRluugAKCRCaEZ6wQi2W
 4fqPD/9CPGtH4kaj0opR4bH3hGO8NuQZ8lAdbJ5MGteS7xF63/cx2bfpGHEWvZOKTOAU16ktE25
 fRuxELhRXSbKiilPyVJVZtgxXMcWVSVNQSbZuO7CTgmoCLRzTEC+HwcZPKPrRb2fNn2/fmGjfoB
 iA5c1wM8VOFXLoCRQ7HaqZmXIYiMydKuB2a0fUXWhlHCs5jRQ3BqzGFST7QNvza04e5IlSAxjGd
 MfOnaSmtVO2Rbdo7QoysK7VPCeYs9XPEO2/iKHjg8fndpL7Npwnxx7KXrAVpOLRo/tJ+ToMUitG
 M1tmJ9TJJ2M536h0JFIRah/77CUy+XXVqHAOZ4dMtKycQBGHKAOKeB0X6EXdwEd8eVVpr1lowO6
 Sg2Ad7nzPqBGt5qB4wUfSmyhU0yKk+KxbIBeXH/Ynv1jCMFmOmO7GBTS08Ck0ypHfP1cQkdfQQW
 +gNG1YySskfQlvhc5XugyZAWooe0paQed6V7eW4/EIbPtkQ3HgR1zfYwbiBm5Q/ghl/wmdmBg2N
 GUC9poYcjfH84jqaeI14D3V4qXtBmlPhcoNPWMpMz4FkytVihpLry0TJcneDAMUNhO3Jg1SPxGK
 u4eczvMIoB5qck1fUzEaMIih1ZvgsHPHOfeF+6sNsIqA+iUiQku9sTRae4lZesvcSWn7Iy6pux9
 DcPB0K/qohQWpJw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding for the Marvell PXA1928 USB and HSIC PHYs from TXT
to DT schema.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../bindings/phy/marvell,pxa1928-hsic-phy.yaml     | 37 +++++++++++++++++
 .../bindings/phy/marvell,pxa1928-usb-phy.yaml      | 46 ++++++++++++++++++++++
 .../devicetree/bindings/phy/pxa1928-usb-phy.txt    | 18 ---------
 3 files changed, 83 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,pxa1928-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,pxa1928-hsic-phy.yaml
new file mode 100644
index 000000000000..a477afd11329
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,pxa1928-hsic-phy.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/marvell,pxa1928-hsic-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA1928 HSIC PHY
+
+maintainers:
+  - devicetree@vger.kernel.org
+
+properties:
+  $nodename:
+    pattern: '^phy@[a-f0-9]+$'
+
+  compatible:
+    const: "marvell,pxa1928-hsic-phy"
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#phy-cells'
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
new file mode 100644
index 000000000000..4ae9201767ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/marvell,pxa1928-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA1928 USB PHY
+
+maintainers:
+  - devicetree@vger.kernel.org
+
+properties:
+  $nodename:
+    pattern: '^phy@[a-f0-9]+$'
+
+  compatible:
+    const: "marvell,pxa1928-usb-phy"
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@7000 {
+      compatible = "marvell,pxa1928-usb-phy";
+      reg = <0x7000 0xe0>;
+      clocks = <&apmu_clocks PXA1928_CLK_USB>;
+      #phy-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/pxa1928-usb-phy.txt b/Documentation/devicetree/bindings/phy/pxa1928-usb-phy.txt
deleted file mode 100644
index da94426aa694..000000000000
--- a/Documentation/devicetree/bindings/phy/pxa1928-usb-phy.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Marvell PXA1928 USB and HSIC PHYs
-
-Required properties:
-- compatible: "marvell,pxa1928-usb-phy" or "marvell,pxa1928-hsic-phy"
-- reg: base address and length of the registers
-- clocks - A single clock. From common clock binding.
-- #phys-cells: should be 0. From common phy binding.
-- resets: reference to the reset controller
-
-Example:
-
-	usbphy: phy@7000 {
-		compatible = "marvell,pxa1928-usb-phy";
-		reg = <0x7000 0xe0>;
-		clocks = <&apmu_clocks PXA1928_CLK_USB>;
-		#phy-cells = <0>;
-	};
-

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20231001-pxa1928-usb-yaml-809564082241

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


