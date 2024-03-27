Return-Path: <linux-kernel+bounces-120865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B51D88DFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5941C26D67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59390130A59;
	Wed, 27 Mar 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEcrEYr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC8140373;
	Wed, 27 Mar 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541425; cv=none; b=la8COYgeweKF8/oCfEYWBHHdhxNyWGsTU9Etk0yYESZYVXJ8kswivjfwlKVU2/P1/MiAJvlvPPQbWl6jPvILch7hah3mtHd4zbddI5kS2iAfQ601JIFpYBq0aSl8nr4AaQ14C2a7aR+VG0Vygm5e4XvWQg1CwHdbn5kDkY0PSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541425; c=relaxed/simple;
	bh=a1I4hbTttO1K9D1ocO46/enq/86kw6OIeL8mO7NXWnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haL1JJ4FZkmmtar7gn2Bg/2V4XNRPmBNU07aFMaAv1ERH6z/71OTUtgFAbxdnXApY8g5Zr7RsDzyfC1n4rRWCdkfNBeHcBQb5ivwUfD9shLmK6f/h9j3LZnz/P595Fe37WdkvwCWBFfOlihJ7Z/VbMKDYKTGR532JB1pfQaC+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEcrEYr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1219FC433F1;
	Wed, 27 Mar 2024 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541425;
	bh=a1I4hbTttO1K9D1ocO46/enq/86kw6OIeL8mO7NXWnw=;
	h=From:To:Cc:Subject:Date:From;
	b=iEcrEYr98Wvx/fuBVkeeonkD9iltqZ274atkMlym6rxci2teevwrpQ2nlSCi9FzE0
	 jlx2Vvwg5AhbJeNuULTCxvlYd5ey6ZZoay6otomnLcyevP3gNn36XKCwt4ZEw0IE0H
	 xVZew8vDIjGX/SwIW80Y+SRoJwkaIGV5+/WcWSK4Jq+QDyFtVSE0k9eU1iQn0LHh5C
	 SCHehfYr7u/8pF7/S6RXkkBuH5S+0PalUEAT1P+r1Hoo7P86fs2qmYMNHg5+YTlux9
	 JIcHzMOdM9Fnz+9XlGzRtvXQTJ+/9+JMn3K3pdZ95ykM3WB22N+lMbDAPBrCsmNcbs
	 YKEDTbvmXaW6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	allen.pan@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add a dc_state NULL check in dc_state_release" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:22 -0400
Message-ID: <20240327121023.2827913-1-sashal@kernel.org>
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

From 334b56cea5d9df5989be6cf1a5898114fa70ad98 Mon Sep 17 00:00:00 2001
From: Allen Pan <allen.pan@amd.com>
Date: Fri, 23 Feb 2024 18:20:16 -0500
Subject: [PATCH] drm/amd/display: Add a dc_state NULL check in
 dc_state_release

[How]
Check wheather state is NULL before releasing it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 180ac47868c22..5cc7f8da209c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -334,7 +334,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_state_release(struct dc_state *state)
 {
-	kref_put(&state->refcount, dc_state_free);
+	if (state != NULL)
+		kref_put(&state->refcount, dc_state_free);
 }
 /*
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
-- 
2.43.0





