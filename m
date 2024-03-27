Return-Path: <linux-kernel+bounces-120829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5C88DE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7761B2486B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DF912DDA6;
	Wed, 27 Mar 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6e+ZNC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489D139D09;
	Wed, 27 Mar 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541322; cv=none; b=b8gNBNjZIfsUIyx3aD8ikdc8hop9omJ62fZvgXHrUmt0/uQW0DdTCaKyd676gqPfwYtPgJNfkyffqzxAJEAax6c+JGoQZ0GsZsyH+BDZqBN2leaoVpzDbUbUikrT/d8cTEdjBecFJ771znO1qm8Zo3Gne9SOhBy4Vnbu7GkKNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541322; c=relaxed/simple;
	bh=RefdEEQR2WW+1s1RlS40ESTXryb1X0ViQR6Q4wLd6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjE5pK15/PM2cuRe4bkA4I7K6coTN9gXHPAfRH3Re2xf86SnW/lk939uJ23lVsS9JB2mK/mvkYdq+Uc680u7Qs+UaOkbNdn8Cxi3A86EG5GP6Wyt5sXsVW41R/31e4eJFx4I3jBk9zUFFWrRCYqJzbZ8XIP+uLo71ixtnj7nNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6e+ZNC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A50C433F1;
	Wed, 27 Mar 2024 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541322;
	bh=RefdEEQR2WW+1s1RlS40ESTXryb1X0ViQR6Q4wLd6tU=;
	h=From:To:Cc:Subject:Date:From;
	b=k6e+ZNC8XEIvWdxoEEe4w+K/b2+p6FAmtRx7QnV15sJpsCmUrZCruYcu0Y1mZtSA0
	 U2cNouG9Cc/CwqhqmVvsp6NP8FIyzX6Df4DMxL9+KAaDqf9toBHy/6jqpXNoHyzxXu
	 vaXknoa3jiCp4Rm+nx+oq/UUQNrFnljLwsmpQQR31Ct0Crne9jHfkwFsmhKcYOM495
	 Y/2PnmHegLPjzfhSj3GYgqBK5/K9J5bO4M9CQHpW739tVz//I0TMQE0GYco0O1Ncj5
	 B9GhGSUawAefnCegt4kj/t1hzmpervnKy8vYuXtc9aFCYbmWuIH44fqURazwpC3Bop
	 6x4MBPdADdcXg==
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
Subject: FAILED: Patch "drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests." failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:39 -0400
Message-ID: <20240327120839.2826392-1-sashal@kernel.org>
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

The patch below does not apply to the 6.7-stable tree.
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





