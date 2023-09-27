Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5837AFAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjI0GTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjI0GS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:18:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F83611F;
        Tue, 26 Sep 2023 23:18:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RwRJQ3jH6z4f3l6j;
        Wed, 27 Sep 2023 14:18:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt1IyRNl_QoCBg--.53663S6;
        Wed, 27 Sep 2023 14:18:51 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3 2/2] md: simplify md_seq_ops
Date:   Wed, 27 Sep 2023 14:12:41 +0800
Message-Id: <20230927061241.1552837-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt1IyRNl_QoCBg--.53663S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47XF18KrWDCw4kCr4Durg_yoWrZF1Dpa
        nI9FW3Ar48Z3yFqa1DJa1Du3W5Jws7t34qgr9rG3s3Cr1jqr13u3WaqF40qr90gayUWrn0
        qw4UKa4UurWxG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
directly, and move printing "Personalities" to md_seq_start(),
"unsed devices" to md_seq_stop():

1) md_seq_start print Personalities, and then set pos to first mddev;
2) md_seq_show show mddev;
3) md_seq_next update pos to next mddev;
4) loop 2-3 until the last mddev;
5) md_seq_stop print unsed devices;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 100 +++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 78 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 73782cafad4e..0b83a406e797 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8213,105 +8213,46 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
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
@@ -8382,6 +8323,9 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
+	spin_lock(&all_mddevs_lock);
+	if (atomic_dec_and_test(&mddev->active))
+		__mddev_put(mddev);
 
 	return 0;
 }
-- 
2.39.2

