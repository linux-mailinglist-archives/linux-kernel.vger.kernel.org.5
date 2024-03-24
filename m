Return-Path: <linux-kernel+bounces-113639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA30888E34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645351F2F1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC91839E2;
	Sun, 24 Mar 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChUnC/Ho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB52811F9;
	Sun, 24 Mar 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320553; cv=none; b=LPgsodBVg2oePqS4P5oeXEoeUKArgyKsXfy+1l3eZOkyJD1tcOpl6MEGzd4XWI3DBzEM+77Ssy9ZS/4a4Qyh7vj7MmdHb8TKhAsb3jBPj7tSb5BI/7ZVepL6EMadqXz72i88RZwJO8QTNErQr4dzj+eDDcIK3fEMKCx9GncSaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320553; c=relaxed/simple;
	bh=yVUsKV4jgxvtvm1H6E8T9TK0qKFypGddsw3+FQLzm+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hefjqB7FEQx7fTqHJdAHQRjm6QtSRnOHeEpdZPej91q5FfFyc/MAbctupzJKO/3sJdC1kf3pzCWHk1JIYLIgZ1JmQLz3TSD78PawqAA6AUnVEMBEjdoJ0QrCVFZzIaVpilD9hyA0TMbPPXo938IljOQarEuZnVXaSm4ImezncwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChUnC/Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10787C43394;
	Sun, 24 Mar 2024 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320551;
	bh=yVUsKV4jgxvtvm1H6E8T9TK0qKFypGddsw3+FQLzm+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChUnC/HoTmVmlLpQW1vULMR1Mi9Xfx3yxf1TgY5gjkPyMqIpcUaZ3QpysZiLf3bn4
	 7JSLvLKzb1by3tipCi0I7M3/JVT5VBUMPAHUdTcLW8FdtaffAweCMJrmo18g+mg6D9
	 E3vi/iJrwWQp9CZ7veQNNsiBOJnLxDIYNFWhY8Xw2QQu9u4p72smatfiZXhiMFUpdE
	 pjRJ3G1gJMsWuNrA3uZwKrAPCeH1X3se0fWYbFT6jraqaXXpPhUEMKsl91sPP/wkOl
	 X4Iou8EO930RK229U5ZyeH1ZlT1MJYRR/Th8Ato1fd+oAl4njrKp6Fa02K5cXyHUYy
	 pWqHPCIkdP+cQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 112/713] md: remove flag RemoveSynchronized
Date: Sun, 24 Mar 2024 18:37:18 -0400
Message-ID: <20240324224720.1345309-113-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit c891f1fd90e66e584bb1353e1859cef7c9eb36f8 ]

rcu is not used correctly here, because synchronize_rcu() is called
before replacing old value, for example:

remove_and_add_spares   // other path
 synchronize_rcu
 // called before replacing old value
 set_bit(RemoveSynchronized)
                        rcu_read_lock()
                        rdev = conf->mirros[].rdev
 pers->hot_remove_disk
  conf->mirros[].rdev = NULL;
  if (!test_bit(RemoveSynchronized))
   synchronize_rcu
   /*
    * won't be called, and won't wait
    * for concurrent readers to be done.
    */
                        // access rdev after remove_and_add_spares()
                        rcu_read_unlock()

Fortunately, there is a separate rcu protection to prevent such rdev
to be freed:

md_kick_rdev_from_array		//other path
				rcu_read_lock()
				rdev = conf->mirros[].rdev
list_del_rcu(&rdev->same_set)

				rcu_read_unlock()
				/*
				 * rdev can be removed from conf, but
				 * rdev won't be freed.
				 */
synchronize_rcu()
free rdev

