Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0100E7AE3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjIZDEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjIZDEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:04:49 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A6116;
        Mon, 25 Sep 2023 20:04:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rvl2l70Yyz4f3kpy;
        Tue, 26 Sep 2023 11:04:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd0+ShJlShWjBQ--.31625S6;
        Tue, 26 Sep 2023 11:04:32 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 2/2] md: simplify md_seq_ops
Date:   Tue, 26 Sep 2023 10:58:27 +0800
Message-Id: <20230926025827.671407-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926025827.671407-1-yukuai1@huaweicloud.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd0+ShJlShWjBQ--.31625S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47XF18KrWDCw4kCr4Durg_yoWrCFy7pa
        nI9FZxAr48Z3yFqan8Ja1Du3W3Jws7t34qgr9rG3s5Cr1jqr13ZF1aqr40qr90gayUWrn0
        qw4UKa45urWxGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Before this patch, the implementation is hacky and hard to understand:

1) md_seq_start set pos to 1;
2) md_seq_show found pos is 1, then print Personalities;
3) md_seq_next found pos is 1, then it update pos to the first mddev;
4) md_seq_show found pos is not 1 or 2, show mddev;
5) md_seq_next found pos is not 1 or 2, update pos to next mddev;
6) loop 4-5 until the last mddev, then md_seq_next update pos to 2;
7) md_seq_show found pos is 2, then print unused devices;
8) md_seq_next found pos is 2, stop;

This patch remove the magic value and use seq_list_start/next/stop()
directly, and move printing "Personalities" to md_sep_start(),
"unsed devices" to md_seq_stop():

1) md_seq_start print Personalities, and then set pos to first mddev;
2) md_seq_show show mddev;
3) md_seq_next update pos to next mddev;
4) loop 2-3 until the last mddev;
5) md_seq_stop print unsed devices;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 99 +++++++++++--------------------------------------
 1 file changed, 21 insertions(+), 78 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a5ef6f7da8ec..44635b6ee26f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8220,105 +8220,46 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 }
 
 static void *md_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(&all_mddevs_lock)
 {
-	struct list_head *tmp;
-	loff_t l = *pos;
-	struct mddev *mddev;
+	struct md_personality *pers;
 
-	if (l == 0x10000) {
-		++*pos;
-		return (void *)2;
-	}
-	if (l > 0x10000)
-		return NULL;
-	if (!l--)
-		/* header */
-		return (void*)1;
+	seq_puts(seq, "Personalities : ");
+	spin_lock(&pers_lock);
+	list_for_each_entry(pers, &pers_list, list)
+		seq_printf(seq, "[%s] ", pers->name);
+
+	spin_unlock(&pers_lock);
+	seq_puts(seq, "\n");
+	seq->poll_event = atomic_read(&md_event_count);
 
 	spin_lock(&all_mddevs_lock);
-	list_for_each(tmp,&all_mddevs)
-		if (!l--) {
-			mddev = list_entry(tmp, struct mddev, all_mddevs);
-			if (!mddev_get(mddev))
-				continue;
-			spin_unlock(&all_mddevs_lock);
-			return mddev;
-		}
-	spin_unlock(&all_mddevs_lock);
-	if (!l--)
-		return (void*)2;/* tail */
-	return NULL;
+
+	return seq_list_start(&all_mddevs, *pos);
 }
 
 static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct list_head *tmp;
-	struct mddev *next_mddev, *mddev = v;
-	struct mddev *to_put = NULL;
-
-	++*pos;
-	if (v == (void*)2)
-		return NULL;
-
-	spin_lock(&all_mddevs_lock);
-	if (v == (void*)1) {
-		tmp = all_mddevs.next;
-	} else {
-		to_put = mddev;
-		tmp = mddev->all_mddevs.next;
-	}
-
-	for (;;) {
-		if (tmp == &all_mddevs) {
-			next_mddev = (void*)2;
-			*pos = 0x10000;
-			break;
-		}
-		next_mddev = list_entry(tmp, struct mddev, all_mddevs);
-		if (mddev_get(next_mddev))
-			break;
-		mddev = next_mddev;
-		tmp = mddev->all_mddevs.next;
-	}
-	spin_unlock(&all_mddevs_lock);
-
-	if (to_put)
-		mddev_put(to_put);
-	return next_mddev;
-
+	return seq_list_next(v, &all_mddevs, pos);
 }
 
 static void md_seq_stop(struct seq_file *seq, void *v)
+	__releases(&all_mddevs_lock)
 {
-	struct mddev *mddev = v;
-
-	if (mddev && v != (void*)1 && v != (void*)2)
-		mddev_put(mddev);
+	status_unused(seq);
+	spin_unlock(&all_mddevs_lock);
 }
 
 static int md_seq_show(struct seq_file *seq, void *v)
 {
-	struct mddev *mddev = v;
+	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
 	sector_t sectors;
 	struct md_rdev *rdev;
 
-	if (v == (void*)1) {
-		struct md_personality *pers;
-		seq_printf(seq, "Personalities : ");
-		spin_lock(&pers_lock);
-		list_for_each_entry(pers, &pers_list, list)
-			seq_printf(seq, "[%s] ", pers->name);
-
-		spin_unlock(&pers_lock);
-		seq_printf(seq, "\n");
-		seq->poll_event = atomic_read(&md_event_count);
+	if (!mddev_get(mddev))
 		return 0;
-	}
-	if (v == (void*)2) {
-		status_unused(seq);
-		return 0;
-	}
 
+	spin_unlock(&all_mddevs_lock);
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
@@ -8390,6 +8331,8 @@ static int md_seq_show(struct seq_file *seq, void *v)
 	}
 	spin_unlock(&mddev->lock);
 
+	__mddev_put(mddev, true);
+
 	return 0;
 }
 
-- 
2.39.2

