Return-Path: <linux-kernel+bounces-14735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F582214F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E601F21F79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133A16433;
	Tue,  2 Jan 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq/p6ZvV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9215AF7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso4333732e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221200; x=1704826000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=846iHGUkxLzE5ToX3/xFEcRjp3aW1Mkydl1M48KgaNk=;
        b=eq/p6ZvV5Tefw8btJLqA7KWquv6gPjOHWzBNYzuafvAjMJYL5uomhIkhK4vbaemU5u
         uQErfNgXMaFl6HaTDf2cY6kYyEBMvihMYbN/PgnzccQ5D7mHxVKG0H5zkUa7SeMmwW50
         qU8HbU28gOPfUTvC2nuqhlz1LbCrPh/75H6kp7JiRi3dxxCzlesrlTjdh6rU5N0c7RWt
         jajRurtySimvMiBRPlXeUVC7zLeukClNV2pb3gOiSUxby74vjRP3K8F03om3KnlEo+y+
         KgRPZ/9pMyw/GYk3AtSEde/DR0PP9uVxLe3+yVSihmjcj9GW/FU+OqHEIbEuEJn7sI9V
         WgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221200; x=1704826000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=846iHGUkxLzE5ToX3/xFEcRjp3aW1Mkydl1M48KgaNk=;
        b=JLW8E/3tbSVlSiawdJ6uACkOevg+dZDYRpdLJ832alajsEaUgH8GNgqLD2AKa5YcS+
         ChBEe/ylsdMlBlAoHubl40mg+9jIzQLdC9Iw3ktrXa5LMNhgSBL/OCg6GJCaho5qAmhP
         SrHOmmNG0r1faKpwRm8cS4y7qWVh6ddQhRbO+0MUrQJrRl3VZAKyTJCQ/XiADOLK7Ero
         zDk4Kp4NikHAw1LyOAouzTz/IdBVZ/hbmSotGdiIKaTVT5lG2Xv7jE8B2oj5i11mnTnn
         hjYg958t7w/E6h7Fx6KtKMxk9472MiTgdS4scLQguYHrgUV//r5uxJJVt30sxKtYYNKf
         Ojzw==
X-Gm-Message-State: AOJu0YzCEnWxEPe7TKPj2Qx/YnA7KFgs7qRFkMVhvqi2/nvnAESbjAdB
	DfuE1kXBhH36D3cfl/WthDgYl/J8v55C5A==
X-Google-Smtp-Source: AGHT+IEWhJlp1zs3fLwCvhy1mP5b731c3cOSs/r4uDwHpR4O2rYQ3MiJru5ERnu0tkKGRVB+bMlVkg==
X-Received: by 2002:a05:6512:3b28:b0:50e:7f8a:5f77 with SMTP id f40-20020a0565123b2800b0050e7f8a5f77mr6510582lfv.127.1704221200488;
        Tue, 02 Jan 2024 10:46:40 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:40 -0800 (PST)
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
Subject: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root rb-tree
Date: Tue,  2 Jan 2024 19:46:26 +0100
Message-Id: <20240102184633.748113-5-urezki@gmail.com>
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

Store allocated objects in a separate nodes. A va->va_start
address is converted into a correct node where it should
be placed and resided. An addr_to_node() function is used
to do a proper address conversion to determine a node that
contains a VA.

Such approach balances VAs across nodes as a result an access
becomes scalable. Number of nodes in a system depends on number
of CPUs.

Please note:

1. As of now allocated VAs are bound to a node-0. It means the
   patch does not give any difference comparing with a current
   behavior;

2. The global vmap_area_lock, vmap_area_root are removed as there
   is no need in it anymore. The vmap_area_list is still kept and
   is _empty_. It is exported for a kexec only;

3. The vmallocinfo and vread() have to be reworked to be able to
   handle multiple nodes.

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 240 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 173 insertions(+), 67 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 06bd843d18ae..786ecb18ae22 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
 
