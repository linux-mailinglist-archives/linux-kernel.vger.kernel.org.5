Return-Path: <linux-kernel+bounces-120792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909B88DD72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F4F290498
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610C12F5AB;
	Wed, 27 Mar 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlhbx/M9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7912F59B;
	Wed, 27 Mar 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541215; cv=none; b=JdTCK+1P9BfwiMLco20mDvYVX69vbXgHD0REEwDf540MpqVSu+Qgc89BsQMeaz34xSYG4vWBwq5l335vTtvmzydt9Z3UHE/+DiUCAOKDVeN2TCkPxq+Qrsb3ujN+MpQSxrKZublugnDece99P/N9rXIRJT5u4FEVPiZt49bix9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541215; c=relaxed/simple;
	bh=+J7ERlUOqwzi8/rVnchw03P5BC09HJILEOn2wX+hlzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVAb1cC8zTxDUJdthYSTimeg2DiO8N+gINdykW9HEZ9ayepxBH/CdqPS2i1qGqoaPg1XQNWbq7zn3thHw9euz20wj4RvUVMA7f/kF6rsC99v69g9Z3/Hph1ZlSbGXhp5fi/+KcNJ6cLzzWtt6Yehn6LrfnpPgqDjT6fJKw64rVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlhbx/M9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8205FC43390;
	Wed, 27 Mar 2024 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541215;
	bh=+J7ERlUOqwzi8/rVnchw03P5BC09HJILEOn2wX+hlzc=;
	h=From:To:Cc:Subject:Date:From;
	b=hlhbx/M9AVnSW+gQHForzSHGIEoK+QxP1Me/6Bo5HK6saz9NgaXJxxsIF2f+FUwZO
	 NNsniJjlY8Z/AT/ULn6rv6QX8w0TCNv9Vj0DPRs/HOBijQYxVOcuSftvmY2LEwalfV
	 Oeav1fTmuUzRVRLjMcoHcnvct65/juDoxLIkFE7qqxAzCSYShmudIYkdcdFP9JiLIV
	 A5XA5Jjj8m0ybY31bgafg8SCspTOP54JPE40BpLz6HzSkxjPmKlwewjbjQP6bCQpu3
	 KZ17cPyM1bfWjiSYfAch5M682FF6dQ+ZAFmocaFsETSrMm9sZEEvuxjm4A6yk7l+4h
	 c4pzq/3/xITCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	corngood@gmail.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd: Don't init MEC2 firmware when it fails to load" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:06:53 -0400
Message-ID: <20240327120653.2824861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c3ec8c4f9a470c026066ac7b2e4bac898bc7ff02 Mon Sep 17 00:00:00 2001
From: David McFarland <corngood@gmail.com>
Date: Mon, 29 Jan 2024 18:18:22 -0400
Subject: [PATCH] drm/amd: Don't init MEC2 firmware when it fails to load

The same calls are made directly above, but conditional on the firmware
loading and validating successfully.

Cc: stable@vger.kernel.org
Fixes: 9931b67690cf ("drm/amd: Load GFX10 microcode during early_init")
Signed-off-by: David McFarland <corngood@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index be4d5c1e826f3..b02d63328f1cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4027,8 +4027,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		err = 0;
 		adev->gfx.mec2_fw = NULL;
 	}
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 
 	gfx_v10_0_check_fw_write_wait(adev);
 out:
-- 
2.43.0





