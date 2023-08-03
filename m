Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE6076EABF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjHCNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjHCNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:34:13 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9525245;
        Thu,  3 Aug 2023 06:32:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqXP3lYkz4f44xH;
        Thu,  3 Aug 2023 21:32:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtqrMtkWHLlPQ--.49699S32;
        Thu, 03 Aug 2023 21:32:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 28/29] md/raid5: Revert "md/raid5: fix a deadlock in the case that reshape is interrupted"
Date:   Thu,  3 Aug 2023 21:29:29 +0800
Message-Id: <20230803132930.2742286-29-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
References: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtqrMtkWHLlPQ--.49699S32
X-Coremail-Antispam: 1UD129KBjvJXoWxWr13KF4fJr1UXw1Uur4kWFg_yoWrAFWrpa
        9ayF9Ivr40qF98KFWDJr4kWFyF9ry7KrZ3ta9xJ3WxA3W3Xr4rC3W5Gw4rXFy8Aa48ArW5
        Xr48JryDWr4jg3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU56pBDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

This reverts commit 868bba54a3bcbfc34314e963d5a7e66717f39d4e.

Because the old apis mddev_suspend() and mddev_resume() is removed, and
the deadlock is not possible anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c    |  1 -
 drivers/md/raid5.c | 44 +-------------------------------------------
 2 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3f4537876cc2..f480f225781a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9165,7 +9165,6 @@ void md_do_sync(struct md_thread *thread)
 	spin_unlock(&mddev->lock);
 
 	wake_up(&resync_wait);
-	wake_up(&mddev->sb_wait);
 	md_wakeup_thread(mddev->thread);
 	return;
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4709b7ad0317..8a3045e4d43f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5953,19 +5953,6 @@ static int add_all_stripe_bios(struct r5conf *conf,
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
@@ -5997,8 +5984,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 			if (ahead_of_reshape(mddev, logical_sector,
 					     conf->reshape_safe)) {
 				spin_unlock_irq(&conf->device_lock);
-				ret = STRIPE_SCHEDULE_AND_RETRY;
-				goto out;
+				return STRIPE_SCHEDULE_AND_RETRY;
 			}
 		}
 		spin_unlock_irq(&conf->device_lock);
@@ -6077,15 +6063,6 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
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
 
@@ -9026,22 +9003,6 @@ static int raid5_start(struct mddev *mddev)
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
@@ -9062,7 +9023,6 @@ static struct md_personality raid6_personality =
 	.check_reshape	= raid6_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
-	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
@@ -9087,7 +9047,6 @@ static struct md_personality raid5_personality =
 	.check_reshape	= raid5_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
-	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
@@ -9113,7 +9072,6 @@ static struct md_personality raid4_personality =
 	.check_reshape	= raid5_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
-	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
-- 
2.39.2

