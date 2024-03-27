Return-Path: <linux-kernel+bounces-120794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A088DD81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A1F1F28532
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21812DDB2;
	Wed, 27 Mar 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSDP+Z5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F812DDB0;
	Wed, 27 Mar 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541221; cv=none; b=RRYrtvImFEDLmEB6BMPP5gWbQpXW2niQw5JzX/cjlCVaGZiVJSgjcjte+OfGtRZWh7kPn8qppwyK29YvgEgW1wkOkQbBhMssoWHxCqpAD8Lwt5myt9rUEoiIkc5xgPCEGJifFOOlyadQxtr7N9V/TzIPcHBHEKAL7KaezD0Js64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541221; c=relaxed/simple;
	bh=h6ROyy+3C/ljEpDwwrz81uL4PDbd3s4mq+D18gXSBMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPrN5hJR6FYALSEhpBSHb2TpmrdDV39/laRKMQaczVVfJn/CPiabZiNEyADlTx6Y+XLG5OI+hWi83e/v+L5w/VgYYY4321YFvx5uvIPZAaYUdedFL04ZiOCMPdWw2iAUjhZPH/NjIffStvcTNuCsjLqcVVdyc4NAJFIdYp0U40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSDP+Z5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0ADC433F1;
	Wed, 27 Mar 2024 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541221;
	bh=h6ROyy+3C/ljEpDwwrz81uL4PDbd3s4mq+D18gXSBMY=;
	h=From:To:Cc:Subject:Date:From;
	b=aSDP+Z5vOVSOpW/f6yGXoPhi74gnQ8gxcNKyPTmZm6F8MO2RbFXv9eCUEJFk6yYlf
	 G2AvD/3bYQpeUP1K3GZwLmR58GVQH9b+B6PpgTrmf/rLOmBKDaWMG9d3vkMNIFpkoF
	 8K6ppmV9IIffGv7tls9idyGfCLPBNsZ5Woo/w5CGXz+gEBqBAtcHb4j4cLyug+cLly
	 cGvZQfxuTiYGHA2370CoGk7Hm/Cn8tHLkBSToFc4Reahqe6t2sSCnKm2DflpZNfbBv
	 qDdjL5tPg10Zcw7VklGiU5qSdNEEOcus+3kW6j1Bu0rGY9bEqBfgrOrlXtYqp+abvZ
	 3ERqidaqbBlMA==
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
Subject: FAILED: Patch "drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests." failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:06:58 -0400
Message-ID: <20240327120659.2824939-1-sashal@kernel.org>
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





