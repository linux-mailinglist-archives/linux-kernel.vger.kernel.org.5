Return-Path: <linux-kernel+bounces-121018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E618188E185
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2364B1C222FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F29158DD2;
	Wed, 27 Mar 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvWuVDX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A015957F;
	Wed, 27 Mar 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541855; cv=none; b=UIgbhiClneArkTaNB3pJaPmUbDJym3QT3NYkJ+GZCvju0hmuyeXimEn4QopV1ay8d2TJfistESS0RY/3T1+TuNDnCiRa8oFYWNofq9hlaTcNrPRgNp5qu9bC8k18Ai+Gga4+Y9ZFRoSbrRceHwa7qinRXZ+yxrCo2tclxt+MO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541855; c=relaxed/simple;
	bh=rbfDrddplKEBc78G+emDnzYQbvlYfaYHFyuBflOcgZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2TRVzFIN6AgoYRFDMUG1QAID/+KSCBVmP3PGPtVYhSEuBTkrEp504DJFpRNpjPR/0pngvknLkg9YBsu5Crdr6k8x+VJNJ4zKb/56Iyqwp1L6AXhY6jfD/HG504MOmBmNtTFsEdwfJ79zGO9AVj9AJ0GkGgEWBp3CeraWiLbmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvWuVDX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A92C433C7;
	Wed, 27 Mar 2024 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541854;
	bh=rbfDrddplKEBc78G+emDnzYQbvlYfaYHFyuBflOcgZc=;
	h=From:To:Cc:Subject:Date:From;
	b=LvWuVDX5woBRcNSqQavuXUBxitUWosBeXhLNrYgX6ActN3n+RU5nvX59OcMABLUXQ
	 E6Y1fzx5jO36K4kuVzzpC7mwgaVpu8/TbF/XAhSDzvpItfkaUuU7rYc2nYk5LUXV2X
	 n0Quf9P2sk7Mh6wPIhF/EY0XfJjPYT9NGtxZSd1dQxEn7wTOBQ7GRrgeRa5SjVDMVc
	 WNtkyw0aWIIJcFldkDxp/kHsiAAIdGd2P8E6ZX4qpb7Y9fAUTquCfAc+oc0LUJWTsm
	 TekvN/tPBLoangLMb/ik1lkcPVOZQd1Etzjfi8gbWhEczmThpbtHZ6hlYEmCtDqZ1b
	 vnHrOmbPNCi0A==
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
Subject: FAILED: Patch "drm/amd/display: Align the returned error code with legacy DP" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:17:32 -0400
Message-ID: <20240327121732.2833618-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





