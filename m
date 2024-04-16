Return-Path: <linux-kernel+bounces-147463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5D8A7488
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9641C224BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DEC137C4E;
	Tue, 16 Apr 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="tIvRH91c"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2A137C42
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295182; cv=none; b=erW/v/y/PVsGZQkbbqtxgnxWeoJMIVlefqvpDYn26kf89OAv/DCPdYdxrTv6FTQRlz8pJUBJuvLu8VSGzLwZJvwmwRJcZAocLwWWHu88FxwMKGj/kKm8EZ6PZXOs2NR3QLoXEpTJ8uXRPXRAeGkRt4CcvYuF0MzxzDF/ciLzpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295182; c=relaxed/simple;
	bh=GxcofnKNVNbbBFF4cyNRNVeMqKEmmntSNw15YNzkPZI=;
	h=Message-Id:In-Reply-To:References:To:Cc:From:Subject:Date; b=nf+WdyOM9ERNnw3f5JXDcIQ3bC80n7efUcNTvU1pryzCo93sn2WTJMapCz509kwLBMDaET92KgAZXcRHEj/ScdREL3p0vEZQ1XFIInrIFDa5cAPGgpHffA0hVNWvL5mXEQq/ueOennKLh+eFRjlaV/3yVbjkbEcKKgbE65Jcz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=tIvRH91c; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GJI4gT002353;
	Tue, 16 Apr 2024 19:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:in-reply-to:references:to:cc:from:subject:date; s=
	DKIM202306; bh=Ktj2knpZkxEzepUnXbFCAHnzLfkAa26Odp8kjW5qVXw=; b=t
	IvRH91cKGfnfqx35lOWohhZ8d7xbjQ803QvX1t1pf3wFaQw5yoIlX9PbNHe0Z56R
	eTT7pWo/NaTzmdpM8+4hPV7EjKn8kYDs3XsP+11id2YuLgBZVrSwhB6FDvunP4iC
	8q9ZUzFmq0OYFZNGlZVPjc5pzmj4rmghPQDRDXl+tzX1VKjMpqqe22Icedg2EplE
	PyieGPN8XCb8iQv6PUYpTJVnMMCacNx5qnjXhB+wQ3fe4Rx9Nwur73z/k1xnuBYU
	6aVcebndAoaDBvneC/9R7WPSx8qiGJYMMwAFNDWNNhwA6oHlkl6TIh+5uhK5oRIR
	qybI2G7ivrYFNn9r989vw==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xhyc7r01x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 19:19:22 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4VJv3t08HKz53xyX;
	Tue, 16 Apr 2024 19:19:22 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VJv3s75L2z2SlV8;
	Tue, 16 Apr 2024 19:19:21 +0000 (UTC)
Message-Id: <20240416122254.868007168-2-mbland@motorola.com>
In-Reply-To: <20240416122254.868007168-1-mbland@motorola.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Maxwell Bland <mbland@motorola.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
From: Maxwell Bland <mbland@motorola.com>
Subject: [PATCH 1/5 RESEND] mm: allow arch refinement/skip for vmap alloc
Date: Tue, 16 Apr 2024 14:18:15 -0500
X-Proofpoint-GUID: H86CUAODmaPSKsWi32l4bYEE5cNkOhPT
X-Proofpoint-ORIG-GUID: H86CUAODmaPSKsWi32l4bYEE5cNkOhPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_17,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160122
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Makes red black tree allocation more flexible on a per-architecture
basis by introducing an optional hooks to refine the red-black tree
structuring and exposing vmalloc functions for clipping vmap areas,
finding vmap areas, and inserting vmap areas.

With this patch, the red-black vmap tree can be refined to account for
architecture-specific memory management operations, most notably address
space layout randomization, as these features conflict with generic
management of a single vmalloc_start to vmalloc_end range as given by
mm/vmalloc.c.

