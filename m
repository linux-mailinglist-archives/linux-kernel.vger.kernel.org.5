Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86F789CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjH0J3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjH0J3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD95E1;
        Sun, 27 Aug 2023 02:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB7A5615D3;
        Sun, 27 Aug 2023 09:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D31C433C9;
        Sun, 27 Aug 2023 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693128549;
        bh=BDjKxssVciyafhRoklrknMsC7Bl61wHlzGID0mz0Kb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDRSB6BuXfTUhb8KjeEad6rpXSHysvgZzbylO+uHW5+1F151eLaNU7gTrEXO4a+jp
         mQHKUwcJ+rHjjjRgPHdj8ZiIA8/Dgy0cK5fSm28mjJD6DKDGbGEh3E2ZgXY3lDd5Q6
         ox0HTLT3GS0EaCZkI6RotQuDixVL1Fea1/vC8/dSDlDDWdmgdsXOlTY6r4icWdZCwY
         c/vWZv2AkqiYeYPQXQmUJZbjYSIxjdDN+FpvMdCtD9CpOpUZkjjKG0arHtLOTgGwci
         ZKkfocC1yHZUgNLYBhddo4XEjHc1xcQu5VpxyX6DZpauLv8gy2cHX1+2aTCRw0Fpkq
         UocciAmUSvnNQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, Maxime@vger.kernel.org,
        Coquelin@vger.kernel.org, Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH net-next v2 2/3] dt-bindings: net: add T-HEAD dwmac support
Date:   Sun, 27 Aug 2023 17:17:09 +0800
Message-Id: <20230827091710.1483-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827091710.1483-1-jszhang@kernel.org>
References: <20230827091710.1483-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe T-HEAD dwmac.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../devicetree/bindings/net/thead,dwmac.yaml  | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index b196c5de2061..73821f86a609 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -96,6 +96,7 @@ properties:
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7110-dwmac
+        - thead,th1520-dwmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
new file mode 100644
index 000000000000..bf8ec8ca2753
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD DWMAC Ethernet controller
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - thead,th1520-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - thead,th1520-dwmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    maxItems: 1
+
+  thead,gmacapb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to the syscon node that control ethernet
+      interface and timing delay.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
+  - thead,gmacapb
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@e7070000 {
+        compatible = "thead,th1520-dwmac", "snps,dwmac-3.70a";
+        reg = <0xe7070000 0x2000>;
+        clocks = <&clk 1>, <&clk 2>;
+        clock-names = "stmmaceth", "pclk";
+        interrupts = <66>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&stmmac_axi_setup>;
+        snps,pbl = <32>;
+        thead,gmacapb = <&gmacapb_syscon>;
+        phy-handle = <&phy0>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "snps,dwmac-mdio";
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
-- 
2.40.1

