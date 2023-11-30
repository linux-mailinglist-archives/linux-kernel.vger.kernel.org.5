Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2577FF18A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbjK3ORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbjK3ORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:17:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCE83
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:17:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so1477409e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701353837; x=1701958637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CX2gA6r/dtvGkH0YEYWwI6mzbAd5lMyIJziHnyg55Q=;
        b=NAQQF9CGd2EXG8YvKEnsscjo0HUWWemZLQW4B3vpiXibNdSAvbgLwTIhPVFaF7hMqv
         UDxUkIZMGog8Ii6zoGQqaG8hahL/4jLyTG8E4H00ocfjnQMezH/bemAFUyoOX8D3uMi1
         ICaUmb40+HHBQA3CZD4ztSg0rS61Ime6LCRho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353837; x=1701958637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CX2gA6r/dtvGkH0YEYWwI6mzbAd5lMyIJziHnyg55Q=;
        b=IztGEAmRwObVtNcZ4QvpQSilDnWnRoK5WKjOkGLCeLMr3IIIwJDvIuNekmydhovd0f
         WXNg2G0e/bZ//9YcApbCGT3FDF2PeSmIMMMwrPnuxZP2eYsjHPnofP2dq+a1RDLUB+b4
         whDNx8KIzwamS467g+uPM6pWObyK9U0LBikBHvhzTJUaXURQBjIOO1uJXfmF9JabubJ9
         2EZCKNFHfqkNvJ3dBQ5Dwvh4RTO1l2brvEq5lTZ+tugwkrz6i0wKdYX+m0VieHVcopz6
         iUzH0ycBYON+Ive5CKVLiEMZnWVtnZqeViwjHcxUOukn3S2BzQ0nTZZF8VpoD8WZDpL0
         8LEg==
X-Gm-Message-State: AOJu0YzmiWwX/ldCI4W7bqUDzOT5mGO8JAEHQAqh9KCYQhspd0Oscg2F
        990NFwoSATNJ9I0sMNytc89j5EcDPB/iEZUHVGulNw==
X-Google-Smtp-Source: AGHT+IHCKwwfgrllbhvlJeqG2XUHDgFIBCO+K+nOK6Djztf8lfoC6PZrn7hwv7UgXPi2dqQ4M8ZtEg==
X-Received: by 2002:a05:6512:3d88:b0:50b:c910:dd00 with SMTP id k8-20020a0565123d8800b0050bc910dd00mr3629996lfv.46.1701353837401;
        Thu, 30 Nov 2023 06:17:17 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
        by smtp.gmail.com with ESMTPSA id my18-20020a1709065a5200b009f28db2b702sm716064ejc.209.2023.11.30.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:17:17 -0800 (PST)
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
Subject: [PATCH v3 03/10] drm: bridge: samsung-dsim: enter display mode in the enable() callback
Date:   Thu, 30 Nov 2023 15:16:20 +0100
Message-ID: <20231130141705.1796672-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
References: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
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
2.43.0

