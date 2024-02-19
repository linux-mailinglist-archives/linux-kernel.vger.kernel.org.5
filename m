Return-Path: <linux-kernel+bounces-70923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B018859E13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFFB1C21CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DCA210F3;
	Mon, 19 Feb 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgmNZOLZ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FD2134A;
	Mon, 19 Feb 2024 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330862; cv=none; b=bupwl58xqQeJAYG42ejOJyKQyXfKNwEZTUc068+6UcLCSMi9BcHB9ROrfmwCGQvN/2quiJxRgAHdIILbzkl00BlNN+2J+yV6X2z3MYjXE5wLqYyWyCNncFGTxka2a4PZ5nCFSgSOWrP7/E6t7CEC2q3kgQgEC6EgZIOzt6rgjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330862; c=relaxed/simple;
	bh=KK0U6nGCFbFXpgilN2iSD6ZS/ljysbOqEN5GyyU41kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcVYHm5rd0nMalPTTD0gb9atZIRtxC3juALZ2Xquplz6gvmlBQfF5SF45t2FB0LUoXfqcLGWHRxttHW0NhGYOG3efFwNgxKMlmM1DD06tly87D3eO0C7/zfOsNXk7tD2/oDD9y6WNZBIPd7XrRJIzEZs/CD2N2QDAv457tmLyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgmNZOLZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2305700a12.1;
        Mon, 19 Feb 2024 00:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708330860; x=1708935660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JChNLde82L5m9AVzKziuQHuDxbxpj+2i5hnJOoXu0tI=;
        b=OgmNZOLZjqJ/AoUx4FEK3PTypOjubxWPLT21QSyMtDYwfw8hTeqjsPtTvGZVg2139K
         Nf5Iz7/hRxWZIsn7iAY6HjYR9j5tUVoMJMaENpgkcEJnXplrt5QXk/7UAVd+0H1O33LD
         bvGcrBTsOd1tOWTh9Ok4S15cz8bz8axBEdH47yefVtDjOM5BiuSPAj/dVenWMvikOe6Y
         x8k1RQHiMhRyKBJLldzaEBWxxGOfd5cpjHIPK7VOIHqiCwOtpj21jMMiC7B6D5OIJXa0
         HSEB8AUA2M6Adgya3RqKRF/cBccCsRbPih345/jkW+bQZo6JMyL5luyr7iiN64ypWrJL
         Gdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330860; x=1708935660;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JChNLde82L5m9AVzKziuQHuDxbxpj+2i5hnJOoXu0tI=;
        b=TbrmO2dNebYFUhYNuF6qu4AFCTerq1GkcpJcQmM7JkVNcdhKmpy7ljV7Pw35c6UlUt
         T2Q0wJEp09fADoZnlZQp6N4ZCtZ3S5iLsoy48BdjdCc/rELd2aWvzyqimeCLB5OlkGJT
         6px9qXkUkbFsitgIAPX6Xg53N6W2n2m079j0RQWRnqwxqeALrcUQmmMSEcumwvk/jR65
         19pXv9S+vYDN0QhGYawqalNhrbbjlD2RJJI70H2AJERHi3GcmNYFdWZnqTNVy/vqVCHL
         TOshmPtgQHR6oBsKHzgOxSEhpxyd0eN+huZNx+iR11zxskasb/ZRICshnwi4gF27NeXz
         EjJw==
X-Forwarded-Encrypted: i=1; AJvYcCVHPPVMclbRU0aUkjOY1kMqW+RRYBdg1HCegRB1uRH7iXpCi/zy2qyJxyGAKYUuXqiUPGhEYNPZIl9IpDQshN7MGRGps7m7bWoXpoZLZinDE/HZPZqYpUESA104xKKfCq5tiIpG
X-Gm-Message-State: AOJu0YzGAiZFF7IJLNLf6GTH4ktsB2qaMNlk7qipYhEWBS9eWfBZeM63
	EetjCWu3k0OICc+4hXaTCOWt6xAAqu862MG1bGoTRf+KB8Qg/pvb
X-Google-Smtp-Source: AGHT+IFUzxl7M6z2ToajWeg4ujLZ5c7nVGQiaEFJostNyF9dytQWaQsSchxz4PUlEMzJihWTpC6nRg==
X-Received: by 2002:a05:6a20:49b0:b0:19e:c34a:6fb2 with SMTP id fs48-20020a056a2049b000b0019ec34a6fb2mr7443677pzb.20.1708330860040;
        Mon, 19 Feb 2024 00:21:00 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id cp15-20020a17090afb8f00b0029929839db8sm4674849pjb.14.2024.02.19.00.20.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Feb 2024 00:20:59 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4] mm/swap: fix race when skipping swapcache
