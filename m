Return-Path: <linux-kernel+bounces-120923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9C88E08D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DEDDB28954
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FF212EBEC;
	Wed, 27 Mar 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB6akFEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960A14A60E;
	Wed, 27 Mar 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541594; cv=none; b=HogSyApobftQF7V6C5YNoGebtBDYPxx12nIC86wRwMe5Bk04ycaRMilZOwN4JP7bkwvVD9fOQUQfVgyGNtOJanke9KLKzFAedMz42N/Ah7yH+i2mhH5UXqmDSGQqVRtL0MXFH3Sy6DL1ZG5nbPAbn5xLdIum+4Y11GsQScz6ebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541594; c=relaxed/simple;
	bh=3k9Wr46MD3uT08kscaqdDHwaAGEf0STDD/lddHPSoys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXAcqL2ZZnSGDnSroOSOeYryAWICMPwgC78HtwFIK3lsKUjE3JP4TrRle2OJpqWKpHb4OfPq/MSsh1KUyGhwykOwDmoB1SGc8u/X8RsGwRg90SrdApHpLvYi98NM8jgIPs4IDLAz4tvJrn2AsSKqGarrgVka3jMTWF+ZK+ijReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB6akFEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ACEC433F1;
	Wed, 27 Mar 2024 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541594;
	bh=3k9Wr46MD3uT08kscaqdDHwaAGEf0STDD/lddHPSoys=;
	h=From:To:Cc:Subject:Date:From;
	b=iB6akFEnUtBFcRT9fPVzQsQd2SgMKkZyZNOOIyQ8g9dTD9fvCzDnWiKuKJzcvPkIq
	 yll+Pqyo23cJofpH6ViOzfbx9Mt+wKXXuMEa/AM6Vj5OooUx4uaA7+oZUY8/1C+vAF
	 Y9QUCjHe4u4KFQ3lYB4Uph/HEAyU+8VVAWMrgN+dbu1utmMI3O7h6jx/r5S6GAAHsz
	 laDgeMGsMhCtz1L5RnD0L5iKeCNqJQJa+SD/sZrv0TitxAen8h0mthmv6PNeyftNmO
	 cZaFbDOVKhyZ0HLZ8VkAFx86sQ5QVgWVK5RPTQmmmC/IofdOs/J0bjFu8oaGzEdro0
	 UHtAO0B/1e8OA==
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
Subject: FAILED: Patch "drm/amd/display: Add a dc_state NULL check in dc_state_release" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:11 -0400
Message-ID: <20240327121312.2830127-1-sashal@kernel.org>
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





