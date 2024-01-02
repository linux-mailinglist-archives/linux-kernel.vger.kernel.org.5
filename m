Return-Path: <linux-kernel+bounces-14738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B8822152
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8656284515
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C896171D3;
	Tue,  2 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrcehluU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB1171C5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e80d14404so5335212e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221234; x=1704826034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h07asMUPPPIr10RgfLD/fjXiYN2b5qLhuka70E2DoO0=;
        b=NrcehluUmDNrdeY+LnObMqSFBbTD1qO4PZRuaY0r2VoS7EiFs1dvxVT+N6nJASywoV
         DlMD5oi1/ZXNnVZEDAkTqwIRzvdh92nEdnaHE16Uy0nhrkHcB9Y2/1MYvC/KDVCT6f0H
         6MVYkULJtzrP2jUbdC89skk7tYyaEiaKRmGGg/yRhI8Is4OBnn50FlC3D27QWKZ2zVYR
         6YboGPhpbS3W1jbQ9wKpKbJCbURlCLRDx7ZEzW471BRPXufrl1FS71xu4/JeT3+FVL6V
         3FUB/w5dFbUVI3FcVQaqHZ9xmY11DseKH+ZokInJEHtl9q/x/J0JcM4o/Kan/CRZCh29
         Wvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221234; x=1704826034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h07asMUPPPIr10RgfLD/fjXiYN2b5qLhuka70E2DoO0=;
        b=w98pzS/KpIjIyFZdM+f3+FUz/h1kZwcuh5rbEvNgOElCrW0ciAbn5v606mtl6DguCl
         w9YuOluFDhlXJclT/YzGOctdHzCt4qnHTXxZnWWyp4wPkkZxJmifJdDK9ASxqBS0mo2c
         WzbywA3yWrs86k5a8E13wxQg/YVDX98pi3azSNRRrSHKU0eCjCxwHyxwMAnMMnzJ3BWQ
         Mx1aDGoMzyc8a8ixN99AQWhpRsSQXwXqxT19G8ueaLEePI4c25Ec9D9cNn6MypSvfN6v
         j9xN99o6kUFdHGuc/IcMEYdYafYgdGhAHHjyohnwXcaoONpES8AOWb1JdgsyeHn4vbsh
         u94g==
X-Gm-Message-State: AOJu0YxBhuHmuL2ztG2fW1aD73ISXI7gXGLYNHRTMlQRh+VM043sM3Rl
	pS9GwYfkkgdCx/0h81+Duuo=
X-Google-Smtp-Source: AGHT+IECQYn33SzuSoJtEpL4Qq9+JrKnIGLpOJF6cxZlu1nvYsQ8EYyOApu4rMADQk0y798LtEw2JQ==
X-Received: by 2002:ac2:5975:0:b0:50e:765b:1ea3 with SMTP id h21-20020ac25975000000b0050e765b1ea3mr6543728lfp.22.1704221203595;
        Tue, 02 Jan 2024 10:46:43 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:43 -0800 (PST)
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
Subject: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Date: Tue,  2 Jan 2024 19:46:29 +0100
Message-Id: <20240102184633.748113-8-urezki@gmail.com>
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

Concurrent access to a global vmap space is a bottle-neck.
We can simulate a high contention by running a vmalloc test
suite.

To address it, introduce an effective vmap node logic. Each
node behaves as independent entity. When a node is accessed
it serves a request directly(if possible) from its pool.

This model has a size based pool for requests, i.e. pools are
serialized and populated based on object size and real demand.
A maximum object size that pool can handle is set to 256 pages.

This technique reduces a pressure on the global vmap lock.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 387 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 342 insertions(+), 45 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9b2f1b0cac9d..fa4ab2bbbc5b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -775,7 +775,22 @@ struct rb_list {
 	spinlock_t lock;
 };
 
