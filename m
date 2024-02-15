Return-Path: <linux-kernel+bounces-67687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C6F856F27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35666B2113E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3CD13DB83;
	Thu, 15 Feb 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mQ5zcsdz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6A139564
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031718; cv=none; b=OTcwanxtxl/dx3zwFngwnKiB087YZWIvvmWsamtjyYDhmJD2L748ODwxsNGJS7uX9UGK3i+el0PbGc2yELJ21dFeUipfmMBmFjWwnYGrAeGaRYTcUpgFHHnyatkZCtkVLgGy0h37vOq5JQwYdyNOcsszsGrJn7iQQOv+Lr4yiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031718; c=relaxed/simple;
	bh=jKdoiijhhRMza8p7KwgM+l47NJNE8y8ii7puhTq+T3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BV2ur9k2nnCoCUqcjqs3s6/mZ3jsqFZ4sn3rH5GCgAQs3MZPJmWKFSw0ZpSUHpRlW7nW7rnVu0U23t/bMxDckBrd589qPnX81/ZG1Q8ExkkHO47QVxO0xA9qWocd3979ru23GxoEN8UVvxcuXz7BPrejQ5Nk49V/pFAq1Q3fLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mQ5zcsdz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFStrN006126;
	Thu, 15 Feb 2024 21:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=QwOz67E/OHYRy6Ud5RwkMTPCcemq8UDvvWptjvYQl9I=;
 b=mQ5zcsdzKlohCg/+z3teCpPZbiHZPLsZ/yWSRnNfyg2BsZxc1bD/yBdnM6KrFmbGCdUQ
 xRyWIjW8BrzAhg6ij7wwIyRfFu4Pm268HVzAH6F2xAHrRCrFtWHx/SeIf5fL+6gRC3zw
 huD2xhcr8qSGsBY01xula1KOm93HjFbINlf1rXrgUXS0LJthA0Zrp1wINUSsdaodUwX0
 1zy7L8lK9L3YEyDoTFDjJoUVfaAbOHvgiBkPRzAQ2LXDT0FU6CQQe7jeOtpotxgyY+0p
 4AKl99TroLiFIu67olqW+k/Pt9FkzZae/AescBiyzCHgblXuB/vgV+HU+wEC+R1ipzu8 SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w930139ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:15:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FL9JMI014984;
	Thu, 15 Feb 2024 21:14:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykav2pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:14:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FLExx9014286;
	Thu, 15 Feb 2024 21:14:59 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-156-163.vpn.oracle.com [10.159.156.163])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykav2nh-1;
	Thu, 15 Feb 2024 21:14:59 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianfeng Wang <jianfeng.w.wang@oracle.com>
Subject: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Date: Thu, 15 Feb 2024 13:14:57 -0800
Message-ID: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_20,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150168
X-Proofpoint-GUID: wUxNxrDlcZA1LNy_BFJnVnTGBApNpkWc
X-Proofpoint-ORIG-GUID: wUxNxrDlcZA1LNy_BFJnVnTGBApNpkWc

When reading "/proc/slabinfo", the kernel needs to report the number of
free objects for each kmem_cache. The current implementation relies on
count_partial() that counts the number of free objects by scanning each
kmem_cache_node's partial slab list and summing free objects from all
partial slabs in the list. This process must hold per kmem_cache_node
spinlock and disable IRQ. Consequently, it can block slab allocation
requests on other CPU cores and cause timeouts for network devices etc.,
if the partial slab list is long. In production, even NMI watchdog can
be triggered because some slab caches have a long partial list: e.g.,
for "buffer_head", the number of partial slabs was observed to be ~1M
in one kmem_cache_node. This problem was also observed by several
others [1-2] in the past.

The fix is to maintain a counter of free objects for each kmem_cache.
Then, in get_slabinfo(), use the counter rather than count_partial()
when reporting the number of free objects for a slab cache. per-cpu
counter is used to minimize atomic or lock operation.

Benchmark: run hackbench on a dual-socket 72-CPU bare metal machine
with 256 GB memory and Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.3 GHz.
The command is "hackbench 18 thread 20000". Each group gets 10 runs.

