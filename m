Return-Path: <linux-kernel+bounces-3182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B93F81687A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88D31F21378
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC6F107A7;
	Mon, 18 Dec 2023 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mMJ/eAGO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295810945
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso3278489a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702889043; x=1703493843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CX2gA6r/dtvGkH0YEYWwI6mzbAd5lMyIJziHnyg55Q=;
        b=mMJ/eAGOWSZY6hi8L1gd/tfhpVubuiJdnFNs67cunHy6zOXCr0TFT5euTiuf9nfcqa
         xJZbrC4/c9uCj4Nd7aR3CHVAJmiVD6zfH6Kqt62/AjuRTr9ss0hGriIgiECCuXxbHXD6
         jWBYBKpwig5Hv/Ga0XGf8O+O5Q5oVKuBeo1XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702889043; x=1703493843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CX2gA6r/dtvGkH0YEYWwI6mzbAd5lMyIJziHnyg55Q=;
        b=C3yeXiyJSHbIgFptlxirsGW+l+1KLukl4W/VJWU9NcZ6F/e1KRvQ1Tg18MrwSEds9N
         hLf7jSwG2IpORrkkejsn9zPAPUxYKrMzaGIHkAccZjsl+uYb9amZ1LRW3/LvLAUvYV7l
         gYTMqNeE8lHpa0gpgpJNrwGDUBDmWOj6dKtuT71FO6Wm+TldYGUNVMzaca2TzFH/x6Gm
         zZkCVuBACHeD+Xf1fTTpt2VgcTKHs9orfGsmcgPqrgdkeNSb7gJmqaWXfnExf6QV9Ia3
         32ttcSJr/BEJG/mBnIYc3a7KNLS+oEjx301rHZaHAPQAonxkwOxTtsdkqfoR33yE3+rA
         1frQ==
X-Gm-Message-State: AOJu0Yx+PsXVC+G5t0Y4ofCng8I8hNEXKo864zs1nIRS11El6vGNfwi0
	7lqra6CTfBBPuLBoPilY3QFMPMNP9CoLTb74zTkA9Q==
X-Google-Smtp-Source: AGHT+IFQIjmnqwJHXBWuNV3lOiYbeAZ7NPxnsnxpiSweOVnDxxJk9dtKKOT/fn1raM0scBnAt9eeTA==
X-Received: by 2002:a17:907:e8d:b0:a1f:5e5d:d71b with SMTP id ho13-20020a1709070e8d00b00a1f5e5dd71bmr10134407ejc.40.1702889042999;
        Mon, 18 Dec 2023 00:44:02 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.retail.telecomitalia.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id un5-20020a170907cb8500b009ff77c2e1dasm13775480ejc.167.2023.12.18.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:44:02 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: michael@amarulasolutions.com,
	Amarula patchwork <linux-amarula@amarulasolutions.com>,
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
Subject: [PATCH v9 1/2] drm: bridge: samsung-dsim: enter display mode in the enable() callback
Date: Mon, 18 Dec 2023 09:43:37 +0100
Message-ID: <20231218084354.508942-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218084354.508942-1-dario.binacchi@amarulasolutions.com>
References: <20231218084354.508942-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


