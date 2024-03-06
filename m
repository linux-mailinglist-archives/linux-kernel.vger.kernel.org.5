Return-Path: <linux-kernel+bounces-94524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6287410F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5221F237DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8A71419BC;
	Wed,  6 Mar 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="mP0AE+Hq"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0680140386
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755429; cv=none; b=rygOAasGqSQs9gn6i+C6EFk8h5mH0PYsntNHzahlP6XPEHK6fuolLBB7p6OwjJJ41SZMGBNZiQ7ftE/Fma1yK+/KepxXXq/nM9prag/DPMrfvuOKAAQSiStsZV43wvwKdLFaY3fMD7AvjxiMse2SF6qmzriENHbm9bY3aZtT+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755429; c=relaxed/simple;
	bh=h0PodFS5qCsCyCWWmRwb25OxPxljdoN865Ax2gcERF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1PM8r/CElea7sa4VpI0gjuiHaR2rHzneOdEm/PylTY13OjALTkQN2ld88/12KwTXtsPoAWiphCaomr7lMjhZa9LOPgn9xadsbftSj+a43o5L+WUagGW4WzqAqWoq7ioypbICC4lGlkKbCjHUbjQlSV+rTPBAPD+3Q8KaZWVpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=mP0AE+Hq; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Tqjzw02wBz9wM4;
	Wed,  6 Mar 2024 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709755420; bh=h0PodFS5qCsCyCWWmRwb25OxPxljdoN865Ax2gcERF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mP0AE+HqWm0eUi+j3N/Wu3jiqQoq/TVRhdxuYjQCy+At5EB+lJElGd69IZfSDsJ6d
	 PEcw7wJMidM6niyzA+lEU3owS0wTQbnIvKZbmwQGxZGx9izmjWbRuauZRYPLpekMHB
	 0QOcInocEFyxirvBg7jbcl4iUrqrymFArYdywH20=
X-Riseup-User-ID: 4C21D9B088B280759A744A19E3AD30C66DC2FF9F68FF7EEE6FD7EEE672255839
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Tqjzp2fpVzFvsm;
	Wed,  6 Mar 2024 20:03:34 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 06 Mar 2024 17:03:09 -0300
Subject: [PATCH 2/7] drm/vkms: Add comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-louis-vkms-conv-v1-2-5bfe7d129fdd@riseup.net>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
In-Reply-To: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 44d9b9b3bdc3..55ed3f598bd7 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -577,6 +577,18 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 0,
 	};
+
+	/*
+	 * Those matrixies were generated using the colour python framework
+	 *
+	 * Below are the function calls used to generate eac matrix, go to
+	 * https://colour.readthedocs.io/en/develop/generated/colour.matrix_YCbCr.html
+	 * for more info:
+	 *
+	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                                  is_legal = False,
+	 *                                  bits = 8) * 2**32).astype(int)
+	 */
 	static struct conversion_matrix yuv_bt601_full = {
 		.matrix = {
 			{ 4294967296, 0,           6021544149 },
@@ -585,6 +597,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 0,
 	};
+
+	/*
+	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                                  is_legal = True,
+	 *                                  bits = 8) * 2**32).astype(int)
+	 */
 	static struct conversion_matrix yuv_bt601_limited = {
 		.matrix = {
 			{ 5020601039, 0,           6881764740 },
@@ -593,6 +611,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 16,
 	};
+
+	/*
+	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                                  is_legal = False,
+	 *                                  bits = 8) * 2**32).astype(int)
+	 */
 	static struct conversion_matrix yuv_bt709_full = {
 		.matrix = {
 			{ 4294967296, 0,          6763714498 },
@@ -601,6 +625,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 0,
 	};
+
+	/*
+	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                                  is_legal = True,
+	 *                                  bits = 8) * 2**32).astype(int)
+	 */
 	static struct conversion_matrix yuv_bt709_limited = {
 		.matrix = {
 			{ 5020601039, 0,          7729959424 },
@@ -609,6 +639,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 16,
 	};
+
+	/*
+	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                                  is_legal = False,
+	 *                                  bits = 8) * 2**32).astype(int)
+	 */
 	static struct conversion_matrix yuv_bt2020_full = {
 		.matrix = {
 			{ 4294967296, 0,          6333358775 },
@@ -617,6 +653,12 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 0,
 	};
+
+	/*
+	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                                  is_legal = True,
+	 *                                  bits = 8) * 2**32).astype(int)
+	 */
 	static struct conversion_matrix yuv_bt2020_limited = {
 		.matrix = {
 			{ 5020601039, 0,          7238124312 },
@@ -625,6 +667,11 @@ get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 		},
 		.y_offset = 16,
 	};
+
+	/*
+	 * The next matrices are just the previous ones, but with the first and
+	 * second columns swapped
+	 */
 	static struct conversion_matrix yvu_bt601_full = {
 		.matrix = {
 			{ 4294967296, 6021544149,  0 },

-- 
2.43.0


