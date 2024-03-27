Return-Path: <linux-kernel+bounces-121051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93888E1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7FF1C28827
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5E13AA2C;
	Wed, 27 Mar 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tae1olgp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950215ECDC;
	Wed, 27 Mar 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541945; cv=none; b=sKqxr1R9ZD4g/ByFWy+ui1LRQALRFya2Q9ojoAqC1OtsixWcq13eb4kzGB0+RQDy/3zLEF/zCo8qOIH8ttrKHeu6nzB/7GPgyufQ4loAzs4OCdSd3ZrvHsnsdBCs02fGjSwhqx+CaLgQGzmUbKB+L+Ckfudofjy9Qr65CJVNPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541945; c=relaxed/simple;
	bh=xhHUhagou7j7yV4aF0lAFnXi96sDR97KFT8YkdNIod4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhyITC2BVFOEjynxpwESSX/oNmDxoq7XopFKqhFz38quIhBGhJONxC0ZGfxL54xX4/nUdHrf2y5HxpSCDVGZFNmmVPV/LtFRJ2cRvdV05RrfwDvsC3VbRNrkGvNRSl09noojYaeTvUqqV3nAcJEDaRzAcuiWB85ZYqXE3XWKtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tae1olgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE626C433F1;
	Wed, 27 Mar 2024 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541945;
	bh=xhHUhagou7j7yV4aF0lAFnXi96sDR97KFT8YkdNIod4=;
	h=From:To:Cc:Subject:Date:From;
	b=tae1olgpA+WkaRFNBJeK2xSMkbCtsX99wjutqlYX0sTvwlPuArct4JsvyjV47pzMU
	 0E0AcehNAnVGOWJjDRcbJE71pe1k9I/Boyx6nVTj1s1XNghc7MjG8UjZRQY0QCDFHC
	 nh9Zvkmt28+FRkV4RfPYBKQPgNB64rKvSIVRlpPnz1NI3f8Av4aGb77ACAYZSiQuej
	 BaokPhEL0UWkt7XcSwbNDaL31vpXyF9hneB9pUbJF3dJESw5YmxzMA1SuE83OogXkL
	 XcrchfvALXbpx8/SfKf8k9b5MIYti+AJx3NDHEYDC0rijvn7cqwIGliaUD2cjV8pip
	 lJdCKyPoQI96A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	srinivasan.shanmugam@amd.com
Cc: Jerry Zuo <jerry.zuo@amd.com>,
	Jun Lei <Jun.Lei@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:02 -0400
Message-ID: <20240327121903.2834888-1-sashal@kernel.org>
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

From 3295580d4683bdc56c0662b4a4834f597baceadc Mon Sep 17 00:00:00 2001
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Date: Wed, 17 Jan 2024 08:41:52 +0530
Subject: [PATCH] drm/amd/display: Fix uninitialized variable usage in
 core_link_ 'read_dpcd() & write_dpcd()' functions

The 'status' variable in 'core_link_read_dpcd()' &
'core_link_write_dpcd()' was uninitialized.

Thus, initializing 'status' variable to 'DC_ERROR_UNEXPECTED' by default.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:226 core_link_read_dpcd() error: uninitialized symbol 'status'.
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:248 core_link_write_dpcd() error: uninitialized symbol 'status'.

Cc: stable@vger.kernel.org
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index 5c9a30211c109..fc50931c2aecb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -205,7 +205,7 @@ enum dc_status core_link_read_dpcd(
 	uint32_t extended_size;
 	/* size of the remaining partitioned address space */
 	uint32_t size_left_to_read;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	/* size of the next partition to be read from */
 	uint32_t partition_size;
 	uint32_t data_index = 0;
@@ -234,7 +234,7 @@ enum dc_status core_link_write_dpcd(
 {
 	uint32_t partition_size;
 	uint32_t data_index = 0;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 
 	while (size) {
 		partition_size = dpcd_get_next_partition_size(address, size);
-- 
2.43.0





