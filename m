Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602E0781656
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbjHSBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbjHSBJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1592D59;
        Fri, 18 Aug 2023 18:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C506142D;
        Sat, 19 Aug 2023 01:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517F7C433C9;
        Sat, 19 Aug 2023 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692407394;
        bh=0XvaoLkX8SfTQSjDLN60fvMvpwG6yb+pFrQkc7aaaCw=;
        h=From:To:Cc:Subject:Date:From;
        b=KdQKqmY8VWQlteyoypQ1P+UiskpvFwOzv6aYS+J09+/pyrLETrMppOHg5JyFJcZmm
         cwsnysFJBbToziMO3aGhctjWM63/QXGHl/ZDdj2biEV0RZtYxf58hdF46TIbC6gtuh
         4TPfn76+ofAS35Gk/XZmZTs8w+eo+Je/DCHVJQ+3rIAgJZeVGbappQvyHNjMu61iHf
         ZrNkzcMLtiE7lXn43TS/PktTddY903GKgJjy3aTfeYE/5Ywu30g84vtm1wULYLfjof
         I26cUwnVbo4NrwSZjTPKm4FC9XW7PSekpOsd8NqpLarRPjNGhvYgr3hykEHiRhVhAy
         IQLus4z79AB/Q==
Received: (nullmailer pid 916899 invoked by uid 1000);
        Sat, 19 Aug 2023 01:09:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: pinctrl: Drop 'phandle' properties
Date:   Fri, 18 Aug 2023 20:09:44 -0500
Message-Id: <20230819010946.916772-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

'phandle' properties are implicitly supported on all nodes, so it
shouldn't be listed in schemas.

dtschema had a bug where 'phandle' and other implicit properties weren't
being added under 'additionalProperties' schemas. That was fixed in
v2023.07 release.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/ingenic,pinctrl.yaml          | 4 ----
 .../devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.yaml   | 2 --
 .../devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.yaml   | 2 --
 .../devicetree/bindings/pinctrl/nvidia,tegra194-pinmux.yaml   | 2 --
 .../devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.yaml    | 2 --
 .../devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.yaml   | 2 --
 .../devicetree/bindings/pinctrl/nvidia,tegra30-pinmux.yaml    | 2 --
 Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml    | 4 ----
 .../devicetree/bindings/pinctrl/renesas,rza1-ports.yaml       | 4 ----
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    | 4 ----
 .../devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml     | 4 ----
 .../devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml    | 4 ----
 .../bindings/pinctrl/socionext,uniphier-pinctrl.yaml          | 2 --
 13 files changed, 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
index 35723966b70a..890961826c6f 100644
--- a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
@@ -135,7 +135,6 @@ additionalProperties:
         - $ref: pinmux-node.yaml#
 
       properties:
-        phandle: true
         function: true
         groups: true
         pins: true
@@ -147,8 +146,6 @@ additionalProperties:
       additionalProperties: false
 
     - type: object
-      properties:
-        phandle: true
       additionalProperties:
         type: object
         allOf:
@@ -156,7 +153,6 @@ additionalProperties:
           - $ref: pinmux-node.yaml#
 
         properties:
-          phandle: true
           function: true
           groups: true
           pins: true
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.yaml
index 065dedb3573a..1690c0ef553a 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.yaml
@@ -22,8 +22,6 @@ properties:
 patternProperties:
   "^pinmux(-[a-z0-9-_]+)?$":
     type: object
-    properties:
-      phandle: true
 
     # pin groups
     additionalProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.yaml
index f924652bef0d..9b7368bd3862 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.yaml
@@ -32,8 +32,6 @@ properties:
 patternProperties:
   "^pinmux(-[a-z0-9-_]+)?$":
     type: object
-    properties:
-      phandle: true
 
     # pin groups
     additionalProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra194-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra194-pinmux.yaml
index 60a4bdf01bf2..87b6f4f42f25 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra194-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra194-pinmux.yaml
@@ -23,8 +23,6 @@ properties:
 patternProperties:
   "^pinmux(-[a-z0-9-_]+)?$":
     type: object
-    properties:
-      phandle: true
 
     # pin groups
     additionalProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.yaml
index 432ea40209a8..63cd743a30e0 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.yaml
@@ -24,8 +24,6 @@ properties:
 patternProperties:
   "^pinmux(-[a-z0-9-_]+)?$":
     type: object
-    properties:
-      phandle: true
 
     # pin groups
     additionalProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.yaml
index 28ae2e6d0cbc..e99387a6da5e 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.yaml
@@ -22,8 +22,6 @@ properties:
 patternProperties:
   "^pinmux(-[a-z0-9-_]+)?$":
     type: object
-    properties:
-      phandle: true
 
     # pin groups
     additionalProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra30-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra30-pinmux.yaml
index c0eda7848767..36c8f3301a8f 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra30-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra30-pinmux.yaml
@@ -22,8 +22,6 @@ properties:
 patternProperties:
   "^pinmux(-[a-z0-9-_]+)?$":
     type: object
-    properties:
-      phandle: true
 
     # pin groups
     additionalProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
index 0fc3c0f52c19..181cd1676c0a 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
@@ -107,7 +107,6 @@ additionalProperties:
         Client device subnodes use below standard properties.
 
       properties:
-        phandle: true
         function: true
         groups: true
         pins: true
@@ -127,9 +126,6 @@ additionalProperties:
       additionalProperties: false
 
     - type: object
-      properties:
-        phandle: true
-
       additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
index 83800fcf0ce4..2bd7d47d0fdb 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
@@ -108,7 +108,6 @@ additionalProperties:
             Integers values in "pinmux" argument list are assembled as:
             ((PORT * 16 + PIN) | MUX_FUNC << 16)
 
-        phandle: true
         input-enable: true
         output-enable: true
 
@@ -118,9 +117,6 @@ additionalProperties:
       additionalProperties: false
 
     - type: object
-      properties:
-        phandle: true
-
       additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 9ce1a07fc015..145c5442f268 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -83,7 +83,6 @@ additionalProperties:
         Client device subnodes use below standard properties.
 
       properties:
-        phandle: true
         pinmux:
           description:
             Values are constructed from GPIO port number, pin number, and
@@ -106,9 +105,6 @@ additionalProperties:
         line-name: true
 
     - type: object
-      properties:
-        phandle: true
-
       additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
index 19d4d2facfb4..816688580e33 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
@@ -74,7 +74,6 @@ additionalProperties:
             offset by 10.  Additional identifiers are provided to specify the
             MDIO source peripheral.
 
-        phandle: true
         bias-disable: true
         bias-pull-up:
           description: Pull up the pin with 50 kOhm
@@ -91,9 +90,6 @@ additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
     - type: object
-      properties:
-        phandle: true
-
       additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
index c87161f2954f..cb81a17bd0b1 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
@@ -63,7 +63,6 @@ additionalProperties:
         Client device subnodes use below standard properties.
 
       properties:
-        phandle: true
         pinmux:
           description:
             Values are constructed from GPIO port number, pin number, and
@@ -87,9 +86,6 @@ additionalProperties:
         line-name: true
 
     - type: object
-      properties:
-        phandle: true
-
       additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
index a6f34df82e90..880da721a927 100644
--- a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
@@ -32,7 +32,6 @@ additionalProperties:
     - $ref: pinmux-node.yaml#
 
   properties:
-    phandle: true
     function: true
     groups: true
     pins: true
@@ -49,7 +48,6 @@ additionalProperties:
       - $ref: pinmux-node.yaml#
 
     properties:
-      phandle: true
       function: true
       groups: true
       pins: true
-- 
2.40.1

