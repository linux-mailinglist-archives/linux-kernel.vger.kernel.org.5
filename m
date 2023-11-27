Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCA7FAE34
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjK0XK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0XKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:10:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C008A19D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:29 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso7338006e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701126628; x=1701731428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebCaCeD18lScqs91J6GhqRptQIZNUU3CWEgjdYQG/5k=;
        b=haLFDG3Yt4ZKSIPCuOg9Hg7I/tOWsH79/YORRhHBOnjYbDmg3VRJRLSYy8G5Dl5Mr8
         GynyVbIOyCMfEXyGvatXCD8uZbApbgtHq063T31ie345K1DWClC6rKjP8tDaygChUm5J
         cN2sTezIf6gW5NILEc81kL6x2Lqv2Clkr6HZ6QfS36J26KJp5jlc0+r54u13YE8wlKNm
         prCzF8aSJXCBa7iKQE1sri6GaFdFA9i7J34nHzuod8Qdfk0ky/ZkWoBsK1R4FHJjfqFH
         Z44Kxs6coXGn20Qf3YhTk6DKj6X3dww3ZutXUSG9tab3G2aDBGN/q8YfKBwDREIAZZc/
         Rn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701126628; x=1701731428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebCaCeD18lScqs91J6GhqRptQIZNUU3CWEgjdYQG/5k=;
        b=CE9ExALtUR30GGoapUJu6DO+s04cD04I/FuR01NISP6GW+zBLSsh87zgNHsgrQ5MPz
         amahKB2XjbrucWHkA1vAOMeba5M59NvISU8I5PvTF/u6P5/r/7b1P8W01gRdL1Sd64U6
         YFbAbmxuf57TQuX3Wlg72DVa/XTDcGQIOAHncow3JS/3tsndgHJeRmXW0CSX3OtkmR41
         YxcHQQuCBykBXGbKWY9Id2yP2W4C/TIadUbbaZ9Ge+X5uSPwB5c2mCL9j+MT9vzNE0d1
         yodikrdewJhEPjEgkH04p/4nuRFoDOCO47qvVExg+jeawkgtfUHzWKjht69naKEVCdtI
         jAvw==
X-Gm-Message-State: AOJu0YwKpYuxMHnuSukgHHI4mj3lAvsn5HNTAX6C6vWmsAb7EZUwN+aX
        j0m2zgTECTj50HrwrWOk6uEmzQ==
X-Google-Smtp-Source: AGHT+IEhEPXemDbkIJhSLCv5/GH5cwpEPdzf5GSgTd+fUOw58GlymZwfd+AJ0UkTPtPIdrnHM/VP5Q==
X-Received: by 2002:a05:6512:4883:b0:509:8fbf:7af0 with SMTP id eq3-20020a056512488300b005098fbf7af0mr7163748lfb.69.1701126628030;
        Mon, 27 Nov 2023 15:10:28 -0800 (PST)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b0050aa94e6d15sm1636877lfb.9.2023.11.27.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:10:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 00:10:21 +0100
Subject: [PATCH 3/3] Revert "drm/bridge: panel: Add a device link between
 drm device and panel device"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-revert-panel-fix-v1-3-69bb05048dae@linaro.org>
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
In-Reply-To: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
To:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 199cf07ebd2b0d41185ac79b895547d45610b681.

This patch creates bugs on devices where the DRM device is
the ancestor of the panel devices.

Attempts to fix this have failed because it leads to using
device core functionality which is questionable.

Reported-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/lkml/CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+nJ1P0JrfJ-ArMvQ@mail.gmail.com/T/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/bridge/panel.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index e48823a4f1ed..7f41525f7a6e 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2017 Broadcom
  */
 
-#include <linux/device.h>
-
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
@@ -21,7 +19,6 @@ struct panel_bridge {
 	struct drm_bridge bridge;
 	struct drm_connector connector;
 	struct drm_panel *panel;
-	struct device_link *link;
 	u32 connector_type;
 };
 
@@ -63,24 +60,13 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 	struct drm_connector *connector = &panel_bridge->connector;
-	struct drm_panel *panel = panel_bridge->panel;
-	struct drm_device *drm_dev = bridge->dev;
 	int ret;
 
-	panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
-					     DL_FLAG_STATELESS);
-	if (!panel_bridge->link) {
-		DRM_ERROR("Failed to add device link between %s and %s\n",
-			  dev_name(drm_dev->dev), dev_name(panel->dev));
-		return -EINVAL;
-	}
-
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
 	if (!bridge->encoder) {
 		DRM_ERROR("Missing encoder\n");
-		device_link_del(panel_bridge->link);
 		return -ENODEV;
 	}
 
@@ -92,7 +78,6 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 				 panel_bridge->connector_type);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector\n");
-		device_link_del(panel_bridge->link);
 		return ret;
 	}
 
@@ -115,8 +100,6 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 	struct drm_connector *connector = &panel_bridge->connector;
 
-	device_link_del(panel_bridge->link);
-
 	/*
 	 * Cleanup the connector if we know it was initialized.
 	 *

-- 
2.41.0

