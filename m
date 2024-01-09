Return-Path: <linux-kernel+bounces-21443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE1828F2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC96A288B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B4F3EA83;
	Tue,  9 Jan 2024 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeRHfLRx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B343E496
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9c2db82b0so1739255b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836920; x=1705441720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izlcXhoLb/FAG4DF0HKozUrvfE6eFhoty+7/u8hPLcM=;
        b=VeRHfLRxMHXGshvC/XbwlLgYFOZP5QvcpSuOa40jBRXIszv7HfHrzEgcw9MT+ctQWi
         pHnM0k0iRHHN01Q+yT35MyrkUV9u7g3Y+uCB2hNVU0T42/B7oqv7c56l0jEYAGDyiuYz
         ZFKWRk0svq//FcDQ1V65oy8uxYAPEvzzX1barYm9KUNidvZT2jL+Q+CwzRpoOKEk6nYf
         LPBVPB90FPUdMDBvcz8TGg5ZNbMZ64XhocTIsuBDVcMvW89BJaNng3V3rugRQ+mQdFAI
         V2s1VsuBr77Z39cKIoRSABIqoNvEVRJaSa6cBy0uFo3EUFfB1JyfHXdj7r2mEeboxNsR
         Ctlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836920; x=1705441720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izlcXhoLb/FAG4DF0HKozUrvfE6eFhoty+7/u8hPLcM=;
        b=rb1guiTBYVjf4A9KBYLMIr++pE6lzPP4X+PPSj363ZDSPiVuVuyry20ubw2+opJFOH
         eYFqKkUBl1lJY1wuSDaIC+lbq6740EeQf3dW6Cjoo0u7FD4xU459M/eWSS29KXQwUV7g
         Oeb9ni4Mwe9txE7Ejnz96RMGUrNaX/j+cTNvRQjebfo5w9a63uOKAkDFemNcDjNYVcXv
         EuHMC8y4PqhuPoElsggAY0f/7/Hs3hkIEy9QtfFmLR7gmNztgGS83U0m/RuE8VA7+OnX
         FPm0p4IFHshOqDFFJnXtcqlpp0g5JpABoNmwqbuH3DsR9OfLi6hkh9jJtMtMEmC5Bc21
         02AA==
X-Gm-Message-State: AOJu0YzcywBGAnzbS/ALBMUI0NcDIMOinXdxzXa8ec9Nbr9ViXBcCjxc
	vGY38Bw+ILRJp66LXAz+hKA=
X-Google-Smtp-Source: AGHT+IGmU28IlHuXvLqJeWY3xL3CjJVWuDokBZO5qdGk/Fby5t8o6ScmGKz72RCyIwvgo62eI638Xw==
X-Received: by 2002:a05:6a00:4593:b0:6d9:b75e:ddc3 with SMTP id it19-20020a056a00459300b006d9b75eddc3mr133424pfb.33.1704836920078;
        Tue, 09 Jan 2024 13:48:40 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fd50])
        by smtp.gmail.com with ESMTPSA id j20-20020a056a00235400b006d9bcf301ffsm2111314pfj.194.2024.01.09.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:48:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: andrea.righi@canonical.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] kernfs: RCU protect kernfs_nodes and avoid kernfs_idr_lock in kernfs_find_and_get_node_by_id()
Date: Tue,  9 Jan 2024 11:48:04 -1000
Message-ID: <20240109214828.252092-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109214828.252092-1-tj@kernel.org>
References: <20240109214828.252092-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF helper bpf_cgroup_from_id() calls kernfs_find_and_get_node_by_id()
which acquires kernfs_idr_lock, which is an non-raw non-IRQ-safe lock. This
can lead to deadlocks as bpf_cgroup_from_id() can be called from any BPF
programs including e.g. the ones that attach to functions which are holding
the scheduler rq lock.

Consider the following BPF program:

  SEC("fentry/__set_cpus_allowed_ptr_locked")
  int BPF_PROG(__set_cpus_allowed_ptr_locked, struct task_struct *p,
	       struct affinity_context *affn_ctx, struct rq *rq, struct rq_flags *rf)
  {
	  struct cgroup *cgrp = bpf_cgroup_from_id(p->cgroups->dfl_cgrp->kn->id);

	  if (cgrp) {
		  bpf_printk("%d[%s] in %s", p->pid, p->comm, cgrp->kn->name);
		  bpf_cgroup_release(cgrp);
	  }
	  return 0;
  }

