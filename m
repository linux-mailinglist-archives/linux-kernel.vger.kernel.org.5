Return-Path: <linux-kernel+bounces-17771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27651825265
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0121C23028
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47E28E12;
	Fri,  5 Jan 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4RPaeAa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC528DAF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccb923c4d2so15662551fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704451811; x=1705056611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxmF6hgaWDxL83/RiFp/pbdxQnZJvQkERCrsIdRQr+Y=;
        b=M4RPaeAaZmTkVb9s84KMguBhKd/hhmZsNFfM3X8kNczZblN6Fh3tXJTgGAvzagthBQ
         VtmOCSSJ2HD5VE01zsGo18gAkB/fSqOZYxpPZrjfP279vJqWrlWjbvCCDpTLdctgSh0t
         TV/D/BsP31wlmugOI/aVEpgJy/Z7N9r5drAM8MseGw6vn7J1Z65iJ56DKp/K2jwQ7HHY
         O6cPQ1Y4WP/LVb3iwdvtwO/tV75RnexaVrKBzkNy7V+54Jh3/ipf75wFyUqVntSaX7CB
         stLuR+B2hll8uqLqA0l++Y/jd4Bk2R6lOyLdpqA6HTj2EfhF5BgxJKlRGJYjIsgu4KG3
         +68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704451811; x=1705056611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxmF6hgaWDxL83/RiFp/pbdxQnZJvQkERCrsIdRQr+Y=;
        b=UANo7qq7KacP32R1tDSWl7WHeKhaWkYIQ1erTFU1tqAJIJJ50cWQUYQa/aDcm553Tc
         /D3NHYCAj2GxVqbQzSGmyv2dmI8vWLvwmfxOqfkxN1bHzgBXXu7AdWFbTgW3f09izK1v
         tQh/fXGNXWn7WVOqke95o68HOM/A1dAiPKYAYlakx14wGZ5MFhOJKnoQ3pnnUeaRaOUR
         7LSvXbl5j+JBakxwggAgK+1eAottF6YkVuHPs1xkKP++lZeHLW67oi4z4OAL5AkXJG9i
         JOhFaYStjoi4AcWw4PFrbpyVYpyViHm+yahBLC0WjB8+eErG5NlIwKqOMo0B5BloboEC
         mAEw==
X-Gm-Message-State: AOJu0Yx3JoIjJT/gKy4lCBCKxKWPo8V2mObP0lDcdaV/523bH1eoYTv+
	4dwI7qIuWgTeDcHIU7dU/O4=
X-Google-Smtp-Source: AGHT+IHqSt13dpnHAthqTWv0KF9Dc4NwVYi3Pwb6wRGw2041BPrdEvaFnA9i0HRwC8J2PMH/1uDQbQ==
X-Received: by 2002:a05:6512:1047:b0:50e:aee2:d55e with SMTP id c7-20020a056512104700b0050eaee2d55emr719450lfb.100.1704451810449;
        Fri, 05 Jan 2024 02:50:10 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id c22-20020a056512325600b0050e6d2125a6sm210354lfr.59.2024.01.05.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:50:10 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Fri, 5 Jan 2024 11:50:08 +0100
To: Wen Gu <guwen@linux.alibaba.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	shaozhengchao <shaozhengchao@huawei.com>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root
 rb-tree
Message-ID: <ZZfe4O850fFaxOgQ@pc638.lan>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
 <238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com>

Hello, Wen Gu.

> 
> Hi Uladzislau Rezki,
> 
> I really like your work, it is great and helpful!
> 
> Currently, I am working on using shared memory communication (SMC [1])
> to transparently accelerate TCP communication between two peers within
> the same OS instance[2].
> 
> In this scenario, a vzalloced kernel buffer acts as a shared memory and
> will be simultaneous read or written by two SMC sockets, thus forming an
> SMC connection.
> 
> 
>           socket1                    socket2
>              |                          ^
>              |                          |    userspace
>       ---- write -------------------- read ------
>              |    +-----------------+   |    kernel
>              +--->|  shared memory  |---+
>                   | (vzalloced now) |
>                   +-----------------+
> 
> Then I encountered the performance regression caused by lock contention
> in find_vmap_area() when multiple threads transfer data through multiple
> SMC connections on machines with many CPUs[3].
> 
> According to perf, the performance bottleneck is caused by the global
> vmap_area_lock contention[4]:
> 
> - writer:
> 
>   smc_tx_sendmsg
>   -> memcpy_from_msg
>      -> copy_from_iter
>         -> check_copy_size
>            -> check_object_size
>               -> if (CONFIG_HARDENED_USERCOPY is set) check_heap_object
>                  -> if(vm) find_vmap_area
>                     -> try to hold vmap_area_lock lock
> - reader:
> 
>   smc_rx_recvmsg
>    -> memcpy_to_msg
>       -> copy_to_iter
>          -> check_copy_size
>             -> check_object_size
>                -> if (CONFIG_HARDENED_USERCOPY is set) check_heap_object
>                   -> if(vm) find_vmap_area
>                      -> try to hold vmap_area_lock lock
> 
> Fortunately, thank you for this patch set, the global vmap_area_lock was
> removed and per node lock vn->busy.lock is introduced. it is really helpful:
> 
> In 48 CPUs qemu environment, the Requests/s increased by 5 times:
> - nginx
> - wrk -c 1000 -t 96 -d 30 http://127.0.0.1:80
> 
>                 vzalloced shmem      vzalloced shmem(with this patch set)
> Requests/sec          113536.56            583729.93
> 
> 
Thank you for the confirmation that your workload is improved. The "nginx"
is 5 times better!

