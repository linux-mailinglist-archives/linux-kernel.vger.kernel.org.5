Return-Path: <linux-kernel+bounces-120893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62988E03F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FEE29FB92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4951145FED;
	Wed, 27 Mar 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfRjn+jr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2E145FE6;
	Wed, 27 Mar 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541512; cv=none; b=oGS9QHsyKLZ5GvVv1zrPtAml+MaBafcymcDVJNPbyjCD4YnjuQr2Gfc4whfnLsyKGiat8LucSl6dxj4OuluSVEHgdvj7F3VoCHZ2l3DS0DYBcUITXrfcykUV8cbwiBJ4GWfK6LK3W/2g8T7EgZKiWaDu0v6A77Vj3Z9rM0UqQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541512; c=relaxed/simple;
	bh=2Kr8PTdAZyAl58wBKC1+WWzJyamt4mSFZhFb+FpEWKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxqQd9q1tG7B6tS2mrSpL2XCeJU9F7KC0hL08kvdKt70zOtnXfHRtEjoKjMAL7pWg9f9BsCW1VzbF/bXyPGHhxbVIF34dtuV/IdiZhzLjYfmibmYm3d6eZ6VnAcTw/3aie5MVIwQcRzOLXXOB3qLriqwfCuSoIho1oSSeHP3oHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfRjn+jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59971C433C7;
	Wed, 27 Mar 2024 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541512;
	bh=2Kr8PTdAZyAl58wBKC1+WWzJyamt4mSFZhFb+FpEWKI=;
	h=From:To:Cc:Subject:Date:From;
	b=YfRjn+jrmTR5PgZG5ojtgO2Sk9HLJ/pNWc1xlMVxMQ+0IQXt4Wqf7YM2YZaEIKGE1
	 S30WJIOB29xAckDIMF4wPCyIJxbGlV8genrEHtM1vcOm3f8q1+1NUkI9u39kv7p3Jw
	 x0BE/raI8h/s7nGjbtL8gpx2GVFUYmUi4mLKFxLhV3E2bt6k7RxQZ5nMS/qTbJV2yi
	 EKNyncfXNmhm5sQ6W1WMZtbdnLVWVo2/XKvzVhg3XPvY/DN5YNkFP2SJVb1R0O+S0N
	 JkkOcCYq7bfJp0xaewkPbxz9o6hpznYmmyPMQ6iaNRgU/21VGpx0zhVgLAvIuQh8xl
	 vkLypcrfk5Kpw==
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
Subject: FAILED: Patch "drm/amd/display: Revert Remove pixle rate limit for subvp" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:11:50 -0400
Message-ID: <20240327121150.2829047-1-sashal@kernel.org>
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





