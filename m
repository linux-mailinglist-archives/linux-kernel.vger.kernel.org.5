Return-Path: <linux-kernel+bounces-121259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B088E578
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05D3B30B83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781A1B48B5;
	Wed, 27 Mar 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liz27+3F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638221B48A3;
	Wed, 27 Mar 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542483; cv=none; b=GZjh9aig+LcsWQ/PIG5S856Nq3Q6siV07d/GDnr5zeHXlvgaQy1xMae7e5FEVjaKk7rjLl0eqnd7j8H0fLXai9g+B4hCNXncA25XQaeDc1gOwg5mryn50lsBOu57h8sN5dtAhXO4cgHNvHan+j5Z0tHeWzOMLQx1IuJQjIghlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542483; c=relaxed/simple;
	bh=tAuTV6LSJ2JopxHyNQ68pJxS6L8HMX+vlbwqZUqaZzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUGWZnsZiH7PW0YWj2SmrlLJxjDursR3oE6nfkSz+WqbmR+TDel7smDxA0XEsxuY31/N8lAXBkALXIt37e3EgjqUASG7WLlcWzGJj6yLdsA663akTdelC1IBmni9ygDIc2g0Mk6S/lwfcZlSUUt9i7eSojj0+KAoygPr7Dbkem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liz27+3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F796C43394;
	Wed, 27 Mar 2024 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542483;
	bh=tAuTV6LSJ2JopxHyNQ68pJxS6L8HMX+vlbwqZUqaZzc=;
	h=From:To:Cc:Subject:Date:From;
	b=liz27+3FvLoPKxF/C5Qan6ViCjj1kTJdkQ/lSglO3ibXKfESY4RBD3JDFPfJdOLWj
	 bl/zEFDlbZQ9ivWMqbkrka0e7GFekfJDBD4mfZhiLRPJ4023GpC8kPux6vNyvOEcFP
	 LG2VrIjvmH5QYQjxd9+T3feA15PPv0WPKaO4lzOD1Yo5uRC5B4OkaFIUZ+L+IlELmS
	 ZlV90LXvnReq/g+AeNNt6Lu7Izn+ZXY76ZziUlQgejnh/CdpynIgCLGdF0o5IncLec
	 zdGZg6cq4fZI+qkDzK5NxpSBQ6ZMDZlXOLNe5PYpKcAfBX8B2BY4e4cSut2XZ5/Yhl
	 5VTb3JNLMJb6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yukuai3@huawei.com
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Xiao Ni <xni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Song Liu <song@kernel.org>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: FAILED: Patch "dm-raid: really frozen sync_thread during suspend" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:00 -0400
Message-ID: <20240327122801.2842406-1-sashal@kernel.org>
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

From 16c4770c75b1223998adbeb7286f9a15c65fba73 Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Tue, 5 Mar 2024 15:23:02 +0800
Subject: [PATCH] dm-raid: really frozen sync_thread during suspend

1) commit f52f5c71f3d4 ("md: fix stopping sync thread") remove
   MD_RECOVERY_FROZEN from __md_stop_writes() and doesn't realize that
   dm-raid relies on __md_stop_writes() to frozen sync_thread
   indirectly. Fix this problem by adding MD_RECOVERY_FROZEN in
   md_stop_writes(), and since stop_sync_thread() is only used for
   dm-raid in this case, also move stop_sync_thread() to
   md_stop_writes().
2) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is frozen,
   it only prevent new sync_thread to start, and it can't stop the
   running sync thread; In order to frozen sync_thread, after seting the
   flag, stop_sync_thread() should be used.
3) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped, use
   it as condition for md_stop_writes() in raid_postsuspend() doesn't
   look correct. Consider that reentrant stop_sync_thread() do nothing,
   always call md_stop_writes() in raid_postsuspend().
4) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime,
   and if MD_RECOVERY_FROZEN is cleared while the array is suspended,
   new sync_thread can start unexpected. Fix this by disallow
   raid_message() to change sync_thread status during suspend.

Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread"), the
test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thread(),
and with previous fixes, the test won't hang there anymore, however, the
test will still fail and complain that ext4 is corrupted. And with this
patch, the test won't hang due to stop_sync_thread() or fail due to ext4
is corrupted anymore. However, there is still a deadlock related to
dm-raid456 that will be fixed in following patches.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com/
Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_stop_writes()")
Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240305072306.2562024-6-yukuai1@huaweicloud.com
---
 drivers/md/dm-raid.c | 25 +++++++++++++++----------
 drivers/md/md.c      |  3 ++-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index eb009d6bb03a1..e2d7a73c0f874 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.ro = 1;
 	rs->md.in_sync = 1;
 
-	/* Keep array frozen until resume. */
-	set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
-
 	/* Has to be held on running the array */
 	mddev_suspend_and_lock_nointr(&rs->md);
+
+	/* Keep array frozen until resume. */
+	md_frozen_sync_thread(&rs->md);
+
 	r = md_run(&rs->md);
 	rs->md.in_sync = 0; /* Assume already marked dirty */
 	if (r) {
@@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
+	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+		return -EBUSY;
+
 	if (!strcasecmp(argv[0], "frozen"))
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	else
@@ -3796,10 +3800,11 @@ static void raid_postsuspend(struct dm_target *ti)
 	struct raid_set *rs = ti->private;
 
 	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
-		/* Writes have to be stopped before suspending to avoid deadlocks. */
-		if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
-			md_stop_writes(&rs->md);
-
+		/*
+		 * sync_thread must be stopped during suspend, and writes have
+		 * to be stopped before suspending to avoid deadlocks.
+		 */
+		md_stop_writes(&rs->md);
 		mddev_suspend(&rs->md, false);
 	}
 }
@@ -4012,8 +4017,6 @@ static int raid_preresume(struct dm_target *ti)
 	}
 
 	/* Check for any resize/reshape on @rs and adjust/initiate */
-	/* Be prepared for mddev_resume() in raid_resume() */
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		mddev->resync_min = mddev->recovery_cp;
@@ -4055,10 +4058,12 @@ static void raid_resume(struct dm_target *ti)
 		if (mddev->delta_disks < 0)
 			rs_set_capacity(rs);
 
+		WARN_ON_ONCE(!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery));
+		WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
 		mddev_lock_nointr(mddev);
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		mddev->ro = 0;
 		mddev->in_sync = 0;
+		md_unfrozen_sync_thread(mddev);
 		mddev_unlock_and_resume(mddev);
 	}
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 55ecc05c17c65..167db77442392 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6364,7 +6364,6 @@ static void md_clean(struct mddev *mddev)
 
 static void __md_stop_writes(struct mddev *mddev)
 {
-	stop_sync_thread(mddev, true, false);
 	del_timer_sync(&mddev->safemode_timer);
 
 	if (mddev->pers && mddev->pers->quiesce) {
@@ -6389,6 +6388,8 @@ static void __md_stop_writes(struct mddev *mddev)
 void md_stop_writes(struct mddev *mddev)
 {
 	mddev_lock_nointr(mddev);
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
 	__md_stop_writes(mddev);
 	mddev_unlock(mddev);
 }
-- 
2.43.0





