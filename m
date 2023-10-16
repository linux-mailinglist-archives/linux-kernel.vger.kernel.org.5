Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975C7C9CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJPB2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:28:42 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C25C5;
        Sun, 15 Oct 2023 18:28:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S7zyl1145z4f3kjR;
        Mon, 16 Oct 2023 09:28:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXCkSxl3zBODA--.42064S6;
        Mon, 16 Oct 2023 09:28:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 2/6] md: remove flag RemoveSynchronized
Date:   Mon, 16 Oct 2023 17:24:35 +0800
Message-Id: <20231016092439.493646-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092439.493646-1-yukuai1@huaweicloud.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXCkSxl3zBODA--.42064S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1DCFyDZFW7AFyfKF15Arb_yoW7XFykpw
        sxWFy3ur4xXw4Utw4DJrW7CFyrJw1UK3yUCr93u34fZa43AryDX34rJFy5Zr90vFZaya10
        vF1UJw4DGFy8GF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNLvtUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
    /*
                        // access rdev after remove_and_add_spares()
                        rcu_read_unlock()

Hence remove this flag and prepare to remove rcu protection to access
rdev from 'conf'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-multipath.c |  9 ---------
 drivers/md/md.c           | 37 ++++++-------------------------------
 drivers/md/raid1.c        |  9 ---------
 drivers/md/raid10.c       |  9 ---------
 drivers/md/raid5.c        |  9 ---------
 5 files changed, 6 insertions(+), 67 deletions(-)

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
index 8ee079c4dc1e..fa6fe1664e78 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9235,44 +9235,19 @@ static int remove_and_add_spares(struct mddev *mddev,
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
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c13088eae401..4348d670439d 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1836,15 +1836,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
index 4b5f34f320c8..33ab00323cae 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2219,15 +2219,6 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
index 17981a889058..209a6a9d4146 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8225,15 +8225,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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

