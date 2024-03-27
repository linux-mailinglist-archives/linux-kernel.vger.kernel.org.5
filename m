Return-Path: <linux-kernel+bounces-120806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6488DDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6A8B239F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30F131735;
	Wed, 27 Mar 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdFbfuvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C413172E;
	Wed, 27 Mar 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541256; cv=none; b=Ck73ivPfZlcHgRKKs8H2YOjeQedF37VyjwLvbn12EcTQPdTw3WOQQgEyoz05r2yVH1XpjnKlPYQ1RAckYaez4aYHc1IUoGflJYvOm5ZDLjv6+ZIsD6P5rNDAFxLyy+11Mq+TcdhnpQT9rBKQ6ngbX8kjljsYJkHc5igTffEmP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541256; c=relaxed/simple;
	bh=z27ctd1wqikApmCBJsojXFRGwBDUyNl1AUcGGmUOJTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMhDVX4wD0oUYdhAFg9Khz3iL4xVAvsxsiwjTNHW0Y9z4U/YuCcJJ+s5JId9BmfE9TPQg7dsxZlyO2lnsw1LZluF0xUO1OnG8vMB3ZJ0K9BIX0CdVcsR5noaT695/B7pHBaPh+pelAcyQ2oBeJ5KyPKLKa7v28X2Wb7wvRHhZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdFbfuvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D731C433F1;
	Wed, 27 Mar 2024 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541255;
	bh=z27ctd1wqikApmCBJsojXFRGwBDUyNl1AUcGGmUOJTI=;
	h=From:To:Cc:Subject:Date:From;
	b=DdFbfuvKGX8/ZvDOlR4+myQW5bdeak1LY1mHXVdpmoHcVVt3XWDHLLOhRhuabnFPG
	 jQyjnUDrd6bG1cq1/pJpCcLf2bwz4G8/usK5tTGVqMy0YI0jRGBlS7scF6r12aXiDH
	 TdRplkcDnaXN6SAJTWshvuqrQzTQFLs/fPdwwo6AvuM9sSjI3lNh8pVHDGEdaBjHdZ
	 001R281Y8tZb71BynXE8Q0g+luDPItT8q3xCL0IRpTHO6xswBoQPKbWJt4MSWB+fpM
	 IuLAAURlL3kzLvoozmJur7LhI1WEuL2JAGDfQZtGssCKOUQF3ILLON1rScqiFeCbEK
	 WXHtrMjq6Dn3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Nevenko Stupar <nevenko.stupar@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: fix incorrect mpc_combine array size" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:33 -0400
Message-ID: <20240327120733.2825545-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 607e1b0cf480cb8dbd65b372397871d7389942b5 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Thu, 18 Jan 2024 15:14:15 -0500
Subject: [PATCH] drm/amd/display: fix incorrect mpc_combine array size

[why]
MAX_SURFACES is per stream, while MAX_PLANES is per asic. The
mpc_combine is an array that records all the planes per asic. Therefore
MAX_PLANES should be used as the array size. Using MAX_SURFACES causes
array overflow when there are more than 3 planes.

[how]
Use the MAX_PLANES for the mpc_combine array size.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9b80f65c04664..a7981a0c4158f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1113,7 +1113,7 @@ struct pipe_slice_table {
 		struct pipe_ctx *pri_pipe;
 		struct dc_plane_state *plane;
 		int slice_count;
-	} mpc_combines[MAX_SURFACES];
+	} mpc_combines[MAX_PLANES];
 	int mpc_combine_count;
 };
 
-- 
2.43.0





