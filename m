Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93477B5B61
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbjJBTe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbjJBTe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:34:56 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDAD7;
        Mon,  2 Oct 2023 12:34:49 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 9289D83C68;
        Mon,  2 Oct 2023 21:34:46 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 02 Oct 2023 21:34:37 +0200
Subject: [PATCH v2] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231002-pxa1928-usb-yaml-v2-1-121a7e02d29f@skole.hr>
X-B4-Tracking: v=1; b=H4sIAEwbG2UC/32NQQ6CMBBFr0Jm7ZiZgqZ1xT0Mi4rFNiIlrTYQ0
 rtbOYDL95L//gbRBGciXKoNgkkuOj8VEIcKequnh0F3LwyCRM1EjPOiWQmJn3jDVb9GlKRO54a
 kEA1Dmc3BDG7Zk9eusHXx7cO6PyT+2T+xxMioalJa9tRTPbTx6UdztAG6nPMXgTPhlq8AAAA=
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=OgvaUU8MJ1mJrse/GI+YQsWTLsXAVZ4nX34xt2is75o=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlGxtQAQwZCkgVwqJPXJ3lPoXZFQ3pVhOdoaHX4
 nrUOGrmN7yJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRsbUAAKCRCaEZ6wQi2W
 4V1HD/90P71Wo7UVPPNCqWe+cw/z5EzghrOwhiefUL2IEbNn+kV4vtonywqNdCLIATP9zhKBcfK
 GBbeLXRxfo8lHp9QrAIGvv2dZH58NuwLApujmxX8TGaEv7XLanBsKHUf6sBE0bN2wxBldnuaP9R
 9JD71DT0rRZs7MnvS+qqMCDupSTBfFy7Nixgjb8cSkzpUSj4KZw32MWGv8asx5CJAvi3hbkMHeD
 h8Z5CimS5Obgfsdo4nN5HzqVUfihpHISwPJeAvO+ICMljGKOAXQMb4MrPh2092fKCRgqX3xfkS4
 O8tpOS/BwkwhbuSX1rn1di9uyw265e4y6xWuIGQztnHLcIH6hjkfcZUT2z9uXbLj2BlCm1qq9Fq
 Gv/n8q8bXihLjNwFhMaWNtEaAX49iLX2RcBXs409bUDLcTNk0/SFZ1oGy7qOZ4MnXwAz7L5xyxM
 mpOToQiHPeAzOXtDjB3ld9mt2HOCf3FHbiU5YkdvxgbXxrQHSDXP3DIWM1DoGx+fMbxzRoa+noT
 lxKeqgWi0YFysW0kxdRbm4psxAqmJseL+HaGYckCJedrhsyl9Zcyk8NxVSjwa4vv9xyO5JMFmQO
 5mKmWaXXnohrV3Qrd4YlYi5SHBXCMJWt+XcQxOaxPYLDrkPK3Pswjm2/yR1uOnaooTYxqTYQhc2
 bU2q2QbYhgJBYtg==
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
Changes in v2:
- Add myself as maintainer
- Combine HSIC and USB bindings into one
- Drop unneeded quotes
- Remove example as it can't compile (probably because of clock
  reference)
- Link to v1: https://lore.kernel.org/r/20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr
---
 .../bindings/phy/marvell,pxa1928-usb-phy.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/phy/pxa1928-usb-phy.txt    | 18 ----------
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
new file mode 100644
index 000000000000..60cf3fa8d3bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
@@ -0,0 +1,41 @@
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
+  $nodename:
+    pattern: '^phy@[a-f0-9]+$'
+
+  compatible:
+    oneOf:
+      - items:
+          const: marvell,pxa1928-usb-phy
+      - items:
+          const: marvell,pxa1928-hsic-phy
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


