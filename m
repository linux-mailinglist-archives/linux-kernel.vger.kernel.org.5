Return-Path: <linux-kernel+bounces-136941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9902689DA38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD7283B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574F12FB24;
	Tue,  9 Apr 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T7xIZI+D"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773B12F384
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669150; cv=none; b=j92oJTx5jTbGZ6xktMi7/TUxQkfBPIgUasPE7VH21qonuWSiUb4fCW1S6hFJuVsTVtiMoN8GTYc/yD4F/5iIcEyYxe/Yal3cpcUVTZHa37cHNEqK9qG8oz42RNunoInar3Hgq8wBffVKx689sc0/A3b761v5PfCFlN/Zno+uaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669150; c=relaxed/simple;
	bh=164qTOxE3KUK4t9/ok9gCy0euOEROLUxKU8GIhJ3Pdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRlD5wFeybNAlw1J94sYKoq5ex0aCitaINcCgIvfXrvy9WLw+Vtbt5YRPVz+MuNCm0S0mACUJ+hCcv62ZCN4srWyBr413okL6X/e1sHRGX2Jcbm/tkV2LZx3owCBNWuDwzpw6Oi6wsEs2QHseeFJNrks6GlYIROpsryU071Tm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T7xIZI+D; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDAC3240013;
	Tue,  9 Apr 2024 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hjEDAG/XIZxKuMYGyzJPCctK8bCbeQAujWuOuwxeXw=;
	b=T7xIZI+DEqmYE/WHent4D0qKg/OJpwgjfZm+31XT2vZTJ7ENoXnM+SktMzm7emOcgRJZp8
	X+tnlgo7QK7LFP4iTAw0Dl61bESa3xCm5lAGb8rbCqTejCh+uEcIs388C3tGeuaqIeUrkI
	zpSlX3ObOlXDdcy2oYHhgyqMSK5nGFjb8l+VWlPoK4TK11WRfwLFtu6HurxyblHd2A7Hc7
	5UgTRwGrllPNFS3KuTbfnQKKg3sbobLETHQORq51kvdtoz+rRTgtfXbYi58q08f9br/xTL
	VECa19B/4rpfiUCORx9SM1D/69s6JZKmrJ4nfuhngkkdEWljmX9b7fsq8N1/cw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:21 +0200
Subject: [PATCH v6 03/17] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-3-de1c5728fd70@bootlin.com>
References: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
In-Reply-To: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7486;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=164qTOxE3KUK4t9/ok9gCy0euOEROLUxKU8GIhJ3Pdk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHRQbhMmtKgiHZ3xFZs0vN1XIgKcinWV8pKB
 UfSttpTHYGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0QAKCRAgrS7GWxAs
 4vcMD/43m7oXnoZmN6DKhdh0V0MtqNJ5HtRltDn2tmxdMufCXChzNMrszhDLsC6sGyVAh3un7Jy
 7sCNK4JE+IzM6K9QM56C7Quzum/siXjvQW2veI5/3oQCor34yt+y27vjzEjAFOSJoC7mXRZDrBp
 uYRMM/DrtwmTgeBDv3QcJ1sC6Zl/Cr/sHaCbhGy0KKVCmVqmBlxT3rgTirl1zYp6UUKrbi2+9KE
 VtLzDH9ZTBG+bW47F+GIyDMP8+aLzu21QzYyRKz6FyyQ2C9G5W8QQs6Acuzr9cfmhCdRn23+uNI
 4jQKEvcP/weoueKCGsB8LfZeEhqC1ZMmb6J58vk9zH7k6xSiV8AFP74X5GO/iEojdWpjLms8I4X
 Ecr6YkLJ4Nd/YMkHHGUnGuVU0ntXL5DGhE2JKGy+O3ojP1yc9NY2a48XdNXFjcpbR0udR2iuLlV
 dsamVhFfK0AMuX7e+k+phEohwtTvP3X4637Hzs+E204tt35KDaWen4o+LdqRpTru4IYppc611/J
 cJV7GK5s8Iq1cp2dS6hAWaLn1eLgt7O5SAF5EPDVE1opHBvOtm/kZcs53Dj2RHetlf4rtAM3EZM
 NnX6nPOKSAhB0bPTJQW6gY+spnC1Qfrl2aYpd1QJxlMhz8mmOF2ze9mG6XyVmOzsHYZztfbSkqm
 t28Pkk0DnuOg5Nw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add some documentation on pixel conversion functions.
