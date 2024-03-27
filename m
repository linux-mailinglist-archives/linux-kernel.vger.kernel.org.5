Return-Path: <linux-kernel+bounces-120888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885688E034
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5131C2927D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872812EBC3;
	Wed, 27 Mar 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG7gP21U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89790144D35;
	Wed, 27 Mar 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541497; cv=none; b=eHR6yRoBwKJgqlcdbp9RsuZlociqiCLU1WEaSCSdXwvatpcQyloFURhWmtOC/Oc2jhz/3iTz/RgzIj1RTJUqdrjeQ/RscVm/ZDUrjwVLzmCWQ/JaLpnotcUK6/o2YY0epDOHOwfErUr61sIcRhIXEpRI9R+xA3r9Frm8TvjrSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541497; c=relaxed/simple;
	bh=hM1oiJp2iiTIVco/dGFCdZULN+dVH3TXCdht6Ugz6eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsgHU+R1J30ri9bQg4ti1ay1Yb+RiGKzFXt8ZlDOm7AkbH+J5+ok9WCkyuuZ1Gqvw2jq8tlCrfxsxOdyQIduLGvv0tv+0RJxM2E+Gs3h3/iLzuImBrPFcXRYGAjbvtCSD0ZIX/U/F0bKsbptO5elie3ZONPcJnVDlL8Z4ZuicA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG7gP21U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A297CC433C7;
	Wed, 27 Mar 2024 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541497;
	bh=hM1oiJp2iiTIVco/dGFCdZULN+dVH3TXCdht6Ugz6eA=;
	h=From:To:Cc:Subject:Date:From;
	b=YG7gP21UbCK4KfqMfhblxbNbvum8g3eQkI8Md8i+yKlriC6CyW5xYCGP7CxMjDpOG
	 jApXaRQq1wX/kAQqgNBNmYHwojcxLpBFHgpwC0LgnELzaVDAZ+F4s4mkt0ZI5ljdAn
	 K8XY8b+VrKhAL2JPCoxMvX2DltEa1B+ESrTrP6V1j9OkJ8qbZAzyZy0xTD5carY7O/
	 EfBZkSiQlASIriZuOt2UjBQV+5emPezTRK4DjdDjRdTVvnium59YCC0IcLDkMPYtyd
	 Q2dx33AnjRr5LN3v9VOveCFvYMZ4DGWqvJya2svY4uN75sTvmmqA0tbrcZuTl3DgPG
	 slUpQaLVy/NTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.deucher@amd.com
Cc: Feifei Xu <Feifei.Xu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:11:35 -0400
Message-ID: <20240327121135.2828856-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





