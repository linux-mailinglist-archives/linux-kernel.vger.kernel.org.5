Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6752676EA4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjHCN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjHCN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:34 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095592109;
        Thu,  3 Aug 2023 06:27:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqQN3bKKz4f3lXd;
        Thu,  3 Aug 2023 21:27:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S5;
        Thu, 03 Aug 2023 21:27:27 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 01/13] md: remove rdev flag 'RemoveSynchronized'
Date:   Thu,  3 Aug 2023 21:24:14 +0800
Message-Id: <20230803132426.2688608-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4xGFWDZrW7JrWxXF1UKFg_yoWxGryfpw
        s3XFy3Cw48Aw42qw4DtrW7Ca4rX3W7KayUCr93u34fZa4fAryDX348JFy5Ar90qFZ3Aa1F
        vF1UJw4DCF1xuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

When multiple rdevs are removed from array in remove_and_add_spares(),
which is only possible from daemon thread(user can only remove one rdev
through ioctl/sysfs at one time), the flag is used to avoid calling
synchronize_rcu() multiple times for each rdev.

However, remove rdev from daemon thread really is super cold path, while
removing n rdevs, it doesn't matter sync rcu n times or just one time.
Hence remove this flag and make code simpler.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-multipath.c | 15 +++++++--------
 drivers/md/md.c           | 26 ++------------------------
 drivers/md/md.h           |  5 -----
 drivers/md/raid1.c        | 15 +++++++--------
 drivers/md/raid10.c       | 15 +++++++--------
 drivers/md/raid5.c        | 15 +++++++--------
 6 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index d22276870283..9e4ddd5240cd 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -258,14 +258,13 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
+
+		synchronize_rcu();
+		if (atomic_read(&rdev->nr_pending)) {
+			/* lost the race, try later */
+			err = -EBUSY;
+			p->rdev = rdev;
+			goto abort;
 		}
 		err = md_integrity_register(mddev);
 	}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a3d98273b295..cd7ac1dee3b8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9155,7 +9155,6 @@ static int remove_and_add_spares(struct mddev *mddev,
 	struct md_rdev *rdev;
 	int spares = 0;
 	int removed = 0;
-	bool remove_some = false;
 
 	if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		/* Mustn't remove devices when resync thread is running */
@@ -9165,28 +9164,9 @@ static int remove_and_add_spares(struct mddev *mddev,
 		if ((this == NULL || rdev == this) &&
 		    rdev->raid_disk >= 0 &&
 		    !test_bit(Blocked, &rdev->flags) &&
-		    test_bit(Faulty, &rdev->flags) &&
+		    !test_bit(In_sync, &rdev->flags) &&
+		    !test_bit(Journal, &rdev->flags) &&
 		    atomic_read(&rdev->nr_pending)==0) {
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
-		    rdev->raid_disk >= 0 &&
-		    !test_bit(Blocked, &rdev->flags) &&
-		    ((test_bit(RemoveSynchronized, &rdev->flags) ||
-		     (!test_bit(In_sync, &rdev->flags) &&
-		      !test_bit(Journal, &rdev->flags))) &&
-		    atomic_read(&rdev->nr_pending)==0)) {
 			if (mddev->pers->hot_remove_disk(
 				    mddev, rdev) == 0) {
 				sysfs_unlink_rdev(mddev, rdev);
@@ -9195,8 +9175,6 @@ static int remove_and_add_spares(struct mddev *mddev,
 				removed++;
 			}
 		}
-		if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
-			clear_bit(RemoveSynchronized, &rdev->flags);
 	}
 
 	if (removed && mddev->kobj.sd)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8ae957480976..b25b6d061372 100644
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
index 23d211969565..acb6d6542619 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1859,15 +1859,14 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
+		synchronize_rcu();
+		if (atomic_read(&rdev->nr_pending)) {
+			/* lost the race, try later */
+			err = -EBUSY;
+			p->rdev = rdev;
+			goto abort;
 		}
+
 		if (conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7704a4c7f469..64dd5cb6133e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2247,15 +2247,14 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
+	synchronize_rcu();
+	if (atomic_read(&rdev->nr_pending)) {
+		/* lost the race, try later */
+		err = -EBUSY;
+		*rdevp = rdev;
+		goto abort;
 	}
+
 	if (p->replacement) {
 		/* We must have just cleared 'rdev' */
 		p->rdev = p->replacement;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4cdb35e54251..37d9865b180a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8267,15 +8267,14 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
+	lockdep_assert_held(&mddev->reconfig_mutex);
+	synchronize_rcu();
+	if (atomic_read(&rdev->nr_pending)) {
+		/* lost the race, try later */
+		err = -EBUSY;
+		rcu_assign_pointer(*rdevp, rdev);
 	}
+
 	if (!err) {
 		err = log_modify(conf, rdev, false);
 		if (err)
-- 
2.39.2

