Return-Path: <linux-kernel+bounces-139325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C508A0170
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D86FB23C65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04A181CE9;
	Wed, 10 Apr 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFYX6sFV"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D6181CE0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781957; cv=none; b=Rcn5PDRFNYHQnfLE63ORROjAlT6mp6qnlMdlcBG8YTPuYduIBRjMhE766+4EzD+xuAi6KzM30p18L1Ze4pgO0Te771HvvFWFjmP6JfHv9nFZGJybAwLjBapbo11Jr+ChZUPaHFWHjn1NcbhlLFa4CUDt+8vJALDaagJpitMEfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781957; c=relaxed/simple;
	bh=bMzjQWQMtB75ExL7Mufx5SJbm3fyIcSyleJcxUjqv6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DjT1ChVY3NngCgAI419dVn3D/863kdz/cMCWHWLL7fE2ubB6RY+QnIkL+Z/0gXV/Vc0oO/6PXwoZvtApsErVk4ju+IF1fyPShZp5Yl5/Nje2v75Wnw6EndNvAzXfy51WMA1InbTu/49bWm1XPVJiB728z7Hd9XGpVR3i6iyh0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFYX6sFV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d700beb60bso116030961fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712781951; x=1713386751; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsGqX3KEMe0tMFWNo37D5kyKHEthzUhLzdIDt7eGccA=;
        b=eFYX6sFV8WfupG0a+ZXUu5zJvPPuPPHoiv/WGKDgR6SeAg+D+Sk0foS6tS9CbIN0wC
         8lneYp7IoGcaDnUYQ+mbYUaQQCIc2usPopA2s4FiS9+c866Jt9uaOo9A5C+5wgXH6p1n
         UAX3qqUs9KICxBO+LNSKWb4TNrseccySs7EMXyzGexiX+REy0abut2fEmy6d5zOmC7g2
         SVGAfpcTPrK1xQskfWuvkxvh3kUe4dXjcpex3Ly5eRFzhUKzlUwzw6MAA2PDjG8uUAZD
         jaI1HmEWHhQzUVNtt1eCW/OnkLuQgaUUPa381CW3FQXCYh6HEMFICX5Zigg07th/Yzvr
         7m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712781951; x=1713386751;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsGqX3KEMe0tMFWNo37D5kyKHEthzUhLzdIDt7eGccA=;
        b=SMy5713SXyX6tGVbveEvMMULnLHHnOhfcGS6aA4wDRsEkplPXqqv53Z73jf6I8g6pY
         UORg25I4WThjQMHbJNntRc2GlfRT2Oj8qs/2hKilFevKNycfHIWJp80Fiqb8pXz8tm+W
         Q1F87l0f4yOQKlClIJ0cSDiHjw9tZrWrPCYHsptLRUi7T58B74qy5i37y++waaBuLmdQ
         KwkqH6sKxpVQJ/AzKAEzlK1mZilmqQ3mO4puhAeZ4pfMBihxP15Fh8d0qtY+QDmxByuh
         jWckVjSEIQcF3B/aRdj5I6wgkudsB+6Ksd3D1NjeNtrWfc1U4lW430T/GNzbmTo339zB
         ElWA==
X-Forwarded-Encrypted: i=1; AJvYcCWo9zTImDzfAgQMiSU9htl7ct1NHugQIGHA+Bms+tsOX42E3MlvqEIyNVISRRfIIkC2ueoCenx9N1DAgsfPXlDFTAgmvqSGcJJL6KES
X-Gm-Message-State: AOJu0YzU3dQgTewrR2gEgeyRsWo4w+uRaggwXqBY8MCXbC6joHt2nRJm
	pG7yUZ/5j/ttJ1Q0iJcRKDFQ+pqypAX17rqwzBLOYp377erMp1Fv
X-Google-Smtp-Source: AGHT+IH3QYbCsvLH7JDF0/52kyHq3vwRp8DboQ3O3yhv+yJaWJs1M0Qq+jeH4ZaKHY74WkJWalcKnw==
X-Received: by 2002:a2e:9645:0:b0:2d8:8fb6:a53d with SMTP id z5-20020a2e9645000000b002d88fb6a53dmr3057039ljh.42.1712781951058;
        Wed, 10 Apr 2024 13:45:51 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id jo12-20020a170906f6cc00b00a51e004de4asm43200ejb.11.2024.04.10.13.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:45:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 22:45:43 +0200
