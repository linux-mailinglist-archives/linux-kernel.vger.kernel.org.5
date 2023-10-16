Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7887C9D10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjJPBub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPBua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:50:30 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9090C1;
        Sun, 15 Oct 2023 18:50:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S80Rx60WBz4f3lXG;
        Mon, 16 Oct 2023 09:50:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXdlixl04ZPDA--.43336S4;
        Mon, 16 Oct 2023 09:50:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md: cleanup pers->prepare_suspend()
Date:   Mon, 16 Oct 2023 17:46:26 +0800
Message-Id: <20231016094626.496378-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXdlixl04ZPDA--.43336S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JryrKF15Ar4DCw1kZr1rtFb_yoWxWF4Dpa
        9ayF9xZr40vFy3KrWDJr4kWa4Y9r17KrW7ta9rJw1xA3W3tr4rC3W5Way5Zr95Aa48ArWD
        Xa1UJa4Dur4093JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
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

pers->prepare_suspend() is not used anymore and can be removed.

Reverts following three commit:

 - commit 431e61257d63 ("md: export md_is_rdwr() and is_md_suspended()")
 - commit 3e00777d5157 ("md: add a new api prepare_suspend() in
md_personality")
 - commit 868bba54a3bc ("md/raid5: fix a deadlock in the case that reshape
is interrupted")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c    | 17 ++++++++++++++++-
 drivers/md/md.h    | 18 ------------------
 drivers/md/raid5.c | 44 +-------------------------------------------
 3 files changed, 17 insertions(+), 62 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d89b3b60915c..727f7a8f194b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -91,6 +91,18 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
 static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
 static bool remove_rdev(struct md_rdev *rdev);
 
+enum md_ro_state {
+	MD_RDWR,
+	MD_RDONLY,
+	MD_AUTO_READ,
+	MD_MAX_STATE
+};
+
+static bool md_is_rdwr(struct mddev *mddev)
+{
+	return (mddev->ro == MD_RDWR);
+}
+
 /*
  * Default number of read corrections we'll attempt on an rdev
  * before ejecting it from the array. We divide the read error
@@ -333,6 +345,10 @@ EXPORT_SYMBOL_GPL(md_new_event);
 static LIST_HEAD(all_mddevs);
 static DEFINE_SPINLOCK(all_mddevs_lock);
 
+static bool is_md_suspended(struct mddev *mddev)
+{
+	return percpu_ref_is_dying(&mddev->active_io);
+}
 /* Rather than calling directly into the personality make_request function,
  * IO requests come here first so that we can check if the device is
  * being suspended pending a reconfiguration.
@@ -9141,7 +9157,6 @@ void md_do_sync(struct md_thread *thread)
 	spin_unlock(&mddev->lock);
 
 	wake_up(&resync_wait);
-	wake_up(&mddev->sb_wait);
 	md_wakeup_thread(mddev->thread);
 	return;
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 55d01d431418..20f3f96cf4c1 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -565,23 +565,6 @@ enum recovery_flags {
 	MD_RESYNCING_REMOTE,	/* remote node is running resync thread */
 };
 
-enum md_ro_state {
-	MD_RDWR,
-	MD_RDONLY,
-	MD_AUTO_READ,
-	MD_MAX_STATE
-};
-
-static inline bool md_is_rdwr(struct mddev *mddev)
-{
-	return (mddev->ro == MD_RDWR);
-}
-
-static inline bool is_md_suspended(struct mddev *mddev)
-{
-	return percpu_ref_is_dying(&mddev->active_io);
-}
-
 static inline int __must_check mddev_lock(struct mddev *mddev)
 {
 	return mutex_lock_interruptible(&mddev->reconfig_mutex);
@@ -641,7 +624,6 @@ struct md_personality
 	int (*start_reshape) (struct mddev *mddev);
 	void (*finish_reshape) (struct mddev *mddev);
 	void (*update_reshape_pos) (struct mddev *mddev);
-	void (*prepare_suspend) (struct mddev *mddev);
 	/* quiesce suspends or resumes internal processing.
 	 * 1 - stop new actions and wait for action io to complete
 	 * 0 - return to normal behaviour
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 36ca6db37153..ad6d5138a6bd 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5907,19 +5907,6 @@ static int add_all_stripe_bios(struct r5conf *conf,
 	return ret;
 }
 
-static bool reshape_inprogress(struct mddev *mddev)
-{
-	return test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
-	       test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
-	       !test_bit(MD_RECOVERY_DONE, &mddev->recovery) &&
-	       !test_bit(MD_RECOVERY_INTR, &mddev->recovery);
-}
-
-static bool reshape_disabled(struct mddev *mddev)
-{
-	return is_md_suspended(mddev) || !md_is_rdwr(mddev);
-}
-
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
 		sector_t logical_sector, struct bio *bi)
@@ -5951,8 +5938,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 			if (ahead_of_reshape(mddev, logical_sector,
 					     conf->reshape_safe)) {
 				spin_unlock_irq(&conf->device_lock);
-				ret = STRIPE_SCHEDULE_AND_RETRY;
-				goto out;
+				return STRIPE_SCHEDULE_AND_RETRY;
 			}
 		}
 		spin_unlock_irq(&conf->device_lock);
@@ -6031,15 +6017,6 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 out_release:
 	raid5_release_stripe(sh);
-out:
-	if (ret == STRIPE_SCHEDULE_AND_RETRY && !reshape_inprogress(mddev) &&
-	    reshape_disabled(mddev)) {
-		bi->bi_status = BLK_STS_IOERR;
-		ret = STRIPE_FAIL;
-		pr_err("md/raid456:%s: io failed across reshape position while reshape can't make progress.\n",
-		       mdname(mddev));
-	}
-
 	return ret;
 }
 
@@ -8924,22 +8901,6 @@ static int raid5_start(struct mddev *mddev)
 	return r5l_start(conf->log);
 }
 
-static void raid5_prepare_suspend(struct mddev *mddev)
-{
-	struct r5conf *conf = mddev->private;
-
-	wait_event(mddev->sb_wait, !reshape_inprogress(mddev) ||
-				    percpu_ref_is_zero(&mddev->active_io));
-	if (percpu_ref_is_zero(&mddev->active_io))
-		return;
-
-	/*
-	 * Reshape is not in progress, and array is suspended, io that is
-	 * waiting for reshpape can never be done.
-	 */
-	wake_up(&conf->wait_for_overlap);
-}
-
 static struct md_personality raid6_personality =
 {
 	.name		= "raid6",
@@ -8960,7 +8921,6 @@ static struct md_personality raid6_personality =
 	.check_reshape	= raid6_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
-	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
@@ -8985,7 +8945,6 @@ static struct md_personality raid5_personality =
 	.check_reshape	= raid5_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
-	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
@@ -9011,7 +8970,6 @@ static struct md_personality raid4_personality =
 	.check_reshape	= raid5_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
-	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
-- 
2.39.2

