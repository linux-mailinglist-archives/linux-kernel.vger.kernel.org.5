Return-Path: <linux-kernel+bounces-112228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F88887728
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E732842C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DB53A6;
	Sat, 23 Mar 2024 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w2mdwH9W"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973D33DD;
	Sat, 23 Mar 2024 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711173236; cv=none; b=f6sgipqwHeFaAXS4MXW1491PpyeBjgOh6Ky0eOg72n9j4c8hv7xDOIkL2QJyc6zE9u3JdqcSyxO3kClYY8bOaMKH+Wfpxhsy5wxs/vpXavFLu+DFxqr8a7qYCyS21ERo/QbXVf8Ew2UlNK1icfEjgAv5WGcUc48ogHic+8QJf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711173236; c=relaxed/simple;
	bh=bXaUhgRhlgaPkf0W2et6nNkdWKh7fK5E5pljYZH3PGk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eah58pQHM7+bx+9XaV3e5rkkz5s62+NoLOGD6r7XsMYhvdqWdgYMb7gtS6Ps3FmO8J3A124EVap3j/g9aVl6Gq9Ej4yQmJd4x2xezrxqkHVuBRKgTf1pE0l2t2b+Ig5vxLpMFHvARaT1fYADbRhMFZuOeSQ/FBJsQ8CX8xweMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w2mdwH9W; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711172925; bh=pWdL3j2CHbA+clccoOVAV3AQGQIYceCGblDMDmSDSVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w2mdwH9WMMRBfPpSX2MjR+oem1yTx8KyZl2q9PcWS1KMDyctC0D0sJXqt/+bNr4Fr
	 8WDMe2F87NPl+ZNTVV5Wive5UeR4Iv724otOUdLv4wSsSl3N6qYpss4ryuUDtMFWcj
	 SM7+Xr0tYOQ+qMZYIEwVPozPdV9NzEwgXP9U8dww=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id A9DA5009; Sat, 23 Mar 2024 13:42:29 +0800
X-QQ-mid: xmsmtpt1711172549tpzws66rh
Message-ID: <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
X-QQ-XMAILINFO: N8tT1W7MFzrwsCvk5mtuk67Wi6U5Lr0QflSZuTnuWzXvu/UeoDgsR360XsSe5s
	 cOlgO5QMkhbJqWgn2Rn3YdZMv/730utyABRIqKL2+fyu0Q4/PGUR2w8Obf+UUG/YPY89jH9DNoFf
	 vN91yOS5GjkTEq3dS2nEIFH/D9/lYGOkql1VFl/ZMKVDrgiuSM/Z0NqXSuU1PFc7OCdbzK4D40Dd
	 tL7WKeCEfV5yyTZls3+fCxB31WXXq7xKJx8jKzKCQSZR3V5qbYHuHFo26XLwaJ8DyB8IMrkW16B3
	 lUpxXmNZpfPIZYiowgGVgh0XUm6QG1mPZtmkMenr0VrVwnVjL3QfMyJb8fKlRwOSmN1voQx0wdlT
	 CXXMU1MS0OJlqnMSVEAdGQysFf7AHhQxYviEJCrPqsrQIunKlKlza55nyaCfEU/bSDhjg+IoUw4S
	 oRAdxvoYtOgoxVOTb+xE2Gp5IV1dUPHOaw9jZZUOwZ5KFu2rthzcYTRVjCxRwLIxo9hJkCO+bSW9
	 z1HaN2GP0Qdlxqh3aoz+yezqk+j4BJ9xpLfACD7n0RqbJ957Y3XABrwU7O23rPJdP3hWtQaxdNEP
	 5KhIRdye/9ixUv1NznbFk0rN9R4DWWaH3IYOQ6vmvnygUuq2DXO978Xlf5XpUejl7sZhsT9yajPy
	 jvQ64o2ymLseVkso4e0NbXzG+v/DVq5Zu1IzCwonSJRFeWc6vlaZVmKEy0bhBEgWOHYpg80a6y53
	 5jhVQKZe9xVaHTiqb6/cTihtGS3CyemvYlXB6exEN1u6/XVnto0GDLtQv/f+CboqMqbfa95H4VSH
	 f2n1FyFk89f+dMF8vyhCCGf2UNS3vUkC6FTVNf1qVvv4TVTNq7cSsQcmZW19VJBjYG0nY+CpIsex
	 zOqESM/+dV0xy26egyZzP+LbDpSRARQA0AYMBTAQywXTAUPrnPhU7z3odJj7GQan/c2vWa9uZ4/o
	 NW4uMJRMY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com
Cc: 42.hyeyoo@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	kafai@fb.com,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peterz@infradead.org,
	songliubraving@fb.com,
	syzkaller-bugs@googlegroups.com,
	yhs@fb.com
Subject: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Date: Sat, 23 Mar 2024 13:42:30 +0800
X-OQ-MSGID: <20240323054229.3871557-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000dc9aca0613ec855c@google.com>
References: <000000000000dc9aca0613ec855c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05221-gea80e3ed09ab #0 Not tainted
-----------------------------------------------------
rcu_exp_gp_kthr/18 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
which would create a new lock dependency:
 (rcu_node_0){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (rcu_node_0){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  rcu_report_exp_cpu_mult+0x27/0x2f0 kernel/rcu/tree_exp.h:238
  csd_do_func kernel/smp.c:133 [inline]
  __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
  __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
  instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
  sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
  __sanitizer_cov_trace_switch+0x90/0x120
  update_event_printk kernel/trace/trace_events.c:2750 [inline]
  trace_event_eval_update+0x311/0xf90 kernel/trace/trace_events.c:2922
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
  0xffffffffa0001b0e
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
  trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
  __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
  futex_cleanup_begin kernel/futex/core.c:1091 [inline]
  futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
  exit_mm_release+0x1a/0x30 kernel/fork.c:1652
  exit_mm+0xb0/0x310 kernel/exit.c:542
  do_exit+0x99e/0x27e0 kernel/exit.c:865
  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
  __do_sys_exit_group kernel/exit.c:1038 [inline]
  __se_sys_exit_group kernel/exit.c:1036 [inline]
  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
  do_syscall_64+0xfb/0x240
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(rcu_node_0);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(rcu_node_0);

 *** DEADLOCK ***
[Fix]
Ensure that the context interrupt state is the same before and after using the
bucket->lock.

Reported-and-tested-by: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/core/sock_map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..ae8f81b26e16 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
@@ -1136,6 +1137,7 @@ static void sock_hash_free(struct bpf_map *map)
 	struct bpf_shtab_elem *elem;
 	struct hlist_node *node;
 	int i;
+	unsigned long flags;
 
 	/* After the sync no updates or deletes will be in-flight so it
 	 * is safe to walk map and remove entries without risking a race
@@ -1151,11 +1153,11 @@ static void sock_hash_free(struct bpf_map *map)
 		 * exists, psock exists and holds a ref to socket. That
 		 * lets us to grab a socket ref too.
 		 */
-		spin_lock_bh(&bucket->lock);
+		spin_lock_irqsave(&bucket->lock, flags);
 		hlist_for_each_entry(elem, &bucket->head, node)
 			sock_hold(elem->sk);
 		hlist_move_list(&bucket->head, &unlink_list);
-		spin_unlock_bh(&bucket->lock);
+		spin_unlock_irqrestore(&bucket->lock, flags);
 
 		/* Process removed entries out of atomic context to
 		 * block for socket lock before deleting the psock's
-- 
2.43.0


