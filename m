Return-Path: <linux-kernel+bounces-61654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80888514FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D91F220DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1028751C23;
	Mon, 12 Feb 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXHlyP6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CD51027;
	Mon, 12 Feb 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743692; cv=none; b=PqSGOXuQqrsO34Ly1ts7zCz2q3WL/yttTLFAoN9XVqcjAEI5SYh39eN9DfZ6y1/9CoAtYrR+7z9o0jpfEgofJYDg+csa8O/Vu7CRSyNEdxNApDEgjiL2gslBt8Cd+0Y0130UiJ4UX1TzX+Geg92j6xMxY3WMC46BQ3j6SOyOz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743692; c=relaxed/simple;
	bh=/jfLw1y1aRl+eLhmrONAjpwWcjkjTwhnvsiFkp4DW20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggfR8XXv2EeBwc912xZ2SsFQkK26eiumVgpxErjQgK9Bh5JopsbgWusl8UG73ldq26p7pbVwtbUnRlZn3CTtb3hSQGdLAJXtZmnahkbuH2bMnmisCLGpJ5UoIxorR/PwCLDHf9GB/8X9UbJbOOex6cwqHP+dv5LFVeOXCLTZkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXHlyP6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54A8C433C7;
	Mon, 12 Feb 2024 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743692;
	bh=/jfLw1y1aRl+eLhmrONAjpwWcjkjTwhnvsiFkp4DW20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BXHlyP6XaRDeISyTRp+b2IWaAZj5i+v68Ngq1MsGQjJiiUf+Dwlutai62bvmtmjS0
	 A/sKFBAlMcYWRr5FxcrMgH6Ydt1Yi6EKiNTQ3INKTplt4yvdnbHz9+FTM0TU/UMRMs
	 UppNT9wi4qhls0W/QQt+yumMJ1R/MtXo1nlZatqIQPNapMAEsMdW4CQe7h8nGTmmkW
	 LUXHVENfzk7rgFYgpYIY8Jp8f9yVAiWUVBsYRIaLY4qnyU8xFvG+ZNvaofZmEY3l3U
	 xp4g77vylpajOWVmbMpUvByEDnIfbDf0VTAPfyJ23PBdgoo6dmbnjgG18hD9utUbjR
	 hw53s4wVlSEYQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:12 +0100
Subject: [PATCH v6 29/36] drm/vc4: tests: Remove vc4_dummy_plane structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-29-f4bcdc979e6f@kernel.org>
References: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
In-Reply-To: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/jfLw1y1aRl+eLhmrONAjpwWcjkjTwhnvsiFkp4DW20=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJAuMGE37rDsly7r3Jt+cb7X7pWzlFZ7bpuITZv/J0
 n/rsOp5RykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACbyLYzhf+FmdbM6zeCFMnzv
 Pj04OcVPIu4V27bNvEk76mZdv/RC1o2R4Wchu6fSpuJP9Us22rwI27wt/Nq3d4zBEu++phRszNv
 1mQUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The vc4_dummy_plane structure is an exact equivalent to vc4_plane, so we
don't need it.

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
@@ -109,16 +109,14 @@ static const struct vc4_mock_desc vc5_mock =
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
 
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.h b/drivers/gpu/drm/vc4/tests/vc4_mock.h
index 2d0b339bd9f3..002b6218960c 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.h
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.h
@@ -21,13 +21,8 @@ struct drm_crtc *vc4_find_crtc_for_encoder(struct kunit *test,
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
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
index 62b18f5f41db..973f5f929097 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
@@ -22,15 +22,12 @@ static const uint32_t vc4_dummy_plane_formats[] = {
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
@@ -38,10 +35,9 @@ struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
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
2.43.0