__set_cpus_allowed_ptr_locked() is called with rq lock held and the above
BPF program calls bpf_cgroup_from_id() within leading to the following
lockdep warning:

  =====================================================
  WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
  6.7.0-rc3-work-00053-g07124366a1d7-dirty #147 Not tainted
  -----------------------------------------------------
  repro/1620 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
  ffffffff833b3688 (kernfs_idr_lock){+.+.}-{2:2}, at: kernfs_find_and_get_node_by_id+0x1e/0x70

		and this task is already holding:
  ffff888237ced698 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0x4e/0xf0
  which would create a new lock dependency:
   (&rq->__lock){-.-.}-{2:2} -> (kernfs_idr_lock){+.+.}-{2:2}
  ...
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
  ...
  Call Trace:
   dump_stack_lvl+0x55/0x70
   dump_stack+0x10/0x20
   __lock_acquire+0x781/0x2a40
   lock_acquire+0xbf/0x1f0
   _raw_spin_lock+0x2f/0x40
   kernfs_find_and_get_node_by_id+0x1e/0x70
   cgroup_get_from_id+0x21/0x240
   bpf_cgroup_from_id+0xe/0x20
   bpf_prog_98652316e9337a5a___set_cpus_allowed_ptr_locked+0x96/0x11a
   bpf_trampoline_6442545632+0x4f/0x1000
   __set_cpus_allowed_ptr_locked+0x5/0x5a0
   sched_setaffinity+0x1b3/0x290
   __x64_sys_sched_setaffinity+0x4f/0x60
   do_syscall_64+0x40/0xe0
   entry_SYSCALL_64_after_hwframe+0x46/0x4e

Let's fix it by protecting kernfs_node and kernfs_root with RCU and making
kernfs_find_and_get_node_by_id() acquire rcu_read_lock() instead of
kernfs_idr_lock.

This adds an rcu_head to kernfs_node making it larger by 16 bytes on 64bit.
Combined with the preceding rearrange patch, the net increase is 8 bytes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <andrea.righi@canonical.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/kernfs/dir.c             | 31 ++++++++++++++++++++-----------
 fs/kernfs/kernfs-internal.h |  2 ++
 include/linux/kernfs.h      |  2 ++
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index bce1d7ac95ca..458519e416fe 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -529,6 +529,20 @@ void kernfs_get(struct kernfs_node *kn)
 }
 EXPORT_SYMBOL_GPL(kernfs_get);
 
+static void kernfs_free_rcu(struct rcu_head *rcu)
+{
+	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
+
+	kfree_const(kn->name);
+
+	if (kn->iattr) {
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	}
+
+	kmem_cache_free(kernfs_node_cache, kn);
+}
+
 /**
  * kernfs_put - put a reference count on a kernfs_node
  * @kn: the target kernfs_node
@@ -557,16 +571,11 @@ void kernfs_put(struct kernfs_node *kn)
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
 
-	kfree_const(kn->name);
-
-	if (kn->iattr) {
-		simple_xattrs_free(&kn->iattr->xattrs, NULL);
-		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
-	}
 	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
 	spin_unlock(&kernfs_idr_lock);
-	kmem_cache_free(kernfs_node_cache, kn);
+
+	call_rcu(&kn->rcu, kernfs_free_rcu);
 
 	kn = parent;
 	if (kn) {
@@ -575,7 +584,7 @@ void kernfs_put(struct kernfs_node *kn)
 	} else {
 		/* just released the root kn, free @root too */
 		idr_destroy(&root->ino_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 EXPORT_SYMBOL_GPL(kernfs_put);
@@ -715,7 +724,7 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	ino_t ino = kernfs_id_ino(id);
 	u32 gen = kernfs_id_gen(id);
 
-	spin_lock(&kernfs_idr_lock);
+	rcu_read_lock();
 
 	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
@@ -739,10 +748,10 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
-	spin_unlock(&kernfs_idr_lock);
+	rcu_read_unlock();
 	return kn;
 err_unlock:
-	spin_unlock(&kernfs_idr_lock);
+	rcu_read_unlock();
 	return NULL;
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 237f2764b941..b42ee6547cdc 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -49,6 +49,8 @@ struct kernfs_root {
 	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore	kernfs_iattr_rwsem;
 	struct rw_semaphore	kernfs_supers_rwsem;
+
+	struct rcu_head		rcu;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 03c3fb83ab9e..05dcbae7ecbf 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -224,6 +224,8 @@ struct kernfs_node {
 	u64			id;
 
 	struct kernfs_iattrs	*iattr;
+
+	struct rcu_head		rcu;
 };
 
 /*
-- 
2.43.0


