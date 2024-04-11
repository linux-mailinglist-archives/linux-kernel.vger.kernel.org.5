Return-Path: <linux-kernel+bounces-140149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00E8A0C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114EF287146
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91241442FD;
	Thu, 11 Apr 2024 09:14:59 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4D142E61;
	Thu, 11 Apr 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826899; cv=none; b=a1xOoaSR9iQnviAoiRrF0/b7RrC09AjF6buNhUtnd6/jXf+lQhRqPBycdmxjVNuexnVOnlHnitrA5Ll+3RR+OAofXIlU21HVij9OiX5ai8/99gL8eLbn1cKwTSXxemJG6W6Daf+3fj0e6wYutR2hxdwuyTEgTNV0a5cYgWClxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826899; c=relaxed/simple;
	bh=KqGU897vzhzDZW5OmesbDqaBreTgT2QjXAuJtDUvnmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JknlcrOl5F/Bo7rlxrGzOWe8iWFciYfV1O1nVmirkfK1QtEX/w/sEc+PiWwPIZAh1JgVKtJj547ES6vIqwKbUfNJbeka+MC7+Jy+USkaHE65lhcAD4+Bq+qxE6kW3dev2zJyc00O5teDPK7a0nhQjScXrah4+faVSPEJgCMqzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VFYsf5251z1wr5r;
	Thu, 11 Apr 2024 17:13:58 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A67418002F;
	Thu, 11 Apr 2024 17:14:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemd100001.china.huawei.com
 (7.185.36.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 11 Apr
 2024 17:14:53 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<mpatocka@redhat.com>, <torvalds@linux-foundation.org>, <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<msnitzer@redhat.com>, <ignat@cloudflare.com>, <damien.lemoal@wdc.com>,
	<bob.liu@oracle.com>, <houtao1@huawei.com>, <nhuck@google.com>,
	<peterz@infradead.org>, <mingo@elte.hu>, <yukuai3@huawei.com>,
	<yangerkun@huawei.com>, <yi.zhang@huawei.com>, <lilingfeng3@huawei.com>,
	<lilingfeng@huaweicloud.com>
Subject: [PATCH 6.6] Revert "dm-crypt, dm-verity: disable tasklets"
Date: Thu, 11 Apr 2024 17:15:39 +0800
Message-ID: <20240411091539.361470-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100001.china.huawei.com (7.185.36.94)

This reverts commit 5735a2671ffb70ea29ca83969fe01316ee2ed6fc which is
commit 0a9bab391e336489169b95cb0d4553d921302189 upstream.

Tasklet is thought to cause memory corruption [1], so it was disabled in
dm-crypt and dm-verity. However, memory corruption may not happen since
cc->io_queue is created without WQ_UNBOUND [2].
Revert commit 5735a2671ffb ("dm-crypt, dm-verity: disable tasklets") to
bring tasklet back.

[1] https://lore.kernel.org/all/d390d7ee-f142-44d3-822a-87949e14608b@suse.de/T/
[2] https://lore.kernel.org/all/4d331659-badd-749d-fba1-271543631a8a@huawei.com/

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/dm-crypt.c         | 38 +++++++++++++++++++++++++++++++++--
 drivers/md/dm-verity-target.c | 26 ++++++++++++++++++++++--
 drivers/md/dm-verity.h        |  1 +
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index aa6bb5b4704b..a60d91d02e28 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -75,8 +75,10 @@ struct dm_crypt_io {
 	struct bio *base_bio;
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool:1;
+	bool in_tasklet:1;
 
 	struct work_struct work;
+	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -1775,6 +1777,7 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
+	io->in_tasklet = false;
 	atomic_set(&io->io_pending, 0);
 }
 
@@ -1785,6 +1788,13 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
 
 static void kcryptd_queue_read(struct dm_crypt_io *io);
 
+static void kcryptd_io_bio_endio(struct work_struct *work)
+{
+	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
+
+	bio_endio(io->base_bio);
+}
+
 /*
  * One of the bios was finished. Check for completion of
  * the whole request and correctly clean up the buffer.
@@ -1817,6 +1827,20 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 
 	base_bio->bi_status = error;
 
+	/*
+	 * If we are running this function from our tasklet,
+	 * we can't call bio_endio() here, because it will call
+	 * clone_endio() from dm.c, which in turn will
+	 * free the current struct dm_crypt_io structure with
+	 * our tasklet. In this case we need to delay bio_endio()
+	 * execution to after the tasklet is done and dequeued.
+	 */
+	if (io->in_tasklet) {
+		INIT_WORK(&io->work, kcryptd_io_bio_endio);
+		queue_work(cc->io_queue, &io->work);
+		return;
+	}
+
 	bio_endio(base_bio);
 }
 
@@ -2291,6 +2315,11 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
+static void kcryptd_crypt_tasklet(unsigned long work)
+{
+	kcryptd_crypt((struct work_struct *)work);
+}
+
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
@@ -2302,10 +2331,15 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
 		 * it is being executed with irqs disabled.
 		 */
-		if (!(in_hardirq() || irqs_disabled())) {
-			kcryptd_crypt(&io->work);
+		if (in_hardirq() || irqs_disabled()) {
+			io->in_tasklet = true;
+			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
+			tasklet_schedule(&io->tasklet);
 			return;
 		}
+
+		kcryptd_crypt(&io->work);
+		return;
 	}
 
 	INIT_WORK(&io->work, kcryptd_crypt);
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 49e4a35d7019..0bb126eadc0d 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -701,6 +701,23 @@ static void verity_work(struct work_struct *w)
 	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
 }
 
+static void verity_tasklet(unsigned long data)
+{
+	struct dm_verity_io *io = (struct dm_verity_io *)data;
+	int err;
+
+	io->in_tasklet = true;
+	err = verity_verify_io(io);
+	if (err == -EAGAIN || err == -ENOMEM) {
+		/* fallback to retrying with work-queue */
+		INIT_WORK(&io->work, verity_work);
+		queue_work(io->v->verify_wq, &io->work);
+		return;
+	}
+
+	verity_finish_io(io, errno_to_blk_status(err));
+}
+
 static void verity_end_io(struct bio *bio)
 {
 	struct dm_verity_io *io = bio->bi_private;
@@ -713,8 +730,13 @@ static void verity_end_io(struct bio *bio)
 		return;
 	}
 
-	INIT_WORK(&io->work, verity_work);
-	queue_work(io->v->verify_wq, &io->work);
+	if (static_branch_unlikely(&use_tasklet_enabled) && io->v->use_tasklet) {
+		tasklet_init(&io->tasklet, verity_tasklet, (unsigned long)io);
+		tasklet_schedule(&io->tasklet);
+	} else {
+		INIT_WORK(&io->work, verity_work);
+		queue_work(io->v->verify_wq, &io->work);
+	}
 }
 
 /*
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index db93a91169d5..7e495cc375b0 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -87,6 +87,7 @@ struct dm_verity_io {
 	bool in_tasklet;
 
 	struct work_struct work;
+	struct tasklet_struct tasklet;
 
 	char *recheck_buffer;
 
-- 
2.31.1


