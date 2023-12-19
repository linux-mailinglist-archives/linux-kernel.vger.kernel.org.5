Return-Path: <linux-kernel+bounces-5640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E59818D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643191C24CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05838FA7;
	Tue, 19 Dec 2023 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al2e0YvO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A73C087;
	Tue, 19 Dec 2023 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b5155e154so60386005e9.3;
        Tue, 19 Dec 2023 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005286; x=1703610086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8JOWn9GU9Nla83BWtTSRAknxxtN8+L8TovD6+V8Mi4=;
        b=Al2e0YvO08Yx5vbGmdiCLzVSqo1QSvU7dfCzZG35xxH0q5z4jMChpRRZFZC7Qrp2bx
         VZbxxwcIxW21tXSg27VrN+z12oHfcR5OiBbObpTZJeX3FaD4PFK+JOKnC7ISKkus41ni
         rKzbRB97rk7inY2cbsc9AC8c9zBLDNIR3edFoEEn2xaroeNIPOTVZMWyAD7sB9btrXzc
         QOOBVSBlZrHRPzWm4wHMBNJr5aPhj3BDmB8rQUk/goEUiAmsNxa9ZliiQjt6Qxb+0KNn
         GEonyjv2GoVoUFUsi76p1qDTlYgVKsEUyCBrXmMi7p2cHOXJ0yVuErx56CRwjM+/aQ1B
         mqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005286; x=1703610086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8JOWn9GU9Nla83BWtTSRAknxxtN8+L8TovD6+V8Mi4=;
        b=noGJ/P3ljibZ4lvVxXjlFS6rUyusS07m0kyfHU3moDy5rLupQwQtWtoBxfF9ooJZnz
         dt/6UpIsItctojw6sOiczRtTXpNkMWuS2Hlm+TUnbw7BC+R2UaVW26B1cUvZTkvY4uye
         WXHNUQXPEKAsbeouBERdw2N8aO2Gu70D/Y6XgAkyOV+RQZYKOFziGi/nMPdy5zLSyuyM
         duJ823dKNtzaekOY3K+C3pIW6RQHvWh57MXG1X2tAEdhDOBnWufVqmxEv9FszU1bjLJ9
         BsHTg+rEVPFJq9t17Mq2NEqzEFZmv84qbGaFHsioMbU2z2vNYdS3NDNuYWfxi4OPSlu8
         HjOw==
X-Gm-Message-State: AOJu0YwUy0+oB2i72zpKDZxglZPFdQdxkv56yjgFdvdzn704bbwu8HTy
	/rf1ZeWIL224uCqqQCycWABC9WYj9w==
X-Google-Smtp-Source: AGHT+IFvESFKFDDj+P6Hp56SjNt5xISbZzFocZziXX7FumH32R2Au9gUTKsNb6b63EcE9fIlyJTiZg==
X-Received: by 2002:a05:600c:2492:b0:40c:5583:c6b7 with SMTP id 18-20020a05600c249200b0040c5583c6b7mr6324639wms.109.1703005286360;
        Tue, 19 Dec 2023 09:01:26 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:26 -0800 (PST)
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
Subject: [PATCH v3 21/29] drm/rockchip: inno_hdmi: Don't power up the phy after resetting
Date: Tue, 19 Dec 2023 18:00:51 +0100
Message-ID: <20231219170100.188800-22-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

inno_hdmi_reset is only ever called when initializing the controller. At
this point it’s completely uneccessary to power up the PHY, since all
what has to work at this point is the DDC bus. The phy will be powered up
correctly when a mode is set in inno_hdmi_encoder_enable and disabled in
inno_hdmi_encoder_disable.
Set it to LOWER_PWR after resetting the controller.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v3:
 - new patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e6d37772500c..9fea464b6234 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -202,7 +202,7 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	val = v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS | v_PWR_ON | v_INT_POL_HIGH;
 	hdmi_modb(hdmi, HDMI_SYS_CTRL, msk, val);
 
-	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
+	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
 }
 
 static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
-- 
2.43.0