Hence remove this useless flag and prepare to remove rcu protection to
access rdev from 'conf'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20231125081604.3939938-2-yukuai1@huaweicloud.com
Stable-dep-of: 257ac239ffcf ("md/raid1: fix choose next idle in read_balance()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-multipath.c |  9 ---------
 drivers/md/md.c           | 37 ++++++-------------------------------
 drivers/md/md.h           |  5 -----
 drivers/md/raid1.c        |  9 ---------
 drivers/md/raid10.c       |  9 ---------
 drivers/md/raid5.c        |  9 ---------
 6 files changed, 6 insertions(+), 72 deletions(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index d22276870283d..aa77133f31887 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -258,15 +258,6 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 			goto abort;
 		}
 		p->rdev = NULL;
-		if (!test_bit(RemoveSynchronized, &rdev->flags)) {
-			synchronize_rcu();
-			if (atomic_read(&rdev->nr_pending)) {
-				/* lost the race, try later */
-				err = -EBUSY;
-				p->rdev = rdev;
-				goto abort;
-			}
-		}
 		err = md_integrity_register(mddev);
 	}
 abort:
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b2f27ac51bfb6..99b60d37114c4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9314,44 +9314,19 @@ static int remove_and_add_spares(struct mddev *mddev,
 	struct md_rdev *rdev;
 	int spares = 0;
 	int removed = 0;
-	bool remove_some = false;
 
 	if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		/* Mustn't remove devices when resync thread is running */
 		return 0;
 
 	rdev_for_each(rdev, mddev) {
-		if ((this == NULL || rdev == this) &&
-		    rdev->raid_disk >= 0 &&
-		    !test_bit(Blocked, &rdev->flags) &&
-		    test_bit(Faulty, &rdev->flags) &&
-		    atomic_read(&rdev->nr_pending)==0) {
-			/* Faulty non-Blocked devices with nr_pending == 0
-			 * never get nr_pending incremented,
-			 * never get Faulty cleared, and never get Blocked set.
-			 * So we can synchronize_rcu now rather than once per device
-			 */
-			remove_some = true;
-			set_bit(RemoveSynchronized, &rdev->flags);
-		}
-	}
-
-	if (remove_some)
-		synchronize_rcu();
-	rdev_for_each(rdev, mddev) {
-		if ((this == NULL || rdev == this) &&
-		    (test_bit(RemoveSynchronized, &rdev->flags) ||
-		     rdev_removeable(rdev))) {
-			if (mddev->pers->hot_remove_disk(
-				    mddev, rdev) == 0) {
-				sysfs_unlink_rdev(mddev, rdev);
-				rdev->saved_raid_disk = rdev->raid_disk;
-				rdev->raid_disk = -1;
-				removed++;
-			}
+		if ((this == NULL || rdev == this) && rdev_removeable(rdev) &&
+		    !mddev->pers->hot_remove_disk(mddev, rdev)) {
+			sysfs_unlink_rdev(mddev, rdev);
+			rdev->saved_raid_disk = rdev->raid_disk;
+			rdev->raid_disk = -1;
+			removed++;
 		}
-		if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
-			clear_bit(RemoveSynchronized, &rdev->flags);
 	}
 
 	if (removed && mddev->kobj.sd)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index ade83af123a22..8d881cc597992 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -190,11 +190,6 @@ enum flag_bits {
 				 * than other devices in the array
 				 */
 	ClusterRemove,
-	RemoveSynchronized,	/* synchronize_rcu() was called after
-				 * this device was known to be faulty,
-				 * so it is safe to remove without
-				 * another synchronize_rcu() call.
-				 */
 	ExternalBbl,            /* External metadata provides bad
 				 * block management for a disk
 				 */
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e138922d51292..6bd42ccbea9c4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1863,15 +1863,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 			goto abort;
 		}
 		p->rdev = NULL;
-		if (!test_bit(RemoveSynchronized, &rdev->flags)) {
-			synchronize_rcu();
-			if (atomic_read(&rdev->nr_pending)) {
-				/* lost the race, try later */
-				err = -EBUSY;
-				p->rdev = rdev;
-				goto abort;
-			}
-		}
 		if (conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b7b0a573e7f8b..6e828a6aa0b0a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2247,15 +2247,6 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		goto abort;
 	}
 	*rdevp = NULL;
-	if (!test_bit(RemoveSynchronized, &rdev->flags)) {
-		synchronize_rcu();
-		if (atomic_read(&rdev->nr_pending)) {
-			/* lost the race, try later */
-			err = -EBUSY;
-			*rdevp = rdev;
-			goto abort;
-		}
-	}
 	if (p->replacement) {
 		/* We must have just cleared 'rdev' */
 		p->rdev = p->replacement;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6fe334bb954ab..f03e4231bec11 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8241,15 +8241,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		goto abort;
 	}
 	*rdevp = NULL;
-	if (!test_bit(RemoveSynchronized, &rdev->flags)) {
-		lockdep_assert_held(&mddev->reconfig_mutex);
-		synchronize_rcu();
-		if (atomic_read(&rdev->nr_pending)) {
-			/* lost the race, try later */
-			err = -EBUSY;
-			rcu_assign_pointer(*rdevp, rdev);
-		}
-	}
 	if (!err) {
 		err = log_modify(conf, rdev, false);
 		if (err)
-- 
2.43.0


