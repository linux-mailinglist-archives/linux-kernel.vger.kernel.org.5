Return-Path: <linux-kernel+bounces-121275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1288E497
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7DA1C29CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792C1BB071;
	Wed, 27 Mar 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s07z12DL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B11BB066;
	Wed, 27 Mar 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542530; cv=none; b=D1L7AwqK9m06azqd9E86dA7Q78a/67aFsOitF7n5+t9ovDTZsE+dwJefENxwD+C7J8OtRoL0w8xkvBzhTbkw7Y5bbpmHLwcvAbft/8ylsiQbzhCrZeOpK40hCJcp+BVx3oKcGbw/dYgtflL3JUL0gmgXwYlA4X35KQB+Upw16rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542530; c=relaxed/simple;
	bh=GKnDNnS4DmpxxaSXiDyxHR3YKPspPG25hkQy2T/vBPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STgwHxbb+azG19eJRBkNg5PDs4JC7kU/IOp/OBue2ZEtqtV4hKjApaThrNcg38VhoLTRDuOFMWtQnimc2h4zBYqsqUlIfOaWLS277ISHBXOWQ4/ovMg1mpAELJyzZQgUrslwtGBgkTv0484o0moelspr5HnKQqa3OsSKrq//v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s07z12DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA7C433C7;
	Wed, 27 Mar 2024 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542530;
	bh=GKnDNnS4DmpxxaSXiDyxHR3YKPspPG25hkQy2T/vBPA=;
	h=From:To:Cc:Subject:Date:From;
	b=s07z12DLnPlqSZy0dcx55sGmYHyjw3jFEMq1l30mFNYL//WYWUqu0XOU/iHb0M8sN
	 WnkmjGdsehrKStpGWXzql/qb8Ap6c2rhp3vWKMGhc8in63mU9M6rssQVeWIi0TVfkf
	 640sLc/CxZDvHpwrUbdIO8Unt2TQWbR84sNhPyeOR0T4A4Xt7dMyItvcE3dNkuNJgH
	 w+dtR9t/rTLKh4QbVdcSbie9bOirImatPq9NSdOLfh1NgrKd2qGrGkbKfJDAz+cSS9
	 KTQqzW2oEyyIbJTmECu0iP04/QNywVximQusCxTxasbRFXjs3S0JkkF07c4t7xL2wh
	 U2ACrsMibRk6w==
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
Subject: FAILED: Patch "drm/amd/display: Align the returned error code with legacy DP" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:48 -0400
Message-ID: <20240327122848.2843053-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





