Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A87C9CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjJPB2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjJPB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:28:42 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0618C1;
        Sun, 15 Oct 2023 18:28:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S7zyk5kRtz4f3kjN;
        Mon, 16 Oct 2023 09:28:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXCkSxl3zBODA--.42064S5;
        Mon, 16 Oct 2023 09:28:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 1/6] md: remove useless debug code to print configuration
Date:   Mon, 16 Oct 2023 17:24:34 +0800
Message-Id: <20231016092439.493646-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092439.493646-1-yukuai1@huaweicloud.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXCkSxl3zBODA--.42064S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1DWFy7ZrWxXw15Xr47Arb_yoWxuw4Dpw
        43ta47JrsFv345JF4kArWDC3Wayw47KayIyryfC3s7ZanIyrZ3J3WrJFyrJFy5Za45Zw15
        Z3yYkrWkC3WIgFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRxhLUUUUUU
        =
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

One the one hand, print_conf() can be called without grabbing
'reconfig_mtuex' and current rcu protection to access rdev through 'conf'
is not safe, on the other hand, print_conf() is just used for debug,
and user can always grab such information(/proc/mdstat and mdadm).

There is no need to always enable this debug and try to fix potential
problems, hence remove print_conf().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c  | 28 ----------------------------
 drivers/md/raid10.c | 29 -----------------------------
 drivers/md/raid5.c  | 34 ----------------------------------
 3 files changed, 91 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 35d12948e0a9..c13088eae401 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1679,30 +1679,6 @@ static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
 		mdname(mddev), conf->raid_disks - mddev->degraded);
 }
 
-static void print_conf(struct r1conf *conf)
-{
-	int i;
-
-	pr_debug("RAID1 conf printout:\n");
-	if (!conf) {
-		pr_debug("(!conf)\n");
-		return;
-	}
-	pr_debug(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
-		 conf->raid_disks);
-
-	rcu_read_lock();
-	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
-		if (rdev)
-			pr_debug(" disk %d, wo:%d, o:%d, dev:%pg\n",
-				 i, !test_bit(In_sync, &rdev->flags),
-				 !test_bit(Faulty, &rdev->flags),
-				 rdev->bdev);
-	}
-	rcu_read_unlock();
-}
-
 static void close_sync(struct r1conf *conf)
 {
 	int idx;
@@ -1763,7 +1739,6 @@ static int raid1_spare_active(struct mddev *mddev)
 	mddev->degraded -= count;
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
-	print_conf(conf);
 	return count;
 }
 
@@ -1829,7 +1804,6 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
 	}
 
-	print_conf(conf);
 	return err;
 }
 
@@ -1846,7 +1820,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
-	print_conf(conf);
 	if (rdev == p->rdev) {
 		if (test_bit(In_sync, &rdev->flags) ||
 		    atomic_read(&rdev->nr_pending)) {
@@ -1902,7 +1875,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	}
 abort:
 
-	print_conf(conf);
 	return err;
 }
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a5927e98dc67..4b5f34f320c8 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2059,31 +2059,6 @@ static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
 		mdname(mddev), conf->geo.raid_disks - mddev->degraded);
 }
 
-static void print_conf(struct r10conf *conf)
-{
-	int i;
-	struct md_rdev *rdev;
-
-	pr_debug("RAID10 conf printout:\n");
-	if (!conf) {
-		pr_debug("(!conf)\n");
-		return;
-	}
-	pr_debug(" --- wd:%d rd:%d\n", conf->geo.raid_disks - conf->mddev->degraded,
-		 conf->geo.raid_disks);
-
-	/* This is only called with ->reconfix_mutex held, so
-	 * rcu protection of rdev is not needed */
-	for (i = 0; i < conf->geo.raid_disks; i++) {
-		rdev = conf->mirrors[i].rdev;
-		if (rdev)
-			pr_debug(" disk %d, wo:%d, o:%d, dev:%pg\n",
-				 i, !test_bit(In_sync, &rdev->flags),
-				 !test_bit(Faulty, &rdev->flags),
-				 rdev->bdev);
-	}
-}
-
 static void close_sync(struct r10conf *conf)
 {
 	wait_barrier(conf, false);
@@ -2136,7 +2111,6 @@ static int raid10_spare_active(struct mddev *mddev)
 	mddev->degraded -= count;
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
-	print_conf(conf);
 	return count;
 }
 
