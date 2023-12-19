Return-Path: <linux-kernel+bounces-5626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F7F818D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A0283E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14D37D25;
	Tue, 19 Dec 2023 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUZZgW+A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054536B09;
	Tue, 19 Dec 2023 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so54679255e9.3;
        Tue, 19 Dec 2023 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005275; x=1703610075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvJhWTUaZ1kAS2FjYOCcewK/+2L6xqjKsMInEMuEacc=;
        b=YUZZgW+ACrnUlHzbpSAvOAbc6Rf3T92GNxJ6eikJLhAFB2OjIX4NrIcZUpiMMNt8iW
         e/9j0aeOdiUJagwZ5WplDvDkYO5LZ0CY45VY9Mzhru9UFCMLAR14a1UZ8IvVgW2w6ygY
         FYS1Naa3VgWrtYbwAncEO6Ue20lGe9VqEoaaNYi/um8XJoE6Fvbq4rGXL/ZpQDihLiyM
         e4RdBPFY5iL8v9dH7mubknAgBQLB0+CjmNkEybI7QG9dlvMXVgrD7zXBJ/uZA5ynooUz
         RB18d425ZynI01LbeFzELVcUqvUqQ3rWlACK46w3vTFLplUr7fVkqgA7lSTFDAw9Qffs
         y5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005275; x=1703610075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvJhWTUaZ1kAS2FjYOCcewK/+2L6xqjKsMInEMuEacc=;
        b=B2ywCuxCF7zviMwzvopm7U1Rn5pPh8sl/hLjppr4NH87Ml/jEB1KjG/dHBbSOplLGs
         89/BJUiBHJ6uz7I/ETIeibmN3XMRY918jPvIhbzdQsbPvT6FziPzZEClHhWzaQvMAJaJ
         1ZLzQQ85JGB859ud8WWMAhKCZp/fPrS/f3S2tQARQOWhVpx5TKwrzQ1HZP/SnPhE2Mhs
         oFgkEaXXhg1uMT9Xs3usd7MKpyJr5pS5DZkwVTu8FdkuYWhHjXGyakdSdfMnmWlKjkCo
         nzvUGBpC/crvCxKOypaG+Ul5b+3LBmLijLkQnsNvtwQlYyC5XqbpbirJ/0OstEWl5h3R
         FKEw==
X-Gm-Message-State: AOJu0Yy/Q5pBXRLma0G0WE82mRROd7m4Fx3KR7M5B6HlyOBUnAbda9X0
	q75uvmMsNwJjtZgmnUnxFA==
X-Google-Smtp-Source: AGHT+IGSTG2bZEzpSu8nSWJckWftmgfOLD5ECMR1O8HR3EFeEhnatTb8aS+6tL1yBM93D+staL9K0w==
X-Received: by 2002:a7b:ce8f:0:b0:40c:2205:e5f6 with SMTP id q15-20020a7bce8f000000b0040c2205e5f6mr5185131wmj.293.1703005274526;
        Tue, 19 Dec 2023 09:01:14 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:14 -0800 (PST)
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
Subject: [PATCH v3 08/29] drm/rockchip: inno_hdmi: no need to store vic
Date: Tue, 19 Dec 2023 18:00:38 +0100
Message-ID: <20231219170100.188800-9-knaerzche@gmail.com>
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

From: Maxime Ripard <mripard@kernel.org>

The mode's VIC is only ever used in the inno_hdmi_setup() function so
there's no need to store it in the main structure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
[made checkpatch happy]
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 299770e481b7..d99896f1a73a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -28,7 +28,6 @@
 #include "inno_hdmi.h"
 
 struct hdmi_data_info {
-	int vic;
 	bool sink_has_audio;
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
@@ -443,16 +442,15 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 			   struct drm_display_mode *mode)
 {
 	struct drm_display_info *display = &hdmi->connector.display_info;
-
-	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
+	u8 vic = drm_match_cea_mode(mode);
 
 	hdmi->hdmi_data.enc_in_format = HDMI_COLORSPACE_RGB;
 	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
 
-	if ((hdmi->hdmi_data.vic == 6) || (hdmi->hdmi_data.vic == 7) ||
-	    (hdmi->hdmi_data.vic == 21) || (hdmi->hdmi_data.vic == 22) ||
-	    (hdmi->hdmi_data.vic == 2) || (hdmi->hdmi_data.vic == 3) ||
-	    (hdmi->hdmi_data.vic == 17) || (hdmi->hdmi_data.vic == 18))
+	if (vic == 6 || vic == 7 ||
+	    vic == 21 || vic == 22 ||
+	    vic == 2 || vic == 3 ||
+	    vic == 17 || vic == 18)
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
 	else
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
-- 
2.43.0