-static DEFINE_SPINLOCK(vmap_area_lock);
 static DEFINE_SPINLOCK(free_vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
-static struct rb_root vmap_area_root = RB_ROOT;
 static bool vmap_initialized __read_mostly;
 
 static struct rb_root purge_vmap_area_root = RB_ROOT;
@@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
  */
 static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
 
+/*
+ * An effective vmap-node logic. Users make use of nodes instead
+ * of a global heap. It allows to balance an access and mitigate
+ * contention.
+ */
+struct rb_list {
+	struct rb_root root;
+	struct list_head head;
+	spinlock_t lock;
+};
+
+static struct vmap_node {
+	/* Bookkeeping data of this node. */
+	struct rb_list busy;
+} single;
+
+static struct vmap_node *vmap_nodes = &single;
+static __read_mostly unsigned int nr_vmap_nodes = 1;
+static __read_mostly unsigned int vmap_zone_size = 1;
+
+static inline unsigned int
+addr_to_node_id(unsigned long addr)
+{
+	return (addr / vmap_zone_size) % nr_vmap_nodes;
+}
+
+static inline struct vmap_node *
+addr_to_node(unsigned long addr)
+{
+	return &vmap_nodes[addr_to_node_id(addr)];
+}
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
@@ -803,10 +833,11 @@ unsigned long vmalloc_nr_pages(void)
 }
 
 /* Look up the first VA which satisfies addr < va_end, NULL if none. */
-static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
+static struct vmap_area *
+find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 {
 	struct vmap_area *va = NULL;
-	struct rb_node *n = vmap_area_root.rb_node;
+	struct rb_node *n = root->rb_node;
 
 	addr = (unsigned long)kasan_reset_tag((void *)addr);
 
@@ -1552,12 +1583,14 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
  */
 static void free_vmap_area(struct vmap_area *va)
 {
+	struct vmap_node *vn = addr_to_node(va->va_start);
+
 	/*
 	 * Remove from the busy tree/list.
 	 */
-	spin_lock(&vmap_area_lock);
-	unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	spin_lock(&vn->busy.lock);
+	unlink_va(va, &vn->busy.root);
+	spin_unlock(&vn->busy.lock);
 
 	/*
 	 * Insert/Merge it back to the free tree/list.
@@ -1600,6 +1633,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask,
 				unsigned long va_flags)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
 	unsigned long freed;
 	unsigned long addr;
@@ -1645,9 +1679,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = va_flags;
 
-	spin_lock(&vmap_area_lock);
-	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
-	spin_unlock(&vmap_area_lock);
+	vn = addr_to_node(va->va_start);
+
+	spin_lock(&vn->busy.lock);
+	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
+	spin_unlock(&vn->busy.lock);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
 	BUG_ON(va->va_start < vstart);
@@ -1871,26 +1907,61 @@ static void free_unmap_vmap_area(struct vmap_area *va)
 
 struct vmap_area *find_vmap_area(unsigned long addr)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
+	int i, j;
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	/*
+	 * An addr_to_node_id(addr) converts an address to a node index
+	 * where a VA is located. If VA spans several zones and passed
+	 * addr is not the same as va->va_start, what is not common, we
+	 * may need to scan an extra nodes. See an example:
+	 *
+	 *      <--va-->
+	 * -|-----|-----|-----|-----|-
+	 *     1     2     0     1
+	 *
+	 * VA resides in node 1 whereas it spans 1 and 2. If passed
+	 * addr is within a second node we should do extra work. We
+	 * should mention that it is rare and is a corner case from
+	 * the other hand it has to be covered.
+	 */
+	i = j = addr_to_node_id(addr);
+	do {
+		vn = &vmap_nodes[i];
 
-	return va;
+		spin_lock(&vn->busy.lock);
+		va = __find_vmap_area(addr, &vn->busy.root);
+		spin_unlock(&vn->busy.lock);
+
+		if (va)
+			return va;
+	} while ((i = (i + 1) % nr_vmap_nodes) != j);
+
+	return NULL;
 }
 
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
+	int i, j;
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr, &vmap_area_root);
-	if (va)
-		unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	i = j = addr_to_node_id(addr);
+	do {
+		vn = &vmap_nodes[i];
 
-	return va;
+		spin_lock(&vn->busy.lock);
+		va = __find_vmap_area(addr, &vn->busy.root);
+		if (va)
+			unlink_va(va, &vn->busy.root);
+		spin_unlock(&vn->busy.lock);
+
+		if (va)
+			return va;
+	} while ((i = (i + 1) % nr_vmap_nodes) != j);
+
+	return NULL;
 }
 
 /*** Per cpu kva allocator ***/
