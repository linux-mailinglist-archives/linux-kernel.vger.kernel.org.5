Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B737C7241
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379205AbjJLQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbjJLQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:16:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99147EA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:16:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d8c05784so959477b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697127384; x=1697732184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny485M0AU8MmmUOX+bFbVHEs+lAeqc0RdPdwyQFkVFQ=;
        b=EQQJGLghL1Fh+DROpsh8cgyBKEKsuSpAYjTpfTBiQdfnE3VSfgK94w41v8BE1cWyGN
         BXqlkywfOFYNBJHkJPoEX1j8x2KTfiZd4KoXowWfufagpAyszLkEiWZAXW54kENSuM4c
         cyD+SGzWcYIiDkEWXzHL/ehJjqp8IJU1+69jABDWi0ivWYRhlbYSMWvQxjxr30ejYbmc
         jp6n1rKxsQjcfCaqN5DmbpLNnywlQOXezFHztiXsxpmj3d5ANRPgOZRI4vtuq/W44xKi
         SewPdVqTmQmOqeM+hT8chju1RLt6BSy/C+9cjgkZlMBToecBxBliMDYvccR9bu2YgBio
         gbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127384; x=1697732184;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny485M0AU8MmmUOX+bFbVHEs+lAeqc0RdPdwyQFkVFQ=;
        b=IwJnkhEOtYAbzqOjk8QrMLLide8ErKCYkzYS7SwAkdT1ojktigzjNdcECL94mvuhZT
         NXS3gFGJTBmxP2/bIArmPdpQ3wwURdsqaKApIlKEhY5nqTUCFfzZhFRF7x0zQEBqkzIu
         sb22EN6RGLLy3T4V2Cjw13ZMH/JW2e4act5EZz5nOl8DgI7X6rDEx85Z/YyVc+GsBD27
         7CQPy2i+6ON2XcaG7Z+DkOJe53JMDu21qm8dWcRLDY1pe/1UxVAM5qWszzTxRSca9mQ+
         F870dW4eFVABOKl2r/OTI05bv+O6RsAOourCiqHoIl3Y3etFK5N4iXHEoltOoblzymQk
         ZPeg==
X-Gm-Message-State: AOJu0YxB4EqiHM+VR4slNTZH0VlLMswtR+hkKGlOCtPRF6k8I20YB7fk
        5Mh3zsckLkxSiZc28JXfitY1WIIoJH13PHVxXDCz0Q==
X-Google-Smtp-Source: AGHT+IGhQknklyuQH/X9dNkqip0s4RYoK7vEegagFPI75/kA7TDmJk5bgD1yFVquGpsoyMjlCIqgFQ==
X-Received: by 2002:a05:6a20:1450:b0:16b:80f2:f30c with SMTP id a16-20020a056a20145000b0016b80f2f30cmr18450252pzi.26.1697127383570;
        Thu, 12 Oct 2023 09:16:23 -0700 (PDT)
Received: from [192.168.3.101] ([104.28.240.135])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709026b0b00b001c3267ae317sm2171057plk.165.2023.10.12.09.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:16:23 -0700 (PDT)
Message-ID: <da8d0422-756a-364d-9d57-bc3455ab97dc@bytedance.com>
Date:   Fri, 13 Oct 2023 00:16:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
 <20230905015255.81545-2-wuqiang.matt@bytedance.com>
 <20230923184858.d82abcf71e5f02c4c070543b@kernel.org>
 <84dacdd7-3364-9cb6-3b9e-2bf348e10449@bytedance.com>
 <20231009231938.c6830d986103da57ce55d26d@kernel.org>
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH v9 1/5] lib: objpool added: ring-array based lockless MPMC
In-Reply-To: <20231009231938.c6830d986103da57ce55d26d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami,

I've udpated the objpool patch and did some function testings for X64 and
ARM64. Later I'll do the performance testings and more regressions.

Here are the changelogs:
1) new struct objpool_node added to represent the real percpu ring arrary
    and struct objpool_slot now represents the expansion of objpool_node.
    ages[] and entries[] are now managed by objpool_slot (which is managed
    by objpool_head)
2) ages[] added back to objpool_try_add_slot and objpool_try_get_slot
3) unnecessary OBJPOOL_FLAG definitions are removed
4) unnecessary head/tail loading removed since try_cmpxchg_acuiqre and
    try_cmxchg_release have inherent memory loading embeded
5) objpool_fini refined to make sure the extra refcount to be released

The new version is attached in this mail for your review. And I will
prepare the full patch after the regression testings.

Best regards,
wuqiang


