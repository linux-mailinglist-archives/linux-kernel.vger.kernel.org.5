Return-Path: <linux-kernel+bounces-121176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5488E327
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F9E1F217EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5B13E6D4;
	Wed, 27 Mar 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onk8m2i2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3917D254;
	Wed, 27 Mar 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542278; cv=none; b=pqUGGYS31LpqW8T0zLvbg4NT1JjEBIrgJ+wHdtfOTAP9Iznx1vGJFmPBaO6Uy5Cs5N2uT0zD8ofI9HZxk/Q+lAWXqtovkSrbE3Jmkn92KpepWuPincgRbCDYyu6VrkmzmsKKaFTwu5hY61/92zF/R3piTnpx9vkY5UjvGKHekCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542278; c=relaxed/simple;
	bh=XaSPV+5pouUPw9O5X70X00PpD2subqUAH+hDMk77jgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvQtG9tmb71G0TeSRXqMXAVCHiUmJ00GrqU0H3Y4rF3K/LSFZUFLoYvkpMnQOUXX7tnH8/0Ckn4esJsx5U2YSBZRSPmiq8zgdQfkmHVCCbepIOledQWwqpiyVYuITfkrIRl/4Df5Gu6FMWWOdvGL7MH22R2hFSh95dwkoBUkf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onk8m2i2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FE3C433F1;
	Wed, 27 Mar 2024 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542278;
	bh=XaSPV+5pouUPw9O5X70X00PpD2subqUAH+hDMk77jgg=;
	h=From:To:Cc:Subject:Date:From;
	b=onk8m2i2LZxfB6xNxpq3VPzEKnvsJEBN7uGyWCa0wKgwJmunUpdWcI5LlMwzmcKTy
	 9/Nuo3ap4AvJB/3NNn0QOwwVY3EIHjJPhWyzb0aistX6XYuqvJYUh73WbvkVxKEGKx
	 9lL2v4Ke0BgwGlVYAoQ9kX14eYf9NJ/VATjr2uhEgDPRc65DGSGO/wkd3eWhzv1ly8
	 +5Z3OXDz7xWUB34RSstlqO4odSQg5RqIObzkv9VE3L/gvXBBaMDYXrBBJCIWYX0mnX
	 m2MnIh3PzY1AnxPCQ8UZtcnDf7glIoNR16lQpooQVi3KPXNUUQvpHemV3JkChdm+y8
	 BPQRWL0YltUig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Philip.Yang@amd.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:36 -0400
Message-ID: <20240327122436.2839540-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





