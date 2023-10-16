Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2B7CB571
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjJPVos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjJPVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:44:44 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B572D9;
        Mon, 16 Oct 2023 14:44:42 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e562706d29so2799871fac.2;
        Mon, 16 Oct 2023 14:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492681; x=1698097481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BhNqPjC35KssOVWym22Xm+PXqXG2BALMex6wzlPMLg=;
        b=gDR5nFrJmrH85E5yZSZz4MrBw3FnA2s0KBvDtwfHHeab/VRkGsQPSB81XemjBqyPoR
         mQfLJ1DbIJB3fbuC/aunfSC2lY6kGyFEE+7Cgp+v2FfRk8vKteRN+pNLVNkOHIOsDVKW
         UFqx5nJK703bwPfSG7/cRMOh6BzrPw/hW4OG1RFV1LVXNOAjBcj9Sc6VsWPiCKGFXHnU
         TfuAvDTeUv37bbMpiHi5XmNmP0gXmuFi/M6/Dbb9dllEDSynOjB9I2BuNEspLt23KY8i
         TWw7qkf4GIX41reGabcs2sP0DD86rS7Bea+kOIp8LRkjS8l/IjpVZcA0vAo1qbQRhVG1
         6ijA==
X-Gm-Message-State: AOJu0YwUqp7VHc2uFVW3GYW7FkR3i1vt2CWkSUtHRSeMdZAEE+uZeZ5B
        DnfEpCiWoYGNu4hLXAnIPw==
X-Google-Smtp-Source: AGHT+IHELa3QHrlqv0npdH8PwKmFcvXksdJa9jP/xfBiEmi6ssht9Ijd5bifDAScNBAJ1b9VgjfDuQ==
X-Received: by 2002:a05:6870:110f:b0:1e9:a248:b1b3 with SMTP id 15-20020a056870110f00b001e9a248b1b3mr277337oaf.49.1697492681546;
        Mon, 16 Oct 2023 14:44:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cb20-20020a056871e11400b001ea17894928sm8906oac.21.2023.10.16.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:44:40 -0700 (PDT)
Received: (nullmailer pid 3823214 invoked by uid 1000);
        Mon, 16 Oct 2023 21:44:35 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Oct 2023 16:44:22 -0500
Subject: [PATCH net-next 3/8] dt-bindings: net: dsa/switch: Make
 'ethernet-port' node addresses hex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>
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
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ethernet-port' node unit-addresses should be in hexadecimal. Some
instances have it correct, but fix the ones that don't.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml         | 2 +-
 Documentation/devicetree/bindings/net/dsa/dsa.yaml               | 2 +-
 Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml   | 6 +++---
 Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml | 2 +-
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml       | 2 +-
 Documentation/devicetree/bindings/net/ethernet-switch.yaml       | 4 ++--
 Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml        | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
index aa3162c74833..75d8138298fb 100644
--- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
@@ -53,7 +53,7 @@ properties:
         const: 0
 
     patternProperties:
-      "^port@[0-9]+$":
+      "^port@[0-9a-f]+$":
         type: object
 
         $ref: ethernet-controller.yaml#
diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index ec74a660beda..e6010821f86f 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -50,7 +50,7 @@ $defs:
             const: 0
 
         patternProperties:
-          "^(ethernet-)?port@[0-9]+$":
+          "^(ethernet-)?port@[0-9a-f]+$":
             description: Ethernet switch ports
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 20f7ba4e2203..5038818e9f2e 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -157,7 +157,7 @@ patternProperties:
     additionalProperties: true
 
     patternProperties:
-      "^(ethernet-)?port@[0-9]+$":
+      "^(ethernet-)?port@[0-6]$":
         type: object
         additionalProperties: true
 
@@ -186,7 +186,7 @@ $defs:
     patternProperties:
       "^(ethernet-)?ports$":
         patternProperties:
-          "^(ethernet-)?port@[0-9]+$":
+          "^(ethernet-)?port@[0-6]$":
             if:
               required: [ ethernet ]
             then:
@@ -212,7 +212,7 @@ $defs:
     patternProperties:
       "^(ethernet-)?ports$":
         patternProperties:
-          "^(ethernet-)?port@[0-9]+$":
+          "^(ethernet-)?port@[0-6]$":
             if:
               required: [ ethernet ]
             then:
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 6a4d90d550b6..9973d64f15a7 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
@@ -39,7 +39,7 @@ patternProperties:
   "^(ethernet-)?ports$":
     additionalProperties: true
     patternProperties:
-      "^(ethernet-)?port@[0-9]+$":
+      "^(ethernet-)?port@[0-7]$":
         allOf:
           - if:
               properties:
diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index d179c6971193..9432565f4f5d 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -77,7 +77,7 @@ patternProperties:
   "^(ethernet-)?ports$":
     additionalProperties: true
     patternProperties:
-      "^(ethernet-)?port@[0-9]+$":
+      "^(ethernet-)?port@[0-9]$":
         allOf:
           - if:
               properties:
diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
index f1b9075dc7fb..dcbffe19d71a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
@@ -36,7 +36,7 @@ patternProperties:
         const: 0
 
     patternProperties:
-      "^(ethernet-)?port@[0-9]+$":
+      "^(ethernet-)?port@[0-9a-f]+$":
         type: object
         description: Ethernet switch ports
 
@@ -58,7 +58,7 @@ $defs:
     $ref: '#'
 
     patternProperties:
-      "^(ethernet-)?port@[0-9]+$":
+      "^(ethernet-)?port@[0-9a-f]+$":
         description: Ethernet switch ports
         $ref: ethernet-switch-port.yaml#
         unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
index b04ac4966608..f07ae3173b03 100644
--- a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
@@ -86,7 +86,7 @@ properties:
         const: 0
 
     patternProperties:
-      "^port@[0-9]+$":
+      "^port@[12]$":
         type: object
         description: CPSW external ports
 

-- 
2.42.0

