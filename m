Return-Path: <linux-kernel+bounces-9965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B525081CDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E81286505
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361436B15;
	Fri, 22 Dec 2023 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT9sfwCg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38A33CDA;
	Fri, 22 Dec 2023 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so12306485e9.1;
        Fri, 22 Dec 2023 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266953; x=1703871753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/FPPxJuSjh4vXrR5zkAljtm7LBwORW2untky7snjAo=;
        b=gT9sfwCgPtehT+kyIgTPNzUWhV/f5IMpsuywWKbmjMkRy3QOQrK2ffHmyyTu4P4Odv
         LFVX0ZUUBYYRi8I0hleYyfLn9fN1jCN63G5En1PxKyuTikQoyy+u2cWLckWrlVbaYu3m
         2uOIZgWZNZ2LyT/ljnFC88ll/CO9vsfI1QJSB/ZFhxHF+WTXp45NXTk5/N9VMzItDIoc
         j2TBzPum1Tbt6kN4VgQgdsGuzJHTISoESGFIElEb+JjypHTA2uH1/d9g0THF/bnUzfrd
         ieNYbrFbhtkEC1LIhHYeY5aQZ7w5Bnlo//P6J/uQjDC/8jMgzOWAvq/26EOgbNSv5WSE
         0rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266953; x=1703871753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/FPPxJuSjh4vXrR5zkAljtm7LBwORW2untky7snjAo=;
        b=hW2ldS481gndJAA0HIvSh6dVNqZpfy+F/SO9CUa9sVIciV/Ja/Bdi+3PYeTYMXvKew
         2Vb0kifNVdkgFEgfZLWa8h6OS4mVii2GJNGDvgTDsOoxvLX889Drrgi+6ep53csit32m
         AsBglgkdvmbxFkJ2v47pdXwFJlsUMfJksvW75aolpn2v7v535aXLEGnaQV7Uk+EvJkJw
         FJs/QVz1rRdiykRJwalqO/7IQCZZn4HlJ1/UIN4Gvt4wWZcoC1Ia5rPPMEhhVL4wzoSu
         hH2mPBUHxgclOWguXJSzvMpv8Bj2YF6GKRVEhp+Lo1cQ2hdAOnWST3uXgeHLQT10JLVq
         4NKw==
X-Gm-Message-State: AOJu0YwfKvNehZ/JrnmBpAoitT0QqfZwYk3FPVbnq2kqVpIVTpU/DtdJ
	3VE2ZpyOUGI0fKC3Zq6lDw==
X-Google-Smtp-Source: AGHT+IESVQNuwVKMm5k3RVva8Soc6Echl59mQa32aRicQaMoyZBUEGDXAro7m0A3Md1PmbcYnl/kjw==
X-Received: by 2002:a05:600c:3c9c:b0:40d:40ea:a0ea with SMTP id bg28-20020a05600c3c9c00b0040d40eaa0eamr911042wmb.130.1703266953617;
        Fri, 22 Dec 2023 09:42:33 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:33 -0800 (PST)
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
Subject: [PATCH v4 16/29] drm/rockchip: inno_hdmi: Remove unused drm device pointer
Date: Fri, 22 Dec 2023 18:42:07 +0100
Message-ID: <20231222174220.55249-17-knaerzche@gmail.com>
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

changes in v4:
 - none

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


