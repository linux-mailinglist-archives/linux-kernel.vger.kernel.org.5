Return-Path: <linux-kernel+bounces-78235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABE861095
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A810E282D73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126F7CF29;
	Fri, 23 Feb 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CoS7pxYK"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3ED78B57
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688270; cv=none; b=QJ4YX5cg70xgG3j3gx7PEuyy3urxKP79g1YHDCXB/CpNLAQ2hFJXy3Ov2nxCXfnViUDtFe8+CG9pvA5QA1LuBW91dGg5avKucdn1L/10qjWuOdEAFVbuwjgo7yjGFb+KNPsVOqE2Rei4hJw+pGfCJjyKckO16RRiD6meGXYBwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688270; c=relaxed/simple;
	bh=+DsmO8SGjkaXdS5jYLEBNm7wDQTKeBuOh6cIQzNvHU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyxj+kzlVvkPWEUo20623vuOaQkR14mJ4yqxev6hoUml5yGPaRDTWATyzcKtifzRchqvJOeTrGSDYsBpx/yyRTQKT7Px5HQWwktv3fb6lI05I006zgeKh2u2gU+guTEiuJYN+mf0W9jt8SjfB3nf27A4hjRmDxKLApNMZHTcT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CoS7pxYK; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EEF040009;
	Fri, 23 Feb 2024 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708688266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5UinReH6vUXNxBJ97EG+ZqktERoBQAcu/k8mtlmiaY=;
	b=CoS7pxYKCeWB23zyjrumCaMa+xAnUMvTeoN/GZkSgbmne85fAH30Jx5iHOZWlHhCATQeTF
	h/Tmn6TPGETR9cWb5G4b2SZ+wno186d4k1pI/tclFUqQTrdEt4hFd6eHOTjtL7pyZW5b+u
	sQLOjtmhcYTaj1ZISUYi8Z8Tu9CG2i7caU/CpdlwvCNXKzsnEncnwu6pkSw3pLA3pWwXxW
	RsLRYLAvCVSyD4NG7xPgE2aODwIDJCwHUnQSRxVURcSJDTdX7Q3pB/JpNqpG+C4XuYG50k
	4hfXoQyd6IxPIRc9AcKoqHopR0qxBVkQ0zqxA4sdAzEAYXCWTsI05G+VpyNYLA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 12:37:23 +0100
Subject: [PATCH v2 3/9] drm/vkms: write/update the documentation for pixel
 conversion and pixel write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-yuv-v2-3-aa6be2827bb7@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6432;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+DsmO8SGjkaXdS5jYLEBNm7wDQTKeBuOh6cIQzNvHU8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2IOELQdbsAL3kPoQQMyXC3JqipcWeSAmxUPjPdxL
 d/KVrGuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdiDhAAKCRAgrS7GWxAs4uboEA
 Cq/5qtV9Y5FvfIqHbu4XA94FvAcUfEnpZKNSgk1MYRGk0lerUT5AToE34MC59pzv48BvCXZpbY/CLE
 QNwsSBr3kl1p8UOanos2TCOiaACkVZ6WJauMELLu9I2vKbz6+1+ENlH1JXha8cLIA+i+BN/YjvTTX2
 guPJwFzyRet8vA+IBwVLp61vWbBrnbXLonIUJlzNMfTJ348RdZzYcmMBU/iNhrxzgu/au4Ruef8ZR6
 n7Y9zdfH60Zie93eEVY5qklmwR+KPMjA4YXkAvgP6hJF0uZqzzYoDooA35NRqb8KAj3dV/YWH11mx2
 5cU1Ly0/K6M2nTs+SnVkJB7ZSCB+qxXFIUlWyZvMCNU7yYuw+ELmzKeivzNcifq769KuioUDYknwcA
 b6safCAMTi46oD9vuCJyAyW8d8G2DcKlxciPZQ4f3tJJmdmyC7I4IYnZnAaGL9I/7DauNCjO6JuBQW
 ZMn0KeltOycRUt8wufbTDhuFvWsIrJsmua8DJ8m/5kzOiB5rIguFhJer5RHN0+WUo7z45oGSZJveLk
 v+wkCGXgx/bHDm+kXQT3Du3d4J2MENBdx2v5Pd+2t5oa3Qcd0UkEzWZgWbcrCYEJxrrwLqE/BriMOj
 TqCeK8hrkI4dp2dRWEcTDyzQHXEKldd3KlCTYIWwaKUoEqAPDbqcbbEu7Ocg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add some documentation on pixel conversion functions.
