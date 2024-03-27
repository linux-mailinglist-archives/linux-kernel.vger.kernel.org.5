Return-Path: <linux-kernel+bounces-121093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5776688E244
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A331285FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD016F0CB;
	Wed, 27 Mar 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGoLJVnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A416F0DE;
	Wed, 27 Mar 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542059; cv=none; b=CSGLCa0jBa4cdvvGrEVIfWGZ/5Txs1KXIJJ6Dg9kaBfSFSRhLJrwGWwwpavFXVFFz+xoGhaBRI6aIwdZGwHR0BeOrc3RClqhAiyo5lG4oWpxUJtvOCmpH0h/msQVeCS9vBwvwedMmbGLe0kRAsY9Wc0sxpf7W8Q6eTAuF5X9WgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542059; c=relaxed/simple;
	bh=OVBJBu+CcgpOegW7hGoEq/EmfAecQDFcileKKuKbLaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESZxUEf83z84hRLDKeiB5drSOw46B+Sz4x/RA2oEqF+NoK+vAj0jGaWoeggysi8guxy7Zv7jk/fXl6q4wJxZv/9GQBjZXqx901ySIvRA6nloJNRVSup5S3syXiNkp4O4O4F+EREy/o5GeV8mu5tVoHVkHxp9q/m6zcXFUxxDKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGoLJVnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C35C43390;
	Wed, 27 Mar 2024 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542059;
	bh=OVBJBu+CcgpOegW7hGoEq/EmfAecQDFcileKKuKbLaY=;
	h=From:To:Cc:Subject:Date:From;
	b=qGoLJVnZq+DdBhrSQErnDAboIPrZ5yg1gr6SeLbtJ4MR8pkU44fAT8sXY2MHaLs6m
	 N53Sb65aZL530sgktaK1OWHpNibAotsE55Pg8umErOVG6YFQQPBRiF3iCIwmlHat0F
	 6KKuMEnSog4lHm4b7qqPLFtwmtaawi8KGDTvpp+XS28P6KcWAAhtin0lu4cak7Jalx
	 EmtDrJONa2gzMVay+nlOSfKVf0iDzMol5e2o51kLs/kkKmVh2a3CDiXMahdpkebcws
	 8KQWS7NBxIrQLmqJfsiOw6FTllcKA2XbxaAZBezjtgmo60gY5611TN7lVOBhgsqJl8
	 2eg+nkpPROsFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Wayne.Lin@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Align the returned error code with legacy DP" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:57 -0400
Message-ID: <20240327122057.2836454-1-sashal@kernel.org>
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

From 3b84525544be4ca0481110263a6d73eb00741cf3 Mon Sep 17 00:00:00 2001
From: Wayne Lin <Wayne.Lin@amd.com>
Date: Tue, 2 Jan 2024 14:20:37 +0800
Subject: [PATCH] drm/amd/display: Align the returned error code with legacy DP

[Why]
For usb4 connector, AUX transaction is handled by dmub utilizing a differnt
code path comparing to legacy DP connector. If the usb4 DP connector is
disconnected, AUX access will report EBUSY and cause igt@kms_dp_aux_dev
fail.

[How]
Align the error code with the one reported by legacy DP as EIO.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index eaf8d9f482446..85b7f58a7f35a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -979,6 +979,11 @@ int dm_helper_dmub_aux_transfer_sync(
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
+	if (!link->hpd_status) {
+		*operation_result = AUX_RET_ERROR_HPD_DISCON;
+		return -1;
+	}
+
 	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload,
 			operation_result);
 }
-- 
2.43.0





