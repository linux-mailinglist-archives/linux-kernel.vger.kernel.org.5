Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7A76FEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjHDKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjHDKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:44:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12B49D6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:44:48 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3F1712E4;
        Fri,  4 Aug 2023 12:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691145820;
        bh=Z33kVdpZefR4T4jHN2TcfkOhn6sG3FUQswblV1pZ7fI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cHtA/ikZSPUMXiwKutlgFnMOpC173aa8kIGA7QGqxZWegVQrNwVgb+rLmcGoWFh6e
         /Koa9D0GSfLAmyYFBNreiQSM5dPf1UriZWvUR4/uYoxVa7tVxvIH8pCtnnVb+rUyqj
         mV3ZXe9BNoyfVdV26Ha+7WzexlSkx8G/j3kbJeHg=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:44:12 +0300
Subject: [PATCH 07/11] drm/bridge: tc358768: Rename dsibclk to hsbyteclk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-tc358768-v1-7-1afd44b7826b@ideasonboard.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
In-Reply-To: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7306;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Z33kVdpZefR4T4jHN2TcfkOhn6sG3FUQswblV1pZ7fI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNaThNg+d7lEAoswYIxJMzYYMiMGqrtH+deZe
 fIT6teBN1mJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzWkwAKCRD6PaqMvJYe
 9Q4eD/wI506iloc5UhJvk5OJX1jmdwK7cTpLn7Rl8obueJ4FAbsfHnS2cYsc70qrzIRaH1qtvSm
 RMmnrKekU1DMZqprAnFJDV39AJVP7ln5+Ol7Wd6k9bIiyNRqS4PEBBH9Jrnbo9og3h0sf5CewTN
 JHQ0dM3kH5eIYwpOC7MBw1Q2kt1ZFo1hWgF6FskssU1hdQrv357ENlmJtTI2twPRzvglOkeWrcy
 6Mp1yzvQSWF/p2sifDIm9TqnLUeWrtFFGKIRW7m4/rg4NUVVWHtb9ONNZ5f9UZnZznnFLEwsOij
 Wlx6fbeRyKksqz2a7OCXocC89wGyi++qHPZz14+Nm8ncqWOCqbhRJF7SlngT2NUnFqaA0TG/U4b
 L3gyJPx0zICHxfxSM8lqJfnEoHJpxyXQtNgNBZg5PUPMM7xsbF+pBghhyK/+JfNNPh8d9M667Nq
 fJdyD8p7Co16zlZozEtp+tJFojf+5+LML37UnExQVrbKjHldszLGFnBwIwk/fLKW6Fnx+WFvWVl
 or4nZNxzAMScOOAArPQxhuiM7VAGhecI375JfZsnTsvULBTGtj0EUUQ2cmeSm9YjyATgqgnr+tg
 8cSCSYdb039A5aSZd7bMbAP6+w3ZrccuOaqTEfywUOc1NW/YPvNn8tfsAGMidfVcYY3MMr/0TXd
 Ud8Hhb1X61zlSWQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Toshiba documentation talks about HSByteClk when referring to the
DSI HS byte clock, whereas the driver uses 'dsibclk' name. Also, in a
few places the driver calculates the byte clock from the DSI clock, even
if the byte clock is already available in a variable.

To align the driver with the documentation, change the 'dsibclk'
variable to 'hsbyteclk'. This also make it easier to visually separate
'dsibclk' and 'dsiclk' variables.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 3266c08d9bf1..db45b4a982c0 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -604,7 +604,7 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
 
 	dev_dbg(priv->dev, "PLL: refclk %lu, fbd %u, prd %u, frs %u\n",
 		clk_get_rate(priv->refclk), fbd, prd, frs);