Update of outdated comments for pixel_write functions.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c |  4 +++
 drivers/gpu/drm/vkms/vkms_drv.h      | 13 ++++++++
 drivers/gpu/drm/vkms/vkms_formats.c  | 58 ++++++++++++++++++++++++++++++------
 3 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index c6d9b4a65809..5b341222d239 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -189,6 +189,10 @@ static void blend(struct vkms_writeback_job *wb,
 
 	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
 
+	/*
+	 * The planes are composed line-by-line. It is a necessary complexity to avoid poor
+	 * blending performance.
+	 */
 	for (size_t y = 0; y < crtc_y_limit; y++) {
 		fill_background(&background_color, output_buffer);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index b4b357447292..18086423a3a7 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -25,6 +25,17 @@
 
 #define VKMS_LUT_SIZE 256
 
+/**
+ * struct vkms_frame_info - structure to store the state of a frame
+ *
+ * @fb: backing drm framebuffer
+ * @src: source rectangle of this frame in the source framebuffer
+ * @dst: destination rectangle in the crtc buffer
+ * @map: see drm_shadow_plane_state@data
+ * @rotation: rotation applied to the source.
+ *
+ * @src and @dst should have the same size modulo the rotation.
+ */
 struct vkms_frame_info {
 	struct drm_framebuffer *fb;
 	struct drm_rect src, dst;
@@ -52,6 +63,8 @@ struct vkms_writeback_job {
  * vkms_plane_state - Driver specific plane state
  * @base: base plane state
  * @frame_info: data required for composing computation
+ * @pixel_read: function to read a pixel in this plane. The creator of a vkms_plane_state must
+ * ensure that this pointer is valid
  */
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 172830a3936a..cb7a49b7c8e7 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -9,6 +9,17 @@
 
 #include "vkms_formats.h"
 
+/**
+ * packed_pixels_offset() - Get the offset of the block containing the pixel at coordinates x/y
+ * in the first plane
+ *
+ * @frame_info: Buffer metadata
+ * @x: The x coordinate of the wanted pixel in the buffer
+ * @y: The y coordinate of the wanted pixel in the buffer
+ *
+ * The caller must be aware that this offset is not always a pointer to a pixel. If individual
+ * pixel values are needed, they have to be extracted from the resulting block.
+ */
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
 {
 	struct drm_framebuffer *fb = frame_info->fb;
@@ -17,12 +28,13 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
 			      + (x * fb->format->cpp[0]);
 }
 
-/*
- * packed_pixels_addr - Get the pointer to pixel of a given pair of coordinates
+/**
+ * packed_pixels_addr() - Get the pointer to the block containing the pixel at the given
+ * coordinates
  *
  * @frame_info: Buffer metadata
- * @x: The x(width) coordinate of the 2D buffer
- * @y: The y(Heigth) coordinate of the 2D buffer
+ * @x: The x(width) coordinate inside the plane
+ * @y: The y(height) coordinate inside the plane
  *
  * Takes the information stored in the frame_info, a pair of coordinates, and
  * returns the address of the first color channel.
@@ -53,6 +65,13 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
 	return x;
 }
 
+/*
+ * The following  functions take pixel data from the buffer and convert them to the format
+ * ARGB16161616 in out_pixel.
+ *
+ * They are used in the `vkms_compose_row` function to handle multiple formats.
+ */
+
 static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
 	/*
@@ -145,12 +164,11 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 }
 
 /*
- * The following  functions take an line of argb_u16 pixels from the
- * src_buffer, convert them to a specific format, and store them in the
- * destination.
+ * The following functions take one argb_u16 pixel and convert it to a specific format. The
+ * result is stored in @dst_pixels.
  *
- * They are used in the `compose_active_planes` to convert and store a line
- * from the src_buffer to the writeback buffer.
+ * They are used in the `vkms_writeback_row` to convert and store a pixel from the src_buffer to
+ * the writeback buffer.
  */
 static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
@@ -216,6 +234,14 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * Generic loop for all supported writeback format. It is executed just after the blending to
+ * write a line in the writeback buffer.
+ *
+ * @wb: Job where to insert the final image
+ * @src_buffer: Line to write
+ * @y: Row to write in the writeback buffer
+ */
 void vkms_writeback_row(struct vkms_writeback_job *wb,
 			const struct line_buffer *src_buffer, int y)
 {
@@ -229,6 +255,13 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 		wb->pixel_write(dst_pixels, &in_pixels[x]);
 }
 
+/**
+ * Retrieve the correct read_pixel function for a specific format.
+ * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
+ * pointer is valid before using it in a vkms_plane_state.
+ *
+ * @format: 4cc of the format
+ */
 void *get_pixel_conversion_function(u32 format)
 {
 	switch (format) {
@@ -247,6 +280,13 @@ void *get_pixel_conversion_function(u32 format)
 	}
 }
 
+/**
+ * Retrieve the correct write_pixel function for a specific format.
+ * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
+ * pointer is valid before using it in a vkms_writeback_job.
+ *
+ * @format: 4cc of the format
+ */
 void *get_pixel_write_function(u32 format)
 {
 	switch (format) {

-- 
2.43.0


