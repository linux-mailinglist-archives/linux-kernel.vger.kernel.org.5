Return-Path: <linux-kernel+bounces-147302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6F8A7230
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2400283EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E0132C1F;
	Tue, 16 Apr 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="UXNGIZCS"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B81DFE1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288311; cv=none; b=DIxnThbTdeZa5DMdZgSjG0X0gzLqG7yh0Wy1LeFZ1mR6+4pNIXTxEaLykPq/c15jiXyugETXsmRT6FeoG5c6Rh4IAIP7eO5k0meYyegwg9V4b1BxFcjjusqZvzmr+Ovg6WJ1figvZ6r6PCh+U/68EaJeDbhviN+nHqQvZVH9A3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288311; c=relaxed/simple;
	bh=GxcofnKNVNbbBFF4cyNRNVeMqKEmmntSNw15YNzkPZI=;
	h=Message-Id:In-Reply-To:References:To:Cc:From:Date:Subject; b=ZEohMGxn3lp7LP0zuTZk4sQMN+8lw/WyHxlDffuc9EGDYeCiB70tRxwBJnO2NATYS87QgdYO4R1IZ38zy7mFx85597+6XFhzJRSjunMUG4oMrp2muIT/Abqk+YCuRo23GSP7zpN4sRefgwf3GJfKgAYnPD/PLtP9CUnjwuEz8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=UXNGIZCS; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GFPN5k006602;
	Tue, 16 Apr 2024 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:in-reply-to:references:to:cc:from:date:subject; s=
	DKIM202306; bh=Ktj2knpZkxEzepUnXbFCAHnzLfkAa26Odp8kjW5qVXw=; b=U
	XNGIZCS9YmDgBUeEu5cofHA9mvaV6V1cdLYUPyD490DtaRc+ylTIkjPFzxuWV+4T
	21f6DuwRlCKVXuIbxpUAP7zIVfKAOnpoOVrxFs50JPTCkWAv031LnE5jmeiZi1aA
	R4XwQPSs9ieKI8NnJOZWkmkEZnXk98ir5fZoWx004yfu9JRghgvTKQx8l5r46UH2
	3Gxac+BT+Y/DdxHClOLeMtkCkpMCot4eJMbl5uT1eqEPYTiWpENBGPURZC3kfUqR
	JGoVqQIu/+3pYXSYSfFrBnBWrgCOkuJqt8EReXdQEsqrYza/cDg2Dejomjcze8ru
	uOgM14JDYDWyjwAaePTTg==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3xhfb73r8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 17:24:58 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4VJrWs1z69zfBZq;
	Tue, 16 Apr 2024 17:24:57 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VJrWs0bYbz2VZS4;
	Tue, 16 Apr 2024 17:24:57 +0000 (UTC)
Message-Id: <20240416122254.868007168-2-mbland@motorola.com>
In-Reply-To: <20240416122254.868007168-1-mbland@motorola.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Maxwell Bland <mbland@motorola.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 2 Apr 2024 15:15:01 -0500
Subject: [PATCH 1/5] mm: allow arch refinement/skip for vmap alloc
X-Proofpoint-GUID: m5q-_kUrWpAiWSiKGKl9KqD-wJ45KyMZ
X-Proofpoint-ORIG-GUID: m5q-_kUrWpAiWSiKGKl9KqD-wJ45KyMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160108
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


