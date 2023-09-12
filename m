Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656DA79C626
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjILFG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjILFGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:06:45 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2105FE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:55:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qfvQV-00040k-BA; Tue, 12 Sep 2023 06:55:03 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qfvQT-005hVo-JV; Tue, 12 Sep 2023 06:55:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qfvQS-007owQ-34;
        Tue, 12 Sep 2023 06:55:00 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v4 1/2] dt-bindings: net: dsa: microchip: Update ksz device tree bindings for drive strength
Date:   Tue, 12 Sep 2023 06:54:58 +0200
Message-Id: <20230912045459.1864085-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045459.1864085-1-o.rempel@pengutronix.de>
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend device tree bindings to support drive strength configuration for the
ksz* switches. Introduced properties:
- microchip,hi-drive-strength-microamp: Controls the drive strength for
  high-speed interfaces like GMII/RGMII and more.
- microchip,lo-drive-strength-microamp: Governs the drive strength for
  low-speed interfaces such as LEDs, PME_N, and others.
- microchip,io-drive-strength-microamp: Controls the drive strength for
  for undocumented Pads on KSZ88xx variants.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/dsa/microchip,ksz.yaml       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 03b5567be3897..41014f5c01c42 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -49,6 +49,26 @@ properties:
       Set if the output SYNCLKO clock should be disabled. Do not mix with
       microchip,synclko-125.
 
+  microchip,io-drive-strength-microamp:
+    description:
+      IO Pad Drive Strength
+    enum: [8000, 16000]
+    default: 16000
+
+  microchip,hi-drive-strength-microamp:
+    description:
+      High Speed Drive Strength. Controls drive strength of GMII / RGMII /
+      MII / RMII (except TX_CLK/REFCLKI, COL and CRS) and CLKO_25_125 lines.
+    enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
+    default: 24000
+
+  microchip,lo-drive-strength-microamp:
+    description:
+      Low Speed Drive Strength. Controls drive strength of TX_CLK / REFCLKI,
+      COL, CRS, LEDs, PME_N, NTRP_N, SDO and SDI/SDA/MDIO lines.
+    enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
+    default: 8000
+
   interrupts:
     maxItems: 1
 
-- 
2.39.2

