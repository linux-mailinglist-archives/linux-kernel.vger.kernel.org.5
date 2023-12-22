Return-Path: <linux-kernel+bounces-9951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC481CDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E6C1C2218B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1EA2C1B5;
	Fri, 22 Dec 2023 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwJU9ftp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8228DD2;
	Fri, 22 Dec 2023 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so1336666f8f.0;
        Fri, 22 Dec 2023 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266944; x=1703871744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0neXejdyKcMYrQeMYfWnn6/UkX9PKjLjeZy6MNbiAE=;
        b=dwJU9ftp43M/s8kTuFvinvim4AUho8Bbhu9R087+4ZiDt2sey5MxfFFgmvgKQcd3CH
         wyvuKkwWlTbD+87sh0PDF9sW0pTR7eNhMagLV0EflKnivZ8u5KpXD+TvD6AAjvCDBkfF
         imRVWpGniu+kK4cbHEOKrXWEhhIizyrk8K6a/WCapaWjoDSLHD+LU1TYF1PzJ5YepEhX
         9MHbEKMo/p4Gt4ZIrRN+XZGtmIkkR6HwyUjY7/2+0SSxYjhRQ5Ibx6iADJTPgDuvadBn
         0Qv5oTkteUBgz1x0N3+PNxpQYgz7vkya12PvyS03pm+OFEdYEcrNOiVzjQtbwIC1zhQq
         gO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266944; x=1703871744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0neXejdyKcMYrQeMYfWnn6/UkX9PKjLjeZy6MNbiAE=;
        b=nqlBtGMibJLhHrTRWR/KG8LqhXMoNJng8+h9C4r57fG7OXUYuu1rOpl/pQrLcxZT0l
         8ekuq3YzOUKWFaM/kZwLeIxRvC2cVwKRlHq33TEyCBsofilV2rHN7gnL0Cmzk4XCX8dY
         bH+06PW+OZAXLd+rMnjTwTa+fAoI4j3O7aUCC828nd0v5AALr0u9xH11C35hkSLH23lz
         C5/zz0c+KBG43gA2hPbMKl0JNkJKwgdCEc9fbnlWW9e+kwxpWeCzTX5CvxKALpd3b757
         6/cSQEGzzVgrU4SVs/XNhsWgoE3ZB61IyjuYAHelPGCV1yq3Zi6XFzoKeyZiLbK6Gsaz
         stcQ==
X-Gm-Message-State: AOJu0Yw06xnWBY82Xdo8VPMLynkdGrkH55i33RKaF9aRp/Wk16oxMqXH
	jsqIOXnPiFHlFBf/ySI9nA==
X-Google-Smtp-Source: AGHT+IHgMx+o2VEbHPVQJ4P/KXTppQFx3koXaTkd1ZRvghWFSrx8ldGUAziC02wAFGucwtqAJI5Y4A==
X-Received: by 2002:a5d:5341:0:b0:336:8485:d870 with SMTP id t1-20020a5d5341000000b003368485d870mr954023wrv.65.1703266943886;
        Fri, 22 Dec 2023 09:42:23 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:23 -0800 (PST)
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
Subject: [PATCH v4 02/29] drm/rockchip: vop: Add output selection registers for RK312x
Date: Fri, 22 Dec 2023 18:41:53 +0100
Message-ID: <20231222174220.55249-3-knaerzche@gmail.com>
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

In contrast to RK3036, RK312x SoCs have multiple output channels such as
RGB (i.e. LVDS TTL), LVDS, DSI and HDMI.

In order to support that, this splits output from RK3036 and defines an
separate one for RK3126 with the registers required to enable the
appropriate output and setup the correct polarity.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - rephrase commit message

changes in v3:
 - none

changes in v4:
 - none

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 13 ++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index c51ca82320cb..b9ee02061d5b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -227,11 +227,22 @@ static const struct vop_win_data rk3126_vop_win_data[] = {
 	  .type = DRM_PLANE_TYPE_CURSOR },
 };
 
+static const struct vop_output rk3126_output = {
+	.pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
+	.hdmi_pin_pol = VOP_REG(RK3126_INT_SCALER, 0x7, 4),
+	.hdmi_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 22),
+	.hdmi_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 23),
+	.rgb_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 24),
+	.rgb_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 25),
+	.mipi_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 28),
+	.mipi_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 29),
+};
+
 static const struct vop_data rk3126_vop = {
 	.intr = &rk3036_intr,
 	.common = &rk3036_common,
 	.modeset = &rk3036_modeset,
-	.output = &rk3036_output,
+	.output = &rk3126_output,
 	.win = rk3126_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3126_vop_win_data),
 	.max_output = { 1920, 1080 },
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index 406e981c75bd..fbf1bcc68625 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -872,6 +872,9 @@
 /* rk3036 register definition end */
 
 /* rk3126 register definition */
+#define RK3126_INT_SCALER		0x0c
+
+/* win1 register */
 #define RK3126_WIN1_MST			0x4c
 #define RK3126_WIN1_DSP_INFO		0x50
 #define RK3126_WIN1_DSP_ST		0x54
-- 
2.43.0


