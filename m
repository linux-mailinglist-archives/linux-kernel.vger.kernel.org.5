Return-Path: <linux-kernel+bounces-78236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86D861096
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B2B1F2477C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220AB7D41B;
	Fri, 23 Feb 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kouTaRKu"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E127AE5A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688271; cv=none; b=WCcEFnAmZwF5Xpw2qLASdzC/5AxVTbrg7SeGaKDuD/dHSJmNHYZZIrZKPlyg90izkauJvLxqnsI/gj6VbLE6j1xe07aOrglq4jQy9UZEK3zc/O1Iu1AoPWGmzgWVsN7gsDClkmHghcN7AYXsDhfcvW2T//7gcEZZrStFFkHhu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688271; c=relaxed/simple;
	bh=D4TC7GfNKrDRx6FBTflEjIvY9r2R7Bzpo66QJhUPBxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijQTIwr5o6OYNmIEZNx7q4R7XpMljUxblti9AKMMI8T0SXnwn5xYGQ5QxCSQ7xSBMANixj04FjxU6HsSJz9otK9I41yC1mXgQBYC8XLC0GPEnWVNMPyGOJ8MXd45gdD2w+81iPAK4ecv2vMcparexcxdysV8PlWwi1tj2691M5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kouTaRKu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FDD040008;
	Fri, 23 Feb 2024 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708688267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNrV5eCxkdETUulcpe7tOcXgNVakjWdt073qLmEHzKs=;
	b=kouTaRKuTfTcAoM9ToSOL3v3gyJuhZW08t5pEiicjf8+zfnTwqLQAYUbNpRzxtRRVb3qTY
	IkKijAfqp63rYraz2kIkZ+ZZN0TWxMv3nN6/MTi68sHbn9dsFYSrbd1cz0baSrSVzPI5ka
	tWkyssy5NgihjXaafJi94gnnxTySjkvLXxrAX2WyrMaQLftYKXUEy1HBKXcQQglmwFRcTr
	cDTjHAGXwBN/3bcVZicUMfVnTNNz1nK3ndTJ4CnOSIE/2jvghIKq4TKP5M3vc5nb/FbD73
	n2lanX9hjNlFLkbOBfPeObz4/jYqOp4+tRO4oHg+A2Fe6detoCZO/Yj7b1A3Pg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 12:37:24 +0100
Subject: [PATCH v2 4/9] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-yuv-v2-4-aa6be2827bb7@bootlin.com>
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
In-Reply-To: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6217;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=D4TC7GfNKrDRx6FBTflEjIvY9r2R7Bzpo66QJhUPBxk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2IOEwoI4N0FIXNcK2HPTYCpvi0fY+WSpre+qy5rm
 +YejseOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdiDhAAKCRAgrS7GWxAs4nbIEA
 CQ1KCymKwudKv0f2bvCot66dLSnQ/FnWvQsRyeE7//H7pgOfPM6zkt+LnDy9rJa3NVnCQMwchujgfd
 EgEcVnQ+ZNm01gEQ0qus8mIQNNpZjPMZi09O7kfeZ54c4N/upSy/4sxdEFF7bJdOYC2SNygsZ1Qz10
 sr/TERgrIJ8qpOn1/Bo04jvrPr/PpI5QiPVsxdmrYscTe2M2d504e9QujoPXlv9zcfuposBp/89FGO
 WihVRVo6vxjbYreJLvD3tIOo+mit5LCJekR5r3vbma4sjie/ol3xn7kwnHE2hXZwGkZJhjkXOrDnem
 36Ffix/9ShjhSVTPK3i8Owgf7Ql4JB/Th5J6/alJjncnkibempek5V0kq14XqrgN23Ozt+IYXGVvCs
 R7TuVv58rhtf7e9ptws7gufMXjEEgSDuieJdL+9YCJDkSMkvI8AczzQw4Qe1Tlo5NRmaSXRUFLpOro
 GRngmzXxGISSxfrW5KO4inBASrFEjSBTZs7TQgZO2vneF6NL5N6PAsG9WMoAnxJGinEO6G/N7VEmu1
 dzi0vKIwxhpfqPolZm+VcHVOWx9Q9HsOj9ISRjauoXGxK8r1BhUm6PrjnBdyxXmwHXYxjXmSsPQWSC
 N2Imw59gDcaSibuGRE9qjK7x5I3sxDVHlGGsuweMStbwRLyS5lYD1tsrg6GA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
compiler to check if the passed functions take the correct arguments.
Such typedefs will help ensuring consistency across the code base in
case of update of these prototypes.

Introduce a check around the get_pixel_*_functions to avoid using a
nullptr as a function.

