Return-Path: <linux-kernel+bounces-119361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD088C7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB64321E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032D913CF94;
	Tue, 26 Mar 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBMoK6RM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A013D625;
	Tue, 26 Mar 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467637; cv=none; b=VTyd44mB6bkLaezrZYvkHfCM2RbLAqjbf+QhSBv2Z2nE++LeQsouctmKTLtsIJaWLE8eql6qUcBXLbcaX5AdFnWRqQDGL3pHKQKlJHZ9Iweqrh4nNB9ILGucgTHePnONEo/xmk0Nk219lkSxRJe/FI0WJKO7lLsMt3G9SYv+BrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467637; c=relaxed/simple;
	bh=SKkWaDyRJNnmKFGJ+c/iBRlTwh6T1Qu0u8sWad+h6/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9uHTNyUkFHVUWaHOFYe2NehZts33Snqbvw485uM/UApU9X7lb5D2CYVDBNPqUKsyzjCF2OouvT0s0JQqUW1eQ/jANxTNuV8bqUUHSbKVHL8U0XhkVf8ZPpHlUY1mi8H0FbmuMkML7gW11/y+GscMd9O1zFiMVBbyi3l/+dz6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBMoK6RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49490C433F1;
	Tue, 26 Mar 2024 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467636;
	bh=SKkWaDyRJNnmKFGJ+c/iBRlTwh6T1Qu0u8sWad+h6/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CBMoK6RMx6DSEaWX2vSEnWKycHWZga5NuQ+WgvbIuEqLl75kW5fnMQvjwo+OE5QVI
	 TufROT/ALBUR9XEw2o5BsQ4rCYbMKFK4LuxRwp3WulzFU3ZM4rWWXL8F/om9yL1Pg2
	 r/3asOECVjQ4Ts5o48UuTZOSmstQq7QGEAa0XZWZYk8TOKTdWUXNJkjCSugBqGqZs7
	 epffRHi/oeROqm6bqlHuXu5VMmPatsbj7TVTtUX5Elu/0T8Yul+GgSgEsZ1Mh8AaSJ
	 l4YUttprqD3D7w0oyneoEZP7oi1kTCeFSJ4x0ysN5edi3N/7c+i+5+7yqmwisWK+CT
	 c/1dv4F98P+0w==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:06 +0100
Subject: [PATCH v11 02/28] drm/mode_object: Export
 drm_mode_obj_find_prop_id for tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-2-c5680ffcf261@kernel.org>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
In-Reply-To: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SKkWaDyRJNnmKFGJ+c/iBRlTwh6T1Qu0u8sWad+h6/I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMb+Jf9vrF35txeseRw3v8RPWT7C+fOcj1yPjKMr0LV
 +oa9nOJdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJuO9hbJi39eCj1v6SUN2k
 Vad0a7bpheiGaV7qcLDo77PbJvti28SWi3PPh8pw2wQJnlrH8Kl4DmPDGW7RFdtEZqxa8UnR5qN
 M/1rmptDyq5cWmHR9fLSiZ7ailddni+11VtlpM53cFn+UYLsGAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We'll need to use drm_mode_obj_find_prop_id() for kunit tests to make
sure a given property has been properly created. Let's export it for
tests only.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 0e8355063eee..df4cc0e8e263 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -476,10 +476,11 @@ struct drm_property *drm_mode_obj_find_prop_id(struct drm_mode_object *obj,
 		if (obj->properties->properties[i]->base.id == prop_id)
 			return obj->properties->properties[i];
 
 	return NULL;
 }
+EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_mode_obj_find_prop_id);
 
 static int set_property_legacy(struct drm_mode_object *obj,
 			       struct drm_property *prop,
 			       uint64_t prop_value)
 {

-- 
2.44.0


