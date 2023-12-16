Return-Path: <linux-kernel+bounces-2263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50526815A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C771F23CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79237D23;
	Sat, 16 Dec 2023 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjcS9X4K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD4321BB;
	Sat, 16 Dec 2023 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so216691866b.0;
        Sat, 16 Dec 2023 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744037; x=1703348837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73XUcSiZm29Hst8BGY/CNDIJrl23XpjPpmNwnFVb4KY=;
        b=EjcS9X4KdVNULbVGSH9dKIdFJ+b2Be0IHxPzAGMQuIssww7sP2z/ouZIaRf1Zu8D0q
         7iHBKO1rhMslEaofNfIUlyC5IQX8KINU2ETtmonBkHyNw6YGe8OM0DYbvsWTceHpv2ES
         WZ0/o8Np40jKWVjZxAXPXKG7RV9avQ8Ep1/hHR7VuF78fR26es8h5EWPisXU7+s1JMt/
         lhCSr0oS5oKLllL1D+wqkdYQ1RcfXVjXSoH0g5XYsoLst2UaJrnbirfAbjh0dlX0DfHT
         LksCFtWEslvR/zAwDTn5R8aDpVv2Wk/nRvXhCRqISflRdgn7CFk/GFXg9g5sr5jsh7NW
         73BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744037; x=1703348837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73XUcSiZm29Hst8BGY/CNDIJrl23XpjPpmNwnFVb4KY=;
        b=T2iKX+KePhBmW3Ffs4yD0L3cgOpokuOSg1lnUg3/XMVfoNOShogVdGY1Jgq5zNVFiB
         rtSWe4YC7H+ChnhfXcGuWDoqlNU6FfGzYZy6L1S4b2zDdDOPJDiUKuA7RM6KvLo4mASe
         Ml2BFH890jFFSkAU72g117JjIk3yFW1StKqQ594b0Pxsx82+tcqZvrBQe450uNPKvK/k
         tKZFmMRi+wMLiTBGB9s+DEHlzfBECG10w1fqnHW+JIJD0lrb0jqi9No6XhDlPRTs5LT1
         Zrj9zSY6OJJnezsPF2jcVe3JsySlcFEgzxJA5cwkgaXY07sISxv0WA5IwR6VaDg/m/Kq
         +8og==
X-Gm-Message-State: AOJu0YwotkEfCBHcNAItpgE70QzNqq5DaLNmpwIrvWgjb2xX2CyfJJk6
	ETa+/mp1AlFAFcIKYCKfdQ==
X-Google-Smtp-Source: AGHT+IFqBPxW/2QVy0WrDKBDbe9uYBS+XAaayLmej63jccZiISHw1g3uoqKtiDcxw89fuZb28tBdPQ==
X-Received: by 2002:a17:907:724d:b0:a1c:a39d:dcbd with SMTP id ds13-20020a170907724d00b00a1ca39ddcbdmr4339820ejc.232.1702744036964;
        Sat, 16 Dec 2023 08:27:16 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:16 -0800 (PST)
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
Subject: [PATCH v2 15/27] drm/rockchip: inno_hdmi: Remove unused drm device pointer
Date: Sat, 16 Dec 2023 17:26:26 +0100
Message-ID: <20231216162639.125215-16-knaerzche@gmail.com>
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

From: Maxime Ripard <mripard@kernel.org>

The drm_dev field in the inno_hdmi struct stores a pointer to the DRM
device but is never used anywhere in the driver. Let's remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index b6b34f4b8cda..e37023d8fa39 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -44,7 +44,6 @@ struct inno_hdmi_i2c {
 
 struct inno_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;
 
 	int irq;
 	struct clk *pclk;
@@ -760,7 +759,6 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	hdmi->dev = dev;
-	hdmi->drm_dev = drm;
 
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
-- 
2.43.0


