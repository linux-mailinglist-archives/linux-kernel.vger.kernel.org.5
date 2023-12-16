Return-Path: <linux-kernel+bounces-2272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFB815A62
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DEE281F82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0028930CF0;
	Sat, 16 Dec 2023 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8jvLg2y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2103E49E;
	Sat, 16 Dec 2023 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bce78f145so1846987e87.0;
        Sat, 16 Dec 2023 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744043; x=1703348843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMBynW0XhMl+E8jO2xYw0fAFMrIK4HAqJAW8qk9Tvbk=;
        b=C8jvLg2yo94U0E3qS9G97SOZUwQSoR9mkAiQJal4CunhY7huXN23BLFT1+7I7MVpY8
         7gN/nlMwq1PAVeXe5hlt0H0NAJPZmqfY6j6ez+WwUq8BTXW+WnRxOr0hTjYgP7ZgSU5L
         iWs0Dhl6bqOUXmLxTKEQ78kUTv1beq03q+IAMFG8cjoRBo3xL/24BbyaMvF2WbQ6HZb9
         RIe/BZCHACsi+3gn3w/66HBI8LcjazSqEzQKzCigYMhgyGHsU3ZYoYXjF5C5PKwSZEsZ
         JdG+U3faZASuSIktIE3Yp+I4hPulwsKHSPpOykG/HAnGz3yKQGRgyhu0fCJWjXfAdGPG
         KIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744043; x=1703348843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMBynW0XhMl+E8jO2xYw0fAFMrIK4HAqJAW8qk9Tvbk=;
        b=YLpig4KoOOHYytrKbjmaYQjADg7h2SONDZ2QRJWerOSxTthUF+0xArpQVFET1ZdBJO
         SwrO9ajBgAWV9xXwpnrL1L8x46r28bC6AgAIgqgi6nO1j+xpyTX9Z8AHBhm8J6ICJKPx
         pRQl9Oi2/r18+r1Xes1gAO3Xj7K2gjgvmfgKuTAkENRA/+WNonl3M7yYIkMO4zZrnCkq
         D0lQOqN7qfJNSFBiK2BghVSy7ccikPddppWkOJrkCeDFZqsNVPjCZIzHjI9pHaDftZBb
         BYhFkDNDl36zY1c1BVJFkxokZ+d2GwyvZTJEI4meGz33WN3XylX3SyRe9n+vQXBXOprl
         CzXw==
X-Gm-Message-State: AOJu0Yww4M9iAOc+pYKF3vr5uEg785bHtPXpxXUQp9ar0mu3e60fblop
	r896bmywoVl9Cq5arsvSQeKJfSoK2w==
X-Google-Smtp-Source: AGHT+IETdaeg0faWSQ1kmwbaQCOpBidvPKReyG1VUQs/IwAoTIeCSP7GXEKcKNtGmATpxPyBDsVDVg==
X-Received: by 2002:a05:6512:2352:b0:50e:1b0c:1143 with SMTP id p18-20020a056512235200b0050e1b0c1143mr1151682lfu.53.1702744043055;
        Sat, 16 Dec 2023 08:27:23 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.22
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
Subject: [PATCH v2 24/27] drm/rockchip: inno_hdmi: Drop custom fill_modes hook
Date: Sat, 16 Dec 2023 17:26:35 +0100
Message-ID: <20231216162639.125215-25-knaerzche@gmail.com>
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

Now that we have proper pixelclock-based mode validation we can drop the
custom fill_modes hook.
CRTC size validation for the display controller has been added with
Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
hardware capabilities")

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

 drivers/gpu/drm/rockchip/inno_hdmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 14473ca96e0f..d477d2872195 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -667,13 +667,6 @@ inno_hdmi_connector_mode_valid(struct drm_connector *connector,
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
@@ -701,7 +694,7 @@ inno_hdmi_connector_duplicate_state(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
-	.fill_modes = inno_hdmi_probe_single_connector_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = inno_hdmi_connector_detect,
 	.destroy = inno_hdmi_connector_destroy,
 	.reset = drm_atomic_helper_connector_reset,
-- 
2.43.0