diff --git a/include/linux/objpool.h b/include/linux/objpool.h
new file mode 100644
index 000000000000..f3e066601df2
--- /dev/null
+++ b/include/linux/objpool.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_OBJPOOL_H
+#define _LINUX_OBJPOOL_H
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+
+/*
+ * objpool: ring-array based lockless MPMC queue
+ *
+ * Copyright: wuqiang.matt@bytedance.com,mhiramat@kernel.org
+ *
+ * The object pool is a scalable implementaion of high performance queue
+ * for objects allocation and reclamation, such as kretprobe instances.
+ *
+ * With leveraging per-cpu ring-array to mitigate the hot spots of memory
+ * contention, it could deliver near-linear scalability for high parallel
+ * scenarios. objpomol is best suited for following cases:
+ * 1) Memory allocation or reclamation are prohibited or too expensive
+ * 2) Consumers are of different priorities, such as irqs and threads
+ *
+ * Limitations:
+ * 1) Maximum objects (capacity) is determined during pool initializing
+ * 2) The memory of objects won't be freed until the pool is finalized
+ * 3) Object allocation (pop) may fail after trying all cpu slots
+ */
+
+/**
+ * struct objpool_node - percpu ring array of objpool
+ * @head: head sequence of the local ring array
+ * @tail: tail sequence of the local ring array
+ *
+ * Represents a cpu-local array-based ring buffer, its size is specialized
+ * during initialization of object pool. The percpu objpool node is to be
+ * allocated from local memory for NUMA system, and to be kept compact in
+ * continuous memory: CPU assigned number of objects are stored just after
+ * the body of objpool_node.
+ *
+ * Real size of the ring array is far too smaller than the value range of
+ * head and tail, typed as uint32_t: [0, 2^32), so only lower bits of head
+ * and tail are used as the actual position in the ring array. In general
+ * the ring array is acting like a small sliding window, which is always
+ * moving forward in the loop of [0, 2^32).
+ */
+ struct objpool_node {
+	uint32_t            head;
+	uint32_t            tail;
+} __packed;
+
+/**
+ * struct objpool_slot - the expansion of percpu objpool_node
+ * @node: the pointer of percpu objpool_node
+ * @ages: unique sequence number to avoid ABA
+ * @entries: object entries on this slot
+ */
+struct objpool_slot {
+	struct objpool_node *node;
+	uint32_t            *ages;
+	void *              *entries;
+};
+
+struct objpool_head;
+
+/*
+ * caller-specified callback for object initial setup, it's only called
+ * once for each object (just after the memory allocation of the object)
+ */
+typedef int (*objpool_init_obj_cb)(void *obj, void *context);
+
+/* caller-specified cleanup callback for objpool destruction */
+typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
+
+/**
+ * struct objpool_head - object pooling metadata
+ * @obj_size:   object size, aligned to sizeof(void *)
+ * @nr_objs:    total objs (to be pre-allocated with objpool)
+ * @nr_cpus:    local copy of nr_cpu_ids
+ * @capacity:   max objs can be managed by one objpool_slot
+ * @gfp:        gfp flags for kmalloc & vmalloc
+ * @ref:        refcount of objpool
+ * @flags:      flags for objpool management
+ * @cpu_slots:  pointer to the array of objpool_slot
+ * @release:    resource cleanup callback
+ * @context:    caller-provided context
+ */
+struct objpool_head {
+	int                     obj_size;
+	int                     nr_objs;
+	int                     nr_cpus;
+	int                     capacity;
+	gfp_t                   gfp;
+	refcount_t              ref;
+	unsigned long           flags;
+	struct objpool_slot    *cpu_slots;
+	objpool_fini_cb         release;
+	void                   *context;
+};
+
+#define OBJPOOL_NR_OBJECT_MAX	(1UL << 24) /* maximum numbers of total objects */
+#define OBJPOOL_OBJECT_SIZE_MAX	(1UL << 16) /* maximum size of an object */
+
+/**
+ * objpool_init() - initialize objpool and pre-allocated objects
+ * @pool:    the object pool to be initialized, declared by caller
+ * @nr_objs: total objects to be pre-allocated by this object pool
+ * @object_size: size of an object (should be > 0)
+ * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
+ * @context: user context for object initialization callback
+ * @objinit: object initialization callback for extra setup
+ * @release: cleanup callback for extra cleanup task
+ *
+ * return value: 0 for success, otherwise error code
+ *
+ * All pre-allocated objects are to be zeroed after memory allocation.
+ * Caller could do extra initialization in objinit callback. objinit()
+ * will be called just after slot allocation and will be only once for
+ * each object. Since then the objpool won't touch any content of the
+ * objects. It's caller's duty to perform reinitialization after each
+ * pop (object allocation) or do clearance before each push (object
+ * reclamation).
+ */
+int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
+		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
+		 objpool_fini_cb release);
+
+/**
+ * objpool_pop() - allocate an object from objpool
+ * @pool: object pool
+ *
+ * return value: object ptr or NULL if failed
+ */
+void *objpool_pop(struct objpool_head *pool);
+
+/**
+ * objpool_push() - reclaim the object and return back to objpool
+ * @obj:  object ptr to be pushed to objpool
+ * @pool: object pool
+ *
+ * return: 0 or error code (it fails only when user tries to push
+ * the same object multiple times or wrong "objects" into objpool)
+ */
+int objpool_push(void *obj, struct objpool_head *pool);
+
+/**
+ * objpool_drop() - discard the object and deref objpool
+ * @obj:  object ptr to be discarded
+ * @pool: object pool
+ *
+ * return: 0 if objpool was released; -EAGAIN if there are still
+ *         outstanding objects
+ *
+ * objpool_drop is normally for the release of outstanding objects
+ * after objpool cleanup (objpool_fini). Thinking of this example:
+ * kretprobe is unregistered and objpool_fini() is called to release
+ * all remained objects, but there are still objects being used by
+ * unfinished kretprobes (like blockable function: sys_accept). So
+ * only when the last outstanding object is dropped could the whole
+ * objpool be released along with the call of objpool_drop()
+ */
+int objpool_drop(void *obj, struct objpool_head *pool);
+
+/**
+ * objpool_free() - release objpool forcely (all objects to be freed)
+ * @pool: object pool to be released
+ */
+void objpool_free(struct objpool_head *pool);
+
+/**
+ * objpool_fini() - deref object pool (also releasing unused objects)
+ * @pool: object pool to be dereferenced
+ *
+ * objpool_fini() will try to release all remained free objects and
+ * then drop an extra reference of objpool. So if all objects are
+ * already returned to objpool, the objpool will be freed too. But
+ * if there are still outstanding objects (blockable kretprobes),
+ * the objpool won't be released until all the oustanding objects
+ * are dropped
+ */
+void objpool_fini(struct objpool_head *pool);
+
+#endif /* _LINUX_OBJPOOL_H */
diff --git a/lib/objpool.c b/lib/objpool.c
new file mode 100644
index 000000000000..628993d93638
--- /dev/null
+++ b/lib/objpool.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/objpool.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/prefetch.h>
+#include <linux/irqflags.h>
+#include <linux/cpumask.h>
+#include <linux/log2.h>
+
+/*
+ * objpool: ring-array based lockless MPMC/FIFO queues
+ *
+ * Copyright: wuqiang.matt@bytedance.com,mhiramat@kernel.org
+ */
+
+#define NODE_AGES(p, n) (uint32_t *)((char *)(n) + sizeof(struct objpool_node))
+#define NODE_ENTS(p, n) (void **)((char *)(n) + sizeof(struct objpool_node) + \
+			sizeof(uint32_t) * (p)->capacity)
+#define NODE_OBJS(p, n) (void *)((char *)(n) + sizeof(struct objpool_node) + \
+			(sizeof(uint32_t) + sizeof(void *)) * (p)->capacity)
+
+/* initialize percpu objpool_slot */
+static int
+objpool_init_percpu_slot(struct objpool_head *pool,
+			 struct objpool_slot *slot,
+			 struct objpool_node *node,
+			 int nodes, void *context,
+			 objpool_init_obj_cb objinit)
+{
+	uint32_t mask = pool->capacity - 1;
+	int i;
+
+	/* initialize percpu objpool_slot */
+	slot->node = node;
+	slot->ages = NODE_AGES(pool, node);
+	slot->entries = NODE_ENTS(pool, node);
+
+	/*
+	 * manually set head & tail to avoid possible conflict:
+	 * We assume that the head item is ready for retrieval
+	 * iff head is equal to ages[head & mask]. but ages is
+	 * initialized as 0, so in view of the caller of pop(),
+	 * the 1st item (0th) is always ready, but the reality
+	 * could be: push() is stalled before the final update,
+	 * thus the item being inserted will be lost forever
+	 */
+	node->head = node->tail = pool->capacity;
+
+	/* initialize ages and entries of this objpool_slot */
+	for (i = 0; i < nodes; i++) {
+		void *obj = NODE_OBJS(pool, node) + i * pool->obj_size;
+		if (objinit) {
+			int rc = objinit(obj, context);
+			if (rc)
+				return rc;
+		}
+		slot->ages[node->tail & mask] = node->tail;
+		slot->entries[node->tail & mask] = obj;
+		node->tail++;
+		pool->nr_objs++;
+	}
+
+	return 0;
+}
+
+/* allocate and initialize percpu slots */
+static int
+objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
+			  void *context, objpool_init_obj_cb objinit)
+{
+	int i, cpu_count = 0;
+
+	for (i = 0; i < pool->nr_cpus; i++) {
+
+		struct objpool_node *node;
+		int nodes, size, rc;
+
+		/* skip the cpu node which could never be present */
+		if (!cpu_possible(i))
+			continue;
+
+		/* compute how many objects to be allocated with this slot */
+		nodes = nr_objs / num_possible_cpus();
+		if (cpu_count < (nr_objs % num_possible_cpus()))
+			nodes++;
+		cpu_count++;
+
+		size = pool->obj_size * nodes + sizeof(struct objpool_node) +
+		       (sizeof(void *) + sizeof(uint32_t)) * pool->capacity;
+
+		/*
+		 * here we allocate percpu-slot & objs together in a single
+		 * allocation to make it more compact, taking advantage of
+		 * warm caches and TLB hits. in default vmalloc is used to
+		 * reduce the pressure of kernel slab system. as we know,
+		 * mimimal size of vmalloc is one page since vmalloc would
+		 * always align the requested size to page size
+		 */
+		if (pool->gfp & GFP_ATOMIC)
+			node = kmalloc_node(size, pool->gfp, cpu_to_node(i));
+		else
+			node = __vmalloc_node(size, sizeof(void *), pool->gfp,
+				cpu_to_node(i), __builtin_return_address(0));
+		if (!node)
+			return -ENOMEM;
+		memset(node, 0, size);
+
+		/* initialize the objpool_slot of cpu node i */
+		rc = objpool_init_percpu_slot(pool, &pool->cpu_slots[i],
+					node, nodes, context, objinit);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+/* cleanup all percpu slots of the object pool */
+static void objpool_fini_percpu_slots(struct objpool_head *pool)
+{
+	int i;
+
+	if (!pool->cpu_slots)
+		return;
+
+	for (i = 0; i < pool->nr_cpus; i++)
+		kvfree(pool->cpu_slots[i].node);
+	kfree(pool->cpu_slots);
+}
+
+/* initialize object pool and pre-allocate objects */
+int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
+		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
+		objpool_fini_cb release)
+{
+	int rc, capacity, slot_size;
+
+	/* check input parameters */
+	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
+	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
+		return -EINVAL;
+
+	/* align up to unsigned long size */
+	object_size = ALIGN(object_size, sizeof(long));
+
+	/* calculate capacity of percpu objpool_slot */
+	capacity = roundup_pow_of_two(nr_objs);
+	if (!capacity)
+		return -EINVAL;
+
+	/* initialize objpool pool */
+	memset(pool, 0, sizeof(struct objpool_head));
+	pool->nr_cpus = nr_cpu_ids;
+	pool->obj_size = object_size;
+	pool->capacity = capacity;
+	pool->gfp = gfp & ~__GFP_ZERO;
+	pool->context = context;
+	pool->release = release;
+	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
+	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
+	if (!pool->cpu_slots)
+		return -ENOMEM;
+
+	/* initialize per-cpu slots */
+	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
+	if (rc)
+		objpool_fini_percpu_slots(pool);
+	else
+		refcount_set(&pool->ref, pool->nr_objs + 1);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(objpool_init);
+
+/* adding object to slot, abort if the slot was already full */
+static inline int
+objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
+{
+	struct objpool_slot *slot = &pool->cpu_slots[cpu];
+	struct objpool_node *node = slot->node;
+	uint32_t head, tail, mask = pool->capacity - 1;
+
+	/* loading tail and head as a local snapshot, tail first */
+	tail = READ_ONCE(node->tail);
+
+	do {
+		head = READ_ONCE(node->head);
+		/* fault caught: something must be wrong */
+		WARN_ON_ONCE(tail - head > pool->nr_objs);
+	} while (!try_cmpxchg_acquire(&node->tail, &tail, tail + 1));
+
+	/* now the tail position is reserved for the given obj */
+	WRITE_ONCE(slot->entries[tail & mask], obj);
+	/* update sequence to make this obj available for pop() */
+	smp_store_release(&slot->ages[tail & mask], tail);
+
+	return 0;
+}
+
+/* reclaim an object to object pool */
+int objpool_push(void *obj, struct objpool_head *pool)
+{
+	unsigned long flags;
+	int rc;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
+	raw_local_irq_restore(flags);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(objpool_push);
+
+/* try to retrieve object from slot */
+static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
+{
+	struct objpool_slot *slot = &pool->cpu_slots[cpu];
+	struct objpool_node *node = slot->node;
+	uint32_t head, mask = pool->capacity - 1;
+
+	/* load node->head and save to local head */
+	head = smp_load_acquire(&node->head);
+
+	while (head != READ_ONCE(node->tail)) {
+		uint32_t pos = head & mask, prev = head;
+
+		/* do prefetching of the object pointer */
+		prefetch(&slot->entries[pos]);
+
+		/* check whether the object is ready for retrieval */
+		if (smp_load_acquire(&slot->ages[pos]) == head) {
+			/* obj must've been udpated by its push() */
+			void *obj = READ_ONCE(slot->entries[pos]);
+			/* try to commit and move forward by 1 */
+			if (try_cmpxchg_release(&node->head, &head, head + 1))
+				return obj;
+			/* head mismatch: was consumed by other nodes */
+		} else {
+			/* refresh head from memory and retry */
+			head = READ_ONCE(node->head);
+			/*
+			* head stays unchanged, so it's very likely there's
+			* an ongoing push() on other cpu nodes but yet not
+			* update ages[] to mark it's completion
+			*/
+			if (head == prev)
+				break;
+		}
+	}
+
+	return NULL;
+}
+
+/* allocate an object from object pool */
+void *objpool_pop(struct objpool_head *pool)
+{
+	void *obj = NULL;
+	unsigned long flags;
+	int i, cpu;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+
+	cpu = raw_smp_processor_id();
+	for (i = 0; i < num_possible_cpus(); i++) {
+		obj = objpool_try_get_slot(pool, cpu);
+		if (obj)
+			break;
+		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
+	}
+	raw_local_irq_restore(flags);
+
+	return obj;
+}
+EXPORT_SYMBOL_GPL(objpool_pop);
+
+/* release whole objpool forcely */
+void objpool_free(struct objpool_head *pool)
+{
+	if (!pool->cpu_slots)
+		return;
+
+	/* release percpu slots */
+	objpool_fini_percpu_slots(pool);
+
+	/* call user's cleanup callback if provided */
+	if (pool->release)
+		pool->release(pool, pool->context);
+}
+EXPORT_SYMBOL_GPL(objpool_free);
+
+/* drop the allocated object, rather reclaim it to objpool */
+int objpool_drop(void *obj, struct objpool_head *pool)
+{
+	if (!obj || !pool)
+		return -EINVAL;
+
+	if (refcount_dec_and_test(&pool->ref)) {
+		objpool_free(pool);
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(objpool_drop);
+
+/* drop unused objects and defref objpool for releasing */
+void objpool_fini(struct objpool_head *pool)
+{
+	void *obj;
+
+	do {
+		/* grab object from objpool and drop it */
+		obj = objpool_pop(pool);
+
+		/*
+		 * drop reference of objpool anyway even if
+		 * the obj is NULL, since one extra ref upon
+		 * objpool was already grabbed during pool
+		 * initialization in objpool_init()
+		 */
+		if (refcount_dec_and_test(&pool->ref))
+			objpool_free(pool);
+	} while (obj);
+}
+EXPORT_SYMBOL_GPL(objpool_fini);


On 2023/10/9 22:19, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Mon, 9 Oct 2023 02:40:53 +0800
> wuqiang <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2023/9/23 17:48, Masami Hiramatsu (Google) wrote:
>>> Hi Wuqiang,
>>>
>>> Sorry for replying later.
>>>
>>> On Tue,  5 Sep 2023 09:52:51 +0800
>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>
>>>> The object pool is a scalable implementaion of high performance queue
>>>> for object allocation and reclamation, such as kretprobe instances.
>>>>
>>>> With leveraging percpu ring-array to mitigate the hot spot of memory
>>>> contention, it could deliver near-linear scalability for high parallel
>>>> scenarios. The objpool is best suited for following cases:
>>>> 1) Memory allocation or reclamation are prohibited or too expensive
>>>> 2) Consumers are of different priorities, such as irqs and threads
>>>>
>>>> Limitations:
>>>> 1) Maximum objects (capacity) is determined during pool initializing
>>>>      and can't be modified (extended) after objpool creation
>>>
>>> So the pool size is fixed in initialization.
>>
>> Right. The arrary size will be up-rounded to the exponent of 2, but the
>> actual number of objects (to be allocated) are the exact value specified
>> by user.
> 
> Yeah, this makes easy to use the seq-number as index.
> 
>>
>>>
>>>> 2) The memory of objects won't be freed until objpool is finalized
>>>> 3) Object allocation (pop) may fail after trying all cpu slots
>>>
>>> This means that object allocation will fail if the all pools are empty,
>>> right?
>>
>> Yes, pop() will return NULL for this case. pop() does the checking for
>> only 1 round of all cpu nodes.
>>
>> The objpool might not be empty since new object could be inserted back
>> in the meaintime by other nodes, which is natural for lockless queues.
> 
> OK.
> 
>>
>>>
>>>>
>>>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>>>> ---
>>>>    include/linux/objpool.h | 174 +++++++++++++++++++++
>>>>    lib/Makefile            |   2 +-
>>>>    lib/objpool.c           | 338 ++++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 513 insertions(+), 1 deletion(-)
>>>>    create mode 100644 include/linux/objpool.h
>>>>    create mode 100644 lib/objpool.c
>>>>
>>>> diff --git a/include/linux/objpool.h b/include/linux/objpool.h
>>>> new file mode 100644
>>>> index 000000000000..33c832216b98
>>>> --- /dev/null
>>>> +++ b/include/linux/objpool.h
>>>> @@ -0,0 +1,174 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +
>>>> +#ifndef _LINUX_OBJPOOL_H
>>>> +#define _LINUX_OBJPOOL_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <linux/refcount.h>
>>>> +
>>>> +/*
>>>> + * objpool: ring-array based lockless MPMC queue
>>>> + *
>>>> + * Copyright: wuqiang.matt@bytedance.com
>>>> + *
>>>> + * The object pool is a scalable implementaion of high performance queue
>>>> + * for objects allocation and reclamation, such as kretprobe instances.
>>>> + *
>>>> + * With leveraging per-cpu ring-array to mitigate the hot spots of memory
>>>> + * contention, it could deliver near-linear scalability for high parallel
>>>> + * scenarios. The ring-array is compactly managed in a single cache-line
>>>> + * to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
>>>> + * The body of pre-allocated objects is stored in continuous cache-lines
>>>> + * just after the ring-array.
>>>
>>> I consider the size of entries may be big if we have larger number of
>>> CPU cores, like 72-cores. And if user specifies (2^n) + 1 entries.
>>> In this case, each CPU has (2^n - 1)/72 objects, but has 2^(n + 1)
>>> entries in ring buffer. So it should be noted.
>>
>> Yes for the arrary size since it‘s up-rounded to the exponent of 2, but the
>> actual number of pre-allocated objects will stay the same as user specified.
>>
>>>> + *
>>>> + * The object pool is interrupt safe. Both allocation and reclamation
>>>> + * (object pop and push operations) can be preemptible or interruptable.
>>>
>>> You've added raw_spinlock_disable/enable(), so it is not preemptible
>>> or interruptible anymore. (Anyway, caller doesn't take care of that)
>>
>> Sure, this decription is imporper and unnecessary. Will be removed.
>>
>>>> + *
>>>> + * It's best suited for following cases:
>>>> + * 1) Memory allocation or reclamation are prohibited or too expensive
>>>> + * 2) Consumers are of different priorities, such as irqs and threads
>>>> + *
>>>> + * Limitations:
>>>> + * 1) Maximum objects (capacity) is determined during pool initializing
>>>> + * 2) The memory of objects won't be freed until the pool is finalized
>>>> + * 3) Object allocation (pop) may fail after trying all cpu slots
>>>> + */
>>>> +
>>>> +/**
>>>> + * struct objpool_slot - percpu ring array of objpool
>>>> + * @head: head of the local ring array (to retrieve at)
>>>> + * @tail: tail of the local ring array (to append at)
>>>> + * @bits: log2 of capacity (for bitwise operations)
>>>> + * @mask: capacity - 1
>>>
>>> These description does not give idea what those roles are.
>>
>> I'll refine the description. objpool_slot is totally internal to objpool.
>>
>>>
>>>> + *
>>>> + * Represents a cpu-local array-based ring buffer, its size is specialized
>>>> + * during initialization of object pool. The percpu objpool slot is to be
>>>> + * allocated from local memory for NUMA system, and to be kept compact in
>>>> + * continuous memory: ages[] is stored just after the body of objpool_slot,
>>>> + * and then entries[]. ages[] describes revision of each item, solely used
>>>> + * to avoid ABA; entries[] contains pointers of the actual objects
>>>> + *
>>>> + * Layout of objpool_slot in memory:
>>>> + *
>>>> + * 64bit:
>>>> + *        4      8      12     16        32                 64
>>>> + * | head | tail | bits | mask | ages[4] | ents[4]: (8 * 4) | objects
>>>> + *
>>>> + * 32bit:
>>>> + *        4      8      12     16        32        48       64
>>>> + * | head | tail | bits | mask | ages[4] | ents[4] | unused | objects
>>>
>>> Hm, the '4' here means number of objects after this objpool_slot?
>>> I don't recommend you to allocate several arraies after the header, instead,
>>> using another data structure like this;
>>>
>>> |head|tail|bits|mask|ents[N]{age:4|offs:4}|padding|objects
>>>
>>> here N means the number of total objects.
>>
>> Sorry for the confusion, I will make it more clear. Here 4/8/.../64 are offset
>> in bytes. The above is an example with the objpool_slot compacted in a single
>> cache line.
> 
> But in that case, the entry number may not be enough for storing all object.
> (or limit the number of objects)
> 
> Actually, since the rethook needs to make a shadow stack list per task not
> per cpu, the (safe) required number of object is usually proportional to the
> number of active tasks. kretprobes sets the default number of nodes according
> to the CPUs but it is minimum requirement. This is because,
> - most of the kernel functions are not nested, thus it is called once on each
>   thread in the kernel.
> - the thread can be scheduled or slept, thus the function return hook also is
>    not done until the thread comes back.
> So, usually, the recommended number of node (obj) will be 100-200 (depends on
> the system.) If it is a server, it may be more than 1000.
> 
>>
>>>
>>> struct objpool_entry {
>>> 	uint32_t	age;
>>> 	void *	ptr;
>>> } __attribute__((packed,aligned(8))) ;
>>>
>>>> + *
>>>> + */
>>>> +struct objpool_slot {
>>>> +	uint32_t                head;
>>>> +	uint32_t                tail;
>>>> +	uint32_t                bits;
>>>> +	uint32_t                mask;
>>>
>>> 	struct objpool_entry	entries[];
>>>
>>>> +} __packed;
>>>
>>> Then, you don't need complex macros to access object, but you need only one
>>> inline function to get the actual object address.
>>>
>>> static inline void *objpool_slot_object(struct objpool_slot *slot, int nth)
>>> {
>>> 	if (nth > (1 << bits))
>>> 		return NULL;
>>>
>>> 	return (void *)((unsigned long)slot + slot.entries[nth].offs);
>>> }
>>
>> The reason of these macroes is to compact objpool_slot/ages/ents to hot cache
>> lines and also minimize the memory footprint.
> 
> Hmm, at this moment, I don't recommend you to stick on the cache line but
> easier to read. If you have any number, you can add optimize patch afterwards.
> But the initial patch should take care about the readability.
> 
>>
>> objpool_head could be a better place to manage these pointers, similarly as
>> cpu_slots. I'll recheck the overhead.
>>
>>
>>>> +
>>>> +struct objpool_head;
>>>> +
>>>> +/*
>>>> + * caller-specified callback for object initial setup, it's only called
>>>> + * once for each object (just after the memory allocation of the object)
>>>> + */
>>>> +typedef int (*objpool_init_obj_cb)(void *obj, void *context);
>>>> +
>>>> +/* caller-specified cleanup callback for objpool destruction */
>>>> +typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
>>>> +
>>>> +/**
>>>> + * struct objpool_head - object pooling metadata
>>>> + * @obj_size:   object & element size
>>>
>>> What does the 'element' mean?
>>
>> "object size" should be enough. "element" means object, so it's unnecessary.
>>
>>>
>>>> + * @nr_objs:    total objs (to be pre-allocated)
>>>
>>> but all objects must be pre-allocated, right? then it is simply
>>
>> Yes, all objects are pre-allocated for this implementation.
>>
>>>
>>> @nr_objs: the total number of objects in this objpool.
>>>
>>>> + * @nr_cpus:    nr_cpu_ids
>>>
>>> would we have to save it? or just use 'nr_cpu_ids'?
>>
>> Yes, it's just a local save of nr_cpu_ids, just to make the members of
>> objpool_head aligned by 64 bits (there could be a 4-byte hold anyway).
>> And possible beatification from hot TLB cache ?
> 
> Unless you pack the data structure, you don't need to care about
> the cache. And the compiler works better than human for initial work.
> At this moment, it is more important to reduce the members as simple
> as possible.
> 
>>
>>>
>>>> + * @capacity:   max objects per cpuslot
>>>
>>> what is 'cpuslot'?
>>> This seems the size of objpool_entry array in objpool_slot.
>>
>> Yes, should be "capacity per objpool_slot", i.e. "maximum objects could be
>> stored in a objpool_slot".
>>
>>>> + * @gfp:        gfp flags for kmalloc & vmalloc
>>>> + * @ref:        refcount for objpool
>>>> + * @flags:      flags for objpool management
>>>> + * @cpu_slots:  array of percpu slots
>>>> + * @slot_sizes:	size in bytes of slots
>>>> + * @release:    resource cleanup callback
>>>> + * @context:    caller-provided context
>>>> + */
>>>> +struct objpool_head {
>>>> +	int                     obj_size;
>>>> +	int                     nr_objs;
>>>> +	int                     nr_cpus;
>>>> +	int                     capacity;
>>>> +	gfp_t                   gfp;
>>>> +	refcount_t              ref;
>>>> +	unsigned long           flags;
>>>> +	struct objpool_slot   **cpu_slots;
>>>> +	int                    *slot_sizes;
>>>> +	objpool_fini_cb         release;
>>>> +	void                   *context;
>>>> +};
>>>> +
>>>> +#define OBJPOOL_FROM_VMALLOC	(0x800000000)	/* objpool allocated from vmalloc area */
>>>> +#define OBJPOOL_HAVE_OBJECTS	(0x400000000)	/* objects allocated along with objpool */
>>>> +
>>>> +/**
>>>> + * objpool_init() - initialize objpool and pre-allocated objects
>>>> + * @head:    the object pool to be initialized, declared by caller
>>>> + * @nr_objs: total objects to be pre-allocated by this object pool
>>>> + * @object_size: size of an object (should be > 0)
>>>> + * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
>>>> + * @context: user context for object initialization callback
>>>> + * @objinit: object initialization callback for extra setup
>>>> + * @release: cleanup callback for extra cleanup task
>>>> + *
>>>> + * return value: 0 for success, otherwise error code
>>>> + *
>>>> + * All pre-allocated objects are to be zeroed after memory allocation.
>>>> + * Caller could do extra initialization in objinit callback. objinit()
>>>> + * will be called just after slot allocation and will be only once for
>>>> + * each object. Since then the objpool won't touch any content of the
>>>> + * objects. It's caller's duty to perform reinitialization after each
>>>> + * pop (object allocation) or do clearance before each push (object
>>>> + * reclamation).
>>>> + */
>>>> +int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
>>>> +		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>>>> +		 objpool_fini_cb release);
>>>> +
>>>> +/**
>>>> + * objpool_pop() - allocate an object from objpool
>>>> + * @head: object pool
>>>> + *
>>>> + * return value: object ptr or NULL if failed
>>>> + */
>>>> +void *objpool_pop(struct objpool_head *head);
>>>> +
>>>> +/**
>>>> + * objpool_push() - reclaim the object and return back to objpool
>>>> + * @obj:  object ptr to be pushed to objpool
>>>> + * @head: object pool
>>>> + *
>>>> + * return: 0 or error code (it fails only when user tries to push
>>>> + * the same object multiple times or wrong "objects" into objpool)
>>>> + */
>>>> +int objpool_push(void *obj, struct objpool_head *head);
>>>> +
>>>> +/**
>>>> + * objpool_drop() - discard the object and deref objpool
>>>> + * @obj:  object ptr to be discarded
>>>> + * @head: object pool
>>>> + *
>>>> + * return: 0 if objpool was released or error code
>>>> + */
>>>> +int objpool_drop(void *obj, struct objpool_head *head);
>>>> +
>>>> +/**
>>>> + * objpool_free() - release objpool forcely (all objects to be freed)
>>>> + * @head: object pool to be released
>>>> + */
>>>> +void objpool_free(struct objpool_head *head);
>>>> +
>>>> +/**
>>>> + * objpool_fini() - deref object pool (also releasing unused objects)
>>>> + * @head: object pool to be dereferenced
>>>> + */
>>>> +void objpool_fini(struct objpool_head *head);
>>>> +
>>>> +#endif /* _LINUX_OBJPOOL_H */
>>>> diff --git a/lib/Makefile b/lib/Makefile
>>>> index 1ffae65bb7ee..7a84c922d9ff 100644
>>>> --- a/lib/Makefile
>>>> +++ b/lib/Makefile
>>>> @@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>>>>    	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>>>>    	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>>>>    	 nmi_backtrace.o win_minmax.o memcat_p.o \
>>>> -	 buildid.o
>>>> +	 buildid.o objpool.o
>>>>    
>>>>    lib-$(CONFIG_PRINTK) += dump_stack.o
>>>>    lib-$(CONFIG_SMP) += cpumask.o
>>>> diff --git a/lib/objpool.c b/lib/objpool.c
>>>> new file mode 100644
>>>> index 000000000000..22e752371820
>>>> --- /dev/null
>>>> +++ b/lib/objpool.c
>>>> @@ -0,0 +1,338 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +#include <linux/objpool.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/vmalloc.h>
>>>> +#include <linux/atomic.h>
>>>> +#include <linux/prefetch.h>
>>>> +#include <linux/irqflags.h>
>>>> +#include <linux/cpumask.h>
>>>> +#include <linux/log2.h>
>>>> +
>>>> +/*
>>>> + * objpool: ring-array based lockless MPMC/FIFO queues
>>>> + *
>>>> + * Copyright: wuqiang.matt@bytedance.com
>>>> + */
>>>> +
>>>> +#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
>>>> +#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
>>>> +			(sizeof(uint32_t) << (s)->bits)))
>>>> +#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
>>>> +			((sizeof(uint32_t) + sizeof(void *)) << (s)->bits)))
>>>> +#define SLOT_CORE(n) cpumask_nth((n) % num_possible_cpus(), cpu_possible_mask)
>>>> +
>>>> +/* compute the suitable num of objects to be managed per slot */
>>>> +static int objpool_nobjs(int size)
>>>> +{
>>>> +	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
>>>> +			(sizeof(uint32_t) + sizeof(void *)));
>>>> +}
>>>> +
>>>> +/* allocate and initialize percpu slots */
>>>
>>> @head: the objpool_head for managing this objpool
>>> @nobjs: the total number of objects in this objpool
>>> @context: context data for @objinit
>>> @objinit: initialize callback for each object.
>>
>> Got it. I didn't since objpool_init_percpu_slots is not public.
>>
>>>> +static int
>>>> +objpool_init_percpu_slots(struct objpool_head *head, int nobjs,
>>>> +			void *context, objpool_init_obj_cb objinit)
>>>> +{
>>>> +	int i, j, n, size, objsz, cpu = 0, nents = head->capacity;
>>>
>>> 'nents' is *round up to the power of 2* of the total number of objects.
>>>
>>>> +
>>>> +	/* aligned object size by sizeof(void *) */
>>>> +	objsz = ALIGN(head->obj_size, sizeof(void *));
>>>> +	/* shall we allocate objects along with percpu-slot */
>>>> +	if (objsz)
>>>> +		head->flags |= OBJPOOL_HAVE_OBJECTS;
>>>
>>> Is there any chance that objsz == 0?
>>
>> No chance. We always require non-zero objsz. Will update in next verion.
>>
>>>
>>>> +
>>>> +	/* vmalloc is used in default to allocate percpu-slots */
>>>> +	if (!(head->gfp & GFP_ATOMIC))
>>>> +		head->flags |= OBJPOOL_FROM_VMALLOC;
>>>> +
>>>> +	for (i = 0; i < head->nr_cpus; i++) {
>>>> +		struct objpool_slot *os;
>>>> +
>>>> +		/* skip the cpus which could never be present */
>>>> +		if (!cpu_possible(i))
>>>> +			continue;
>>>> +
>>>> +		/* compute how many objects to be managed by this slot */
>>>
>>> "to be managed"? or "to be allocated with"?
>>> It seems all objects are possible to be managed by each slot.
>>
>> Right. "to be allocated with" is preferable. Thanks.
>>
>>>> +		n = nobjs / num_possible_cpus();
>>>> +		if (cpu < (nobjs % num_possible_cpus()))
>>>> +			n++;
>>>> +		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
>>>> +		       sizeof(uint32_t) * nents + objsz * n;
>>>> +
>>>> +		/*
>>>> +		 * here we allocate percpu-slot & objects together in a single
>>>> +		 * allocation, taking advantage of warm caches and TLB hits as
>>>> +		 * vmalloc always aligns the request size to pages
>>>
>>> "Since the objpool_entry array in the slot is mostly accessed from the
>>>    i-th CPU, it should be allocated from the memory node for that CPU."
>>>
>>> I think the reason of the memory node allocation is mainly for reducing the
>>> penalty of the cache-miss, since it will be bigger if running on NUMA.
>>
>> Right, NUMA is addressed by objpool_slot. The above description is to explain
>> why a single memory allocation (not multiple). I'll try to make it more clear.
>>
>>>
>>>> +		 */
>>>> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
>>>> +			os = __vmalloc_node(size, sizeof(void *), head->gfp,
>>>> +				cpu_to_node(i), __builtin_return_address(0));
>>>> +		else
>>>> +			os = kmalloc_node(size, head->gfp, cpu_to_node(i));
>>>> +		if (!os)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		/* initialize percpu slot for the i-th slot */
>>>> +		memset(os, 0, size);
>>>> +		os->bits = ilog2(head->capacity);
>>>> +		os->mask = head->capacity - 1;
>>>> +		head->cpu_slots[i] = os;
>>>> +		head->slot_sizes[i] = size;
>>>> +		cpu = cpu + 1;
>>>> +
>>>> +		/*
>>>> +		 * manually set head & tail to avoid possible conflict:
>>>> +		 * We assume that the head item is ready for retrieval
>>>> +		 * iff head is equal to ages[head & mask]. but ages is
>>>> +		 * initialized as 0, so in view of the caller of pop(),
>>>> +		 * the 1st item (0th) is always ready, but the reality
>>>> +		 * could be: push() is stalled before the final update,
>>>> +		 * thus the item being inserted will be lost forever
>>>> +		 */
>>>> +		os->head = os->tail = head->capacity;
>>>> +
>>>> +		if (!objsz)
>>>> +			continue;
>>>
>>> Is it possible? and for what?
>>
>> Will be removed in next version.
>>
>>>
>>>> +
>>>> +		for (j = 0; j < n; j++) {
>>>> +			uint32_t *ages = SLOT_AGES(os);
>>>> +			void **ents = SLOT_ENTS(os);
>>>> +			void *obj = SLOT_OBJS(os) + j * objsz;
>>>> +			uint32_t ie = os->tail & os->mask;
>>>> +
>>>> +			/* perform object initialization */
>>>> +			if (objinit) {
>>>> +				int rc = objinit(obj, context);
>>>> +				if (rc)
>>>> +					return rc;
>>>> +			}
>>>> +
>>>> +			/* add obj into the ring array */
>>>> +			ents[ie] = obj;
>>>> +			ages[ie] = os->tail;
>>>> +			os->tail++;
>>>> +			head->nr_objs++;
>>>> +		}
>>>
>>> To simplify the code, this loop should be another static function.
>>
>> I'll reconsider the implementation. And the multiple computations of ages/ents
>> should be avoided too.
>>
>>>
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/* cleanup all percpu slots of the object pool */
>>>> +static void objpool_fini_percpu_slots(struct objpool_head *head)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (!head->cpu_slots)
>>>> +		return;
>>>> +
>>>> +	for (i = 0; i < head->nr_cpus; i++) {
>>>> +		if (!head->cpu_slots[i])
>>>> +			continue;
>>>> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
>>>> +			vfree(head->cpu_slots[i]);
>>>> +		else
>>>> +			kfree(head->cpu_slots[i]);
>>>> +	}
>>>> +	kfree(head->cpu_slots);
>>>> +	head->cpu_slots = NULL;
>>>> +	head->slot_sizes = NULL;
>>>> +}
>>>> +
>>>> +/* initialize object pool and pre-allocate objects */
>>>> +int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
>>>> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>>>> +		objpool_fini_cb release)
>>>> +{
>>>> +	int nents, rc;
>>>> +
>>>> +	/* check input parameters */
>>>> +	if (nr_objs <= 0 || object_size <= 0)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* calculate percpu slot size (rounded to pow of 2) */
>>>> +	nents = max_t(int, roundup_pow_of_two(nr_objs),
>>>> +			objpool_nobjs(L1_CACHE_BYTES));
>>>> +
>>>> +	/* initialize objpool head */
>>>> +	memset(head, 0, sizeof(struct objpool_head));
>>>> +	head->nr_cpus = nr_cpu_ids;
>>>> +	head->obj_size = object_size;
>>>> +	head->capacity = nents;
>>>> +	head->gfp = gfp & ~__GFP_ZERO;
>>>> +	head->context = context;
>>>> +	head->release = release;
>>>> +
>>>> +	/* allocate array for percpu slots */
>>>> +	head->cpu_slots = kzalloc(head->nr_cpus * sizeof(void *) +
>>>> +			       head->nr_cpus * sizeof(int), head->gfp);
>>>> +	if (!head->cpu_slots)
>>>> +		return -ENOMEM;
>>>> +	head->slot_sizes = (int *)&head->cpu_slots[head->nr_cpus];
>>>> +
>>>> +	/* initialize per-cpu slots */
>>>> +	rc = objpool_init_percpu_slots(head, nr_objs, context, objinit);
>>>> +	if (rc)
>>>> +		objpool_fini_percpu_slots(head);
>>>> +	else
>>>> +		refcount_set(&head->ref, nr_objs + 1);
>>>> +
>>>> +	return rc;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(objpool_init);
>>>> +
>>>> +/* adding object to slot, abort if the slot was already full */
>>>> +static inline int objpool_try_add_slot(void *obj, struct objpool_slot *os)
>>>> +{
>>>> +	uint32_t *ages = SLOT_AGES(os);
>>>> +	void **ents = SLOT_ENTS(os);
>>>> +	uint32_t head, tail;
>>>> +
>>>> +	do {
>>>> +		/* perform memory loading for both head and tail */
>>>> +		head = READ_ONCE(os->head);
>>>> +		tail = READ_ONCE(os->tail);
>>>> +		/* just abort if slot is full */
>>>> +		if (tail - head > os->mask)
>>>> +			return -ENOENT;
>>>
>>> Is this really possible? The total number of objects must be less euqal to
>>> the os->mask. If it means a bug, please use WARN_ON_ONCE() here for debug.
>>
>> Yes, it's a BUG and the caller's fault. When user tries pushing wrong object
>> or repeatedly pushing a same object, it could break the objpool's consistency.
>> It's a 'worse' or 'more worse' choice, rather returning error than breaking
>> the consitency.
>>
>> As you adviced, better crash than problematic. I'll update in next version.
>>
>>>
>>>> +		/* try to extend tail by 1 using CAS to avoid races */
>>>> +		if (try_cmpxchg_acquire(&os->tail, &tail, tail + 1))
>>>> +			break;
>>>> +	} while (1);
>>>
>>> "if(cond) ~ break; } while(1)" should be "} (!cond);"
>>
>> I see. Just to make the codes more "balanced" with comments :)
>>
>>>
>>> And this seems to be buggy since tail++ can be 0, then "tail - head" < 0.
>>>
>>> if (tail < head)
>>> 	if (WARN_ON_ONCE(tail + (UINT32_MAX - head) > os->mask))
>>> 		return -ENOENT;
>>> else
>>> 	if (WARN_ON_ONCE(tail - head > os->mask))
>>> 		return -ENOENT;
>>
>> tail and head are unsigned, so "tail - head" is unsigned and should always
>> be the actual number of free objects in the objpool_slot.
>>
>>>> +
>>>> +	/* the tail-th of slot is reserved for the given obj */
>>>> +	WRITE_ONCE(ents[tail & os->mask], obj);
>>>> +	/* update epoch id to make this object available for pop() */
>>>> +	smp_store_release(&ages[tail & os->mask], tail);
>>>
>>> Note: since the ages array size is the power of 2, this is just a
>>> (32 - os->bits) loop counter. :)
>>>
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/* reclaim an object to object pool */
>>>> +int objpool_push(void *obj, struct objpool_head *oh)
>>>> +{
>>>> +	unsigned long flags;
>>>> +	int cpu, rc;
>>>> +
>>>> +	/* disable local irq to avoid preemption & interruption */
>>>> +	raw_local_irq_save(flags);
>>>> +	cpu = raw_smp_processor_id();
>>>> +	do {
>>>> +		rc = objpool_try_add_slot(obj, oh->cpu_slots[cpu]);
>>>> +		if (!rc)
>>>> +			break;
>>>> +		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
>>>> +	} while (1);
>>>
>>> Hmm, as I said, head->capacity >= nr_all_obj, this must not happen,
>>> we can always push it on this CPU's slot, right?
>>
>> Right. If it happens, that means the user made mistakes. I'll refine
>> the codes.
>>
>>>
>>>> +	raw_local_irq_restore(flags);
>>>> +
>>>> +	return rc;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(objpool_push);
>>>> +
>>>> +/* drop the allocated object, rather reclaim it to objpool */
>>>> +int objpool_drop(void *obj, struct objpool_head *head)
>>>> +{
>>>> +	if (!obj || !head)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (refcount_dec_and_test(&head->ref)) {
>>>> +		objpool_free(head);
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	return -EAGAIN;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(objpool_drop);
>>>> +
>>>> +/* try to retrieve object from slot */
>>>> +static inline void *objpool_try_get_slot(struct objpool_slot *os)
>>>> +{
>>>> +	uint32_t *ages = SLOT_AGES(os);
>>>> +	void **ents = SLOT_ENTS(os);
>>>> +	/* do memory load of head to local head */
>>>> +	uint32_t head = smp_load_acquire(&os->head);
>>>> +
>>>> +	/* loop if slot isn't empty */
>>>> +	while (head != READ_ONCE(os->tail)) {
>>>> +		uint32_t id = head & os->mask, prev = head;
>>>> +
>>>> +		/* do prefetching of object ents */
>>>> +		prefetch(&ents[id]);
>>>> +
>>>> +		/* check whether this item was ready for retrieval */
>>>> +		if (smp_load_acquire(&ages[id]) == head) {
>>>
>>> We may not need this check, since we know head != tail and the
>>> sizeof(ages) >= nr_all_objs.
>>>
>>> Hmm, I guess we can remove ages[] from the code.
>>
>> Just do a quick peek to avoid an unnecessary call of try_cmpxchg_release.
>> try_cmpxchg_release is implemented by heavy instruction with "LOCK" prefix,
>> which could bring cache invalidation among CPU nodes.
> 
> OK, I understand what this ages[] does. This is a nestable commit table
> for the ring array.
> 
>>
>>>
>>>> +			/* node must have been udpated by push() */
>>>> +			void *node = READ_ONCE(ents[id]);
>>>
>>> Please use the same word for the same object.
>>> I mean this is not 'node' but 'object'.
>>
>> Got it.
>>
>>>
>>>> +			/* commit and move forward head of the slot */
>>>> +			if (try_cmpxchg_release(&os->head, &head, head + 1))
>>>> +				return node;
>>>> +			/* head was already updated by others */
>>>> +		}
>>>> +
>>>> +		/* re-load head from memory and continue trying */
>>>> +		head = READ_ONCE(os->head);
>>>> +		/*
>>>> +		 * head stays unchanged, so it's very likely there's an
>>>> +		 * ongoing push() on other cpu nodes but yet not update
>>>> +		 * ages[] to mark it's completion
>>>> +		 */
>>>> +		if (head == prev)
>>>> +			break;
>>>
>>> This is OK. If we always push() on the current CPU slot, and pop() from
>>> any cpus, we can try again here if this slot is not current CPU. But that
>>> maybe to much :P
>>
>> Yes. For most cases, every CPU should only touch it's own objpool_slot.
>>
>>> Thank you,
>>
>> Thanks for your time.
> 
> Thank you for your reply!
> 

