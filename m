Return-Path: <linux-kernel+bounces-165949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C58B93BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2A3284004
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAD1B813;
	Thu,  2 May 2024 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="pssXSrFJ"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D9D527;
	Thu,  2 May 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622408; cv=none; b=LLrHGc5U4EQibMC4e1pUJK1IkaOJBcigonQEFeC35HPdJVv7bhTSp5WTqzMHxpTJuAE25+lQ7N5LDHsQF6c8NJQNhHk/ZLUlqzWAswpiesPXfZCO1E5Oww6pDTP8VjsV6xKQ7nPVeDRrimLV40oUgg+MIONtLUIkj2e3xv1y8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622408; c=relaxed/simple;
	bh=gyjGn7kCm3lE1xA8rN1K4cFmxnP8VfK+E7RaMCYkQd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkGXdjqS28elK4N+fl4s5d7iaoDgyeKQ75EGJYoXpwNjiPvHqVdcLZHO5c0qt3IH98oaNXLEsVEIydjrnKpDRhF07kQWNQEexn5ka7XcMIXMCHTn2HF5tzKpJy6rliqbl7WiahjqV+ncRi7hn6vfUpjZgPb6OYqWXHajfm38rUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=pssXSrFJ; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 9209920039F;
	Thu,  2 May 2024 05:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FaVXZERQHuk+FInxg4by/ZUzUIlPzZXFaJJ+IiLvxFU=; b=pssXSrFJzzoqVOVAPVzkhgjPqG
	GRp3ij/s/axw0G/UoRI4Zre/F1ussKFHRfI5Xcwxvlg4/KXLCAKSU1XJeW2iVIylQpW+hZFlA3V1B
	R9lwKF/yZUy1EoO1rxgz2S/lUM0sOyEwlrRVrjpzE514UWrd0K58Kj1p4Jr6K8giyS04=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s2Nbq-005Zo2-2B;
	Thu, 02 May 2024 05:59:50 +0200
Date: Thu, 2 May 2024 05:59:50 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZjMPtrsrUi8-QJ0G@bender.morinfr.org>
References: <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
 <8a7b9e65-b073-4132-9680-efc2b3af6af0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7b9e65-b073-4132-9680-efc2b3af6af0@redhat.com>

On 30 Apr 21:25, David Hildenbrand wrote:
> > I tried to get the hugepd stuff right but this was the first I heard
> > about it :-) Afaict follow_huge_pmd and friends were already DTRT
> 
> I'll have to have a closer look at some details (the hugepd writability
> check looks a bit odd), but it's mostly what I would have expected!

Ok in the meantime, here is the uprobe change on your current
uprobes_cow trying to address the comments you made in your previous
message. Some of them were not 100% clear to me, so it's a best effort
patch :-) Again lightly tested

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -83,6 +83,10 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 	{}
 };
 
+bool hugetlbfs_mapping(struct address_space *mapping) {
+	return mapping->a_ops == &hugetlbfs_aops;
+}
+
 /*
  * Mask used when checking the page offset value passed in via system
  * calls.  This value will be converted to a loff_t which is signed.
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -511,6 +511,8 @@ struct hugetlbfs_sb_info {
 	umode_t mode;
 };
 
+bool hugetlbfs_mapping(struct address_space *mapping);
+
 static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -557,6 +559,8 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return NULL;
 }
+
+static inline bool hugetlbfs_mapping(struct address_space *mapping) { return false; }
 #endif /* !CONFIG_HUGETLBFS */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 #include <linux/pagemap.h>	/* read_mapping_page */
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -120,7 +121,7 @@ struct xol_area {
  */
 static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 {
-	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	vm_flags_t flags = VM_MAYEXEC | VM_MAYSHARE;
 
 	if (is_register)
 		flags |= VM_WRITE;
@@ -177,6 +178,19 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
 	kunmap_atomic(kaddr);
 }
 
+static bool compare_pages(struct page *page1, struct page *page2, unsigned long page_size)
+{
+	char *addr1, *addr2;
+	int ret;
+
+	addr1 = kmap_local_page(page1);
+	addr2 = kmap_local_page(page2);
+	ret = memcmp(addr1, addr2, page_size);
+	kunmap_local(addr2);
+	kunmap_local(addr1);
+	return ret == 0;
+}
+
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
 {
 	uprobe_opcode_t old_opcode;
@@ -366,7 +380,9 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 }
 
 static bool orig_page_is_identical(struct vm_area_struct *vma,
-		unsigned long vaddr, struct page *page, bool *large)
+		unsigned long vaddr, struct page *page,
+		unsigned long page_size,
+		bool *large)
 {
 	const pgoff_t index = vaddr_to_offset(vma, vaddr) >> PAGE_SHIFT;
 	struct page *orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
@@ -380,7 +396,7 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
 
 	*large = folio_test_large(orig_folio);
 	identical = folio_test_uptodate(orig_folio) &&
-		    pages_identical(page, orig_page);
+		    compare_pages(page, orig_page, page_size);
 	folio_put(orig_folio);
 	return identical;
 }
@@ -396,6 +412,81 @@ struct uwo_data {
 	uprobe_opcode_t opcode;
 };
 
