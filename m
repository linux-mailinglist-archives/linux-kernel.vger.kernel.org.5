Return-Path: <linux-kernel+bounces-41749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1FA83F74C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BFD285DEF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB866B34;
	Sun, 28 Jan 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwXzjTTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8C66B25;
	Sun, 28 Jan 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458445; cv=none; b=upebztMDOuMnEYjtQk2mm5jN/20GajPwr5GP2L0Mn8JkwZJ5ZjWVwn3Es0shuwhLAgOLt2/nxcL1flbchREgkMrJIMwUgSqeq4DI4YCt3anGhK2Hl2nV9oeTs/fchFTTxWSyJGzqU9aha5Q+kdSAjfL9zUAs2EOqio3lj/s+JZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458445; c=relaxed/simple;
	bh=eshXjJ2KbJhZ73e5khc8Rpg/K4834h8pZv6O+OOTfP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEL11dE/IXAvJhMr4kLfb4kXaBJ4aw3LSPCpoY6X3gX9z3dBCR7TkDOIxYldICapJYgWj9ksEDJ5u6RV8wc5/OnVGLMgOTkbaBrXPdd3FzCVFsCw8RX7+sJRsd7PLrCuzFmOkz4J9PFRYbgkUw8tDjlLawt0vLFjKgMBBGWib04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwXzjTTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F412EC43390;
	Sun, 28 Jan 2024 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458445;
	bh=eshXjJ2KbJhZ73e5khc8Rpg/K4834h8pZv6O+OOTfP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwXzjTTMCKt6xLMtnQgeehAo2nz5WzhrLRd92X1XlMNa6BTRd9DFpbrtXpJvrAkOW
	 Aug1O7qFnd12UflyQ5VGWKUBSu0cmeHpEZf7WxDHOo8r7ZOggLJ7zA6D4h6Zc+Jblm
	 eBZS5mbBVL0aoLBbT063Zi83Xm1Rhi5bUo5Q4jPoeVyKL0VDBEiisyq63Po1frn5mc
	 4hLYttuLJgc5lcGdviCTlEk44LYIe0Eo4V6BAR8thB+/RPwq+0N7N3Gz+628nmltlp
	 om1UA4/Qzp5J6p8nE3JcyPpF0j+zcPdOsyjQK4IPH6cCV1JMKmm6nAdxp3j9fjt6VA
	 msorE4nYwuToA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Xiaojian Du <Xiaojian.Du@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	Felix.Kuehling@amd.com,
	tao.zhou1@amd.com,
	ikshwaku.chauhan@amd.com,
	mukul.joshi@amd.com,
	shiwu.zhang@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 28/31] drm/amdgpu: Fix with right return code '-EIO' in 'amdgpu_gmc_vram_checking()'
Date: Sun, 28 Jan 2024 11:12:58 -0500
Message-ID: <20240128161315.201999-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit fac4ebd79fed60e79cccafdad45a2bb8d3795044 ]

The amdgpu_gmc_vram_checking() function in emulation checks whether
all of the memory range of shared system memory could be accessed by
GPU, from this aspect, -EIO is returned for error scenarios.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'

Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d78bd9732543..bc0eda1a729c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,21 +876,28 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 	 * seconds, so here, we just pick up three parts for emulation.
 	 */
 	ret = memcmp(vram_ptr, cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
 	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
 	ret = memcmp(vram_ptr + size - 10, cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
+release_buffer:
 	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
 			&vram_ptr);
 
-	return 0;
+	return ret;
 }
 
 static ssize_t current_memory_partition_show(
-- 
2.43.0


