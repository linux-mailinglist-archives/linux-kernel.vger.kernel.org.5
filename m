Return-Path: <linux-kernel+bounces-136618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07F89D636
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2531F21860
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE808175E;
	Tue,  9 Apr 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZRrq0sSa"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A98060B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657084; cv=none; b=k1IcwzUuUoSQj9p+bLGuvlXuizWG9XQGACSYPrRqq4NodnLKG2pV2WYXKmhCZ1kn7LYtxYSaWkdLAh5XXPQImj07HS+J12gcKrrdH/8SK0Kt9kn8zQI0p2GfAVHy/c/FWbk5sV7sb8ZdnVIMXu3L6TtfcH0bt+pCmtQydwuDik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657084; c=relaxed/simple;
	bh=p9nxB4AmLrlY4zWIcrP/uy/FSacfcNG8RxwAEAEEXDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqTZtpMlknEfbGk6R+XpQPKMvIA/bqyJaaHK1gUTECfo3tK7o8zG3u+/ByKgChe2dLcbsLHQdpNsMwhtdPS1qniaLAb+SbyVCSJvyYaEJcD+k9IqYUpbYxco5p6o1Va+zjitE7kGb5AQiJVwzdHgaZX72KgXSZHRiG/NKL9t+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZRrq0sSa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD693C0008;
	Tue,  9 Apr 2024 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712657080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmoK2saX48Z7BaAk8XIAqhHfqZyQB83Bo3eVwyIjC00=;
	b=ZRrq0sSas7zBBUrm6THO4/o98Kj6Gv2TR+QnfXpJTXGYUWcrMouQNkQtPKPxwIzTPMagpG
	HMgSs9dF5X2LWM1PuPA2YsPAtEnBZ+mieM6h6lMYRJc3fWiyUzgDPLibijEZ6LUlFIC1FI
	Rafq5ztB80pWPA9g4UPYXnaYJwMsKfz/3d5XychhhgyDVKh95nGibDpxDhaO67sG8Efm3R
	DdelqAoryNQG0W5MXAn35vwseu7pUMmHOJGjeA+vkGVgX3K1n0ITBltJfC+vSw5vdQFjKD
	Zwg79FZUS4oNGivgLrc2H6eacSFzIItmQ0iZCxONp1AhJTRUNlyvPJ0Z4vDY5w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 12:04:06 +0200
Subject: [PATCH 2/3] drm: drm_blend.c: Improve
 drm_plane_create_rotation_property kernel doc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-google-drm-doc-v1-2-033d55cc8250@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2944;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=p9nxB4AmLrlY4zWIcrP/uy/FSacfcNG8RxwAEAEEXDI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFRK1GE/Zfoq0FQBmC5eluz1pdZw5EyewevzkT
 8ImCpzVqgmJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhUStQAKCRAgrS7GWxAs
 4i6JD/4yVdG5z/8ZTrn1U4lG/4s67XBOGXJgD80d/hDeXG1bt7N01LbtWsJ8vnory9361X7Mz7S
 iiPZ7kqzQMOv40mTNt6FUUWTuGT4qAaLPGWEbiJCAt15ppISdB+dey28Lealqv3PfGYcBrIM8Fv
 OgrJILVs3WCiYKWz1DmzTEVfZv6C6fkbqSYqoe9Cx0/Hyhrmk09CBBZgNldQ1W6sabfesMvlMbz
 bo7ZMJA3ej/XZxnksHu0ykTg57iwl9ddUtQE3OZ5gv9sfCfvKfGDj4tUL+/Yx4K05rcU7kfnP/g
 P98hTuIJqS6g7758fJweQzXhzAa2vKvl5A96V49VwRQG1Zt4cxJHlFCquTct48/XKi3nirl8Xss
 SCxCzOUePtI9Sn+j89pBjjXwL5QEV7VJMt7zTJr1DBMn8rUx9XaQw9Gc6tWAFsoKlKJyCb9hDff
 Xzv77Nkld/hUvny38BL+aqeQnfoD+kIlSbsdH8EXfHPL/tGqtT8fSdDwuUQqsIuY/RAqwmqYZMt
 ZzVPWQd0StIm4nIuE52f3g68L86eG9eOsW8x3l4hNqbDhY2he9198/8B9t7VkWjK8YhrGE5b7CA
 xQGzpPRJX12xTPCcPcTCO1U9lp2Jk+hFKAgJjsAh99jGe6L1N1bcmcn7b0mZ+j9Nebe0YIKOKA1
 M/9rVWEgL5U7hjA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The expected behavior of the rotation property was not very clear. Add
more examples to explain what is the expected result.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_blend.c | 52 +++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 8d4b317eb9d7..6fbb8730d8b0 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -104,6 +104,9 @@
  *	Without this property the rectangle is only scaled, but not rotated or
  *	reflected.
  *
+ *	See drm_plane_create_rotation_property() for details about the expected rotation and
+ *	reflection behavior.
+ *
  *	Possbile values:
  *
  *	"rotate-<degrees>":
@@ -114,18 +117,6 @@
  *		Signals that the contents of a drm plane is reflected along the
  *		<axis> axis, in the same way as mirroring.
  *
- *	reflect-x::
- *
- *			|o |    | o|
- *			|  | -> |  |
- *			| v|    |v |
- *
- *	reflect-y::
- *
- *			|o |    | ^|
- *			|  | -> |  |
- *			| v|    |o |
- *
  * zpos:
  *	Z position is set up with drm_plane_create_zpos_immutable_property() and
  *	drm_plane_create_zpos_property(). It controls the visibility of overlapping
@@ -266,8 +257,41 @@ EXPORT_SYMBOL(drm_plane_create_alpha_property);
  *
  * Rotation is the specified amount in degrees in counter clockwise direction,
  * the X and Y axis are within the source rectangle, i.e.  the X/Y axis before
- * rotation. After reflection, the rotation is applied to the image sampled from
- * the source rectangle, before scaling it to fit the destination rectangle.
+ * rotation.
+ *
+ * Here are some examples of rotation and reflections:
+ *
+ * |o  +|  REFLECT_X  |+  o|
+ * |    |  ========>  |    |
+ * |    |             |    |
+ *
+ * |o   |  REFLECT_Y  |+   |
+ * |    |  ========>  |    |
+ * |+   |             |o   |
+ *
+ * |o  +|  ROTATE_90  |+   |
+ * |    |  ========>  |    |
+ * |    |             |o   |
+ *
+ * |o   |  ROTATE_180 |   +|
+ * |    |  ========>  |    |
+ * |+   |             |   o|
+ *
+ * |o   |  ROTATE_270 |+  o|
+ * |    |  ========>  |    |
+ * |+   |             |    |
+ *
+ * Rotation and reflection can be combined to handle more situations. In this condition, the
+ * reflection is applied first and the rotation in second.
+ *
+ * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X is:
+ *
+ * |o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
+ * |    |  ========>  |    |  ========>  |    |
+ * |    |             |    |             |+   |
+ *
+ * It is not possible to pass multiple rotation at the same time. (i.e ROTATE_90 | ROTATE_180 is
+ * not the same as ROTATE_270 and is not accepted).
  */
 int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,

-- 
2.43.0


