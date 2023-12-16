Return-Path: <linux-kernel+bounces-2256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ABC815A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B262831A5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345F33CDE;
	Sat, 16 Dec 2023 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBiMK0U4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37031A82;
	Sat, 16 Dec 2023 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so214831566b.1;
        Sat, 16 Dec 2023 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744031; x=1703348831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnlt5lgm9qwa/3Pu0kcziAAeIBysCmQzwYaw/MNqgTo=;
        b=FBiMK0U4LEVnUWTLbgWevpBKncqA8DQFQG00i8TDAJHMhTEvsb60p8BPY4hqZfQ37F
         /iqcLMrLwAc3dppfWvZT/8+IlWR+W9WUlYYaaLQkrRw4QLOctXSUdfhMcxx9+OIz5btf
         dYJXhTf7QlTpihi8AwKJsJs5i934L1Kt0R4rp8M2oCZEvnb/kdAU/4xIxgHSrDQhuyiG
         GjBXwJEl8ZbPitIdIKmIKWN5X0AhPTSHjENGAW/+IIm0cJdd5sMk1Z0vJtvz9SycE4Pz
         i+1NamNvyok/LpWxMaP0FpOTkkgdg5e/M7kpNEk3MHXPaQm9X2xtObuSEEiwpPP0swB1
         0n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744031; x=1703348831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnlt5lgm9qwa/3Pu0kcziAAeIBysCmQzwYaw/MNqgTo=;
        b=TpG314+1OQSqss4+VnAjlKKY/8bKt2mHQ3N1XpMaOOtL3VT78f4oM1O5qU2ScBY4DQ
         xPmboPS7s2/PhGGDLz8oMuUsKawiyABB497RT8PZVqGOlC5F6CHPhkpDd1HhfiaGMd5L
         Zo2hTfQLs1YhNKqTCWJhCA/1hGwzMGAULYk7Fklv2A8Fdc9i9GCuAq+a+WCRO/LnKd2a
         kt0Qn1lBC0YmuC3Rsph2LymBOB/ClambOKc3Vy/+/C8dxQvdtG51cBN6D6eqjqeRease
         nxTIejBe8jnKrWkjXmsUJqVOeAcM1wFWr0WdUXyiX1mxdPgF3t+D/8QAiX5ekV5gnPN5
         w2ng==
X-Gm-Message-State: AOJu0Yz+0eCfAOGy6ug1eFCq6HGna4qAI/upp7PgbmqpFsuSkM8Wn/oI
	4ilJQsOzQrvJf1PFEL/qrU0gx9ytcQ==
X-Google-Smtp-Source: AGHT+IFv2/zw0ooG1yd0ojMj7vmNs6hU7B/IUbAwB2DH7Qa5Ghq8j9jjVMSVxr66g2NaXt7MFLjh6w==
X-Received: by 2002:a17:907:3da9:b0:a1c:898e:6a0c with SMTP id he41-20020a1709073da900b00a1c898e6a0cmr3708081ejc.210.1702744031312;
        Sat, 16 Dec 2023 08:27:11 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:11 -0800 (PST)
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
Subject: [PATCH v2 08/27] drm/rockchip: inno_hdmi: no need to store vic
Date: Sat, 16 Dec 2023 17:26:19 +0100
Message-ID: <20231216162639.125215-9-knaerzche@gmail.com>
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

The mode's VIC is only ever used in the inno_hdmi_setup() function so
there's no need to store it in the main structure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
[made checkpatch happy]
Signed-off-by: Alex Bee <knaerzche@gmail.com>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

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


