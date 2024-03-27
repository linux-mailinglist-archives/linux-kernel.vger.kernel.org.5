Return-Path: <linux-kernel+bounces-121212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804288E3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B41F2ED0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AD188A6F;
	Wed, 27 Mar 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHQgX0Y7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C0187E95;
	Wed, 27 Mar 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542360; cv=none; b=F14cTtLtiyos3ZSWu3LDD5zBKw00w5Gb43YWoK0Te9/Dwvcxaa2ets1ZggbGklSIQrZMmrDGVB2CuTInJ1ZyC2MDMZzkg8ufzQuABSlYskiH/Lb3JqGjajLol8x2oTzNPuKnbIaz58ysd58uHUMCJlJ0HVhW10ao1ja0ztnGCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542360; c=relaxed/simple;
	bh=Z5vUmkS8hfQIbMpayfKcdT4YraA68Xmvs3u64CLWPas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2/jhkzBlp/Gh3S/TsYnTTRAcJE2LASING+4QLv6RIgwxgY/MmFcMWL8t2XLwQjk7dgyQVArEqwQ7pkIucSO7A2p9dGW4L7wtgMAmvWYJjfu1IVYZUgzzZg6VCi1z3Cy06t1SB2JHHXXb0mI5IhbJbhNLx0QbFQu3IYKseMKUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHQgX0Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C31FC433C7;
	Wed, 27 Mar 2024 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542359;
	bh=Z5vUmkS8hfQIbMpayfKcdT4YraA68Xmvs3u64CLWPas=;
	h=From:To:Cc:Subject:Date:From;
	b=bHQgX0Y7lKFVMu55DL8mI5dgnf27tDn/iZYwQhf5WqGROPDM8PRkn6Me7POsSDloP
	 XkfvY+S+c7zyZ9gA4pivm2KxkGfJQl/bwQfWH13gSrkL6ezoxPS9HWEUNep2huiWH9
	 NixG6/N1HNxzBmS6yhmcZ+J4ehybPwrFF6iIX8BwAJIr1L8i/hey5KYnr/t73rmKef
	 R6FudNEvdnebtuUm+0260JLzEGw5aFKOarFpyIe2a91BSvjuA7i+aa3vqqQWEEozwz
	 MyXpwK7MS6Vnstn4NB0mXodR1DH6yhBVxILBLRxZKw0VMQITTAzE9PohkqhUQUX6Dn
	 IHvPLllv7u4aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yukuai3@huawei.com
Cc: Xiao Ni <xni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Song Liu <song@kernel.org>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "md/dm-raid: don't call md_reap_sync_thread() directly" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:57 -0400
Message-ID: <20240327122558.2840700-1-sashal@kernel.org>
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

From cd32b27a66db8776d8b8e82ec7d7dde97a8693b0 Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Tue, 5 Mar 2024 15:23:03 +0800
Subject: [PATCH] md/dm-raid: don't call md_reap_sync_thread() directly

Currently md_reap_sync_thread() is called from raid_message() directly
without holding 'reconfig_mutex', this is definitely unsafe because
md_reap_sync_thread() can change many fields that is protected by
'reconfig_mutex'.

However, hold 'reconfig_mutex' here is still problematic because this
will cause deadlock, for example, commit 130443d60b1b ("md: refactor
idle/frozen_sync_thread() to fix deadlock").

Fix this problem by using stop_sync_thread() to unregister sync_thread,
like md/raid did.

Fixes: be83651f0050 ("DM RAID: Add message/status support for changing sync action")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240305072306.2562024-7-yukuai1@huaweicloud.com
---
 drivers/md/dm-raid.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index e2d7a73c0f874..47c4b1b6e532a 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3719,6 +3719,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 {
 	struct raid_set *rs = ti->private;
 	struct mddev *mddev = &rs->md;
+	int ret = 0;
 
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
@@ -3726,17 +3727,24 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
 		return -EBUSY;
 
-	if (!strcasecmp(argv[0], "frozen"))
-		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	else
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (!strcasecmp(argv[0], "frozen")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
 
-	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
-		if (mddev->sync_thread) {
-			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_reap_sync_thread(mddev);
-		}
-	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
+		md_frozen_sync_thread(mddev);
+		mddev_unlock(mddev);
+	} else if (!strcasecmp(argv[0], "idle")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
+
+		md_idle_sync_thread(mddev);
+		mddev_unlock(mddev);
+	}
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
 		return -EBUSY;
 	else if (!strcasecmp(argv[0], "resync"))
 		; /* MD_RECOVERY_NEEDED set below */
-- 
2.43.0





