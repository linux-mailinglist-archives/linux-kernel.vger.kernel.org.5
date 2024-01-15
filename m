Return-Path: <linux-kernel+bounces-25806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3882D613
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357E91C214A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF3125A9;
	Mon, 15 Jan 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLEasWdK"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3153F9FF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddef319fabso3626837a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705311295; x=1705916095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SCgXOqPBaHJ3YE4KKpTYFMJxEYoP9vWqzEHBPuX+vE=;
        b=iLEasWdK3zF1fX2srvA2ql8FkPP0cX5P3HZU30oVzWMJlp1n0mS0Aa+b5vwLBS2mS8
         X9bGFUdPXJ6FU9AF4B/3k5kVXITlpCAePUefHQZmjGM96bVjZ6TLETRnTJRIpbsMvu6z
         5wWC24vkE1vefjcPeMeyx/Se7EDhWj5//JZfSnqPP0/8xRWcFyn76QWHGOh6Ps4A0RoW
         K2rknYgR7w6Ql+Jq/N6QvrwaRrlHQMD5OGZIYVDLBLrwsgzQrK04ipML8kTJmeqdNLbJ
         hIub5+gxyZeSp2hvj1mWpSKJdN8SzPXnOLcjkXulCqz5Cra07XY7b06T1W37c+aKJjTV
         fMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311295; x=1705916095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SCgXOqPBaHJ3YE4KKpTYFMJxEYoP9vWqzEHBPuX+vE=;
        b=wAAvRNgjMPNhO4k9Ghex92Nouc3PH01MHFGZH0Hw4masY+R0rqrKVT/1qMiihM5LkZ
         ZEYBVRHv/FZ57+2DtMFza3qo1TutKWX1kwsOFk5cOzVeMpYwnzFeBe+XhlGfDJqNAmKZ
         L9PyMKuojo9v1KyVr8G3DZxeWv2xKJLjjxaaku509gibIBrJSMMUPyv2FgkjkFe2AZNV
         LAcNqO9eLjN20Lsn3SGnTqH2OrAzD+zZNkKKjE19uTsKpePOwN/QY1T3g9R7cNlK7GV1
         7YTSeWjpp2NC/3PuAPktHDDwMWRsgUO4XHf+XDOtaR3IARkWpkXajwDBYKLJaYK1OpgU
         xLzw==
X-Gm-Message-State: AOJu0YzNNMIrpoaK6Jds6YA+X2Hxlu+fGTPvrBVcFvwzVL+m2Dozux8u
	LnXH8ld79lCMZcDwGY1O9kKU2e6N8t2VEA==
X-Google-Smtp-Source: AGHT+IE0jj2s198opE4MLHJOo8KEJPjRf/vmyPe2fbkHZcvVXqNW8fP6J3CEdVeGdxXXjsygIo57Ug==
X-Received: by 2002:a9d:6298:0:b0:6dd:e6f2:2ba0 with SMTP id x24-20020a9d6298000000b006dde6f22ba0mr4099609otk.49.1705311294692;
        Mon, 15 Jan 2024 01:34:54 -0800 (PST)
Received: from VERNHAO-MC1.tencent.com ([43.132.98.40])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b006db105027basm7200686pfr.50.2024.01.15.01.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jan 2024 01:34:54 -0800 (PST)
From: Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <vernhao@tencent.com>
To: mgorman@techsingularity.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	haoxing990@gmail.com,
	Xin Hao <vernhao@tencent.com>
Subject: [PATCH RFC v1 2/2] mm, pcp: add more detail info about high order page count
Date: Mon, 15 Jan 2024 17:34:36 +0800
Message-ID: <20240115093437.87814-3-vernhao@tencent.com>
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

With this patch, we can see the distribution of pages of different orders on
each cpu, just like below.
	#cat /proc/zoneinfo
    ....
    cpu: 2
              total_count: 14286
                  order0 : 1260
                  order1 : 13
                  order2 : 42
                  order3 : 4
                  order4 : 0
                  order5 : 0
                  order6 : 0
                  order7 : 0
                  order8 : 0
                  order9 : 25
                  order10: 0
                  order11: 0
                  order12: 0
              high:  14541
              batch: 63

Signed-off-by: Xin Hao <vernhao@tencent.com>
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        |  4 ++++
 mm/vmstat.c            | 18 ++++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 883168776fea..55d25b4f51e5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -684,6 +684,7 @@ enum zone_watermarks {
 struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
 	int total_count;	/* total number of pages in the list */
+	int count[NR_PCP_LISTS]; /* per-order page counts */
 	int high;		/* high watermark, emptying needed */
 	int high_min;		/* min high watermark */
 	int high_max;		/* max high watermark */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4e91e429b8d1..7ec2dc5c5ea5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1228,6 +1228,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			list_del(&page->pcp_list);
 			count -= nr_pages;
 			pcp->total_count -= nr_pages;
+			pcp->count[order] -= 1;
 
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
@@ -2478,6 +2479,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->total_count += 1 << order;
+	pcp->count[order] += 1;
 
 	batch = READ_ONCE(pcp->batch);
 	/*
@@ -2858,6 +2860,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					migratetype, alloc_flags);
 
 			pcp->total_count += alloced << order;
+			pcp->count[order] += alloced;
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
@@ -2865,6 +2868,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		page = list_first_entry(list, struct page, pcp_list);
 		list_del(&page->pcp_list);
 		pcp->total_count -= 1 << order;
+		pcp->count[order] -= 1;
 	} while (check_new_pages(page, order));
 
 	return page;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c1e8096ff0a6..e04300ec450f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1735,19 +1735,25 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 
 	seq_printf(m, "\n  pagesets");
 	for_each_online_cpu(i) {
+		int j;
 		struct per_cpu_pages *pcp;
 		struct per_cpu_zonestat __maybe_unused *pzstats;
 
 		pcp = per_cpu_ptr(zone->per_cpu_pageset, i);
 		seq_printf(m,
 			   "\n    cpu: %i"
-			   "\n              count: %i"
-			   "\n              high:  %i"
-			   "\n              batch: %i",
+			   "\n              total_count: %i",
 			   i,
-			   pcp->total_count,
-			   pcp->high,
-			   pcp->batch);
+			   pcp->total_count);
+		for (j = 0; j < NR_PCP_LISTS; j++)
+			seq_printf(m,
+				   "\n                  order%-2i: %-3i",
+				   j, pcp->count[j]);
+		seq_printf(m,
+                          "\n              high:  %i"
+                          "\n              batch: %i",
+                          pcp->high,
+                          pcp->batch);
 #ifdef CONFIG_SMP
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, i);
 		seq_printf(m, "\n  vm stats threshold: %d",
-- 
2.31.1


