Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073637F8919
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjKYIQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKYIQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:16:30 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96034B7;
        Sat, 25 Nov 2023 00:16:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Scl7417pxz4f3l79;
        Sat, 25 Nov 2023 16:16:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id E71AC1A09FE;
        Sat, 25 Nov 2023 16:16:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgCnqxFfrWFlP8KIBw--.32848S5;
        Sat, 25 Nov 2023 16:16:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 1/5] md: remove flag RemoveSynchronized
Date:   Sat, 25 Nov 2023 16:16:00 +0800
Message-Id: <20231125081604.3939938-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
References: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxFfrWFlP8KIBw--.32848S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WFW3tw1DWF15Ww45uFWrGrg_yoW7KFyfp3
        93XFy3ur4DXw4Utw4DArW7CFyrJw1UtayUCryfu34fZa43AryDX34rJFy5Zr90vFZaya1j
        vF1UJw4DGFyUGFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

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
---
 drivers/md/md-multipath.c |  9 ---------
 drivers/md/md.c           | 37 ++++++-------------------------------
 drivers/md/md.h           |  5 -----
 drivers/md/raid1.c        |  9 ---------
 drivers/md/raid10.c       |  9 ---------
 drivers/md/raid5.c        |  9 ---------
 6 files changed, 6 insertions(+), 72 deletions(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index d22276870283..aa77133f3188 100644
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
index 2ffedc39edd6..0c246397d637 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9251,44 +9251,19 @@ static int remove_and_add_spares(struct mddev *mddev,
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
index 20f3f96cf4c1..b80f87bfa36c 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -189,11 +189,6 @@ enum flag_bits {
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
index 35d12948e0a9..a678e0e6e102 100644
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
index a5927e98dc67..132a79523338 100644
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
index ec6cb8185207..fb009e3df132 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8232,15 +8232,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
2.39.2