+struct vmap_pool {
+	struct list_head head;
+	unsigned long len;
+};
+
+/*
+ * A fast size storage contains VAs up to 1M size.
+ */
+#define MAX_VA_SIZE_PAGES 256
+
 static struct vmap_node {
+	/* Simple size segregated storage. */
+	struct vmap_pool pool[MAX_VA_SIZE_PAGES];
+	spinlock_t pool_lock;
+	bool skip_populate;
+
 	/* Bookkeeping data of this node. */
 	struct rb_list busy;
 	struct rb_list lazy;
@@ -784,6 +799,8 @@ static struct vmap_node {
 	 * Ready-to-free areas.
 	 */
 	struct list_head purge_list;
+	struct work_struct purge_work;
+	unsigned long nr_purged;
 } single;
 
 static struct vmap_node *vmap_nodes = &single;
@@ -802,6 +819,61 @@ addr_to_node(unsigned long addr)
 	return &vmap_nodes[addr_to_node_id(addr)];
 }
 
+static inline struct vmap_node *
+id_to_node(unsigned int id)
+{
+	return &vmap_nodes[id % nr_vmap_nodes];
+}
+
+/*
+ * We use the value 0 to represent "no node", that is why
+ * an encoded value will be the node-id incremented by 1.
+ * It is always greater then 0. A valid node_id which can
+ * be encoded is [0:nr_vmap_nodes - 1]. If a passed node_id
+ * is not valid 0 is returned.
+ */
+static unsigned int
+encode_vn_id(unsigned int node_id)
+{
+	/* Can store U8_MAX [0:254] nodes. */
+	if (node_id < nr_vmap_nodes)
+		return (node_id + 1) << BITS_PER_BYTE;
+
+	/* Warn and no node encoded. */
+	WARN_ONCE(1, "Encode wrong node id (%u)\n", node_id);
+	return 0;
+}
+
+/*
+ * Returns an encoded node-id, the valid range is within
+ * [0:nr_vmap_nodes-1] values. Otherwise nr_vmap_nodes is
+ * returned if extracted data is wrong.
+ */
+static unsigned int
+decode_vn_id(unsigned int val)
+{
+	unsigned int node_id = (val >> BITS_PER_BYTE) - 1;
+
+	/* Can store U8_MAX [0:254] nodes. */
+	if (node_id < nr_vmap_nodes)
+		return node_id;
+
+	/* If it was _not_ zero, warn. */
+	WARN_ONCE(node_id != UINT_MAX,
+		"Decode wrong node id (%d)\n", node_id);
+
+	return nr_vmap_nodes;
+}
+
+static bool
+is_vn_id_valid(unsigned int node_id)
+{
+	if (node_id < nr_vmap_nodes)
+		return true;
+
+	return false;
+}
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
@@ -1623,6 +1695,104 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 		kmem_cache_free(vmap_area_cachep, va);
 }
 