Subject: [PATCH] drm/kmb: Replace of_node_put() with automatic cleanup
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-kmb_of_node_put-v1-1-4d802add6a89@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHb6FmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0MD3ezcpPj8tPi8/JTU+ILSEt3ExDTDZHPzFEszQwMloK6CotS0zAq
 widGxtbUATO4l52EAAAA=
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Edmund Dea <edmund.j.dea@intel.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Julia Lawall <julia.lawall@inria.fr>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712781949; l=3721;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=bMzjQWQMtB75ExL7Mufx5SJbm3fyIcSyleJcxUjqv6A=;
 b=4x42bRafiDixZIvr/1GV+80+RHyrDLGKz29TWe8GX6b0FFhb0v8RSSPpd7pYQWtKbR4sh1t58
 +Olbpp/kpnqBnbdraSQpOzSQURkqny+9MH7QKG9qU0kRfSUtrmPgrzJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
The patch is based on the latest linux-next tag (next-20240410).
---
 drivers/gpu/drm/kmb/kmb_drv.c | 13 ++++---------
 drivers/gpu/drm/kmb/kmb_dsi.c | 11 ++++-------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 169b83987ce2..1a743840688a 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -480,8 +480,8 @@ static int kmb_probe(struct platform_device *pdev)
 	struct device *dev = get_device(&pdev->dev);
 	struct kmb_drm_private *kmb;
 	int ret = 0;
-	struct device_node *dsi_in;
-	struct device_node *dsi_node;
+	struct device_node *dsi_in __free(device_node) =
+		of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
 	struct platform_device *dsi_pdev;
 
 	/* The bridge (ADV 7535) will return -EPROBE_DEFER until it
@@ -491,28 +491,23 @@ static int kmb_probe(struct platform_device *pdev)
 	 *  and then the rest of the driver initialization can proceed
 	 *  afterwards and the bridge can be successfully attached.
 	 */
-	dsi_in = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
 	if (!dsi_in) {
 		DRM_ERROR("Failed to get dsi_in node info from DT");
 		return -EINVAL;
 	}
-	dsi_node = of_graph_get_remote_port_parent(dsi_in);
+	struct device_node *dsi_node __free(device_node) =
+		of_graph_get_remote_port_parent(dsi_in);
 	if (!dsi_node) {
-		of_node_put(dsi_in);
 		DRM_ERROR("Failed to get dsi node from DT\n");
 		return -EINVAL;
 	}
 
 	dsi_pdev = of_find_device_by_node(dsi_node);
 	if (!dsi_pdev) {
-		of_node_put(dsi_in);
-		of_node_put(dsi_node);
 		DRM_ERROR("Failed to get dsi platform device\n");
 		return -EINVAL;
 	}
 
-	of_node_put(dsi_in);
-	of_node_put(dsi_node);
 	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
 
 	if (ret == -EPROBE_DEFER) {
diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index cf7cf0b07541..61f02462b778 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -216,8 +216,6 @@ static const struct mipi_dsi_host_ops kmb_dsi_host_ops = {
 
 int kmb_dsi_host_bridge_init(struct device *dev)
 {
-	struct device_node *encoder_node, *dsi_out;
-
 	/* Create and register MIPI DSI host */
 	if (!dsi_host) {
 		dsi_host = kzalloc(sizeof(*dsi_host), GFP_KERNEL);
@@ -239,21 +237,20 @@ int kmb_dsi_host_bridge_init(struct device *dev)
 	}
 
 	/* Find ADV7535 node and initialize it */
-	dsi_out = of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
+	struct device_node *dsi_out __free(device_node) =
+		of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
 	if (!dsi_out) {
 		DRM_ERROR("Failed to get dsi_out node info from DT\n");
 		return -EINVAL;
 	}
-	encoder_node = of_graph_get_remote_port_parent(dsi_out);
+	struct device_node *encoder_node __free(device_node) =
+		of_graph_get_remote_port_parent(dsi_out);
 	if (!encoder_node) {
-		of_node_put(dsi_out);
 		DRM_ERROR("Failed to get bridge info from DT\n");
 		return -EINVAL;
 	}
 	/* Locate drm bridge from the hdmi encoder DT node */
 	adv_bridge = of_drm_find_bridge(encoder_node);
-	of_node_put(dsi_out);
-	of_node_put(encoder_node);
 	if (!adv_bridge) {
 		DRM_DEBUG("Wait for external bridge driver DT\n");
 		return -EPROBE_DEFER;

---
base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
change-id: 20240410-kmb_of_node_put-aaf1c77d9610

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


