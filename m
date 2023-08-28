Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453678A476
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjH1CFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjH1CFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:05:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E72123;
        Sun, 27 Aug 2023 19:04:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RYv5N4Kqzz4f3k60;
        Mon, 28 Aug 2023 10:04:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S31;
        Mon, 28 Aug 2023 10:04:57 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 27/28] md: remove old apis to suspend the array
Date:   Mon, 28 Aug 2023 10:00:20 +0800
Message-Id: <20230828020021.2489641-28-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S31
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1kKrWfXF1rWFWxXw43Jrb_yoW7GF1kp3
        yftFZakrWUJFZ0qr4UJa4DWa45Xw1jkrWqyrW3Xa4fC3Wakw45GF15WryrXryvka9Yvr4D
        Jw1Fva1UuF18WFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that mddev_suspend() and mddev_resume() is not used anywhere, remove
them, and remove 'MD_ALLOW_SB_UPDATE' and 'MD_UPDATING_SB' as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 82 ++-----------------------------------------------
 drivers/md/md.h |  8 -----
 2 files changed, 3 insertions(+), 87 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 53133b37c9b9..bb67734eded6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -418,74 +418,10 @@ static void md_submit_bio(struct bio *bio)
 	md_handle_request(mddev, bio);
 }
 
-/* mddev_suspend makes sure no new requests are submitted
- * to the device, and that any requests that have been submitted
- * are completely handled.
- * Once mddev_detach() is called and completes, the module will be
- * completely unused.
+/*
+ * Make sure no new requests are submitted to the device, and any requests that
+ * have been submitted are completely handled.
  */
-void mddev_suspend(struct mddev *mddev)
-{
-	struct md_thread *thread = rcu_dereference_protected(mddev->thread,
-			lockdep_is_held(&mddev->reconfig_mutex));
-
-	WARN_ON_ONCE(thread && current == thread->tsk);
-
-	/* can't concurrent with __mddev_suspend() and __mddev_resume() */
-	mutex_lock(&mddev->suspend_mutex);
-	if (mddev->suspended++) {
-		mutex_unlock(&mddev->suspend_mutex);
-		return;
-	}
-
-	wake_up(&mddev->sb_wait);
-	set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
-	percpu_ref_kill(&mddev->active_io);
-
-	/*
-	 * TODO: cleanup 'pers->prepare_suspend after all callers are replaced
-	 * by __mddev_suspend().
-	 */
-	if (mddev->pers && mddev->pers->prepare_suspend)
-		mddev->pers->prepare_suspend(mddev);
-
-	wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
-	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
-	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
-
-	del_timer_sync(&mddev->safemode_timer);
-	/* restrict memory reclaim I/O during raid array is suspend */
-	mddev->noio_flag = memalloc_noio_save();
-
-	mutex_unlock(&mddev->suspend_mutex);
-}
-EXPORT_SYMBOL_GPL(mddev_suspend);
-
-void mddev_resume(struct mddev *mddev)
-{
-	lockdep_assert_held(&mddev->reconfig_mutex);
-
-	/* can't concurrent with __mddev_suspend() and __mddev_resume() */
-	mutex_lock(&mddev->suspend_mutex);
-	if (--mddev->suspended) {
-		mutex_unlock(&mddev->suspend_mutex);
-		return;
-	}
-
-	/* entred the memalloc scope from mddev_suspend() */
-	memalloc_noio_restore(mddev->noio_flag);
-
-	percpu_ref_resurrect(&mddev->active_io);
-	wake_up(&mddev->sb_wait);
-
-	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
-
-	mutex_unlock(&mddev->suspend_mutex);
-}
-EXPORT_SYMBOL_GPL(mddev_resume);
-
 void __mddev_suspend(struct mddev *mddev)
 {
 
@@ -9536,18 +9472,6 @@ static void md_start_sync(struct work_struct *ws)
  */
 void md_check_recovery(struct mddev *mddev)
 {
-	if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags) && mddev->sb_flags) {
-		/* Write superblock - thread that called mddev_suspend()
-		 * holds reconfig_mutex for us.
-		 */
-		set_bit(MD_UPDATING_SB, &mddev->flags);
-		smp_mb__after_atomic();
-		if (test_bit(MD_ALLOW_SB_UPDATE, &mddev->flags))
-			md_update_sb(mddev, 0);
-		clear_bit_unlock(MD_UPDATING_SB, &mddev->flags);
-		wake_up(&mddev->sb_wait);
-	}
-
 	if (is_md_suspended(mddev))
 		return;
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 73334034e880..f932d0cb9db0 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -248,10 +248,6 @@ struct md_cluster_info;
  *			    become failed.
  * @MD_HAS_PPL:  The raid array has PPL feature set.
  * @MD_HAS_MULTIPLE_PPLS: The raid array has multiple PPLs feature set.
- * @MD_ALLOW_SB_UPDATE: md_check_recovery is allowed to update the metadata
- *			 without taking reconfig_mutex.
- * @MD_UPDATING_SB: md_check_recovery is updating the metadata without
- *		     explicitly holding reconfig_mutex.
  * @MD_NOT_READY: do_md_run() is active, so 'array_state', ust not report that
  *		   array is ready yet.
  * @MD_BROKEN: This is used to stop writes and mark array as failed.
@@ -268,8 +264,6 @@ enum mddev_flags {
 	MD_FAILFAST_SUPPORTED,
 	MD_HAS_PPL,
 	MD_HAS_MULTIPLE_PPLS,
-	MD_ALLOW_SB_UPDATE,
-	MD_UPDATING_SB,
 	MD_NOT_READY,
 	MD_BROKEN,
 	MD_DELETED,
@@ -810,8 +804,6 @@ extern int md_rdev_init(struct md_rdev *rdev);
 extern void md_rdev_clear(struct md_rdev *rdev);
 
 extern void md_handle_request(struct mddev *mddev, struct bio *bio);
-extern void mddev_suspend(struct mddev *mddev);
-extern void mddev_resume(struct mddev *mddev);
 extern void __mddev_suspend(struct mddev *mddev);
 extern void __mddev_resume(struct mddev *mddev);
 
-- 
2.39.2

