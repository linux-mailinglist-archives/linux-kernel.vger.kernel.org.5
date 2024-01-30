Return-Path: <linux-kernel+bounces-44441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33AE842215
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6979E1F2BF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B47664A9;
	Tue, 30 Jan 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Sq289lLa"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DDD65BC9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612391; cv=none; b=YvrOdCTs2l6/tzpQhvzPs6GPG9dC2rtFsXTsFB3CeIA38A4ry7KOV3MXtEGCtmkj8aFtp/vb18OXff8PLl3g1DQm1fCTqWo/xYHnxP3oZxTwtHKRqHgsODzE2xvCKWbEBz9WT/N9SIdUy/+sAIs1HeKOp1QRkNmpN2QCZYj9EXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612391; c=relaxed/simple;
	bh=GB2IybzwCWFKvSFD6TdEeL9jOEQsn9lbMsabAy/BvEk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XBEPjpbm7nZNag/sAsGYnt21Xg+1lrrMvY5WKjNBFi2x9WvKZzBArvpyjYxa/StlzE5sDWNYSSf93doklkCFyAsMk904gDiNar5orhuf+RonCKxx+p85jIrpPkufwFOSo1sqYaETYWpjV5ElCl71FKf5h4wrYU0HTO7aIt11VVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Sq289lLa; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706612386; bh=zb2voQHdwFouq3+bHsSfj3f+sdaaJqRfRDqSUKWcVqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sq289lLa+imgpUMSabocPeFmYCs8ajjrx9rfz9wUnOxJvW3eUxEGWmSdFWV7Ou7KI
	 Y8JDMbtktbsfgJF2M+oEHBTm7Ze0Dn1UayI/XeAn4JFaflefhXHR0S4/d10g4Drl3p
	 JmVcp4yEAq0u3Qf/nJ6f2F8aHYH4v+lsiwENc/mE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id D6B15CE0; Tue, 30 Jan 2024 18:53:43 +0800
X-QQ-mid: xmsmtpt1706612023tdu1foa1s
Message-ID: <tencent_185DA85DAC9919CFF40D99A5F00DFA121507@qq.com>
X-QQ-XMAILINFO: MgH8QHUHzFh7ennCN7xTm/B9Ev1wpdoKig/6PQiyPTfqIYNHA7Q660oAk2Ihuy
	 3UMmkJS3oHraVGekR/msbScZsAOdar30Nm4bYsekg0DQXUThgwgAzrGJeosSg+Q8I5n/rPjcOprn
	 VeoJoZkF7C46zJR6qNCyOSAcj+ZjgKqw5VyVXLiTT7jgaqnCD3z8IDkqnRstkF/Gacg1mf5e4oww
	 r0SHS23soSOts2K5qno8sZyN6JKbN8/ThXvgrzfPxlnRLWPLGP2zWWnWppTUZNmQ4XQ7KihzJcck
	 5mxHLKaOhA+cM7/V9E5RVWDdOiyg0KazKHlDf0zYq+1tAIjKHVoHn7ti92nZ/iuVieVdd7cGhEvJ
	 W0+0BGMbGVeGuKO9C5QH06puPzljTzbjaK+SzuBbKFjvnE08i+iFKH7nYW+z/0+HCdfpUjZMJFQb
	 TEgzvq99zfyS94/uKbgqL+VnPaw4dgHeogTjMTZlmoW0EjE/orbZ6Hg9MFimcOZgUpn4VjlrFoD0
	 qC+zIDhtWQSyQJ1bYFCtSWkypXFXoCO3WXh+u66vkZRpd75QqdM1QfTRPi+pkHluZbHIAHFGBvZu
	 b9WkUCJG9ge+Hlc9oNEbYR3LoVmNziXYlvjd1ynUedZKbeuqRwLa3zvyrMlwlwP/M46EPEmvNv5a
	 pETI1dQX1+VjpPgv475tI8lnQ7HxkfNg8cxo9gFeb86l+y1pno+Yz3OlfcMlTL+efbAIxFwkHv8l
	 xJYXNkv1H3+M22AKuOsXkEX5lfLdOCbTZzFvVF6zT1LkXi3e/Ca6a3FxN0LhDf38DD0RtUen1xKV
	 Bcvy8nCvosgihS6YEuyQbGudK3i5RTp9yOPHNhjqL+EY411esO6E9MG3NQeY/lKfv8UKav/j4+3W
	 DVRwj1cIF+K5VYF3gKvbRRgqKy9p1sVrrohpqgpE+Hu1UAyL0Iofxo5wX8HEir2JORb4cHkY4dRu
	 xrbDqTr5Zw0UQhBihvlSua4ZKq2TEe
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 18:53:43 +0800
X-OQ-MSGID: <20240130105342.3944585-2-eadavis@qq.com>
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
index d5d94510afd3..f3d02bf98a80 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -330,6 +330,13 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	kfree(bt);
 }
 
+static void blk_trace_free_rcu(struct blk_trace *bt)
+{
+	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
+	kfree(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -377,12 +384,36 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt) {
+		blk_trace_free_rcu(bt);
+	}
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
-	blk_trace_free(q, bt);
+	if (!bt->dir)
+		bt->debugfs_dir = q->debugfs_dir;
+	mutex_unlock(&q->debugfs_mutex);
+	relay_close(bt->rchan);
+	/*
+	 * If 'bt->dir' is not set, then both 'dropped' and 'msg' are created
+	 * under 'q->debugfs_dir', thus lookup and remove them.
+	 */
+	if (!bt->dir) {
+		debugfs_lookup_and_remove("dropped", bt->debugfs_dir);
+		debugfs_lookup_and_remove("msg", bt->debugfs_dir);
+	} else {
+		debugfs_remove(bt->dir);
+	}
 	put_probe_ref();
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


