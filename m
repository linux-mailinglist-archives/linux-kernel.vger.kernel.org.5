Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB87A2F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjIPLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbjIPLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:10:19 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B381B0;
        Sat, 16 Sep 2023 04:10:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6EE8240004;
        Sat, 16 Sep 2023 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCVsSCUqr94fHC72W488TJM9Q7uBl3U9XOpO5b6zFkI=;
        b=HFsOWmhU1AcmLExDDgGw+IVR7jUbH2dKOYbsQSzyL2/Y3HtO7H7t2hWrEwTraBnNLF4Hmd
        2wzXQfuG7cx4+RvoIVZhkyP+aeXXfN7BObZ+w6LTHTSTFxSbHSrbKHPzWN5tPE8TM2pjZ2
        5B1Hm1Ud+TRTYf16+hrsWr7H2DJn0AUeMfLqf8nGWVsGuak+TQeE12kxIcBCofOtG3lBti
        fEZjgT02/ye1we3qf17VcgXSc2jHSC9TwLnI0cn4RK4BOmqFNUc7rEX0NyZZs6D3LzKXNa
        ex0TJsVceQFcxXb2dkoH1PrA/YI1y1xZ8Erzqp1WhvnGaQJCYh4uJ4UdoYU42Q==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Crispin <john@phrozen.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v2 02/10] dt-bindings: net: dsa: microchip,lan937x: add missing ethernet on example
Date:   Sat, 16 Sep 2023 14:08:54 +0300
Message-Id: <20230916110902.234273-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230916110902.234273-1-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
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

The port@5 node on the example is supposed to be used as a CPU port. Add
the missing ethernet property and remove the label property. Remove the MAC
bindings on the example as they cannot be validated.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/dsa/microchip,lan937x.yaml          | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 8d7e878b84dc..d187034fb31a 100644
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
@@ -134,10 +124,10 @@ examples:
 
                             port@5 {
                                     reg = <5>;
-                                    label = "lan7";
                                     phy-mode = "rgmii";
                                     tx-internal-delay-ps = <2000>;
                                     rx-internal-delay-ps = <2000>;
+                                    ethernet = <&macb1>;
 
                                     fixed-link {
                                             speed = <1000>;
-- 
2.39.2

