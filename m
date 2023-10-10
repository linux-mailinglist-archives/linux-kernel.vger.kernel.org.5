Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F827C00AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjJJPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjJJPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:48:46 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 08:48:42 PDT
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D91F93;
        Tue, 10 Oct 2023 08:48:42 -0700 (PDT)
Received: from Vostro-3710.lan (unknown [58.61.141.228])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 5D8038000B0;
        Tue, 10 Oct 2023 23:38:21 +0800 (CST)
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
Subject: [PATCH 2/2] arm64: dts: allwinner: h616: update emac properties for Orange Pi Zero 3
Date:   Tue, 10 Oct 2023 23:38:12 +0800
Message-Id: <20231010153812.2869633-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010153812.2869633-1-amadeus@jmu.edu.cn>
References: <20231010153812.2869633-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUwfVkofTEgYQh5DTk4fH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPSlVJSUNZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b1a3d3885b03akuuu5d8038000b0
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6SBw*STw8LhASFhkrExpJ
        OhQaFBVVSlVKTUJNQk5JSEtJSU1PVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPSlVJSUNZV1kIAVlBSU5CTzcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the correct delay value to emac. Also add missing mdio
properties for the YT8531 PHY (clock output required).
With these changes, Ethernet now looks stable.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index 00fe28caac93..02c7836b624a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -13,10 +13,14 @@ / {
 };
 
 &emac0 {
+	allwinner,rx-delay-ps = <1800>;
+	allwinner,tx-delay-ps = <700>;
 	phy-supply = <&reg_dldo1>;
 };
 
 &ext_rgmii_phy {
+	motorcomm,keep-pll-enabled;
+	motorcomm,auto-sleep-disabled;
 	motorcomm,clk-out-frequency-hz = <125000000>;
 };
 
-- 
2.25.1

