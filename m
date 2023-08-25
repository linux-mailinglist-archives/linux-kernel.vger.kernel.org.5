Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72497881F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjHYIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjHYIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:19:58 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E3B1FDB;
        Fri, 25 Aug 2023 01:19:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10C1A40006;
        Fri, 25 Aug 2023 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692951592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Roi4EEueh61VDbRVdwO7Fm8Ng6DZ5HRcC6E6QZQcE4=;
        b=dFziPC9wzadZ0Ip8bOanp7q5OIqBs2y9+4k88f9+SWpJBDIJVUJ1XABfn6khVpPwMedINP
        17NWU3MZndfG6WsKkx7UNutHJIpmcgOemt/DzKQ+oDLJLkEnxLDecgI5v+9pWdwFmzi3L5
        vl70CiXbumiWdhkAewRgRQ/27IGvosmS2YCxLmeTdAzyCQjQJRBcHeQDhuFRxB7ayzI8pQ
        Bn3LGEY1OeSLcATvtcJb25j4usnuOq77sEqBivkbfEI10ztmC8f1Sw31l28P4SIQQAiexl
        +R0AN5vqwI0qn0w1rXQGFZkSw9o7qQ7ZePzAAYAJvCkErXH/mECYBlOadU7o4g==
From:   =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        airat.gl@gmail.com
Subject: [PATCH net] dt-bindings: net: dsa: marvell: fix wrong model in compatibility list
Date:   Fri, 25 Aug 2023 10:20:27 +0200
Message-ID: <20230825082027.18773-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Fix wrong switch name in compatibility list. 88E6163 switch does not exist
and is in fact 88E6361

Fixes: 9229a9483d80 ("dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility list")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 Documentation/devicetree/bindings/net/dsa/marvell.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
index 33726134f5c9..6ec0c181b6db 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
@@ -20,7 +20,7 @@ which is at a different MDIO base address in different switch families.
 			  6171, 6172, 6175, 6176, 6185, 6240, 6320, 6321,
 			  6341, 6350, 6351, 6352
 - "marvell,mv88e6190"	: Switch has base address 0x00. Use with models:
-			  6163, 6190, 6190X, 6191, 6290, 6390, 6390X
+			  6190, 6190X, 6191, 6290, 6361, 6390, 6390X
 - "marvell,mv88e6250"	: Switch has base address 0x08 or 0x18. Use with model:
 			  6220, 6250
 
-- 
2.41.0