+static struct vmap_pool *
+size_to_va_pool(struct vmap_node *vn, unsigned long size)
+{
+	unsigned int idx = (size - 1) / PAGE_SIZE;
+
+	if (idx < MAX_VA_SIZE_PAGES)
+		return &vn->pool[idx];
+
+	return NULL;
+}
+
+static bool
+node_pool_add_va(struct vmap_node *n, struct vmap_area *va)
+{
+	struct vmap_pool *vp;
+
+	vp = size_to_va_pool(n, va_size(va));
+	if (!vp)
+		return false;
+
+	spin_lock(&n->pool_lock);
+	list_add(&va->list, &vp->head);
+	WRITE_ONCE(vp->len, vp->len + 1);
+	spin_unlock(&n->pool_lock);
+
+	return true;
+}
+
+static struct vmap_area *
+node_pool_del_va(struct vmap_node *vn, unsigned long size,
+		unsigned long align, unsigned long vstart,
+		unsigned long vend)
+{
+	struct vmap_area *va = NULL;
+	struct vmap_pool *vp;
+	int err = 0;
+
+	vp = size_to_va_pool(vn, size);
+	if (!vp || list_empty(&vp->head))
+		return NULL;
+
+	spin_lock(&vn->pool_lock);
+	if (!list_empty(&vp->head)) {
+		va = list_first_entry(&vp->head, struct vmap_area, list);
+
+		if (IS_ALIGNED(va->va_start, align)) {
+			/*
+			 * Do some sanity check and emit a warning
+			 * if one of below checks detects an error.
+			 */
+			err |= (va_size(va) != size);
+			err |= (va->va_start < vstart);
+			err |= (va->va_end > vend);
+
+			if (!WARN_ON_ONCE(err)) {
+				list_del_init(&va->list);
+				WRITE_ONCE(vp->len, vp->len - 1);
+			} else {
+				va = NULL;
+			}
+		} else {
+			list_move_tail(&va->list, &vp->head);
+			va = NULL;
+		}
+	}
+	spin_unlock(&vn->pool_lock);
+
+	return va;
+}
+
+static struct vmap_area *
+node_alloc(unsigned long size, unsigned long align,
+		unsigned long vstart, unsigned long vend,
+		unsigned long *addr, unsigned int *vn_id)
+{
+	struct vmap_area *va;
+
+	*vn_id = 0;
+	*addr = vend;
+
+	/*
+	 * Fallback to a global heap if not vmalloc or there
+	 * is only one node.
+	 */
+	if (vstart != VMALLOC_START || vend != VMALLOC_END ||
+			nr_vmap_nodes == 1)
+		return NULL;
+
+	*vn_id = raw_smp_processor_id() % nr_vmap_nodes;
+	va = node_pool_del_va(id_to_node(*vn_id), size, align, vstart, vend);
+	*vn_id = encode_vn_id(*vn_id);
+
+	if (va)
+		*addr = va->va_start;
+
+	return va;
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
@@ -1637,6 +1807,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	struct vmap_area *va;
 	unsigned long freed;
 	unsigned long addr;
+	unsigned int vn_id;
 	int purged = 0;
 	int ret;
 
@@ -1647,11 +1818,23 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		return ERR_PTR(-EBUSY);
 
 	might_sleep();
-	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
 
-	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
-	if (unlikely(!va))
-		return ERR_PTR(-ENOMEM);
+	/*
+	 * If a VA is obtained from a global heap(if it fails here)
+	 * it is anyway marked with this "vn_id" so it is returned
+	 * to this pool's node later. Such way gives a possibility
+	 * to populate pools based on users demand.
+	 *
+	 * On success a ready to go VA is returned.
+	 */
+	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
+	if (!va) {
+		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
+
+		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
+		if (unlikely(!va))
+			return ERR_PTR(-ENOMEM);
+	}
 
 	/*
 	 * Only scan the relevant parts containing pointers to other objects
@@ -1660,10 +1843,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
 
 retry:
-	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
-	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
-		size, align, vstart, vend);
-	spin_unlock(&free_vmap_area_lock);
+	if (addr == vend) {
+		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
+		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+			size, align, vstart, vend);
+		spin_unlock(&free_vmap_area_lock);
+	}
 
 	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
 
@@ -1677,7 +1862,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->va_start = addr;
 	va->va_end = addr + size;
 	va->vm = NULL;
-	va->flags = va_flags;
+	va->flags = (va_flags | vn_id);
 
 	vn = addr_to_node(va->va_start);
 
@@ -1770,63 +1955,135 @@ static DEFINE_MUTEX(vmap_purge_lock);
 static void purge_fragmented_blocks_allcpus(void);
 static cpumask_t purge_nodes;
 
-/*
- * Purges all lazily-freed vmap areas.
- */
-static unsigned long
-purge_vmap_node(struct vmap_node *vn)
+static void
+reclaim_list_global(struct list_head *head)
 {
-	unsigned long num_purged_areas = 0;
-	struct vmap_area *va, *n_va;
+	struct vmap_area *va, *n;
 
-	if (list_empty(&vn->purge_list))
-		return 0;
+	if (list_empty(head))
+		return;
 
 	spin_lock(&free_vmap_area_lock);
+	list_for_each_entry_safe(va, n, head, list)
+		merge_or_add_vmap_area_augment(va,
+			&free_vmap_area_root, &free_vmap_area_list);
+	spin_unlock(&free_vmap_area_lock);
+}
+
+static void
+decay_va_pool_node(struct vmap_node *vn, bool full_decay)
+{
+	struct vmap_area *va, *nva;
+	struct list_head decay_list;
+	struct rb_root decay_root;
+	unsigned long n_decay;
+	int i;
+
+	decay_root = RB_ROOT;
+	INIT_LIST_HEAD(&decay_list);
+
+	for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
+		struct list_head tmp_list;
+
+		if (list_empty(&vn->pool[i].head))
+			continue;
+
+		INIT_LIST_HEAD(&tmp_list);
+
+		/* Detach the pool, so no-one can access it. */
+		spin_lock(&vn->pool_lock);
+		list_replace_init(&vn->pool[i].head, &tmp_list);
+		spin_unlock(&vn->pool_lock);
+
+		if (full_decay)
+			WRITE_ONCE(vn->pool[i].len, 0);
+
+		/* Decay a pool by ~25% out of left objects. */
+		n_decay = vn->pool[i].len >> 2;
+
+		list_for_each_entry_safe(va, nva, &tmp_list, list) {
+			list_del_init(&va->list);
+			merge_or_add_vmap_area(va, &decay_root, &decay_list);
+
+			if (!full_decay) {
+				WRITE_ONCE(vn->pool[i].len, vn->pool[i].len - 1);
+
+				if (!--n_decay)
+					break;
+			}
+		}
+
+		/* Attach the pool back if it has been partly decayed. */
+		if (!full_decay && !list_empty(&tmp_list)) {
+			spin_lock(&vn->pool_lock);
+			list_replace_init(&tmp_list, &vn->pool[i].head);
+			spin_unlock(&vn->pool_lock);
+		}
+	}
+
+	reclaim_list_global(&decay_list);
+}
+
+static void purge_vmap_node(struct work_struct *work)
+{
+	struct vmap_node *vn = container_of(work,
+		struct vmap_node, purge_work);
+	struct vmap_area *va, *n_va;
+	LIST_HEAD(local_list);
+
+	vn->nr_purged = 0;
+
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
 		unsigned long orig_end = va->va_end;
+		unsigned int vn_id = decode_vn_id(va->flags);
 
-		/*
-		 * Finally insert or merge lazily-freed area. It is
-		 * detached and there is no need to "unlink" it from
-		 * anything.
-		 */
-		va = merge_or_add_vmap_area_augment(va, &free_vmap_area_root,
-				&free_vmap_area_list);
-
-		if (!va)
-			continue;
+		list_del_init(&va->list);
 
 		if (is_vmalloc_or_module_addr((void *)orig_start))
 			kasan_release_vmalloc(orig_start, orig_end,
 					      va->va_start, va->va_end);
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
-		num_purged_areas++;
+		vn->nr_purged++;
+
+		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
+			if (node_pool_add_va(vn, va))
+				continue;
+
+		/* Go back to global. */
+		list_add(&va->list, &local_list);
 	}
