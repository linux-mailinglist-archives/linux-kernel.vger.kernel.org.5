Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FFC7F0A66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjKTBoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 20:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTBox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:44:53 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08396E6;
        Sun, 19 Nov 2023 17:44:49 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SYVgF5k7Dz4f3lD6;
        Mon, 20 Nov 2023 09:44:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id F163B1A0169;
        Mon, 20 Nov 2023 09:44:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4LulplbmCcBQ--.47132S5;
        Mon, 20 Nov 2023 09:44:45 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH 1/2] block: introduce new field flags in block_device
Date:   Mon, 20 Nov 2023 17:38:46 +0800
Message-Id: <20231120093847.2228127-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120093847.2228127-1-yukuai1@huaweicloud.com>
References: <20231120093847.2228127-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4LulplbmCcBQ--.47132S5
X-Coremail-Antispam: 1UD129KBjvJXoW3JF17Zw4rKF1kuFykJF45GFg_yoWxKw4DpF
        Z8Kas0k3yUGF4xWa1kKa17JF4I9a10kw1xG3y3C34SvFZxtrsaqF1kGryjyFWIyrWxCFW7
        XFn8CrWUAry7urJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE2NtUUUUUU=
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are multiple switches in struct block_device, use seperate bool
fields for them is not gracefully. Add a new field flags and replace
swithes to a bit, there are no functional changes, and preapre to add
a new switch in the next patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c              | 15 ++++++++-------
 block/blk-core.c          |  7 ++++---
 block/genhd.c             |  8 +++++---
 block/ioctl.c             |  2 +-
 include/linux/blk_types.h | 12 ++++++------
 include/linux/blkdev.h    |  5 +++--
 6 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index fc8d28d77495..cb849bcf61ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
-	if (partno)
-		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
+	if (partno && test_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags))
+		set_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
 	else
-		bdev->bd_has_submit_bio = false;
+		clear_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
@@ -612,7 +612,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		bdev->bd_holder = NULL;
 		bdev->bd_holder_ops = NULL;
 		mutex_unlock(&bdev->bd_holder_lock);
-		if (bdev->bd_write_holder)
+		if (test_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags))
 			unblock = true;
 	}
 	if (!whole->bd_holders)
@@ -625,7 +625,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	 */
 	if (unblock) {
 		disk_unblock_events(bdev->bd_disk);
-		bdev->bd_write_holder = false;
+		clear_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags);
 	}
 }
 
@@ -878,9 +878,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		 * writeable reference is too fragile given the way @mode is
 		 * used in blkdev_get/put().
 		 */
-		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
+		if ((mode & BLK_OPEN_WRITE) &&
+		    !test_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags) &&
 		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
-			bdev->bd_write_holder = true;
+			set_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags);
 			unblock_events = false;
 		}
 	}
diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..577a693165d8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
 
 bool should_fail_request(struct block_device *part, unsigned int bytes)
 {
-	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
+	return test_bit(BD_FLAG_MAKE_IT_FAIL, &part->flags) &&
+		should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
@@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
-	if (!bio->bi_bdev->bd_has_submit_bio) {
+	if (!test_bit(BD_FLAG_HAS_SUBMIT_BIO, &bio->bi_bdev->flags)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 */
 	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_has_submit_bio)
+	else if (!test_bit(BD_FLAG_HAS_SUBMIT_BIO, &bio->bi_bdev->flags))
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..026f4c6d5b7e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	elevator_init_mq(disk->queue);
 
 	/* Mark bdev as having a submit_bio, if needed */
-	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
+	if (disk->fops->submit_bio)
+		set_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags);
 
 	/*
 	 * If the driver provides an explicit major number it also must provide
@@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 ssize_t part_fail_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
+	return sprintf(buf, "%d\n",
+		       test_bit(BD_FLAG_MAKE_IT_FAIL, &dev_to_bdev(dev)->flags));
 }
 
 ssize_t part_fail_store(struct device *dev,
@@ -1072,7 +1074,7 @@ ssize_t part_fail_store(struct device *dev,
 	int i;
 
 	if (count > 0 && sscanf(buf, "%d", &i) > 0)
-		dev_to_bdev(dev)->bd_make_it_fail = i;
+		set_bit(BD_FLAG_MAKE_IT_FAIL, &dev_to_bdev(dev)->flags);
 
 	return count;
 }
diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..a548c718a5fb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -394,7 +394,7 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_read_only = n;
+	set_bit(BD_FLAG_READ_ONLY, &bdev->flags);
 	return 0;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 52e264d5a830..95bd26c62655 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -37,17 +37,20 @@ struct bio_crypt_ctx;
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
+#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
+#define BD_FLAG_WRITE_HOLDER	1
+#define BD_FLAG_HAS_SUBMIT_BIO	2
+#define BD_FLAG_MAKE_IT_FAIL	3
+
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
 	struct gendisk *	bd_disk;
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
+	unsigned long		flags;
 	unsigned long		bd_stamp;
-	bool			bd_read_only;	/* read-only policy */
 	u8			bd_partno;
-	bool			bd_write_holder;
-	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
@@ -63,9 +66,6 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex; /* serialize freeze/thaw */
 
 	struct partition_meta_info *bd_meta_info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	bool			bd_make_it_fail;
-#endif
 	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9f6c3373f9fc..ec8382ecfcf1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -743,13 +743,14 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0->bd_read_only ||
+	return test_bit(BD_FLAG_READ_ONLY, &disk->part0->flags) ||
 		test_bit(GD_READ_ONLY, &disk->state);
 }
 
 static inline int bdev_read_only(struct block_device *bdev)
 {
-	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
+	return test_bit(BD_FLAG_READ_ONLY, &bdev->flags) ||
+		get_disk_ro(bdev->bd_disk);
 }
 
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
-- 
2.39.2

