Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4876FEC0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHDKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjHDKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:44:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67546BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:44:46 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0E1E1BAE;
        Fri,  4 Aug 2023 12:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691145818;
        bh=VL2Zw7Ueb46o20OnyXzo7UsNsItrGawjFD5subpRhLA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u4ULlL7tvxIKpOUx0VJO+MVbnfZrDOfOYTnlihOhFO8TLNvLS2KO/yUsNHy+OBkxJ
         QwM7FLJRxjgHAbzy+0V6M5tH53AzKpi2jGaUpB1jvHnbnLv8FEVznyEnbwPVX0ilQn
         Ssii+EpwteLN6FRajzPbcTNJ76hVn4cuxdA0EWXI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:44:10 +0300
Subject: [PATCH 05/11] drm/bridge: tc358768: Print logical values, not raw
 register values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-tc358768-v1-5-1afd44b7826b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VL2Zw7Ueb46o20OnyXzo7UsNsItrGawjFD5subpRhLA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNaS4UeqJCGOhxjM1pf6s/5aVvSD48+u23FYF
 z4/mHBK/+uJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzWkgAKCRD6PaqMvJYe
 9T2RD/0YwlqUpyhFktnI4J/zqdVjHTNjyt/hhVrv7zBqKOlX8+ZReohrJ0sZpZrjyZSv4/tTr/Y
 Zy5PXtHTEbGDeOFMXz3XU5HUef7+E2OPuwRUVgDT+ATsVsQNC5LFPwJWsLifRFfYjm1/SY0NM/T
 oA64T3LV4LxWUrt/8NU5wAje4EzTdmd0OZ6ZY2L4xobZ4irxFaBqRBFNk/fmcPgw8twucBBPRZv
 pCy9bJSXEQ9kgMNMrJSlPyw4GMGavR9DpazR3KfIWbGwBEGDr2iVgDrRJVBdHl3X37bzJvkGgm8
 lNTymEtfWemDw93TLBblbaQqPI0pSHYrItEaUVEHmbIHaybKpkWqg4iAetEVbEhkYbgJt/N40Bc
 5Kv1RQQJq0Xme3ZZ0eJ6a04/fKfM8u9LSuJCABhI0YT6KCEIZwepYeX1XICC8F3YLCznzd7mAI1
 YmRzUs9OE17GNmacEXdkR7F2Fg7oQ9hJ8Yyyvfz29KA23+BpAwyqUOfwFsfFR0dGRPY+b4HFJOF
 yQF1hTSCwoCphmDZkdUvuNlTy8dERNwHHa+/44hZMd4aFIhYy07sxHW/BiXeAlHSD1oN6QMLgyg
 AT/VIf25BsW1z3OuQHP6DQIDP++dlvmFzm4TJZj9EvBVJUazGRVgoI3Xa2pf5ycylS28mX4ZjCL
 5Jxd0QW8KowqPGw==
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

The driver debug prints DSI related timings as raw register values in
hex. It is much more useful to see the "logical" value of the timing,
not the register value.

Change the prints to print the values separately, in case a single
register contains multiple values, and use %u to have it in a more human
consumable form.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 9b633038af33..0ef51d04bb21 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -739,57 +739,59 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* LP11 > 100us for D-PHY Rx Init */
 	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "LINEINITCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
 	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
 	lptxcnt = val;
-	dev_dbg(priv->dev, "LPTXTIMECNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
 	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
+	dev_dbg(priv->dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
 	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
 				  dsibclk_nsk) - 2;
+	dev_dbg(priv->dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
-	dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
 	val = clamp(raw_val, 0, 127);
-	dev_dbg(priv->dev, "TCLK_TRAILCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	dev_dbg(priv->dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
 	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
 	val2 = clamp(raw_val, 0, 127);
+	dev_dbg(priv->dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
-	dev_dbg(priv->dev, "THS_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
 	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
 	val = val / (lptxcnt + 1) - 1;
-	dev_dbg(priv->dev, "TWAKEUP: 0x%x\n", val);
+	dev_dbg(priv->dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
 	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
 				 dsibclk_nsk) - 3;
-	dev_dbg(priv->dev, "TCLK_POSTCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
 				     dsibclk_nsk) - 4;
 	val = clamp(raw_val, 0, 15);
-	dev_dbg(priv->dev, "THS_TRAILCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
 
 	val = BIT(0);
@@ -803,10 +805,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
+	dev_dbg(priv->dev, "TXTAGOCNT: %u\n", val);
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
+	dev_dbg(priv->dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
-	dev_dbg(priv->dev, "BTACNTRL1: 0x%x\n", val);
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
 
 	/* START[0] */

-- 
2.34.1

