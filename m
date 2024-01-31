Return-Path: <linux-kernel+bounces-46142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7341B843B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F384285103
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BD6773B;
	Wed, 31 Jan 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bCKN3iUc"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DD62A09
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693536; cv=none; b=IxPdgPOhUVkL3FGAnyx6lDeX3vstA8A+TW0nGUf228V5tT5p+vWNmJwVyRuq1KBSD7C2nTnYD12Yicf4IYq4NbjgRWLvNxdVZ0Mgpjb7RhNn0iRwUuj+1VbaXlLVWNdot9HTH0yu/Ite6bu8UU9ocelOJgH2uOmB/K/0LrdBGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693536; c=relaxed/simple;
	bh=P9oCSEVSvI3I8NxFBzCwMHgI6aG8o8ztxBa28NA+uno=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cWkr9mhSrl9x6yUkUzUIharc7yMn34hXcFdmfA8UcTaXse5a9F/IvG2/FAkDprFxiqxSXA7mE6CSeCyZ9zyvgUB9ab7yP4KLSh3L/jbGKQchZoLjyLvxLc+xEbnENtHzYdWfTKeGF2las/QD5PREtQ1dfiLRNGEzd70BDGQq8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bCKN3iUc; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706693529; bh=p0o02FUi1b8JvQdnhRH4R4WteCSwKGmKcl/ZjRkdDd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bCKN3iUc0M4UuISkCWGn4Rl7kmnYN8kmzTxcGelY53uRD+jEf9XMK08voztaf9Ntb
	 X6+DmAu06sbBt9pRJEdQKQ7Gc925Vfni5PYCKxTncnc6gMbLcgKjSIq/fBids3HmSM
	 9T5MBT2bCzFvKtmjVa2z3xxGVe5QJ6j3uOYMV2Pc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 80782EF6; Wed, 31 Jan 2024 17:32:07 +0800
X-QQ-mid: xmsmtpt1706693527t6wlriikx
Message-ID: <tencent_EBBB1833609E1E1BFE4B201B0B259BBA3308@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2J9iSjPvrJYFDl2xkNUQwaRGrqXUCvTtCMoqcGgsx
	 mj4f7F/Zco19qE3vDz18Gf08yTVQRhsT0oQE/86n4VhUx3tGznaTBn39lY+a6y9rG2/qKm+/0BIS
	 6MJ+k/TqbLmWm48eQJP84m5Y5vG38L9cJeasz9+uzHKqpQrkuQmAL3dgHe/8IuXYR5N50414LIq9
	 /ouuVfpwGaxTtgGmXJrLqE2rHg7l5MdftCQa1buqT2rqlx5VRD5Psux/yAP9u5ubVzoaA706HeHW
	 62kUXumbosLQgF3r6UoPcbHv4Z/HuxDM6WW1fw1HMKKq9gWyj6XsWpVsv3WcpKjPxF/lqxNWh3zl
	 Q3X7VLktqUAWVX/cmLW1u3e5BJZ9wWkwEaG7hBscVb9MgG20dIj3ETuITO0+SWcPGs1kpAbFckzX
	 Q/h4vtJQlMHF4gDsL3rB/RKA9HFRM3bCJLzUDVhfNzV9/a8HA6PuSOfruwhpaQEeQhT2iyCyx+Cz
	 E01zDvjrjWfyMtYi7iQ0/ZSPI9bIRzgxZxGhhRGDi7KcwlNIolBv8QOUtAQj53xAxPnYo1N4u6Vo
	 /6xnkQhilPDNPyJUgZHskHOEtCSFuMJm1lQe2MVxKCkArwAAqMeKq1qCdUHQERMQssY32B30DdI6
	 EA9fPVxoc5XS3r1/7Esk+aQYNquUaBNUFjZJ2/huzUwHgqgvx0p2p3CiJO82ryqNnZuqzzi4yi3t
	 oDv6yCdKh7OgvgivrGxxhiz/c4Hh1CDuz2XPDQHz+HXHSug7kF+pT0gTtdrOBwCK6+N+l60JUOF6
	 HgMPbUdUvuzdZMBrGL7QRAoSKAM5HbSwx3kmCsbWwcC3SjuDL8ZL4rpCpGYy+27xARII8NhtG/QZ
	 RXZi+H856Z7fO6QchZgGJLJ8QOdsKNwAbuHBptpcOLmWsDjCyWnToydQQa0vAdqj/dSFOKupE1Nb
	 iARnPXUa1+ulLL3NI8cw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 17:32:08 +0800
X-OQ-MSGID: <20240131093207.1041375-2-eadavis@qq.com>
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


