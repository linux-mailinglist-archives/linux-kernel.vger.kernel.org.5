Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A588E7A368C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjIQQ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjIQQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:29:43 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6B891;
        Sun, 17 Sep 2023 09:29:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D80A2FF805;
        Sun, 17 Sep 2023 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694968174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=34Ndrewp5sbJMJ2jOunLl5qw82bqk9h/3cG8G8ygPsc=;
        b=aISGUYh72XAMzn5uT1GbJpZ68jajpUa/1xb1LmMeXvwMILRv3eTZEFnqi4FSgOIqqXh+jG
        FRKQhYMGF2n75GjvnFLisdZnUT1xcqZ0S5ZIPB93Z9G+IxEZH6AuQUyce4EsXnDBnHWpoV
        cT0b6Wg/HYU5h+L5XeOL/TTtZxQwiltZXrqNNSV/XQFfdz+XsmUiTr5+XBVKYS7qrZ6gr+
        EkJLKgNOrbVQ13DpVzHvBtFcBn0lPfui80GCBmxinB5ufJEJGMzFnX+JQROFz/GY+yjwH6
        hiX1PpYoaceNfsprFN9FgXg8X2WFpacj6kPZbX6frJn6c3qemTJWaHAe8cCPuw==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: mtmips: add deprecated ralink,rt2880-pinmux
Date:   Sun, 17 Sep 2023 19:28:36 +0300
Message-Id: <20230917162837.277405-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ralink,rt2880-pinmux" compatible string applies to all MediaTek MTMIPS
SoC pin controllers. Add it as a deprecated compatible string.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml | 5 ++++-
 .../devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml | 5 ++++-
 .../devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml | 5 ++++-
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml   | 5 ++++-
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml   | 5 ++++-
 .../devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml   | 5 ++++-
 .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml   | 5 ++++-
 .../devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml   | 5 ++++-
 8 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
index 591bc0664ec6..221adcef6e14 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,mt7620-pinctrl
+    oneOf:
+      - const: ralink,mt7620-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
index e568b9c13727..5e29332c794b 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,mt7621-pinctrl
+    oneOf:
+      - const: ralink,mt7621-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
index 31849dd5940b..fef7728a5220 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,mt76x8-pinctrl
+    oneOf:
+      - const: ralink,mt76x8-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 43b33dbf115b..71bc961b856e 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,rt2880-pinctrl
+    oneOf:
+      - const: ralink,rt2880-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 95a904273009..bde19a00af80 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,rt305x-pinctrl
+    oneOf:
+      - const: ralink,rt305x-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
index c9bc6cfd834c..f87038cadfc8 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,rt3352-pinctrl
+    oneOf:
+      - const: ralink,rt3352-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 8d14e525b25e..3a13a69f7752 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,rt3883-pinctrl
+    oneOf:
+      - const: ralink,rt3883-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
index f248202ce866..1231f442afbc 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
@@ -17,7 +17,10 @@ description: |
 
 properties:
   compatible:
-    const: ralink,rt5350-pinctrl
+    oneOf:
+      - const: ralink,rt5350-pinctrl
+      - const: ralink,rt2880-pinmux
+        deprecated: true
 
 patternProperties:
   '-pins$':
-- 
2.39.2

