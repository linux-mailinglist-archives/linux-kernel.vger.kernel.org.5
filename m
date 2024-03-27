Return-Path: <linux-kernel+bounces-121868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2988EEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A51C34185
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0814F134;
	Wed, 27 Mar 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fPzpNJei"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3705227
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565915; cv=none; b=mFo5i/24gimkpb81NQqgxECnOO7J3YgDaSan+UzLnSKIFW8gqT/vHBcvqhADbSOpDIP1TpTFo4n+JXnq7ZRTygytTGQPqlgqIB7cYckTmeR6Fq+C+EAiaHOPskyq69AYOCu2qw/DCbdmVN7Y8hQy4XhsvG944/Li0fugbYaHT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565915; c=relaxed/simple;
	bh=Vq/4aAEG0pcCs5YuSBmhUr/VXP4JuBuNGj1cI3MLhI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMrtQSsm+31GYQTpOgJukxKYxx/vCX7Ve166F1keFR+iCkEIsOBPSql7k7cEaSg0VXZq7se6YcjfZ1dR6ep79HP05jf502YUfNnBXU1mc/MFTw0rL0ulhpvzz9GrMAk0prrKRKI/fj0oHqeN6OlH3Dp5KIUYIzsdtRjQAKRtpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fPzpNJei; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789e6f7f748so4479685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711565912; x=1712170712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+6/z6Iu03sZnSDjOG6ZOICRhEOxeVPmVmqIOYHqAQQ=;
        b=fPzpNJeijMaSylBuXJuBbXWsYN1yMQcFmRuu/wEJIGTCcfQoiRRWGM7HczgZrNqa5m
         LrtzprrjjZD4gcMXIs9onl1MXd5DXyQMLjHMpyvX9f2D8MO72Y6h/YzIFDgHsnr7yub9
         cTPGJoaM2vlzpLCZ4nv8owabgztTxU1rO3OLuWyucHHocmcVxhHctLGOWh389sNZA8ir
         najc2AObJ/GH9j8oT75uvw/wzpVqXtQkvMRTtLBw/Qgx3ObaVjGObUwt0vydS1bsLGYT
         a6a72FcO0bcyOa9pRIxSnnM5ujq0w1sMOmC07ExcTWP+FHky3qNNi9HvJikTLDy/J2dE
         MU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565912; x=1712170712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+6/z6Iu03sZnSDjOG6ZOICRhEOxeVPmVmqIOYHqAQQ=;
        b=Hur79myrXRTcky+OMevrAw6EFcJq1vaCnvP24KW7kEW6OegdKWfZ1uHHzI2ku4KoEt
         5gZATsiRviv7dBR4mojS9kNvdpJYVniqAGWlAWjNIcH/O8bMVS8qaN0Pvt/8wB7/CkHh
         9lPofPK4pPBYlLIEI5ote3zF4vylsbFR6QYai4Jlr/bcFqsnlHAVVYUk5KigJmHMgT8F
         ZW+jPtc2E0ZFk8Ws4AIDYb4qSuFtYfhAtI8XPyE61/D5owtL64CkE+OrpftYe5MnOh18
         QbxZQgh88Mk0uWUxt3JOJCy2gAeQF2imdeqTg293aBGwSu91Yj0YAYMe+sKSij5ukGRg
         CNKg==
X-Forwarded-Encrypted: i=1; AJvYcCWXXWcFoDhOceQkVdnBxoh7e/p08eAumcxeHm9x2eLPcfYh4QAl8GZFmSqy9d68DMdXEMu98b1lpCF/GOdI8A0bNtXyfmxsDYQCMy3f
X-Gm-Message-State: AOJu0YyacMLvcgGPiywGGk9ABLpeRFu4bKB7s5/DeqOWoQPlnn36CtvU
	xAedhG3tE4hLb2ZiB1snV0AZLU6vVHIb3pSsHFsrqQpacDB2WJVtSiMmQe8KUbM=
X-Google-Smtp-Source: AGHT+IFMX86LnLj/Jckkj0IDbpKUIbE2+GQj4be5JSr0OrjfUwBsujcYelDxsMjtbJtNCeNV8Jvubg==
X-Received: by 2002:a05:620a:44c4:b0:789:eeb7:2273 with SMTP id y4-20020a05620a44c400b00789eeb72273mr480031qkp.49.1711565912546;
        Wed, 27 Mar 2024 11:58:32 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id cx7-20020a05620a51c700b007884a54ffb1sm4077907qkb.135.2024.03.27.11.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:58:32 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:58:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: page_alloc: consolidate free page accounting fix 2
Message-ID: <20240327185831.GB7597@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>

From d3a0b6847f8bf1ecfa6b08c758dfa5a86cfb18b8 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 27 Mar 2024 12:28:41 -0400
Subject: [PATCH 2/3] mm: page_alloc: consolidate free page accounting fix 2

remove unused page parameter from account_freepages()

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 34c84ef16b66..8987e8869f6d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -643,8 +643,8 @@ compaction_capture(struct capture_control *capc, struct page *page,
 }
 #endif /* CONFIG_COMPACTION */
 
-static inline void account_freepages(struct page *page, struct zone *zone,
-				     int nr_pages, int migratetype)
+static inline void account_freepages(struct zone *zone, int nr_pages,
+				     int migratetype)
 {
 	if (is_migrate_isolate(migratetype))
 		return;
@@ -678,7 +678,7 @@ static inline void add_to_free_list(struct page *page, struct zone *zone,
 				    bool tail)
 {
 	__add_to_free_list(page, zone, order, migratetype, tail);
-	account_freepages(page, zone, 1 << order, migratetype);
+	account_freepages(zone, 1 << order, migratetype);
 }
 
 /*
@@ -698,8 +698,8 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 
 	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
 
-	account_freepages(page, zone, -(1 << order), old_mt);
-	account_freepages(page, zone, 1 << order, new_mt);
+	account_freepages(zone, -(1 << order), old_mt);
+	account_freepages(zone, 1 << order, new_mt);
 }
 
 static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
@@ -723,7 +723,7 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 					   unsigned int order, int migratetype)
 {
 	__del_page_from_free_list(page, zone, order, migratetype);
-	account_freepages(page, zone, -(1 << order), migratetype);
+	account_freepages(zone, -(1 << order), migratetype);
 }
 
 static inline struct page *get_page_from_free_area(struct free_area *area,
@@ -800,7 +800,7 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
-	account_freepages(page, zone, 1 << order, migratetype);
+	account_freepages(zone, 1 << order, migratetype);
 
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
@@ -6930,7 +6930,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	list_del(&page->lru);
 	last = list_empty(&zone->unaccepted_pages);
 
-	account_freepages(page, zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -6982,7 +6982,7 @@ static bool __free_unaccepted(struct page *page)
 	spin_lock_irqsave(&zone->lock, flags);
 	first = list_empty(&zone->unaccepted_pages);
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
-	account_freepages(page, zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-- 
2.44.0


