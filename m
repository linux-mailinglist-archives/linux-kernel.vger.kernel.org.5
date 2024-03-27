Return-Path: <linux-kernel+bounces-121181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A088E334
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660D31F2D992
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CE417EB98;
	Wed, 27 Mar 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozYS4Thf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1517EB89;
	Wed, 27 Mar 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542292; cv=none; b=VLu+OBbeMU6N4qOOqsL75q1MpNb+5HCl4W4IYQdetxU2gS+0GQMQxr4q3j6aPuX7KoD7wzPZ6f5jZA/wmMbYvkO7l2yGmyItMF4a89elE86OE/hJJ5oUmhT5nEfZqKrFAcwlk7m9l0oaAHxsiypVJp9WOATx3LDXO72XvUGb6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542292; c=relaxed/simple;
	bh=+Y1RzOaKe85t4i83uukvnH77D4CLGHFg9O5hUF9UOa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqWzp+qUtCu0FHS58q0rEyF4K3qsgbwJ1zNTmpJQw9NdA7IsuvB7Y+8BTyXi746LjNt+fj/O/642ucf4sxDBmc0yNHlI3M5fWaLOqmB17nc3+CGNTO1ZFEwqQ5v9hDZ8tfydDpFxihSgQrEXY3dASVxgPgsLbhy5Aw4SnFTBIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozYS4Thf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E4BC43390;
	Wed, 27 Mar 2024 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542292;
	bh=+Y1RzOaKe85t4i83uukvnH77D4CLGHFg9O5hUF9UOa8=;
	h=From:To:Cc:Subject:Date:From;
	b=ozYS4Thf3X2JK2rhL+ZkBggDMpYd/527DNsYvtcG8yEXkThBk6FPIPLFsmEBTIrHh
	 yaqg9VFVJzdUelN8U0WV5nAX9a6aYsMlPLDmC24t29ofFJWPMzd979M4WUUFhMkGOU
	 8S22D0yTkZdPoPwZh+Y8+BBPecOhdsq9YhYZaaizkidqhu1Tas5maJWOqarUrNQBF4
	 DTGdji9MvyID02wjkq89VjcVnqbp36JhuafLYnvRHGiHg4JbdKHcRIlfjc/XtM2mkg
	 FAiVzFt/Gg12EbRbLvHrbQdUlchaW6LKPWToq3Gqt+pjnGFe7vkvTAjaY5Ib7dZhfN
	 FH4TiutDmAFeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Wayne.Lin@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Align the returned error code with legacy DP" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:24:50 -0400
Message-ID: <20240327122450.2839728-1-sashal@kernel.org>
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

From 3b84525544be4ca0481110263a6d73eb00741cf3 Mon Sep 17 00:00:00 2001
From: Wayne Lin <Wayne.Lin@amd.com>
Date: Tue, 2 Jan 2024 14:20:37 +0800
Subject: [PATCH] drm/amd/display: Align the returned error code with legacy DP

[Why]
For usb4 connector, AUX transaction is handled by dmub utilizing a differnt
code path comparing to legacy DP connector. If the usb4 DP connector is
disconnected, AUX access will report EBUSY and cause igt@kms_dp_aux_dev
fail.

[How]
Align the error code with the one reported by legacy DP as EIO.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index eaf8d9f482446..85b7f58a7f35a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -979,6 +979,11 @@ int dm_helper_dmub_aux_transfer_sync(
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
+	if (!link->hpd_status) {
+		*operation_result = AUX_RET_ERROR_HPD_DISCON;
+		return -1;
+	}
+
 	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload,
 			operation_result);
 }
-- 
2.43.0





