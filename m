Return-Path: <linux-kernel+bounces-121039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0988E1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A98D1F2D11A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732815CD7E;
	Wed, 27 Mar 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVRBHoEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17F15CD68;
	Wed, 27 Mar 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541912; cv=none; b=HJOf12y+EQcnREWTdivEFFo4bvimdmcjIjsfs+RB7GKYUvJ+BQGoUoi5D+FYT18TeYsYERzytVYku5MEYvrmE8JUwPNupnp1Fjz0w70C1y2uWbS9ed2JXaMjjY1b2kzXkEXmInA7Sb+BcbOwMQHPiE6Sxzg+KNQ4iNlbhhyPHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541912; c=relaxed/simple;
	bh=iotXCXb1pZDh+CXdXoq1EbsxBK5U+ci7M33zpvM4Zds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0AgkNr9Ubu8dYAR0B2Mpx0kErEJMhlki5rBrJ46v26aGfuh6Hom5m9RY/rJdpaFFq+d5sX7EnePe4w/VD1+994ofpCq+cqj2UprdVJDSN0wtLWFw73hFGguiDbkmfaEL4+7jWv0T/P6thN75y22lHX306Ujtuc5tOx9XQ+kNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVRBHoEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B8C433F1;
	Wed, 27 Mar 2024 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541912;
	bh=iotXCXb1pZDh+CXdXoq1EbsxBK5U+ci7M33zpvM4Zds=;
	h=From:To:Cc:Subject:Date:From;
	b=aVRBHoEpvpyNqKVbnVqcHT+XB/I7CGoOKPNtpaBO/PO1zNNfbIxpxq/2sNDVXoJ/m
	 blvXiTxwup/+/1y+DmO65ISINwrR2d2K1I4v6axNh7UuNXDTdOudxogzsPyRsQb/UF
	 Zd4VzgGpsAN0U1QSfddKIw6aUUreI4ZA/FvRoWGYki8UFGD4QcqF54+VcE+fRJYQZt
	 c0vYpzeEhYC+SoYaAkvbAvMcNRx1LEf9FelvOfE4aWxd8RleMb9b92PPZjEKjZcDWz
	 FLmWIbwSF9PdcdAfaqJQaK+0Q6HJkgwjNie5JHAlcHGHruvMWLCKW83jJVcrrKXNjx
	 4Wq6ia46iJn2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.deucher@amd.com
Cc: Feifei Xu <Feifei.Xu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:30 -0400
Message-ID: <20240327121830.2834418-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca01082353d4c7c316cd8cfa53879970564a9c71 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Fri, 19 Jan 2024 12:23:55 -0500
Subject: [PATCH] drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0.  This can lead to hangs in some mixed
graphics and compute workloads.  Updated firmware is also
required for AQL.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 420c82b54650f..be4d5c1e826f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6589,7 +6589,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 8b7fed9135269..22cbfa1bdaddb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -170,6 +170,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
-- 
2.43.0





