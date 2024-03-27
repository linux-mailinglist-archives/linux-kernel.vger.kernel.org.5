Return-Path: <linux-kernel+bounces-121118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0688E289
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E671C2AD33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB2172BA9;
	Wed, 27 Mar 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTvcmOi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF05172BA3;
	Wed, 27 Mar 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542127; cv=none; b=SbeLkdsj6rqDEX2Y61H1Ognpkhbz4hX6XvdTWlOcmTv8Agk6sr/5P/w6I6aH1aYOEYrScNvfYnsCzuPcHPjOgfmRclHAKTw+V9ExjHUsScfJGc8Gg3NaK3X4MEDz6+8R0jc3xreI7Uj13lx4RCww/2BnE3Reu0V4KkTL1mDoEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542127; c=relaxed/simple;
	bh=iZJoDteXGgqMvgg0euaJhMX16eRg+rod8E+p5Tg4tCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwUYyTGeX+7eHLBtbOrjwA6cDfOEh4zH8nTOVMyItgAxf/B2vNaTH+VtPakDsTb0/viqOaMQZWKG6cqhsyGek8YFBNjjOP/uh0xkqXo5mpkVvlmn4gmmW2O67UvPYIBD+9Z/445DwbGpe/+gPG8djbiMSjyNfTnuowIAu0TNPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTvcmOi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164A4C433F1;
	Wed, 27 Mar 2024 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542126;
	bh=iZJoDteXGgqMvgg0euaJhMX16eRg+rod8E+p5Tg4tCA=;
	h=From:To:Cc:Subject:Date:From;
	b=PTvcmOi3CKre58XRiqYoIoEN5/tnuRMavUzsTxfyfTTmw8Xer750gHUC+StebJvv1
	 eR/k/lucgcnfOreEhX3IImQ6WTdRRoF3EQm0CPXGAXKyt6wjqFZOAKv0ymvS82nD4X
	 WCXmPkedMAWnT7kD7778m9akCnp7TOq+AQjRESVK9g8RrNSrLnVV02X3R+3AwUblib
	 duCJCyKRYjAokuL90wTzztwHhtPAQ5CGRX01k7q+LmAXJjSaAWeCaQR6YiLXJPMxmE
	 RH20Ep4/fIK4frZVqRMEQEgkLkWlG4PRR6TZl2OTFqO2uIs5Ww9lWyVO+WgOA5ovF7
	 CuyNcRs/wLd1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.deucher@amd.com
Cc: Feifei Xu <Feifei.Xu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:04 -0400
Message-ID: <20240327122205.2837409-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





