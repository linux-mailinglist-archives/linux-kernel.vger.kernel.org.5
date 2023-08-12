Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF1779E77
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjHLJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjHLJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:17:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1788268C;
        Sat, 12 Aug 2023 02:17:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9372F1BF204;
        Sat, 12 Aug 2023 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691831854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsRwvKVYtk21gU+9mAWLQMZ2egmxY1XWYNUSUt9DxMo=;
        b=FwNw7L1GC8Df9y3lwueMde8imrg8OOVhGbTF/yJ67+g0C8mgismJeZHjEW3fLSi3mOzqoL
        NRZ/x93oZYTZVUKrYZTZJZkljv/76NiYLplgGPGW1yarpIQObKhpmDxg6bCZKtcDWtb2x2
        yQc34XfD21nFUSAMKODDiLNRjbygrAE9TSyDj1ln4rxOIWF92F+IFFhcIKfpBgjrpbIUO4
        31dxjC/E8cnKH/GE4TtXmPIB5ttnTxTTi0dZQ94yRCrU5ZvSsTFXQFMEox2qqLVVAILsFG
        ZqM40yaY1DizcfKIJSWOY/HylHGYZXjZojkpOpN7/0p1a2a6+rZCdA07FIvmLA==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Date:   Sat, 12 Aug 2023 12:17:06 +0300
Message-Id: <20230812091708.34665-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812091708.34665-1-arinc.unal@arinc9.com>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the schema to document the internal MDIO bus. Adjust realtek.yaml
accordingly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/net/dsa/dsa.yaml      | 18 +++++
 .../devicetree/bindings/net/dsa/realtek.yaml  | 66 +++++++++----------
 2 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index ec74a660beda..03ccedbc49dc 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -31,6 +31,24 @@ properties:
       (single device hanging off a CPU port) must not specify this property
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
+  mdio:
+    description: The internal MDIO bus of the switch
+    $ref: /schemas/net/mdio.yaml#
+
+if:
+  required: [ mdio ]
+then:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-9]+$":
+          if:
+            not:
+              required: [ ethernet ]
+          then:
+            required:
+              - phy-handle
+
 additionalProperties: true
 
 $defs:
diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cfd69c2604ea..ea7db0890abc 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek switches for unmanaged switches
 
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
-
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
@@ -95,37 +92,38 @@ properties:
       - '#address-cells'
       - '#interrupt-cells'
 
-  mdio:
-    $ref: /schemas/net/mdio.yaml#
-    unevaluatedProperties: false
-
-    properties:
-      compatible:
-        const: realtek,smi-mdio
-
-if:
-  required:
-    - reg
-
-then:
-  $ref: /schemas/spi/spi-peripheral-props.yaml#
-  not:
-    required:
-      - mdc-gpios
-      - mdio-gpios
-      - mdio
-
-  properties:
-    mdc-gpios: false
-    mdio-gpios: false
-    mdio: false
-
-else:
-  required:
-    - mdc-gpios
-    - mdio-gpios
-    - mdio
-    - reset-gpios
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+  - if:
+      required: [ mdio ]
+    then:
+      properties:
+        mdio:
+          properties:
+            compatible:
+              const: realtek,smi-mdio
+
+  - if:
+      required:
+        - reg
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+      not:
+        required:
+          - mdc-gpios
+          - mdio-gpios
+          - mdio
+
+      properties:
+        mdc-gpios: false
+        mdio-gpios: false
+        mdio: false
+    else:
+      required:
+        - mdc-gpios
+        - mdio-gpios
+        - mdio
+        - reset-gpios
 
 required:
   - compatible
-- 
2.39.2

