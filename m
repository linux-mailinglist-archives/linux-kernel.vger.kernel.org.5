Return-Path: <linux-kernel+bounces-5645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33137818D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B945B25C66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A641C72;
	Tue, 19 Dec 2023 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbTs8Oo7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970C40C09;
	Tue, 19 Dec 2023 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c2308faedso56875975e9.1;
        Tue, 19 Dec 2023 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005292; x=1703610092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arQ8xIKVUtWj1nUwdouDUReL6yFeDt+BlaNGpwFH10c=;
        b=RbTs8Oo7u6lWQN4ritpdDDtCnEZyYNqr3daLnGr3XpV1bsq24lQMnl6xaFRlc0Vmry
         lWaMXh57LHQqN+Asnv6Lps9gJb1mjKoP7e4DFObAwbE1hdzrzQOQ17D5op3/SFya+obg
         HJtuEXY5vtEImSmti0fqPLnGLXc6GOrkb3wBO1ibeNX5FkZP6waVw2IFEnJvq4Zgxyje
         OthXovLYBf3dale2ZvJ3GGh4rlgI/q8Ju63KHrczvWCD3DxvqBhu9v+o74fZ9EqHK0ty
         h5VqcmKzbQ0DT0rdS9TvSShMyVIfY/I/xq0SgjxneJlorPIu1ZGl+hwKwFaVRyseipC+
         /p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005292; x=1703610092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arQ8xIKVUtWj1nUwdouDUReL6yFeDt+BlaNGpwFH10c=;
        b=MvpTSOV/JzNJLJN6CWfiv1aCGdBHqcBVSRx2mTatLH8IcV8U948Unrpx0rKNykG7y1
         3cF1YYpQ6TQj84ruh6OSWqpScf1AHARxe7HXbIxXgQ0gQrAlJdKWxz+ZA+ElxOGYGdhD
         Gawg3klC5pJlog+DPAQXj2nKv8ePExcpXQF7AayAV+4yFCUcJQB9XBsGBRqNYl8d9IzR
         34i5WX7BaW8AiL95W5i6xkxbX9eoq4lduBJaV2mhf4fjzzEJrZxQGzmgfnf8kgJKdY3x
         JiYUxEXjM+FnWGMmHQwGHjqTWIbcXPwIksnNA7P6ulTGvWZ5zHB2H7yPN2u1nJTI7oCr
         oC2Q==
X-Gm-Message-State: AOJu0Ywq7Iex7av+xEAGYormncQf7FhZC5+0SNKj7DhPMESMi+rR0EhB
	SdIx3kbqi9bDrY4bBh0F1Q==
X-Google-Smtp-Source: AGHT+IEm8HS6oHyVinKk2y2E+36YVQQ/TKqJ6BvNP4pRKrkPrVlgTtkIQOEcQo7tQa1nD+AR7BZaTw==
X-Received: by 2002:a05:600c:4f52:b0:40b:5e21:d362 with SMTP id m18-20020a05600c4f5200b0040b5e21d362mr9931502wmq.107.1703005291752;
        Tue, 19 Dec 2023 09:01:31 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:31 -0800 (PST)
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
Subject: [PATCH v3 26/29] drm/rockchip: inno_hdmi: Drop custom fill_modes hook
Date: Tue, 19 Dec 2023 18:00:56 +0100
Message-ID: <20231219170100.188800-27-knaerzche@gmail.com>
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

Now that we have proper pixelclock-based mode validation we can drop the
custom fill_modes hook.
CRTC size validation for the display controller has been added with
Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
hardware capabilities")

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
changes in v2:
 - no changes

changes in v3:
 - collect RB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index a2a9e54b76c0..29a2c1b87294 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -631,13 +631,6 @@ inno_hdmi_connector_mode_valid(struct drm_connector *connector,
 	return  inno_hdmi_display_mode_valid(hdmi, mode);
 }
 
-static int
-inno_hdmi_probe_single_connector_modes(struct drm_connector *connector,
-				       uint32_t maxX, uint32_t maxY)
-{
-	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);
-}
-
 static void inno_hdmi_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
@@ -691,7 +684,7 @@ inno_hdmi_atomic_destroy_state(struct drm_connector *connector,
 }
 
 static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
-	.fill_modes = inno_hdmi_probe_single_connector_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = inno_hdmi_connector_detect,
 	.destroy = inno_hdmi_connector_destroy,
 	.reset = inno_hdmi_connector_reset,
-- 
2.43.0


