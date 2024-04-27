Return-Path: <linux-kernel+bounces-161055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ECB8B467B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2E281732
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7F4F1FC;
	Sat, 27 Apr 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4gd7Z9Q"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639913A1C7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225251; cv=none; b=EdJGCBvBn3HEnlgr29kj2H78JRmQPqTpn6Zybl9sPS/KHa9Q1wJN3Dwcb3uAKjPXRQ7a8ep6DRaji+Aelf8l5UjH9Xorps5IQHHGrlzW4qFPieOf4pX7NqshtkYZEQ0Ir9j4xzlX5pDQcufv2iBAkHr9us38n6yEQilZV2gDAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225251; c=relaxed/simple;
	bh=mPT8Y4F0GBnS1Ver6grIOF95wckeDVQ4/VDgRmfzdOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZkVCRQvpeIl03dCZsiXb+kF6IUwVlA6FUIMF3ixgVdR4WoMRJJ4kDzRzDVcEU0hufDH8D+4P4cT5IZNDd7ZZ3sAiUvRt6Awsvr5i4LdcB7EPhVX4nbhfv6cMBYr1xEFQazzyeER4O4ZQi/7F/Zlh8B8hQFmdKfI2b1fJ7uXqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4gd7Z9Q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso2158255f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714225248; x=1714830048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFM/BIbGMgi9bKV+Fk+cm/HhgYfloz9kI9XIMn+A5SI=;
        b=R4gd7Z9Qh/2yD2dWeWz+zykSSH8UqWx1e5QiXzmsi/WKx4B3ZC5cfKNE+ZJFxguy2h
         BTqmfeGiGzQ2WBA9Ueh6KbcV0kxBf+PaPdGhFuT0gViFavYZmzQOEBDZBZK9Y5zsfzMJ
         ltnYUXXfo/wlX/a21Z+xPD+m+HKexzJQFONwIRBdD0dG8PqYaGB6eYROUdyBozv/FIzB
         lES7rBzRtzOSGFgh+0iHjid6mhOn45LVu/9nnJsmvZjIN0WK/RGcfc38C5keE636/P+d
         zERa4MN9ccfXkAf8zryyO5LuI4aqWyK5m9pztIGSWkSHQMAy5YeV2GQ0CvMfP5akk0ac
         s3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714225248; x=1714830048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFM/BIbGMgi9bKV+Fk+cm/HhgYfloz9kI9XIMn+A5SI=;
        b=L3xaHeXchcJkcf0aDTiI600oEEeN7a9YTCpL2xSnog8hZjbYQHUq8Tnu3Pas/MT1A4
         LScaKqcO8iIT9OPyzFzrbKkVrqrS2tV+1DJLeiWhEX7ND8uA1plPABdQvvTD+ENAMLDA
         TN2bF+RrvnsXcXRdEJPxu8dgqB5Tp+pYDuIrqiQWBIozjpMBTBGv8tJDjC3jQf8VtufH
         9TUsDx+nqXrtTBDJwdmAkHfpoaet5oeC63sIKcWnmUNJm29mMA5irlqdpEI/jcZyTKqJ
         aXoPfXKE4BwOykd1+2mws6f4p/Fiwb3tayQ3wGQQYNPDKJCkyaeQzRsAYJmNrclEWu15
         9T/w==
X-Forwarded-Encrypted: i=1; AJvYcCXbqQ/ndQLl0eEU/YOfjzaczXf5ontCEbAOjX5IgE8Cj0KtDnCnEuIJt9MpbRKuOPKak7zUgD4CGzV6bH/G08VTcFFyBEjueI7eJoNS
X-Gm-Message-State: AOJu0Yz9gztL3xjfny233ZZCHl1LQxZRZxrZJePg7U/4ASN1hwRZ9njN
	jak4LuApHciVzi2azrO7qbWmT1fZfffnBzXVa6uiZ7XOFCzd2Q94
