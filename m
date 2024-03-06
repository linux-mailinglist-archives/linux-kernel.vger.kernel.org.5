Return-Path: <linux-kernel+bounces-94527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A837874113
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE215B214F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BA14374A;
	Wed,  6 Mar 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="RlVxsnWt"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7A14262C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755438; cv=none; b=Y2TTmrzlOt/VmNxiIiddXyJPoIuy9gWY/dRddUF+PJIWc+IwXermYbLl+wxOBnA9qL4NPK+n1GHUwiiRuW3trbhq2tsccKIzfBNNL8yGgZTp2oVx6ed92unnJ4yj71jJiqnsAAzXsB8+0X7JfGeAzEJmZhWrAQ6YyZINDLCh/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755438; c=relaxed/simple;
	bh=lxw3QxFzZobejKxKEX8+mofg4ioooTepWHtlSjpH3R0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRZHySB0f54lo2DJxn+HOuQzEE9NMkMIvVbc9bOs3KCCFb8H4+B5O/iC/PRvShOMxpGi0iqRtFAPogVvenSED2SiVQBQ37oP7oqHVyFxRPIZoWUg+W85PfFEhjFTFIgLwgrZRZ4IaZ9RZ5Ud7UpU7OzKCRJWYfD7XRK9W2A7Yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=RlVxsnWt; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Tqk0D1269zDqnY;
	Wed,  6 Mar 2024 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709755436; bh=lxw3QxFzZobejKxKEX8+mofg4ioooTepWHtlSjpH3R0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RlVxsnWte279ebXZibAtjR9pOGDVso/R7VgRzLkblD8VIL4niqiIjxvrqbEunxvGz
	 sLWW0OIMdaMezuRqUcq3fB9BzUzLMXmZRzTIKTKJsihbp+NMW4ks27kZgeaOlPmaIS
	 nkoLmtePaKtThw/RhDILptqtomD8EPXZW80muxV8=
X-Riseup-User-ID: 4C9406F16155A317FE8B2D2AC996CC510B513A647C5017F16AE00E0AAB1FE21C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Tqk065SYfzFvr9;
	Wed,  6 Mar 2024 20:03:50 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 06 Mar 2024 17:03:12 -0300
Subject: [PATCH 5/7] drm/vkms: Add comments to format tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-louis-vkms-conv-v1-5-5bfe7d129fdd@riseup.net>
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
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 67 +++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index 3522ecee960f..66cdd83c3d25 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -24,7 +24,24 @@ struct yuv_u8_to_argb_u16_case {
 	} colors[TEST_BUFF_SIZE];
 };
 
+/*
+ * The YUV color representation were acquired via the colour python framework.
+ * Below are the function calls used for generating each case.
+ *
+ * for more information got to the docs:
+ * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr.html
+ */
 static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
 	{
 		.encoding = DRM_COLOR_YCBCR_BT601,
 		.range = DRM_COLOR_YCBCR_FULL_RANGE,
@@ -38,6 +55,16 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 			{"blue",  {0x1d, 0xff, 0x6b}, {0xffff, 0x0000, 0x0000, 0xffff}},
 		},
 	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
 	{
 		.encoding = DRM_COLOR_YCBCR_BT601,
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
@@ -51,6 +78,16 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 			{"blue",  {0x29, 0xf0, 0x6e}, {0xffff, 0x0000, 0x0000, 0xffff}},
 		},
 	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
 	{
 		.encoding = DRM_COLOR_YCBCR_BT709,
 		.range = DRM_COLOR_YCBCR_FULL_RANGE,
@@ -64,6 +101,16 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 			{"blue",  {0x12, 0xff, 0x74}, {0xffff, 0x0000, 0x0000, 0xffff}},
 		},
 	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                     in_bits = 16,
+	 *                     int_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
 	{
 		.encoding = DRM_COLOR_YCBCR_BT709,
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
@@ -77,6 +124,16 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 			{"blue",  {0x20, 0xf0, 0x76}, {0xffff, 0x0000, 0x0000, 0xffff}},
 		},
 	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
 	{
 		.encoding = DRM_COLOR_YCBCR_BT2020,
 		.range = DRM_COLOR_YCBCR_FULL_RANGE,
@@ -90,6 +147,16 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 			{"blue",  {0x0f, 0xff, 0x76}, {0xffff, 0x0000, 0x0000, 0xffff}},
 		},
 	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
 	{
 		.encoding = DRM_COLOR_YCBCR_BT2020,
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,

-- 
2.43.0


