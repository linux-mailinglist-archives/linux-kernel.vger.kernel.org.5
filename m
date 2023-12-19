Return-Path: <linux-kernel+bounces-5641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E0818D81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D191284787
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33DD40BF9;
	Tue, 19 Dec 2023 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah44Db2w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF93D0CD;
	Tue, 19 Dec 2023 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so48018385e9.0;
        Tue, 19 Dec 2023 09:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005287; x=1703610087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlneokmKF1TajoqU6rsqTKLh9Q2KoTuUiBV9HAc+RDM=;
        b=ah44Db2wrbv2BqVMt+FErRXDRvYOsk/W1wIWNrEY2QFeTOoyEX2ZVmlpwziD4KEEAM
         CStPOomJPkSjtC7QYWXbZjP3DoTpn7jPyb0/jRzFvS/IO/UANYlF1prr6JPzXEqXBkuL
         IO9YCgDM/hJHunn/pWQB48BfVFqEAcFtnUQAyfdaL07pWyKxuSZzNiMc+fumPTN0eeT4
         wf6bFt/xVbFke4S+DusW56UHpileZDaaEzUxWxbpuuBbgbfhdK2ih1abE60shuD2XeAx
         LlJP2KOkvWg9TXAvgBijihT2X+MUZRw6BU9Yd0Yoo4fivFWN3bQ+8luTFkx2J/7ikuzx
         iezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005287; x=1703610087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlneokmKF1TajoqU6rsqTKLh9Q2KoTuUiBV9HAc+RDM=;
        b=dgnkvnibdk5s25QPCu5XAknzVwXxD43shmqtUYqTEZuPT23YInQUFXGQ/sogsjzU7+
         8V+49PABlcnOVgwlsQb4IfVgpbiskC7Q3FWDkRZwSC7GQIO2YxxkCJmYxOZCRloMzBO8
         e1bMTLSDvbrwTcN7w1J9MtnPgR+SNi3ZHwDGDuo1h6dmFMRVrT0gpnrZrvQqZiwhN+pN
         rL0s/IvMVDmv4u+qlqiL6lycdO6Jduv9h4rUDE+8Dg/7ICNspFnuWIipzGtG+RFxmJJA
         EI1pXTRi1OKJm7q3h42bGjZ0MBdn6c9Y+hyW4JAsBxDGGU54GlObDPfNzzXrDB0RO6zy
         m3Ew==
X-Gm-Message-State: AOJu0YwDJuwIy9z9LD0RyjYZzjxJUSs5GtR4jVyxO908cJTBFhWJ/B5k
	tcKdpvZAGj9ONcU8X8w4QA==
X-Google-Smtp-Source: AGHT+IFgNag5RzBVfRt1FyfNQwZdIW7ZbFhF5a9fbzOs0v3zV+7ntZcb1IJiL0G1mPdw1hfxZoM6rA==
X-Received: by 2002:a05:600c:3502:b0:40d:18e2:895 with SMTP id h2-20020a05600c350200b0040d18e20895mr2209578wmq.98.1703005287566;
        Tue, 19 Dec 2023 09:01:27 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:27 -0800 (PST)
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
Subject: [PATCH v3 22/29] drm/rockchip: inno_hdmi: Split power mode setting
Date: Tue, 19 Dec 2023 18:00:52 +0100
Message-ID: <20231219170100.188800-23-knaerzche@gmail.com>
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

This splits setting the power mode of the controller / phy in two
functions. It's done in preparation of setting up the phy based on the
pixelclock.

No functional changes intended.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v3:
 - new patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 54 +++++++++++++---------------
 drivers/gpu/drm/rockchip/inno_hdmi.h |  5 ---
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 9fea464b6234..e21f6d7aeee6 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -154,38 +154,31 @@ static void inno_hdmi_sys_power(struct inno_hdmi *hdmi, bool enable)
 		hdmi_modb(hdmi, HDMI_SYS_CTRL, m_POWER, v_PWR_OFF);
 }
 
-static void inno_hdmi_set_pwr_mode(struct inno_hdmi *hdmi, int mode)
+static void inno_hdmi_standby(struct inno_hdmi *hdmi)
 {
-	switch (mode) {
-	case NORMAL:
-		inno_hdmi_sys_power(hdmi, false);
+	inno_hdmi_sys_power(hdmi, false);
 
-		hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x6f);
-		hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0xbb);
-
-		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
-		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x14);
-		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x10);
-		hdmi_writeb(hdmi, HDMI_PHY_CHG_PWR, 0x0f);
-		hdmi_writeb(hdmi, HDMI_PHY_SYNC, 0x00);
-		hdmi_writeb(hdmi, HDMI_PHY_SYNC, 0x01);
-
-		inno_hdmi_sys_power(hdmi, true);
-		break;
+	hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0x00);
+	hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x00);
+	hdmi_writeb(hdmi, HDMI_PHY_CHG_PWR, 0x00);
+	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
+};
 
-	case LOWER_PWR:
-		inno_hdmi_sys_power(hdmi, false);
-		hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0x00);
-		hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x00);
-		hdmi_writeb(hdmi, HDMI_PHY_CHG_PWR, 0x00);
-		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
+static void inno_hdmi_power_up(struct inno_hdmi *hdmi)
+{
+	inno_hdmi_sys_power(hdmi, false);
 
-		break;
+	hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x6f);
+	hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0xbb);
+	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
+	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x14);
+	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x10);
+	hdmi_writeb(hdmi, HDMI_PHY_CHG_PWR, 0x0f);
+	hdmi_writeb(hdmi, HDMI_PHY_SYNC, 0x00);
+	hdmi_writeb(hdmi, HDMI_PHY_SYNC, 0x01);
 
-	default:
-		DRM_DEV_ERROR(hdmi->dev, "Unknown power mode %d\n", mode);
-	}
-}
+	inno_hdmi_sys_power(hdmi, true);
+};
 
 static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 {
@@ -202,7 +195,7 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	val = v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS | v_PWR_ON | v_INT_POL_HIGH;
 	hdmi_modb(hdmi, HDMI_SYS_CTRL, msk, val);
 
-	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
+	inno_hdmi_standby(hdmi);
 }
 
 static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
@@ -441,6 +434,8 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
 		  v_AUDIO_MUTE(0) | v_VIDEO_MUTE(0));
 
+	inno_hdmi_power_up(hdmi);
+
 	return 0;
 }
 
@@ -460,7 +455,6 @@ static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
 		return;
 
 	inno_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
-	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
 static void inno_hdmi_encoder_disable(struct drm_encoder *encoder,
@@ -468,7 +462,7 @@ static void inno_hdmi_encoder_disable(struct drm_encoder *encoder,
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
-	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
+	inno_hdmi_standby(hdmi);
 }
 
 static int
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.h b/drivers/gpu/drm/rockchip/inno_hdmi.h
index 93245b55f967..a7edf3559e60 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.h
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.h
@@ -10,11 +10,6 @@
 
 #define DDC_SEGMENT_ADDR		0x30
 
-enum PWR_MODE {
-	NORMAL,
-	LOWER_PWR,
-};
-
 #define HDMI_SCL_RATE			(100*1000)
 #define DDC_BUS_FREQ_L			0x4b
 #define DDC_BUS_FREQ_H			0x4c
-- 
2.43.0


