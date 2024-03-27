Return-Path: <linux-kernel+bounces-121182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037688E5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D45AB27239
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8FB17F36E;
	Wed, 27 Mar 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJNDc2En"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6A17F369;
	Wed, 27 Mar 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542295; cv=none; b=WUjnIS/VtSdbDPAtCd548WxxjxEmy2z0RMMBCR+HJppb7Gn0d6B8QpnY7kFqJ2M413Ht0VN4sweJL7e31NQdprCNPw/akWJ7mZm1WRBaDcMv11LmSCEGo/gpB7dEkSuQNZKWdL/gd3xP9hvyA8VZo0tbUpAF82SfNCLcbyxQ7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542295; c=relaxed/simple;
	bh=fknINu/faBqH5QRRsaVCl1ChPXD+ABIoXqiGoPKk+Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ain/rMNVjxArXljAaXcDjbZ0V5uOZfieTUIG/8tg2KGa5b+YS3QtxuRanh+qrnebS1LicFUNy9h85GvOcMSVv3/gY6qvT1iey5gCTRqz+CYD2LamRwiW4iSEEjFhfclz9S0/0TpxUGSA13415gBX8dmzjeVZqJps0srq8/vKYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJNDc2En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0E8C433C7;
	Wed, 27 Mar 2024 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542295;
	bh=fknINu/faBqH5QRRsaVCl1ChPXD+ABIoXqiGoPKk+Wg=;
	h=From:To:Cc:Subject:Date:From;
	b=HJNDc2Eno+7C9xqwSxojkviGXTXuGwHF7Wt3tCKjZpFtv4zFdnrM/WH/MvAkrEv4A
	 dh7dmSuf/RK4TY09cXYB1Qj8f3g/CEHxY0MmTcQ/qw/rrP5j9g+V83vrGDf00CRjYT
	 xr+pDy10cZAeHmQfXmdXMt5O1oAYBOStEH/FOTSzLnGZMGS+q3kNGIUwsHb6lT2ggd
	 fu4rxHhQ3Ggf62DCBnWb7fmQ6qrfz2cCJdoUiez04cuoFkAknkvhZG4YmF57xFcOpf
	 igIMebykMerDOTgOKILEpEi1aiEK9T1pdL5xJdf4OKRmW9Be/mAAR0gZB1IRHvO0AR
	 FxiZHW/Ff7cFw==
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
Subject: FAILED: Patch "Revert "drm/amd/display: Send DTBCLK disable message on first commit"" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:53 -0400
Message-ID: <20240327122453.2839765-1-sashal@kernel.org>
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





