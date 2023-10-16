Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611377CB589
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjJPVp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjJPVpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:45:05 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C61F189;
        Mon, 16 Oct 2023 14:44:58 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-581cb88f645so180407eaf.1;
        Mon, 16 Oct 2023 14:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492697; x=1698097497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSTNCx96ijN7xDd+L1blp4PP7h+p+AqB5mCYZJB4VZ8=;
        b=vf6m29PJYME4P7l3Q2JgZ1iajOF//5aOpP3BLnjp+ar4iWZAIgYzEV0AtbRDUkUuPf
         mbf1gPbBtXMyaC435p1V18hMeCBdgkeB7guCWuaMvlgEM5HhXPAXebcXgboNveE8UbxV
         0pKQkkd0oBu4RIToQkHCnjf15QiAObpD1riV/yt+LcrcU3dKxfJtp+bWmYuqC3c0+gig
         N5pdiX1TEqE+YWlyr7YVxjhrdWCeLwcLc+2H7x21qXiTKLDzz2f6ZT8C9LmVM/eMNwBv
         ruqS7cG7YwR78eP1IKYzig5TT4LuwpAG/FpcNc6rRLdWBmxaOADXUKqh/719Y2Q5QN/P
         9uIg==
X-Gm-Message-State: AOJu0Yz5sBuDgOHFwXe4i71Hefj7jAaeBHq57vItjBxtSb3oylatr/XU
        B03ZRhHBpQJnJvakAOuCWA==
X-Google-Smtp-Source: AGHT+IEVE6nFcat2AUCk/HtDxiQnH8SCWVk1YkotfqbKD8WxuVGs5L+W66rn7BVzGf/8xA7s3Ce/Cw==
X-Received: by 2002:a4a:d757:0:b0:57b:6a40:8a9e with SMTP id h23-20020a4ad757000000b0057b6a408a9emr284863oot.7.1697492697094;
        Mon, 16 Oct 2023 14:44:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r3-20020a4ab503000000b0057ae5a8e9bcsm16111ooo.28.2023.10.16.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:44:56 -0700 (PDT)
Received: (nullmailer pid 3823212 invoked by uid 1000);
        Mon, 16 Oct 2023 21:44:35 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Oct 2023 16:44:21 -0500
Subject: [PATCH net-next 2/8] dt-bindings: net: renesas: Drop ethernet-phy
 node schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-dt-net-cleanups-v1-2-a525a090b444@kernel.org>
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

What's connected on the MDIO bus is outside the scope of the binding for
ethernet controller's MDIO bus unless it's a fixed internal device, so
drop the node name and reference to ethernet-phy.yaml.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/renesas,ether.yaml    | 3 +--
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ether.yaml b/Documentation/devicetree/bindings/net/renesas,ether.yaml
index 06b38c9bc6ec..29355ab98569 100644
--- a/Documentation/devicetree/bindings/net/renesas,ether.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,ether.yaml
@@ -81,9 +81,8 @@ properties:
       active-high
 
 patternProperties:
-  "^ethernet-phy@[0-9a-f]$":
+  "@[0-9a-f]$":
     type: object
-    $ref: ethernet-phy.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 3f41294f5997..5d074f27d462 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -109,9 +109,8 @@ properties:
     enum: [0, 2000]
 
 patternProperties:
-  "^ethernet-phy@[0-9a-f]$":
+  "@[0-9a-f]$":
     type: object
-    $ref: ethernet-phy.yaml#
 
 required:
   - compatible

-- 
2.42.0

