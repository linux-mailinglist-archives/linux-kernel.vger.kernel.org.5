Return-Path: <linux-kernel+bounces-12976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DA81FDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D633E1F249B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719276FC4;
	Fri, 29 Dec 2023 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cBfCXyE0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF563A3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 289B03F18B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703836167;
	bh=SURP4bEXB3rOoVdDu2PinjzVHqssXg7lipQNHpdE17M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=cBfCXyE0vQyzTKbFPislpi3S15VJDsNMM4I0CxK1g14SKAY/p9wo5azKbWuMpH2dt
	 v1TEez7+fR9oorABH71tbFqMyqcPpDOcr99p4QfzLJA1JXZmutzt6bZbUNsUMZefKr
	 VBkDfBRa5v2Kt7qDhc1yYG85jFElpR/sOyLHKH1hn0X28ezEhGq6z7P95QifQFy+C6
	 I1jruzINgcmC5kiUou/mpJ+x8n/ZMoDDwctT7V7AG3Nikx49LcxFuyp2RbGQ8g9+R3
	 zISk8Ixoab7XmQ6s6H89hq0LBcMV2KpZEvlXUnZdgqeoedPzZuxkTpog+jDEBylCZi
	 TK4QO2p+3tBOQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5541f04f1e9so3554460a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 23:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703836166; x=1704440966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SURP4bEXB3rOoVdDu2PinjzVHqssXg7lipQNHpdE17M=;
        b=ZYSLxtwts7oXkIwcFP2bT7UkmySluH6qDuIZ3hjFVFcJ7zrvho25GoaJZSOWZOgM/s
         zSapyLzfmGiMtUHe+x4QRfHab4D6MGA16rNbT8b68US7Ut4b9cyXxvXJvvkOCjbnL/qC
         OMp2G1bYt2wjTQPTb8m6GqwyxK0rHkd2pr8zDitmx9dDewEBaVUhyY1SkVsYV8PYZkMY
         ccQJCTmaAwZSxbnGdGf/ckLpIkzpwAzJPrHzeJV/12f7bSELN1oJ+RmZgnRCa63Mbo6r
         iZVCizR/SYLYUWsz/5ZF1WPIA4aY6cQGD0u6p9jLVhVLWo6XroodTmV0IqHMfRKGDqGh
         FC0Q==
X-Gm-Message-State: AOJu0YyMdEkJWjsSC9ZadsneMK6c1iJwyRn7aDx9GW8KBDEufAVgITKu
	1LHrkkmpnLN7cJr6n3favffgCSGvaSIUc0z3i3GWwZkUgEGJ9DPIO0QnZ5Jy4R1O7CjRVWsi1EN
	8Nh1uz/M10MmB8NucW9g3O2TDx8SlS+7Mp9R+mXwaEXF7Eksn
X-Received: by 2002:a50:aa9a:0:b0:553:a093:a499 with SMTP id q26-20020a50aa9a000000b00553a093a499mr7613335edc.59.1703836165844;
        Thu, 28 Dec 2023 23:49:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvWzmkeznqahopxufXcyoGcGLOeklBVBN+9Ic3NkLjAsFzOqSwh+th/adSEtSbY1Twn3Xm/Q==
X-Received: by 2002:a50:aa9a:0:b0:553:a093:a499 with SMTP id q26-20020a50aa9a000000b00553a093a499mr7613331edc.59.1703836165337;
        Thu, 28 Dec 2023 23:49:25 -0800 (PST)
Received: from localhost.localdomain (host-95-246-75-161.retail.telecomitalia.it. [95.246.75.161])
        by smtp.gmail.com with ESMTPSA id a14-20020a50ff0e000000b0054d360bdfd6sm10733584edu.73.2023.12.28.23.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:49:24 -0800 (PST)
From: Andrea Righi <andrea.righi@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: convert kernfs_idr_lock to an irq safe raw spinlock
Date: Fri, 29 Dec 2023 08:49:16 +0100
Message-ID: <20231229074916.53547-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgroup_from_id() is basically a wrapper to cgroup_get_from_id(),
that is relying on kernfs to determine the right cgroup associated to
the target id.

As a kfunc, it has the potential to be attached to any function through
BPF, particularly in contexts where certain locks are held.

However, kernfs is not using an irq safe spinlock for kernfs_idr_lock,
that means any kernfs function that is acquiring this lock can be
interrupted and potentially hit bpf_cgroup_from_id() in the process,
triggering a deadlock.