Update of outdated comments for pixel_write functions.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c |  7 ++++
 drivers/gpu/drm/vkms/vkms_drv.h      | 15 ++++++++-
 drivers/gpu/drm/vkms/vkms_formats.c  | 62 ++++++++++++++++++++++++++++++------
 3 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index c6d9b4a65809..da0651a94c9b 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -189,6 +189,13 @@ static void blend(struct vkms_writeback_job *wb,
 
 	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
 
+	/*
+	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
+	 * complexity to avoid poor blending performance.
+	 *
+	 * The function vkms_compose_row is used to read a line, pixel-by-pixel, into the staging
+	 * buffer.
+	 */
 	for (size_t y = 0; y < crtc_y_limit; y++) {
 		fill_background(&background_color, output_buffer);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index b4b357447292..a86cb537d6aa 100644
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
@@ -49,9 +60,11 @@ struct vkms_writeback_job {
 };
 
 /**
- * vkms_plane_state - Driver specific plane state
+ * struct vkms_plane_state - Driver specific plane state
  * @base: base plane state
  * @frame_info: data required for composing computation
+ * @pixel_read: function to read a pixel in this plane. The creator of a vkms_plane_state must
+ * ensure that this pointer is valid
  */
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index d597c48452ac..f157c43da4d6 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -9,6 +9,18 @@
 
 #include "vkms_formats.h"
 
+/**
+ * pixel_offset() - Get the offset of the pixel at coordinates x/y in the first plane
+ *
+ * @frame_info: Buffer metadata
+ * @x: The x coordinate of the wanted pixel in the buffer
+ * @y: The y coordinate of the wanted pixel in the buffer
+ *
+ * The caller must ensure that the framebuffer associated with this request uses a pixel format
+ * where block_h == block_w == 1.
+ * If this requirement is not fulfilled, the resulting offset can point to an other pixel or
+ * outside of the buffer.
+ */
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
 {
 	struct drm_framebuffer *fb = frame_info->fb;
@@ -16,18 +28,22 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
 	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
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
+ * @x: The x (width) coordinate inside the plane
+ * @y: The y (height) coordinate inside the plane
  *
  * Takes the information stored in the frame_info, a pair of coordinates, and
  * returns the address of the first color channel.
  * This function assumes the channels are packed together, i.e. a color channel
  * comes immediately after another in the memory. And therefore, this function
  * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
+ *
+ * The caller must ensure that the framebuffer associated with this request uses a pixel format
+ * where block_h == block_w == 1, otherwise the returned pointer can be outside the buffer.
  */
 static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
 				int x, int y)
@@ -52,6 +68,13 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
 	return x;
 }
 
+/*
+ * The following functions take pixel data from the buffer and convert them to the format
+ * ARGB16161616 in out_pixel.
+ *
+ * They are used in the vkms_compose_row() function to handle multiple formats.
+ */
+
 static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
 	/*
@@ -144,12 +167,11 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 }
 
 /*
- * The following  functions take an line of argb_u16 pixels from the
- * src_buffer, convert them to a specific format, and store them in the
- * destination.
+ * The following functions take one &struct pixel_argb_u16 and convert it to a specific format.
+ * The result is stored in @dst_pixels.
  *
- * They are used in the `compose_active_planes` to convert and store a line
- * from the src_buffer to the writeback buffer.
+ * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
+ * the writeback buffer.
  */
 static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
@@ -215,6 +237,14 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
+ * after the blending to write a line in the writeback buffer.
+ *
+ * @wb: Job where to insert the final image
+ * @src_buffer: Line to write
+ * @y: Row to write in the writeback buffer
+ */
 void vkms_writeback_row(struct vkms_writeback_job *wb,
 			const struct line_buffer *src_buffer, int y)
 {
@@ -228,6 +258,13 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 		wb->pixel_write(dst_pixels, &in_pixels[x]);
 }
 
+/**
+ * get_pixel_conversion_function() - Retrieve the correct read_pixel function for a specific
+ * format. The returned pointer is NULL for unsupported pixel formats. The caller must ensure that
+ * the pointer is valid before using it in a vkms_plane_state.
+ *
+ * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
+ */
 void *get_pixel_conversion_function(u32 format)
 {
 	switch (format) {
@@ -246,6 +283,13 @@ void *get_pixel_conversion_function(u32 format)
 	}
 }
 
+/**
+ * get_pixel_write_function() - Retrieve the correct write_pixel function for a specific format.
+ * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
+ * pointer is valid before using it in a vkms_writeback_job.
+ *
+ * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
+ */
 void *get_pixel_write_function(u32 format)
 {
 	switch (format) {

-- 
2.43.0


