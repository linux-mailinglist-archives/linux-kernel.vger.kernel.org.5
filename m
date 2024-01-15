Return-Path: <linux-kernel+bounces-26262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48A282DDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED69D1C21E29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C817BBF;
	Mon, 15 Jan 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgDoN47J"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370417BAD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b5155e154so110199215e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705336513; x=1705941313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEWF69uVUs8R32BBiybL7zCkXeSNsJv9h+1LnOsNrLk=;
        b=fgDoN47JmMQynRVqOYbb+O9xdz1xs7r4UHEA70AoHI7sYozdxFbvPRnfp1Yo6Hkf6E
         HTdFQYfe82aJmpi5P3FMOyHf6ow3q2jiyyS25/cfHlISGEpqa9MCqFLsgmhyl0a89y54
         c+9wYfpVg2mOfAgnU8GAeTE9Y7Y4GpDjBSw0qR8uy5nLx9/BYm+AYMCqSwXU8bXEVaqJ
         07/mcnWvPI1zmJeX592PLnUby8laNF8tz5p23E9tF9uSPn8TllwKAJlxndX/fxoOTSDk
         KYj0kHkMCA1ijxZdgg5h+9BHY5vU++fi1psj/taE8eRUPdwmCmFX350CkbCTgzZxiDmV
         rgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705336513; x=1705941313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEWF69uVUs8R32BBiybL7zCkXeSNsJv9h+1LnOsNrLk=;
        b=Io0SaAnHcqoLPkxJ+4snDfDBQuJAViy8hfIgIcYEtlgz6tqFcr6+DyAw7ruN2pojB0
         OBoPN4/qZXmDZgRTnHnhjaaBFihmIJfPGPQC7iH/QmL0ZuXJIgxGBnDQBoWe1IfbJCfc
         yxnR0tnjTDtmDJPvEMFWCmg5DPlvS/rE1di7T6bBORxDyD6JSXz0j30Shb4V1zK5zFrZ
         6s7sHyRIKbp+0U1yDwmAp/LahaqZs5OYxXDEf++n/oxLvzcGG/09eyiwh+vilV0zout/
         bsUE9YYKu6Tq+xJZ16gnVub5qlK2KpHZkDVzcWZpxgu3aUUuYy7yzNRKl7w/nI4aWqfK
         HiTQ==
X-Gm-Message-State: AOJu0YwnoZT7fPW6EbbiPTGVJAFwTrghKc+mJzQeAh4Mxy/Vig0b3qwX
	yjbSf6qyhmkLyBmH+G72sfQ8ut/bRmAXqw==
X-Google-Smtp-Source: AGHT+IHPD3fXTk/O8LHvrxdnm5Dr1AHBDa4+FOF3pfEsrnIr290tHFLNseXX/h6/D7IIf9eGmup+XQ==
X-Received: by 2002:a05:600c:3586:b0:40e:692b:1b09 with SMTP id p6-20020a05600c358600b0040e692b1b09mr2253244wmq.248.1705336512343;
        Mon, 15 Jan 2024 08:35:12 -0800 (PST)
Received: from yjn-Lenovo-V14-G2-ITL.Speedport_W_724V_01011603_07_008 (p200300cddf2975c0e82cbdfbfd5fadcf.dip0.t-ipconnect.de. [2003:cd:df29:75c0:e82c:bdfb:fd5f:adcf])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0040e53f24ceasm16420781wmq.16.2024.01.15.08.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:35:11 -0800 (PST)
From: York Jasper Niebuhr <yjnworkstation@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: mm_struct randomized_struct_fields_(start/end)
Date: Mon, 15 Jan 2024 17:34:29 +0100
Message-Id: <20240115163429.419566-1-yjnworkstation@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be consistent with the task_struct, the mm_struct should probably use
the randomized_struct_fields_(start/end) macros too. Also the lines are
shorter this way.

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>

