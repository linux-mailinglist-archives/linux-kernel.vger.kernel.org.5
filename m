Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8332802C07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjLDH2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:28:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C21CA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:28:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71705C433C8;
        Mon,  4 Dec 2023 07:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701674903;
        bh=eJKSep2QD7gJ/0nBUBeTc1a4h97UkN6mjcyAE28MOmA=;
        h=From:To:Cc:Subject:Date:From;
        b=BiBzutVln1VIvwewH6Q8mLGqsvH33r9JMIlab6krzKGBBQ4gnZ9oo05jlAzeeV6zF
         U6/lHP2lHnrolkNWLf0U/ss+OipChnH2ptuIZL1IH56UtIs5uRlb7HI4Pbpmfx2B3U
         bmd56H7qNkkBlArbReoJmXnkWkVAojR4i4/vPceHbxnx58/sTHgvERdVx+rM54wTsK
         /UFPIqF8zm6ysCpXga2EGhcHZ5Tw0UAheTt+iB9AgUVRGvftgjqPVY502sKV50J6m2
         A/4yewRX/ZbfgUGLmoEbKwF0fo3fQgKYdicgaMzrDzJJtaq+pBjo2Ys2j4FB2eece+
         GchdxQbbrQ0IQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS
Date:   Mon,  4 Dec 2023 08:27:36 +0100
Message-Id: <20231204072814.968816-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A dependency on this feature was recently introduced:

x86_64-linux-ld: vmlinux.o: in function `tc358768_bridge_pre_enable':
tc358768.c:(.text+0xbe3dae): undefined reference to `drm_display_mode_to_videomode'

Make sure this is always enabled.

Fixes: e5fb21678136 ("drm/bridge: tc358768: Use struct videomode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index ba82a1142adf..3e6a4e2044c0 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -313,6 +313,7 @@ config DRM_TOSHIBA_TC358768
 	select REGMAP_I2C
 	select DRM_PANEL
 	select DRM_MIPI_DSI
+	select VIDEOMODE_HELPERS
 	help
 	  Toshiba TC358768AXBG/TC358778XBG DSI bridge chip driver.
 
-- 
2.39.2

