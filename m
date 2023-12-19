Return-Path: <linux-kernel+bounces-5630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC6818D67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD211F28477
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B439AC5;
	Tue, 19 Dec 2023 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1ibjq/R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C3381A9;
	Tue, 19 Dec 2023 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c6a71e88cso60302615e9.0;
        Tue, 19 Dec 2023 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005278; x=1703610078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIuIHzK0qm/T7D2HzJVN2+t1kaAcSj5o4LHFrFwAH3M=;
        b=P1ibjq/R21sfJDyK+rfVUceom9FZBEnr5vIe7SF41/ZXhbT6VCiifAgRVvMtJGxqxb
         mw4IhoZEixJ9XrUaCTDWD9EBg617sz0rPRvbwI4CBYfs18YjcXaZ76G4C6o781j/O5qz
         7kBrW4B0a8aWBXNBxIfQXRR38cLWUmzxrhv9H90u4WJ/aima1y+C7vVEpDSGQsBdzSV+
         ihDQkEBMVykNazRUrst6svrr/vMN5XXlBXSZb6UXJi4PFj+q7P5WZgcotujijyXwW8EV
         DNYtbi7dp6bKxhWKuHCkBsvwG8aSLvyePabn+bV6Uzn2OJNZBzVQRzZt1TMJsSkZy0e0
         N+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005278; x=1703610078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIuIHzK0qm/T7D2HzJVN2+t1kaAcSj5o4LHFrFwAH3M=;
        b=mPJLljKL/qnp5gVwUBWuFWqg1N9Wn9bdC3T40XzFrdwO1encbtqDP2creb779Qaq/5
         QrFow4kZdOTpKc2MeoVeRK9bBGQlqQPs6HnYYwdPwPCkzB7uEZjTl3+lKpC3uuwY3U24
         rjL4IIgiw6OfXOUXBumzTRaJE3r1Y/tzw6RcOvcdHhqx0Z/bItuh8QW4IT2+xnlg3OX9
         b9nTBarpOcgcM6cfO49Kym1Fk5esoEMi5eEH6jOXmZdaj3FaxvphKcYg+NA2BRIieJt8
         D0X/4mO/QyFvwS158fKY+qSKNW1FGy6AOb5mlkfhkQ3EF96CGTm8hLegdE9TjXIK2AfJ
         HtMQ==
X-Gm-Message-State: AOJu0Yy03Vo7zr2cWcUwrqozXz2ZOGzW2u2KTUKIWQV2imRQ00aRJ7QB
	QTkNExUQGq5xactyjuMv+Q==
X-Google-Smtp-Source: AGHT+IG+MKZvHdr0LdojEJTOnBVthAxDJ27zyg41YEqLHjuX3KtlEV2RPBM3XFk88GAaBr0tl3d3Kg==
X-Received: by 2002:a05:600c:a01c:b0:40d:2df0:ba12 with SMTP id jg28-20020a05600ca01c00b0040d2df0ba12mr458869wmb.83.1703005277928;
        Tue, 19 Dec 2023 09:01:17 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:17 -0800 (PST)
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
Subject: [PATCH v3 12/29] drm/rockchip: inno_hdmi: Remove tmds rate from structure
Date: Tue, 19 Dec 2023 18:00:42 +0100
Message-ID: <20231219170100.188800-13-knaerzche@gmail.com>
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

The tmds_rate field in the inno_hdmi structure is used mostly to
configure the internal i2c controller divider through a call to the
inno_hdmi_i2c_init() function.

We can simply make that rate an argument to that function, which also
removes a workaround to initialize the divider at probe time when we
don't have a mode yet.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v3:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 04344ee1265d..102195837206 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -56,8 +56,6 @@ struct inno_hdmi {
 	struct inno_hdmi_i2c *i2c;
 	struct i2c_adapter *ddc;
 
-	unsigned int tmds_rate;
-
 	struct hdmi_data_info	hdmi_data;
 };
 
@@ -134,11 +132,11 @@ static inline void hdmi_modb(struct inno_hdmi *hdmi, u16 offset,
 	hdmi_writeb(hdmi, offset, temp);
 }
 
-static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi)
+static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi, unsigned long long rate)
 {
-	int ddc_bus_freq;
+	unsigned long long ddc_bus_freq = rate >> 2;
 
-	ddc_bus_freq = (hdmi->tmds_rate >> 2) / HDMI_SCL_RATE;
+	do_div(ddc_bus_freq, HDMI_SCL_RATE);
 
 	hdmi_writeb(hdmi, DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
 	hdmi_writeb(hdmi, DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
@@ -421,8 +419,7 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	 * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
 	 * clock rate, and reconfigure the DDC clock.
 	 */
-	hdmi->tmds_rate = mode->clock * 1000;
-	inno_hdmi_i2c_init(hdmi);
+	inno_hdmi_i2c_init(hdmi, mode->clock * 1000);
 
 	/* Unmute video and audio output */
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
@@ -800,8 +797,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
 	 * and reconfigure the DDC clock.
 	 */
-	hdmi->tmds_rate = clk_get_rate(hdmi->pclk);
-	inno_hdmi_i2c_init(hdmi);
+	inno_hdmi_i2c_init(hdmi, clk_get_rate(hdmi->pclk));
 
 	ret = inno_hdmi_register(drm, hdmi);
 	if (ret)
-- 
2.43.0


