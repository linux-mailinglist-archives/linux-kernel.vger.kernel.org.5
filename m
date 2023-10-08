Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50C7BCE74
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbjJHNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbjJHNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:06:12 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B63C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696770368; bh=RR80q5tjzziqB2LGjQvlUWzbTeLf/Y2/TnpugtEscbc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BlWThhwOsaTCvKljn7BTZAw3iQakA826UlbM0OoCmagHD1bjxNlrI/LdEPjaC0svc
         hCCiteZ8MDBBTSkdHs1J77QARJsXNT+rT9VfKmSswPSf3F6ioYauMPhO2Byk5q6sVm
         dzyWp43+9iaxS5Epft3trtmtQk0aATP2WW3NB6UY=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@edgeble.ai>,
        Jonas Karlman <jonas@kwiboo.se>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: rockchip: rk3588s-pinctrl: Add UART9 M0 pin definitions
Date:   Sun,  8 Oct 2023 15:05:00 +0200
Message-ID: <20231008130515.1155664-3-megi@xff.cz>
In-Reply-To: <20231008130515.1155664-1-megi@xff.cz>
References: <20231008130515.1155664-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

This is used on Orange Pi 5 Plus.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
index 72708b1d8036..63151d9d2377 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
@@ -3342,6 +3342,15 @@ uart8_xfer: uart8-xfer {
 	};
 
 	uart9 {
+		/omit-if-no-ref/
+		uart9m0_xfer: uart9m0-xfer {
+			rockchip,pins =
+				/* uart9_rx_m0 */
+				<2 RK_PC4 10 &pcfg_pull_up>,
+				/* uart9_tx_m0 */
+				<2 RK_PC2 10 &pcfg_pull_up>;
+		};
+
 		/omit-if-no-ref/
 		uart9m1_xfer: uart9m1-xfer {
 			rockchip,pins =
-- 
2.42.0

