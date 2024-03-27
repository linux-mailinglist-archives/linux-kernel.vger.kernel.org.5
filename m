Return-Path: <linux-kernel+bounces-121221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CD88E418
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982871F2D8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8570B18A73A;
	Wed, 27 Mar 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riZmJyC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD566130A5B;
	Wed, 27 Mar 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542384; cv=none; b=Nn0aSWNt7JjxHw+sr01kCeAuE9dL/3q5yKhIQI5pDo9EDI6Wrf77J46xmOKfWfqjr0Rqv00gY0nWWvZLroOcpYNoTXhbh70l8ilAOC599cPGtUtQWDbmuzQuS55g+jZn2Qo7JW/oTbwvo4hYaY/3R4TENw93cd0f6SlsPRFzOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542384; c=relaxed/simple;
	bh=LQBoXGf9p1SZaNSvXSfZE9eFpWax/u1bGRR7bbNl9N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ER+imGn2rJDc55weicMnyeGXFuOk5VzaOy3vRqGA6PKOBYcaAq3kpN/3QKkZ9a/Y3tw21bFE1gvMf06n0kI+/mRB8iBZL/Tf8vlhZ0NxvrL4uJ1NbF+w0H1CKbFptAyT4Vw3sQHUovgXycnm/xMiIA21Nur5ATtDOanomoxup6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riZmJyC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A28CC43390;
	Wed, 27 Mar 2024 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542383;
	bh=LQBoXGf9p1SZaNSvXSfZE9eFpWax/u1bGRR7bbNl9N0=;
	h=From:To:Cc:Subject:Date:From;
	b=riZmJyC2anvwYaZ5EYrb9o3eMNIXM1YMqHqhea3HqGUGNY46HyBkbdtbrsbQh4Epz
	 avo2M9zcIvcw8vh3EXiN8UOPq4Iq81rkOuBYbirkNic3MeGoBeBXLNQWfXAvxgyF8T
	 xuPMVWd84FZ8MLqbsF2lx8sjSGm5p2yjj2Y+0iq8aGQ1C+hVdLA0KuXZxKAEa8goOz
	 +qND2Gg3+M0pADZsqwQQIdelNIvEBdxkFxY/9Wfy+P+f1sMNf1oN+mXSQONuw5O2La
	 z7OVFce+Ik1ru617XIFUdPxJk6KzfkYunZyl/pIKsGs/dIMCUurKXcUfOwLbxwg4Q4
	 51QQsAflSjYrA==
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
Subject: FAILED: Patch "drm/amd/display: Clear OPTC mem select on disable" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:21 -0400
Message-ID: <20240327122621.2841037-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





