Return-Path: <linux-kernel+bounces-33306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3616836830
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CC11F25D53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5507A4652E;
	Mon, 22 Jan 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxR8+NUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C8246522;
	Mon, 22 Jan 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935739; cv=none; b=gXeeNILP/Af5dO67yOdxQjR6xwNwXrRbtJxWkcpHLSQ9Rzf7DWB0n42y/K+ZdcJ7rDV42909/VytHyT/hGRCM02Svp1JDyzC8DWm3wxXakoUkKBuiB1VflW9MQfXiI1/vRUSpB4rj1mpiR1AWaWYvGwpJ4WgHdMXdxNeww5zWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935739; c=relaxed/simple;
	bh=9hdCOZDVM1e55sPqaXfj1cjoms03INlYhbcem3byNFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOoM4aBYp+KNolnSI5xzYLcSc6iZ/leNyx1p7N86MwVa5AZfL9+Fpg9Yb3hf0qFXgsqWjzwKSUdK2P8pb0PyAyMvtMzNcVQD9ekp+C8sJAP6fS2t1FLwiB3F+ji+wwQ2CLxI2ovnaQLCd6JCFlvUUyQhD/67iD3okmyRRdwe0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxR8+NUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCFDC433C7;
	Mon, 22 Jan 2024 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935739;
	bh=9hdCOZDVM1e55sPqaXfj1cjoms03INlYhbcem3byNFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxR8+NUmpxIktzQjPPn/oz7e77n2MiTj0CxQXH3KxOjXAbAP+2ucp6CiFIfA9qRjN
	 Mq6+j9i6yMap3T1upcVcW5ZrPn36dK3uvE7D8XtfnXFDPpOXPTxVeDvkSKCpe5pcny
	 lcp1wU65bkyvVKn6tP9bDOvLYDSdvLr9CONz+I0o+Rr9EH6IshPn9jvpsgsiaaoUwL
	 E6udYpu2wHd2QnlZ1PADRDmyTY1oDne8Zli+yGxOUSXuhIWfKzye4UgFbXdDkgf2qg
	 Xgf9gJ3iJt/GfPalWZNu67AIioPRi1w7ZcJzw2fY6qJUgm31LnLvYHxnoxLS+AI0Mi
	 jsf0WZQ3j9xKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Jiadong Zhu <Jiadong.Zhu@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	Hawking.Zhang@amd.com,
	yifan1.zhang@amd.com,
	srinivasan.shanmugam@amd.com,
	le.ma@amd.com,
	lijo.lazar@amd.com,
	victorchengchi.lu@amd.com,
	lang.yu@amd.com,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	Qingqing.Zhuo@amd.com,
	wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 84/88] drm/amdgpu: apply the RV2 system aperture fix to RN/CZN as well
Date: Mon, 22 Jan 2024 09:51:57 -0500
Message-ID: <20240122145608.990137-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 16783d8ef08448815e149e40c82fc1e1fc41ddbf ]

These chips needs the same fix.  This was previously not seen
on then since the AGP aperture expanded the system aperture,
but this showed up again when AGP was disabled.

Reviewed-and-tested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c          | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c          | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c           | 4 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 53a2ba5fcf4b..22175da0e16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -102,7 +102,9 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+				       AMD_APU_IS_RENOIR |
+				       AMD_APU_IS_GREEN_SARDINE))
 		       /*
 			* Raven2 has a HW issue that it is unable to use the
 			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 55423ff1bb49..95d06da544e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -139,7 +139,9 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 				min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-			if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+					       AMD_APU_IS_RENOIR |
+					       AMD_APU_IS_GREEN_SARDINE))
 			       /*
 				* Raven2 has a HW issue that it is unable to use the
 				* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 843219a91736..e3ddd22aa172 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -96,7 +96,9 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
-	if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+	if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+			       AMD_APU_IS_RENOIR |
+			       AMD_APU_IS_GREEN_SARDINE))
 		/*
 		 * Raven2 has a HW issue that it is unable to use the vram which
 		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cf32502d669f..2ec5705596bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1257,7 +1257,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	/* AGP aperture is disabled */
 	if (agp_bot > agp_top) {
 		logical_addr_low = adev->gmc.fb_start >> 18;
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+				       AMD_APU_IS_RENOIR |
+				       AMD_APU_IS_GREEN_SARDINE))
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
 			 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
@@ -1269,7 +1271,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 			logical_addr_high = adev->gmc.fb_end >> 18;
 	} else {
 		logical_addr_low = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+		if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+				       AMD_APU_IS_RENOIR |
+				       AMD_APU_IS_GREEN_SARDINE))
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
 			 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
-- 
2.43.0


