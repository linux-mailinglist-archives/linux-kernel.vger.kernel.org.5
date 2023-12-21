Return-Path: <linux-kernel+bounces-7922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566581AF37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8B21F22F33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602CB156DA;
	Thu, 21 Dec 2023 07:13:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044DD309;
	Thu, 21 Dec 2023 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwhTt53ypz4f3jLc;
	Thu, 21 Dec 2023 15:13:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1AB7B1A49B8;
	Thu, 21 Dec 2023 15:13:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCn9QuB5YNlzFboEA--.31997S6;
	Thu, 21 Dec 2023 15:13:07 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/2] md: create symlink with disk holder after mddev resume
Date: Thu, 21 Dec 2023 15:11:09 +0800
Message-Id: <20231221071109.1562530-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221071109.1562530-1-linan666@huaweicloud.com>
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCn9QuB5YNlzFboEA--.31997S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyrAF13WFy7ArW7tFW7twb_yoWrWF4Up3
	ySga45KrWUJr9xXr4UtasxW3W5Xw18K397try3uryIga43twsIkr1rury5Xryrtas3ZFWD
	Xa15Xw4UuF18uFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	AKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfU1xhLUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There is a risk of deadlock when a process gets disk->open_mutex after
suspending mddev, because other processes may hold open_mutex while
submitting io. For example:

  T1				T2
  blkdev_open
   bdev_open_by_dev
    mutex_lock(&disk->open_mutex)
  				md_ioctl
  				 mddev_suspend_and_lock
  				  mddev_suspend
  				 md_add_new_disk
  				  bind_rdev_to_array
  				   bd_link_disk_holder
  				    //wait open_mutex
    blkdev_get_whole
     bdev_disk_changed
      efi_partition
       read_lba
        ...
         md_submit_bio
          md_handle_request
           //wait resume

Fix it by getting disk->open_mutex after mddev resume, iterating each
mddev->disk to create symlink for rdev which has not been created yet.
and moving bd_unlink_disk_holder() to mddev_unlock(), rdev has been
deleted from mddev->disks here, which can avoid concurrent bind and unbind,

Fixes: 1b0a2d950ee2 ("md: use new apis to suspend array for ioctls involed array reconfiguration")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d6612b922c76..c128570f2a5d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -521,6 +521,20 @@ void mddev_resume(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
+static void md_link_disk_holder(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rcu_read_lock();
+	rdev_for_each_rcu(rdev, mddev) {
+		if (test_bit(SymlinkCreated, &rdev->flags))
+			continue;
+		if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
+			set_bit(SymlinkCreated, &rdev->flags);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Generic flush handling for md
  */
@@ -902,6 +916,11 @@ void mddev_unlock(struct mddev *mddev)
 
 	list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
 		list_del_init(&rdev->same_set);
+		if (test_bit(SymlinkCreated, &rdev->flags)) {
+			bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
+			clear_bit(SymlinkCreated, &rdev->flags);
+		}
+		rdev->mddev = NULL;
 		kobject_del(&rdev->kobj);
 		export_rdev(rdev, mddev);
 	}
@@ -2526,8 +2545,6 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 		sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
 
 	list_add_rcu(&rdev->same_set, &mddev->disks);
-	if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
-		set_bit(SymlinkCreated, &rdev->flags);
 
 	/* May as well allow recovery to be retried once */
 	mddev->recovery_disabled++;
@@ -2562,14 +2579,9 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 {
 	struct mddev *mddev = rdev->mddev;
 
-	if (test_bit(SymlinkCreated, &rdev->flags)) {
-		bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
-		clear_bit(SymlinkCreated, &rdev->flags);
-	}
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
 	mddev_destroy_serial_pool(rdev->mddev, rdev);
-	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
 	sysfs_put(rdev->sysfs_unack_badblocks);
@@ -4667,8 +4679,10 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	if (err)
 		export_rdev(rdev, mddev);
 	mddev_unlock_and_resume(mddev);
-	if (!err)
+	if (!err) {
+		md_link_disk_holder(mddev);
 		md_new_event();
+	}
 	return err ? err : len;
 }
 
@@ -6606,6 +6620,7 @@ static void autorun_devices(int part)
 			}
 			autorun_array(mddev);
 			mddev_unlock_and_resume(mddev);
+			md_link_disk_holder(mddev);
 		}
 		/* on success, candidates will be empty, on error
 		 * it won't...
@@ -7832,8 +7847,12 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	    err != -EINVAL)
 		mddev->hold_active = 0;
 
-	md_ioctl_need_suspend(cmd) ? mddev_unlock_and_resume(mddev) :
-				     mddev_unlock(mddev);
+	if (md_ioctl_need_suspend(cmd)) {
+		mddev_unlock_and_resume(mddev);
+		md_link_disk_holder(mddev);
+	} else {
+		mddev_unlock(mddev);
+	}
 
 out:
 	if(did_set_md_closing)
-- 
2.39.2


