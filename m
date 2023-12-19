Return-Path: <linux-kernel+bounces-5621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08593818D51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DF6B2464F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9C34557;
	Tue, 19 Dec 2023 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTe2ZN4f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF620DE0;
	Tue, 19 Dec 2023 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso56957465e9.0;
        Tue, 19 Dec 2023 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005269; x=1703610069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uClaQQ2dRjLaUKPRgkZZsqsXWCBLw2oyW3zHKJRRqCQ=;
        b=PTe2ZN4fgiZ06579gZZOQFCsE+SlG3Kij9e/UIQ0/9apXPXF3/qbWInkmFuULsScDJ
         /Re70XvtGsOHayTMEat3Wug0ZYmpW6viRawc/uYAa8ZCxr0g9h6Zny+N6OD/EZWCyz1G
         CDB4N3FbQZsOighRD/LmQLQG3g33jn0a3GkY54bkoy6B2KD8VUpeExziEtB7Cdrf0SNC
         9oEJ9a5umSP//bXTpGHL5EOuDvJzMYogUrbUYPmXpf6EO7/JNbiftG0vTJST7f71J497
         N0vjT0SEQ3ntGASc/R78xhEDmBx6kddHwPBvffBbi3iWYs644/iC9h6UjvCNm2GoFBDf
         PjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005269; x=1703610069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uClaQQ2dRjLaUKPRgkZZsqsXWCBLw2oyW3zHKJRRqCQ=;
        b=bW1Y65SCECURu4e5Hk+Gyu4Qe72iTlumu8XIFwur5D46l4YFU0wj9xUrU3YqNeX/7G
         r9ioULlKeY/5AtaSQhtkzdXDAzJBtiEW3/bpkndu1NsWYdbA8GgQyBGH7wI7JpDdAv2j
         KXTWj+lWVXI64WsQ45uonK0hkH/Z3eY/DKHR2QOHV/5lT+Jg32sriJ9LLVSrVCqLgUaX
         CzEnZScMHhjYXA7W8/QMtFdU61RwHrpC6jSRodQTKCfHQywpIcVBJ+VY7qzNXMW+CTRe
         E9znlWCIXCEUapxF/1BQyUKBkRZyAFh+shIbS2y9SJ9pD9EFX+RQAs/HN/+QU4XXZLBA
         bVSg==
X-Gm-Message-State: AOJu0Ywh4o0msj5XGWrm1S+alNffA7+NGDrLEC7IKXQ9K221eYWiSOER
	XzAAPtAltf0vsjZoEqJW3g==
X-Google-Smtp-Source: AGHT+IFjM19BzeJ7opBdpwxu2A1HFwreYdOm1l3GDNQQNs3Nw6kKgPMgszKGHl0AEjwpNwVYqeSAcA==
X-Received: by 2002:a05:600c:2212:b0:40c:6160:98f7 with SMTP id z18-20020a05600c221200b0040c616098f7mr5158875wml.17.1703005269466;
        Tue, 19 Dec 2023 09:01:09 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:09 -0800 (PST)
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
	Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>
Subject: [PATCH v3 03/29] drm/rockchip: inno_hdmi: Fix video timing
Date: Tue, 19 Dec 2023 18:00:33 +0100
Message-ID: <20231219170100.188800-4-knaerzche@gmail.com>
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

changes in v3:
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


