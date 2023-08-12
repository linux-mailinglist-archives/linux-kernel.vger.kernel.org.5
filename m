Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673EA779E74
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjHLJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjHLJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:17:25 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E219A3;
        Sat, 12 Aug 2023 02:17:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61E701BF206;
        Sat, 12 Aug 2023 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691831847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voAtLXmLl9r79y4j5NbdVi9awaISDF1Sa79XgocDMGs=;
        b=kncA3e3JiQcrxoNOJ4hUbNZOZ3oAl04PNDSloDgEq6cUb5Lz4IoUQ9aW5yKUf2sozSK2oS
        zCvZWVOPPWPvljoxiw2YsHG7n6yaRAV/tngrRQk8UPt89kXCuBjos1klD8u19jgy7VMBiQ
        yQMiIOWrMpUmDmdnkHLX10sBb3L24hCQ1vMUFQjdMMM3zn2wTGyR2EOvqsg0iRD6oFaoMI
        JTEvNqHIt7kqdk+TqXyd4ux+xMhZWq43eyeDutFTcDxvw+zydqUZRL8kKc9UUONIy2S4jL
        6sJoaBMHMt3cJjHgB72OdUHSHcEXNKZ4g4uheAbakfY5RqOy4usqR4iiGolCYQ==
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
Subject: [PATCH 1/4] dt-bindings: net: dsa: microchip,lan937x: add missing ethernet on example
Date:   Sat, 12 Aug 2023 12:17:05 +0300
Message-Id: <20230812091708.34665-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812091708.34665-1-arinc.unal@arinc9.com>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port@5 node on the example is missing the ethernet property. Add it.
Remove the MAC bindings on the example as they cannot be validated.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../bindings/net/dsa/microchip,lan937x.yaml           | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 8d7e878b84dc..49af4b0d5916 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
@@ -68,16 +68,6 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
-    macb0 {
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            fixed-link {
-                    speed = <1000>;
-                    full-duplex;
-            };
-    };
-
     spi {
             #address-cells = <1>;
             #size-cells = <0>;
@@ -138,6 +128,7 @@ examples:
                                     phy-mode = "rgmii";
                                     tx-internal-delay-ps = <2000>;
                                     rx-internal-delay-ps = <2000>;
+                                    ethernet = <&macb1>;
 
                                     fixed-link {
                                             speed = <1000>;
-- 
2.39.2

