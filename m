Return-Path: <linux-kernel+bounces-121174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66888E322
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905C41C2867D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903E17D22E;
	Wed, 27 Mar 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvxUQF4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6717D223;
	Wed, 27 Mar 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542273; cv=none; b=F1+bR1qsFci99wW3aFz1ptKxliLvgf7Y8E3UtdwUyJRCKqUge5RA0ToNxFSFCWCcrPEz52Yku7fMrgjbQl9KrKbk635NclYmbX4BhEEawKk8mYt5dk1BGssEx4Bsyv2kbJlS9BW9PrO09gsOHVzzVgVWqKq/FJ+BIknFxgY0vjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542273; c=relaxed/simple;
	bh=ADQPzvOaXVjhUf4GjOq9t1hnKX5dHQyMDgapdqiwSLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpzk7lGNYFxGvLoCRAdK0hhAYvW+WjNSd+ssnVAjjluKp7H8S0cD2uuR/Rn0zsoj0uXOBKPlIy7gSd0DfyILjrXzF6+V76p4z2G6//jHHgC2s8f9B25r+pWbPQ7xO3GZ+1F0Iq0OtRFOF00gmagfKGjx1zoNlCzbbgWjWU7UjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvxUQF4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DE8C433C7;
	Wed, 27 Mar 2024 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542272;
	bh=ADQPzvOaXVjhUf4GjOq9t1hnKX5dHQyMDgapdqiwSLE=;
	h=From:To:Cc:Subject:Date:From;
	b=bvxUQF4zBdoChgLr2I1GCijMupsBWZzxo+/I3tsqIauhL1zn8pvX/YNluDY6jbthf
	 IZIbtxgrVgtB2CAMpEq+a+sGV0ujbfWFfPOLQfqKaG8JtAwArpaAxEC2UWn9H7n2F8
	 +Hy2q+iZKM1NnPTnAIDERibSfk3BNem7gEas1J7vKiBfgFjlMe6lxLphFdDCd5F76P
	 g7CCcwKlUfre1QmdYK/n3gwfRNPlvm3c/hvtBb6FZke60duHpAL0FRRGVF4Ez0I/qd
	 5xx1Mzu/5AmY2ODdaxvg/6kN1TdbRmN1Uq6dhdMlAfGbMHai0bN0OlXVIVMNjtRGqt
	 WBRpYUE44287Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	josip.pavic@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Allow dirty rects to be sent to dmub when abm is active" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:30 -0400
Message-ID: <20240327122430.2839466-1-sashal@kernel.org>
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

From 7fb19d9510937121a1f285894cffd30bc96572e3 Mon Sep 17 00:00:00 2001
From: Josip Pavic <josip.pavic@amd.com>
Date: Fri, 9 Feb 2024 16:05:18 -0500
Subject: [PATCH] drm/amd/display: Allow dirty rects to be sent to dmub when
 abm is active

[WHY]
It's beneficial for ABM to know when new frame data are available.

[HOW]
Add new condition to allow dirty rects to be sent to DMUB when ABM is
active. ABM will use this as a signal that a new frame has arrived.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5211c1c0f3c0c..613d09c42f3b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3270,6 +3270,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 	if (stream->link->replay_settings.config.replay_supported)
 		return true;
 
+	if (stream->ctx->dce_version >= DCN_VERSION_3_5 && stream->abm_level)
+		return true;
+
 	return false;
 }
 
-- 
2.43.0





