Return-Path: <linux-kernel+bounces-84523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3A86A7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B091C24055
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848832134B;
	Wed, 28 Feb 2024 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sg8xeHhZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F520DFF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097104; cv=none; b=SXOXpdOzp3Rgus1/NhNUT95x4iJah0YAc9laeVZpgsQjZmORiDXGLuhsagVIXFZUv33Z5CejDMdbiKBzpce8hVhtqNDtteyLfaWb6LD1LNxyfjWtXydAQ3GCxr4IoyMhX3qJiCnMGo4PPRjjX2w0NdSl7L50j2W0WdT5RC9+lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097104; c=relaxed/simple;
	bh=CJHY3E3l0STl1mnEmS9k7x6uJ3VjL+97RnCR4NbqExw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mtkog7rBdLHOZEMQEpH7WX8h/uG1CFmXXn6zUavkCRwP0WQp5JZo9T9dqSW5tPpsTLxSHcBq8O9/zHYyznWpCVialYcfG6xJ8cmYaMP0SdCbUKHRlu5TPT0I3u3HHqmgt6PoKNQLOVZ/9o9dImZNO5eYzo1S9LkfjcmnFjw+xxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sg8xeHhZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608dc99b401so57122577b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709097102; x=1709701902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqML4vY0pGUSQ+ssAelgPTzgnCg/ot5G0/OjWps3luM=;
        b=sg8xeHhZkApqcWnjmVQO3DfekVWLtaf2cMm/zfkMvNy4mIWcEuLpAp7o0dedNZ0uWr
         hLEbhhK79KgBpqtCzufyVsF2mqwJGr1JrWgbb6dEanUiRTlS6J9wkDdrknOSsoDDRmyU
         ijL/j2jj8IrjiIiud7IWFL7l6R+Dp5tLTg7K6p2CFaiMO95l3kKXXG2cir94YDQHez8K
         js5Nv6yoDSj4kWhUuKq4FqBXoW+Bw6iT3ozvCIAae7NcLFZRZ+jsaYipgi0eynK5Uro7
         mdKkAFMYS3g84foDc573bLbIhyPs8m/8YIBXuuCJ4q4XrbmeIWU3QOL5bEhlzewiNFj5
         Fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097102; x=1709701902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqML4vY0pGUSQ+ssAelgPTzgnCg/ot5G0/OjWps3luM=;
        b=MXBxr/LHa+qK35OoPy9xgba8OkZ1rfVsd1eTvuPs7QCZlCVPECqvUug1/pkL5dZyJG
         z/vMRbJ6wnB+GbZE0qdtnssKkxSKadAmHg5do4nTZ2Vvj/pysJBFvDw6W7QfzTzfTux/
         kYg+dMx0eQQ2493Ln9R3krw47NaHLbiH1AaEYyLIL5/GBk+uY/VWyDo07MoMUzzyEEjV
         d9VvQF8ai9XRocSGsSHVciw3t79oKn3Ip734EXFMnvYwSTG9nQV9Pvbw7GUwnlI6NRjM
         UWNj/7EQEU5a0goHc5SwdmxPksRF34sQLSmNeAgtrLm9QYk2SmZ/uESU/NL/UnAbdR9z
         aFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUyfCN3FmU6gg+qTMUrb3JlfZR+2dZjXAwYFLSDcXPwyQPhlKE4WEgWAh2K08oV4SMiWeAioaP3I4T+ZvAP0Q166yBoIRpk3fQ2zzi1
X-Gm-Message-State: AOJu0YxgrWj8KuIhBFvvJmRqvOghDzrX0112V76NP61/oGaJqEDAEUsy
	5IqNwWcchcVIPqLS43wd2EL1jk0H2QRC4Y16wSg3U8WKYzTJ9qHTnScOFd3ntXhxmrdCoCcuL+C
	zgBrvC3oN6DtJ5Ij2
X-Google-Smtp-Source: AGHT+IHyzMYAk41ghRY9BmWyJ7wM13H2JKhk13gZrcP4KgPdiL8ORxRnV4ac5QW5ZsOurSY8RayignJdNKweROeL
X-Received: from richardycc.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:f5f])
 (user=richardycc job=sendgmr) by 2002:a05:690c:88:b0:609:247a:bdc5 with SMTP
 id be8-20020a05690c008800b00609247abdc5mr955171ywb.4.1709097102017; Tue, 27
 Feb 2024 21:11:42 -0800 (PST)