> But it also has some overhead, compared to using kzalloced shared memory
> or unsetting CONFIG_HARDENED_USERCOPY, which won't involve finding vmap area:
> 
>                 kzalloced shmem      vzalloced shmem(unset CONFIG_HARDENED_USERCOPY)
> Requests/sec          831950.39            805164.78
> 
> 
The CONFIG_HARDENED_USERCOPY prevents coping "wrong" memory regions. That is 
why if it is a vmalloced memory it wants to make sure it is really true,
if not user-copy is aborted.

So there is an extra work that involves finding a VA associated with an address.

> So, as a newbie in Linux-mm, I would like to ask for some suggestions:
> 
> Is it possible to further eliminate the overhead caused by lock contention
> in find_vmap_area() in this scenario (maybe this is asking too much), or the
> only way out is not setting CONFIG_HARDENED_USERCOPY or not using vzalloced
> buffer in the situation where cocurrent kernel-userspace-copy happens?
> 
Could you please try below patch, if it improves this series further?
Just in case:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e30dabf68263..40acf53cadfb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -772,7 +772,7 @@ static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
 struct rb_list {
 	struct rb_root root;
 	struct list_head head;
-	spinlock_t lock;
+	rwlock_t lock;
 };
 
 struct vmap_pool {
@@ -947,19 +947,19 @@ find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
 
-		spin_lock(&vn->busy.lock);
+		read_lock(&vn->busy.lock);
 		va_lowest = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
 		if (va_lowest) {
 			if (!va_node || va_lowest->va_start < (*va)->va_start) {
 				if (va_node)
-					spin_unlock(&va_node->busy.lock);
+					read_unlock(&va_node->busy.lock);
 
 				*va = va_lowest;
 				va_node = vn;
 				continue;
 			}
 		}
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 	}
 
 	return va_node;
@@ -1695,9 +1695,9 @@ static void free_vmap_area(struct vmap_area *va)
 	/*
 	 * Remove from the busy tree/list.
 	 */
-	spin_lock(&vn->busy.lock);
+	write_lock(&vn->busy.lock);
 	unlink_va(va, &vn->busy.root);
