Return-Path: <linux-kernel+bounces-121157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBDE88E2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AF1296BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043113E03D;
	Wed, 27 Mar 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN+V8PsQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2208178CE7;
	Wed, 27 Mar 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542229; cv=none; b=abS56DwI+9T8pk/zS+SIhl8tO/nquMy3VPL6VAfWEZFWP2kO2BDqekezikxUt9V8jeB1xqv3XXnxTKVy76VEc/NA86JhE/jEwDjYc2KEfQfqF2l+ssQpLn/lfILbs761znERF3zuwF/jCjphT465ZSLPLOM6pvyWZciI6Ef23Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542229; c=relaxed/simple;
	bh=DoQnaQT+t8MTyyH1rCn641sboskSEeo4a4QMaq1sHDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csohW8IFd40yCrEgx5DgOiXsmKyouOj6uFok39R1EnC+eRfS2VLEnL0oDPi7WiZFpA4xUJm/oDTXTKlPgpsMbWmA8F0ECmbJ1hBxIN3F9VT4gzhJfm4CzfQbDXZFQiCaawC46geexUDPFvfe2AXql38ltx/xmycJ5ESZzrOfTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN+V8PsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA31C433F1;
	Wed, 27 Mar 2024 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542229;
	bh=DoQnaQT+t8MTyyH1rCn641sboskSEeo4a4QMaq1sHDA=;
	h=From:To:Cc:Subject:Date:From;
	b=LN+V8PsQ6rybJhM6WYoTHcL5uwbWBU32I988gKtUAR5lvR4SZ+HgiLE28cJimshVA
	 bhAUFnTvSBgyNGnz/bGyGhh6abRIISvLsZgLOWvXCFeIXy6EWgSQ3dAjqRjXfzESB2
	 7pQshrRJpXZVRdidEmTST26wCQGTsxF0HKS8ONMyh0kzF4W2rCXf6lFO2VCSdCjAUD
	 YIhRhJFBL2OjUr/+FHFkS5/1ARiLgcdCnKB8LtoLTMQah8r70z3I831n+Vbg/AURzA
	 y0nWn7iNwBr2CYwLVRKZh5IEpw50fOYmSFRr9T9AbECwgYnsJGeZKT0obXSN5mw71e
	 lnLf4zBiQtA7Q==
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
Subject: FAILED: Patch "drm/amd/display: Change default size for dummy plane in DML2" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:47 -0400
Message-ID: <20240327122347.2838841-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