Document for those typedefs.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h       | 23 +++++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_formats.c   |  8 ++++----
 drivers/gpu/drm/vkms/vkms_formats.h   |  4 ++--
 drivers/gpu/drm/vkms/vkms_plane.c     |  9 ++++++++-
 drivers/gpu/drm/vkms/vkms_writeback.c |  9 ++++++++-
 5 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 18086423a3a7..886c885c8cf5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -53,12 +53,31 @@ struct line_buffer {
 	struct pixel_argb_u16 *pixels;
 };
 
+/**
+ * typedef pixel_write_t - These functions are used to read a pixel from a
+ * `struct pixel_argb_u16*`, convert it in a specific format and write it in the @dst_pixels
+ * buffer.
+ *
+ * @dst_pixel: destination address to write the pixel
+ * @in_pixel: pixel to write
+ */
+typedef void (*pixel_write_t)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
+
 struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
 	struct vkms_frame_info wb_frame_info;
-	void (*pixel_write)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
+	pixel_write_t pixel_write;
 };
 
+/**
+ * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
+ * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
+ *
+ * @src_pixels: Pointer to the pixel to read
+ * @out_pixel: Pointer to write the converted pixel
+ */
+typedef void (*pixel_read_t)(u8 *src_pixels, struct pixel_argb_u16 *out_pixel);
+
 /**
  * vkms_plane_state - Driver specific plane state
  * @base: base plane state
@@ -69,7 +88,7 @@ struct vkms_writeback_job {
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info *frame_info;
-	void (*pixel_read)(u8 *src_buffer, struct pixel_argb_u16 *out_pixel);
+	pixel_read_t pixel_read;
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index cb7a49b7c8e7..1f5aeba57ad6 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -262,7 +262,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
  *
  * @format: 4cc of the format
  */
-void *get_pixel_conversion_function(u32 format)
+pixel_read_t get_pixel_read_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -276,7 +276,7 @@ void *get_pixel_conversion_function(u32 format)
 	case DRM_FORMAT_RGB565:
 		return &RGB565_to_argb_u16;
 	default:
-		return NULL;
+		return (pixel_read_t)NULL;
 	}
 }
 
@@ -287,7 +287,7 @@ void *get_pixel_conversion_function(u32 format)
  *
  * @format: 4cc of the format
  */
-void *get_pixel_write_function(u32 format)
+pixel_write_t get_pixel_write_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -301,6 +301,6 @@ void *get_pixel_write_function(u32 format)
 	case DRM_FORMAT_RGB565:
 		return &argb_u16_to_RGB565;
 	default:
-		return NULL;
+		return (pixel_write_t)NULL;
 	}
 }
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index cf59c2ed8e9a..3ecea4563254 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -5,8 +5,8 @@
 
 #include "vkms_drv.h"
 
-void *get_pixel_conversion_function(u32 format);
+pixel_read_t get_pixel_read_function(u32 format);
 
-void *get_pixel_write_function(u32 format);
+pixel_write_t get_pixel_write_function(u32 format);
 
 #endif /* _VKMS_FORMATS_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index d5203f531d96..f68b1b03d632 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -106,6 +106,13 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 		return;
 
 	fmt = fb->format->format;
+	pixel_read_t pixel_read = get_pixel_read_function(fmt);
+
+	if (!pixel_read) {
+		DRM_WARN("Pixel format is not supported by VKMS planes. State is inchanged\n");
+		return;
+	}
+
 	vkms_plane_state = to_vkms_plane_state(new_state);
 	shadow_plane_state = &vkms_plane_state->base;
 
@@ -124,7 +131,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
 			drm_rect_height(&frame_info->rotated), frame_info->rotation);
 
-	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
+	vkms_plane_state->pixel_read = pixel_read;
 }
 
 static int vkms_plane_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index c8582df1f739..c92b9f06c4a4 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -140,6 +140,13 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
+	pixel_write_t pixel_write = get_pixel_write_function(wb_format);
+
+	if (!pixel_write) {
+		DRM_WARN("Pixel format is not supported by VKMS writeback. State is inchanged\n");
+		return;
+	}
+
 	vkms_set_composer(&vkmsdev->output, true);
 
 	active_wb = conn_state->writeback_job->priv;
@@ -150,7 +157,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	crtc_state->wb_pending = true;
 	spin_unlock_irq(&output->composer_lock);
 	drm_writeback_queue_job(wb_conn, connector_state);
-	active_wb->pixel_write = get_pixel_write_function(wb_format);
+	active_wb->pixel_write = pixel_write;
 	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
 	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
 }

-- 
2.43.0


