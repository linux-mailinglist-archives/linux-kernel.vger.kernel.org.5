Return-Path: <linux-kernel+bounces-120839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3888DEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375601F2B7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01D13AD30;
	Wed, 27 Mar 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY/8hv2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8A12FB3C;
	Wed, 27 Mar 2024 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541349; cv=none; b=q59bOPgH6fyDDMixNPntcI5UPJCy/B5zeS3W90W5ILBYcl+C+6ZDUMxb6YE9rj2sJXlwEVUhwi3YdDu1tHqp+285B/igQsY/AvP7RGDpaGP6mjsrN41FfjeGdv+acO7pCmJvVhf1wm1NvokraK8kv+ISrvPCHety+uID4m1xxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541349; c=relaxed/simple;
	bh=BeBKwzKBwed9eN7L7G3xjM/u3W2SZWkvavGDISJ37TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAQ9Jb0bW76J+hbbnrPSWMv9e1T9MMGEFWzqPnnNAgauZGEBNWuzp8sRKdsGh5l8l7pH2PcAf2BF8vjLLHj/bh27FGu8loiexq9Vj2bkTd5uZRbxDkq6ROXEWMa+4JQ8qlMmjF6nfQzqh41/hb9Uow2BSLmcveQEyeagAeuwqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY/8hv2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCDDC433C7;
	Wed, 27 Mar 2024 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541349;
	bh=BeBKwzKBwed9eN7L7G3xjM/u3W2SZWkvavGDISJ37TM=;
	h=From:To:Cc:Subject:Date:From;
	b=NY/8hv2S4BX208A6POI60tvokl17PJJet0rBtzhLWDKxvgdSdNq/vCeBZg8QHqu4F
	 WIKeejjTl5RMlR4xLkNoOoir2CWIW1f/CRglrTUdueunrp1Jb9Ssv7S8Q+Gqu4vrd+
	 xblHt4YJaPUXpwloOEa9w5u8Tx7XyxOb0TA0CbPekeGpT/suHFkVGtr/CQSTxgJrRm
	 gxy0xVB+BYppCP3kXysRh16xvYAb33W/Z357vXAOiBIMsIxb/BIlEyY9h6ZDwbkruj
	 CKZLVekBNl5dYPZtEXR1XmwQnfGOvuFTKNOS1Wo+A72cJUPrDeqflNGyZ8FA+/8iB1
	 KkGeru9nkZy2Q==
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
Subject: FAILED: Patch "Revert "drm/amd/display: Send DTBCLK disable message on first commit"" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:09:07 -0400
Message-ID: <20240327120907.2826757-1-sashal@kernel.org>
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

The patch below does not apply to the 6.7-stable tree.
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