For example, x86 is forced to restrict aslr to 1024 possible locations,
which is a very, very small number, and arm64 breaks standard code/data
partitioning altogether, which prevents the enforcement of performant
immmutability on kernel page tables.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 include/linux/vmalloc.h | 24 ++++++++++++++++++++++++
 mm/vmalloc.c            | 16 ++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 98ea90e90439..3c5ce7ee0bea 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -12,6 +12,7 @@
 
 #include <asm/vmalloc.h>
 
+struct kmem_cache;
 struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
 struct notifier_block;		/* in notifier.h */
 struct iov_iter;		/* in uio.h */
@@ -125,6 +126,21 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
 }
 #endif
 
+#ifndef arch_skip_va
+static inline bool arch_skip_va(struct vmap_area *va, unsigned long vstart)
+{
+	return false;
+}
+#endif
+
+#ifndef arch_refine_vmap_space
+static inline void arch_refine_vmap_space(struct rb_root *root,
+					  struct list_head *head,
+					  struct kmem_cache *cachep)
+{
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
@@ -214,6 +230,14 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
+extern void insert_vmap_area_augment(struct vmap_area *va, struct rb_node *from,
+				     struct rb_root *root,
+				     struct list_head *head);
+extern int va_clip(struct rb_root *root, struct list_head *head,
+		   struct vmap_area *va, unsigned long nva_start_addr,
+		   unsigned long size);
+extern struct vmap_area *__find_vmap_area(unsigned long addr,
+					  struct rb_root *root);
 struct vmap_area *find_vmap_area(unsigned long addr);
 
 static inline bool is_vm_area_hugepages(const void *addr)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68fa001648cc..de4577a3708e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -989,7 +989,7 @@ unsigned long vmalloc_nr_pages(void)
 	return atomic_long_read(&nr_vmalloc_pages);
 }
 
-static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
+struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
 {
 	struct rb_node *n = root->rb_node;
 
@@ -1322,7 +1322,7 @@ insert_vmap_area(struct vmap_area *va,
 		link_va(va, root, parent, link, head);
 }
 
-static void
+void
 insert_vmap_area_augment(struct vmap_area *va,
 	struct rb_node *from, struct rb_root *root,
 	struct list_head *head)
@@ -1501,7 +1501,7 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
 				vstart < va->va_start) {
 			node = node->rb_left;
 		} else {
-			if (is_within_this_va(va, size, align, vstart))
+			if (!arch_skip_va(va, vstart) && is_within_this_va(va, size, align, vstart))
 				return va;
 
 			/*
@@ -1522,7 +1522,8 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
 			 */
 			while ((node = rb_parent(node))) {
 				va = rb_entry(node, struct vmap_area, rb_node);
-				if (is_within_this_va(va, size, align, vstart))
+				if (!arch_skip_va(va, vstart) &&
+				    is_within_this_va(va, size, align, vstart))
 					return va;
 
 				if (get_subtree_max_size(node->rb_right) >= length &&
@@ -1554,7 +1555,7 @@ find_vmap_lowest_linear_match(struct list_head *head, unsigned long size,
 	struct vmap_area *va;
 
 	list_for_each_entry(va, head, list) {
-		if (!is_within_this_va(va, size, align, vstart))
+		if (arch_skip_va(va, vstart) || !is_within_this_va(va, size, align, vstart))
 			continue;
 
 		return va;
@@ -1617,7 +1618,7 @@ classify_va_fit_type(struct vmap_area *va,
 	return type;
 }
 
-static __always_inline int
+__always_inline int
 va_clip(struct rb_root *root, struct list_head *head,
 		struct vmap_area *va, unsigned long nva_start_addr,
 		unsigned long size)
@@ -5129,4 +5130,7 @@ void __init vmalloc_init(void)
 	vmap_node_shrinker->count_objects = vmap_node_shrink_count;
 	vmap_node_shrinker->scan_objects = vmap_node_shrink_scan;
 	shrinker_register(vmap_node_shrinker);
+
+	arch_refine_vmap_space(&free_vmap_area_root, &free_vmap_area_list,
+			       vmap_area_cachep);
 }
-- 
2.39.2


