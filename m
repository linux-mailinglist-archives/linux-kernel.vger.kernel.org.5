Return-Path: <linux-kernel+bounces-120953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3688E0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF24AB2A05F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F514F9CF;
	Wed, 27 Mar 2024 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIYF3NKG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A11514EC;
	Wed, 27 Mar 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541681; cv=none; b=UEt4VDR6/FxHOixqvMM/fqa9RfBZ+ATE2Q1fYHTNbcAD08TQLJsecI9DJX6TYoSsNjqbIwInd4boj2ASMTgXs0dShxyUi2Grjh3nSW3Tb8LX5NZNroDNXZ68ZVNhTukUl0FETrG64q055U82tVZ8/0jKDHn/EF8Qh9/6cjxgmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541681; c=relaxed/simple;
	bh=vHDl6XVP2KbDnmhBKDFO/+2APEFrhTrEdIFfdgptccU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rdv7zZYE1m24xj082nRq+bRTltRFw6XwCkBI2HIk9NMYkUv1nEJ5vOXItCj622D/SdBnKvttxzrx0riGwvZ0HhF9wrjAjZoUyjWxBFG+yOAZedRHfEfIKB5iKTECMaqwF4NfvQfmyDvdAKOH/UOCT6q4EoSUoWAcHH3I/byOA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIYF3NKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D40C43390;
	Wed, 27 Mar 2024 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541681;
	bh=vHDl6XVP2KbDnmhBKDFO/+2APEFrhTrEdIFfdgptccU=;
	h=From:To:Cc:Subject:Date:From;
	b=UIYF3NKGHqADRfZqjLZZg0pgVZxsbz8f8+RoG4yWD7bvLxt4GTMboDnkhWLxqn4Gi
	 xQIjFIGwmGX6D1uV19CT0SyhM04zYzuw3zOlMon1nwzfGagvaYbBButFuQUvQsBbFT
	 /sxTmyaTqom0+dW+bjlODB34FiT5QZo8wOSOblT1aOZjohedb3nOCHEhxzOQrbdkZ3
	 RD1XH73KOQkZWbRtGfYUq4mfxFXA32mNWOhVIs9NZr+Qu0Vt3ltS8X3397cfwflZV8
	 KvMCNz4Suj+25NBMTFx3p+45SsEZhCClaCaqDkqcXFSXi/wSoYtPEQ7oAe+6RXgCh3
	 u78hnERw3yIKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.deucher@amd.com
Cc: Feifei Xu <Feifei.Xu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:14:39 -0400
Message-ID: <20240327121439.2831264-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fc8f5a29d4cf0979ac4019282c3ca5cb246969f9 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Fri, 19 Jan 2024 12:32:59 -0500
Subject: [PATCH] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0. This can lead to hangs in some mixed
graphics and compute workloads. Updated firmware is also
required for AQL.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 043eff309100f..c1e0000107608 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3846,7 +3846,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 15277f1d5cf0a..d722cbd317834 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -224,6 +224,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
-- 
2.43.0





