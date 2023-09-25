Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878DB7AE171
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjIYWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:01:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA4112
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:01:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3adf06730c4so4631018b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695679272; x=1696284072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f56JQlsSAmLM+rWl8eVCaUJ/LY2QFxeZQE+QgWmGsq0=;
        b=YoRyRJ9Giht3eW/Q610XE3F2Ud3rrWCyPsdIRd3z37dSf+q8+/GbTO7oIOYkm68NHD
         Um0RxXgS1al6+JEyF4ESYIb5DuJljtFqBzPpMsUTJUIAkqviGSrkvTidAx8m0dUuvVPZ
         y8vohGcTvi8Tbym221c1rZIrbnGTLHHYq6utw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679272; x=1696284072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f56JQlsSAmLM+rWl8eVCaUJ/LY2QFxeZQE+QgWmGsq0=;
        b=dHCStC753U4JnnVSsCxsYdxLZ61PqQ7inYAatetmC/fkJEgHR3exPv79k2hG6Yju/b
         yjU1pi+kboHtykrWwjiNAGR3SXDG7L3Ucu9oHRqqaxNLx/gNB3GGoe1ES4c99viRkm3L
         OIlLLVYQQMPKttAcBMaFnc/7/UztDyj4dmH+P+vQAwqFGD0wNDg6ZFHgq+eHknaihDvK
         zCqVP+al+wChNw3Q0ToB4dxTIsiTCWuulHrwNzu7x8DUziTpZUW4nEqOZoRbvvu7coKw
         caT3kzX3mNQqYFt9+EC/6JVXUuN1mvZWrAK+J22ROGDBO+sp6yAJVa0j8cmIFMqt9tsd
         ifOA==
X-Gm-Message-State: AOJu0YxEcojLXJAIgch1woAQ7+imlkCzdhsxcLbly0vWE32mYzwH7vTb
        62uKTCaNYIGTDOnLmt/v2Mbbng==
X-Google-Smtp-Source: AGHT+IF1Hh6HqLLdCLMtBH4MBn5gTyDegFYkgrOxkSx/P6oII1rExFDnHQGDyN9+FIpRz6er1CzuVQ==
X-Received: by 2002:a05:6808:1386:b0:3a7:38c5:bc18 with SMTP id c6-20020a056808138600b003a738c5bc18mr11073698oiw.32.1695679272043;
        Mon, 25 Sep 2023 15:01:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f75d:a4e1:226a:3071])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b00690f622d3cdsm8549874pfm.126.2023.09.25.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:01:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, jitao.shi@mediatek.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        quic_jesszhan@quicinc.com, sam@ravnborg.org
Subject: [PATCH] drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple
Date:   Mon, 25 Sep 2023 15:00:11 -0700
Message-ID: <20230925150010.1.Iff672233861bcc4cf25a7ad0a81308adc3bda8a4@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of
panel-simple") I moved a pile of panels out of panel-simple driver
into the newly created panel-edp driver. One of those panels, however,
shouldn't have been moved.

As is clear from commit e35e305eff0f ("drm/panel: simple: Add AUO
B116XW03 panel support"), AUX B116XW03 is an LVDS panel. It's used in
exynos5250-snow and exynos5420-peach-pit where it's clear that the
panel is hooked up with LVDS. Furthermore, searching for datasheets I
found one that makes it clear that this panel is LVDS.

As far as I can tell, I got confused because in commit 88d3457ceb82
("drm/panel: auo,b116xw03: fix flash backlight when power on") Jitao
Shi added "DRM_MODE_CONNECTOR_eDP". That seems wrong. Looking at the
downstream ChromeOS trees, it seems like some Mediatek boards are
using a panel that they call "auo,b116xw03" that's an eDP panel. The
best I can guess is that they actually have a different panel that has
similar timing. If so then the proper panel should be used or they
should switch to the generic "edp-panel" compatible.

When moving this back to panel-edp, I wasn't sure what to use for
.bus_flags and .bus_format and whether to add the extra "enable" delay
from commit 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash
backlight when power on"). I've added formats/flags/delays based on my
(inexpert) analysis of the datasheet. These are untested.

NOTE: if/when this is backported to stable, we might run into some
trouble. Specifically, before 474c162878ba ("arm64: dts: mt8183:
jacuzzi: Move panel under aux-bus") this panel was used by
"mt8183-kukui-jacuzzi", which assumed it was an eDP panel. I don't
know what to suggest for that other than someone making up a bogus
panel for jacuzzi that's just for the stable channel.

Fixes: 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when power on")
Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I haven't had a snow or peach-pit hooked up for debugging / testing
for years. I presume that they must be broken and hope that this fixes
them.

 drivers/gpu/drm/panel/panel-edp.c    | 29 -----------------------
 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index feb665df35a1..95c8472d878a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -976,32 +976,6 @@ static const struct panel_desc auo_b116xak01 = {
 	},
 };
 
-static const struct drm_display_mode auo_b116xw03_mode = {
-	.clock = 70589,
-	.hdisplay = 1366,
-	.hsync_start = 1366 + 40,
-	.hsync_end = 1366 + 40 + 40,
-	.htotal = 1366 + 40 + 40 + 32,
-	.vdisplay = 768,
-	.vsync_start = 768 + 10,
-	.vsync_end = 768 + 10 + 12,
-	.vtotal = 768 + 10 + 12 + 6,
-	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
-};
-
-static const struct panel_desc auo_b116xw03 = {
-	.modes = &auo_b116xw03_mode,
-	.num_modes = 1,
-	.bpc = 6,
-	.size = {
-		.width = 256,
-		.height = 144,
-	},
-	.delay = {
-		.enable = 400,
-	},
-};
-
 static const struct drm_display_mode auo_b133han05_mode = {
 	.clock = 142600,
 	.hdisplay = 1920,
@@ -1725,9 +1699,6 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b116xa01",
 		.data = &auo_b116xak01,
-	}, {
-		.compatible = "auo,b116xw03",
-		.data = &auo_b116xw03,
 	}, {
 		.compatible = "auo,b133han05",
 		.data = &auo_b133han05,
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index bb89e6d047bc..439d26928938 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -919,6 +919,38 @@ static const struct panel_desc auo_b101xtn01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xw03_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc auo_b116xw03 = {
+	.modes = &auo_b116xw03_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 256,
+		.height = 144,
+	},
+	.delay = {
+		.prepare = 1,
+		.enable = 200,
+		.disable = 200,
+		.unprepare = 500,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_g070vvn01_timings = {
 	.pixelclock = { 33300000, 34209000, 45000000 },
 	.hactive = { 800, 800, 800 },
@@ -4128,6 +4160,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b101xtn01",
 		.data = &auo_b101xtn01,
+	}, {
+		.compatible = "auo,b116xw03",
+		.data = &auo_b116xw03,
 	}, {
 		.compatible = "auo,g070vvn01",
 		.data = &auo_g070vvn01,
-- 
2.42.0.515.g380fc7ccd1-goog

