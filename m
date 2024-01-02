Return-Path: <linux-kernel+bounces-14736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B34822150
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714061C229CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF7168C1;
	Tue,  2 Jan 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD/HtqhK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF716415
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7af5f618so6917304e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221202; x=1704826002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7TPXqOPL1FAObBiwLOLjtzw+Q8CAhI3CaP8/RlkErk=;
        b=mD/HtqhKcLOIVSwYq82R5UvmnJaImogH9T6pCBJ2GYBKoA4ZvO8DqsTMA9qmdWM8f3
         y7XkQNOjwVyvWGhZkDcUkhvYs1zYFADq9qnHfJzG6Y8gqiGHUqTLlyNEOzJ8XDGiLgLK
         fAEEojTXrg2l1NsLo6JLNSwZpulNRLYZRhgiGDaE+2c0gofFrxbpc828tH4CqFEk5HFj
         LgDxCv3xqFMm7Yc1O35MJSd7l3062oY3tKgWEN3rRutCrSG/RSgDWfkrq+tCzHBcyLnJ
         7JOxsvFf5vERnlPYAZpCdc+XjgqC6C6cLNICwXVM2mIo2HlyZ6LI6tGPYE/HwNrLHWcG
         AKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221202; x=1704826002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7TPXqOPL1FAObBiwLOLjtzw+Q8CAhI3CaP8/RlkErk=;
        b=QASfy4hdtbPZEcOimN2BKvPOZE8ZKFxYnZ5yyklkFOqcxStX1Arn3Dj4eCsl+vRTP8
         ipqzqTxrFjRQmAceMvew8CIqiWKHqkGPXYdl+d9yO9/qblPYwLWE5njHHb4+iXreqYQj
         CpBWGw0U3bc8WeAC0go1ExjEecJxOYlDE00jGDxDsA98WotIPbE1joTOAgvOA5Ln938a
         6AjIjBMmm0fIvTnHgau3hgi18Fkr+YAcrOfGc+nwPD/wuWTr5nfQsVwcdBTtm7ECeO2a
         vXlShqwF1Yp/BWASjXfkZFJchLEBzSX4MsTkWgzjwE281ICrEeGVpcb+vK6Z3jRtx4BO
         Kvvw==
X-Gm-Message-State: AOJu0YxifunKo92rBPVfkbVV6hO9REjwAfeMj3rC1nAVES/oTrY/5fve
	mI5RkxXLDfFnEfYIimrPDlQ=
X-Google-Smtp-Source: AGHT+IEqmNEBRY+67JLEN5/lqBW0cHGCcx7d8OHSSEsbnprrKpdCdH45LWYpuY7EtQcmCYTMyqhKag==
X-Received: by 2002:a05:6512:1581:b0:50e:902d:b48 with SMTP id bp1-20020a056512158100b0050e902d0b48mr3325679lfb.64.1704221202399;
        Tue, 02 Jan 2024 10:46:42 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:42 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v3 06/11] mm: vmalloc: Remove global purge_vmap_area_root rb-tree
Date: Tue,  2 Jan 2024 19:46:28 +0100
Message-Id: <20240102184633.748113-7-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102184633.748113-1-urezki@gmail.com>
References: <20240102184633.748113-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to busy VA, lazily-freed area is stored to a node
it belongs to. Such approach does not require any global
locking primitive, instead an access becomes scalable what
mitigates a contention.

This patch removes a global purge-lock, global purge-tree
and global purge list.

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 135 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 53 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8c01f2225ef7..9b2f1b0cac9d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -731,10 +731,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 static DEFINE_SPINLOCK(free_vmap_area_lock);
 static bool vmap_initialized __read_mostly;
 
-static struct rb_root purge_vmap_area_root = RB_ROOT;
-static LIST_HEAD(purge_vmap_area_list);
-static DEFINE_SPINLOCK(purge_vmap_area_lock);
-
 /*
  * This kmem_cache is used for vmap_area objects. Instead of
  * allocating from slab we reuse an object from this cache to
@@ -782,6 +778,12 @@ struct rb_list {
 static struct vmap_node {
 	/* Bookkeeping data of this node. */
 	struct rb_list busy;
+	struct rb_list lazy;
+
+	/*
+	 * Ready-to-free areas.
+	 */
+	struct list_head purge_list;
 } single;
 
 static struct vmap_node *vmap_nodes = &single;
@@ -1766,40 +1768,22 @@ static DEFINE_MUTEX(vmap_purge_lock);
 
 /* for per-CPU blocks */
 static void purge_fragmented_blocks_allcpus(void);
+static cpumask_t purge_nodes;
 
 /*
  * Purges all lazily-freed vmap areas.
  */