Date: Wed, 28 Feb 2024 05:11:17 +0000
In-Reply-To: <20240226120728.3f495fa7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226120728.3f495fa7@gandalf.local.home>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228051127.2859472-1-richardycc@google.com>
Subject: [PATCH v2] mm: add alloc_contig_migrate_range allocation statistics
From: Richard Chang <richardycc@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, richardycc@google.com
Cc: liumartin@google.com, surenb@google.com, minchan@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

alloc_contig_migrate_range has every information to be able to
understand big contiguous allocation latency. For example, how many
pages are migrated, how many times they were needed to unmap from
page tables.

This patch adds the trace event to collect the allocation statistics.
In the field, it was quite useful to understand CMA allocation
latency.

Signed-off-by: Richard Chang <richardycc@google.com>
---
* from v1 - https://lore.kernel.org/linux-mm/20240226100045.2083962-1-richardycc@google.com/
  * Move the trace event int field to the end of the longs - rostedt
  * Do the calculation only when tracing is enabled - rostedt

 include/trace/events/kmem.h | 38 +++++++++++++++++++++++++++++++++++++
 mm/internal.h               |  3 ++-
 mm/page_alloc.c             | 32 ++++++++++++++++++++++++++-----
 mm/page_isolation.c         |  2 +-
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 58688768ef0f..6e62cc64cd92 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -304,6 +304,44 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(mm_alloc_contig_migrate_range_info,
+
+	TP_PROTO(unsigned long start,
+		 unsigned long end,
+		 unsigned long nr_migrated,
+		 unsigned long nr_reclaimed,
+		 unsigned long nr_mapped,
+		 int migratetype),
+
+	TP_ARGS(start, end, nr_migrated, nr_reclaimed, nr_mapped, migratetype),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned long, nr_migrated)
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_mapped)
+		__field(int, migratetype)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->end = end;
+		__entry->nr_migrated = nr_migrated;
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->nr_mapped = nr_mapped;
+		__entry->migratetype = migratetype;
+	),
+
+	TP_printk("start=0x%lx end=0x%lx migratetype=%d nr_migrated=%lu nr_reclaimed=%lu nr_mapped=%lu",
+		  __entry->start,
+		  __entry->end,
+		  __entry->migratetype,
+		  __entry->nr_migrated,
+		  __entry->nr_reclaimed,
+		  __entry->nr_mapped)
+);
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..e114c647e278 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -537,7 +537,8 @@ isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
 
 int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end);
+					unsigned long start, unsigned long end,
+					int migratetype);
 
 /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
 void init_cma_reserved_pageblock(struct page *page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..da169fa20d8e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6219,9 +6219,14 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
 	}
 }
 
-/* [start, end) must belong to a single zone. */
+/*
+ * [start, end) must belong to a single zone.
+ * @migratetype: using migratetype to filter the type of migration in
+ *		trace_mm_alloc_contig_migrate_range_info.
+ */
 int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end)
+					unsigned long start, unsigned long end,
+					int migratetype)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
@@ -6232,6 +6237,10 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 		.nid = zone_to_nid(cc->zone),
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
+	struct page *page;
+	unsigned long total_mapped = 0;
+	unsigned long total_migrated = 0;
+	unsigned long total_reclaimed = 0;
 
 	lru_cache_disable();
 
@@ -6257,9 +6266,18 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
+		if (trace_mm_alloc_contig_migrate_range_info_enabled()) {
+			total_reclaimed += nr_reclaimed;
+			list_for_each_entry(page, &cc->migratepages, lru)
+				total_mapped += page_mapcount(page);
+		}
+
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
 
+		if (trace_mm_alloc_config_migrate_range_info_enabled() && !ret)
+			total_migrated += cc->nr_migratepages;
+
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
 		 * to retry again over this error, so do the same here.
@@ -6273,9 +6291,13 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
-		return ret;
 	}
-	return 0;
+
+	trace_mm_alloc_contig_migrate_range_info(start, end, migratetype,
+						 total_migrated,
+						 total_reclaimed,
+						 total_mapped);
+	return (ret < 0) ? ret : 0;
 }
 
 /**
@@ -6355,7 +6377,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end);
+	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret = 0;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index cd0ea3668253..a5c8fa4c2a75 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -434,7 +434,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				}
 
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
-							head_pfn + nr_pages);
+							head_pfn + nr_pages, page_mt);
 
 				/*
 				 * restore the page's migratetype so that it can
-- 
2.44.0.rc1.240.g4c46232300-goog


