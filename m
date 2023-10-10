Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4337BF433
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442614AbjJJHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442463AbjJJHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65B99;
        Tue, 10 Oct 2023 00:23:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S4S7G28Xkz4f3kp4;
        Tue, 10 Oct 2023 15:23:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S12;
        Tue, 10 Oct 2023 15:23:39 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 08/19] md/raid5-cache: use new apis to suspend array
Date:   Tue, 10 Oct 2023 23:19:47 +0800
Message-Id: <20231010151958.145896-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S12
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4fWFyktFW5Xw4rKr1xKrg_yoW8uw48pF
        4IqayF9348uFyrZFy8XF4DGF95Ww40grZ2yr9xW3WkZa95ZryxGF1rWFyjqrykAFyfAF13
        Jw45tw18Cr18trUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5-cache.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 889bba60d6ff..9909110262ee 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -686,7 +686,6 @@ static void r5c_disable_writeback_async(struct work_struct *work)
 					   disable_writeback_work);
 	struct mddev *mddev = log->rdev->mddev;
 	struct r5conf *conf = mddev->private;
-	int locked = 0;
 
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH)
 		return;
@@ -696,13 +695,13 @@ static void r5c_disable_writeback_async(struct work_struct *work)
 	/* wait superblock change before suspend */
 	wait_event(mddev->sb_wait,
 		   !READ_ONCE(conf->log) ||
-		   (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) &&
-		    (locked = mddev_trylock(mddev))));
-	if (locked) {
-		mddev_suspend(mddev);
+		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
+
+	log = READ_ONCE(conf->log);
+	if (log) {
+		__mddev_suspend(mddev, false);
 		log->r5c_journal_mode = R5C_JOURNAL_MODE_WRITE_THROUGH;
-		mddev_resume(mddev);
-		mddev_unlock(mddev);
+		__mddev_resume(mddev);
 	}
 }
 
@@ -2586,9 +2585,7 @@ int r5c_journal_mode_set(struct mddev *mddev, int mode)
 	    mode == R5C_JOURNAL_MODE_WRITE_BACK)
 		return -EINVAL;
 
-	mddev_suspend(mddev);
 	conf->log->r5c_journal_mode = mode;
-	mddev_resume(mddev);
 
 	pr_debug("md/raid:%s: setting r5c cache mode to %d: %s\n",
 		 mdname(mddev), mode, r5c_journal_mode_str[mode]);
@@ -2613,11 +2610,11 @@ static ssize_t r5c_journal_mode_store(struct mddev *mddev,
 		if (strlen(r5c_journal_mode_str[mode]) == len &&
 		    !strncmp(page, r5c_journal_mode_str[mode], len))
 			break;
-	ret = mddev_lock(mddev);
+	ret = mddev_suspend_and_lock(mddev);
 	if (ret)
 		return ret;
 	ret = r5c_journal_mode_set(mddev, mode);
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	return ret ?: length;
 }
 
-- 
2.39.2

