Return-Path: <linux-kernel+bounces-120881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF588E023
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3602F29F34E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E19143C6F;
	Wed, 27 Mar 2024 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds1aFSKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEE130E37;
	Wed, 27 Mar 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541475; cv=none; b=gmGSmdidnttr+YbMAidOiQadUzQC3z4MTJ48PmnK146q4TM5yTkl9viKljC7iT8dop9jtaPTV75Atf8iMUK3U2juB7cZ/diEP0FSjWyznTDq7EJSgYK62CPLo9XtnWpSyQ2NwWbIE7ubKqPHN716wcwQM+4KQQGpu9TjjYePiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541475; c=relaxed/simple;
	bh=9MDSg8diNnnmtmY8t5so3HBPUWbg3AOvXnfYt2w+2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gk/OMX53Md44my15Itja37Yclb9Jo9cwVkgq0RQYfK2pkV7i972UhZzqHVadQaiBl1ERgRbaVg8IjgiKNqwOXp0e0iosjYdf5vmdkQcc7pW+Rwyvuum3as9pxEk8qe1x+298i0QJPYU5DFDOZbBClTjS/+Z3AIEx+dXRAqehuQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds1aFSKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D85C433C7;
	Wed, 27 Mar 2024 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541475;
	bh=9MDSg8diNnnmtmY8t5so3HBPUWbg3AOvXnfYt2w+2q8=;
	h=From:To:Cc:Subject:Date:From;
	b=ds1aFSKt/6m4/iyIOLX80sv4w9WqpSMUotTK6J26yDxLRksGvtZhsVUoqJxyDvc7a
	 pRaWZlqBqKitN+STeqhoK3WGtN4bd1esBJ+CGhiB1+TlmO1HXyhOiYstxPIJatKIVW
	 bhR5IHrnfYEBEr9rYXjZdi4HYCLnvtkLOlmPxvzUw1wX9TaitPkhQpjEAeXjTMqz2P
	 rmzClRimePQ+7Tri+b5ePxu8+x36L53qnzjYP+Pe04a7BGFlzL9b6d48Z5hRyqpaJe
	 tBQeefwQBdBqvXWZE8Epi6plqEFtUXDHkHuq0F53tGoJ62+OondZVnKx1BJd+NN1cB
	 cW8h+jEkzlj0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gabe.teeger@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "Revert "drm/amd/display: Send DTBCLK disable message on first commit"" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:11:12 -0400
Message-ID: <20240327121112.2828592-1-sashal@kernel.org>
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

From 3a6a32b31a111f6e66526fb2d3cb13a876465076 Mon Sep 17 00:00:00 2001
From: Gabe Teeger <gabe.teeger@amd.com>
Date: Mon, 29 Jan 2024 13:31:44 -0500
Subject: [PATCH] Revert "drm/amd/display: Send DTBCLK disable message on first
 commit"

This reverts commit f341055b10bd8be55c3c995dff5f770b236b8ca9.

System hang observed, this commit is thought to be the
regression point.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 06edca50a8fa1..36e5bb611fb10 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -414,7 +414,6 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
-	clk_mgr->clks.dtbclk_en = true;
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
-- 
2.43.0





