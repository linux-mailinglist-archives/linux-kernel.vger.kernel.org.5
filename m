Return-Path: <linux-kernel+bounces-62674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33285243F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B01C21855
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA411DFC7;
	Tue, 13 Feb 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIlj846i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEB657AF;
	Tue, 13 Feb 2024 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783724; cv=none; b=Mh8t4W6ldIbpRKV508JpaR7iExE8EfYFtRFogAOIlqCCV1xir0OvjuCmF2nhXMI/C+MOlocaJ8N8U3iIojsd+bA2XYHea9KzB2uK5QEGWQZjDjrsxSZd1f3DtjTMg3oaoynkvxWPG44JZeyQF34wCCO9xh+Ety78xHEItqGNSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783724; c=relaxed/simple;
	bh=EzAeGvEoADN7LMELb2zRS6/ytFyRzUvov75Db9/da/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQEGHJ7LnJscLrI3obFDhwT8PrTchNAdg4ZLc4M/Zu0EYubPd8M04pwRj0bC5NKgBXwrsKuQrtxH4+/2u8BoDXWpXYXA6UiIElX8FZO+IPFKBIRtJZFYH2zW2gCH1jUyFHHwxaNKn+Fay2d/f4pwqbcvedVeJxNF0sjVhUFtNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIlj846i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF03C433F1;
	Tue, 13 Feb 2024 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783724;
	bh=EzAeGvEoADN7LMELb2zRS6/ytFyRzUvov75Db9/da/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIlj846icCRAOnjhbAT7/MKEThXVb0eJ7OQ2xe2BCutTvFR/TUKcV6KAo7lqJxCeS
	 6qLEWYMWqNkhFef68MEtxNYWKpWbhZsE+3bHKldR0vMrzrd0peiE9rUEO8VK3AW2bj
	 sWe4Ree0tt10RZC8x4A7yl0RGjKnmixQBmz6dZHPw/UMev9O1V6rw+jhGyQ4mj/5Rv
	 uIScLSlc+s+5iWaN3bSoONWpLMkLxf1DkXIzz8q38eMwjL17/4ebwh5fe1zImalVFQ
	 Lv+2Qx5G921u3mF0bSOmrZjaEkvxveJ6mdsokq5WTg0B+fN13dfA9BjfmGLa9aC/zK
	 73jYZmG8QXSIQ==
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
Subject: [PATCH AUTOSEL 6.6 43/51] drm/amdgpu: skip to program GFXDEC registers for suspend abort
Date: Mon, 12 Feb 2024 19:20:20 -0500
Message-ID: <20240213002052.670571-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index a79d53bdbe13..85efd686e538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1009,6 +1009,8 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	/* indicate amdgpu suspension status */
+	bool				suspend_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2c35036e4ba2..3204c3a42f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2409,6 +2409,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2423,6 +2424,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2e23d08b45f4..d7d15b618c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3033,6 +3033,14 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 
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


