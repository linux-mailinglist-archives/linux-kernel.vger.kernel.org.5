Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2D770A86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHDVI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjHDVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4784EDD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so1904061b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183248; x=1691788048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrsSjqZ7OVl1AWfIXsg4vL7ZkYMxPl18iDNJrqzoz4k=;
        b=igZkBXcHHS/NmtYnn82Gu31zizwN7sk/X1c4RXzpaeTXixkHYqPgzx5DzIgAZExffK
         mICfP6MOntNN+49lbOrNo9rMHa67le2kkx350dw0aTzJ/t0z66RTi8tWKsQ5xvmOt7Cb
         aT3W7ufFoCZ/s9dfIdRqpOo6DBhQXgaZ5Be9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183248; x=1691788048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrsSjqZ7OVl1AWfIXsg4vL7ZkYMxPl18iDNJrqzoz4k=;
        b=TkkD73Haki/3DMTK0FTYJ33ydyNZQOUSOCMzK215ROy+fUk1cd9r2yKBtzLtkr7qCw
         53yMfB0e6+5R3/ftsYDVPQgOBt5MpAZ4BCLONbcX9XuqC44Uzb1+wCX3cCkSgIK8CJCi
         L03OTzXd9OyS81RpJHKpspk7dG6rXdJZqkpNwvAyqOty4Sur2AyFHYqyfU+6etK1FPIV
         /cTqIp0GN19zrNuUZQGaoa3nlxSlfFm1qpxvJmOV/J8Pj8/yaq6Gy7Tgq3wvboucupwT
         hx+p8I/bkVjkyMdargEkYgPUCeRN6j+8DFTTKIJGk6P+N/AioesnkoSvCwFdlK/hDbKE
         Gmcw==
X-Gm-Message-State: AOJu0YzxeJWh4dDI6PJ6sA7KtRMCjZcV6vvFu4oloic5EfkritY1aHX3
        sZMgkUW8V9MFxFWZ5rpNtVpDEQ==
X-Google-Smtp-Source: AGHT+IEcK7W1PDCytR6pAUX1xURN5daOQuXk47xXgJ9839il1wgV/d4dk8Z2A8ZZyb0W6m409c8NtQ==
X-Received: by 2002:a05:6a00:1798:b0:666:b254:1c9c with SMTP id s24-20020a056a00179800b00666b2541c9cmr3339506pfg.27.1691183248705;
        Fri, 04 Aug 2023 14:07:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/10] drm/panel: st7703: Don't store+check prepared
Date:   Fri,  4 Aug 2023 14:06:10 -0700
Message-ID: <20230804140605.RFC.7.Ifc436b262d72f1a33ddef10adfd7578d4acb60d8@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
References: <20230804210644.1862287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

For the st7703 panel driver this is fairly straightforward. Like with
many other panels, we need to use the new drm_panel_helper_shutdown()
function to make sure that remove() and shutdown() don't try to
disable/unprepare a panel that hasn't been prepared/enabled. One thing
that is a little different for st7703 is that it has a special
"allpixelson" debugfs file. When this file is written the driver hacks
a disable/unprepare and then a prepare/enable to try to reset the
panel. This debugfs file didn't appear to be particularly safe to use
even before this patch since it would cause a disabled/unprepared
panel to become prepared/enabled. It is nominally even less safe after
this patch since calling it on a panel that wasn't prepared/enabled
will now likely cause a regulator underflow message. If this matters
to anyone, it could be fixed in a future patch.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 6a3945639535..dde903e803d1 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -22,6 +22,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_panel_helper.h>
 
 #define DRV_NAME "panel-sitronix-st7703"
 
@@ -58,7 +59,6 @@ struct st7703 {
 	struct gpio_desc *reset_gpio;
 	struct regulator *vcc;
 	struct regulator *iovcc;
-	bool prepared;
 
 	struct dentry *debugfs;
 	const struct st7703_panel_desc *desc;
@@ -486,13 +486,9 @@ static int st7703_unprepare(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
 
-	if (!ctx->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vcc);
-	ctx->prepared = false;
 
 	return 0;
 }
@@ -502,9 +498,6 @@ static int st7703_prepare(struct drm_panel *panel)
 	struct st7703 *ctx = panel_to_st7703(panel);
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	dev_dbg(ctx->dev, "Resetting the panel\n");
 	ret = regulator_enable(ctx->vcc);
 	if (ret < 0) {
@@ -522,8 +515,6 @@ static int st7703_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	msleep(20);
 
-	ctx->prepared = true;
-
 	return 0;
 
 disable_vcc:
@@ -665,15 +656,8 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 static void st7703_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct st7703 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
 
-	ret = drm_panel_unprepare(&ctx->panel);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to unprepare panel: %d\n", ret);
-
-	ret = drm_panel_disable(&ctx->panel);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to disable panel: %d\n", ret);
+	drm_panel_helper_shutdown(&ctx->panel);
 }
 
 static void st7703_remove(struct mipi_dsi_device *dsi)
-- 
2.41.0.585.gd2178a4bd4-goog

