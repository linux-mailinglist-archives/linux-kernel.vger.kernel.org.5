Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8184B80EBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbjLLM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLLM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:29:39 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7409A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:29:44 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A8B3C240028
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1702384181; bh=XK2o029UFWRLUtVZMifdlCezK2kjfe6cbAx2NwU/6DI=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=hFHrE6jmnoTzfrtLODa3H0mhc2HFou23qsyKLAETduwd1SPWsDptM7CJWqC/CfEZN
         0bUkRFAlsmqiWS8/YAJ/WVeasY4VAGXbOopRnGTyxEksjJsJYzWaCbOaUh0OCD4hoY
         erJAn09lxRAXgbM8LdMja/XIrQGlvGsDbvBzGdJmHSj1jaR5dYvjbLXdqdZ7OwqulH
         sqjSyLFkiPC0L0sIAt/k0DlBdyCyy0+kQoSyqjSXC7BGFIjPOY2PxMzyx+hEUcBsL/
         4wHIOfR4rHIm1DlGgvrubqVHOIrowfC5ZZ0hANcTlHWSwB9B4jfLyv5yuG6SUuOigc
         Ab52Zz/gRFOkg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SqHxC63NBz6tyQ;
        Tue, 12 Dec 2023 13:29:35 +0100 (CET)
From:   Anne Macedo <retpolanne@posteo.net>
Cc:     retpolanne@posteo.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: allwinner: Orange Pi One Plus PHY support
Date:   Tue, 12 Dec 2023 12:28:30 +0000
Message-ID: <20231212122835.10850-2-retpolanne@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds compatible values to mdio subnodes for Ethernet PHY representing
Realtek 8211 PHY to Orange Pi One Plus.

Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 29a081e72..7248ab72f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -37,7 +37,8 @@ &emac {
 
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+		compatible = "ethernet-phy-id001c.c915",
+			     "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 	};
 };
-- 
2.43.0

