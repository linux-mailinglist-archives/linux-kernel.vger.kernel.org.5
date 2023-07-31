Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2C768F21
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGaHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGaHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:44:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003DB133;
        Mon, 31 Jul 2023 00:44:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so6683382e87.2;
        Mon, 31 Jul 2023 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690789474; x=1691394274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqvGAPT7neziVvHDubuOu9V/KpoUsJhFanau8JLehaM=;
        b=EKFUZjLJHPE14vqKWjXvsS6Bqqm3VnQFvC1cNc8/mWhf/bF5eBvU29IoXau3+5Hrtp
         Ge6jbVwbARIUXNIkBooxca+G6WFz0cdTPVaLY7v4/jUrMiw2rn6vglh4ipfF0+S/NJbg
         Ti1s7fx69EDKHBMVuPMK/vP+wCPF3R8ENYLNiHLzbMIYrxrora4GgUMTqFBrtppE/haE
         mX4Q+35UkQuelpj2NZFr/f1iB1TAxa5Nhy7EZ5Me24lHda/cSEPqfVfXkDAXlIwDf5Z0
         ds65DZRx/MkCVOA043oMwdVPEB2semuCdkNSK/e8MjG+0ibCG1h2YPj4yZSQLvOLyR91
         oRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789474; x=1691394274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqvGAPT7neziVvHDubuOu9V/KpoUsJhFanau8JLehaM=;
        b=LeCOx5LLe1A5avSQSAHaoywd6UdBROMmFOALmRECGjRxe43GuEN7MMR6QnISmbRyy0
         4XN6Ns4JWa9CWBXZramdNyD25gGT/n0znUL0advxx+ikKRwgQOPvLoNEjMlaehJJI+c3
         ZbK5v2GDzZI8Ewc3SEdF49zynEQ/W78nDkgfy3TQXiIPakNiO9NA/TLmgpOI2pMiFFPa
         1AOeIH4+22fCWD6yN2kwjM6AGLr/0vU8Yw0Q4D0bEFO3UbQWcMZzqzFOhjLn0xS/+Vge
         TBQ79DYYmFo6vRzD17LWlk9ef2z9iCb7jhL2O/6e4DZN8JUojOFbU7fw3ctC8B/RF1wD
         p3gA==
X-Gm-Message-State: ABy/qLbIKrhauqO53hDw0kllW2AteNgCw5t1E9R9bd0DZ9/WWAWXix7z
        ZSeTKy/9JrwQL5Tvzc6ZdiM=
X-Google-Smtp-Source: APBJJlFjdqXCx11bxD67YFSpU8yNqpslq4g/EBtoYD8wvo2b24AyhfPJrx3t8bFDTxyoSpEK2PSc4g==
X-Received: by 2002:a05:6512:2018:b0:4fb:9da2:6cec with SMTP id a24-20020a056512201800b004fb9da26cecmr4314772lfb.7.1690789473875;
        Mon, 31 Jul 2023 00:44:33 -0700 (PDT)
Received: from localhost.localdomain (95-24-155-24.broadband.corbina.ru. [95.24.155.24])
        by smtp.googlemail.com with ESMTPSA id c14-20020a05651221ae00b004fe14a429a8sm1973944lft.50.2023.07.31.00.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:44:32 -0700 (PDT)
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
Subject: [PATCH v3] dt-bindings: net: ftgmac100: convert to yaml version from txt
Date:   Mon, 31 Jul 2023 10:44:26 +0300
Message-ID: <20230731074426.4653-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion from ftgmac100.txt to yaml format version.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/net/faraday,ftgmac100.yaml       | 104 ++++++++++++++++++
 .../devicetree/bindings/net/ftgmac100.txt     |  67 -----------
 2 files changed, 104 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
new file mode 100644
index 000000000000..965e6db38970
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -0,0 +1,104 @@
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

