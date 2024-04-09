Return-Path: <linux-kernel+bounces-136619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3489D638
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9F41C226C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678382888;
	Tue,  9 Apr 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QJc24gR+"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5B80619
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657085; cv=none; b=IC0Z5RQ655rG5KHut705Jhe8+2LCHfFXy4zCwltvfsD9gwhQOYtH5lMhTmXOqOUNmlV5MFh/sLI9Prpubt7Gr86XcjW27ZxEjQEgSGdfgEIzQeoial73c743Htdx00If8afCeP5QiVSwl4+0AYxx3fzFSFZERnyFruOMsqVhqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657085; c=relaxed/simple;
	bh=p9bWfzVhPSbxnan4gt/J8np1umoCeXuce2K3EFa4g9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSqJy1j/9cCHlOT3UpK0/nSNEWPdMDMErCn4x1MaTr1pYu7hPs1WkKYgOXGmyeZ+RCMgvvh7kWtmx6c202NQQ4KB1fJGr45wz0xTTADplFyDSD8AL1//fpBYUvFSpV3i+8fE1G6YQ7ox4Ig/Ajyg5N3n6xtvHEGwKWiS86UOsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QJc24gR+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95F33C0011;
	Tue,  9 Apr 2024 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712657081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaOfMtUooEBbcTUX3ySQvIrI0XekY4PkXHzJqdiW8Do=;
	b=QJc24gR+EXPcui/smHnpzu+Iyl0fuhh4pXJnOtuggGfG9A8hmU6oIIUMFDk+AM7gqRCVOe
	moo86y2k7ZTh6yHYSGXG6xew/rlTlEisKSupG68sd8dVYxDjrXVdEsxWgx8PCdy0HDzp8S
	aJaJL+zrJ76sZBor5k3l0+/Z6ahq7l+yBKcKGY/GHksEAaebdtuBtFN+tdV/hsAgAll8h5
	PECQCJjSoxj0wUowUdY+VstshOb+ZSFvw5YqriQYCP/vIdxqupAnmE07NPvtfEwWCkwBZN
	qg4M05eQ2Xk2Y6QN3dFkhDJAtuOd4E07KFvjo7U0OFmeKylztBHmUmdhjaakzA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 12:04:07 +0200
Subject: [PATCH 3/3] drm/fourcc: Add documentation around drm_format_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-google-drm-doc-v1-3-033d55cc8250@bootlin.com>
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
In-Reply-To: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3487;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=p9bWfzVhPSbxnan4gt/J8np1umoCeXuce2K3EFa4g9o=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFRK1SSdf8m+PrFjNQ3393GV2MGNqtQp/i5TiL
 IsTjcumGhaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhUStQAKCRAgrS7GWxAs
 4msAEACt6PBybYnO/0WibFTqCZSNQrho5XGmeeAUcpdpp9btXh0I2bQxxAqFRZgJG9iEnEJF2mo
 oePi6L0iTBRMesI/C/EP/XQbz+zD9lQhcxirWahCwz4yzDIJzkilX7WQ6Gd4yeBr1hQt0McLZvp
 AyXdUUrAMBMhu2hug+k205Q5+AdpIWF+zqaspIPSTarIgVoZc+oYo9e5mt3fkvUKr4ZYybFUIRh
 L+XQ9zd6Gdkx1QwLhnDNEu+OKv6YeITTQaqjld/Cz3ooXGBvd7e7D8sOTVENbDV49QODwjElgHh
 n95tUFT2Gzk1F5Tkmomd6pC+L+cv1Y/eJFLMGkaPhUImP/GvtlRfmUS0DpsSdULJvx8m5qpkDZo
 Pe6te1cbxdbGrH5A11iKW4t3Ckkr3wEYJOULKi2nXNWbQii+CbGX+TE+jAHNRrxE0/drcJOa4X6
 XLestlDulUHC2Zon0gw86eVhVtdODOQVQoDV//J2sIxoGEB1Rf2F9UMqv6dosrBA1puYjukI77v
 Y4V2JLU58fV0Ph06I9PGN8nAlUFM0h1tZbGUFXRIah7C3wjFIpq84ea8KMTLoyEB3yiBZsuHu08
 t/IKIoQ2Fb1q2Wo1w/EERvSIx5xzxbKfmqX4x4ABmbw1lETyMUUCT8QjvAScJuk6959UYdr4UB1
 HqKRZRmEfQTNkGQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Let's provide more details about the drm_format_info structure because
its content may not be straightforward for someone not used to video
formats and drm internals.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/drm/drm_fourcc.h | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index ccf91daa4307..66cc30e28f79 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -58,6 +58,44 @@ struct drm_mode_fb_cmd2;
 
 /**
  * struct drm_format_info - information about a DRM format
+ *
+ * A drm_format_info describes how planes and pixels are stored in memory.
+ *
+ * Some format like YUV can have multiple planes, counted in @num_planes. It
+ * means that a full pixel can be stored in multiple non-continuous buffers.
+ * For example, NV12 is a YUV format using two planes: one for the Y values and
+ * one for the UV values.
+ *
+ * On each plane, the "pixel" unit can be different in case of subsampling. For
+ * example with the NV12 format, a pixel in the UV plane is used for four pixels
+ * in the Y plane.
+ * The fields @hsub and @vsub are the relation between the size of the main
+ * plane and the size of the subsampled planes in pixels:
+ *	plane[0] width = hsub * plane[1] width
+ *	plane[0] height = vsub * plane[1] height
+ *
+ * In some formats, pixels are not independent in memory. It can be a packed
+ * representation to store more pixels per byte (for example P030 uses 4 bytes
+ * for three 10 bit pixels). It can also be used to represent tiled formats,
+ * where a continuous buffer in memory can represent a rectangle of pixels (for
+ * example, in DRM_FORMAT_Y0L0, a buffer of 8 bytes represents a 2x2 pixel
+ * region of the picture).
+ *	The field @char_per_block is the size of a block on a specific plane, in
+ *	bytes.
+ *	The fields @block_w and @block_h are the size of a block in pixels.
+ *
+ * The older format representation (which only uses @cpp, kept for historical
+ * reasons because there are a lot of places in drivers where it's used) is
+ * assuming that a block is always 1x1 pixel.
+ *
+ * To keep the compatibility with older format representations and treat block
+ * and non-block formats in the same way one should use:
+ *	- @char_per_block to access the size of a block on a specific plane, in
+ *	bytes.
+ *	- drm_format_info_block_width() to access the width of a block of a
+ *	specific plane, in pixels.
+ *	- drm_format_info_block_height() to access the height of a block of a
+ *	specific plane, in pixels.
  */
 struct drm_format_info {
 	/** @format: 4CC format identifier (DRM_FORMAT_*) */
@@ -97,13 +135,6 @@ struct drm_format_info {
 		 * formats for which the memory needed for a single pixel is not
 		 * byte aligned.
 		 *
-		 * @cpp has been kept for historical reasons because there are
-		 * a lot of places in drivers where it's used. In drm core for
-		 * generic code paths the preferred way is to use
-		 * @char_per_block, drm_format_info_block_width() and
-		 * drm_format_info_block_height() which allows handling both
-		 * block and non-block formats in the same way.
-		 *
 		 * For formats that are intended to be used only with non-linear
 		 * modifiers both @cpp and @char_per_block must be 0 in the
 		 * generic format table. Drivers could supply accurate

-- 
2.43.0