@@ -2207,7 +2181,6 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		rcu_assign_pointer(p->replacement, rdev);
 	}
 
-	print_conf(conf);
 	return err;
 }
 
@@ -2219,7 +2192,6 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct md_rdev **rdevp;
 	struct raid10_info *p;
 
-	print_conf(conf);
 	if (unlikely(number >= mddev->raid_disks))
 		return 0;
 	p = conf->mirrors + number;
@@ -2271,7 +2243,6 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 abort:
 
-	print_conf(conf);
 	return err;
 }
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d6de084a85e5..17981a889058 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -156,8 +156,6 @@ static int raid6_idx_to_slot(int idx, struct stripe_head *sh,
 	return slot;
 }
 
-static void print_raid5_conf (struct r5conf *conf);
-
 static int stripe_operations_active(struct stripe_head *sh)
 {
 	return sh->check_state || sh->reconstruct_state ||
@@ -8006,8 +8004,6 @@ static int raid5_run(struct mddev *mddev)
 		mddev->raid_disks-mddev->degraded, mddev->raid_disks,
 		mddev->new_layout);
 
-	print_raid5_conf(conf);
-
 	if (conf->reshape_progress != MaxSector) {
 		conf->reshape_safe = conf->reshape_progress;
 		atomic_set(&conf->reshape_stripes, 0);
@@ -8098,7 +8094,6 @@ static int raid5_run(struct mddev *mddev)
 	return 0;
 abort:
 	md_unregister_thread(mddev, &mddev->thread);
-	print_raid5_conf(conf);
 	free_conf(conf);
 	mddev->private = NULL;
 	pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
@@ -8130,31 +8125,6 @@ static void raid5_status(struct seq_file *seq, struct mddev *mddev)
 	seq_printf (seq, "]");
 }
 
-static void print_raid5_conf (struct r5conf *conf)
-{
-	struct md_rdev *rdev;
-	int i;
-
-	pr_debug("RAID conf printout:\n");
-	if (!conf) {
-		pr_debug("(conf==NULL)\n");
-		return;
-	}
-	pr_debug(" --- level:%d rd:%d wd:%d\n", conf->level,
-	       conf->raid_disks,
-	       conf->raid_disks - conf->mddev->degraded);
-
-	rcu_read_lock();
-	for (i = 0; i < conf->raid_disks; i++) {
-		rdev = rcu_dereference(conf->disks[i].rdev);
-		if (rdev)
-			pr_debug(" disk %d, o:%d, dev:%pg\n",
-			       i, !test_bit(Faulty, &rdev->flags),
-			       rdev->bdev);
-	}
-	rcu_read_unlock();
-}
-
 static int raid5_spare_active(struct mddev *mddev)
 {
 	int i;
@@ -8196,7 +8166,6 @@ static int raid5_spare_active(struct mddev *mddev)
 	spin_lock_irqsave(&conf->device_lock, flags);
 	mddev->degraded = raid5_calc_degraded(conf);
 	spin_unlock_irqrestore(&conf->device_lock, flags);
-	print_raid5_conf(conf);
 	return count;
 }
 
@@ -8209,7 +8178,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct disk_info *p;
 	struct md_rdev *tmp;
 
-	print_raid5_conf(conf);
 	if (test_bit(Journal, &rdev->flags) && conf->log) {
 		/*
 		 * we can't wait pending write here, as this is called in
@@ -8289,7 +8257,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	clear_bit(WantReplacement, &rdev->flags);
 abort:
 
-	print_raid5_conf(conf);
 	return err;
 }
 
@@ -8371,7 +8338,6 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	}
 out:
-	print_raid5_conf(conf);
 	return err;
 }
 
-- 
2.39.2

