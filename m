Return-Path: <linux-kernel+bounces-9674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A33181C969
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E985A283283
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E117984;
	Fri, 22 Dec 2023 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1aPVIwz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB217751
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703245954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qeM/S/omrfSVhML5YUobmUmWfHTQ46GRH696mY5TNyo=;
	b=L1aPVIwzO/ys5wDIMmHz9LQoFWLrFYgsjIhMzZk+zlYp3Tvdgm46um1vpofoJk+sDCEnT2
	ZhdkHGCpGE2cW2+E28/PS98Jkx/RHm8/UMHn5X7jYxutraI5rsBQXRNiaohIAWQUQtqqEM
	VyjEqJ0iYzw26u/n3/FnPmWhQG/EkVk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-xX47TCWlMr-TndOBd4kxoA-1; Fri, 22 Dec 2023 06:52:32 -0500
X-MC-Unique: xX47TCWlMr-TndOBd4kxoA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e3288601bso342676e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703245951; x=1703850751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeM/S/omrfSVhML5YUobmUmWfHTQ46GRH696mY5TNyo=;
        b=k+McB1ygvn0wKPhY6V2v7yqiJ3QROkAbTSawQHbyghBRB38YKeGER2WlRPPsLVLp9+
         tXusT7AjXOGwt9d+UXarry2ef1nNpYuO7syJTn32k+kEqn4FoT55bbHn0UGEpLki4BVd
         N3ejzdlyJcXSlRCbKIEBx3DgMXBS5QE7A0+kVNv9o93sgP7RDI6BTlxU30p28QB5InpS
         cSKReiA0p0e69TQxudyAr9nsZAGD0Dkd67aMJL1d711WQ9oW+WjMO6ILG7wqD+4whvkF
         c4rofYW2UTH8PVUOqW+qkEhltZIZAhgOhT4rQSahjD/Ij+lZjub/VHTgkEuqv6VMJyuy
         hgsQ==
X-Gm-Message-State: AOJu0Yz50tgeR1TVLCzEORLlUBvTKagkQkkxju5lkOHqZYeRIH324xVT
	It+wd9mvG4yU3K44hQtoSUc9zzf+LcGmVJ+KAvsA/gqYbMe7XSht20l973mWc6oK08kdPm1X3gM
	d1l/js0HiWyGoA8XZj5kKzKV7Q8MIzMc6
X-Received: by 2002:a05:6512:3127:b0:50e:2460:d703 with SMTP id p7-20020a056512312700b0050e2460d703mr1361168lfd.0.1703245951143;
        Fri, 22 Dec 2023 03:52:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1vvC6LH7skIEuy9Objfe1rs8IpDRitZkcFcKkuSjJ+mvjDH0GtZ0gmLOqEGqEtPCyCz7BQA==
X-Received: by 2002:a05:6512:3127:b0:50e:2460:d703 with SMTP id p7-20020a056512312700b0050e2460d703mr1361141lfd.0.1703245950241;
        Fri, 22 Dec 2023 03:52:30 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32ea:8600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003fee6e170f9sm6602732wmo.45.2023.12.22.03.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:52:29 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/tilcdc: request and mapp iomem with devres
Date: Fri, 22 Dec 2023 12:52:17 +0100
Message-ID: <20231222115216.19218-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tilcdc currently just ioremaps its iomem, without doing the (a bit more
robust) request on the memory first. The devm_ functions provide a handy
way to both request and ioremap the memory with automatic cleanup.

Replace the manual ioremap with the devm_ version.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 8ebd7134ee21..2ad3f44a6e2d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -182,9 +182,6 @@ static void tilcdc_fini(struct drm_device *dev)
 	if (priv->clk)
 		clk_put(priv->clk);
 
-	if (priv->mmio)
-		iounmap(priv->mmio);
-
 	if (priv->wq)
 		destroy_workqueue(priv->wq);
 
@@ -201,7 +198,6 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
 	struct tilcdc_drm_private *priv;
-	struct resource *res;
 	u32 bpp = 0;
 	int ret;
 
@@ -226,17 +222,10 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 		goto init_failed;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get memory resource\n");
-		ret = -EINVAL;
-		goto init_failed;
-	}
-
-	priv->mmio = ioremap(res->start, resource_size(res));
-	if (!priv->mmio) {
-		dev_err(dev, "failed to ioremap\n");
-		ret = -ENOMEM;
+	priv->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->mmio)) {
+		dev_err(dev, "failed to request / ioremap\n");
+		ret = PTR_ERR(priv->mmio);
 		goto init_failed;
 	}
 
-- 
2.43.0


