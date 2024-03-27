Return-Path: <linux-kernel+bounces-120821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990688DE53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57AA2989E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DA137C38;
	Wed, 27 Mar 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ5U0qdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABA137C30;
	Wed, 27 Mar 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541299; cv=none; b=o5VzOESqDZlOKMmTsFstSyE9HpvjD3AeDmxhs+prXb8FtHbmtvoSdL1unkf8I6/s4PRlG1O1LgM+FQ89FxtqTj3PUyjenFv/hnTMkTaaKlJ4RGU7T4gfozC7YUuI8/AtJ1wAJXqtK2IavNz5IvLxrgqfom5BwU4HJaMFtBsaYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541299; c=relaxed/simple;
	bh=o2jl+DOgHAxIMe3E9PEMDyJqKN7SCl1t/32FlL9O1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1kFYRKfqy9LlmfH2ajHcfr4mP6ZImTwDAbmcgQrVjMSPN0k63L9zY9fEFu8b6DtUchtKZwnIq0PEvWTx46+9MS7y6bKMQd+c4dhCkFlEx7fQnXMnH+BnOgamsadzVPVnsjADgdUjy7B02QmwYTas8zmheMhBeH9WaGdiNCzbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ5U0qdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C4EC43390;
	Wed, 27 Mar 2024 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541298;
	bh=o2jl+DOgHAxIMe3E9PEMDyJqKN7SCl1t/32FlL9O1Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=jQ5U0qdvN99g1LNbde9GBB7aa53qwfMq+6WDZCK+8aiN0AO3In6vFJK4RyHNtg31X
	 2cC4D7MZhVkVBshuLiezKeSd7EUkVZXuG68NxQjl3k2besQBX/4NNx+hNfQO7+4Lxf
	 jqLw+UKxJzdePoQkgrFAYqBqQPcyQpmtAExS1cZtG78DMgU7FKwiDizT3kvJio/Aco
	 yzGajm5ZthFuPNJU4TXoropTdbS5CiqiIOE5BGftPSnM4CeNUeMp24VdUw4k63sPHJ
	 WClTjb/xAVEb6VX3miHihaOlPthw1He0VqaWR/4V8MJ8uYsr+fhZwBjygIuP5NWjVq
	 k4IP2Z9YEWOQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jerry.zuo@amd.com
Cc: Wayne Lin <wayne.lin@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Fix MST Null Ptr for RV" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:08:16 -0400
Message-ID: <20240327120816.2826066-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1b5b72b4d67c1e72c4fc19151fd669acecc92faa Mon Sep 17 00:00:00 2001
From: Fangzhi Zuo <jerry.zuo@amd.com>
Date: Mon, 22 Jan 2024 13:43:46 -0500
Subject: [PATCH] drm/amd/display: Fix MST Null Ptr for RV

The change try to fix below error specific to RV platform:

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 4 PID: 917 Comm: sway Not tainted 6.3.9-arch1-1 #1 124dc55df4f5272ccb409f39ef4872fc2b3376a2
Hardware name: LENOVO 20NKS01Y00/20NKS01Y00, BIOS R12ET61W(1.31 ) 07/28/2022
RIP: 0010:drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper]
Code: 01 00 00 48 8b 85 60 05 00 00 48 63 80 88 00 00 00 3b 43 28 0f 8d 2e 01 00 00 48 8b 53 30 48 8d 04 80 48 8d 04 c2 48 8b 40 18 <48> 8>
RSP: 0018:ffff960cc2df77d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8afb87e81280 RCX: 0000000000000224
RDX: ffff8afb9ee37c00 RSI: ffff8afb8da1a578 RDI: ffff8afb87e81280
RBP: ffff8afb83d67000 R08: 0000000000000001 R09: ffff8afb9652f850
R10: ffff960cc2df7908 R11: 0000000000000002 R12: 0000000000000000
R13: ffff8afb8d7688a0 R14: ffff8afb8da1a578 R15: 0000000000000224
FS:  00007f4dac35ce00(0000) GS:ffff8afe30b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010ddc6000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? plist_add+0xbe/0x100
 ? exc_page_fault+0x7c/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper 0e67723696438d8e02b741593dd50d80b44c2026]
 ? drm_dp_atomic_find_time_slots+0x28/0x260 [drm_display_helper 0e67723696438d8e02b741593dd50d80b44c2026]
 compute_mst_dsc_configs_for_link+0x2ff/0xa40 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 ? fill_plane_buffer_attributes+0x419/0x510 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 compute_mst_dsc_configs_for_state+0x1e1/0x250 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 amdgpu_dm_atomic_check+0xecd/0x1190 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 drm_atomic_check_only+0x5c5/0xa40
 drm_mode_atomic_ioctl+0x76e/0xbc0
 ? _copy_to_user+0x25/0x30
 ? drm_ioctl+0x296/0x4b0
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 drm_ioctl_kernel+0xcd/0x170
 drm_ioctl+0x26d/0x4b0
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 amdgpu_drm_ioctl+0x4e/0x90 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x60/0x90
 ? do_syscall_64+0x6c/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f4dad17f76f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c>
RSP: 002b:00007ffd9ae859f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000055e255a55900 RCX: 00007f4dad17f76f
RDX: 00007ffd9ae85a90 RSI: 00000000c03864bc RDI: 000000000000000b
RBP: 00007ffd9ae85a90 R08: 0000000000000003 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c03864bc
R13: 000000000000000b R14: 000055e255a7fc60 R15: 000055e255a01eb0
 </TASK>
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm cmac algif_hash algif_skcipher af_alg joydev mousedev bnep >
 typec libphy k10temp ipmi_msghandler roles i2c_scmi acpi_cpufreq mac_hid nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_mas>
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper]
Code: 01 00 00 48 8b 85 60 05 00 00 48 63 80 88 00 00 00 3b 43 28 0f 8d 2e 01 00 00 48 8b 53 30 48 8d 04 80 48 8d 04 c2 48 8b 40 18 <48> 8>
RSP: 0018:ffff960cc2df77d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8afb87e81280 RCX: 0000000000000224
RDX: ffff8afb9ee37c00 RSI: ffff8afb8da1a578 RDI: ffff8afb87e81280
RBP: ffff8afb83d67000 R08: 0000000000000001 R09: ffff8afb9652f850
R10: ffff960cc2df7908 R11: 0000000000000002 R12: 0000000000000000
R13: ffff8afb8d7688a0 R14: ffff8afb8da1a578 R15: 0000000000000224
FS:  00007f4dac35ce00(0000) GS:ffff8afe30b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010ddc6000 CR4: 00000000003506e0

With a second DP monitor connected, drm_atomic_state in dm atomic check
sequence does not include the connector state for the old/existing/first
DP monitor. In such case, dsc determination policy would hit a null ptr
when it tries to iterate the old/existing stream that does not have a
valid connector state attached to it. When that happens, dm atomic check
should call drm_atomic_get_connector_state for a new connector state.
Existing dm has already done that, except for RV due to it does not have
official support of dsc where .num_dsc is not defined in dcn10 resource
cap, that prevent from getting drm_atomic_get_connector_state called.
So, skip dsc determination policy for ASICs that don't have DSC support.

Cc: stable@vger.kernel.org # 6.1+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2314
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fe8dc6536966..b7a717c3682f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10859,11 +10859,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
-		if (ret) {
-			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
-			ret = -EINVAL;
-			goto fail;
+		if (dc_resource_is_dsc_encoding_supported(dc)) {
+			ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
+			if (ret) {
+				DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+				ret = -EINVAL;
+				goto fail;
+			}
 		}
 
 		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
-- 
2.43.0





