Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B0771000
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHENxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHENxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:53:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC5199;
        Sat,  5 Aug 2023 06:53:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so50303801fa.0;
        Sat, 05 Aug 2023 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691243607; x=1691848407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EL4irT6Xqgsi30IiRyba/mxba3n+qOkv3KZi5C+dTFA=;
        b=Z54dEAgGg1/ePblnO5SIkudufQDZvAw4Jfe++swbd744aIrn6h5ZWAcK4+ejasdlxh
         FMfUFFiW5sJPMusFbhotbiS/056Vh0UBhEpQOQJi/4cglsxEeqtXtEQTlCVEuANi13HN
         vmnOVstvCy1oQpFhYI0+FzJJqmNVlEPcqYR8N8+ZMEoW7fw7vJxz5nzSkgpaMPcNKIp2
         FMOU/18MsrjIcjwcGVGVQzugKoyql9ZT+rj4+sKWtL1XngaZ4uNzCsl25VlC3VhVQCmc
         cd/HLLr9NEpT6E+8DyTHzVNIRBTcPhnZjRRENSY8Vci7jrADftfF4pwfXfeR2QHQmy/G
         F49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691243607; x=1691848407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL4irT6Xqgsi30IiRyba/mxba3n+qOkv3KZi5C+dTFA=;
        b=E+Wy5PoK9So3YMm51COMbNkSSaNvFD3h1rC1+QAQI3wizS09QGY3iQ2RulyaH9qsvL
         5gR0Khh2usXozsEtGTzunG22ED79uosp8cMvsQt4HV9sfa7+6Lw2mASO7HunbqfJdeMw
         Xt+S6on/UHJGAo4cUXOKgEQziZ2iCMbZ/NjUr2gjQmpK9Dq5EpF4FaTTYBiuqGuogB21
         D/emj1dwecCzt0sYEp65lMJSmmuaiHFJ6FVDeypL9hBz7VqMi5pmJJCJBx0EhHHE+nbP
         v4ms/S5n6IIqxeUmw/1FxG2u6hNzGKlv4BfATfpq3mgk6oQeYyR2Wwt5Qc3FXzZ/Q8KY
         uqpA==
X-Gm-Message-State: AOJu0Yyu1iMYjLH2TJPNkbF8GwLqLtj50m1gK91CCs2/34CikuNrYQ9K
        f0ipYqC7bFg3SCzgYb40xX8=
X-Google-Smtp-Source: AGHT+IEpbkT7AmigjkKcx1rCZ2YLVNr03+lzCRMl97dOakJxIalSkm8IT3s8x9hCj1TKaa7lYmzSpw==
X-Received: by 2002:a05:651c:483:b0:2b9:cb73:9a90 with SMTP id s3-20020a05651c048300b002b9cb739a90mr789696ljc.11.1691243606913;
        Sat, 05 Aug 2023 06:53:26 -0700 (PDT)
Received: from localhost.localdomain (95-24-145-241.broadband.corbina.ru. [95.24.145.241])
        by smtp.googlemail.com with ESMTPSA id w20-20020a2e9bd4000000b002b6f8d07d30sm900124ljj.134.2023.08.05.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 06:53:26 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>,
        Conor Dooley <conor@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v4] dt-bindings: net: ftgmac100: convert to yaml version from txt
Date:   Sat,  5 Aug 2023 16:53:18 +0300
Message-ID: <20230805135318.6102-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 000000000000..9bcbacb6640d
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
+    minItems: 1
+    items:
+      - description: MAC IP clock
+      - description: RMII RCLK gate for AST2500/2600
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: MACCLK
+      - const: RCLK
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
+    deprecated: true
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
+    ethernet@1e660000 {
+        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        reg = <0x1e660000 0x180>;
+        interrupts = <2>;
+        use-ncsi;
+    };
+
+    ethernet@1e680000 {
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

