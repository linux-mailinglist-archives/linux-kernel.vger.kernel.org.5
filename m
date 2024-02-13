Return-Path: <linux-kernel+bounces-62623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FB8523C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4631F21525
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427658F5C;
	Tue, 13 Feb 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyWx/me/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772DD5BACD;
	Tue, 13 Feb 2024 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783607; cv=none; b=G2azKAqHKF7we+/SQ42rHxL3c0BTV2I4IIfqKZX0sLfcOeltYfJbOoZ7dsccGik9nex4Q0yl8qeEOH3yuOAyZJdTVJr3B4c0lSPRZFKJBhqQeGlYHkeG6jTe3s5q6XmpjjZaE+k0UDquK3aHf7siA1tDLTBKw2T4ssVFKyseuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783607; c=relaxed/simple;
	bh=kLI/Z3BGIWtXmA/Hsv8uVgRvEViq3fIcRKy5hUTBHFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2s7215QbepUwfEkSBOOeDtAEEc6gTMFoTdBS6+49edQux2w+qu5NGMOOte24VxZIWsKO5AW7z2BLkHHemYAnjV2FElIGYWvnAqkKKvij4qY5pLTdY6qLhfrKxlowOvFA6a++fwbsnbKKSpX5q8uSzrFYgStKfU/OMbj434GPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyWx/me/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38750C43394;
	Tue, 13 Feb 2024 00:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783606;
	bh=kLI/Z3BGIWtXmA/Hsv8uVgRvEViq3fIcRKy5hUTBHFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyWx/me/wKaf8oCx/wh1cRinjlOMQbRG5f4yVcYAuM0fZddW/ZlIQGejFK4bibnBc
	 mjf2eczeaVOKe94VYLDK4iGLeyCSLH9T9L8HmlWus/ouP4rVcO0+sfpnKiSowqg6vA
	 1CCIU3iYMnfZpe45BB347CX1vm+G6fgTw2cCwOV3uYSDNFXPDw5cppnrUjpZP42iFI
	 QrBsFTAkdM1ZHYSSiN7xyZjLRKcQMyrcyrq4B/kXpQmiijUuYG0vCxACYu+c6aB6u2
	 cQLFlWlKdhwI1KhX4r5IvyS++M4PyuvYCi9mkHx22Up7S00+s3uvFiY/2V9+Qskn1m
	 RUhLY0woyvqzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	le.ma@amd.com,
	andrealmeid@igalia.com,
	maarten.lankhorst@linux.intel.com,
	srinivasan.shanmugam@amd.com,
	James.Zhu@amd.com,
	aurabindo.pillai@amd.com,
	Jiadong.Zhu@amd.com,
	jesse.zhang@amd.com,
	guchun.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 50/58] drm/amdgpu: skip to program GFXDEC registers for suspend abort
Date: Mon, 12 Feb 2024 19:17:56 -0500
Message-ID: <20240213001837.668862-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 93bafa32a6918154aa0caf9f66679a32c2431357 ]

In the suspend abort cases, the gfx power rail doesn't turn off so
some GFXDEC registers/CSB can't reset to default value and at this
moment reinitialize GFXDEC/CSB will result in an unexpected error.
So let skip those program sequence for the suspend abort case.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 50f57d4dfd8f..be12ed96eb96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1041,6 +1041,8 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	/* indicate amdgpu suspension status */
+	bool				suspend_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a7ad77ed09ca..10c4a8cfa18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2449,6 +2449,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2463,6 +2464,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 69c500910746..3bc6943365a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3034,6 +3034,14 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	gfx_v9_0_cp_gfx_enable(adev, true);
 
+	/* Now only limit the quirk on the APU gfx9 series and already
+	 * confirmed that the APU gfx10/gfx11 needn't such update.
+	 */
+	if (adev->flags & AMD_IS_APU &&
+			adev->in_s3 && !adev->suspend_complete) {
+		DRM_INFO(" Will skip the CSB packet resubmit\n");
+		return 0;
+	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-- 
2.43.0


