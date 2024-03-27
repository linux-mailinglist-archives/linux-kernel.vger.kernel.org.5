Return-Path: <linux-kernel+bounces-120927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264A88E095
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AB51C29822
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7212D756;
	Wed, 27 Mar 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpUFvs5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B085D14AD03;
	Wed, 27 Mar 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541605; cv=none; b=Htwrf+0LsRKAFWUrmax13BAqZesZUe9O7Kp5YBrxjfbJbnrnjwfNs1PgDn+FyNTZAMPMJjcW+7GAhbMCyiBrjQ2X1qq+k8LN6BJuRGSuhjfxth5pjcdix7Otislm1C+7SBfoFRfxzUDTJ4UJhSOkHThuwvUgEN6CORzDyV1v1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541605; c=relaxed/simple;
	bh=mMX2x+2vaei6U/ylr9NhOjmaTkh9q7mzJ5yCbMhF3qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sThgrAIj4aUFic+omxWzrWUigsJ5oeP0/R+PC1bX+pM89QFzHwzekH6gZI+Lr6wdRxYMu+i4w5sLry7yxyGtQbCL5AmUTqiqNUb1VZhEuUZ4h++KNN2usJMPyGL/puN/bh3UJbVMvMlvidZjSnZWtdPIFeWKwfRBgHIJA6iwSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpUFvs5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E822C43390;
	Wed, 27 Mar 2024 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541605;
	bh=mMX2x+2vaei6U/ylr9NhOjmaTkh9q7mzJ5yCbMhF3qc=;
	h=From:To:Cc:Subject:Date:From;
	b=HpUFvs5YBFSSYJHUJaDYVPmcnGvzTcDMhemmL/cNPoY98ckmOYuVC2C7txZ+N3lFY
	 epfZeFpdBdIoci/hSt2Dz2pq/t/PMKRfrpkkIgpp8Q0wRt265MBcsnUv3FRDITidUQ
	 qK6Zoz1bSoYfs2WqPz7n1K/OSR27+qOPkfSeYI0cv1RJ4nVL3gmb0LiQRU1Lj07aIP
	 tGVcsZEHoe82vNiaMD28goWhsckHSq+vOh2vMVZfDOurvDlZ7GF+d9xpgC/usgidTr
	 QSleVpSzrKx9/SVNnx2P4AfiKcOzqGiac69ACnI9rQlTyTCYduu6Wx9IaOrdZIHbyQ
	 WGMA+724rLSdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	swapnil.patel@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Change default size for dummy plane in DML2" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:23 -0400
Message-ID: <20240327121323.2830275-1-sashal@kernel.org>
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

From 75eb8f7df65c5e6eb22a5aff8deb60ce0b65de1a Mon Sep 17 00:00:00 2001
From: Swapnil Patel <swapnil.patel@amd.com>
Date: Tue, 13 Feb 2024 08:09:48 -0500
Subject: [PATCH] drm/amd/display: Change default size for dummy plane in DML2

[WHY & HOW]
Currently, to map dc states into dml_display_cfg,
We create a dummy plane if the stream doesn't have any planes
attached to it. This dummy plane uses max addersable width height.
This results in certain mode validations failing when they shouldn't.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 1ba6933d2b361..17a58f41fc6a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -824,13 +824,25 @@ static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
 {
+	dml_uint_t width, height;
+
+	if (in->timing.h_addressable > 3840)
+		width = 3840;
+	else
+		width = in->timing.h_addressable;	// 4K max
+
+	if (in->timing.v_addressable > 2160)
+		height = 2160;
+	else
+		height = in->timing.v_addressable;	// 4K max
+
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
 	out->GPUVMMinPageSizeKBytes[location] = 256;
 
-	out->ViewportWidth[location] = in->timing.h_addressable;
-	out->ViewportHeight[location] = in->timing.v_addressable;
+	out->ViewportWidth[location] = width;
+	out->ViewportHeight[location] = height;
 	out->ViewportStationary[location] = false;
 	out->ViewportWidthChroma[location] = 0;
 	out->ViewportHeightChroma[location] = 0;
@@ -849,7 +861,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->HTapsChroma[location] = 0;
 	out->VTapsChroma[location] = 0;
 	out->SourceScan[location] = dml_rotation_0;
-	out->ScalerRecoutWidth[location] = in->timing.h_addressable;
+	out->ScalerRecoutWidth[location] = width;
 
 	out->LBBitPerPixel[location] = 57;
 
-- 
2.43.0





