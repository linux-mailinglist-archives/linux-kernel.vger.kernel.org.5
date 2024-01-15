Return-Path: <linux-kernel+bounces-25805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100D82D612
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFCB1C2158D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA2101C6;
	Mon, 15 Jan 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA0X5wsc"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5906F51B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd7c5b243dso377919b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705311292; x=1705916092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryA6H5cbLCNpCpmZxc3/gjIEd+58MWOB7i0gvowH1/c=;
        b=hA0X5wsc7DLPlnjojPIDW2hsEjecfpdqAW8MQWIJfQRgRmQGHQgXbC++85ACk6kXss
         WD8hckavtgBzSrrHwpbSbVfocCeK7WbWHKq8krADqoCh/fpsrcb95XxmjrQCiYr74WGp
         xmDcZ4jCbYySXElYPTxOTlKQviuOB1sgXiMmdeW6b0OI4ryH2IxuuevUf1AW4hMHZXFC
         Tv41mjMwRLAKZ064E+8T5ucbPDqJpLTmRTjBzH+sP9Qgn3dCS35JqUTKAk7oQD1q3PfT
         Gvmk1LzIKvInTRj71s30Rups4EkTYxrCaMfO2eWWaOaWvlkhgYLstq68v4FPqIm24iPH
         Vc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311292; x=1705916092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryA6H5cbLCNpCpmZxc3/gjIEd+58MWOB7i0gvowH1/c=;
        b=EQ+9EMx35V4vAGOQD0MjcmK3BwMz45CNiLM3DZiJ1IW5wnlPKnVx6+9IKNBMr3jeFr
         QU1ltj/xBH9KP8arS4021Gt6aCPAz0VhsOe5hM8+Uuwa6rR/wtuAVT5zH+V8dXWHpeya
         1B7mgwleQEVminTrn6JpL5fpJIxLUHpEob67IUA8Gk3LW/2hY1J/D4hVW3XyKiAFwsFL
         ZpA3/4ips6qkt4Ky7qbCSDAfRqx8I/x74pXxmlTVfnM40G/njWkp4KLSkfB+RMWiZqbD
         MKiEDUQRMDVW00Xv39POyLPTc47W+TtSeTdGLcqD5sH2CE2mT29uJ20CZoCvAuiWh81y
         hQmQ==
X-Gm-Message-State: AOJu0YzQGVlSeP2GoGIUJw338eZcumOCEZKCJskhrPqjqegwxjfzyhrw
	ScdqWa8jqOuPa3jFuMOLvk4=
X-Google-Smtp-Source: AGHT+IHE8SbOePg1AFjMpNHMlBnLKCKJyk7x7gN/qIfox+OvYCUNtOiGJVOlRc5pkEr+TSi68Md5Tg==
X-Received: by 2002:a05:6358:fd19:b0:174:c540:dfd1 with SMTP id ui25-20020a056358fd1900b00174c540dfd1mr3258390rwb.56.1705311292566;
        Mon, 15 Jan 2024 01:34:52 -0800 (PST)
Received: from VERNHAO-MC1.tencent.com ([43.132.98.40])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b006db105027basm7200686pfr.50.2024.01.15.01.34.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jan 2024 01:34:52 -0800 (PST)
From: Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <vernhao@tencent.com>
To: mgorman@techsingularity.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	haoxing990@gmail.com,
	Xin Hao <vernhao@tencent.com>
Subject: [PATCH RFC v1 1/2] mm, pcp: rename pcp->count to pcp->total_count
Date: Mon, 15 Jan 2024 17:34:35 +0800
Message-ID: <20240115093437.87814-2-vernhao@tencent.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240115093437.87814-1-vernhao@tencent.com>
References: <20240115093437.87814-1-vernhao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Hao <vernhao@tencent.com>

Just a rename for avoiding name conflicts in the next patch

