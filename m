Return-Path: <linux-kernel+bounces-120868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BB88DFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1561C22824
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D0A130A6D;
	Wed, 27 Mar 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E818UR3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D011411E6;
	Wed, 27 Mar 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541434; cv=none; b=OnCgRN/CfWINBuiijIAAJe9bdzvZ3zRFHChuMPuXS/qxe/vsFHW/TdRUxI2J8NAZcljG8jzzBtCiqr56Nw89UZn4gaVERhk9S32P3WsatkQfgc+EMRGtbbW78hfbIsz0lnuf1/CLVSi3FN2ogaNevU/LnQ2eGVEVlinPKqGOKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541434; c=relaxed/simple;
	bh=kVGztSXoCNM2CtcsNjAj4RJwr8crHwTY7PMb9c3CMrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxbgM4MVYt0b7f4+g/jpf0tlwPdcqLfOKwfhV8Ih9qkYcrr17KUfNfHODtrP6eFoMGz+iBKuejSNkTXfPNVv+ubeOyMXjaNpxIg3+pIONYCD2QNgMsFMiNJrtwf6oYDPeQ5nwIyRvb1n0nUi4K9zHNhV1pV26vi6PBenqDcGFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E818UR3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FCCC433F1;
	Wed, 27 Mar 2024 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541433;
	bh=kVGztSXoCNM2CtcsNjAj4RJwr8crHwTY7PMb9c3CMrk=;
	h=From:To:Cc:Subject:Date:From;
	b=E818UR3WRS6CLxoyn/SF1ebWzpNUemJeO/upFlTlkZUrK7sMFTwiYKjPFc81qyl+E
	 Wb6LUqdiDXtSH7p7bxLJ9mAM5bKwpF5uh8X0skJAD5szsav+XKDOyAyn6GLW1KMr0j
	 cPMYXeNAeyYjOeiQ8LLcgz+i0J5ROkM2SdUxsva5ad4ngfW/zN2kIC672+Wn3pEr3i
	 3DHiaVLuR88+ZZw3GJX5N+i6orrwoEihOmRMyZjC4rsws5e7rCL6+0Zq/D26dwP+ny
	 zItoAIsoKAn2/34/O34aDThrqLbcupSRz3fW2EXoN1bwzBIqOnKPhcN/Qbt/qYgwf6
	 5JanMXC78+NPA==
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
Subject: FAILED: Patch "drm/amd/display: Change default size for dummy plane in DML2" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:31 -0400
Message-ID: <20240327121031.2828024-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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





