Return-Path: <linux-kernel+bounces-2250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0520815A32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD86B238B0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082130FA1;
	Sat, 16 Dec 2023 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV/CDwrx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305F30662;
	Sat, 16 Dec 2023 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1f0616a15bso190965766b.2;
        Sat, 16 Dec 2023 08:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744027; x=1703348827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Lm26+4tm6Q9dy5TiKyQzH1wZ/PMiBfYpwbeTXzDXzY=;
        b=NV/CDwrxIKEOovhSvBgy9czdYvWrYP01xZCrxuRiYLtO5nn1ZRKtGUIWJ8g8WiDorU
         0CU6hQfRm9F61WNNOT2NlAcW077SK0bM8nbiepAXWLLWInDGW0elbFq2mBvl7E1sEN10
         wJJm+7aMHMPBbhZH9jdNs4tah3w8M/GrSoSFExQpSVazo5M/sdKk0DP8edCd9UU8F5t1
         o6j6Db/7EBYDiXGpplV9LLdRe8Yj8qmF+HNTwKh5OqaYVWOH6Rdxl0Q/YnVDBK7Da4VF
         YH+yCdQAd2LefAkI7Ubt5Wi+MF0YhV/7l8HamY+OGWFmLq/uQZsHUdTL++G1QNpcM06q
         mgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744027; x=1703348827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Lm26+4tm6Q9dy5TiKyQzH1wZ/PMiBfYpwbeTXzDXzY=;
        b=ltMvoS280ieEK6oqfjCUGKwcZzFuDpz2LCJUXYyDEyucxtivhsJGN7APxzphY8kvXr
         uyV5hwAo82GUTlq9iSQQtgP4JtH+AtOtscSEgHyjDuzJ2ftHuQRQgWt26hZNz7ePLux7
         +03NSpiBTbPtsoTkxRdMmum9AQsHiKRBfJ+dJNvX8iW533/qf/8PaaRTsqoX0ncR1Mk7
         e/gwxw/KP/UAhMTczDXLRJ8EsLeAUuJTJnsZEJXi1VQiiAseqtY05Uk1hvThsvlPfmdL
         0tKVgFUhGqX8ygX4+HVT7x8vVc/7hLUEMlIUT6ZM3dvhlG3QT+AIoOqyZhYUotjdxSbW
         ceTw==
X-Gm-Message-State: AOJu0YyOcZFIlTumT5luhX0LShe8eLOAth+8GYB6ay2bdBeqF3QYvf6E
	9MpT24lCYQy3C7iYoPVHaQ==
X-Google-Smtp-Source: AGHT+IGZ7VeNHGWq+1VZP4LYh9qX3NgWRdPWJnURnN0HnbB2LJH1KRm9aL1BAMwgow9ZPeylMhQF8w==
X-Received: by 2002:a17:907:208f:b0:a19:a19b:78a7 with SMTP id pv15-20020a170907208f00b00a19a19b78a7mr7159079ejb.106.1702744027021;
        Sat, 16 Dec 2023 08:27:07 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:06 -0800 (PST)
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
Subject: [PATCH v2 02/27] drm/rockchip: vop: Add output selection registers for RK312x
Date: Sat, 16 Dec 2023 17:26:13 +0100
Message-ID: <20231216162639.125215-3-knaerzche@gmail.com>
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

In contrast to RK3036, RK312x SoCs have multiple output channels such as
RGB (i.e. LVDS TTL), LVDS, DSI and HDMI.

In order to support that, this splits output from RK3036 and defines an
separate one for RK3126 with the registers required to enable the
appropriate output and setup the correct polarity.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - rephrase commit message

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


