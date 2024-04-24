Return-Path: <linux-kernel+bounces-156388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD388B0242
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D41F23AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D67157A55;
	Wed, 24 Apr 2024 06:38:37 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD69142E67
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940717; cv=none; b=lW6T/5/mgpY4LKV+z9svRnKmsW4kE1CGpoM4gw6o8pM2XH7FqUiOkXUWfWdkFmCTh6tVhWVx5EPm00uFzWoN85RXkxvYcVoLqO92eOmQS+ej3WKc2xXiN25BsOJRYedb5D3N5MWFJ2GxzR/O269y2O13thp/oq5Jp+D3tEF4BfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940717; c=relaxed/simple;
	bh=Zu5TgZ+zPeerZa7u5U1tgqw/dALHMDKrH7bkwcDYUds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TE3KSsvGl0VZd00Z/vY+rENFhWjooZMYEABDC4idIONN6Am9k0ftYuKnuWx82DsFq2azWTXy9XQ9n0k1yEmb11cH9QXOpGOtYxYqhiYJDeRcFRd++5/iOjqjA9jXH+rx06CmsPXoCrsewoq/KNczDPWiyC/sjG1kIIC+Xcj5saw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349c4505058so5073809f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713940714; x=1714545514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7F6fcWvuVbwO8A7BKBGHpEMXt2s9j8A9+ZiuFQieNc=;
        b=KJIuuqd1VvQJyaaYF6clthn4YN6e4LmPw0Wrxd1ju4AWxxZMSIqeEHHARlzBgjxev1
         kEZZyqKnFII10QMk9qhQjJQfbisBv0x5nl87+T3DzUdX0OoSW1ueJcAkIDFffK6EYOqr
         Je/5zVHJSPBUpXCtlL0kyAkYb64MqZuSsDARK3+ANld2cEwdlqm9+f/LdjdBfLRh2eMv
         q6bilG/pbdwTWN7s8q8o9NOqhPvR5g8kqR+pSjUlVt7hBQT32G/Tpt7ZAY/4x7lrBKn7
         x054aP6x1178Ro46/hadqZZ7qnaZ3BC3ZMxY7+vDhtvQqvNRLDnfUc0ds4Wj0Hv7bv2P
         zFGQ==
X-Gm-Message-State: AOJu0YyvM+N6WiStYMf0IdY2XuiAov/9iwI+5ZIDwYAnWIL3P/J5vH8b
	9cOPRSTGEbW3LmC3wAmxBErNELQcbInJmZA5IZu7dBDfOQvRlcIrZgWBT8dr
X-Google-Smtp-Source: AGHT+IGZxz0n9OTHB3mbYtVMEI21k1MjIrdkYkQkkOS5bd8p0H9eqeY2ndEMfxp9vJxluXAE0WdVSA==
X-Received: by 2002:a5d:4b48:0:b0:346:cd6f:3fd9 with SMTP id w8-20020a5d4b48000000b00346cd6f3fd9mr799188wrs.10.1713940713579;
        Tue, 23 Apr 2024 23:38:33 -0700 (PDT)
Received: from localhost.localdomain (cst-prg-33-92.cust.vodafone.cz. [46.135.33.92])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b00419f7b73c55sm14284298wmq.0.2024.04.23.23.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:38:33 -0700 (PDT)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Date: Wed, 24 Apr 2024 08:37:51 +0200
Message-ID: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we expose a render node for NPUs without rendering capabilities, the
userspace stack will offer it to compositors and applications for
rendering, which of course won't work.

Userspace is probably right in not questioning whether a render node
might not be capable of supporting rendering, so change it in the kernel
instead by exposing a /dev/accel node.

Before we bring the device up we don't know whether it is capable of
rendering or not (depends on the features of its blocks), so first try
to probe a rendering node, and if we find out that there is no rendering
hardware, abort and retry with an accel node.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 46 ++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..8e7dd23115f4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
+#include <drm/drm_accel.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -488,10 +489,10 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
 	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_FOPS(fops);
+DEFINE_DRM_GEM_FOPS(render_fops);
+DEFINE_DRM_ACCEL_FOPS(accel_fops);
 
-static const struct drm_driver etnaviv_drm_driver = {
-	.driver_features    = DRIVER_GEM | DRIVER_RENDER,
+static struct drm_driver etnaviv_drm_driver = {
 	.open               = etnaviv_open,
 	.postclose           = etnaviv_postclose,
 	.gem_prime_import_sg_table = etnaviv_gem_prime_import_sg_table,
@@ -500,7 +501,6 @@ static const struct drm_driver etnaviv_drm_driver = {
 #endif
 	.ioctls             = etnaviv_ioctls,
 	.num_ioctls         = DRM_ETNAVIV_NUM_IOCTLS,
-	.fops               = &fops,
 	.name               = "etnaviv",
 	.desc               = "etnaviv DRM",
 	.date               = "20151214",
@@ -508,15 +508,20 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.minor              = 4,
 };
 
-/*
- * Platform driver:
- */
-static int etnaviv_bind(struct device *dev)
+static int etnaviv_bind_with_type(struct device *dev, u32 type)
 {
 	struct etnaviv_drm_private *priv;
 	struct drm_device *drm;
+	bool is_compute_only = true;
 	int ret;
 
+	etnaviv_drm_driver.driver_features = DRIVER_GEM | type;
+
+	if (type == DRIVER_RENDER)
+		etnaviv_drm_driver.fops = &render_fops;
+	else
+		etnaviv_drm_driver.fops = &accel_fops;
+
 	drm = drm_dev_alloc(&etnaviv_drm_driver, dev);
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
@@ -553,6 +558,18 @@ static int etnaviv_bind(struct device *dev)
 
 	load_gpu(drm);
 
+	for (unsigned int i = 0; i < ETNA_MAX_PIPES; i++) {
+		struct etnaviv_gpu *g = priv->gpu[i];
+
+		if (g && (g->identity.minor_features8 & chipMinorFeatures8_COMPUTE_ONLY) == 0)
+			is_compute_only = false;
+	}
+
+	if (type == DRIVER_RENDER && is_compute_only) {
+		ret = -EINVAL;
+		goto out_unbind;
+	}
+
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto out_unbind;
@@ -571,6 +588,19 @@ static int etnaviv_bind(struct device *dev)
 	return ret;
 }
 
+/*
+ * Platform driver:
+ */
+static int etnaviv_bind(struct device *dev)
+{
+	int ret = etnaviv_bind_with_type(dev, DRIVER_RENDER);
+
+	if (ret == -EINVAL)
+		return etnaviv_bind_with_type(dev, DRIVER_COMPUTE_ACCEL);
+
+	return ret;
+}
+
 static void etnaviv_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-- 
2.44.0


