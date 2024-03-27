Return-Path: <linux-kernel+bounces-121222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E313F88E41A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2065A1C2B38C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFB18B5F2;
	Wed, 27 Mar 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir8Cgzd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A518B5E5;
	Wed, 27 Mar 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542386; cv=none; b=KCR/VnW7SwJUHvMogBrDGMfarkgDAKVmp0juC8YbV9DSh2IdTMIaUpXZytye2MGgC4+nb3Dn/pEFuvOE1lt0UajCh3X7j5w3ixJdDPl5EWZGUU9Kng7ytfrcIgTAfkJHGKU8aORXQmsqV6DX3yZtwJ4HrYvH178epZHmb15Bi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542386; c=relaxed/simple;
	bh=PB4kk0Wp84kE12ut24gphFtfl2JguhysIcly5C9Zt4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSR8fvQNFv4wk86Fzr7NL31p65IQsOXOPQe1Xe2y9fcFYtyWZPJzgsU/tGLF/SScG27sLy2xnFLe0P+0JTtqLNg9MEI/CArbmF4rYMF8sKACVbsNbFff528cz8igp4kGPX7UzUQF6rz1hqmkBtKyOLDqLRliT5Yx5wFyuqTFir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir8Cgzd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27005C433F1;
	Wed, 27 Mar 2024 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542386;
	bh=PB4kk0Wp84kE12ut24gphFtfl2JguhysIcly5C9Zt4E=;
	h=From:To:Cc:Subject:Date:From;
	b=ir8Cgzd0GfhQw9fNLiKRJPgIoVcAaF9wTIKnVCdV4cNhhJsNq4l+9VM3blKMI0OEr
	 Yfw62p3/LVSGtoPUmiTcqIA/PlpEyh835OXccEEHny7dt2oh1Ta4iw1eeNzR5Di477
	 P1Pr8BgihnRF1Trgy/dARFaQkSUut1zK2B80VqDTxvH03SRPh2H+H8JVCWQqb37Hnh
	 qbOwk9prc/SqW2seGoFwps2hJV2cAdjmd8JJCif+l5oynbNpMMeWWOkOH6ZIPUmH/x
	 kcg1kWh3+5Zysk7tUjtdoD6G044ckmIuEr/pPr5X9+uaHmQI0wtxya2nKPSpJkjFhn
	 NAru1c0W24QHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	srinivasan.shanmugam@amd.com
Cc: Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests." failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:24 -0400
Message-ID: <20240327122624.2841074-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b2f26f49e84bea03dddb5f37ff137c97b165107b Mon Sep 17 00:00:00 2001
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Date: Sat, 13 Jan 2024 14:32:27 +0530
Subject: [PATCH] drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL
 check for writeback requests.

Return value of 'to_amdgpu_crtc' which is container_of(...) can't be
null, so it's null check 'acrtc' is dropped.

Fixing the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9302 amdgpu_dm_atomic_commit_tail() error: we previously assumed 'acrtc' could be null (see line 9299)

Added 'new_crtc_state' NULL check for function
'drm_atomic_get_new_crtc_state' that retrieves the new state for a CRTC,
while enabling writeback requests.

Cc: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 36af104e7663c..8623722e954f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9327,10 +9327,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (!new_con_state->writeback_job)
 			continue;
 
-		new_crtc_state = NULL;
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 
-		if (acrtc)
-			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+		if (!new_crtc_state)
+			continue;
 
 		if (acrtc->wb_enabled)
 			continue;
-- 
2.43.0