@@ -2092,6 +2163,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 static void free_vmap_block(struct vmap_block *vb)
 {
+	struct vmap_node *vn;
 	struct vmap_block *tmp;
 	struct xarray *xa;
 
@@ -2099,9 +2171,10 @@ static void free_vmap_block(struct vmap_block *vb)
 	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
 	BUG_ON(tmp != vb);
 
-	spin_lock(&vmap_area_lock);
-	unlink_va(vb->va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	vn = addr_to_node(vb->va->va_start);
+	spin_lock(&vn->busy.lock);
+	unlink_va(vb->va, &vn->busy.root);
+	spin_unlock(&vn->busy.lock);
 
 	free_vmap_area_noflush(vb->va);
 	kfree_rcu(vb, rcu_head);
@@ -2525,9 +2598,11 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 			      unsigned long flags, const void *caller)
 {
-	spin_lock(&vmap_area_lock);
+	struct vmap_node *vn = addr_to_node(va->va_start);
+
+	spin_lock(&vn->busy.lock);
 	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&vn->busy.lock);
 }
 
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
@@ -3715,6 +3790,7 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
  */
 long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
 	struct vm_struct *vm;
 	char *vaddr;
@@ -3728,8 +3804,11 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 	remains = count;
 
-	spin_lock(&vmap_area_lock);
-	va = find_vmap_area_exceed_addr((unsigned long)addr);
+	/* Hooked to node_0 so far. */
+	vn = addr_to_node(0);
+	spin_lock(&vn->busy.lock);
+
+	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
 	if (!va)
 		goto finished_zero;
 
@@ -3737,7 +3816,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	if ((unsigned long)addr + remains <= va->va_start)
 		goto finished_zero;
 
-	list_for_each_entry_from(va, &vmap_area_list, list) {
+	list_for_each_entry_from(va, &vn->busy.head, list) {
 		size_t copied;
 
 		if (remains == 0)
@@ -3796,12 +3875,12 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	}
 
 finished_zero:
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&vn->busy.lock);
 	/* zero-fill memory holes */
 	return count - remains + zero_iter(iter, remains);
 finished:
 	/* Nothing remains, or We couldn't copy/zero everything. */
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&vn->busy.lock);
 
 	return count - remains;
 }
@@ -4135,14 +4214,15 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 
 	/* insert all vm's */
-	spin_lock(&vmap_area_lock);
 	for (area = 0; area < nr_vms; area++) {
-		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
+		struct vmap_node *vn = addr_to_node(vas[area]->va_start);
 
+		spin_lock(&vn->busy.lock);
+		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
 		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
+		spin_unlock(&vn->busy.lock);
 	}
