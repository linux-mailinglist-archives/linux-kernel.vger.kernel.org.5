Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BA7BF429
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442560AbjJJHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442479AbjJJHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7EB6;
        Tue, 10 Oct 2023 00:23:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S4S7H08srz4f3kpT;
        Tue, 10 Oct 2023 15:23:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S14;
        Tue, 10 Oct 2023 15:23:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 10/19] md: use new apis to suspend array for sysfs apis
Date:   Tue, 10 Oct 2023 23:19:49 +0800
Message-Id: <20231010151958.145896-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S14
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrCF1UAr4fZry7GFW7Jwb_yoW5Aw47pw
        4xKFZ3Wr1jv3s3Jr1q9a1kKa45Jw1xKrWqyrZru3Z7J3Z3Jw13G3WYgF1rXryFya4xCrn8
        Jw45Xa4rArW7GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
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

Convert to use new apis in following sysfs apis:
 - level_store
 - suspend_lo_store
 - suspend_hi_store
 - serialize_policy_store

These are not hot path, so performance is not concerned.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 201de29d913c..aa08b9b78332 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4019,7 +4019,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	if (slen == 0 || slen >= sizeof(clevel))
 		return -EINVAL;
 
-	rv = mddev_lock(mddev);
+	rv = mddev_suspend_and_lock(mddev);
 	if (rv)
 		return rv;
 
@@ -4112,7 +4112,6 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 
 	/* Looks like we have a winner */
-	mddev_suspend(mddev);
 	mddev_detach(mddev);
 
 	spin_lock(&mddev->lock);
@@ -4198,14 +4197,13 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	blk_set_stacking_limits(&mddev->queue->limits);
 	pers->run(mddev);
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-	mddev_resume(mddev);
 	if (!mddev->thread)
 		md_update_sb(mddev, 1);
 	sysfs_notify_dirent_safe(mddev->sysfs_level);
 	md_new_event();
 	rv = len;
 out_unlock:
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	return rv;
 }
 
@@ -5293,15 +5291,13 @@ suspend_lo_store(struct mddev *mddev, const char *buf, size_t len)
 	if (new != (sector_t)new)
 		return -EINVAL;
 
-	err = mddev_lock(mddev);
+	err = __mddev_suspend(mddev, true);
 	if (err)
 		return err;
 
-	mddev_suspend(mddev);
 	WRITE_ONCE(mddev->suspend_lo, new);
-	mddev_resume(mddev);
+	__mddev_resume(mddev);
 
-	mddev_unlock(mddev);
 	return len;
 }
 static struct md_sysfs_entry md_suspend_lo =
@@ -5326,15 +5322,13 @@ suspend_hi_store(struct mddev *mddev, const char *buf, size_t len)
 	if (new != (sector_t)new)
 		return -EINVAL;
 
-	err = mddev_lock(mddev);
+	err = __mddev_suspend(mddev, true);
 	if (err)
 		return err;
 
-	mddev_suspend(mddev);
 	WRITE_ONCE(mddev->suspend_hi, new);
-	mddev_resume(mddev);
+	__mddev_resume(mddev);
 
-	mddev_unlock(mddev);
 	return len;
 }
 static struct md_sysfs_entry md_suspend_hi =
@@ -5582,7 +5576,7 @@ serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
 	if (value == mddev->serialize_policy)
 		return len;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	if (mddev->pers == NULL || (mddev->pers->level != 1)) {
@@ -5591,15 +5585,13 @@ serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
 		goto unlock;
 	}
 
-	mddev_suspend(mddev);
 	if (value)
 		mddev_create_serial_pool(mddev, NULL, true);
 	else
 		mddev_destroy_serial_pool(mddev, NULL, true);
 	mddev->serialize_policy = value;
-	mddev_resume(mddev);
 unlock:
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	return err ?: len;
 }
 
-- 
2.39.2

