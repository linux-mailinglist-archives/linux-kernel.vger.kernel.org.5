Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF01E7E3E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjKGMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjKGMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:32:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6D3A959;
        Tue,  7 Nov 2023 04:21:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24050C433CC;
        Tue,  7 Nov 2023 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359683;
        bh=dNl4RH6xCgJU7dwxKXMaCywX15lUfmbyqJAgYBCGVYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCXkMzfzzrXRwTelL7P4ix0cmAVhCoMDeRSGe3jGkoJXiMHrwhHM6Ihb3S0Sr7jxD
         JInMDpkBfEBQ3Nrn4Tx+d/rMUxiC1c7fDE9ZgWbLU9it5HI8BsoCjA/nhwPi8X5La3
         rO5s7mOenpCKX7vBVdhNOIEY8hnUjiaVZsztfYsulbHGRjnPTEpW8T5fZgDOwuUZsK
         Cw01ym02c5Mk9HKlaOwAABlf/85pxe5cCu/MLU/DcjwLAARJ+l5pRtBYZBW4rrjrVs
         VkP0M5MZZs+QqDLocLB6YY3yxW2rzaSm9z95/fm1hgV3AcU+Nme7KBSsg8ECymTqzf
         R6yG+Sih8cvTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jagan@edgeble.ai, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 36/40] arm64: dts: rockchip: add PCIe to rk3588s-indiedroid-nova
Date:   Tue,  7 Nov 2023 07:16:38 -0500
Message-ID: <20231107121837.3759358-36-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit f5fb02c7125e3564aa773f54add37655d09e64f1 ]

Add the necessary nodes to the Indiedroid Nova to activate the PCI
express port that is used by the RTL8111 ethernet controller.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20230918173255.1325-2-macroalpha82@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/rockchip/rk3588s-indiedroid-nova.dts     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index d1503a4b233a3..646f49cc9e53d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -109,6 +109,10 @@ vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
@@ -348,6 +352,12 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&pcie2x1l2 {
+	pinctrl-0 = <&rtl8111_perstb>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pinctrl {
 	bluetooth-pins {
 		bt_reset: bt-reset {
@@ -366,6 +376,12 @@ bt_wake_host: bt-wake-host {
 		};
 	};
 
+	ethernet-pins {
+		rtl8111_perstb: rtl8111-perstb {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	hym8563 {
 
 		hym8563_int: hym8563-int {
-- 
2.42.0

