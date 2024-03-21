Return-Path: <linux-kernel+bounces-110246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F87885C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34FD281BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4812BF07;
	Thu, 21 Mar 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd0czSfR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611F12A141;
	Thu, 21 Mar 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035035; cv=none; b=jchtcCcQldmZ6PngXhuliFuFqdoeC45H5UOoAetNQ6efljE5LUTJkB0l7luiRPp/jFgdPejZ/6NM/uPU/ZrG7zTIIegyb257PNEpRt+3oZyRhKesgtgbe5LpqobrfB8L03Qr8E/vnyQl+ByglsEVRogrVVBho/fan60l3w2Wnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035035; c=relaxed/simple;
	bh=qqwR8snTsMUCSQhySgzRiBMtDFLDW3r/mg7D3AAdcrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrqn0BS/NG56zu48ZBQF7izWs2XfOZ2gL9tIb/Cljoemumc9tIrNoMC8xO6cExDJwr6FXAy5mUpke9X3otxqAtGXlN+KR/bj8CuJTo5hFx2D+XqRLdR1APfibKpCVR4rxstZ8SEAdv9nQDzzfQ2ksdb207pUEt0KVp7Ww2JzHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd0czSfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F9C433C7;
	Thu, 21 Mar 2024 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035035;
	bh=qqwR8snTsMUCSQhySgzRiBMtDFLDW3r/mg7D3AAdcrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kd0czSfRmi7MpwVOykQQ/eKq6+Px2rlFvRIQepXDz4+3F1iSk44AOePfw19Lv7g42
	 TeA7FnrV3VqFtvow6R3wwbd65GYzQ1sZhasIMJI65jEdvKgGxYD8N6Xmu87aRalq7g
	 7dJlLqUOjjIKhNJykCqmyKNMA4Z+eGMpvnNZ3xptz3Sny8s5gGSpDZRosf85+vEHnH
	 GekA6LHBmSa96afgty7y69nQgcpSLlCYr+3qZtLXBRFQVgHbexnIZBr5obBxNdwEhw
	 WdLeCyqh79CFeLcX4JEkDzRiciQiisDlpPPPclf4Hz2H9IiN8IdozU6dpcchIy57ez
	 +xRxBdwksXOsA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 21 Mar 2024 16:29:20 +0100
Subject: [PATCH v10 24/27] drm/vc4: tests: Remove vc4_dummy_plane structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240321-kms-hdmi-connector-state-v10-24-e6c178361898@kernel.org>
References: <20240321-kms-hdmi-connector-state-v10-0-e6c178361898@kernel.org>
In-Reply-To: <20240321-kms-hdmi-connector-state-v10-0-e6c178361898@kernel.org>
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
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3744; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qqwR8snTsMUCSQhySgzRiBMtDFLDW3r/mg7D3AAdcrw=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKl/ggIDRZ3935xu8fvm0Pp1/rw9HA6hb61t2m9Nsdz1d
 c1vo9/HO0pZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRDxIM/xO+VCaHrn50XqNH
 5/ytedmPhO61RT2XW2Ridqbe/KRFZiIjw4yMmWcbHiYLJ17R86maIbpszusPq+d8DZ4mc+Od/Bn
 /WAYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The vc4_dummy_plane structure was introduced as a mean to add
mock-specific fields.

However, we never really used it and it's still strictly equivalent to
vc4_plane (which is in the same situation vs drm_plane), so we can
simply remove the vc4_dummy_plane structure and make the mock code
cleaner.

Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_mock.c       |  6 ++----
 drivers/gpu/drm/vc4/tests/vc4_mock.h       |  9 ++-------
 drivers/gpu/drm/vc4/tests/vc4_mock_plane.c | 14 +++++---------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index becb3dbaa548..0731a7d85d7a 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -107,20 +107,18 @@ static const struct vc4_mock_desc vc5_mock =
 );
 
 static int __build_one_pipe(struct kunit *test, struct drm_device *drm,
 			    const struct vc4_mock_pipe_desc *pipe)
 {
-	struct vc4_dummy_plane *dummy_plane;
 	struct drm_plane *plane;
 	struct vc4_dummy_crtc *dummy_crtc;
 	struct drm_crtc *crtc;
 	unsigned int i;
 
-	dummy_plane = vc4_dummy_plane(test, drm, DRM_PLANE_TYPE_PRIMARY);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_plane);
+	plane = vc4_dummy_plane(test, drm, DRM_PLANE_TYPE_PRIMARY);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
 
-	plane = &dummy_plane->plane.base;
 	dummy_crtc = vc4_mock_pv(test, drm, plane, pipe->data);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_crtc);
 
 	crtc = &dummy_crtc->crtc.base;
 	for (i = 0; i < pipe->noutputs; i++) {
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.h b/drivers/gpu/drm/vc4/tests/vc4_mock.h
index 2d0b339bd9f3..002b6218960c 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.h
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.h
@@ -19,17 +19,12 @@ struct drm_crtc *vc4_find_crtc_for_encoder(struct kunit *test,
 			return crtc;
 
 	return NULL;
 }
 
-struct vc4_dummy_plane {
-	struct vc4_plane plane;
-};
-
-struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
-					struct drm_device *drm,
-					enum drm_plane_type type);
+struct drm_plane *vc4_dummy_plane(struct kunit *test, struct drm_device *drm,
+				  enum drm_plane_type type);
 
 struct vc4_dummy_crtc {
 	struct vc4_crtc crtc;
 };
 
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
index 62b18f5f41db..973f5f929097 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
@@ -20,28 +20,24 @@ static const struct drm_plane_funcs vc4_dummy_plane_funcs = {
 
 static const uint32_t vc4_dummy_plane_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
-struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
-					struct drm_device *drm,
-					enum drm_plane_type type)
+struct drm_plane *vc4_dummy_plane(struct kunit *test, struct drm_device *drm,
+				  enum drm_plane_type type)
 {
-	struct vc4_dummy_plane *dummy_plane;
 	struct drm_plane *plane;
 
-	dummy_plane = drmm_universal_plane_alloc(drm,
-						 struct vc4_dummy_plane, plane.base,
+	plane = __drmm_universal_plane_alloc(drm, sizeof(struct drm_plane), 0,
 						 0,
 						 &vc4_dummy_plane_funcs,
 						 vc4_dummy_plane_formats,
 						 ARRAY_SIZE(vc4_dummy_plane_formats),
 						 NULL,
 						 DRM_PLANE_TYPE_PRIMARY,
 						 NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
 
-	plane = &dummy_plane->plane.base;
 	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
 
-	return dummy_plane;
+	return plane;
 }

-- 
2.44.0