Results:
- Mainline:
21.0381 +- 0.0325 seconds time elapsed  ( +-  0.15% )
- Mainline w/ this patch:
21.1878 +- 0.0239 seconds time elapsed  ( +-  0.11% )

[1] https://lore.kernel.org/linux-mm/
alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
[2] https://lore.kernel.org/lkml/
alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/slab.h |  4 ++++
 mm/slub.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..a0e7672ba648 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -11,6 +11,7 @@
 #include <linux/memcontrol.h>
 #include <linux/kfence.h>
 #include <linux/kasan.h>
+#include <linux/percpu_counter.h>
 
 /*
  * Internal slab definitions
@@ -277,6 +278,9 @@ struct kmem_cache {
 	unsigned int red_left_pad;	/* Left redzone padding size */
 	const char *name;		/* Name (only for display!) */
 	struct list_head list;		/* List of slab caches */
+#ifdef CONFIG_SLUB_DEBUG
+	struct percpu_counter free_objects;
+#endif
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;		/* For sysfs */
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..44f8ded96574 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -736,6 +736,12 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
 
+static inline void
+__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta)
+{
+	percpu_counter_add_batch(&s->free_objects, delta, INT_MAX);
+}
+
 static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
 		       struct slab *slab)
 {
@@ -1829,6 +1835,9 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 	return flags | slub_debug_local;
 }
 #else /* !CONFIG_SLUB_DEBUG */
+static inline void
+__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta) {}
+
 static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
@@ -2369,6 +2378,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	slab->inuse = 0;
 	slab->frozen = 0;
 
+	__update_kmem_cache_free_objs(s, slab->objects);
 	account_slab(slab, oo_order(oo), s, flags);
 
 	slab->slab_cache = s;
@@ -2445,6 +2455,7 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
 		call_rcu(&slab->rcu_head, rcu_free_slab);
 	else
 		__free_slab(s, slab);
+	__update_kmem_cache_free_objs(s, -slab->objects);
 }
 
 static void discard_slab(struct kmem_cache *s, struct slab *slab)
@@ -3859,6 +3870,8 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	 */
 	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
 
+	if (object)
+		__update_kmem_cache_free_objs(s, -1);
 	return object;
 }
 
@@ -4235,6 +4248,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	unsigned long tid;
 	void **freelist;
 
+	__update_kmem_cache_free_objs(s, cnt);
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
@@ -4286,6 +4300,7 @@ static void do_slab_free(struct kmem_cache *s,
 				struct slab *slab, void *head, void *tail,
 				int cnt, unsigned long addr)
 {
+	__update_kmem_cache_free_objs(s, cnt);
 	__slab_free(s, slab, head, tail, cnt, addr);
 }
 #endif /* CONFIG_SLUB_TINY */
@@ -4658,6 +4673,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		memcg_slab_alloc_error_hook(s, size, objcg);
 	}
 
+	__update_kmem_cache_free_objs(s, -i);
 	return i;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
@@ -4899,6 +4915,9 @@ void __kmem_cache_release(struct kmem_cache *s)
 	cache_random_seq_destroy(s);
 #ifndef CONFIG_SLUB_TINY
 	free_percpu(s->cpu_slab);
+#endif
+#ifdef CONFIG_SLUB_DEBUG
+	percpu_counter_destroy(&s->free_objects);
 #endif
 	free_kmem_cache_nodes(s);
 }
@@ -5109,6 +5128,14 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->random = get_random_long();
 #endif
 
+#ifdef CONFIG_SLUB_DEBUG
+	int ret;
+
+	ret = percpu_counter_init(&s->free_objects, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+#endif
+
 	if (!calculate_sizes(s))
 		goto error;
 	if (disable_higher_order_debug) {
@@ -7100,15 +7127,15 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 {
 	unsigned long nr_slabs = 0;
 	unsigned long nr_objs = 0;
-	unsigned long nr_free = 0;
+	unsigned long nr_free;
 	int node;
 	struct kmem_cache_node *n;
 
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
-		nr_free += count_partial(n, count_free);
 	}
+	nr_free = percpu_counter_sum_positive(&s->free_objects);
 
 	sinfo->active_objs = nr_objs - nr_free;
 	sinfo->num_objs = nr_objs;
-- 
2.42.1


