Return-Path: <linux-kernel+bounces-121269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D788E71D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AE5B32A04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563331B6FDE;
	Wed, 27 Mar 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suqu1WNr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F11B6FD5;
	Wed, 27 Mar 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542512; cv=none; b=GcZ9+hS0S0Wjq46QtSo+ONCBZSjU/Jbr5i0gZjKBPP2E5VXSlLUnvuSZpuDY6ByrjGq6X7cUrjRuATcTfSK+LixjGo8ze45kFEh0nQ3zbUNDTSsXG3/iIpnjngRD1DbZFzHrRR5WW1fNl+vqftdqD2G/aXYhCYhl6RG0xFZd7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542512; c=relaxed/simple;
	bh=YWBrmyrOQ8PxEBOzvBTJCbGd3f9JLChempXE4mAhhSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cobglwbw5xCLod5pxklKS30R6E2SgyBeTK2/RJn+hSII/a6I3HkbsIZz1F1Me7vvyaph+a6jv6QiLnS4V6L+bSo96llRThTtyJZZfhsrTUzO2WDXMbHpm2I+ykM11PnMkyWuUISlJl/Y/Z+Ma3YukLm48T6awHGz8lEDU0EpdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suqu1WNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443FDC433C7;
	Wed, 27 Mar 2024 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542512;
	bh=YWBrmyrOQ8PxEBOzvBTJCbGd3f9JLChempXE4mAhhSw=;
	h=From:To:Cc:Subject:Date:From;
	b=suqu1WNrZjpEpTyVYtCJjsnpPIKhgSXjLAEJKsl/p4mDXAHj/qeLlXNJBMIMvAbrd
	 rW+ZMLLOBwGR4HD1k+x7XwoBLB5Sph4MBuU3rwu2Uxh+vwjNcy6nYkz1lrwHNxFvtq
	 pGFjJxwCC7XGlo+9QZu6ly1lRa6xGO2vOUnu0owmGCLcqdHwjhck8xZjcrxTWE/XPH
	 qRaLqYRrN72m2N9K9mhQqT6j/k2tsT4acby9wmUt9SrQJeMei71KF9qrJW2wuaP5Vf
	 tEW9rHm8bNCXzEHdIociOpx+63DFvFvWVNeHylu3Lg0OGnUExUIEEOldXY7K5cpZZq
	 OAaZxZWavrcqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Philip.Yang@amd.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:30 -0400
Message-ID: <20240327122830.2842794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6c6064cbe58b43533e3451ad6a8ba9736c109ac3 Mon Sep 17 00:00:00 2001
From: Philip Yang <Philip.Yang@amd.com>
Date: Mon, 11 Mar 2024 18:07:34 -0400
Subject: [PATCH] drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Otherwise after the GTT bo is released, the GTT and gart space is freed
but amdgpu_ttm_backend_unbind will not clear the gart page table entry
and leave valid mapping entry pointing to the stale system page. Then
if GPU access the gart address mistakely, it will read undefined value
instead page fault, harder to debug and reproduce the real issue.

Cc: stable@vger.kernel.org
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8722beba494e5..fc418e670fdae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -864,6 +864,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
 				 gtt->ttm.dma_address, flags);
 	}
+	gtt->bound = true;
 }
 
 /*
-- 
2.43.0