For example, it is really easy to trigger a lockdep splat between
kernfs_idr_lock and rq->_lock, attaching a small BPF program to
__set_cpus_allowed_ptr_locked() that just calls bpf_cgroup_from_id():

 =====================================================
 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
 6.7.0-rc7-virtme #5 Not tainted
 -----------------------------------------------------
 repro/131 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 ffffffffb2dc4578 (kernfs_idr_lock){+.+.}-{2:2}, at: kernfs_find_and_get_node_by_id+0x1d/0x80

 and this task is already holding:
 ffff911cbecaf218 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0x50/0xc0
 which would create a new lock dependency:
  (&rq->__lock){-.-.}-{2:2} -> (kernfs_idr_lock){+.+.}-{2:2}

 but this new dependency connects a HARDIRQ-irq-safe lock:
  (&rq->__lock){-.-.}-{2:2}

 ... which became HARDIRQ-irq-safe at:
   lock_acquire+0xbf/0x2b0
   _raw_spin_lock_nested+0x2e/0x40
   scheduler_tick+0x5d/0x170
   update_process_times+0x9c/0xb0
   tick_periodic+0x27/0xe0
   tick_handle_periodic+0x24/0x70
   __sysvec_apic_timer_interrupt+0x64/0x1a0
   sysvec_apic_timer_interrupt+0x6f/0x80
   asm_sysvec_apic_timer_interrupt+0x1a/0x20
   memcpy+0xc/0x20
   arch_dup_task_struct+0x15/0x30
   copy_process+0x1ce/0x1eb0
   kernel_clone+0xac/0x390
   kernel_thread+0x6f/0xa0
   kthreadd+0x199/0x230
   ret_from_fork+0x31/0x50
   ret_from_fork_asm+0x1b/0x30

 to a HARDIRQ-irq-unsafe lock:
  (kernfs_idr_lock){+.+.}-{2:2}

 ... which became HARDIRQ-irq-unsafe at:
 ...
   lock_acquire+0xbf/0x2b0
   _raw_spin_lock+0x30/0x40
   __kernfs_new_node.isra.0+0x83/0x280
   kernfs_create_root+0xf6/0x1d0
   sysfs_init+0x1b/0x70
   mnt_init+0xd9/0x2a0
   vfs_caches_init+0xcf/0xe0
   start_kernel+0x58a/0x6a0
   x86_64_start_reservations+0x18/0x30
   x86_64_start_kernel+0xc5/0xe0
   secondary_startup_64_no_verify+0x178/0x17b

 other info that might help us debug this:

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(kernfs_idr_lock);
                                local_irq_disable();
                                lock(&rq->__lock);
                                lock(kernfs_idr_lock);
   <Interrupt>
     lock(&rq->__lock);

  *** DEADLOCK ***

Prevent this deadlock condition converting kernfs_idr_lock to a raw irq
safe spinlock.

The performance impact of this change should be negligible and it also
helps to prevent similar deadlock conditions with any other subsystems
that may depend on kernfs.

Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/kernfs/dir.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..9ce7d2872b55 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -27,7 +27,7 @@ static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
  */
 static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
-static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
+static DEFINE_RAW_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
@@ -539,6 +539,7 @@ void kernfs_put(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent;
 	struct kernfs_root *root;
+	unsigned long flags;
 
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
@@ -563,9 +564,9 @@ void kernfs_put(struct kernfs_node *kn)
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
 	kmem_cache_free(kernfs_node_cache, kn);
 
 	kn = parent;
@@ -607,6 +608,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	struct kernfs_node *kn;
 	u32 id_highbits;
 	int ret;
+	unsigned long irqflags;
 
 	name = kstrdup_const(name, GFP_KERNEL);
 	if (!name)
@@ -617,13 +619,13 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 		goto err_out1;
 
 	idr_preload(GFP_KERNEL);
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
 	if (ret >= 0 && ret < root->last_id_lowbits)
 		root->id_highbits++;
 	id_highbits = root->id_highbits;
 	root->last_id_lowbits = ret;
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
@@ -659,9 +661,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -702,8 +704,9 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	struct kernfs_node *kn;
 	ino_t ino = kernfs_id_ino(id);
 	u32 gen = kernfs_id_gen(id);
+	unsigned long flags;
 
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
 
 	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
@@ -727,10 +730,10 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
 	return kn;
 err_unlock:
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
 	return NULL;
 }
 
-- 
2.43.0


