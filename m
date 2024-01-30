Return-Path: <linux-kernel+bounces-43821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF21841934
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACCDDB26ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729733717A;
	Tue, 30 Jan 2024 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BLNHwKIy"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A237163
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581463; cv=none; b=G1+wUjebMjA7uNMNeGpnoWu/O6rNUi6fjEAuWAop7bnOkYC2KYUkECVHRhMJUyQDPM6D4g5JtcSXCf8ODP+9KfyDyjGyu6Xxfs7OLvFHx5J35neFk1Kcp6NIfSce93BlwXv0DrszkY85OI+xwBdZbsAHOkKUqylZmTB8PeT1lyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581463; c=relaxed/simple;
	bh=IvdKvPT2p+UhTS7EYPWp0W952pSiLq+NXqaH8eQW6fg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MoqYzWYs6UDREhSWSsTqbIh3QpwF8jMrcIGpQKz8zennAwr7t0Qj2wFVS8aQj9n1mb8ovOAbdWMM5gXZ2EP9AWP7Yck6yO1Y3VltqvHjeSXpFuGWD8fVLo673AasiD03brT2D7FCiCuP18YGrzoPpxaYlWKVWvj+idZWYyP3Rus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BLNHwKIy; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706581450; bh=Wk/cAVcnz+aRbH5hyvDU84O9l59UFe/4YXlZOoNacsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLNHwKIyA3dzsANGvvFJvDmDAi5a0giMvE7djh7HAhqPhi74egrtUP9d5GbsSqaKz
	 mV51jIrRMcpLbjrxzieLH3qltwbH4tTH9ijGn03MZjgNKMlTFNWAH+ZYVW8CjVaxAD
	 yjBEBW/KbfVdeL1s4pFycMl9ODovhCiJTHrNe7vQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 3F58EEAA; Tue, 30 Jan 2024 10:15:53 +0800
X-QQ-mid: xmsmtpt1706580953tjn6gbu0b
Message-ID: <tencent_324B541BA3251CBAC1BB0F33A29EDF1B6E08@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zF/zgUJiJLT0u0hWVkTlOx4MfxCxhJYzvzeOBBgSxOlRKU1tm4C
	 7vwWjZbJ4Uz+cedSc9IC43uHqaX2pnw3Utm+xbwbZAHFFf3mVIakoophYbr21oydfkGxv5d8gDLe
	 qL7+G+N5x3R8m8q2PKfUreaLIEpkt7FNa6DK7xxSm5I/nEMa/Wfrfa5RoqBcgvS/jR6Hxm53PGKQ
	 PdJzwCu1lCmXYrdYuw2QWlF52NIVoQZ0eXfY/EENugdeN7TU1hCScIioYW8mX1uE1OoyNFKLFz1Q
	 m5AZtVSfmmUKm59zRooC8Vg3boI+t59GZX2zlmhtULTUEkTA/G48KgLkZ3GA6zIEHJm0acbesKS5
	 n+53ZPAv5Sw0a3VlQvNq1Z/yzErJQPg0MgF9SCdRColPTBwMqZ2RgY7SQW/TF9WYgyXbkbkaMBNs
	 l7ptyNN4yiqECiDBTe2/DQvcD0IPaBqWw/QJdxbP1yWd818qf/j1df2HCxy1iw3TOW/dF8w2lD/j
	 nvCiD7ab2ZcZGYNAv8UZ/U1deJkxldFr0JngWGiVVuCZ1f8YxoshpYw/7p3xLVYvmZs+m62x9UAj
	 P5Vzn3C5O5nDWz5Erp9Z36jQzpaECAomliB/SGDGYEY5baJefexmB6YkD0vVn9CPvJOkkt7FOq/s
	 wf067A4A5Mv2kysKqUiM2dIDaHpKfJYj3hdltI7p2nAWg20jkG7y60BmiicZYGaFXSJmyrYitL9K
	 of8BVhVjC+4FFOr7E8ZYN1WvGJK73/2RrOmPAPyF3q4IQj0OJVrUhJvRA13OTMVJOm1jJEI1v8OQ
	 8ihXVdAJsdR+VKV3dVolSbAwg65hoLs/gJgy+vDhcpxg0YHxdIIidKPC84EVxJRHuVrovzbAAGwE
	 n/9VY/pLF/j8z8zh0V75+XnwlZY2ZbQ3DlifIdyWV5+tMLVs783a6sH9eXfNe/jQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 10:15:54 +0800
X-OQ-MSGID: <20240130021553.3254750-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
References: <0000000000002b1fc7060fca3adf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in blk_trace_remove

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..ce5a1ed01d64 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -320,14 +320,16 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	 * under 'q->debugfs_dir', thus lookup and remove them.
 	 */
 	if (!bt->dir) {
-		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
-		debugfs_lookup_and_remove("msg", q->debugfs_dir);
+		struct dentry *debugfs_dir = q ? q->debugfs_dir : bt->debugfs_dir;
+
+		debugfs_lookup_and_remove("dropped", debugfs_dir);
+		debugfs_lookup_and_remove("msg", debugfs_dir);
 	} else {
 		debugfs_remove(bt->dir);
 	}
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
-	kfree(bt);
+	kfree_rcu(bt);
 }
 
 static void get_probe_ref(void)
@@ -377,12 +379,25 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt) {
+		blk_trace_free(NULL, bt);
+		put_probe_ref();
+	}
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
-	blk_trace_free(q, bt);
-	put_probe_ref();
+	if (!bt->dir)
+		bt->debugfs_dir = q->debugfs_dir;
+	mutex_unlock(&q->debugfs_mutex);
+	call_rcu(&bt->rcu, blk_trace_rcu_free);
+	mutex_lock(&q->debugfs_mutex);
 }
 
 static int __blk_trace_remove(struct request_queue *q)
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..4920c201bd12 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -26,6 +26,8 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	struct dentry  *debugfs_dir;
+	struct rcu_head rcu;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);


