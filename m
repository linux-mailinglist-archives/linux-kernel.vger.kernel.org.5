Return-Path: <linux-kernel+bounces-120614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71988DA45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EC51C265F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AEB33995;
	Wed, 27 Mar 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UU2scdN6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Txe5EZeh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4sX2sre";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FagpEbYi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E93C13D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531836; cv=none; b=QjZoCxXgmmDOU5Yv/A6/MmskpAcJ6gNWhLbvhz35WVMl5Xj8KAUMVfHSAHVTlT2I4hhQwdJKyLtptpUCz6CRVDkcZQR94aDrXXhQlLf3ewTGpAnaNK8LD2lVNjiY9SUvRJb8xj0Y2mJGKfOamaahk9Otomv/tpoRWiYFOutqEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531836; c=relaxed/simple;
	bh=Zd27xQAX4E7RL3WN4Zk7I+TkQqkrtXP/EQAsdBEGTLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU0b/JAz8EiDcT0a9l17LG2NDCAlBXqGPnYQVLiVBKXtGxWVDAuIrKzeRItM1F0wbo95/C78sYhC0QWyn7t1kej7Q1huQqSSOFJF33MmWbKqO743we+x2p4kUOuM/nVDoB+CISWGgbZyZrvt2cQv7m1psDLgD4JDhC4pLAAjcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UU2scdN6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Txe5EZeh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4sX2sre; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FagpEbYi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F2CC60190;
	Wed, 27 Mar 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711531832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVtsAoUH5IH+I7nzQ90FtRSD5xnb1Cluk9Zp6s7yUWo=;
	b=UU2scdN6Oun/dlVmEZsumb48WftOvPMZyqkgegdn7rFoYZ4JuQuRvzpl2vqlqKsUAIcMVH
	jBK6WLjHtn4yIg/WO8s5i8/60jF7AG9QjE0RJXVyOrZOcimfOO8cd45emzfm+zRBoM4KcN
	a+iyTFqkW6uHMjeyXtlE1/X6XXszWbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711531832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVtsAoUH5IH+I7nzQ90FtRSD5xnb1Cluk9Zp6s7yUWo=;
	b=Txe5EZehw/jccoHVxJFWGUZoWoQRHSI5inevyDFqR6c3AbVFxBkK3yP/cJxKqsbYXHRqcd
	Yx1hLHoK8l3U1CCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711531830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVtsAoUH5IH+I7nzQ90FtRSD5xnb1Cluk9Zp6s7yUWo=;
	b=n4sX2sredVIOadRqUJ1Jt4CUbA8/AcnWT0qVmrb5wEa+/mW/thnzhLt9zwZ+bZhAo1R9Ad
	s5m9xAgm+0sLVvBfyUw6oviG8cbCd5g94iug4yEhx+wEabuVp4GmG2vVDYdWqfoDXrqBWR
	FgVnNqQkPWDdk+hEELS40VTaTQqLvrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711531830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVtsAoUH5IH+I7nzQ90FtRSD5xnb1Cluk9Zp6s7yUWo=;
	b=FagpEbYi6DMhvU7Rip8/13QgoK/7e6ub3lzPuuCEOh65Bw1GbecPezbOp8W5cGLBkwAFM1
	u/MXmKZJHaRfpcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B7DC13688;
	Wed, 27 Mar 2024 09:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FGLNGTbnA2YEGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 27 Mar 2024 09:30:30 +0000
Message-ID: <81b1d642-2ec0-49f5-89fc-19a3828419ff@suse.cz>
Date: Wed, 27 Mar 2024 10:30:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n4sX2sre;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FagpEbYi
X-Rspamd-Queue-Id: 7F2CC60190

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> V4:
> - fixed !pcp_order_allowed() case in free_unref_folios()
> - reworded the patch 0 changelog a bit for the git log
> - rebased to mm-everything-2024-03-19-23-01
> - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
> 
> ---
> 
> The page allocator's mobility grouping is intended to keep unmovable
> pages separate from reclaimable/compactable ones to allow on-demand
> defragmentation for higher-order allocations and huge pages.
> 
> Currently, there are several places where accidental type mixing
> occurs: an allocation asks for a page of a certain migratetype and
> receives another. This ruins pageblocks for compaction, which in turn
> makes allocating huge pages more expensive and less reliable.
> 
> The series addresses those causes. The last patch adds type checks on
> all freelist movements to prevent new violations being introduced.
> 
> The benefits can be seen in a mixed workload that stresses the machine
> with a memcache-type workload and a kernel build job while
> periodically attempting to allocate batches of THP. The following data
> is aggregated over 50 consecutive defconfig builds:

Great stuff. What would you say to the following on top?

