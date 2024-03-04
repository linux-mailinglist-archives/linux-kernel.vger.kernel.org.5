Return-Path: <linux-kernel+bounces-90179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A386FB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB931F22B64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0917552;
	Mon,  4 Mar 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keCarv5z"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1F17BAC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540094; cv=none; b=s/1hhjbadgRKxkYyAtx9gTQHcakpE7WdmaTQUoVbRfsb0SziHHrMcosKYVD23CdWVnymnmLP8OpwZF1Immk9tC22YoVJo9AfdTyMOXOQXc/1oRWYZASkc3PzDKoNbCGmm7AfrpKJyaxM8UzjTjUcrjX2endOTSrgw10wjATxlhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540094; c=relaxed/simple;
	bh=9NiAmaNMcQqQy5qDH5R7xvBLevxdcjq0TuHgInEcdWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQjAc3mwY1WUoi4F64x6yNXjhB8eVvglSLLgDnwM+z+K0sBlHskJacsI/4ycUJRNubQJqbAhpUTAtU4wndX3VAZ/1fL3cJoy+1diV/U0SivemxkYKyVu4mUHbFpM8NH6eOVmNQoG+0GetTWTVF8TMmxp1zOH3MxBZ09lNT2S6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keCarv5z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e4560664b5so3374452b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540092; x=1710144892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEHcUaBOURO/yC0z8mfKLfYRHHxSSbfVWo8QOD6O6SM=;
        b=keCarv5zcLnNsdKKqHVC8mIPIVGxGPvxnkCXOXfnozFXtGWOpwdc4lzlto5K58x6Kx
         WhYfZrlepmdtytTTX2JJdEf4ZsCaIQoVEZXkmIw6Ii/b4es0AiUbc27jXdLb6vDCOcOp
         QGLK0VtcXOg14hGujft5QgPSh1nqzxAyXMxvfDKZ3W9tSZrz6KVCD8LOnQsnAuLIAVU8
         N0Uc4gKhy3/WVWcxfEHNKYD+aXWDFUuCPcHRrds9H6sSqfTqXN1QXTevT1x0cnrOuh/C
         X2MCiRbLgb86duy5kD8vOoxufaDWepOpwcuqrEbY4AvzX8CikSIdxuNdekISqi1P49KZ
         2O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540092; x=1710144892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEHcUaBOURO/yC0z8mfKLfYRHHxSSbfVWo8QOD6O6SM=;
        b=dY0zX8irtsi8M9DN8vePNPIpv/VwEs1LqiVY8KgSZ57CIKUvru0A+0RAC+7klLuOQs
         N+bAt6pnRK8U3jUgBCwhhUcyCt+cdlpGaKq2s4YJhd+i61tnGwnK73Z3QXcDqxCwc2ES
         IrKT2w/OHuEsa0yS3B1CcOjLeCHSFphXsS5IwibLhBzZc5oQRsMO5CtXPDHALcHP3Cxp
         g7OxgsYWhonw8DRnFmfcw7wdEXb+EbY2xbcrZQ95zCSQWV9p1QMFdRErROXArADFFyBN
         na9T5HS9u2XuscoS2Dg06upQjZo8hhZ8r/C+0aBNldgRd1V+9G0TDrN58jlOBgelwhg6
         3L7g==
X-Forwarded-Encrypted: i=1; AJvYcCWrPyPq9kEm4rw6Nw3YCcA8cmDWgZZV0hkyHdol2gDdvBSkzAa/JtuRBAaWDk+prD9NsnDq+Pocdu1ggIQlUZ49OHtNWSdhOd7r9RVY
X-Gm-Message-State: AOJu0YwOZzpreSwp0s70I9X/uI2wD4KKQuDyYwUczyEK0W2HMhxkhRqv
	U3iH9lzFHoVcnBkKs07U1Jrkqr3lrAG/qoJPvt+AIdtR1mZ5qjVT
X-Google-Smtp-Source: AGHT+IGE7Q24s92a3q9O7BOh15+H0RGSvY6KsWDz94mjR2aHEmrzB8E5OFPS9feP8EbqMCx8xVkVsg==
X-Received: by 2002:a05:6a00:2d99:b0:6e6:2499:d189 with SMTP id fb25-20020a056a002d9900b006e62499d189mr2330890pfb.2.1709540091964;
        Mon, 04 Mar 2024 00:14:51 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e558a67374sm6686387pfb.0.2024.03.04.00.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:14:51 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Minchan Kim <minchan@kernel.org>,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH v3 4/5] mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for large folios swap-in
Date: Mon,  4 Mar 2024 21:13:47 +1300
Message-Id: <20240304081348.197341-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304081348.197341-1-21cnbao@gmail.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") supports
one entry only, to support large folio swap-in, we need to handle multiple
swap entries.

