Return-Path: <linux-kernel+bounces-9971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045281CE01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A7D1C225E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A427482E2;
	Fri, 22 Dec 2023 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYdOF7vz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF73B19D;
	Fri, 22 Dec 2023 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33687627ad0so1708236f8f.2;
        Fri, 22 Dec 2023 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266958; x=1703871758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfTDEigy6tmq2Mn9E1wnnsAPUxEbWwuqi0N9nc+qdGo=;
        b=jYdOF7vzKRhpy8++/ZXyEzpvN0070HBaPQg7+JDxaJw4nsK8XDguLnMrriun1sHzQE
         jdGlJsrFY3bgnsvqnsqMCMtJ7pZjU1aSLlq1O4y+10RzKb33EYIx2UlDNN81RpBH83VE
         711nJjgM4KTiHJwKFA9jbPfZLC5FcBwefjnrdSficY1qYVteE0DJvJooTXUWQ3JCjQvL
         Zksf+rYNBP6OzweW4jGbzF/mUhMmKj3qLoiX9x3LlKjNmYu4blyY2puaZHHWBV4m2Uzo
         7AtNfyBUgx973PZMD4tpW36b2OnKE9AS/g8cz9eZOkwXfQJ7JWSRSK2ECQmTkegjlTVF
         FtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266958; x=1703871758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfTDEigy6tmq2Mn9E1wnnsAPUxEbWwuqi0N9nc+qdGo=;
        b=Y6O795ECjaD0xKMu+A8rhOAH2yybZAuta1TJr6DZdvLGD62r4gtlgs9Cp6RzXCVTdS
         aafHjPjgwwY0jd1v1O43s1d9R92V5AIDHH7kzR1QwqvX74sfNVs1C4u8oDPGQIvCn6L1
         9dd5qWGfi6ex1X8zfJW75nDmtGa2khELXaxEJ3vPorrnk8ApgVpQKnHwtBYeO4ARSAe+
         N6n+nKEIey669qbHyWI95wYV6MbAXStd2gQC0OWV7CMtYyN1XpUzoXYfs9TpdYZxuWSN
         oRv8h7KfEq4QNj28RLb/mlfcqSi0zASblB10hso00JXgLdjR7ZpE7u4eBlZj7wmKwBL1
         bXMQ==
X-Gm-Message-State: AOJu0YwGSY7TkDGfhq+WLaWPzB5R1tgirBJf6WfPGx/R9353RfVYQlGk
	vMDHJflhGNhsfhlLDY1m5A==
X-Google-Smtp-Source: AGHT+IHD1sMRR0b9UfvVWSWGlPGdgDIwu7H3ElnGmo67e7+XKWlpbK8y3mbb/mtv5CeniedxhpSZ1Q==
X-Received: by 2002:adf:e74b:0:b0:332:e667:4277 with SMTP id c11-20020adfe74b000000b00332e6674277mr1205025wrn.40.1703266957871;
        Fri, 22 Dec 2023 09:42:37 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:37 -0800 (PST)
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
Subject: [PATCH v4 22/29] drm/rockchip: inno_hdmi: Split power mode setting
Date: Fri, 22 Dec 2023 18:42:13 +0100
Message-ID: <20231222174220.55249-23-knaerzche@gmail.com>
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

This splits setting the power mode of the controller / phy in two
functions. It's done in preparation of setting up the phy based on the
pixelclock.

No functional changes intended.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v3:
 - new patch

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 54 +++++++++++++---------------
 drivers/gpu/drm/rockchip/inno_hdmi.h |  5 ---
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 52b49f44a4f4..44c311e7e2d3 100644
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