+static int __write_opcode_hugetlb(pte_t *ptep, unsigned long page_mask,
+				  unsigned long vaddr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	struct uwo_data *data = walk->private;
+	const bool is_register = !!is_swbp_insn(&data->opcode);
+	pte_t pte = huge_ptep_get(ptep);
+	struct folio *folio;
+	struct page *page;
+	bool large;
+	struct hstate *h = hstate_vma(walk->vma);
+	unsigned subpage_index = (vaddr & (huge_page_size(h) - 1)) >>
+		PAGE_SHIFT;
+
+	if (!pte_present(pte))
+		return UWO_RETRY;
+	page = vm_normal_page(walk->vma, vaddr, pte);
+	if (!page)
+		return UWO_RETRY;
+	folio = page_folio(page);
+
+	/* When unregistering and there is no anon folio anymore, we're done. */
+	if (!folio_test_anon(folio))
+		return is_register ? UWO_RETRY_WRITE_FAULT : UWO_DONE;
+
+	/*
+	 * See can_follow_write_pte(): we'd actually prefer requiring a
+	 * writable PTE here, but when unregistering we might no longer have
+	 * VM_WRITE ...
+	 */
+	if (!huge_pte_write(pte)) {
+		if (!PageAnonExclusive(page))
+			return UWO_RETRY_WRITE_FAULT;
+		if (unlikely(userfaultfd_wp(walk->vma) && huge_pte_uffd_wp(pte)))
+			return UWO_RETRY_WRITE_FAULT;
+		/* SOFTDIRTY is handled via pte_mkdirty() below. */
+	}
+
+	/* Unmap + flush the TLB, such that we can write atomically .*/
+	flush_cache_page(walk->vma, vaddr & page_mask, pte_pfn(pte));
+	pte = huge_ptep_clear_flush(walk->vma, vaddr & page_mask, ptep);
+	copy_to_page(nth_page(page, subpage_index), data->opcode_vaddr,
+		     &data->opcode, UPROBE_SWBP_INSN_SIZE);
+
+	/*
+	 * When unregistering, we may only zap a PTE if uffd is disabled and
+	 * the folio is not pinned ...
+	 */
+	if (is_register || userfaultfd_missing(walk->vma) ||
+	    folio_maybe_dma_pinned(folio))
+		goto remap;
+
+	/*
+	 * ... the mapped anon page is identical to the original page (that
+	 * will get faulted in on next access), and we don't have GUP pins.
+	 */
+	if (!orig_page_is_identical(walk->vma, vaddr & page_mask, page,
+				    huge_page_size(h), &large))
+		goto remap;
+
+	hugetlb_remove_rmap(folio);
+	folio_put(folio);
+	return UWO_DONE;
+remap:
+	/*
+	 * Make sure that our copy_to_page() changes become visible before the
+	 * set_huge_pte_at() write.
+	 */
+	smp_wmb();
+	/* We modified the page. Make sure to mark the PTE dirty. */
+	set_huge_pte_at(walk->mm , vaddr & page_mask, ptep,
+			huge_pte_mkdirty(pte), huge_page_size(h));
+	return UWO_DONE;
+}
+
 static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
 		unsigned long next, struct mm_walk *walk)
 {
@@ -447,7 +538,7 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
 	 * ... the mapped anon page is identical to the original page (that
 	 * will get faulted in on next access), and we don't have GUP pins.
 	 */
-	if (!orig_page_is_identical(walk->vma, vaddr, page, &large))
+	if (!orig_page_is_identical(walk->vma, vaddr, page, PAGE_SIZE, &large))
 		goto remap;
 
 	/* Zap it and try to reclaim swap space. */
@@ -473,6 +564,7 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
 }
 
 static const struct mm_walk_ops write_opcode_ops = {
+	.hugetlb_entry		= __write_opcode_hugetlb,
 	.pte_entry		= __write_opcode_pte,
 	.walk_lock		= PGWALK_WRLOCK,
 };
@@ -510,6 +602,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	int ret, ref_ctr_updated = 0;
 	struct page *page;
+	unsigned long page_size = PAGE_SIZE;
+	unsigned long page_mask = PAGE_MASK;
 
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
 		return -EINVAL;
@@ -528,6 +622,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	if (ret != 1)
 		goto out;
 
+	if (is_vm_hugetlb_page(vma)) {
+		struct hstate *h = hstate_vma(vma);
+		page_size = huge_page_size(h);
+		page_mask = huge_page_mask(h);
+	}
 	ret = verify_opcode(page, opcode_vaddr, &opcode);
 	put_page(page);
 	if (ret <= 0)
@@ -547,8 +646,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 * unregistering. So trigger MMU notifiers now, as we won't
 		 * be able to do it under PTL.
 		 */
+		const unsigned long start = vaddr & page_mask;
 		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
-					vaddr, vaddr + PAGE_SIZE);
+					start, start + page_size);
 		mmu_notifier_invalidate_range_start(&range);
 	}
 
@@ -830,8 +930,16 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	 */
 	if (mapping->a_ops->read_folio)
 		page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
-	else
+	else if (!is_file_hugepages(filp))
 		page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
+	else {
+		struct hstate *h = hstate_file(filp);
+		unsigned long mask = huge_page_mask(h);
+		page = find_get_page(mapping, (offset & mask) >> PAGE_SHIFT);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+		page = nth_page(page, (offset & (huge_page_size(h) - 1)) >> PAGE_SHIFT);
+	}
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
@@ -1182,9 +1290,12 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	if (!uc->handler && !uc->ret_handler)
 		return -EINVAL;
 
-	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
+	/* copy_insn() uses read_mapping_page() or shmem/hugetlbfs specific
+	 * logic
+	 */
 	if (!inode->i_mapping->a_ops->read_folio &&
-	    !shmem_mapping(inode->i_mapping))
+	    !shmem_mapping(inode->i_mapping) &&
+	    !hugetlbfs_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))

-- 
Guillaume Morin <guillaume@morinfr.org>

