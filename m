Return-Path: <linux-kernel+bounces-2254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A5815A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F723B24396
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD46328CD;
	Sat, 16 Dec 2023 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPCSFiem"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADF3174A;
	Sat, 16 Dec 2023 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-552ff8d681aso883979a12.1;
        Sat, 16 Dec 2023 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744030; x=1703348830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enGw8p8B5CzjGv0S8y8E93U6rzPMRXDY8CyOli66yco=;
        b=GPCSFiem7awZ/Bq4UJclcJ+kSLCXPlRXaYcUyQ6FoObu64eXXspw0ZL9jdL0EwKRhk
         I8/C82sq6L44awNvcHCgvfk+vMqp2nHcKZmDqgo86KzFdnRNRxvrasZwUGbg0w/07om5
         Yzh4AxVjxNgywk1NBZ2WQPER5iCVujf1guN/XcUhYhdH6SF5rKHvBKJsYE6AIf6Q4azT
         ffbqriX/GsC2vlwXC4mHeTg0GVH1lJTtFEGfmFYa/icnvR0olWUBCeKqkHn4cuAlOavF
         xy6DKpjOCgAdWyFr2m776TZz70rMYjw5q121+lutTEfoQuv9XRLemyvxpsfj6L4jgNlm
         H9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744030; x=1703348830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enGw8p8B5CzjGv0S8y8E93U6rzPMRXDY8CyOli66yco=;
        b=Gumm/dgEIAuOgjtEs8uBeRdAp1pQy1+Mm7mt1asMR2fPvpvPIvpM9m0DAcVoRZbo5t
         8HxPyLgKIz5Va1ocSOymiKzgE445JBL7of+711POs1WoMd12XQtZHQAHCG84YXl+U+sA
         EikNid/FLVMFZtNxdPIBRr3m34cWve/F9ED9q4mpGcCyzJPF8FlFxxgzf5VaNaMbySra
         Jmifi7KaM3VEoKy3jce1tOVQs8qWCbjHhwQ2gLcLnFrHczkLikzHoD5/j6n4GGMn863F
         RkkXfx1v+WAeIkXO5EIQx5l3RyVaPcHNDRppAAynVyU8qLShGx8ac10m1i3rPm3W2tKd
         KQTw==
X-Gm-Message-State: AOJu0YyV/VetTANOkCcxYPvK5JHLRuyMGSutSbVFET1mCi6FvSP9eskU
	aYyJbF3ZM4fwQmJFM88WGbXNoNu4KQ==
X-Google-Smtp-Source: AGHT+IGw7FiYDghqDzTy3nLXlydCF1Rdkl1jTzgPRe5Ngs12gDtlJP7mEFvi4eD8tZOZvQbZfPvCdw==
X-Received: by 2002:a17:907:5c7:b0:a23:f56:98e1 with SMTP id wg7-20020a17090705c700b00a230f5698e1mr5449054ejb.18.1702744030650;
        Sat, 16 Dec 2023 08:27:10 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:10 -0800 (PST)
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
Subject: [PATCH v2 07/27] drm/rockchip: inno_hdmi: Get rid of mode_set
Date: Sat, 16 Dec 2023 17:26:18 +0100
Message-ID: <20231216162639.125215-8-knaerzche@gmail.com>
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

From: Maxime Ripard <mripard@kernel.org>

We're not doing anything special in atomic_mode_set so we can simply
merge it into atomic_enable.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 48c4f010b260..299770e481b7 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -490,21 +490,22 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	return 0;
 }
 
-static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_crtc_state *crtc_state,
-				       struct drm_connector_state *conn_state)
-{
-	struct drm_display_mode *adj_mode = &crtc_state->adjusted_mode;
-	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
-
-	inno_hdmi_setup(hdmi, adj_mode);
-}
-
 static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
 				     struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+
+	conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;
 
+	inno_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
@@ -533,7 +534,6 @@ static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.atomic_check	= inno_hdmi_encoder_atomic_check,
 	.atomic_enable	= inno_hdmi_encoder_enable,
 	.atomic_disable	= inno_hdmi_encoder_disable,
-	.atomic_mode_set	= inno_hdmi_encoder_mode_set,
 };
 
 static enum drm_connector_status
-- 
2.43.0


