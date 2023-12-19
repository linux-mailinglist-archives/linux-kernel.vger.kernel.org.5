Return-Path: <linux-kernel+bounces-5634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAA818D73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5617A1C24A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BFE3B289;
	Tue, 19 Dec 2023 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4cNKGq4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3238DED;
	Tue, 19 Dec 2023 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso55022775e9.2;
        Tue, 19 Dec 2023 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005282; x=1703610082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s72CnTe6ZV2IMv3pM/65G6mJvxbtoIjfslzb5tL7Ro=;
        b=B4cNKGq42qhvQhHz/Moc41Si/KshZlja9rqQUGM/4NLOj4mn5PkduV2wT4Mmv/onlc
         sU2mCcJ32TQ0cJwZwJaVUMNb9JyEheKVxfyNi6GA36P6SBHKHGX/G215WRA2EBWCJRgZ
         /XsTdbJja0Ue+QyGj3f4oeWue5oJ6tU7KkbqTT+QzxyKbLVzpj9PNWLpfWb/lGySJ9Ci
         +T7AIIncghCU/rdz88r0xlVlS/4ilzeNUc91ndWaAtJwRPzFVtnXWT+Q1eO95VXyFjxg
         zQKf9dpqX+MdEVQTSBnZO7jaPFTzJ9jSH6+f0INKRLRp4OdH8x5WowS0uE44DNUWgM0F
         ZRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005282; x=1703610082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s72CnTe6ZV2IMv3pM/65G6mJvxbtoIjfslzb5tL7Ro=;
        b=gSidN2+t2mzSh7o7r1Nxd6LSb4nnbTsnwsmk+53Qu5lW3FH0L2RiUL8UephLF2bP1F
         irqDopWNx30FrgLRpImEpR7dUS6VuMoQQQmEnqbKB2qxO8HIc8m2mkPSvnncefoAdbOk
         nBU5eIGkjMer/22gQJugr8v7jpKduU07DNtziiVDywd7Q4Te60pvCkjEAws4fjUS5BEx
         e8DuzokhrQmxJNczxwN3chVebhGeGydMK77NxxPvlGMZ7RhH9apVPXN+foZh6G8THbJz
         w+U3KkIAXVVQCMD49BUjhIgvNQ1xYph+tiPaxulcGg3Y2k0HA94Z3tY8IwVSdPOCQ0TI
         Hvrg==
X-Gm-Message-State: AOJu0YwaZalEKXTEz3TZcZIV0KgdlC8HmaNFfPIh5nnx3A1RniBp1IKg
	udJhaRpa2CH3+AUc++KRYA==
X-Google-Smtp-Source: AGHT+IF42FDcOro97JAPmk/FhpAyFJfar6DWOBNmBzFRzZO3M20X58L49lSjppkjM2XFoVbHdGgTNw==
X-Received: by 2002:a05:600c:244:b0:40c:2b4c:623f with SMTP id 4-20020a05600c024400b0040c2b4c623fmr6217351wmj.82.1703005281769;
        Tue, 19 Dec 2023 09:01:21 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:21 -0800 (PST)
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
Subject: [PATCH v3 16/29] drm/rockchip: inno_hdmi: Remove unused drm device pointer
Date: Tue, 19 Dec 2023 18:00:46 +0100
Message-ID: <20231219170100.188800-17-knaerzche@gmail.com>
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

The drm_dev field in the inno_hdmi struct stores a pointer to the DRM
device but is never used anywhere in the driver. Let's remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 49367ca24125..51c1a69dfcc0 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -44,7 +44,6 @@ struct inno_hdmi_i2c {
 
 struct inno_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;
 
 	int irq;
 	struct clk *pclk;
@@ -757,7 +756,6 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	hdmi->dev = dev;
-	hdmi->drm_dev = drm;
 
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
-- 
2.43.0


