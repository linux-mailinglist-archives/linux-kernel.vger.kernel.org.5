Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51F7BF428
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442472AbjJJHYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442509AbjJJHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:48 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7DC9;
        Tue, 10 Oct 2023 00:23:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S4S7G3hYgz4f3kp2;
        Tue, 10 Oct 2023 15:23:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S23;
        Tue, 10 Oct 2023 15:23:43 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 19/19] md: rename __mddev_suspend/resume() back to mddev_suspend/resume()
Date:   Tue, 10 Oct 2023 23:19:58 +0800
Message-Id: <20231010151958.145896-20-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S23
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW7KrWrCw4UZFyUJr1DKFg_yoW7Ar4Upw
        4xtFWrZw4UZF93XryDJa1kCa45tw4rKrZFyrW7Z3s3CasIq3s5GF15WF45Xryqka4fXF1D
        Ja1j9a48ZryxGrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
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

Now that the old apis are removed, __mddev_suspend/resume() can be
renamed to their original names.

This is done by:

sed -i "s/__mddev_suspend/mddev_suspend/g" *.[ch]
sed -i "s/__mddev_resume/mddev_resume/g" *.[ch]

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c     |  4 ++--
 drivers/md/md.c          | 18 +++++++++---------
 drivers/md/md.h          | 12 ++++++------
 drivers/md/raid5-cache.c |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 05dd6ccf6f48..a4692f8f98ee 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3797,7 +3797,7 @@ static void raid_postsuspend(struct dm_target *ti)
 		if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
 			md_stop_writes(&rs->md);
 
-		__mddev_suspend(&rs->md, false);
+		mddev_suspend(&rs->md, false);
 	}
 }
 
@@ -4009,7 +4009,7 @@ static int raid_preresume(struct dm_target *ti)
 	}
 
 	/* Check for any resize/reshape on @rs and adjust/initiate */
-	/* Be prepared for __mddev_resume() in raid_resume() */
+	/* Be prepared for mddev_resume() in raid_resume() */
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 757cd53c0fa1..8ee079c4dc1e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -422,7 +422,7 @@ static void md_submit_bio(struct bio *bio)
  * Make sure no new requests are submitted to the device, and any requests that
  * have been submitted are completely handled.
  */
-int __mddev_suspend(struct mddev *mddev, bool interruptible)
+int mddev_suspend(struct mddev *mddev, bool interruptible)
 {
 	int err = 0;
 
@@ -473,9 +473,9 @@ int __mddev_suspend(struct mddev *mddev, bool interruptible)
 	mutex_unlock(&mddev->suspend_mutex);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__mddev_suspend);
+EXPORT_SYMBOL_GPL(mddev_suspend);
 
-void __mddev_resume(struct mddev *mddev)
+void mddev_resume(struct mddev *mddev)
 {
 	lockdep_assert_not_held(&mddev->reconfig_mutex);
 
@@ -486,7 +486,7 @@ void __mddev_resume(struct mddev *mddev)
 		return;
 	}
 
-	/* entred the memalloc scope from __mddev_suspend() */
+	/* entred the memalloc scope from mddev_suspend() */
 	memalloc_noio_restore(mddev->noio_flag);
 
 	percpu_ref_resurrect(&mddev->active_io);
@@ -498,7 +498,7 @@ void __mddev_resume(struct mddev *mddev)
 
 	mutex_unlock(&mddev->suspend_mutex);
 }
-EXPORT_SYMBOL_GPL(__mddev_resume);
+EXPORT_SYMBOL_GPL(mddev_resume);
 
 /*
  * Generic flush handling for md
@@ -5219,12 +5219,12 @@ suspend_lo_store(struct mddev *mddev, const char *buf, size_t len)
 	if (new != (sector_t)new)
 		return -EINVAL;
 
-	err = __mddev_suspend(mddev, true);
+	err = mddev_suspend(mddev, true);
 	if (err)
 		return err;
 
 	WRITE_ONCE(mddev->suspend_lo, new);
-	__mddev_resume(mddev);
+	mddev_resume(mddev);
 
 	return len;
 }
@@ -5250,12 +5250,12 @@ suspend_hi_store(struct mddev *mddev, const char *buf, size_t len)
 	if (new != (sector_t)new)
 		return -EINVAL;
 
-	err = __mddev_suspend(mddev, true);
+	err = mddev_suspend(mddev, true);
 	if (err)
 		return err;
 
 	WRITE_ONCE(mddev->suspend_hi, new);
-	__mddev_resume(mddev);
+	mddev_resume(mddev);
 
 	return len;
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 4c5f3f032656..55d01d431418 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -804,8 +804,8 @@ extern int md_rdev_init(struct md_rdev *rdev);
 extern void md_rdev_clear(struct md_rdev *rdev);
 
 extern void md_handle_request(struct mddev *mddev, struct bio *bio);
-extern int __mddev_suspend(struct mddev *mddev, bool interruptible);
-extern void __mddev_resume(struct mddev *mddev);
+extern int mddev_suspend(struct mddev *mddev, bool interruptible);
+extern void mddev_resume(struct mddev *mddev);
 
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
@@ -853,27 +853,27 @@ static inline int mddev_suspend_and_lock(struct mddev *mddev)
 {
 	int ret;
 
-	ret = __mddev_suspend(mddev, true);
+	ret = mddev_suspend(mddev, true);
 	if (ret)
 		return ret;
 
 	ret = mddev_lock(mddev);
 	if (ret)
-		__mddev_resume(mddev);
+		mddev_resume(mddev);
 
 	return ret;
 }
 
 static inline void mddev_suspend_and_lock_nointr(struct mddev *mddev)
 {
-	__mddev_suspend(mddev, false);
+	mddev_suspend(mddev, false);
 	mutex_lock(&mddev->reconfig_mutex);
 }
 
 static inline void mddev_unlock_and_resume(struct mddev *mddev)
 {
 	mddev_unlock(mddev);
-	__mddev_resume(mddev);
+	mddev_resume(mddev);
 }
 
 struct mdu_array_info_s;
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 9909110262ee..6157f5beb9fe 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -699,9 +699,9 @@ static void r5c_disable_writeback_async(struct work_struct *work)
 
 	log = READ_ONCE(conf->log);
 	if (log) {
-		__mddev_suspend(mddev, false);
+		mddev_suspend(mddev, false);
 		log->r5c_journal_mode = R5C_JOURNAL_MODE_WRITE_THROUGH;
-		__mddev_resume(mddev);
+		mddev_resume(mddev);
 	}
 }
 
-- 
2.39.2

