Return-Path: <linux-kernel+bounces-121128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0088E2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F381C282149
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C22174940;
	Wed, 27 Mar 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuP6Zl7q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7E13C90E;
	Wed, 27 Mar 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542148; cv=none; b=tysLnCwmJHYWOT46tfXHeiuSh9W8YsjoCiJupkiZImnblmise2+ck0BsUiL2KrlmMGIYCG21XOAwfaPeE1KD/XvprYEqLiMgKGWAe0eyJFZ1SwUvzlHRWiXtVBqvaI8U+P2XMl3QXL7+/04qvvHEILpJXrRyPZGjC6G4fwI02gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542148; c=relaxed/simple;
	bh=LjaA+PCDzYfqK9L7/WofbPKiOd67HjBA8xxSBLeDJUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KP6IgkYUMH4gWlbFfQqs5kzMaMKmg4foZUZvPG4hLwLDf0vEOYHWd9BsFGf+ZSJB/RvQsvwyJR0y0nqkiRGGfXlbJ3iEOGbH7Mlz9p9GPmwQyrCN7+GRjua8areG2lM01jMupb1u7tN/N8O41mO/erRQ8Q/dnAtVw9YDrA8o2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuP6Zl7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD0C433C7;
	Wed, 27 Mar 2024 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542148;
	bh=LjaA+PCDzYfqK9L7/WofbPKiOd67HjBA8xxSBLeDJUU=;
	h=From:To:Cc:Subject:Date:From;
	b=MuP6Zl7qz4G0HofWfNr76FHuLMJCoQ3jx5MJcXApp/IG0MJ3JAIW+BmgJhBfb5pVy
	 D05nBiSX9g9h/wSE/jbb5bkWIRjVMK2gxVaWkx9iTHQeYQdLXKO9kzFhCGyJXcOZI7
	 FdyIpSWLI+rnj1w5B1xRl2MKvgElBxVOG65iabxbsYbjmvN2ewroTmfiCWENl4iAwt
	 mNfhvLSGmHDGK7NfLD2s06MMtMhi5lRIwxY8ELN9wOfO9zJZgPGih4luWlratw0IXW
	 Igv3hp/bmH7pG2nJ+iiTDRYsZ5sAVR3a9r3T0cZA3G5rxO+c6F/w+eQ5qi30U4PNps
	 A5Sr4w1kaR5rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ilya.bakoulin@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Clear OPTC mem select on disable" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:25 -0400
Message-ID: <20240327122226.2837710-1-sashal@kernel.org>
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

From b4e05bb1dec53fe28c3c88425aded824498666e5 Mon Sep 17 00:00:00 2001
From: Ilya Bakoulin <ilya.bakoulin@amd.com>
Date: Wed, 3 Jan 2024 09:42:04 -0500
Subject: [PATCH] drm/amd/display: Clear OPTC mem select on disable

[Why]
Not clearing the memory select bits prior to OPTC disable can cause DSC
corruption issues when attempting to reuse a memory instance for another
OPTC that enables ODM.

[How]
Clear the memory select bits prior to disabling an OPTC.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c | 3 +++
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 1788eb29474b4..8234935433254 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -173,6 +173,9 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 3d6c1b2c2b4d6..5b15475088503 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -145,6 +145,9 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
-- 
2.43.0





