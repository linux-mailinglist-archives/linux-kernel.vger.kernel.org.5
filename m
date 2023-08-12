Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9793E77A1F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHLTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHLTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:20:57 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50420171C;
        Sat, 12 Aug 2023 12:20:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3BB020003;
        Sat, 12 Aug 2023 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691868054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkvIeEIu6KR1GNaowX9Ez01iP6cp+XBEoN9CzarUDNI=;
        b=Z44QQ+NMyTrkAMd5+WdShG3UQgUDqOsYRBVYh3dg4JSR4bYRvtYrf5mEbcUS9/BHn2n9X/
        VfFOu4fXu0YFA9f5L92DXzVQo1Hm6C0WRESIeigYjJSAwzfxTPWEt/qRf1E3PbORJXbcT/
        7zV+rCBEUZ+bCff7UH6DAiFC5/qJuZl0MWjaCdukqc8V+1IoylI7y4dpldjsZLVvzoYbRB
        gjLSXp0IXE/wASIR86ByyM7dIfCTT8jszZYJpvHSQQegQnKIYOxvmz54UZJIfv4Kwvwjlv
        /tqmwzheXWMg6RYok0aW31hi+2M2IQ/JTmbm3KLRwqcymiAbjnpN3NqQ93fKWA==
Message-ID: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
Date:   Sat, 12 Aug 2023 22:20:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
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
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
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
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
Content-Language: en-US
In-Reply-To: <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've realised there are more schemas that extend the mdio.yaml schema. This
is the final state of this patch.

dt-bindings: net: dsa: document internal MDIO bus

Add the schema to document the internal MDIO bus. Require the phy-handle
property on the non-CPU ports if the mdio property is being used.

Define the mdio property on all of the schemas that refer to
dsa.yaml#/$defs/ethernet-ports. Refer to dsa.yaml#/properties/mdio to point
the human readers to the description on the dsa.yaml schema.

Some of these schemas extend the mdio.yaml schema. The mdio.yaml schema is
also being referred to through dsa.yaml#/$defs/ethernet-ports now which
means we cannot disallow additional properties by 'unevaluatedProperties:
false' on the dsa.yaml schema.

---
  .../bindings/net/dsa/arrow,xrs700x.yaml        |  4 ++++
  .../devicetree/bindings/net/dsa/brcm,b53.yaml  |  4 ++++
  .../devicetree/bindings/net/dsa/brcm,sf2.yaml  |  4 ++++
  .../devicetree/bindings/net/dsa/dsa.yaml       | 18 ++++++++++++++++++
  .../bindings/net/dsa/hirschmann,hellcreek.yaml |  4 ++++
  .../bindings/net/dsa/mediatek,mt7530.yaml      |  4 ++++
  .../bindings/net/dsa/microchip,ksz.yaml        |  4 ++++
  .../bindings/net/dsa/microchip,lan937x.yaml    |  2 +-
  .../bindings/net/dsa/mscc,ocelot.yaml          |  4 ++++
  .../bindings/net/dsa/nxp,sja1105.yaml          |  4 ++++
  .../devicetree/bindings/net/dsa/qca8k.yaml     |  2 +-
  .../devicetree/bindings/net/dsa/realtek.yaml   |  2 +-
  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml   |  2 +-
  13 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml b/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
index 9565a740214629..f0229352e05694 100644
--- a/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
@@ -29,6 +29,10 @@ properties:
    reg:
      maxItems: 1
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  required:
    - compatible
    - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
index 4c78c546343f5e..e14562b33bfb97 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
@@ -65,6 +65,10 @@ properties:
                - brcm,bcm63268-switch
            - const: brcm,bcm63xx-switch
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  required:
    - compatible
    - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
index c745407f2f6853..1bf4317e038687 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
@@ -90,6 +90,10 @@ properties:
                tags enabled (per-packet metadata)
              type: boolean
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  required:
    - reg
    - interrupts
diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index ec74a660bedaed..03ccedbc49dcc3 100644
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
diff --git a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
index 4021b054f68446..32f17345825d4a 100644
--- a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
@@ -67,6 +67,10 @@ properties:
  
      additionalProperties: false
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  required:
    - compatible
    - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index e532c6b795f4fc..293d1affe75451 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -151,6 +151,10 @@ properties:
        ethsys.
      maxItems: 1
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  patternProperties:
    "^(ethernet-)?ports$":
      type: object
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index e51be1ac036237..01d11c642ecfd4 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -49,6 +49,10 @@ properties:
        Set if the output SYNCLKO clock should be disabled. Do not mix with
        microchip,synclko-125.
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  required:
    - compatible
    - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 49af4b0d591695..15f24a1716cd44 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
@@ -32,7 +32,7 @@ properties:
      maxItems: 1
  
    mdio:
-    $ref: /schemas/net/mdio.yaml#
+    $ref: dsa.yaml#/properties/mdio
      unevaluatedProperties: false
  
  patternProperties:
diff --git a/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml b/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
index fe02d05196e4a6..d781b8c2324836 100644
--- a/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
@@ -73,6 +73,10 @@ properties:
    little-endian: true
    big-endian: true
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  required:
    - compatible
    - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 4d5f5cc6d031e2..82dda8fae8b16e 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -72,6 +72,10 @@ properties:
            - compatible
            - reg
  
+  mdio:
+    $ref: dsa.yaml#/properties/mdio
+    unevaluatedProperties: false
+
  patternProperties:
    "^(ethernet-)?ports$":
      patternProperties:
diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
index df64eebebe1856..001b72bcd0746b 100644
--- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
@@ -60,7 +60,7 @@ properties:
        B68 on the QCA832x and B49 on the QCA833x.
  
    mdio:
-    $ref: /schemas/net/mdio.yaml#
+    $ref: dsa.yaml#/properties/mdio
      unevaluatedProperties: false
      description: Qca8k switch have an internal mdio to access switch port.
                   If this is not present, the legacy mapping is used and the
diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cfd69c2604ea39..f4b4fe0509a022 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -96,7 +96,7 @@ properties:
        - '#interrupt-cells'
  
    mdio:
-    $ref: /schemas/net/mdio.yaml#
+    $ref: dsa.yaml#/properties/mdio
      unevaluatedProperties: false
  
      properties:
diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
index 833d2f68daa144..c58c4ec8613ac1 100644
--- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
@@ -46,7 +46,7 @@ properties:
      maxItems: 1
  
    mdio:
-    $ref: /schemas/net/mdio.yaml#
+    $ref: dsa.yaml#/properties/mdio
      unevaluatedProperties: false
  
    clocks:

The nxp,sja1105.yaml schema also needed some changes.

dt-bindings: net: dsa: nxp,sja1105: improve internal MDIO bus bindings

SJA1110 Ethernet Switch uses the mdios property for its internal MDIO bus.
Therefore, disallow the mdios property for SJA1105, and the mdio property
for SJA1110.

Require the phy-handle property on the non-CPU ports if the mdios property
is being used.

Refer to dsa.yaml#/properties/mdio to point the human readers to the
description on the dsa.yaml schema.

---
  .../bindings/net/dsa/nxp,sja1105.yaml         | 20 ++++++++++++++++++-
  1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 82dda8fae8b16e..7d92350f1065b2 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -52,7 +52,7 @@ properties:
  
      patternProperties:
        "^mdio@[0-1]$":
-        $ref: /schemas/net/mdio.yaml#
+        $ref: dsa.yaml#/properties/mdio
          unevaluatedProperties: false
  
          properties:
@@ -128,14 +128,32 @@ allOf:
      then:
        properties:
          spi-cpol: false
+        mdios: false
+
        required:
          - spi-cpha
      else:
        properties:
          spi-cpha: false
+        mdio: false
+
        required:
          - spi-cpol
  
+  - if:
+      required: [ mdios ]
+    then:
+      patternProperties:
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-9]+$":
+              if:
+                not:
+                  required: [ ethernet ]
+              then:
+                required:
+                  - phy-handle
+
  unevaluatedProperties: false
  
  examples:

Arınç

On 12.08.2023 19:28, Arınç ÜNAL wrote:
> I changed this to below. I will wait for reviews before submitting v2.
> 
> The realtek.yaml schema extends the mdio.yaml schema. The mdio.yaml schema
> is also being referred to through dsa.yaml#/$defs/ethernet-ports now which
> means we cannot disallow additional properties by 'unevaluatedProperties:
> false' on the dsa.yaml schema.
> 
> On the realtek.yaml schema, refer to dsa.yaml#/properties/mdio instead to
> point the human readers to the description on the dsa.yaml schema.
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> index ec74a660beda..03ccedbc49dc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> @@ -31,6 +31,24 @@ properties:
>         (single device hanging off a CPU port) must not specify this property
>       $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> +  mdio:
> +    description: The internal MDIO bus of the switch
> +    $ref: /schemas/net/mdio.yaml#
> +
> +if:
> +  required: [ mdio ]
> +then:
> +  patternProperties:
> +    "^(ethernet-)?ports$":
> +      patternProperties:
> +        "^(ethernet-)?port@[0-9]+$":
> +          if:
> +            not:
> +              required: [ ethernet ]
> +          then:
> +            required:
> +              - phy-handle
> +
>   additionalProperties: true
> 
>   $defs:
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index cfd69c2604ea..f4b4fe0509a0 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -96,7 +96,7 @@ properties:
>         - '#interrupt-cells'
> 
>     mdio:
> -    $ref: /schemas/net/mdio.yaml#
> +    $ref: dsa.yaml#/properties/mdio
>       unevaluatedProperties: false
> 
>       properties:
> 
> Arınç