-	spin_unlock(&vmap_area_lock);
 
 	/*
 	 * Mark allocated areas as accessible. Do it now as a best-effort
@@ -4253,55 +4333,57 @@ bool vmalloc_dump_obj(void *object)
 {
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 	const void *caller;
-	struct vm_struct *vm;
 	struct vmap_area *va;
+	struct vmap_node *vn;
 	unsigned long addr;
 	unsigned int nr_pages;
+	bool success = false;
 
-	if (!spin_trylock(&vmap_area_lock))
-		return false;
-	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
-	if (!va) {
-		spin_unlock(&vmap_area_lock);
-		return false;
-	}
+	vn = addr_to_node((unsigned long)objp);
 
-	vm = va->vm;
-	if (!vm) {
-		spin_unlock(&vmap_area_lock);
-		return false;
+	if (spin_trylock(&vn->busy.lock)) {
+		va = __find_vmap_area(addr, &vn->busy.root);
+
+		if (va && va->vm) {
+			addr = (unsigned long)va->vm->addr;
+			caller = va->vm->caller;
+			nr_pages = va->vm->nr_pages;
+			success = true;
+		}
+
+		spin_unlock(&vn->busy.lock);
 	}
-	addr = (unsigned long)vm->addr;
-	caller = vm->caller;
-	nr_pages = vm->nr_pages;
-	spin_unlock(&vmap_area_lock);
-	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		nr_pages, addr, caller);
-	return true;
+
+	if (success)
+		pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
+			nr_pages, addr, caller);
+
+	return success;
 }
 #endif
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
-	__acquires(&vmap_purge_lock)
-	__acquires(&vmap_area_lock)
 {
+	struct vmap_node *vn = addr_to_node(0);
+
 	mutex_lock(&vmap_purge_lock);
-	spin_lock(&vmap_area_lock);
+	spin_lock(&vn->busy.lock);
 
-	return seq_list_start(&vmap_area_list, *pos);
+	return seq_list_start(&vn->busy.head, *pos);
 }
 
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	return seq_list_next(p, &vmap_area_list, pos);
+	struct vmap_node *vn = addr_to_node(0);
+	return seq_list_next(p, &vn->busy.head, pos);
 }
 
 static void s_stop(struct seq_file *m, void *p)
-	__releases(&vmap_area_lock)
-	__releases(&vmap_purge_lock)
 {
-	spin_unlock(&vmap_area_lock);
+	struct vmap_node *vn = addr_to_node(0);
+
+	spin_unlock(&vn->busy.lock);
 	mutex_unlock(&vmap_purge_lock);
 }
 
@@ -4344,9 +4426,11 @@ static void show_purge_info(struct seq_file *m)
 
 static int s_show(struct seq_file *m, void *p)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
 	struct vm_struct *v;
 
+	vn = addr_to_node(0);
 	va = list_entry(p, struct vmap_area, list);
 
 	if (!va->vm) {
@@ -4397,7 +4481,7 @@ static int s_show(struct seq_file *m, void *p)
 	 * As a final step, dump "unpurged" areas.
 	 */
 final:
-	if (list_is_last(&va->list, &vmap_area_list))
+	if (list_is_last(&va->list, &vn->busy.head))
 		show_purge_info(m);
 
 	return 0;
@@ -4428,7 +4512,8 @@ static void vmap_init_free_space(void)
 {
 	unsigned long vmap_start = 1;
 	const unsigned long vmap_end = ULONG_MAX;
-	struct vmap_area *busy, *free;
+	struct vmap_area *free;
+	struct vm_struct *busy;
 
 	/*
 	 *     B     F     B     B     B     F
@@ -4436,12 +4521,12 @@ static void vmap_init_free_space(void)
 	 *  |           The KVA space           |
 	 *  |<--------------------------------->|
 	 */
-	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
+	for (busy = vmlist; busy; busy = busy->next) {
+		if ((unsigned long) busy->addr - vmap_start > 0) {
 			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
 			if (!WARN_ON_ONCE(!free)) {
 				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
+				free->va_end = (unsigned long) busy->addr;
 
 				insert_vmap_area_augment(free, NULL,
 					&free_vmap_area_root,
@@ -4449,7 +4534,7 @@ static void vmap_init_free_space(void)
 			}
 		}
 
-		vmap_start = busy->va_end;
+		vmap_start = (unsigned long) busy->addr + busy->size;
 	}
 
 	if (vmap_end - vmap_start > 0) {
@@ -4465,9 +4550,23 @@ static void vmap_init_free_space(void)
 	}
 }
 
+static void vmap_init_nodes(void)
+{
+	struct vmap_node *vn;
+	int i;
+
+	for (i = 0; i < nr_vmap_nodes; i++) {
+		vn = &vmap_nodes[i];
+		vn->busy.root = RB_ROOT;
+		INIT_LIST_HEAD(&vn->busy.head);
+		spin_lock_init(&vn->busy.lock);
+	}
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
+	struct vmap_node *vn;
 	struct vm_struct *tmp;
 	int i;
 
@@ -4489,6 +4588,11 @@ void __init vmalloc_init(void)
 		xa_init(&vbq->vmap_blocks);
 	}
 
+	/*
+	 * Setup nodes before importing vmlist.
+	 */
+	vmap_init_nodes();
+
 	/* Import existing vmlist entries. */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
@@ -4498,7 +4602,9 @@ void __init vmalloc_init(void)
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
 		va->vm = tmp;
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+
+		vn = addr_to_node(va->va_start);
+		insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
 	}
 
 	/*
-- 
2.39.2


