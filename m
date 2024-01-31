Return-Path: <linux-kernel+bounces-46000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92000843914
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489971F22D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE75D72B;
	Wed, 31 Jan 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c0xtmx5z"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5887F5820A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689781; cv=none; b=akbPNDfMAlE/U4d6kJBTnPqpr5YJmEYEIHGBQLFNWpWdrduF7qrtjO+1zHy10a8sGNMQl5QCRR7TZKj01Fx8KKM+ig3p3Ql+M/lwrHsnF62KxEbJggmXlmua2jSQzE/2NAhGkoa66qkiiT2RoTN5Hd6HA2aVc1GtfoQRoVd2uDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689781; c=relaxed/simple;
	bh=P9oCSEVSvI3I8NxFBzCwMHgI6aG8o8ztxBa28NA+uno=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ejoSX+ejOUeV7Evs0VN7BVkNEj2CeYAUZoEe4E77inIh1+I53sWwHEegFC5VCaVO5+pCF7liUVzZHezzFdV/j35vPNwwSqn13C5dV0ti6KJRW6NJTui7sBPklVtogGRAPXK5HNflE/cV0vy55n9oPMzuzGkyJKFaZA32WYIZd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c0xtmx5z; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706689467; bh=p0o02FUi1b8JvQdnhRH4R4WteCSwKGmKcl/ZjRkdDd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0xtmx5zIwTBzrRKdBeHbT/Wjo5lgsoLIbnRthGiWdN1fTZ4XmuBjgJuYEEPt90Vb
	 cCh1OVA6QzDPhGZpkPDlj/cL4y/1bpUz6dWm3L8INyv3jqPKzuPvnD4FdW7jj3LsZY
	 72w8yMzRvNRHJHaZ9k2Lvow3szuorAyz/xTCTrGE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 4901D00A; Wed, 31 Jan 2024 16:18:16 +0800
X-QQ-mid: xmsmtpt1706689096twnw4h0ck
Message-ID: <tencent_248437564B1275D376C967E03D4336389609@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTqLDJ+oJttz7oP1x2EDtJFAio97nA0Sd9iXDO0ZndTqjlVKf3+1
	 Z/LtkWWDG9Y5hDRyB8wUjFZitfvGi3RSU5qDDemaUEA6oH2nuj0T5plcm2BR15VRHJrLjfRQml/J
	 Behge5TEPK4fzVWkQ/LlH2nWRa9H8nigj1iSjWLvsAXzx09RDUsuaoYbMkdOqrzbBAp2rUmlK8h1
	 Fv3SewblAT/IMDMPpgdGa4ZhUiAChDWMNhH/mia8k0hLcwIGv8cnlakq0GimyDY7Bq58xED2gyeL
	 mF7PHnvvMED5oDSGqhfDzFOslIHWaspSGQqjWOgBLsxbbAK4zOosJu2KjG/egkPYjaJzmgVu5MMb
	 f5nY5FktMQua6UfLHvZLVVvgJ6UMs6Lykr0PPERHHlI25lmtXQqP2zwlSAHWA8Fw7AzVXsLreYov
	 VjhflxIJ1+sTDLENrUN1zDy+O5TZb777eTfqCg0kD0VNXAr9t9V+aQuqTByyX566la4lwJ8+hd21
	 gCchWp5zvHWeZXlA/r7u8Z/lfBheuTTGn08WT6ePkcrIHZm5VWb0S+nPkviFRuVNrOd49XlV6tE4
	 poB+bmWCD62O6pb8P3Ak/KdOBvnbNi6d4uLk4/X8AWtuoUzJf6s0INkqSG728DLZSZkaqUBCTEBm
	 MYFYxFcumfnAB00YjprBaknFIwnReITEgPnvj1M6cfhJ4353bECKJt3Wmwk8aAOKm+YHUp9M1VaT
	 IVNYB6JNK9irCbXHtiZg6qrPgbdFnOzdFZt0rpcakNTITUNvo1z3SunNAxMSNWWGHimWM/h1izaY
	 ruWfXVhdmW4r4dfCnaOcRohAonTGUWyUozWRX9XzmWW/wa7Kp3VLHEvsrOLo6LbIBALWLkxQUvlZ
	 IZRsxCLmwuAp7/9nxteblPSSBvwi3vLHzoNlTbkrQS2xcRiIteVAWQiV0bghpZ2IdMIuD9PUohxl
	 impKR92vTsmHGPOHhBbA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 16:18:17 +0800
X-OQ-MSGID: <20240131081816.920688-2-eadavis@qq.com>
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
index d5d94510afd3..1af3c8aa78a3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,7 +311,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
-static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
+static void blk_trace_free_top(struct request_queue *q, struct blk_trace *bt)
 {
 	relay_close(bt->rchan);
 
@@ -325,11 +325,21 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	} else {
 		debugfs_remove(bt->dir);
 	}
+}
+
+static void blk_trace_free_bt(struct blk_trace *bt)
+{
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
 }
 
+static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
+{
+	blk_trace_free_top(q, bt);
+	blk_trace_free_bt(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -377,12 +387,23 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt)
+		blk_trace_free_bt(bt);
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
-	blk_trace_free(q, bt);
+	blk_trace_free_top(q, bt);
 	put_probe_ref();
+	mutex_unlock(&q->debugfs_mutex);
+	call_rcu(&bt->rcu, blk_trace_rcu_free);
+	mutex_lock(&q->debugfs_mutex);
 }
 
 static int __blk_trace_remove(struct request_queue *q)
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..5f927328b7e6 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -26,6 +26,7 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	struct rcu_head rcu;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);