-	spin_unlock(&free_vmap_area_lock);
 
-	return num_purged_areas;
+	reclaim_list_global(&local_list);
 }
 
 /*
  * Purges all lazily-freed vmap areas.
  */
-static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
+static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
+		bool full_pool_decay)
 {
-	unsigned long num_purged_areas = 0;
+	unsigned long nr_purged_areas = 0;
+	unsigned int nr_purge_helpers;
+	unsigned int nr_purge_nodes;
 	struct vmap_node *vn;
 	int i;
 
 	lockdep_assert_held(&vmap_purge_lock);
+
+	/*
+	 * Use cpumask to mark which node has to be processed.
+	 */
 	purge_nodes = CPU_MASK_NONE;
 
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
 
 		INIT_LIST_HEAD(&vn->purge_list);
+		vn->skip_populate = full_pool_decay;
+		decay_va_pool_node(vn, full_pool_decay);
 
 		if (RB_EMPTY_ROOT(&vn->lazy.root))
 			continue;
@@ -1845,17 +2102,45 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 		cpumask_set_cpu(i, &purge_nodes);
 	}
 
-	if (cpumask_weight(&purge_nodes) > 0) {
+	nr_purge_nodes = cpumask_weight(&purge_nodes);
+	if (nr_purge_nodes > 0) {
 		flush_tlb_kernel_range(start, end);
 
+		/* One extra worker is per a lazy_max_pages() full set minus one. */
+		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
+		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
+
 		for_each_cpu(i, &purge_nodes) {
-			vn = &nodes[i];
-			num_purged_areas += purge_vmap_node(vn);
+			vn = &vmap_nodes[i];
+
+			if (nr_purge_helpers > 0) {
+				INIT_WORK(&vn->purge_work, purge_vmap_node);
+
+				if (cpumask_test_cpu(i, cpu_online_mask))
+					schedule_work_on(i, &vn->purge_work);
+				else
+					schedule_work(&vn->purge_work);
+
+				nr_purge_helpers--;
+			} else {
+				vn->purge_work.func = NULL;
+				purge_vmap_node(&vn->purge_work);
+				nr_purged_areas += vn->nr_purged;
+			}
+		}
+
+		for_each_cpu(i, &purge_nodes) {
+			vn = &vmap_nodes[i];
+
+			if (vn->purge_work.func) {
+				flush_work(&vn->purge_work);
+				nr_purged_areas += vn->nr_purged;
+			}
 		}
 	}
 
-	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
-	return num_purged_areas > 0;
+	trace_purge_vmap_area_lazy(start, end, nr_purged_areas);
+	return nr_purged_areas > 0;
 }
 
 /*
@@ -1866,14 +2151,14 @@ static void reclaim_and_purge_vmap_areas(void)
 {
 	mutex_lock(&vmap_purge_lock);
 	purge_fragmented_blocks_allcpus();
-	__purge_vmap_area_lazy(ULONG_MAX, 0);
+	__purge_vmap_area_lazy(ULONG_MAX, 0, true);
 	mutex_unlock(&vmap_purge_lock);
 }
 
 static void drain_vmap_area_work(struct work_struct *work)
 {
 	mutex_lock(&vmap_purge_lock);
-	__purge_vmap_area_lazy(ULONG_MAX, 0);
+	__purge_vmap_area_lazy(ULONG_MAX, 0, false);
 	mutex_unlock(&vmap_purge_lock);
 }
 
@@ -1884,9 +2169,10 @@ static void drain_vmap_area_work(struct work_struct *work)
  */
 static void free_vmap_area_noflush(struct vmap_area *va)
 {
-	struct vmap_node *vn = addr_to_node(va->va_start);
 	unsigned long nr_lazy_max = lazy_max_pages();
 	unsigned long va_start = va->va_start;
+	unsigned int vn_id = decode_vn_id(va->flags);
+	struct vmap_node *vn;
 	unsigned long nr_lazy;
 
 	if (WARN_ON_ONCE(!list_empty(&va->list)))
@@ -1896,10 +2182,14 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 				PAGE_SHIFT, &vmap_lazy_nr);
 
 	/*
-	 * Merge or place it to the purge tree/list.
+	 * If it was request by a certain node we would like to
+	 * return it to that node, i.e. its pool for later reuse.
 	 */
