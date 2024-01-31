Return-Path: <linux-kernel+bounces-46149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815AD843B43
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B13128F941
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D446775E;
	Wed, 31 Jan 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l/FhzAmU"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C36773D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693891; cv=none; b=U//9eDS5pz5FQMRqr1cIKYGc8oD2CIDLm/E1NIM+id75H4KnPIm+UcKDoihSksi2dY0jsU7/NvcmD+YcvB0wVwgOsHj5zGZynHd1+GaVyFAVV+EYhXPXLCnjoUBPOlCJ/2wQW6R2JHzNSOX00XfZ6mrKs9kF7qrwS6qtf2Eb6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693891; c=relaxed/simple;
	bh=P9oCSEVSvI3I8NxFBzCwMHgI6aG8o8ztxBa28NA+uno=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=glT3uydGhKwBjut8aniuCYnxhDMESZKvwcR8fkVQRY4oxIS3c5Fl1ilUS18Q0+dVAmUnfGKI5uA91ZnLQk50N+m15NwLQi4A0bXY+x+cBklyKJhLbj67Mhim7gkFvN1m8KGWv+ZCZ+5ouI4mT3rhKP9noCn8ANO6mXlj85Bd6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l/FhzAmU; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706693884; bh=p0o02FUi1b8JvQdnhRH4R4WteCSwKGmKcl/ZjRkdDd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/FhzAmU8O6YmijlrqGS0xrLi98HJh5KWMb0DKdF46KiUJ1SMiZmn2CnuwvX+kOJj
	 K3mYY2+WNcPrlCqFJZ/mo9WQG1ylGKWh0Rj8FYHSokwVEzuYqUMzDwTIHaG5BzD6Ne
	 UFQg4Op5SqeC5auOG+GwQTD3i80ghwjOqhdZ+zsA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 9832AEBE; Wed, 31 Jan 2024 17:38:03 +0800
X-QQ-mid: xmsmtpt1706693883tafy3pex3
Message-ID: <tencent_48D4BAEFBB2133B89EC81B974B4A1B242508@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aO645nJ9CGVGSJdd4bz9P8UwSDScT1q/xnawKlJQ8idd1qIh3aM
	 Tx5HG242m8ujpb0DVF3W1LgwPIFAQyRUYzsdezj+lRtd5RSvKWdyD1qRdsP6yHFiGasfJR9hDYG3
	 VJKhyehhkGgRd6NKV587G69aXIT7YvNH8adK26KYTUYfJlA8YLyzXWHsbjF3jS32x4lAoJqVBzVP
	 j7eiGOp7SpgP44DHo5Nc5WVmfhMfDO8GsvlVzL6MIg6sDE1vxoWVvVdRDwvyUieQeKBpQgLTN0aU
	 xxy7sFPTE9tqnY75Y8zOSm5VsC/E7dlgWZwk3s2ERjU7opGsBYGQT1TNGN5SX80z4mBMspR4FNEc
	 S6BQ3fSLhNMcpvsIlH5lHRzjac9KUszuhU5I74nLQe9nF69ljT5iha5sfHKVXnD/jonPiGYBjn8I
	 Doh+ByNgbyZ7e0Nl0pKQPyavnZfMZUPKuJqzx1oIy0ZF9+xTAqDZGlLIAt7nULoVvu+yFJOt9fBI
	 9PjNj94Zf1NjgbjQ0wRm2zVQ7NhMyQp3DhybX6BnNTtEFONrrim8ygV8XJJMwLOfP6N2nuUnf6L1
	 T1JjQyUcLXWPojPNwAj/R3At0YFn3jb6n+H24ELHvLgL8LUBMJDeeym6mjsAAK6a2zez1NGchYUv
	 S4Kj+lm75MHIyoaUakM9iTrNklcmJiv3GPiD0mofqlYvnA2KYg9N4aadVDQYq/BwGDOmOaWDoKNB
	 ybELuqpoPVpQgJ0pY3y70rLeLXLxpk6IrNUz2Ne8kiImHYBNOWJPrImoyMtekA1oKOue5EjTj3jP
	 KUp0Dch4B9qQlNGhCJtiMnvLu0d/4lijmSRv8n+2bZ+5X9cd/o0DAcY4bUc4NNzmWVYYEe1/NvPZ
	 tKOpmoeVDK9p7ormD4sAMp19RbYIjK0BveXn8QIC6WXlRx3M+umZU2x/1xw/5QFZmsVzg+MfosJG
	 eIX4pgZqW64qtnFaPk+cZ4BE4Or2KJU1iHPnJHE/0QW44GvXrRNSY+wY9thque/83fQk4L1o4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 17:38:03 +0800
X-OQ-MSGID: <20240131093803.1049661-2-eadavis@qq.com>
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


