Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68B17C00B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjJJPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjJJPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:48:47 -0400
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56797;
        Tue, 10 Oct 2023 08:48:44 -0700 (PDT)
Received: from Vostro-3710.lan (unknown [58.61.141.228])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 5E3D38000AE;
        Tue, 10 Oct 2023 23:38:20 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/2] arm64: dts: allwinner: h616: move emac delay back to Orange Pi Zero 2 DT
Date:   Tue, 10 Oct 2023 23:38:11 +0800
Message-Id: <20231010153812.2869633-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTBlIVkgZHUtMTUgYHR5KGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPSlVJSUNZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b1a3d34a8b03akuuu5e3d38000ae
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Tio4Azw*SRAJPCJCEz0B
        TRkKFAtVSlVKTUJNQk5JSEtKSEpDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPSlVJSUNZV1kIAVlBSUNDSzcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current emac delay value is not suitable for Orange Pi
Zero 3, move it back to Orange Pi Zero 2 DT.

Fixes: 322bf103204b ("arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
index 15290e6892fc..02a4776c9f2b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
@@ -70,8 +70,6 @@ &emac0 {
 	pinctrl-0 = <&ext_rgmii_pins>;
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
-	allwinner,rx-delay-ps = <3100>;
-	allwinner,tx-delay-ps = <700>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
index d83852e72f06..84daa309893b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -13,6 +13,8 @@ / {
 };
 
 &emac0 {
+	allwinner,rx-delay-ps = <3100>;
+	allwinner,tx-delay-ps = <700>;
 	phy-supply = <&reg_dcdce>;
 };
 
-- 
2.25.1

