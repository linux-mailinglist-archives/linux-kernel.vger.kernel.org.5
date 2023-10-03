Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664497B6574
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjJCJ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjJCJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:27:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F94A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:27:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59bebd5bdadso8858057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696325270; x=1696930070; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mU56FlmjTv5eFSUjfveUTDJtj2QxEcbZGZN96w5K2oc=;
        b=BuHxbeKqUOKpgxYRhky6tQla1+pFFvDI9Je4UYWkWFXpDhnsHAezm3tmDUlqFkHicf
         CPxafyNxr6DoI6KpJRbTnE7f3VzenXgt6YJquC1Kz8olotjEh8nIhZsedDahknw/0JLp
         /Hu8WS31weOygGVXZnGCNg7L2Z9033z1ClkT+4jyVkX4jXk88gu5taj60a061nhRKJ7e
         GgyFqOT7uI3xaCKtLl6zBMfnb3pPi6bJpiwJuDn2R2AQrPxkJvF8z4sQtShXKr6R0AO6
         dlYzAkzBwd2O4ACR6Qfs+vSKt6FiYgeU9/FOYb3uylBG7sR7SUJHPj0WRogW/lWdUltU
         vsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325270; x=1696930070;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mU56FlmjTv5eFSUjfveUTDJtj2QxEcbZGZN96w5K2oc=;
        b=wYSAaNeKv4huVgYVAiGMZ+FtvQ9gvQ+3q5d/9ZFjffUGchC6hHf8TwGsb3ZzyKGMEj
         BgMwBP/PhNpKszgb3gajNMHgwZ2U6ZexJ4cL7pj9FhGSPOEeG+edoYGpwxvYEBOB1zhO
         1Nw3IQlWtvtdLv2VuSpr3tzdzxWolcsgqw7zqbyfJcx09zIrZvy+I3zFiSaaAu8BgVDv
         43OT+aSj2Io3WZcfVMXLqC4YR9F5MLlfew/pEZdoNy81L8mh8wNpy1tfz0JqZzYo2EUN
         3n7nnlEmrJqtxd50p9Cc7vIIcbh6z3H/J0RZgVx13Bh+b80PKZgg0L6Q4Cc1gzCKCboa
         iubA==
X-Gm-Message-State: AOJu0YwVF0Eo9tDN6J8yY+4TRnpjyD8pgcagTEKlaSsyEbAyJv39chZC
        kdOCXNW8iVQZKs9p1ygYh/Q4/w==
X-Google-Smtp-Source: AGHT+IH+RBdvJ2zPjHqn2yE7GeZTf5dQ/uq/KjJe+YyhinlFoMPpIY/IVB5OPsNP+GzZ5W6FH4sY9g==
X-Received: by 2002:a0d:ddc1:0:b0:5a1:d4bc:7faa with SMTP id g184-20020a0dddc1000000b005a1d4bc7faamr14296514ywe.18.1696325269879;
        Tue, 03 Oct 2023 02:27:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k6-20020a0dc806000000b0058038e6609csm256304ywd.74.2023.10.03.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:27:49 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:27:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 11/12] mempolicy: mmap_lock is not needed while migrating
 folios
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <21e564e8-269f-6a89-7ee2-fd612831c289@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbind(2) holds down_write of current task's mmap_lock throughout
(exclusive because it needs to set the new mempolicy on the vmas);
migrate_pages(2) holds down_read of pid's mmap_lock throughout.

They both hold mmap_lock across the internal migrate_pages(), under which
all new page allocations (huge or small) are made.  I'm nervous about it;
and migrate_pages() certainly does not need mmap_lock itself.  It's done
this way for mbind(2), because its page allocator is vma_alloc_folio() or
alloc_hugetlb_folio_vma(), both of which depend on vma and address.

Now that we have alloc_pages_mpol(), depending on (refcounted) memory
policy and interleave index, mbind(2) can be modified to use that or
alloc_hugetlb_folio_nodemask(), and then not need mmap_lock across the
internal migrate_pages() at all: add alloc_migration_target_by_mpol()
to replace mbind's new_page().

(After that change, alloc_hugetlb_folio_vma() is used by nothing but a
userfaultfd function: move it out of hugetlb.h and into the #ifdef.)

migrate_pages(2) has chosen its target node before migrating, so can
continue to use the standard alloc_migration_target(); but let it take
and drop mmap_lock just around migrate_to_node()'s queue_pages_range():
neither the node-to-node calculations nor the page migrations need it.

It seems unlikely, but it is conceivable that some userspace depends on
the kernel's mmap_lock exclusion here, instead of doing its own locking:
more likely in a testsuite than in real life.  It is also possible, of
course, that some pages on the list will be munmapped by another thread
before they are migrated, or a newer memory policy applied to the range
by that time: but such races could happen before, as soon as mmap_lock
was dropped, so it does not appear to be a concern.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/hugetlb.h |  9 -----
 mm/hugetlb.c            | 38 ++++++++++----------
 mm/mempolicy.c          | 83 ++++++++++++++++++++++---------------------
 3 files changed, 63 insertions(+), 67 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a574e26e18a2..7c6faee07b42 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -716,8 +716,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
-struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
-				unsigned long address);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
@@ -1040,13 +1038,6 @@ alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return NULL;
 }
 
