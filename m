Return-Path: <linux-kernel+bounces-120827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19E88DE87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29FE1F2434E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76384139594;
	Wed, 27 Mar 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLuY61H8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DC139590;
	Wed, 27 Mar 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541316; cv=none; b=eKwv9opTaGYtDkqmeE4URiiA+vkiiTVSIuqOWhRvAdnbmVDI86p+8NHCw64X/il7fy480nd/s062DqdK9TgsoRlM6U41uXdEFUG3AfcWnQ+xYkehSTwdaAJrkREmaLpaWmjUKJjmXHOi2TFYU6Il9I3D5ONhlxRZhgyrk/0bvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541316; c=relaxed/simple;
	bh=h2tgrs2uNgXzSXW5PHoTPUwhMpvafx50r23jrhrkiqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMyliWh7aR/dGGC5OXHA3JEKzvwrSXUj5LE2mXS22R353WSzZgTGEbsW6Y0yqdQH2LpglDQh9eyhtYjoqyIqc3Gh0nvLP6EJN/n6A1h1C0HD5+ZhUFRb65dO9hGdm/41uck46Eo1HoJ+CXna0o7EjVNgFsDrC4Xv7WGoNAByF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLuY61H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFF8C43143;
	Wed, 27 Mar 2024 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541316;
	bh=h2tgrs2uNgXzSXW5PHoTPUwhMpvafx50r23jrhrkiqE=;
	h=From:To:Cc:Subject:Date:From;
	b=aLuY61H8MrDkG277bA7k2UsD9NTvge+xt1jYUzeB9Ju08in63UzS5H/Lc6dqvmsOq
	 3xH+4XAfHb3AMJGimcTzxSUBdGqiRnN7Bd7nwE4/5YYCoFiVObpCFmcFnofshD+vB9
	 wQy5pra0DNT70rSwQMv7JTW4MguaQ4UjFcAJc/19obn9zWQ/2/ro80DuYfSJeAfxke
	 rwWFKpape62tCRNiQ99AJgJLFubLNSW1Wb0TPayZ0tVW/N/czc7yA1PMo4kupurrAU
	 blBqHxvc9qX5o4g5VRA8T9FK+4B+EY9l3zCSj/lOSKYd1NEbYm9Uln3xWp5VWuUxsf
	 n1m26mFxo40WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Martin Leung <martin.leung@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Revert Remove pixle rate limit for subvp" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:34 -0400
Message-ID: <20240327120834.2826317-1-sashal@kernel.org>
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

From cf8c498694a443e28dc1222f3ab94677114a4724 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Mon, 4 Mar 2024 11:20:27 -0500
Subject: [PATCH] drm/amd/display: Revert Remove pixle rate limit for subvp

This reverts commit 340383c734f8 ("drm/amd/display: Remove pixle rate
limit for subvp")

[why]
The original commit causes a regression when subvp is applied
on ODM required 8k60hz timing. The display shows black screen
on boot. The issue can be recovered with hotplug. It also causes
MPO to fail. We will temprarily revert this commit and investigate
the root cause further.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b49e1dc9d8ba5..a0a65e0991041 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -623,6 +623,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
+				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
 				(refresh_rate < 120 || dcn32_allow_subvp_high_refresh_rate(dc, context, pipe)) &&
-- 
2.43.0