Signed-off-by: Xin Hao <vernhao@tencent.com>
---
 include/linux/mmzone.h |  2 +-
 mm/page_alloc.c        | 42 +++++++++++++++++++++---------------------
 mm/show_mem.c          |  6 +++---
 mm/vmstat.c            |  6 +++---
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4ed33b127821..883168776fea 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -683,7 +683,7 @@ enum zone_watermarks {
 
 struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
-	int count;		/* number of pages in the list */
+	int total_count;	/* total number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int high_min;		/* min high watermark */
 	int high_max;		/* max high watermark */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5be4cd8f6b5a..4e91e429b8d1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1197,7 +1197,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * Ensure proper count is passed which otherwise would stuck in the
 	 * below while (list_empty(list)) loop.
 	 */
-	count = min(pcp->count, count);
+	count = min(pcp->total_count, count);
 
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
@@ -1227,7 +1227,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
 			count -= nr_pages;
-			pcp->count -= nr_pages;
+			pcp->total_count -= nr_pages;
 
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
@@ -2209,13 +2209,13 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	 * control latency.  This caps pcp->high decrement too.
 	 */
 	if (pcp->high > high_min) {
-		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+		pcp->high = max3(pcp->total_count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
 				 pcp->high - (pcp->high >> 3), high_min);
 		if (pcp->high > high_min)
 			todo++;
 	}
 
-	to_drain = pcp->count - pcp->high;
+	to_drain = pcp->total_count - pcp->high;
 	if (to_drain > 0) {
 		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
@@ -2237,7 +2237,7 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	int to_drain, batch;
 
 	batch = READ_ONCE(pcp->batch);
-	to_drain = min(pcp->count, batch);
+	to_drain = min(pcp->total_count, batch);
 	if (to_drain > 0) {
 		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
@@ -2254,9 +2254,9 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	struct per_cpu_pages *pcp;
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count) {
+	if (pcp->total_count) {
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, pcp->count, pcp, 0);
+		free_pcppages_bulk(zone, pcp->total_count, pcp, 0);
 		spin_unlock(&pcp->lock);
 	}
 }
@@ -2292,7 +2292,7 @@ void drain_local_pages(struct zone *zone)
  *
  * drain_all_pages() is optimized to only execute on cpus where pcplists are
  * not empty. The check for non-emptiness can however race with a free to
- * pcplist that has not yet increased the pcp->count from 0 to 1. Callers
+ * pcplist that has not yet increased the pcp->total_count from 0 to 1. Callers
  * that need the guarantee that every CPU has drained can disable the
  * optimizing racy check.
  */
@@ -2336,12 +2336,12 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			has_pcps = true;
 		} else if (zone) {
 			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-			if (pcp->count)
+			if (pcp->total_count)
 				has_pcps = true;
 		} else {
 			for_each_populated_zone(z) {
 				pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
-				if (pcp->count) {
+				if (pcp->total_count) {
 					has_pcps = true;
 					break;
 				}
@@ -2393,7 +2393,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free
 
 	/* Free as much as possible if batch freeing high-order pages. */
 	if (unlikely(free_high))
-		return min(pcp->count, batch << CONFIG_PCP_BATCH_SCALE_MAX);
+		return min(pcp->total_count, batch << CONFIG_PCP_BATCH_SCALE_MAX);
 
 	/* Check for PCP disabled or boot pageset */
 	if (unlikely(high < batch))
@@ -2448,8 +2448,8 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		int free_count = max_t(int, pcp->free_count, batch);
 
 		pcp->high = max(high - free_count, high_min);
-		high = max(pcp->count, high_min);
-	} else if (pcp->count >= high) {
+		high = max(pcp->total_count, high_min);
+	} else if (pcp->total_count >= high) {
 		int need_high = pcp->free_count + batch;
 
 		/* pcp->high should be large enough to hold batch freed pages */
@@ -2477,7 +2477,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
-	pcp->count += 1 << order;
+	pcp->total_count += 1 << order;
 
 	batch = READ_ONCE(pcp->batch);
 	/*
@@ -2490,7 +2490,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 		free_high = (pcp->free_count >= batch &&
 			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
 			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
-			      pcp->count >= READ_ONCE(batch)));
+			      pcp->total_count >= READ_ONCE(batch)));
 		pcp->flags |= PCPF_PREV_FREE_HIGH_ORDER;
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
@@ -2498,7 +2498,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
 		pcp->free_count += (1 << order);
 	high = nr_pcp_high(pcp, zone, batch, free_high);
-	if (pcp->count >= high) {
+	if (pcp->total_count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
 				   pcp, pindex);
 		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
@@ -2815,7 +2815,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 		high = pcp->high = min(high + batch, high_max);
 
 	if (!order) {
-		max_nr_alloc = max(high - pcp->count - base_batch, base_batch);
+		max_nr_alloc = max(high - pcp->total_count - base_batch, base_batch);
 		/*
 		 * Double the number of pages allocated each time there is
 		 * subsequent allocation of order-0 pages without any freeing.
@@ -2857,14 +2857,14 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					batch, list,
 					migratetype, alloc_flags);
 
-			pcp->count += alloced << order;
+			pcp->total_count += alloced << order;
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
 		list_del(&page->pcp_list);
-		pcp->count -= 1 << order;
+		pcp->total_count -= 1 << order;
 	} while (check_new_pages(page, order));
 
 	return page;
@@ -5482,7 +5482,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online,
 
 /*
  * pcp->high and pcp->batch values are related and generally batch is lower
- * than high. They are also related to pcp->count such that count is lower
+ * than high. They are also related to pcp->total_count such that count is lower
  * than high, and as soon as it reaches high, the pcplist is flushed.
  *
  * However, guaranteeing these relations at all times would require e.g. write
@@ -5490,7 +5490,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online,
  * thus be prone to error and bad for performance. Thus the update only prevents
  * store tearing. Any new users of pcp->batch, pcp->high_min and pcp->high_max
  * should ensure they can cope with those fields changing asynchronously, and
- * fully trust only the pcp->count field on the local CPU with interrupts
+ * fully trust only the pcp->total_count field on the local CPU with interrupts
  * disabled.
  *
  * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..6fcb2c771613 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -197,7 +197,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			continue;
 
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->total_count;
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
@@ -299,7 +299,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 
 		free_pcp = 0;
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->total_count;
 
 		show_node(zone);
 		printk(KERN_CONT
@@ -342,7 +342,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
-			K(this_cpu_read(zone->per_cpu_pageset->count)),
+			K(this_cpu_read(zone->per_cpu_pageset->total_count)),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..c1e8096ff0a6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -846,7 +846,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			 * if not then there is nothing to expire.
 			 */
 			if (!__this_cpu_read(pcp->expire) ||
-			       !__this_cpu_read(pcp->count))
+			       !__this_cpu_read(pcp->total_count))
 				continue;
 
 			/*
@@ -862,7 +862,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 				continue;
 			}
 
-			if (__this_cpu_read(pcp->count)) {
+			if (__this_cpu_read(pcp->total_count)) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
@@ -1745,7 +1745,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   "\n              high:  %i"
 			   "\n              batch: %i",
 			   i,
-			   pcp->count,
+			   pcp->total_count,
 			   pcp->high,
 			   pcp->batch);
 #ifdef CONFIG_SMP
-- 
2.31.1


