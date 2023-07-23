Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2975E2F0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGWPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGWPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:51:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FCCE5F;
        Sun, 23 Jul 2023 08:51:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso51089381fa.1;
        Sun, 23 Jul 2023 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690127480; x=1690732280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcrgJB1yR+1Ol8iHx2MeBLAKq+SVY3ABMYCIl2QjY3k=;
        b=TIy6pqvqLwSXFuffSLn411w/V9cWjUaxFnFsozdiQfbjgO9x+ceXXmGZw6TgVZN/AJ
         xwDYwtG+hC2iv0/onbPW2Jvbu09D6ATHAm/gdjZ0OCpBWdeKpgZ8lchSbOgOkXVgBgEy
         CCrUZ9G9Byt4Dkl0y6st8tePv6XpkbEaVDivvUbj3o9rp7Hw63lnFyrW24GMwlqo5w95
         sUY6wE6CJ4v+9L/eaJsxUQGo+9QPssX5TZbIC0Gyp9eHip1HqGaRcvIXVa117AVAdLoK
         Wa44widgYSFz/zu6VVw9EE9BGKORzKzfn6lczUiBDOg/x0jHFkjqnbX7o+JhwcLVmoyc
         tstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690127480; x=1690732280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcrgJB1yR+1Ol8iHx2MeBLAKq+SVY3ABMYCIl2QjY3k=;
        b=Y0NPO2QAFWMMG/utmJ+Y8tD/78t92jRJboWDk+Ij69ZGFILtCHywtxxmmyWvV8tzxz
         aLmul+ToM3Xbyv9R2MOuagy3BmXLQEDsTBMByc4LsAxbc+pAeQ7Sd681He35o5xf+S91
         4gAnrV8GWq0JAh2+t2BAs/mxEBsOUgDgs1W5KIHMNK4p1NkJzMZqOtq7pdAdZRc9Dceu
         LcCPcC3vTyq+B0HRNbI0bFNuuOl/3wu6uFYTcriOByNoQ4swbX9VT9sPT9mpniBtHi+H
         UAjwH34+doseSpppM1vCwcm+uvlkqJcZXWlBOoBNQQbLrRzHhtju0w6Luxj4vvbLj41D
         shHA==
X-Gm-Message-State: ABy/qLacyo4HOoqJTFAom794EscV9zXNRzBwj3sR0ahi354c8ZfRYrfN
        H8lqXtP9cNKYVXbuwM+QNvk=
X-Google-Smtp-Source: APBJJlFyTUTyUBTnSQJOn/f/OABMoGGE9lVKX0PNoCyCirwC+/+HrUiB5O7eiMmKhcEhsCWAZqpAUQ==
X-Received: by 2002:a2e:3206:0:b0:2b6:da1e:d063 with SMTP id y6-20020a2e3206000000b002b6da1ed063mr4201530ljy.45.1690127480048;
        Sun, 23 Jul 2023 08:51:20 -0700 (PDT)
Received: from localhost.localdomain (95-24-145-175.broadband.corbina.ru. [95.24.145.175])
        by smtp.googlemail.com with ESMTPSA id l22-20020a2ea316000000b002b6fed37b18sm2167024lje.101.2023.07.23.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:51:19 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH] dt-bindings: net: ftgmac100: convert to yaml version from txt
Date:   Sun, 23 Jul 2023 18:51:07 +0300
Message-Id: <20230723155107.4498-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion from ftgmac100.txt to yaml format version.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/net/faraday,ftgmac100.yaml       | 102 ++++++++++++++++++
 .../devicetree/bindings/net/ftgmac100.txt     |  67 ------------
 2 files changed, 102 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
new file mode 100644
index 000000000000..f1e72290ed94
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTGMAC100 gigabit ethernet controller
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+maintainers:
+  - Po-Yu Chuang <ratbert@faraday-tech.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,ftgmac100
+      - items:
+          - enum:
+              - aspeed,ast2400-mac
+              - aspeed,ast2500-mac
+              - aspeed,ast2600-mac
+          - const: faraday,ftgmac100
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      The MAC IP clock and optionally a RMII RCLK gate for the AST2500/AST2600.
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - enum:
+          - MACCLK
+          - RCLK
+    minItems: 1
+
+  phy-mode:
+    enum:
+      - rgmii
+      - rmii
+
+  phy-handle: true
+
+  use-ncsi:
+    description:
+      Use the NC-SI stack instead of an MDIO PHY. Currently assumes
+      rmii (100bT) but kept as a separate property in case NC-SI grows support
+      for a gigabit link.
+    type: boolean
+
+  no-hw-checksum:
+    description:
+      Used to disable HW checksum support. Here for backward
+      compatibility as the driver now should have correct defaults based on
+      the SoC.
+    type: boolean
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mac0: ethernet@1e660000 {
+        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        reg = <0x1e660000 0x180>;
+        interrupts = <2>;
+        use-ncsi;
+    };
+
+    mac1: ethernet@1e680000 {
+        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        reg = <0x1e680000 0x180>;
+        interrupts = <2>;
+
+        phy-handle = <&phy>;
+        phy-mode = "rgmii";
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy: ethernet-phy@1 {
+                compatible = "ethernet-phy-ieee802.3-c22";
+                reg = <1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/ftgmac100.txt b/Documentation/devicetree/bindings/net/ftgmac100.txt
deleted file mode 100644
index 29234021f601..000000000000
--- a/Documentation/devicetree/bindings/net/ftgmac100.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Faraday Technology FTGMAC100 gigabit ethernet controller
-
-Required properties:
-- compatible: "faraday,ftgmac100"
-
-  Must also contain one of these if used as part of an Aspeed AST2400
-  or 2500 family SoC as they have some subtle tweaks to the
-  implementation:
-
-     - "aspeed,ast2400-mac"
-     - "aspeed,ast2500-mac"
-     - "aspeed,ast2600-mac"
-
-- reg: Address and length of the register set for the device
-- interrupts: Should contain ethernet controller interrupt
-
-Optional properties:
-- phy-handle: See ethernet.txt file in the same directory.
-- phy-mode: See ethernet.txt file in the same directory. If the property is
-  absent, "rgmii" is assumed. Supported values are "rgmii*" and "rmii" for
-  aspeed parts. Other (unknown) parts will accept any value.
-- use-ncsi: Use the NC-SI stack instead of an MDIO PHY. Currently assumes
-  rmii (100bT) but kept as a separate property in case NC-SI grows support
-  for a gigabit link.
-- no-hw-checksum: Used to disable HW checksum support. Here for backward
-  compatibility as the driver now should have correct defaults based on
-  the SoC.
-- clocks: In accordance with the generic clock bindings. Must describe the MAC
-  IP clock, and optionally an RMII RCLK gate for the AST2500/AST2600. The
-  required MAC clock must be the first cell.
-- clock-names:
-
-      - "MACCLK": The MAC IP clock
-      - "RCLK": Clock gate for the RMII RCLK
-
-Optional subnodes:
-- mdio: See mdio.txt file in the same directory.
-
-Example:
-
-	mac0: ethernet@1e660000 {
-		compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
-		reg = <0x1e660000 0x180>;
-		interrupts = <2>;
-		use-ncsi;
-	};
-
-Example with phy-handle:
-
-	mac1: ethernet@1e680000 {
-		compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
-		reg = <0x1e680000 0x180>;
-		interrupts = <2>;
-
-		phy-handle = <&phy>;
-		phy-mode = "rgmii";
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			phy: ethernet-phy@1 {
-				compatible = "ethernet-phy-ieee802.3-c22";
-				reg = <1>;
-			};
-		};
-	};
-- 
2.40.1