Cc: Kairui Song <kasong@tencent.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |   1 +
 mm/swap.h            |   1 +
 mm/swapfile.c        | 118 ++++++++++++++++++++++++++-----------------
 3 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d6ab27929458..22105f0fe2d4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
+extern int swapcache_prepare_nr(swp_entry_t entry, int nr);
 extern void swap_free(swp_entry_t);
 extern void swap_nr_free(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
diff --git a/mm/swap.h b/mm/swap.h
index fc2f6ade7f80..1cec991efcda 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 244106998a69..bae1b8165b11 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3309,7 +3309,7 @@ void si_swapinfo(struct sysinfo *val)
 }
 
 /*
- * Verify that a swap entry is valid and increment its swap map count.
+ * Verify that nr swap entries are valid and increment their swap map count.
  *
  * Returns error code in following case.
  * - success -> 0
@@ -3319,66 +3319,76 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned char usage)
 {
 	struct swap_info_struct *p;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
-	unsigned char count;
-	unsigned char has_cache;
-	int err;
+	unsigned char count[SWAPFILE_CLUSTER];
+	unsigned char has_cache[SWAPFILE_CLUSTER];
+	int err, i;
 
 	p = swp_swap_info(entry);
 
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
 
-	count = p->swap_map[offset];
-
-	/*
-	 * swapin_readahead() doesn't check if a swap entry is valid, so the
-	 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
-	 */
-	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
-		err = -ENOENT;
-		goto unlock_out;
-	}
-
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-	err = 0;
-
-	if (usage == SWAP_HAS_CACHE) {
+	for (i = 0; i < nr; i++) {
+		count[i] = p->swap_map[offset + i];
 
-		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
-		if (!has_cache && count)
-			has_cache = SWAP_HAS_CACHE;
-		else if (has_cache)		/* someone else added cache */
-			err = -EEXIST;
-		else				/* no users remaining */
+		/*
+		 * swapin_readahead() doesn't check if a swap entry is valid, so the
+		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
+		 */
+		if (unlikely(swap_count(count[i]) == SWAP_MAP_BAD)) {
 			err = -ENOENT;
+			goto unlock_out;
+		}
 
-	} else if (count || has_cache) {
-
-		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-			count += usage;
-		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-			err = -EINVAL;
-		else if (swap_count_continued(p, offset, count))
-			count = COUNT_CONTINUED;
-		else
-			err = -ENOMEM;
-	} else
-		err = -ENOENT;			/* unused swap entry */
+		has_cache[i] = count[i] & SWAP_HAS_CACHE;
+		count[i] &= ~SWAP_HAS_CACHE;
+		err = 0;
+
+		if (usage == SWAP_HAS_CACHE) {
+
+			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
+			if (!has_cache[i] && count[i])
+				has_cache[i] = SWAP_HAS_CACHE;
+			else if (has_cache[i])		/* someone else added cache */
+				err = -EEXIST;
+			else				/* no users remaining */
+				err = -ENOENT;
+		} else if (count[i] || has_cache[i]) {
+
+			if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+				count[i] += usage;
+			else if ((count[i] & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
+				err = -EINVAL;
+			else if (swap_count_continued(p, offset + i, count[i]))
+				count[i] = COUNT_CONTINUED;
+			else
+				err = -ENOMEM;
+		} else
+			err = -ENOENT;			/* unused swap entry */
 
-	if (!err)
-		WRITE_ONCE(p->swap_map[offset], count | has_cache);
+		if (err)
+			break;
+	}
 
+	if (!err) {
+		for (i = 0; i < nr; i++)
+			WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]);
+	}
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
 	return err;
 }
 
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+{
+	return __swap_duplicate_nr(entry, 1, usage);
+}
+
 /*
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
@@ -3417,17 +3427,33 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+int swapcache_prepare_nr(swp_entry_t entry, int nr)
+{
+	return __swap_duplicate_nr(entry, nr, SWAP_HAS_CACHE);
+}
+
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
 	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
-	unsigned char usage;
+	unsigned char usage[SWAPFILE_CLUSTER];
+	int i;
 
 	ci = lock_cluster_or_swap_info(si, offset);
-	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+	for (i = 0; i < nr; i++)
+		usage[i] = __swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE);
 	unlock_cluster_or_swap_info(si, ci);
-	if (!usage)
-		free_swap_slot(entry);
+	for (i = 0; i < nr; i++) {
+		if (!usage[i]) {
+			free_swap_slot(entry);
+			entry.val++;
+		}
+	}
+}
+
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	swapcache_clear_nr(si, entry, 1);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.34.1


