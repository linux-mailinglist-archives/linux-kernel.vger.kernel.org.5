Return-Path: <linux-kernel+bounces-9956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88F81CDE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19541C224EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB002F871;
	Fri, 22 Dec 2023 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw/f5pss"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2C2E826;
	Fri, 22 Dec 2023 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336788cb261so1662129f8f.3;
        Fri, 22 Dec 2023 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266947; x=1703871747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3GkVjgO7xCOhsoyA3/cHuRL2/Yb9XCTkkYsuRn5/o8=;
        b=Iw/f5pssDhztQKeAAtTOCYb1VhSRdml6Y/HVm162l6g0ZJEn/FdEdhhTIrlPoIk+7r
         pdQsYFQ9hV3iMVUuVzJNVxAtZdAu3J2AnQ6z4Os0s3JXBVwNJX/dPZr4S1VJXY49gNDT
         suY7Hixj5rMvBUbqhxIqXNSj9SmpMIq/jFURJZmfkQWxfyoWsyqab9jdk4g61VtAdnj+
         vfB3PkZKtRNehZmh7Jz/23ItSNwULA5KJnX0xcdR40N78J/Z82xkQSB7shthYV43Yrj0
         AUnln+17/GYtLrimkpeQqALKBK7I0VqRHI7obOA+xB0FPNd9kQYoOniQexcYIJZr3OZ3
         S79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266947; x=1703871747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3GkVjgO7xCOhsoyA3/cHuRL2/Yb9XCTkkYsuRn5/o8=;
        b=KeWstFnfDZ+Ou48TpC9LjqgsgPvb+Lr4vhMZoQ/E2GWhKi9kfjXmnJrp3O40dIKB7n
         N01lPXRekaINGyT47h5RtV/lLStkFvc9iIQreyKciEV9gX7MnbBsJ99hGJBxoAcZJJrk
         Uk93oRNKxVlSEfkywp8AmXyXoeuTN6yP9/Dw5BoH1cPTorZFATiXK/RdTpM0Xrwf5pmW
         AnB1wC/gGtavmyWqlhhx9/lI+nVvBi0QXx+T+cxxFOA0Pm5xsTTJqjWvQ6xXSajCu0RN
         C0sCgJt3N50TQ0zmxL/BPYHu4zpUfbAVqb39CWS0romEYgKhslFWBFfkGCID8X/VSsH5
         NJ4w==
X-Gm-Message-State: AOJu0Yz6Sp3BtFW9z4XBK/6lQnGIQlc9/mEQKoTam5v3/nbNWZbPpavc
	vY/r7qI55UOtj8q6HScTvA==
X-Google-Smtp-Source: AGHT+IHX+9/MPXHlLJ3T80hITMDfMHWCaU/WAybii+j6ocgFvzMfV97yoJKax2k3/7nsxxV6QrfASA==
X-Received: by 2002:a5d:4cc3:0:b0:336:788b:f064 with SMTP id c3-20020a5d4cc3000000b00336788bf064mr959130wrt.23.1703266947305;
        Fri, 22 Dec 2023 09:42:27 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:27 -0800 (PST)
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
Subject: [PATCH v4 07/29] drm/rockchip: inno_hdmi: Get rid of mode_set
Date: Fri, 22 Dec 2023 18:41:58 +0100
Message-ID: <20231222174220.55249-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
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
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

changes in v4:
 - none

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