X-Google-Smtp-Source: AGHT+IGasWr0k0KEN5sP+v9RER4xfDUZYpeJMU8PqWe5qEU+lkJZ7i0M6DKAroSovgmgzTmPCbMgcg==
X-Received: by 2002:a5d:6d09:0:b0:34a:b682:7978 with SMTP id e9-20020a5d6d09000000b0034ab6827978mr4506308wrq.42.1714225247471;
        Sat, 27 Apr 2024 06:40:47 -0700 (PDT)
Received: from localhost ([185.77.198.11])
        by smtp.gmail.com with ESMTPSA id d9-20020adfe2c9000000b00349a5b8eba6sm25028151wrj.34.2024.04.27.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 06:40:47 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Shuah Khan <shuah@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH] drm/vc4: remove all usages of of_node_put()
Date: Sat, 27 Apr 2024 15:40:44 +0200
Message-Id: <20240427134044.38910-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the scope-based cleanup feature to clean up 'struct device_node *'
when they go out of scope, and remove all instances of of_node_put()
within the same scope, to simplify function exit and avoid potential
memory leaks.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c  | 14 ++++++--------
 drivers/gpu/drm/vc4/vc4_hdmi.c |  4 +---
 drivers/gpu/drm/vc4/vc4_hvs.c  |  4 +---
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index c133e96b8aca..bb0bb052e595 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -289,7 +289,6 @@ static int vc4_drm_bind(struct device *dev)
 	struct rpi_firmware *firmware = NULL;
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
-	struct device_node *node;
 	struct drm_crtc *crtc;
 	bool is_vc5;
 	int ret = 0;
@@ -302,11 +301,10 @@ static int vc4_drm_bind(struct device *dev)
 	else
 		driver = &vc4_drm_driver;
 
-	node = of_find_matching_node_and_match(NULL, vc4_dma_range_matches,
-					       NULL);
+	struct device_node *node __free(device_node) =
+		of_find_matching_node_and_match(NULL, vc4_dma_range_matches, NULL);
 	if (node) {
 		ret = of_dma_configure(dev, node, true);
-		of_node_put(node);
 
 		if (ret)
 			return ret;
@@ -341,10 +339,10 @@ static int vc4_drm_bind(struct device *dev)
 			goto err;
 	}
 
-	node = of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
-	if (node) {
-		firmware = rpi_firmware_get(node);
-		of_node_put(node);
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
+	if (np) {
+		firmware = rpi_firmware_get(np);
 
 		if (!firmware) {
 			ret = -EPROBE_DEFER;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d30f8e8e8967..915e8da3f41a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3661,7 +3661,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_hdmi *vc4_hdmi;
 	struct drm_encoder *encoder;
-	struct device_node *ddc_node;
 	int ret;
 
 	vc4_hdmi = drmm_kzalloc(drm, sizeof(*vc4_hdmi), GFP_KERNEL);
@@ -3699,14 +3698,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
+	struct device_node *ddc_node __free(device_node) = of_parse_phandle(dev->of_node, "ddc", 0);
 	if (!ddc_node) {
 		DRM_ERROR("Failed to find ddc node in device tree\n");
 		return -ENODEV;
 	}
 
 	vc4_hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
-	of_node_put(ddc_node);
 	if (!vc4_hdmi->ddc) {
 		DRM_DEBUG("Failed to get ddc i2c adapter by node\n");
 		return -EPROBE_DEFER;
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 04af672caacb..6e3613e06e09 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -845,15 +845,13 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 
 	if (vc4->is_vc5) {
 		struct rpi_firmware *firmware;
-		struct device_node *node;
+		struct device_node *node __free(device_node) = rpi_firmware_find_node();
 		unsigned int max_rate;
 
-		node = rpi_firmware_find_node();
 		if (!node)
 			return -EINVAL;
 
 		firmware = rpi_firmware_get(node);
-		of_node_put(node);
 		if (!firmware)
 			return -EPROBE_DEFER;
 
-- 
2.34.1