-	spin_unlock(&vn->busy.lock);
+	write_unlock(&vn->busy.lock);
 
 	/*
 	 * Insert/Merge it back to the free tree/list.
@@ -1901,9 +1901,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	vn = addr_to_node(va->va_start);
 
-	spin_lock(&vn->busy.lock);
+	write_lock(&vn->busy.lock);
 	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
-	spin_unlock(&vn->busy.lock);
+	write_unlock(&vn->busy.lock);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
 	BUG_ON(va->va_start < vstart);
@@ -2123,10 +2123,10 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
 		if (RB_EMPTY_ROOT(&vn->lazy.root))
 			continue;
 
-		spin_lock(&vn->lazy.lock);
+		write_lock(&vn->lazy.lock);
 		WRITE_ONCE(vn->lazy.root.rb_node, NULL);
 		list_replace_init(&vn->lazy.head, &vn->purge_list);
-		spin_unlock(&vn->lazy.lock);
+		write_unlock(&vn->lazy.lock);
 
 		start = min(start, list_first_entry(&vn->purge_list,
 			struct vmap_area, list)->va_start);
@@ -2223,9 +2223,9 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	vn = is_vn_id_valid(vn_id) ?
 		id_to_node(vn_id):addr_to_node(va->va_start);
 
-	spin_lock(&vn->lazy.lock);
+	write_lock(&vn->lazy.lock);
 	insert_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
-	spin_unlock(&vn->lazy.lock);
+	write_unlock(&vn->lazy.lock);
 
 	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
 
@@ -2272,9 +2272,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	do {
 		vn = &vmap_nodes[i];
 
-		spin_lock(&vn->busy.lock);
+		read_lock(&vn->busy.lock);
 		va = __find_vmap_area(addr, &vn->busy.root);
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 
 		if (va)
 			return va;
@@ -2293,11 +2293,11 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 	do {
 		vn = &vmap_nodes[i];
 
-		spin_lock(&vn->busy.lock);
+		write_lock(&vn->busy.lock);
 		va = __find_vmap_area(addr, &vn->busy.root);
 		if (va)
 			unlink_va(va, &vn->busy.root);
-		spin_unlock(&vn->busy.lock);
+		write_unlock(&vn->busy.lock);
 
 		if (va)
 			return va;
@@ -2514,9 +2514,9 @@ static void free_vmap_block(struct vmap_block *vb)
 	BUG_ON(tmp != vb);
 
 	vn = addr_to_node(vb->va->va_start);
-	spin_lock(&vn->busy.lock);
+	write_lock(&vn->busy.lock);
 	unlink_va(vb->va, &vn->busy.root);
-	spin_unlock(&vn->busy.lock);
+	write_unlock(&vn->busy.lock);
 
 	free_vmap_area_noflush(vb->va);
 	kfree_rcu(vb, rcu_head);
@@ -2942,9 +2942,9 @@ static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 {
 	struct vmap_node *vn = addr_to_node(va->va_start);
 
-	spin_lock(&vn->busy.lock);
+	read_lock(&vn->busy.lock);
 	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vn->busy.lock);
+	read_unlock(&vn->busy.lock);
 }
 
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
@@ -4214,19 +4214,19 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 	next_va:
 		next = va->va_end;
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 	} while ((vn = find_vmap_area_exceed_addr_lock(next, &va)));
 
 finished_zero:
 	if (vn)
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 
 	/* zero-fill memory holes */
 	return count - remains + zero_iter(iter, remains);
 finished:
 	/* Nothing remains, or We couldn't copy/zero everything. */
 	if (vn)
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 
 	return count - remains;
 }
@@ -4563,11 +4563,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	for (area = 0; area < nr_vms; area++) {
 		struct vmap_node *vn = addr_to_node(vas[area]->va_start);
 
-		spin_lock(&vn->busy.lock);
+		write_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
 		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
-		spin_unlock(&vn->busy.lock);
+		write_unlock(&vn->busy.lock);
 	}
 
 	/*
@@ -4687,7 +4687,7 @@ bool vmalloc_dump_obj(void *object)
 
 	vn = addr_to_node((unsigned long)objp);
 
-	if (spin_trylock(&vn->busy.lock)) {
+	if (read_trylock(&vn->busy.lock)) {
 		va = __find_vmap_area(addr, &vn->busy.root);
 
 		if (va && va->vm) {
@@ -4697,7 +4697,7 @@ bool vmalloc_dump_obj(void *object)
 			success = true;
 		}
 
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 	}
 
 	if (success)
@@ -4742,13 +4742,13 @@ static void show_purge_info(struct seq_file *m)
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
 
-		spin_lock(&vn->lazy.lock);
+		read_lock(&vn->lazy.lock);
 		list_for_each_entry(va, &vn->lazy.head, list) {
 			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
 				(void *)va->va_start, (void *)va->va_end,
 				va->va_end - va->va_start);
 		}
-		spin_unlock(&vn->lazy.lock);
+		read_unlock(&vn->lazy.lock);
 	}
 }
 
@@ -4762,7 +4762,7 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
 
-		spin_lock(&vn->busy.lock);
+		read_lock(&vn->busy.lock);
 		list_for_each_entry(va, &vn->busy.head, list) {
 			if (!va->vm) {
 				if (va->flags & VMAP_RAM)
@@ -4808,7 +4808,7 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			show_numa_info(m, v);
 			seq_putc(m, '\n');
 		}
-		spin_unlock(&vn->busy.lock);
+		read_unlock(&vn->busy.lock);
 	}
 
 	/*
@@ -4902,11 +4902,11 @@ static void vmap_init_nodes(void)
 		vn = &vmap_nodes[n];
 		vn->busy.root = RB_ROOT;
 		INIT_LIST_HEAD(&vn->busy.head);
-		spin_lock_init(&vn->busy.lock);
+		rwlock_init(&vn->busy.lock);
 
 		vn->lazy.root = RB_ROOT;
 		INIT_LIST_HEAD(&vn->lazy.head);
-		spin_lock_init(&vn->lazy.lock);
+		rwlock_init(&vn->lazy.lock);
 
 		for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
 			INIT_LIST_HEAD(&vn->pool[i].head);
<snip>

Thank you!

--
Uladzislau Rezki

