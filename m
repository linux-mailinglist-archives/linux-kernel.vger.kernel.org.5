Return-Path: <linux-kernel+bounces-120943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3850988E0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FCBB29678
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960691369A3;
	Wed, 27 Mar 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV+XS/B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73913699F;
	Wed, 27 Mar 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541654; cv=none; b=sgx8FPOoHetS4YfU+B1DQWc1Kelqf1xfvVdR0/wSVLvY4gy6NHo0E50WLpZ4I8GUeDlt2jUxo+sE+k/o/xk3rJm/3hvSzpk6UV61X/b/bFS7glCsKDqmGMQIcQsq5dNWpolpOOGeaViSzcjb0XeeyFcVQ77M2nuOdZAQos5frOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541654; c=relaxed/simple;
	bh=AolUbv574hiscVqKWm5EVbmKwv0JDOxa1vBJ8eh/0kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB9uSTGABZNsHme6BzxBplnkz2wnnHgNLi/oCGXe4xlCZ2r5GQvdWDqZOdW0zV6VOg+gQelluwnrO4zBbBvqEn/WYoqyzEM6U8HHjsw/qAbJGLOqBFLuHAqR3urnlhnTH/mu04xOyXbDIzNoS65SpZTEdtnsGMgRo6YtcYwPLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV+XS/B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776D3C433F1;
	Wed, 27 Mar 2024 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541653;
	bh=AolUbv574hiscVqKWm5EVbmKwv0JDOxa1vBJ8eh/0kg=;
	h=From:To:Cc:Subject:Date:From;
	b=bV+XS/B626Z+S/z2fIm1MdrT6TDAXlWUZZmwLTMKP27yPVJv7NsLzg/9ITAE9oulm
	 /yt333JbU5KC3ofY1YwnbGgvxLo6wJnmyNbdSIG9pwWnLDlGJ4GkH4dI4LU+n38JmR
	 iHabBGnhzZi4rdyruCf7/lSvvRCp+giwzG2MkNtQYlhGHPw9gX6TgvRp2PDdHTkR+R
	 9KN0jo+bBOxNDDvQEe5Gbol/ha3eJM0QegcRgqQNju3ClOgjrtr1BpPc+fKisczaJT
	 1JHVpdlmoi4GSP6IYhpZmgbx/GgUeu9dvZYgiowzSMn9hfBtI/AV7bJYRWFbMcCfGG
	 +yp9YuO4Vt1jA==
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
Subject: FAILED: Patch "drm/amd/display: Align the returned error code with legacy DP" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:14:11 -0400
Message-ID: <20240327121411.2830921-1-sashal@kernel.org>
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





