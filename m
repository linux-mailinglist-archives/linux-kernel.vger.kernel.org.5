Return-Path: <linux-kernel+bounces-2252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB4815A36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E01C2184F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FAC31A85;
	Sat, 16 Dec 2023 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTLyyQTy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB230D1B;
	Sat, 16 Dec 2023 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso2051734a12.2;
        Sat, 16 Dec 2023 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744028; x=1703348828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyAWfNkXQL+v/gZSDlmmFF5ztG5yHb26ZkJxvxzB8Hc=;
        b=MTLyyQTyFUzMRpweOwN2a4P2t6HZlLsvqYYCzfi5ACj/FoJB7OPE/VxNKS1i5I1N7b
         UW3wpFOkZXX4uKUEhIMBuosEDvUZEKYA73lEESiZQy709pH1UAtjyT9bb6QVJv1MGmZL
         t3fPSVS6DJ4bJCSgFWvJ4vO5tTrVbDAeQ5lA+MJLGCmLfMatZ39zu//YbXMR5QAV2oga
         TbNw3EWQCsjReb0xOJpA9lZVjtGdHVZ5W98IDKxWeZpJ/TskKJWEprcWNUHBEXfPiC2T
         5pl52dxrovT/7ZkgfEUFguRGimXLs5iMAmcx1Pza0sGv3asdSjpRQt5AuIST/6lWnwlb
         JbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744028; x=1703348828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyAWfNkXQL+v/gZSDlmmFF5ztG5yHb26ZkJxvxzB8Hc=;
        b=D2HDZ5F9xsi9ODeoGbuJuUcMpFXwDBa9XeSuFZXAAXFElI+JFWeME1aE5/HlWlrAOp
         tZpxl4ch/3ibwGywpb4gYlKqxLUlXzUFtkIhnaPagqtQSpYrg4XB0NSbBbs1BCx0Y/ZV
         nY6UR9UPCITb1eUWiBki9GyQ+eVbEa2F8K8I70InlxtOSV2oUkMmjoVRZvnm9KFFwE/B
         NJhavkr/4dNxGUc92F6XxtJdKCgObznpzpLZqr7B6y0Ue7ZtjWOZBS0fGIp8ZcLryAwM
         HUflKt7OFmsenPO2rD303zKet0aHlHI8FFZzsrdY3+3mJoYlSueBV03FRRb+HKg4p0Jh
         gujw==
X-Gm-Message-State: AOJu0Yx3s3lFrHjkV6ROrWeAphS6T0TYitsuVrfWyMHKnKd0oF1Z584N
	2xh6gpsD9Y8rRiUsdb2xYg==
X-Google-Smtp-Source: AGHT+IG3ytNKpYhW3AxvamdKVLTOk5M5VW41roA7N2pAlKA2C2kww6MnweL75Ttzw+MUjezGDENIdQ==
X-Received: by 2002:a17:906:6a1d:b0:9c2:2d0a:320c with SMTP id qw29-20020a1709066a1d00b009c22d0a320cmr8522242ejc.46.1702744027873;
        Sat, 16 Dec 2023 08:27:07 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:07 -0800 (PST)
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
	Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>
Subject: [PATCH v2 03/27] drm/rockchip: inno_hdmi: Fix video timing
Date: Sat, 16 Dec 2023 17:26:14 +0100
Message-ID: <20231216162639.125215-4-knaerzche@gmail.com>
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

The controller wants the difference between *total and *sync_start in the
HDMI_VIDEO_EXT_*DELAY registers. Otherwise the signal is very unstable for
certain non-VIC modes. See downstream commit [0].

[0] https://github.com/rockchip-linux/kernel/commit/8eb559f2502c

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Co-developed-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - none
 
 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 6e5b922a121e..345253e033c5 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -412,7 +412,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -427,7 +427,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


