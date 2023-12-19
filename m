Return-Path: <linux-kernel+bounces-5644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEBD818D89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D041C24CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BC3C087;
	Tue, 19 Dec 2023 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlocDPac"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75040BFE;
	Tue, 19 Dec 2023 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so39146185e9.2;
        Tue, 19 Dec 2023 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005291; x=1703610091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg73sX3i9a8aQACa3LQIeyAKZ2sxvdHhoE4dFqwZeRk=;
        b=XlocDPacYVHgSupznSKk4CKMDwHhcuRui0K1xzG19Z3UgDJ2lW+Yf7UxK3vyTXm08V
         Qm0+rTx80yjhqeR5HU/FpSVbnt7kGc4qXjjA7M5PANM+ebViri1nVDM8+7eUKLWT4k7k
         8YUWZyaqS2gyuxe3QPdTe350EdmKCr1putAzlL7PDUR428Nz0fCxKTOyD2BqnknPnvxC
         m5l9D4pfO0oPMa1w5msSWD0XJSS8fjgCqkFmhv5iRglGr8hOJZd3lzrQYJgVN9k+/iIJ
         14tPYheQ0aVmngizn+gsQRi7DhqDYHNq2I7jAFBiNN7eTnUpln2RcZlM4JBJeB47ppdL
         NN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005291; x=1703610091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lg73sX3i9a8aQACa3LQIeyAKZ2sxvdHhoE4dFqwZeRk=;
        b=ir+yfOiWGOnY4iQ82h0mjcIJyxeKV3oVi4IUmyW42q92imjdMTIBYfIoIhKfjTVlmu
         T3E1sJ5fOHo4VKmBTzKjx0AqlgkQIsPc9yG6lYnmfDpR4B0mMU9locw+fnJVDmCp6hM4
         Ek+dwj79W/Xlj1cQbLCOxKlj2KH/pim6RYSpjimXTxyyuf86SFKPVKagpBnuaLIcoWgu
         whTt2rpEUiaymIa9nFbbneO6myLhvWMwmeb9OsNMoUl1rJRCtT5KHsUPbY8ete2jsgf4
         iWfrSAtfFdn24PjBn+HIYVfEy7K2N1ntTXsvZOcQRK4fR3zChZC/nmaqeepAO3KbQsT9
         EkKg==
X-Gm-Message-State: AOJu0YzOY/o6GmDRZqxzTfU+y4pB8hqTkrazij0whjnbT0AvH20XpcdY
	u7z1Bq6+/8H5NA5VFi028A==
X-Google-Smtp-Source: AGHT+IHXi6Ragi4oBQ3GZNtFDmz9icVV62tivi8tCjIWJeMUtr3MMODMzP3LpyoP4WMp+2GJb/Pgbw==
X-Received: by 2002:a1c:6a0a:0:b0:40c:386e:6aa2 with SMTP id f10-20020a1c6a0a000000b0040c386e6aa2mr5197610wmc.55.1703005290969;
        Tue, 19 Dec 2023 09:01:30 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:30 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 25/29] drm/rockchip: inno_hdmi: Add basic mode validation
Date: Tue, 19 Dec 2023 18:00:55 +0100
Message-ID: <20231219170100.188800-26-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per TRM this controller supports pixelclocks starting from 25 MHz. The
maximum supported pixelclocks are defined by the phy configurations we
have. Also it can't support modes that require doubled clocks. If the
variant has a phy reference clock we can additionally validate against VESA
DMT'srecommendations.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
changes in v2:
 - rename inno_mode_valid -> inno_hdmi_display_mode_valid
 - fixed max_tolerance calculation
 - use abs_diff() instead of abs()
 - call in inno_hdmi_display_mode_valid in atomic_check

changes in v3:
 - collect RB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 8a1a2320749a..a2a9e54b76c0 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -26,6 +26,8 @@
 
 #include "inno_hdmi.h"
 
+#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
+
 struct inno_hdmi_phy_config {
 	unsigned long pixelclock;
 	u8 pre_emphasis;
@@ -497,6 +499,38 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	return 0;
 }
 
+static enum drm_mode_status inno_hdmi_display_mode_valid(struct inno_hdmi *hdmi,
+							 struct drm_display_mode *mode)
+{
+	unsigned long mpixelclk, max_tolerance;
+	long rounded_refclk;
+
+	/* No support for double-clock modes */
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		return MODE_BAD;
+
+	mpixelclk = mode->clock * 1000;
+
+	if (mpixelclk < INNO_HDMI_MIN_TMDS_CLOCK)
+		return MODE_CLOCK_LOW;
+
+	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
+		return MODE_CLOCK_HIGH;
+
+	if (hdmi->refclk) {
+		rounded_refclk = clk_round_rate(hdmi->refclk, mpixelclk);
+		if (rounded_refclk < 0)
+			return MODE_BAD;
+
+		/* Vesa DMT standard mentions +/- 0.5% max tolerance */
+		max_tolerance = mpixelclk / 200;
+		if (abs_diff((unsigned long)rounded_refclk, mpixelclk) > max_tolerance)
+			return MODE_NOCLOCK;
+	}
+
+	return MODE_OK;
+}
+
 static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
 				     struct drm_atomic_state *state)
 {
@@ -529,6 +563,7 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_connector_state *conn_state)
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	u8 vic = drm_match_cea_mode(mode);
 	struct inno_hdmi_connector_state *inno_conn_state =
@@ -549,7 +584,8 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 	inno_conn_state->rgb_limited_range =
 		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
 
-	return 0;
+	return  inno_hdmi_display_mode_valid(hdmi,
+				&crtc_state->adjusted_mode) == MODE_OK ? 0 : -EINVAL;
 }
 
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
@@ -590,7 +626,9 @@ static enum drm_mode_status
 inno_hdmi_connector_mode_valid(struct drm_connector *connector,
 			       struct drm_display_mode *mode)
 {
-	return MODE_OK;
+	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
+
+	return  inno_hdmi_display_mode_valid(hdmi, mode);
 }
 
 static int
-- 
2.43.0


