Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C997BF430
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442626AbjJJHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442478AbjJJHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:44 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C8AC;
        Tue, 10 Oct 2023 00:23:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S4S7B6bSZz4f3kpW;
        Tue, 10 Oct 2023 15:23:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S13;
        Tue, 10 Oct 2023 15:23:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 09/19] md/raid5: use new apis to suspend array
Date:   Tue, 10 Oct 2023 23:19:48 +0800
Message-Id: <20231010151958.145896-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S13
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8XryDCF1rGr4kWr1rZwb_yoWrCF1fpr
        sxKayfXr4jqry3XryDJ3WqgFy8Jw17KrZFyryxX3Z7J3Z3t347G34YgryrWry8Aa4xJ395
        Jw4Yg3WkAFy7JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
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

Convert to use new apis, the old apis will be removed eventually.

These are not hot path, so performance is not concerned.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6383723468e5..e6b8c0145648 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7025,7 +7025,7 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 			new != roundup_pow_of_two(new))
 		return -EINVAL;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 
@@ -7049,7 +7049,6 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 		goto out_unlock;
 	}
 
-	mddev_suspend(mddev);
 	mutex_lock(&conf->cache_size_mutex);
 	size = conf->max_nr_stripes;
 
@@ -7064,10 +7063,9 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 		err = -ENOMEM;
 	}
 	mutex_unlock(&conf->cache_size_mutex);
-	mddev_resume(mddev);
 
 out_unlock:
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	return err ?: len;
 }
 
@@ -7153,7 +7151,7 @@ raid5_store_skip_copy(struct mddev *mddev, const char *page, size_t len)
 		return -EINVAL;
 	new = !!new;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	conf = mddev->private;
@@ -7162,15 +7160,13 @@ raid5_store_skip_copy(struct mddev *mddev, const char *page, size_t len)
 	else if (new != conf->skip_copy) {
 		struct request_queue *q = mddev->queue;
 
-		mddev_suspend(mddev);
 		conf->skip_copy = new;
 		if (new)
 			blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
 		else
 			blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, q);
-		mddev_resume(mddev);
 	}
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	return err ?: len;
 }
 
@@ -7225,15 +7221,13 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 	if (new > 8192)
 		return -EINVAL;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	conf = mddev->private;
 	if (!conf)
 		err = -ENODEV;
 	else if (new != conf->worker_cnt_per_group) {
-		mddev_suspend(mddev);
-
 		old_groups = conf->worker_groups;
 		if (old_groups)
 			flush_workqueue(raid5_wq);
@@ -7250,9 +7244,8 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 				kfree(old_groups[0].workers);
 			kfree(old_groups);
 		}
-		mddev_resume(mddev);
 	}
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 
 	return err ?: len;
 }
@@ -8974,12 +8967,12 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 	struct r5conf *conf;
 	int err;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	conf = mddev->private;
 	if (!conf) {
-		mddev_unlock(mddev);
+		mddev_unlock_and_resume(mddev);
 		return -ENODEV;
 	}
 
@@ -8989,19 +8982,14 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 			err = log_init(conf, NULL, true);
 			if (!err) {
 				err = resize_stripes(conf, conf->pool_size);
-				if (err) {
-					mddev_suspend(mddev);
+				if (err)
 					log_exit(conf);
-					mddev_resume(mddev);
-				}
 			}
 		} else
 			err = -EINVAL;
 	} else if (strncmp(buf, "resync", 6) == 0) {
 		if (raid5_has_ppl(conf)) {
-			mddev_suspend(mddev);
 			log_exit(conf);
-			mddev_resume(mddev);
 			err = resize_stripes(conf, conf->pool_size);
 		} else if (test_bit(MD_HAS_JOURNAL, &conf->mddev->flags) &&
 			   r5l_log_disk_error(conf)) {
@@ -9014,11 +9002,9 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 					break;
 				}
 
-			if (!journal_dev_exists) {
-				mddev_suspend(mddev);
+			if (!journal_dev_exists)
 				clear_bit(MD_HAS_JOURNAL, &mddev->flags);
-				mddev_resume(mddev);
-			} else  /* need remove journal device first */
+			else  /* need remove journal device first */
 				err = -EBUSY;
 		} else
 			err = -EINVAL;
@@ -9029,7 +9015,7 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 	if (!err)
 		md_update_sb(mddev, 1);
 
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 
 	return err;
 }
-- 
2.39.2

