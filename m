Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5972D7CB579
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjJPVo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjJPVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:44:52 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33496AC;
        Mon, 16 Oct 2023 14:44:50 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3af608eb34bso3141374b6e.1;
        Mon, 16 Oct 2023 14:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492689; x=1698097489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjGwCRfeJ6jyUkUfij15uJxe6Br0BrgfpLSpLSGPlOQ=;
        b=qOUv+KLTDvJAV9s3tT6OVQBoQC6q01XK8pSkRiJ0+srqDTcqpU9WXljJ9oRVzj1FiC
         J/qc2SrR/k851nuTHhxWVxz1Jbxmf0u2I0XTP3JN9XMBvOd1W/4JSVISSBiBKtnCaOom
         zuB3fXNj2UQ3/QaTx0QgSywtVwHS9Yq5K191vKKR63KnvZsaGBt/wIAvEmfW8HB1EOWz
         QHpJ+s2IFnmq9fry2JIS28PzlMj157a7rEQFRM7SUTUX1uVIaBuOkZ7rMc5tsG0ZiVGh
         yXNXFqD7wMBC7CX/ketAKJnItbEyvkbnlxKcTmgOCcQPv9l7qNn4TSeQNRhg1+Nj9pyf
         NuKQ==
X-Gm-Message-State: AOJu0Ywg0C4dtVgfUb2J5vcOO/7d1ll0UCqBKPmxA7E0cf6YeFKGoHG5
        N1ma8tMsm9zDETb6uqwW/g==
X-Google-Smtp-Source: AGHT+IG+MUFDErrTfJWVkRN5eb91KPhnPO15E/39mPn136AxbnLR+bGvAhs0Li2tuR7K6Spxnt7dpA==
X-Received: by 2002:a54:478c:0:b0:3a8:80ea:f0c6 with SMTP id o12-20020a54478c000000b003a880eaf0c6mr591052oic.29.1697492689379;
        Mon, 16 Oct 2023 14:44:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a05680801ca00b003adfc72ed20sm31622oic.17.2023.10.16.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:44:48 -0700 (PDT)
Received: (nullmailer pid 3823210 invoked by uid 1000);
        Mon, 16 Oct 2023 21:44:35 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Oct 2023 16:44:20 -0500
Subject: [PATCH net-next 1/8] dt-bindings: net: Add missing
 (unevaluated|additional)Properties on child node schemas
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
In-Reply-To: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        John Crispin <john@phrozen.org>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Add unevaluatedProperties or additionalProperties as appropriate.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml     |  2 ++
 Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml        |  1 +
 Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml |  2 ++
 .../devicetree/bindings/net/dsa/microchip,lan937x.yaml         |  1 +
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml     |  2 ++
 Documentation/devicetree/bindings/net/dsa/qca8k.yaml           |  1 +
 Documentation/devicetree/bindings/net/dsa/realtek.yaml         |  2 ++
 .../devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml        | 10 ++--------
 Documentation/devicetree/bindings/net/engleder,tsnep.yaml      |  1 +
 Documentation/devicetree/bindings/net/nxp,tja11xx.yaml         |  1 +
 10 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 4bfac9186886..7fe0352dff0f 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -158,6 +158,8 @@ allOf:
               patternProperties:
                 "^ethernet-phy@[0-9a-f]$":
                   type: object
+                  $ref: ethernet-phy.yaml#
+                  unevaluatedProperties: false
                   description:
                     Integrated PHY node
 
diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
index b06c416893ff..f21bdd0f408d 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
@@ -78,6 +78,7 @@ properties:
 
   ports:
     type: object
+    additionalProperties: true
 
     patternProperties:
       '^port@[0-9a-f]$':
diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index e532c6b795f4..20f7ba4e2203 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -154,10 +154,12 @@ properties:
 patternProperties:
   "^(ethernet-)?ports$":
     type: object
+    additionalProperties: true
 
     patternProperties:
       "^(ethernet-)?port@[0-9]+$":
         type: object
+        additionalProperties: true
 
         properties:
           reg:
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 8d7e878b84dc..6a4d90d550b6 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
@@ -37,6 +37,7 @@ properties:
 
 patternProperties:
   "^(ethernet-)?ports$":
+    additionalProperties: true
     patternProperties:
       "^(ethernet-)?port@[0-9]+$":
         allOf:
diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 4d5f5cc6d031..d179c6971193 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -43,6 +43,7 @@ properties:
   # PHY 1.
   mdios:
     type: object
+    additionalProperties: false
 
     properties:
       '#address-cells':
@@ -74,6 +75,7 @@ properties:
 
 patternProperties:
   "^(ethernet-)?ports$":
+    additionalProperties: true
     patternProperties:
       "^(ethernet-)?port@[0-9]+$":
         allOf:
diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
index df64eebebe18..167398ab253a 100644
--- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
@@ -73,6 +73,7 @@ $ref: dsa.yaml#
 patternProperties:
   "^(ethernet-)?ports$":
     type: object
+    additionalProperties: true
     patternProperties:
       "^(ethernet-)?port@[0-6]$":
         type: object
diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cfd69c2604ea..cce692f57b08 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -68,6 +68,8 @@ properties:
 
   interrupt-controller:
     type: object
+    additionalProperties: false
+
     description: |
       This defines an interrupt controller with an IRQ line (typically
       a GPIO) that will demultiplex and handle the interrupt from the single
diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
index 833d2f68daa1..ea285ef3e64f 100644
--- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
@@ -61,17 +61,11 @@ properties:
 
   ethernet-ports:
     type: object
-    properties:
-      '#address-cells':
-        const: 1
-      '#size-cells':
-        const: 0
-
+    additionalProperties: true
     patternProperties:
       "^(ethernet-)?port@[0-4]$":
         type: object
-        description: Ethernet switch ports
-
+        additionalProperties: true
         properties:
           pcs-handle:
             maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/engleder,tsnep.yaml b/Documentation/devicetree/bindings/net/engleder,tsnep.yaml
index 82a5d7927ca4..34fd24ff6a71 100644
--- a/Documentation/devicetree/bindings/net/engleder,tsnep.yaml
+++ b/Documentation/devicetree/bindings/net/engleder,tsnep.yaml
@@ -63,6 +63,7 @@ properties:
   mdio:
     type: object
     $ref: mdio.yaml#
+    unevaluatedProperties: false
     description: optional node for embedded MDIO controller
 
 required:
diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index ab8867e6939b..85bfa45f5122 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -20,6 +20,7 @@ allOf:
 patternProperties:
   "^ethernet-phy@[0-9a-f]+$":
     type: object
+    additionalProperties: false
     description: |
       Some packages have multiple PHYs. Secondary PHY should be defines as
       subnode of the first (parent) PHY.

-- 
2.42.0