-static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
+static unsigned long
+purge_vmap_node(struct vmap_node *vn)
 {
-	unsigned long resched_threshold;
-	unsigned int num_purged_areas = 0;
-	struct list_head local_purge_list;
+	unsigned long num_purged_areas = 0;
 	struct vmap_area *va, *n_va;
 
-	lockdep_assert_held(&vmap_purge_lock);
-
-	spin_lock(&purge_vmap_area_lock);
-	purge_vmap_area_root = RB_ROOT;
-	list_replace_init(&purge_vmap_area_list, &local_purge_list);
-	spin_unlock(&purge_vmap_area_lock);
-
-	if (unlikely(list_empty(&local_purge_list)))
-		goto out;
-
-	start = min(start,
-		list_first_entry(&local_purge_list,
-			struct vmap_area, list)->va_start);
-
-	end = max(end,
-		list_last_entry(&local_purge_list,
-			struct vmap_area, list)->va_end);
-
-	flush_tlb_kernel_range(start, end);
-	resched_threshold = lazy_max_pages() << 1;
+	if (list_empty(&vn->purge_list))
+		return 0;
 
 	spin_lock(&free_vmap_area_lock);
-	list_for_each_entry_safe(va, n_va, &local_purge_list, list) {
+	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
 		unsigned long orig_end = va->va_end;
@@ -1821,13 +1805,55 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		num_purged_areas++;
-
-		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
-			cond_resched_lock(&free_vmap_area_lock);
 	}
 	spin_unlock(&free_vmap_area_lock);
 
-out:
+	return num_purged_areas;
+}
+
+/*
+ * Purges all lazily-freed vmap areas.
+ */
+static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
+{
+	unsigned long num_purged_areas = 0;
+	struct vmap_node *vn;
+	int i;
+
+	lockdep_assert_held(&vmap_purge_lock);
+	purge_nodes = CPU_MASK_NONE;
+
+	for (i = 0; i < nr_vmap_nodes; i++) {
+		vn = &vmap_nodes[i];
+
+		INIT_LIST_HEAD(&vn->purge_list);
+
+		if (RB_EMPTY_ROOT(&vn->lazy.root))
+			continue;
+
+		spin_lock(&vn->lazy.lock);
+		WRITE_ONCE(vn->lazy.root.rb_node, NULL);
+		list_replace_init(&vn->lazy.head, &vn->purge_list);
+		spin_unlock(&vn->lazy.lock);
+
+		start = min(start, list_first_entry(&vn->purge_list,
+			struct vmap_area, list)->va_start);
+
+		end = max(end, list_last_entry(&vn->purge_list,
+			struct vmap_area, list)->va_end);
+
+		cpumask_set_cpu(i, &purge_nodes);
+	}
+
+	if (cpumask_weight(&purge_nodes) > 0) {
+		flush_tlb_kernel_range(start, end);
+
+		for_each_cpu(i, &purge_nodes) {
+			vn = &nodes[i];
+			num_purged_areas += purge_vmap_node(vn);
+		}
+	}
+
 	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
 	return num_purged_areas > 0;
 }
@@ -1846,16 +1872,9 @@ static void reclaim_and_purge_vmap_areas(void)
 
 static void drain_vmap_area_work(struct work_struct *work)
 {
-	unsigned long nr_lazy;
-
-	do {
-		mutex_lock(&vmap_purge_lock);
-		__purge_vmap_area_lazy(ULONG_MAX, 0);
-		mutex_unlock(&vmap_purge_lock);
-
-		/* Recheck if further work is required. */
-		nr_lazy = atomic_long_read(&vmap_lazy_nr);
-	} while (nr_lazy > lazy_max_pages());
+	mutex_lock(&vmap_purge_lock);
+	__purge_vmap_area_lazy(ULONG_MAX, 0);
+	mutex_unlock(&vmap_purge_lock);
 }
 
 /*
@@ -1865,6 +1884,7 @@ static void drain_vmap_area_work(struct work_struct *work)
  */
 static void free_vmap_area_noflush(struct vmap_area *va)
 {
+	struct vmap_node *vn = addr_to_node(va->va_start);
 	unsigned long nr_lazy_max = lazy_max_pages();
 	unsigned long va_start = va->va_start;
 	unsigned long nr_lazy;
@@ -1878,10 +1898,9 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	/*
 	 * Merge or place it to the purge tree/list.
 	 */
-	spin_lock(&purge_vmap_area_lock);
-	merge_or_add_vmap_area(va,
-		&purge_vmap_area_root, &purge_vmap_area_list);
-	spin_unlock(&purge_vmap_area_lock);
+	spin_lock(&vn->lazy.lock);
+	merge_or_add_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
+	spin_unlock(&vn->lazy.lock);
 
 	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
 
@@ -4411,15 +4430,21 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 
 static void show_purge_info(struct seq_file *m)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
+	int i;
 
-	spin_lock(&purge_vmap_area_lock);
-	list_for_each_entry(va, &purge_vmap_area_list, list) {
-		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
-			(void *)va->va_start, (void *)va->va_end,
-			va->va_end - va->va_start);
+	for (i = 0; i < nr_vmap_nodes; i++) {
+		vn = &vmap_nodes[i];
+
+		spin_lock(&vn->lazy.lock);
+		list_for_each_entry(va, &vn->lazy.head, list) {
+			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
+				(void *)va->va_start, (void *)va->va_end,
+				va->va_end - va->va_start);
+		}
+		spin_unlock(&vn->lazy.lock);
 	}
-	spin_unlock(&purge_vmap_area_lock);
 }
 
 static int s_show(struct seq_file *m, void *p)
@@ -4558,6 +4583,10 @@ static void vmap_init_nodes(void)
 		vn->busy.root = RB_ROOT;
 		INIT_LIST_HEAD(&vn->busy.head);
 		spin_lock_init(&vn->busy.lock);
+
+		vn->lazy.root = RB_ROOT;
+		INIT_LIST_HEAD(&vn->lazy.head);
+		spin_lock_init(&vn->lazy.lock);
 	}
 }
 
-- 
2.39.2


