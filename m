Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF57F9398
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKZPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjKZPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:46:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B521A5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:44 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a08e4352992so278697566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013603; x=1701618403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frvwetq2uP6wtxuP9UX1ctUqElygA7huby/aEqYEpm0=;
        b=bDRBqyHTyF+fHdoboWSuZZQfp6AcYc1IJ8ii28CCzvKa2krnfgE91PhZCo2OK3ioMV
         tXy08MhS8+Ds69186bFuAKpBtuk93ANCQDwJ/QtDwUlRKKGH88zXFnnGxQicUOsSnd+F
         rOungMdmME4OOyHxXtoy5IDaWATP2q/JtCAUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013603; x=1701618403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frvwetq2uP6wtxuP9UX1ctUqElygA7huby/aEqYEpm0=;
        b=GxpFrZ99BhggkcZKh3qnV44rlnuQApy0RVg2ctccaXfzjEhcYRSruqCU2wOjVV0mDk
         t8zHjqTIRsCvm/+BD80kOodft1u8m7INVRFwH9Qd8n9lG66iCAPkGMsDuO8BDkL2of/I
         romnMjM4HrBw1+6kqzRPTa0y2IpUnkqCKNTBof8gQ1tqiCKNw3ITu156tbXexnYfbdQY
         zNSl09HSZQGOAZfmDbLsdZQDulRl/iOJtwQTvtkJFOYD7Kg+iu5wHDHGrJOoYcshzT0k
         MkjWUOzLXe8mH7fqjdsrEOSYXS/hKahjv20DNXunJhhy55IWiceglF2xPfyU2afQSphD
         ZQFA==
X-Gm-Message-State: AOJu0YwSbzCjJZRVLXbRwnhqWWiwQhJ5KrrRG77U7IfFVIJrkBvYF07U
        QCKEveuwnpIniDC/YMWYil/asXrEUdTzTE2g48BWrg==
X-Google-Smtp-Source: AGHT+IEDqopibIRdY4CT9KM9oqdSMtz/RcmEiz+/nh5esAfdhe2suG5tPBnyv8lcQHoHyXYw6DmKvA==
X-Received: by 2002:a17:906:25e:b0:a0d:35b:89a9 with SMTP id 30-20020a170906025e00b00a0d035b89a9mr1819881ejl.46.1701013603021;
        Sun, 26 Nov 2023 07:46:43 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:41 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 03/11] drm: bridge: samsung-dsim: enter display mode in the enable() callback
Date:   Sun, 26 Nov 2023 16:44:55 +0100
Message-ID: <20231126154605.15767-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
References: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synaptics-r63353 (panel-bridge) can only be configured in command mode.
So, samsung-dsim (bridge) must not be in display mode during the
prepare()/unprepare() of the panel-bridge. Setting the
"pre_enable_prev_first" flag to true allows the prepare() of the
panel-bridge to be called between the pre_enabled() and enabled() of the
bridge. So, the bridge can enter display mode only in the enabled().
The unprepare() of the panel-bridge is instead called between the disable()
and post_disable() of the bridge. So, the disable() must exit the display
mode (i .e. enter command mode) to allow the panel-bridge to receive DSI
commands.

samsung_dsim_atomic_pre_enable   -> command mode
r63353_panel_prepare             -> send DSI commands
samsung_dsim_atomic_enable       -> enter display mode

samsung_dsim_atomic_disable      -> exit display mode (command mode)
r63353_panel_unprepare           -> send DSI commands
samsung_dsim_atomic_post_disable

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/gpu/drm/bridge/samsung-dsim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index be5914caa17d..15bf05b2bbe4 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1494,7 +1494,6 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
 			return;
 
 		samsung_dsim_set_display_mode(dsi);
-		samsung_dsim_set_display_enable(dsi, true);
 	}
 }
 
@@ -1507,6 +1506,7 @@ static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
 		samsung_dsim_set_display_mode(dsi);
 		samsung_dsim_set_display_enable(dsi, true);
 	} else {
+		samsung_dsim_set_display_enable(dsi, true);
 		samsung_dsim_set_stop_state(dsi, false);
 	}
 
@@ -1524,6 +1524,8 @@ static void samsung_dsim_atomic_disable(struct drm_bridge *bridge,
 	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
 		samsung_dsim_set_stop_state(dsi, true);
 
+	samsung_dsim_set_display_enable(dsi, false);
+
 	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
 }
 
@@ -1532,7 +1534,8 @@ static void samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
 {
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
 
-	samsung_dsim_set_display_enable(dsi, false);
+	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
+		samsung_dsim_set_stop_state(dsi, true);
 
 	dsi->state &= ~DSIM_STATE_ENABLED;
 	pm_runtime_put_sync(dsi->dev);
-- 
2.42.0

