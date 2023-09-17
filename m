Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6327A3530
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjIQKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjIQKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:38:19 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16646189;
        Sun, 17 Sep 2023 03:38:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DAAF60008;
        Sun, 17 Sep 2023 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694947091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b9jlP+QMwX9cNjlMgnqdJZg9rK01wAc9gTFIwnzsuzg=;
        b=nHTzyZ2EcVd9psF16qt1mZ8cCRB6QinrWTD+DAM75wicxUhCkBBMPSgTP/6EPNRnm3SmGS
        7BsoC8FlvsQ5yNFBmLQvLap/v9r+JSMR4PGgUTSHLuYugQeoUuVDrZw1DfnIWdEI1M1ama
        dkV5HQ3bKD/oJkyKI0bkMhic6GydiLVrh7b/ygrOtAUGyfOyCWQJKPZGo5O89Bo8/SoNDw
        BWhIQP8Yx2f124OEBk+LWTObUlMRCWfh4/y4EPx5HYnOy9521x/YwVEeAuFqOMHtMDH+oC
        DAkoGBZZyBPHhnPrvPbK0NTaEtsMVfxUqAjWt/xmISha1ASfUqlyTqmTjrWl5g==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mips: dts: ralink: mt7621: define each reset as an item
Date:   Sun, 17 Sep 2023 13:37:53 +0300
Message-Id: <20230917103753.52644-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Each item of the resets property should define a reset. Split the item with
two resets on the ethernet node into two separate items.

Sort the items of the clocks property to the same line as a trivial change.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 7caed0d14f11..35a10258f235 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -300,14 +300,13 @@ ethernet: ethernet@1e100000 {
 		compatible = "mediatek,mt7621-eth";
 		reg = <0x1e100000 0x10000>;
 
-		clocks = <&sysc MT7621_CLK_FE>,
-			 <&sysc MT7621_CLK_ETH>;
+		clocks = <&sysc MT7621_CLK_FE>, <&sysc MT7621_CLK_ETH>;
 		clock-names = "fe", "ethif";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		resets = <&sysc MT7621_RST_FE &sysc MT7621_RST_ETH>;
+		resets = <&sysc MT7621_RST_FE>, <&sysc MT7621_RST_ETH>;
 		reset-names = "fe", "eth";
 
 		interrupt-parent = <&gic>;
-- 
2.39.2