-static inline struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
-					       struct vm_area_struct *vma,
-					       unsigned long address)
-{
-	return NULL;
-}
-
 static inline int __alloc_bootmem_huge_page(struct hstate *h)
 {
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d5b7f208dac..68ff79061f88 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2458,24 +2458,6 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
-/* mempolicy aware migration callback */
-struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
-		unsigned long address)
-{
-	struct mempolicy *mpol;
-	nodemask_t *nodemask;
-	struct folio *folio;
-	gfp_t gfp_mask;
-	int node;
-
-	gfp_mask = htlb_alloc_mask(h);
-	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
-	mpol_cond_put(mpol);
-
-	return folio;
-}
-
 /*
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
@@ -6279,6 +6261,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_USERFAULTFD
+/*
+ * Can probably be eliminated, but still used by hugetlb_mfill_atomic_pte().
+ */
+static struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
+		struct vm_area_struct *vma, unsigned long address)
+{
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+	struct folio *folio;
+	gfp_t gfp_mask;
+	int node;
+
+	gfp_mask = htlb_alloc_mask(h);
+	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
+	mpol_cond_put(mpol);
+
+	return folio;
+}
+
 /*
  * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_atomic_pte
  * with modifications for hugetlb pages.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8cf76de12acd..a7b34b9c00ef 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -417,6 +417,8 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags);
+static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
+				pgoff_t ilx, int *nid);
 
 static bool strictly_unmovable(unsigned long flags)
 {
@@ -1043,6 +1045,8 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	node_set(source, nmask);
 
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
+
+	mmap_read_lock(mm);
 	vma = find_vma(mm, 0);
 
 	/*
@@ -1053,6 +1057,7 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	 */
 	nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 				      flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+	mmap_read_unlock(mm);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
@@ -1081,8 +1086,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 
 	lru_cache_disable();
 
-	mmap_read_lock(mm);
-
 	/*
 	 * Find a 'source' bit set in 'tmp' whose corresponding 'dest'
 	 * bit in 'to' is not also set in 'tmp'.  Clear the found 'source'
@@ -1162,7 +1165,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		if (err < 0)
 			break;
 	}
-	mmap_read_unlock(mm);
 
 	lru_cache_enable();
 	if (err < 0)
@@ -1171,44 +1173,38 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 }
 
 /*
- * Allocate a new page for page migration based on vma policy.
- * Start by assuming the page is mapped by the same vma as contains @start.
- * Search forward from there, if not.  N.B., this assumes that the
- * list of pages handed to migrate_pages()--which is how we get here--
- * is in virtual address order.
+ * Allocate a new folio for page migration, according to NUMA mempolicy.
  */
-static struct folio *new_folio(struct folio *src, unsigned long start)
+static struct folio *alloc_migration_target_by_mpol(struct folio *src,
+						    unsigned long private)
 {
-	struct vm_area_struct *vma;
-	unsigned long address;
-	VMA_ITERATOR(vmi, current->mm, start);
-	gfp_t gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
+	struct mempolicy *pol = (struct mempolicy *)private;
+	pgoff_t ilx = 0;	/* improve on this later */
+	struct page *page;
+	unsigned int order;
+	int nid = numa_node_id();
+	gfp_t gfp;
 
-	for_each_vma(vmi, vma) {
-		address = page_address_in_vma(&src->page, vma);
-		if (address != -EFAULT)
-			break;
-	}
-
-	/*
-	 * __get_vma_policy() now expects a genuine non-NULL vma. Return NULL
-	 * when the page can no longer be located in a vma: that is not ideal
-	 * (migrate_pages() will give up early, presuming ENOMEM), but good
-	 * enough to avoid a crash by syzkaller or concurrent holepunch.
-	 */
-	if (!vma)
-		return NULL;
+	order = folio_order(src);
+	ilx += src->index >> order;
 
 	if (folio_test_hugetlb(src)) {
-		return alloc_hugetlb_folio_vma(folio_hstate(src),
-				vma, address);
+		nodemask_t *nodemask;
+		struct hstate *h;
+
+		h = folio_hstate(src);
+		gfp = htlb_alloc_mask(h);
+		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
+		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
 	}
 
 	if (folio_test_large(src))
 		gfp = GFP_TRANSHUGE;
+	else
+		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
 
-	return vma_alloc_folio(gfp, folio_order(src), vma, address,
-			folio_test_large(src));
+	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
+	return page_rmappable_folio(page);
 }
 #else
 
@@ -1224,7 +1220,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	return -ENOSYS;
 }
 
-static struct folio *new_folio(struct folio *src, unsigned long start)
+static struct folio *alloc_migration_target_by_mpol(struct folio *src,
+						    unsigned long private)
 {
 	return NULL;
 }
@@ -1298,6 +1295,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (nr_failed < 0) {
 		err = nr_failed;
+		nr_failed = 0;
 	} else {
 		vma_iter_init(&vmi, mm, start);
 		prev = vma_prev(&vmi);
@@ -1308,19 +1306,24 @@ static long do_mbind(unsigned long start, unsigned long len,
 		}
 	}
 
-	if (!err) {
-		if (!list_empty(&pagelist)) {
-			nr_failed |= migrate_pages(&pagelist, new_folio, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
+	mmap_write_unlock(mm);
+
+	if (!err && !list_empty(&pagelist)) {
+		/* Convert MPOL_DEFAULT's NULL to task or default policy */
+		if (!new) {
+			new = get_task_policy(current);
+			mpol_get(new);
 		}
-		if (nr_failed && (flags & MPOL_MF_STRICT))
-			err = -EIO;
+		nr_failed |= migrate_pages(&pagelist,
+				alloc_migration_target_by_mpol, NULL,
+				(unsigned long)new, MIGRATE_SYNC,
+				MR_MEMPOLICY_MBIND, NULL);
 	}
 
+	if (nr_failed && (flags & MPOL_MF_STRICT))
+		err = -EIO;
 	if (!list_empty(&pagelist))
 		putback_movable_pages(&pagelist);
-
-	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-- 
2.35.3