+	vn = is_vn_id_valid(vn_id) ?
+		id_to_node(vn_id):addr_to_node(va->va_start);
+
 	spin_lock(&vn->lazy.lock);
-	merge_or_add_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
+	insert_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
 	spin_unlock(&vn->lazy.lock);
 
 	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
@@ -2408,7 +2698,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 	}
 	free_purged_blocks(&purge_list);
 
-	if (!__purge_vmap_area_lazy(start, end) && flush)
+	if (!__purge_vmap_area_lazy(start, end, false) && flush)
 		flush_tlb_kernel_range(start, end);
 	mutex_unlock(&vmap_purge_lock);
 }
@@ -4576,7 +4866,7 @@ static void vmap_init_free_space(void)
 static void vmap_init_nodes(void)
 {
 	struct vmap_node *vn;
-	int i;
+	int i, j;
 
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
@@ -4587,6 +4877,13 @@ static void vmap_init_nodes(void)
 		vn->lazy.root = RB_ROOT;
 		INIT_LIST_HEAD(&vn->lazy.head);
 		spin_lock_init(&vn->lazy.lock);
+
+		for (j = 0; j < MAX_VA_SIZE_PAGES; j++) {
+			INIT_LIST_HEAD(&vn->pool[j].head);
+			WRITE_ONCE(vn->pool[j].len, 0);
+		}
+
+		spin_lock_init(&vn->pool_lock);
 	}
 }
 
-- 
2.39.2


