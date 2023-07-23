Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE875E471
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGWTUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:20:40 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DE1BC;
        Sun, 23 Jul 2023 12:20:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703a0453fso51372151fa.3;
        Sun, 23 Jul 2023 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690140037; x=1690744837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4aytIQn94twcjyotrD+oqBf+KXoIbhRWHt21ZbgVkA=;
        b=NLIoC0HdDwhnOq/2MGCe7NKNvlaDjuy1kJ+zaXbBsYxD+92/+X2ucmIL5TvHe/DjRa
         XFOn1u0epuH+Uwgo8JAP4uxrAKp99TIM4/iVUbVM5mvmDtZUz2rLyacdozI2RHWL8W88
         rfYoT1KLt0fTQUO4csPqpAwssF9D6/NRwN8TR6yGuespxOZ2/rOibs81lrXwnCT5+dex
         EnXrEuvNoDSKa6BeCtqGPg8ZBG8Jjh8LoIrNcvPpdrjJ21Iv/1oIc60JB0j2Qlg2pOaV
         Bqs8bl1u9koVljId4Ha0viIfYqYnwJbJP8+RIrYTRDUZ1j1eC3qaN/5cfFk0OaLbrTpu
         A8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690140037; x=1690744837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4aytIQn94twcjyotrD+oqBf+KXoIbhRWHt21ZbgVkA=;
        b=b0eBWbw+ocA4AAIhXdV+UPUqHCkVq+4nEUGgx2EZC8/nInrSH2BLol4r55eUs/9T8X
         BN2pjnurHOziEBSJ9yzTV8RIrELOd1FOtUISQNbYFwnIKyiY/UujWAhjkOrKidMZWWfD
         2o0n6qz7HqhhOheK7O20dZ9wF6PGc24KpDvEn/BjKDPG/yUjG4Y4w78SrVXLvGZcQE5H
         bG+o3OOs9BZxDvZ/k44nBBS4k3X0BwEDzEde34gZYZBhSpIwt5dDAZORGwezVC3ui2R9
         H1fLbXwI+H2KX14BBzgQwX2mBJUnGQ7nePe7WpWL1Qw1441QTOsTss1tK/4VwMi0WRZn
         mHWw==
X-Gm-Message-State: ABy/qLbn6loDZoDzju6aXGNs4pZxWZqzB/pps0TI/wKXOOkp1d1Romot
        ySf8XkZP/UmvOJIMNGvhU/Y+B1dIDHfVUT1f
X-Google-Smtp-Source: APBJJlG96kkoAL2pjuWgX3xVE8F8hsZ//4boP8R3WgU2DoYazDce8oqYb7elEGBXFu19JeNWWzC0Mg==
X-Received: by 2002:a05:6512:3d93:b0:4fb:9d61:db44 with SMTP id k19-20020a0565123d9300b004fb9d61db44mr4745078lfv.12.1690140037029;
        Sun, 23 Jul 2023 12:20:37 -0700 (PDT)
Received: from localhost.localdomain (95-24-145-175.broadband.corbina.ru. [95.24.145.175])
        by smtp.googlemail.com with ESMTPSA id q7-20020ac24a67000000b004fde831f86esm1139687lfp.142.2023.07.23.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:20:36 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: net: ftgmac100: convert to yaml version from txt
Date:   Sun, 23 Jul 2023 22:20:30 +0300
Message-ID: <20230723192030.33642-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.41.0
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
 .../bindings/net/faraday,ftgmac100.yaml       | 103 ++++++++++++++++++
 .../devicetree/bindings/net/ftgmac100.txt     |  67 ------------
 2 files changed, 103 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
new file mode 100644
index 000000000000..92686caf251f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -0,0 +1,103 @@
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
+    minItems: 1
+    items:
+      - description: MAC IP clock
+      - description: RMII RCLK gate for AST2500/2600
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    contains:
+      enum:
+        - MACCLK
+        - RCLK
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
2.41.0

