Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343507A2F80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjIPLLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbjIPLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:10:35 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148E19A;
        Sat, 16 Sep 2023 04:10:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91CB3240003;
        Sat, 16 Sep 2023 11:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgK1RR7PvoKyZDk0Jc59OCF7MxiLvtGydv7ioUqbT0Y=;
        b=jfHvHtuc+xqfSbVdGtke/CXe36aT3ln5BhveQlDrHTC4bUBcwnisulq7Nq5WitSm3y/Zro
        v8JuJhLWLr+P6UfJQfQBfkcldkNix/BAG7b5INH2Zo461XHQKOBuaLe6MPW8EfCvMimDe6
        esnrB0UDXQ23P3rmQZgIXkzecBbPtSgH+S/RokQbhJMm0/w4dI3Mqws6oIHcRuVm6z64UW
        kV1yltovhTPM93EnMDIBCf7n7vc0phIBwojsrPUnl76AEqrFIKhc1bte9p5fs+MkZjpUVY
        Lk084pAvydhldmDOQkS9YGPo7O/vNcPTmYi5hOvW9iFD/bqArjKLiqclwu8EJg==
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
Cc:     Woojung Huh <Woojung.Huh@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v2 03/10] dt-bindings: net: dsa: realtek: fix MDIO bus child node restrictions
Date:   Sat, 16 Sep 2023 14:08:55 +0300
Message-Id: <20230916110902.234273-4-arinc.unal@arinc9.com>
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

The MDIO controlled Realtek switches (distinguished by the reg property
being used) are allowed to have their MDIO bus registered OF-based. Allow
the mdio property for them.

Only the SMI controlled Realtek switches require the compatible property of
the mdio child node. Require it for them and disallow it for the MDIO controlled
ones.

Remove the unnecessary if:then:not:required rule and comments.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/net/dsa/realtek.yaml  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cfd69c2604ea..7eb025df0df8 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -109,18 +109,19 @@ if:
 
 then:
   $ref: /schemas/spi/spi-peripheral-props.yaml#
-  not:
-    required:
-      - mdc-gpios
-      - mdio-gpios
-      - mdio
-
   properties:
     mdc-gpios: false
     mdio-gpios: false
-    mdio: false
+    mdio:
+      properties:
+        compatible: false
 
 else:
+  properties:
+    mdio:
+      required:
+        - compatible
+
   required:
     - mdc-gpios
     - mdio-gpios
@@ -130,11 +131,6 @@ else:
 required:
   - compatible
 
-    #  - mdc-gpios
-    #  - mdio-gpios
-    #  - reset-gpios
-    #  - mdio
-
 unevaluatedProperties: false
 
 examples:
-- 
2.39.2

