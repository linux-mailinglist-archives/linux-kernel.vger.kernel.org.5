Return-Path: <linux-kernel+bounces-120933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836788E0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA01C22102
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11997134412;
	Wed, 27 Mar 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS38X9Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627C133980;
	Wed, 27 Mar 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541623; cv=none; b=YBiO7zXEKBhH1dzbFwrLxQEtWA+16Dgj63hrXI/DEeOT6q+vxBaoq4h2JT/5ZlkIwIbTy86Y+CiBRiyCHxc1P6d3mdWFJC+Aphw2UigfhLlQUhh06lcEydTm4Bm4aDymHjaY7SnwPSMMmIyvR9HejVnPyK2LYXydIUzlV0uuQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541623; c=relaxed/simple;
	bh=Y18FNnOqkQYBQRmd78kjGtkBzjSbcChjSXW2ZoeRRzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuPcBd+vHXScvBW3NkUFUKoIDpygrvFB/FqaYzMWMxC3P10ytdOaTTJHpduTt7JMEXX0OlUe3O61uDRWU64e1X/8Je9wz0sPE7jwhO36daIyp1KEdHffGWF92+yoMPbF3AYj3RvHBQ9xV4RqhbirRccoiMTvP8wbIhTLsiR4nG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS38X9Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DCDC43390;
	Wed, 27 Mar 2024 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541623;
	bh=Y18FNnOqkQYBQRmd78kjGtkBzjSbcChjSXW2ZoeRRzw=;
	h=From:To:Cc:Subject:Date:From;
	b=BS38X9DnlRnKUva83b1d2lR08in3fldJBo8SxDO1HT0AbyF4gFskJ78vJeONW0fxo
	 Fvidr7NlmlKUq59YhPPdirZvIrOwVEYP+ssc8NzlCAaRxXobw9q3QbQDiG2/C4HcIM
	 e9C8A0ugHG1jE7nScYcZ6pq/RpgOWep7BO1mo7A8PI/RiexyTaEgXSKikOKvdHgQZH
	 I0F9KKrB3BKwB1YZRoeIx8Df28WFDfNVFLqBEtMqlvM19QRdxUPgk6x/COssT8LrME
	 +H5FefiRcbuat39FJmrH2oOiNjbEW4uunwImb+BQYoeUmdwXINI4XnD0YZbi4Lzefj
	 HGUT1LSqD/Fhg==
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
Subject: FAILED: Patch "dm-raid: really frozen sync_thread during suspend" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:40 -0400
Message-ID: <20240327121341.2830534-1-sashal@kernel.org>
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





