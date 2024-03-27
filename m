Return-Path: <linux-kernel+bounces-121066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA188E205
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42001C2A53B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62106161303;
	Wed, 27 Mar 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL/+v8wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA9160873;
	Wed, 27 Mar 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541988; cv=none; b=ELlWt/XefW65uR7JCTx4iHuA02pCKtN4rsbnt+86nhVwzou3x8kQRwfncnwA+YfYQuoDty491qQMyXu1bkCddmnOXreEh3zZedmIK7Bv79Bxy7fFMol2fZE1HH9MoT6lhB/sXGWBg5cHngmsrgyfa9hPTl1lhxb0QHL+IC9URQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541988; c=relaxed/simple;
	bh=egbXLkqW2ltqYLDtV6wrlHM4IKYp43oTYDDs7XtRjas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJMgxFQb7D1yPuP8DeRNjPhNowBru2tZveSQ2DNxP7+jiJasd3/14CXNKwOkrtRblL+IBUn97SMPytAsN5LLPopI3U8mnMxGnwadfaoTNx5r96hYAKfJJ9+OucgXdITAW9zcOCUab2UbMcnK2Yp0aBLJFjKZi/dbN/sps6zAn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL/+v8wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751D7C433F1;
	Wed, 27 Mar 2024 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541988;
	bh=egbXLkqW2ltqYLDtV6wrlHM4IKYp43oTYDDs7XtRjas=;
	h=From:To:Cc:Subject:Date:From;
	b=jL/+v8wk6SaqbT5RprVf52E/yxtdY+3GRIdgJJxpr8NUpRn6f/9SDoPGKQczfXUlU
	 PFLCnXIFxm/1vdJjmxExIAChTXx6mkgh6zVzWDI6ruggtmTzbonSgxpjfjWrQuqcpf
	 inbz1ZUpotGGjL5GrhWjkZtk9g5SBGVzFQLpel0Wf2KZKde1+5SGlVMZh6A5OdG+89
	 tVuxCzY8BsNcznxrYNnmE4N+5nADGGEHb19JT2RbYB9GBvkpMiwdF4Qriq+hzt/KfM
	 ewSJJfzVePbMEX0q9XX6GJgxkKzF/ejQI1Q1iPlaTtp+9Q7UH1wNQYffry6lwULAir
	 Gzva0okKwawHA==
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
Subject: FAILED: Patch "drm/amd/display: Add a dc_state NULL check in dc_state_release" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:46 -0400
Message-ID: <20240327121946.2835462-1-sashal@kernel.org>
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





