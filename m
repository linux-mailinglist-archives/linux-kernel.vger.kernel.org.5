Return-Path: <linux-kernel+bounces-12657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2EE81F88C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED46B21476
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015410A23;
	Thu, 28 Dec 2023 12:58:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C5107AD;
	Thu, 28 Dec 2023 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T17pv4F0vz4f3k5f;
	Thu, 28 Dec 2023 20:58:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 267D91A017F;
	Thu, 28 Dec 2023 20:58:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQvmcI1lvcx3Ew--.36075S5;
	Thu, 28 Dec 2023 20:58:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	neilb@suse.de
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 1/3] md: remove redundant check of 'mddev->sync_thread'
Date: Thu, 28 Dec 2023 20:55:51 +0800
Message-Id: <20231228125553.2697765-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231228125553.2697765-1-yukuai1@huaweicloud.com>
References: <20231228125553.2697765-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHlQvmcI1lvcx3Ew--.36075S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1DCw4xAF1UCw4rKrWUXFb_yoWrAr18pa
	yIyF98Xr18Zry3XrWjy3WDXa45Zw1jgFZFyr93Wa48J3ZayF42kF45uFyUAFWkJas5Aa15
	Zw1rJFW5ZFy09w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The lifetime of sync_thread:

1) Set MD_RECOVERY_NEEDED and wake up daemon thread (by ioctl/sysfs or
   other events);
2) Daemon thread woke up, md_check_recovery() found that
   MD_RECOVERY_NEEDED is set:
   a) try to grab reconfig_mutex;
   b) set MD_RECOVERY_RUNNING;
   c) clear MD_RECOVERY_NEEDED, and then queue sync_work;
3) md_start_sync() choose sync_action, then register sync_thread;
4) md_do_sync() is done, set MD_RECOVERY_DONE and wake up daemon thread;
5) Daemon thread woke up, md_check_recovery() found that
   MD_RECOVERY_DONE is set:
   a) try to grab reconfig_mutex;
   b) unregister sync_thread;
   c) clear MD_RECOVERY_RUNNING and MD_RECOVERY_DONE;

Hence there is no such case that MD_RECOVERY_RUNNING is not set, while
sync_thread is registered.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c    | 14 ++++----------
 drivers/md/raid5.c |  6 ++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bdd57324c37..2208eed3baac 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3314,8 +3314,7 @@ static ssize_t new_offset_store(struct md_rdev *rdev,
 	if (kstrtoull(buf, 10, &new_offset) < 0)
 		return -EINVAL;
 
-	if (mddev->sync_thread ||
-	    test_bit(MD_RECOVERY_RUNNING,&mddev->recovery))
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	if (new_offset == rdev->data_offset)
 		/* reset is always permitted */
@@ -3993,8 +3992,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	 */
 
 	rv = -EBUSY;
-	if (mddev->sync_thread ||
-	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 	    mddev->reshape_position != MaxSector ||
 	    mddev->sysfs_active)
 		goto out_unlock;
@@ -6388,7 +6386,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		err = -EBUSY;
@@ -6441,7 +6438,6 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
 	    mddev->sysfs_active ||
-	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		mutex_unlock(&mddev->open_mutex);
@@ -7287,8 +7283,7 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 	 * of each device.  If num_sectors is zero, we find the largest size
 	 * that fits.
 	 */
-	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-	    mddev->sync_thread)
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	if (!md_is_rdwr(mddev))
 		return -EROFS;
@@ -7325,8 +7320,7 @@ static int update_raid_disks(struct mddev *mddev, int raid_disks)
 	if (raid_disks <= 0 ||
 	    (mddev->max_disks && raid_disks >= mddev->max_disks))
 		return -EINVAL;
-	if (mddev->sync_thread ||
-	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 	    test_bit(MD_RESYNCING_REMOTE, &mddev->recovery) ||
 	    mddev->reshape_position != MaxSector)
 		return -EBUSY;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 26e1e8a5e941..e3a216e51e3f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7025,10 +7025,8 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 	pr_debug("md/raid: change stripe_size from %lu to %lu\n",
 			conf->stripe_size, new);
 
-	if (mddev->sync_thread ||
-		test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-		mddev->reshape_position != MaxSector ||
-		mddev->sysfs_active) {
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	    mddev->reshape_position != MaxSector || mddev->sysfs_active) {
 		err = -EBUSY;
 		goto out_unlock;
 	}
-- 
2.39.2