---
 include/linux/mm_types.h | 380 ++++++++++++++++++++-------------------
 1 file changed, 193 insertions(+), 187 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..3e80c9d24238 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -732,253 +732,259 @@ struct mm_cid {
 struct kioctx_table;
 struct iommu_mm_data;
 struct mm_struct {
+	randomized_struct_fields_start
+
+	/*
+	 * Fields which are often written to are placed in a separate
+	 * cache line.
+	 */
 	struct {
-		/*
-		 * Fields which are often written to are placed in a separate
-		 * cache line.
+		/**
+		 * @mm_count: The number of references to &struct
+		 * mm_struct (@mm_users count as 1).
+		 *
+		 * Use mmgrab()/mmdrop() to modify. When this drops to
+		 * 0, the &struct mm_struct is freed.
 		 */
-		struct {
-			/**
-			 * @mm_count: The number of references to &struct
-			 * mm_struct (@mm_users count as 1).
-			 *
-			 * Use mmgrab()/mmdrop() to modify. When this drops to
-			 * 0, the &struct mm_struct is freed.
-			 */
-			atomic_t mm_count;
-		} ____cacheline_aligned_in_smp;
+		atomic_t mm_count;
+	} ____cacheline_aligned_in_smp;
 
-		struct maple_tree mm_mt;
+	struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
-		unsigned long (*get_unmapped_area) (struct file *filp,
-				unsigned long addr, unsigned long len,
-				unsigned long pgoff, unsigned long flags);
+	unsigned long (*get_unmapped_area)(struct file *filp,
+			unsigned long addr, unsigned long len,
+			unsigned long pgoff, unsigned long flags);
 #endif
-		unsigned long mmap_base;	/* base of mmap area */
-		unsigned long mmap_legacy_base;	/* base of mmap area in bottom-up allocations */
+	unsigned long mmap_base;	/* base of mmap area */
+	unsigned long mmap_legacy_base;	/* base of mmap area in bottom-up allocations */
 #ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
-		/* Base addresses for compatible mmap() */
-		unsigned long mmap_compat_base;
-		unsigned long mmap_compat_legacy_base;
+	/* Base addresses for compatible mmap() */
+	unsigned long mmap_compat_base;
+	unsigned long mmap_compat_legacy_base;
 #endif
-		unsigned long task_size;	/* size of task vm space */
-		pgd_t * pgd;
+	unsigned long task_size;	/* size of task vm space */
+	pgd_t *pgd;
 
 #ifdef CONFIG_MEMBARRIER
-		/**
-		 * @membarrier_state: Flags controlling membarrier behavior.
-		 *
-		 * This field is close to @pgd to hopefully fit in the same
-		 * cache-line, which needs to be touched by switch_mm().
-		 */
-		atomic_t membarrier_state;
+	/**
+	 * @membarrier_state: Flags controlling membarrier behavior.
+	 *
+	 * This field is close to @pgd to hopefully fit in the same
+	 * cache-line, which needs to be touched by switch_mm().
+	 */
+	atomic_t membarrier_state;
 #endif
 
-		/**
-		 * @mm_users: The number of users including userspace.
-		 *
-		 * Use mmget()/mmget_not_zero()/mmput() to modify. When this
-		 * drops to 0 (i.e. when the task exits and there are no other
-		 * temporary reference holders), we also release a reference on
-		 * @mm_count (which may then free the &struct mm_struct if
-		 * @mm_count also drops to 0).
-		 */
-		atomic_t mm_users;
+	/**
+	 * @mm_users: The number of users including userspace.
+	 *
+	 * Use mmget()/mmget_not_zero()/mmput() to modify. When this
+	 * drops to 0 (i.e. when the task exits and there are no other
+	 * temporary reference holders), we also release a reference on
+	 * @mm_count (which may then free the &struct mm_struct if
+	 * @mm_count also drops to 0).
+	 */
+	atomic_t mm_users;
 
 #ifdef CONFIG_SCHED_MM_CID
-		/**
-		 * @pcpu_cid: Per-cpu current cid.
-		 *
-		 * Keep track of the currently allocated mm_cid for each cpu.
-		 * The per-cpu mm_cid values are serialized by their respective
-		 * runqueue locks.
-		 */
-		struct mm_cid __percpu *pcpu_cid;
-		/*
-		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
-		 *
-		 * When the next mm_cid scan is due (in jiffies).
-		 */
-		unsigned long mm_cid_next_scan;
+	/**
+	 * @pcpu_cid: Per-cpu current cid.
+	 *
+	 * Keep track of the currently allocated mm_cid for each cpu.
+	 * The per-cpu mm_cid values are serialized by their respective
+	 * runqueue locks.
+	 */
+	struct mm_cid __percpu *pcpu_cid;
+	/*
+	 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
+	 *
+	 * When the next mm_cid scan is due (in jiffies).
+	 */
+	unsigned long mm_cid_next_scan;
 #endif
 #ifdef CONFIG_MMU
-		atomic_long_t pgtables_bytes;	/* size of all page tables */
+	atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
-		int map_count;			/* number of VMAs */
+	int map_count;			/* number of VMAs */
 
-		spinlock_t page_table_lock; /* Protects page tables and some
-					     * counters
-					     */
-		/*
-		 * With some kernel config, the current mmap_lock's offset
-		 * inside 'mm_struct' is at 0x120, which is very optimal, as
-		 * its two hot fields 'count' and 'owner' sit in 2 different
-		 * cachelines,  and when mmap_lock is highly contended, both
-		 * of the 2 fields will be accessed frequently, current layout
-		 * will help to reduce cache bouncing.
-		 *
-		 * So please be careful with adding new fields before
-		 * mmap_lock, which can easily push the 2 fields into one
-		 * cacheline.
-		 */
-		struct rw_semaphore mmap_lock;
+	spinlock_t page_table_lock; /* Protects page tables and some
+				     * counters
+				     */
+	/*
+	 * With some kernel config, the current mmap_lock's offset
+	 * inside 'mm_struct' is at 0x120, which is very optimal, as
+	 * its two hot fields 'count' and 'owner' sit in 2 different
+	 * cachelines,  and when mmap_lock is highly contended, both
+	 * of the 2 fields will be accessed frequently, current layout
+	 * will help to reduce cache bouncing.
+	 *
+	 * So please be careful with adding new fields before
+	 * mmap_lock, which can easily push the 2 fields into one
+	 * cacheline.
+	 */
+	struct rw_semaphore mmap_lock;
 
-		struct list_head mmlist; /* List of maybe swapped mm's.	These
-					  * are globally strung together off
-					  * init_mm.mmlist, and are protected
-					  * by mmlist_lock
-					  */
+	struct list_head mmlist; /* List of maybe swapped mm's.	These
+				  * are globally strung together off
+				  * init_mm.mmlist, and are protected
+				  * by mmlist_lock
+				  */
 #ifdef CONFIG_PER_VMA_LOCK
-		/*
-		 * This field has lock-like semantics, meaning it is sometimes
-		 * accessed with ACQUIRE/RELEASE semantics.
-		 * Roughly speaking, incrementing the sequence number is
-		 * equivalent to releasing locks on VMAs; reading the sequence
-		 * number can be part of taking a read lock on a VMA.
-		 *
-		 * Can be modified under write mmap_lock using RELEASE
-		 * semantics.
-		 * Can be read with no other protection when holding write
-		 * mmap_lock.
-		 * Can be read with ACQUIRE semantics if not holding write
-		 * mmap_lock.
-		 */
-		int mm_lock_seq;
+	/*
+	 * This field has lock-like semantics, meaning it is sometimes
+	 * accessed with ACQUIRE/RELEASE semantics.
+	 * Roughly speaking, incrementing the sequence number is
+	 * equivalent to releasing locks on VMAs; reading the sequence
+	 * number can be part of taking a read lock on a VMA.
+	 *
+	 * Can be modified under write mmap_lock using RELEASE
+	 * semantics.
+	 * Can be read with no other protection when holding write
+	 * mmap_lock.
+	 * Can be read with ACQUIRE semantics if not holding write
+	 * mmap_lock.
+	 */
+	int mm_lock_seq;
 #endif
 
 
-		unsigned long hiwater_rss; /* High-watermark of RSS usage */
-		unsigned long hiwater_vm;  /* High-water virtual memory usage */
+	unsigned long hiwater_rss; /* High-watermark of RSS usage */
+	unsigned long hiwater_vm;  /* High-water virtual memory usage */
 
-		unsigned long total_vm;	   /* Total pages mapped */
-		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
-		atomic64_t    pinned_vm;   /* Refcount permanently increased */
-		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
-		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
-		unsigned long stack_vm;	   /* VM_STACK */
-		unsigned long def_flags;
+	unsigned long total_vm;	   /* Total pages mapped */
+	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+	atomic64_t    pinned_vm;   /* Refcount permanently increased */
+	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
+	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
+	unsigned long stack_vm;	   /* VM_STACK */
+	unsigned long def_flags;
 
-		/**
-		 * @write_protect_seq: Locked when any thread is write
-		 * protecting pages mapped by this mm to enforce a later COW,
-		 * for instance during page table copying for fork().
-		 */
-		seqcount_t write_protect_seq;
+	/**
+	 * @write_protect_seq: Locked when any thread is write
+	 * protecting pages mapped by this mm to enforce a later COW,
+	 * for instance during page table copying for fork().
+	 */
+	seqcount_t write_protect_seq;
 
-		spinlock_t arg_lock; /* protect the below fields */
+	spinlock_t arg_lock; /* protect the below fields */
 
-		unsigned long start_code, end_code, start_data, end_data;
-		unsigned long start_brk, brk, start_stack;
-		unsigned long arg_start, arg_end, env_start, env_end;
+	unsigned long start_code, end_code, start_data, end_data;
+	unsigned long start_brk, brk, start_stack;
+	unsigned long arg_start, arg_end, env_start, env_end;
 
-		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
+	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-		struct percpu_counter rss_stat[NR_MM_COUNTERS];
+	struct percpu_counter rss_stat[NR_MM_COUNTERS];
 
-		struct linux_binfmt *binfmt;
+	struct linux_binfmt *binfmt;
 
-		/* Architecture-specific MM context */
-		mm_context_t context;
+	/* Architecture-specific MM context */
+	mm_context_t context;
 
-		unsigned long flags; /* Must use atomic bitops to access */
+	unsigned long flags; /* Must use atomic bitops to access */
 
 #ifdef CONFIG_AIO
-		spinlock_t			ioctx_lock;
-		struct kioctx_table __rcu	*ioctx_table;
+	spinlock_t			ioctx_lock;
+	struct kioctx_table __rcu	*ioctx_table;
 #endif
 #ifdef CONFIG_MEMCG
-		/*
-		 * "owner" points to a task that is regarded as the canonical
-		 * user/owner of this mm. All of the following must be true in
-		 * order for it to be changed:
-		 *
-		 * current == mm->owner
-		 * current->mm != mm
-		 * new_owner->mm == mm
-		 * new_owner->alloc_lock is held
-		 */
-		struct task_struct __rcu *owner;
+	/*
+	 * "owner" points to a task that is regarded as the canonical
+	 * user/owner of this mm. All of the following must be true in
+	 * order for it to be changed:
+	 *
+	 * current == mm->owner
+	 * current->mm != mm
+	 * new_owner->mm == mm
+	 * new_owner->alloc_lock is held
+	 */
+	struct task_struct __rcu *owner;
 #endif
-		struct user_namespace *user_ns;
+	struct user_namespace *user_ns;
 
-		/* store ref to file /proc/<pid>/exe symlink points to */
-		struct file __rcu *exe_file;
+	/* store ref to file /proc/<pid>/exe symlink points to */
+	struct file __rcu *exe_file;
 #ifdef CONFIG_MMU_NOTIFIER
-		struct mmu_notifier_subscriptions *notifier_subscriptions;
+	struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
+	pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
 #ifdef CONFIG_NUMA_BALANCING
-		/*
-		 * numa_next_scan is the next time that PTEs will be remapped
-		 * PROT_NONE to trigger NUMA hinting faults; such faults gather
-		 * statistics and migrate pages to new nodes if necessary.
-		 */
-		unsigned long numa_next_scan;
+	/*
+	 * numa_next_scan is the next time that PTEs will be remapped
+	 * PROT_NONE to trigger NUMA hinting faults; such faults gather
+	 * statistics and migrate pages to new nodes if necessary.
+	 */
+	unsigned long numa_next_scan;
 
-		/* Restart point for scanning and remapping PTEs. */
-		unsigned long numa_scan_offset;
+	/* Restart point for scanning and remapping PTEs. */
+	unsigned long numa_scan_offset;
 
-		/* numa_scan_seq prevents two threads remapping PTEs. */
-		int numa_scan_seq;
+	/* numa_scan_seq prevents two threads remapping PTEs. */
+	int numa_scan_seq;
 #endif
-		/*
-		 * An operation with batched TLB flushing is going on. Anything
-		 * that can move process memory needs to flush the TLB when
-		 * moving a PROT_NONE mapped page.
-		 */
-		atomic_t tlb_flush_pending;
+	/*
+	 * An operation with batched TLB flushing is going on. Anything
+	 * that can move process memory needs to flush the TLB when
+	 * moving a PROT_NONE mapped page.
+	 */
+	atomic_t tlb_flush_pending;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-		/* See flush_tlb_batched_pending() */
-		atomic_t tlb_flush_batched;
+	/* See flush_tlb_batched_pending() */
+	atomic_t tlb_flush_batched;
 #endif
-		struct uprobes_state uprobes_state;
+	struct uprobes_state uprobes_state;
 #ifdef CONFIG_PREEMPT_RT
-		struct rcu_head delayed_drop;
+	struct rcu_head delayed_drop;
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
-		atomic_long_t hugetlb_usage;
+	atomic_long_t hugetlb_usage;
 #endif
-		struct work_struct async_put_work;
+	struct work_struct async_put_work;
 
 #ifdef CONFIG_IOMMU_MM_DATA
-		struct iommu_mm_data *iommu_mm;
+	struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
-		/*
-		 * Represent how many pages of this process are involved in KSM
-		 * merging (not including ksm_zero_pages).
-		 */
-		unsigned long ksm_merging_pages;
-		/*
-		 * Represent how many pages are checked for ksm merging
-		 * including merged and not merged.
-		 */
-		unsigned long ksm_rmap_items;
-		/*
-		 * Represent how many empty pages are merged with kernel zero
-		 * pages when enabling KSM use_zero_pages.
-		 */
-		unsigned long ksm_zero_pages;
+	/*
+	 * Represent how many pages of this process are involved in KSM
+	 * merging (not including ksm_zero_pages).
+	 */
+	unsigned long ksm_merging_pages;
+	/*
+	 * Represent how many pages are checked for ksm merging
+	 * including merged and not merged.
+	 */
+	unsigned long ksm_rmap_items;
+	/*
+	 * Represent how many empty pages are merged with kernel zero
+	 * pages when enabling KSM use_zero_pages.
+	 */
+	unsigned long ksm_zero_pages;
 #endif /* CONFIG_KSM */
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
-		struct {
-			/* this mm_struct is on lru_gen_mm_list */
-			struct list_head list;
-			/*
-			 * Set when switching to this mm_struct, as a hint of
-			 * whether it has been used since the last time per-node
-			 * page table walkers cleared the corresponding bits.
-			 */
-			unsigned long bitmap;
+	struct {
+		/* this mm_struct is on lru_gen_mm_list */
+		struct list_head list;
+		/*
+		 * Set when switching to this mm_struct, as a hint of
+		 * whether it has been used since the last time per-node
+		 * page table walkers cleared the corresponding bits.
+		 */
+		unsigned long bitmap;
 #ifdef CONFIG_MEMCG
-			/* points to the memcg of "owner" above */
-			struct mem_cgroup *memcg;
+		/* points to the memcg of "owner" above */
+		struct mem_cgroup *memcg;
 #endif
-		} lru_gen;
+	} lru_gen;
 #endif /* CONFIG_LRU_GEN_WALKS_MMU */
-	} __randomize_layout;
+
+	/*
+	 * New fields for mm_struct should be added above here, so that
+	 * they are included in the randomized portion of mm_struct.
+	 */
+	randomized_struct_fields_end
 
 	/*
 	 * The mm_cpumask needs to be at the end of mm_struct, because it

base-commit: 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
-- 
2.34.1


