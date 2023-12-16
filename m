Return-Path: <linux-kernel+bounces-2271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD2815A61
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58003285477
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7B40BE6;
	Sat, 16 Dec 2023 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElayTmm+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D73D0DD;
	Sat, 16 Dec 2023 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso1827092e87.2;
        Sat, 16 Dec 2023 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744042; x=1703348842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8OEv0l6dNVJqHF1ONziiRRjeg+pBs39OamlQeNnAzk=;
        b=ElayTmm+GXaHUkL7hbPK4rZxtF6XsrGsoQe0xrUK83FScyzB6U5XdkPgUowADgUBA0
         swggymZAPhzNWNJB6ct/SsGrzwgf1MrKnerb+Td73qLH2n/HEHtcWSwbM9H1JQr72fyl
         /y4IUb3blKyRNI9EfbZySMxdoPC8BMFDGFofikCm2657Pd0o9ZFVP5As98PR8seNyJ3y
         +cKeVDXWG0b7RDn9AVONchVCKx/GjLg6gKmqdrDFT0qhOBReIQaKceIpbTUbNkmeW7SD
         4ni9qc88HfB8acRanhzYFwdAofeTaTaSTIwpx6QERkXBH7Lu36U77S2ZSZ2cIc5fcA1X
         UCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744042; x=1703348842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8OEv0l6dNVJqHF1ONziiRRjeg+pBs39OamlQeNnAzk=;
        b=C5ki7xYIWPvLYyyBRIsduTSeM9CWIG5wHsK1rnrs8pQ73WWpaN/pNx578zc69FAUf0
         PB7HAnJbq+GlrKh4N/yQIa0ciEaoCRGxICObpMDaX9iLlM+xGPrUIEQ5tJDnvlgDUUT9
         raDxiDSxrvKuMXKcM+VNhS/nU6drfkG4um7875OPkhbBEpGVfB/f5klL98xmEgMGGjh4
         S3CaCe7D5C+ypi0FPNk4WEmhFYA8V04wOr2K6zVctBWS2tRUZ5JBfozHfzRFX91SRZ4J
         nBCS5UPw9KJaqslqh2B30tTVpsKZ+1aFO4znpaJpDLDruPY4wo5VjZNDnZw9WVHXSTRV
         +Wzw==
X-Gm-Message-State: AOJu0YwvSolG/jSju4M/QoOrrda7JVoH/V718ETCHY2wlF3GAupBCSMq
	ItBZb2LBuFRC7+fLIBEX1A==
X-Google-Smtp-Source: AGHT+IFEHvRQbTKnZvTIoMFV/ssuD2uNon+ejyGS9XyVQHiyLyghPQz2Vh5IUyEFL7l0qFs8Pgr0pg==
X-Received: by 2002:a05:6512:1327:b0:50d:6249:17cc with SMTP id x39-20020a056512132700b0050d624917ccmr3309272lfu.245.1702744042393;
        Sat, 16 Dec 2023 08:27:22 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:22 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 23/27] drm/rockchip: inno_hdmi: Add basic mode validation
Date: Sat, 16 Dec 2023 17:26:34 +0100
Message-ID: <20231216162639.125215-24-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
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
---
changes in v2:
 - rename inno_mode_valid -> inno_hdmi_display_mode_valid
 - fixed max_tolerance calculation
 - use abs_diff() instead of abs()
 - call in inno_hdmi_display_mode_valid in atomic_check

 drivers/gpu/drm/rockchip/inno_hdmi.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 792e5fad09bf..14473ca96e0f 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -26,6 +26,8 @@
 
 #include "inno_hdmi.h"
 
+#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
+
 struct inno_hdmi_phy_config {
 	unsigned long pixelclock;
 	u8 pre_emphasis;
@@ -548,6 +550,38 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
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
@@ -581,11 +615,13 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_connector_state *conn_state)
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
 	s->output_mode = ROCKCHIP_OUT_MODE_P888;
 	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
 
-	return 0;
+	return  inno_hdmi_display_mode_valid(hdmi,
+				&crtc_state->adjusted_mode) == MODE_OK ? 0 : -EINVAL;
 }
 
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
@@ -626,7 +662,9 @@ static enum drm_mode_status
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


