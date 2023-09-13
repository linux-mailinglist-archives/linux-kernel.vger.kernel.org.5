Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0179B79E04E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjIMG7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjIMG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:59:37 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9A1738;
        Tue, 12 Sep 2023 23:59:32 -0700 (PDT)
Received: from p200300ccff163a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff16:3a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qgJqH-003fzu-6Q; Wed, 13 Sep 2023 08:59:17 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qgJqG-006VX4-2U;
        Wed, 13 Sep 2023 08:59:16 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
        andreas@kemnade.info, arnd@arndb.de,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Subject: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Date:   Wed, 13 Sep 2023 08:59:11 +0200
Message-Id: <20230913065911.1551166-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some 3.0 source has it set behind a if (omap4).
Maybe it is helpful maybe not, at least in the omap4460
trm these bits are marked as reserved.
But maybe some dsi video mode panel starts magically working.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 60189a23506a1..e2f576cd9f63c 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4505,7 +4505,7 @@ static const struct dss_pll_hw dss_omap4_dsi_pll_hw = {
 	.has_stopmode = true,
 	.has_freqsel = false,
 	.has_selfreqdco = false,
-	.has_refsel = false,
+	.has_refsel = true,
 };
 
 static const struct dss_pll_hw dss_omap5_dsi_pll_hw = {
-- 
2.39.2