----8<----
From 84f8a6d3a9e34c7ed8b438c3152d56e359a4ffb4 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 27 Mar 2024 10:19:47 +0100
Subject: [PATCH] mm: page_alloc: change move_freepages() to
 __move_freepages_block()

The function is now supposed to be called only on a single pageblock and
checks start_pfn and end_pfn accordingly. Rename it to make this more
obvious and drop the end_pfn parameter which can be determined trivially
and none of the callers use it for anything else.

Also make the (now internal) end_pfn exclusive, which is more common.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 34c84ef16b66..75aefbd52ef9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1566,18 +1566,18 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
  * Change the type of a block and move all its free pages to that
  * type's freelist.
  */
-static int move_freepages(struct zone *zone, unsigned long start_pfn,
-			  unsigned long end_pfn, int old_mt, int new_mt)
+static int __move_freepages_block(struct zone *zone, unsigned long start_pfn,
+				  int old_mt, int new_mt)
 {
 	struct page *page;
-	unsigned long pfn;
+	unsigned long pfn, end_pfn;
 	unsigned int order;
 	int pages_moved = 0;
 
 	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
-	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 != end_pfn);
+	end_pfn = pageblock_end_pfn(start_pfn);
 
-	for (pfn = start_pfn; pfn <= end_pfn;) {
+	for (pfn = start_pfn; pfn < end_pfn;) {
 		page = pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			pfn++;
@@ -1603,14 +1603,13 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
 
 static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 				      unsigned long *start_pfn,
-				      unsigned long *end_pfn,
 				      int *num_free, int *num_movable)
 {
 	unsigned long pfn, start, end;
 
 	pfn = page_to_pfn(page);
 	start = pageblock_start_pfn(pfn);
-	end = pageblock_end_pfn(pfn) - 1;
+	end = pageblock_end_pfn(pfn);
 
 	/*
 	 * The caller only has the lock for @zone, don't touch ranges
@@ -1621,16 +1620,15 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 	 */
 	if (!zone_spans_pfn(zone, start))
 		return false;
-	if (!zone_spans_pfn(zone, end))
+	if (!zone_spans_pfn(zone, end - 1))
 		return false;
 
 	*start_pfn = start;
-	*end_pfn = end;
 
 	if (num_free) {
 		*num_free = 0;
 		*num_movable = 0;
-		for (pfn = start; pfn <= end;) {
+		for (pfn = start; pfn < end;) {
 			page = pfn_to_page(pfn);
 			if (PageBuddy(page)) {
 				int nr = 1 << buddy_order(page);
@@ -1656,13 +1654,12 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 static int move_freepages_block(struct zone *zone, struct page *page,
 				int old_mt, int new_mt)
 {
-	unsigned long start_pfn, end_pfn;
+	unsigned long start_pfn;
 
-	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
-				       NULL, NULL))
+	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
 		return -1;
 
-	return move_freepages(zone, start_pfn, end_pfn, old_mt, new_mt);
+	return __move_freepages_block(zone, start_pfn, old_mt, new_mt);
 }
 
 #ifdef CONFIG_MEMORY_ISOLATION
@@ -1733,10 +1730,9 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 				  int migratetype)
 {
-	unsigned long start_pfn, end_pfn, pfn;
+	unsigned long start_pfn, pfn;
 
-	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
-				       NULL, NULL))
+	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
 		return false;
 
 	/* No splits needed if buddies can't span multiple blocks */
@@ -1767,8 +1763,9 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		return true;
 	}
 move:
-	move_freepages(zone, start_pfn, end_pfn,
-		       get_pfnblock_migratetype(page, start_pfn), migratetype);
+	__move_freepages_block(zone, start_pfn,
+			       get_pfnblock_migratetype(page, start_pfn),
+			       migratetype);
 	return true;
 }
 #endif /* CONFIG_MEMORY_ISOLATION */
@@ -1868,7 +1865,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 			unsigned int alloc_flags, bool whole_block)
 {
 	int free_pages, movable_pages, alike_pages;
-	unsigned long start_pfn, end_pfn;
+	unsigned long start_pfn;
 	int block_type;
 
 	block_type = get_pageblock_migratetype(page);
@@ -1901,8 +1898,8 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		goto single_page;
 
 	/* moving whole block can fail due to zone boundary conditions */
-	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
-				       &free_pages, &movable_pages))
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &free_pages,
+				       &movable_pages))
 		goto single_page;
 
 	/*
@@ -1932,7 +1929,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 */
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
-		move_freepages(zone, start_pfn, end_pfn, block_type, start_type);
+		__move_freepages_block(zone, start_pfn, block_type, start_type);
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
-- 
2.44.0




