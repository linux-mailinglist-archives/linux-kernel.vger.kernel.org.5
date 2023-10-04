Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399F7B8274
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbjJDOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbjJDOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:35:02 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C6FEB;
        Wed,  4 Oct 2023 07:34:57 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 70CAE86040;
        Wed,  4 Oct 2023 16:34:55 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 04 Oct 2023 16:34:43 +0200
Subject: [PATCH v3] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231004-pxa1928-usb-yaml-v3-1-150c9ef3ab9d@skole.hr>
X-B4-Tracking: v=1; b=H4sIAAJ4HWUC/32NQQ6CMBBFr0K6tmZmitq68h7GRYVBGhFIqw2Ec
 HcLKxbG5fvJe38Sgb3jIM7ZJDxHF1zXJlC7TBS1bR8sXZlYEJBCAJT9YNGQlp9wl6N9NVKDORx
 z0EQ5iqT1nis3rMnrLXHtwrvz4/oQcVn/xCJKlEaBsbqAAlR1Cc+u4X3txdKKtPXph0/JR0J7Y
 qCSzNaf5/kLrtQkXO8AAAA=
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=qO9ou1l5FEkTyCnSICtnUTG5cQCSx7IkoImt5WAeNhQ=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlHXgIOpjprFnT+GwaiK4ZJNiEGr8aaTwnhzCdW
 AcHrU4p6dWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZR14CAAKCRCaEZ6wQi2W
 4ScDEACN90WVQXJ1XBT0o0Gs+qqlsnuw26/ff3WG/rbQVKHFWLSmAqinISvMAOYK89kK/yXby/r
 szZ6s+zoZpMGfqI5LcTm9Q6mltOtw5hkYSaqOW6CWgIxwYkV/oSOtp0pDu3KutxOcqPLvbM7VyY
 6r7xkN4VdJTm4kprrvVqTy/uAHrPYs9N2EGafsRcMTwObHn62TbynIyoCS9ZVmhFuDn6ev8I+JA
 prxjZqHoafdl+5cOvt+c8McKNwhlVPjc/AfKXzhG6Ts/Nr42UpE9/zLnANs4a3WlfmzIJdOaPxn
 dB02ed1mOvBoIJtogT+dmaYFNmYo3UPePXpqCXUytAn3y4DTbaP7lvoCWUzu+H2vfBw9bWLXtCq
 OwDxJ+QSLKjpkXg9AQmepYPZpRp706wq0qtXLlXwVHgUpCFFhlT+1PG23j5cqHlGS4T7ZLYhUxV
 NO1MZ5jSi1sCLqdeaHgqVCyAPKsmUnR/yRN54O5xxmaLWwpT4ClLp2JQbzFVQVMRwSOccZIT7jM
 tIlEhmcv6E+QYKIFJnVoz8yVYO2PX+BUhKROywS/5AlqkcRrKTDGs1kOaQCC/7HeYbhNi3SN2ya
 aK6uRkpcfI1VLh396IOCGf6tQNQQuqUL9XRchMRCfp1u3cD7zo8dtl8fFEC09siMn2Y5q88j5Yk
 +6nLdtYQ4deoKlQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding for the Marvell PXA1928 USB and HSIC PHYs from TXT
to DT schema.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v3:
- Address maintainer comments:
  - Re-add example DTS
  - Drop nodename
  - Simplify compatible
- Link to v2: https://lore.kernel.org/r/20231002-pxa1928-usb-yaml-v2-1-121a7e02d29f@skole.hr

Changes in v2:
- Add myself as maintainer
- Combine HSIC and USB bindings into one
- Drop unneeded quotes
- Remove example as it can't compile (probably because of clock
  reference)
- Link to v1: https://lore.kernel.org/r/20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr
---
 .../bindings/phy/marvell,pxa1928-usb-phy.yaml      | 47 ++++++++++++++++++++++
 .../devicetree/bindings/phy/pxa1928-usb-phy.txt    | 18 ---------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
new file mode 100644
index 000000000000..be33f036cda8
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/marvell,pxa1928-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA1928 USB/HSIC PHY
+
+maintainers:
+  - Duje Mihanović <duje.mihanovic@skole.hr>
+
+properties:
+  compatible:
+    enum:
+      - marvell,pxa1928-usb-phy
+      - marvell,pxa1928-hsic-phy
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
+    #include <dt-bindings/clock/marvell,pxa1928.h>
+
+    usbphy: phy@7000 {
+        compatible = "marvell,pxa1928-usb-phy";
+        reg = <0x7000 0xe0>;
+        clocks = <&apmu PXA1928_CLK_USB>;
+        #phy-cells = <0>;
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


