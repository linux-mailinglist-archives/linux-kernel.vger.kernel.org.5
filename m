Return-Path: <linux-kernel+bounces-120835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE388DEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3EA29A7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8413AA23;
	Wed, 27 Mar 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO4LSmPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC013A88C;
	Wed, 27 Mar 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541337; cv=none; b=QEMaAzcXYl91n8Q0b4UFIUxdxXDfRfzT9LFTGocdUMR84YfxC78CkLStV4Ny78DLii+X6jtyL9B/GA9WT/3RKUYL87Sn3hSCjn5tPs3K69KeC1pi4AIVUwNQa1p2VQDw6CQPL0dKqpifzqDp4SojN6qn5QApILWNfaST87GoTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541337; c=relaxed/simple;
	bh=FDcpQWjiADNoFgdMjV7HfKmNenOZ6mJrr1Hve0dxvSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qX6fBMGTwd3lM0lMzh9K5z8KGZiM/DLihNBa82CwD4r40m5zaLilnrhSAyZ8IJM+MeJjpmXMdU5KzHlhqdPTtcW2V5YsmHYX2RNLemqT3C7zQ6PocYLAMp2MnobUGkICDvEclO0B5R5rBlgNKA1CYLiQqhanvkCUMd9Rw6GsYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO4LSmPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E275C433F1;
	Wed, 27 Mar 2024 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541336;
	bh=FDcpQWjiADNoFgdMjV7HfKmNenOZ6mJrr1Hve0dxvSI=;
	h=From:To:Cc:Subject:Date:From;
	b=CO4LSmPulfvbwi2aOcHSQcxy1ca1Jgrr5V54Md6DPAXsHkm8YHS3gD2qGsBQWSncO
	 1m14OyP5nC7Ge69RM/dZhQPEXfGu9Go7w+VbJiOT0HAJaw1c2BOD1jDksQNFVJ0aeX
	 NlBRirkGakxTfzgj6g97TFC8dE5bgI2XpP9j9R7YSeZ8CG6JpEbqirWd+SW0sGkBVx
	 xoYip62cwTGsHUs2Egn0esw3OPKyDjzvoyIW4L9N5gjIv4WSkony3QuTWBMNJCvwKB
	 bu60dGQDny1b+xgVbMXxj7bdWLb18aUbURVkJ3OI5XkuwvhfHni0ursOUzQQsnhHA8
	 hHzv8PtRCGCgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	allen.pan@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add a dc_state NULL check in dc_state_release" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:54 -0400
Message-ID: <20240327120854.2826609-1-sashal@kernel.org>
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

From 334b56cea5d9df5989be6cf1a5898114fa70ad98 Mon Sep 17 00:00:00 2001
From: Allen Pan <allen.pan@amd.com>
Date: Fri, 23 Feb 2024 18:20:16 -0500
Subject: [PATCH] drm/amd/display: Add a dc_state NULL check in
 dc_state_release

[How]
Check wheather state is NULL before releasing it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 180ac47868c22..5cc7f8da209c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -334,7 +334,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_state_release(struct dc_state *state)
 {
-	kref_put(&state->refcount, dc_state_free);
+	if (state != NULL)
+		kref_put(&state->refcount, dc_state_free);
 }
 /*
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
-- 
2.43.0