-	dev_dbg(priv->dev, "PLL: pll_clk: %u, DSIClk %u, DSIByteClk %u\n",
+	dev_dbg(priv->dev, "PLL: pll_clk: %u, DSIClk %u, HSByteClk %u\n",
 		priv->dsiclk * 2, priv->dsiclk, priv->dsiclk / 4);
 	dev_dbg(priv->dev, "PLL: pclk %u (panel: %u)\n",
 		tc358768_pll_to_pclk(priv, priv->dsiclk * 2),
@@ -646,8 +646,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	u32 val, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
 	const struct drm_display_mode *mode;
-	u32 dsibclk_nsk, dsiclk_nsk, ui_nsk;
-	u32 dsiclk, dsibclk, video_start;
+	u32 hsbyteclk_nsk, dsiclk_nsk, ui_nsk;
+	u32 dsiclk, hsbyteclk, video_start;
 	const u32 internal_delay = 40;
 	int ret, i;
 	struct videomode vm;
@@ -678,7 +678,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	drm_display_mode_to_videomode(mode, &vm);
 
 	dsiclk = priv->dsiclk;
-	dsibclk = dsiclk / 4;
+	hsbyteclk = dsiclk / 4;
 
 	/* Data Format Control Register */
 	val = BIT(2) | BIT(1) | BIT(0); /* rdswap_en | dsitx_en | txdt_en */
@@ -730,67 +730,67 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		tc358768_write(priv, TC358768_D0W_CNTRL + i * 4, 0x0000);
 
 	/* DSI Timings */
-	dsibclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION,
-				  dsibclk);
+	hsbyteclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION,
+				  hsbyteclk);
 	dsiclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION, dsiclk);
 	ui_nsk = dsiclk_nsk / 2;
 	dev_dbg(dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
 	dev_dbg(dev, "ui_nsk: %u\n", ui_nsk);
-	dev_dbg(dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
+	dev_dbg(dev, "hsbyteclk_nsk: %u\n", hsbyteclk_nsk);
 
 	/* LP11 > 100us for D-PHY Rx Init */
-	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(100 * 1000, hsbyteclk_nsk) - 1;
 	dev_dbg(dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
-	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(50, hsbyteclk_nsk) - 1;
 	lptxcnt = val;
 	dev_dbg(dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
-	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(65, hsbyteclk_nsk) - 1;
 	dev_dbg(dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
 	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
-				  dsibclk_nsk) - 2;
+				  hsbyteclk_nsk) - 2;
 	dev_dbg(dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
-	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), hsbyteclk_nsk) - 5;
 	val = clamp(raw_val, 0, 127);
 	dev_dbg(dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(val, hsbyteclk_nsk) - 1;
 	dev_dbg(dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
-	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
+	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), hsbyteclk_nsk) - 10;
 	val2 = clamp(raw_val, 0, 127);
 	dev_dbg(dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
-	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
+	val = tc358768_ns_to_cnt(1020000, hsbyteclk_nsk);
 	val = val / (lptxcnt + 1) - 1;
 	dev_dbg(dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
 	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
-				 dsibclk_nsk) - 3;
+				 hsbyteclk_nsk) - 3;
 	dev_dbg(dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
-				     dsibclk_nsk) - 4;
+				     hsbyteclk_nsk) - 4;
 	val = clamp(raw_val, 0, 15);
 	dev_dbg(dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
@@ -804,11 +804,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
-	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
+	val = tc358768_to_ns((lptxcnt + 1) * hsbyteclk_nsk * 4);
+	val = tc358768_ns_to_cnt(val, hsbyteclk_nsk) / 4 - 1;
 	dev_dbg(dev, "TXTAGOCNT: %u\n", val);
-	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
-				  dsibclk_nsk) - 2;
+	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * hsbyteclk_nsk),
+				  hsbyteclk_nsk) - 2;
 	dev_dbg(dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
@@ -831,13 +831,13 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 		/* hsw * byteclk * ndl / pclk */
 		val = (u32)div_u64(vm.hsync_len *
-				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
+				   (u64)hsbyteclk * priv->dsi_lanes,
 				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HSW, val);
 
 		/* hbp * byteclk * ndl / pclk */
 		val = (u32)div_u64(vm.hback_porch *
-				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
+				   (u64)hsbyteclk * priv->dsi_lanes,
 				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HBPR, val);
 	} else {
@@ -856,7 +856,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 		/* (hsw + hbp) * byteclk * ndl / pclk */
 		val = (u32)div_u64((vm.hsync_len + vm.hback_porch) *
-				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
+				   (u64)hsbyteclk * priv->dsi_lanes,
 				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HSW, val);
 

-- 
2.34.1