Date: Mon, 19 Feb 2024 16:20:40 +0800
Message-ID: <20240219082040.7495-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
swapin the same entry at the same time, they get different pages (A, B).
Before one thread (T0) finishes the swapin and installs page (A)
to the PTE, another thread (T1) could finish swapin of page (B),
swap_free the entry, then swap out the possibly modified page
reusing the same entry. It breaks the pte_same check in (T0) because
PTE value is unchanged, causing ABA problem. Thread (T0) will
install a stalled page (A) into the PTE and cause data corruption.

One possible callstack is like this:

CPU0                                 CPU1
----                                 ----
do_swap_page()                       do_swap_page() with same entry
<direct swapin path>                 <direct swapin path>
<alloc page A>                       <alloc page B>
swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
<slow on later locks or interrupt>   <finished swapin first>
..                                  set_pte_at()
                                     swap_free() <- entry is free
                                     <write to page B, now page A stalled>
                                     <swap out page B to same swap entry>
pte_same() <- Check pass, PTE seems
              unchanged, but page A
              is stalled!
swap_free() <- page B content lost!
set_pte_at() <- staled page A installed!

And besides, for ZRAM, swap_free() allows the swap device to discard
the entry content, so even if page (B) is not modified, if
swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
it may also cause data loss.

To fix this, reuse swapcache_prepare which will pin the swap entry using
the cache flag, and allow only one thread to swap it in, also prevent
any parallel code from putting the entry in the cache. Release the pin
after PT unlocked.

Racers just loop and wait since it's a rare and very short event.
A schedule_timeout_uninterruptible(1) call is added to avoid repeated
page faults wasting too much CPU, causing livelock or adding too much
noise to perf statistics. A similar livelock issue was described in
commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")

Reproducer:

This race issue can be triggered easily using a well constructed
reproducer and patched brd (with a delay in read path) [1]:

With latest 6.8 mainline, race caused data loss can be observed easily:
$ gcc -g -lpthread test-thread-swap-race.c && ./a.out
  Polulating 32MB of memory region...
  Keep swapping out...
  Starting round 0...
  Spawning 65536 workers...
  32746 workers spawned, wait for done...
  Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
  Round 0 Failed, 15 data loss!

This reproducer spawns multiple threads sharing the same memory region
using a small swap device. Every two threads updates mapped pages one by
one in opposite direction trying to create a race, with one dedicated
thread keep swapping out the data out using madvise.

The reproducer created a reproduce rate of about once every 5 minutes,
so the race should be totally possible in production.

After this patch, I ran the reproducer for over a few hundred rounds
and no data loss observed.

Performance overhead is minimal, microbenchmark swapin 10G from 32G
zram:

Before:     10934698 us
After:      11157121 us
Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)

Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: stable@vger.kernel.org

---
V3: https://lore.kernel.org/all/20240216095105.14502-1-ryncsn@gmail.com/
Update from V3:
- Use schedule_timeout_uninterruptible(1) for now instead of schedule() to
  prevent the busy faulting task holds CPU and livelocks [Huang, Ying]

V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
Update from V2:
- Add a schedule() if raced to prevent repeated page faults wasting CPU
  and add noise to perf statistics.
- Use a bool to state the special case instead of reusing existing
  variables fixing error handling [Minchan Kim].

V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
Update from V1:
- Add some words on ZRAM case, it will discard swap content on swap_free
  so the race window is a bit different but cure is the same. [Barry Song]
- Update comments make it cleaner [Huang, Ying]
- Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
- Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO
  instead of "direct swapin path" [Yu Zhao]
- Update commit message.
- Collect Review and Acks.

 include/linux/swap.h |  5 +++++
 mm/memory.c          | 20 ++++++++++++++++++++
 mm/swap.h            |  5 +++++
 mm/swapfile.c        | 13 +++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4db00ddad261..8d28f6091a32 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
 
+static inline int swapcache_prepare(swp_entry_t swp)
+{
+	return 0;
+}
+
 static inline void swap_free(swp_entry_t swp)
 {
 }
diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..a99f5e7be9a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
+	bool need_clear_cache = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
+			/*
+			 * Prevent parallel swapin from proceeding with
+			 * the cache flag. Otherwise, another thread may
+			 * finish swapin first, free the entry, and swapout
+			 * reusing the same entry. It's undetectable as
+			 * pte_same() returns true due to entry reuse.
+			 */
+			if (swapcache_prepare(entry)) {
+				/* Relax a bit to prevent rapid repeated page faults */
+				schedule_timeout_uninterruptible(1);
+				goto out;
+			}
+			need_clear_cache = true;
+
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
@@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
+	/* Clear the swap cache pin for direct swapin after PTL unlock */
+	if (need_clear_cache)
+		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
+	if (need_clear_cache)
+		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/swap.h b/mm/swap.h
index 758c46ca671e..fc2f6ade7f80 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
+static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+}
+
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..746aa9da5302 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+	unsigned char usage;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+	unlock_cluster_or_swap_info(si, ci);
+	if (!usage)
+		free_swap_slot(entry);
+}
+
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
 	return swap_type_to_swap_info(swp_type(entry));
-- 
2.43.0


