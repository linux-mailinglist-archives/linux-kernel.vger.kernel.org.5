Return-Path: <linux-kernel+bounces-30153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A497831A95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC5D282A71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161D25552;
	Thu, 18 Jan 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WllbTb/g";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WllbTb/g"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE825760;
	Thu, 18 Jan 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584533; cv=none; b=JYSo6R1r9ii+ih7tZWpnFVyICueosx9LPBAq+7bUA8F7u4faecZJWvw02clllyquB4kH/UfFj/C4mTuj1FqSUD32rl6JP10Fs4NnjqUgUWAG1GlHmmV0UO5kF/dObbGU1TcLy2nWhGcdIqPrHk9Eciqwhq/Ua2mutifDyC0Rsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584533; c=relaxed/simple;
	bh=VU5C+5PdptY2V9w09uw/kiK4GoXkSqNaaZuqP/Mho+I=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=qZs/hZomC7liEL8KJyDQwewtO5nXeJbfQHb7esKrRtNcvfLoXVJTeq4Mpa4zdZM5ZODIHt+cL2Hna0gndniEfBG/2ysXsHrds10C3yjb8DRiiV46yQWc0QH51iNq0a9a4bwwgo9gRMbQHrG5GWRpUuZE5yMj2lzoVfTyrCNluIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WllbTb/g; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WllbTb/g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82B2B1F78B;
	Thu, 18 Jan 2024 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705584528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mT0oCbOsWqWG/op5DtygqpA+fS8OzRrMRXt39lRSlxk=;
	b=WllbTb/gZqRBnRK0f/hUPvIp6OEtbyuw2Th3VEWrA0tQp0m7kHT8rGYMh57HAyXqxJDzGZ
	M3+E+kay+xCTPv32vJMZgPEY2WaE0Oq65zvQ8k3jDJm9LLp2SsEWEhM5jy0+clNbQDAoPD
	6jXknggmKRk+Imiq7dAoNWkonEa+Mhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705584528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mT0oCbOsWqWG/op5DtygqpA+fS8OzRrMRXt39lRSlxk=;
	b=WllbTb/gZqRBnRK0f/hUPvIp6OEtbyuw2Th3VEWrA0tQp0m7kHT8rGYMh57HAyXqxJDzGZ
	M3+E+kay+xCTPv32vJMZgPEY2WaE0Oq65zvQ8k3jDJm9LLp2SsEWEhM5jy0+clNbQDAoPD
	6jXknggmKRk+Imiq7dAoNWkonEa+Mhg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61DA913874;
	Thu, 18 Jan 2024 13:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zwipFJAnqWXmBgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 18 Jan 2024 13:28:48 +0000
Date: Thu, 18 Jan 2024 14:28:43 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to
 process_madvise()
Message-ID: <ZaknizX7GaXuyVFP@tiehlicka>
References: <20240118120347.61817-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118120347.61817-1-ioworker0@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="WllbTb/g"
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 82B2B1F78B
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

[CC linux-api]

On Thu 18-01-24 20:03:46, Lance Yang wrote:
> This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
> 
> Allow MADV_F_COLLAPSE_LIGHT behavior for process_madvise(2) if the caller
> has CAP_SYS_ADMIN or is requesting the collapse of its own memory.
> 
> The semantics of MADV_F_COLLAPSE_LIGHT are similar to MADV_COLLAPSE, but
> it  avoids direct reclaim and/or compaction, quickly failing on allocation
> errors.
> 
> This change enables a more flexible and efficient usage of memory collapse
> operations, providing additional control to userspace applications for
> system-wide THP optimization.
> 
> Semantics
> 
> This call is independent of the system-wide THP sysfs settings, but will
> fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> multiple VMAs, the semantics of the collapse over each VMA is independent
> from the others.  This implies a hugepage cannot cross a VMA boundary.  If
> collapse of a given hugepage-aligned/sized region fails, the operation may
> continue to attempt collapsing the remainder of memory specified.
> 
> The memory ranges provided must be page-aligned, but are not required to
> be hugepage-aligned.  If the memory ranges are not hugepage-aligned, the
> start/end of the range will be clamped to the first/last hugepage-aligned
> address covered by said range.  The memory ranges must span at least one
> hugepage-sized region.
> 
> All non-resident pages covered by the range will first be
> swapped/faulted-in, before being internally copied onto a freshly
> allocated hugepage.  Unmapped pages will have their data directly
> initialized to 0 in the new hugepage.  However, for every eligible
> hugepage aligned/sized region to-be collapsed, at least one page must
> currently be backed by memory (a PMD covering the address range must
> already exist).
> 
> Allocation for the new hugepage will not enter direct reclaim and/or
> compaction, quickly failing if allocation fails. When the system has
> multiple NUMA nodes, the hugepage will be allocated from the node providing
> the most native pages. This operation operates on the current state of the
> specified process and makes no persistent changes or guarantees on how pages
> will be mapped, constructed, or faulted in the future.
> 
> Use Cases
> 
> An immediate user of this new functionality is the Go runtime heap allocator
> that manages memory in hugepage-sized chunks. In the past, whether it was a
> newly allocated chunk through mmap() or a reused chunk released by
> madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory with
> huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3]
> respectively. However, both approaches resulted in performance issues; for
> both scenarios, there could be entries into direct reclaim and/or compaction,
> leading to unpredictable stalls[4]. Now, the allocator can confidently use
> process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of huge pages.
> 
> [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404faca29a82689c77
> [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181268b60a3a
> [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4b3a9bd2af
> [4] https://github.com/golang/go/issues/63334
> 
> [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gmail.com/
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> Suggested-by: Zach O'Keefe <zokeefe@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
> V1 -> V2: Treat process_madvise(MADV_F_COLLAPSE_LIGHT) as the lighter-weight alternative 
> 	to madvise(MADV_COLLAPSE)
> 
>  arch/alpha/include/uapi/asm/mman.h           |  1 +
>  arch/mips/include/uapi/asm/mman.h            |  1 +
>  arch/parisc/include/uapi/asm/mman.h          |  1 +
>  arch/xtensa/include/uapi/asm/mman.h          |  1 +
>  include/linux/huge_mm.h                      |  5 +--
>  include/uapi/asm-generic/mman-common.h       |  1 +
>  mm/khugepaged.c                              | 15 ++++++--
>  mm/madvise.c                                 | 36 +++++++++++++++++---
>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>  9 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 763929e814e9..22f23ca04f1a 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -77,6 +77,7 @@
>  #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> +#define MADV_F_COLLAPSE_LIGHT	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
>  
>  /* compatibility flags */
>  #define MAP_FILE	0
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index c6e1fc77c996..acec0b643e9c 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -104,6 +104,7 @@
>  #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> +#define MADV_F_COLLAPSE_LIGHT	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
>  
>  /* compatibility flags */
>  #define MAP_FILE	0
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index 68c44f99bc93..812029c98cd7 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -71,6 +71,7 @@
>  #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> +#define MADV_F_COLLAPSE_LIGHT	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
>  
>  #define MADV_HWPOISON     100		/* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index 1ff0c858544f..52ef463dd5b6 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -112,6 +112,7 @@
>  #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> +#define MADV_F_COLLAPSE_LIGHT	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
>  
>  /* compatibility flags */
>  #define MAP_FILE	0
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 5adb86af35fc..075fdb5d481a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
>  		     int advice);
>  int madvise_collapse(struct vm_area_struct *vma,
>  		     struct vm_area_struct **prev,
> -		     unsigned long start, unsigned long end);
> +		     unsigned long start, unsigned long end, int behavior);
>  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
>  			   unsigned long end, long adjust_next);
>  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
> @@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
>  
>  static inline int madvise_collapse(struct vm_area_struct *vma,
>  				   struct vm_area_struct **prev,
> -				   unsigned long start, unsigned long end)
> +				   unsigned long start, unsigned long end,
> +				   int behavior)
>  {
>  	return -EINVAL;
>  }
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..92c67bc755da 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -78,6 +78,7 @@
>  #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> +#define MADV_F_COLLAPSE_LIGHT	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
>  
>  /* compatibility flags */
>  #define MAP_FILE	0
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..2840051c0ae2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -97,6 +97,8 @@ static struct kmem_cache *mm_slot_cache __ro_after_init;
>  struct collapse_control {
>  	bool is_khugepaged;
>  
> +	int behavior;
> +
>  	/* Num pages scanned per node */
>  	u32 node_load[MAX_NUMNODES];
>  
> @@ -1058,10 +1060,16 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
>  			      struct collapse_control *cc)
>  {
> -	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
> -		     GFP_TRANSHUGE);
>  	int node = hpage_collapse_find_target_node(cc);
>  	struct folio *folio;
> +	gfp_t gfp;
> +
> +	if (cc->is_khugepaged)
> +		gfp = alloc_hugepage_khugepaged_gfpmask();
> +	else
> +		gfp = (cc->behavior == MADV_F_COLLAPSE_LIGHT ?
> +			       GFP_TRANSHUGE_LIGHT :
> +			       GFP_TRANSHUGE);
>  
>  	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
>  		*hpage = NULL;
> @@ -2697,7 +2705,7 @@ static int madvise_collapse_errno(enum scan_result r)
>  }
>  
>  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> -		     unsigned long start, unsigned long end)
> +		     unsigned long start, unsigned long end, int behavior)
>  {
>  	struct collapse_control *cc;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -2718,6 +2726,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	if (!cc)
>  		return -ENOMEM;
>  	cc->is_khugepaged = false;
> +	cc->behavior = behavior;
>  
>  	mmgrab(mm);
>  	lru_add_drain_all();
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 912155a94ed5..9c40226505aa 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
>  	case MADV_POPULATE_READ:
>  	case MADV_POPULATE_WRITE:
>  	case MADV_COLLAPSE:
> +	case MADV_F_COLLAPSE_LIGHT:
>  		return 0;
>  	default:
>  		/* be safe, default to 1. list exceptions explicitly */
> @@ -1082,8 +1083,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  		if (error)
>  			goto out;
>  		break;
> +	case MADV_F_COLLAPSE_LIGHT:
>  	case MADV_COLLAPSE:
> -		return madvise_collapse(vma, prev, start, end);
> +		return madvise_collapse(vma, prev, start, end, behavior);
>  	}
>  
>  	anon_name = anon_vma_name(vma);
> @@ -1178,6 +1180,7 @@ madvise_behavior_valid(int behavior)
>  	case MADV_HUGEPAGE:
>  	case MADV_NOHUGEPAGE:
>  	case MADV_COLLAPSE:
> +	case MADV_F_COLLAPSE_LIGHT:
>  #endif
>  	case MADV_DONTDUMP:
>  	case MADV_DODUMP:
> @@ -1194,6 +1197,17 @@ madvise_behavior_valid(int behavior)
>  	}
>  }
>  
> +
> +static bool process_madvise_behavior_only(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_F_COLLAPSE_LIGHT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static bool process_madvise_behavior_valid(int behavior)
>  {
>  	switch (behavior) {
> @@ -1201,6 +1215,7 @@ static bool process_madvise_behavior_valid(int behavior)
>  	case MADV_PAGEOUT:
>  	case MADV_WILLNEED:
>  	case MADV_COLLAPSE:
> +	case MADV_F_COLLAPSE_LIGHT:
>  		return true;
>  	default:
>  		return false;
> @@ -1368,6 +1383,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>   *		transparent huge pages so the existing pages will not be
>   *		coalesced into THP and new pages will not be allocated as THP.
>   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> + *  MADV_F_COLLAPSE_LIGHT - only for process_madvise, avoids direct reclaim and/or
> + *		compaction.
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> @@ -1394,7 +1411,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>   *  -EBADF  - map exists, but area maps something that isn't a file.
>   *  -EAGAIN - a kernel resource was temporarily unavailable.
>   */
> -int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
> +int _do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,
> +		int behavior, bool is_process_madvise)
>  {
>  	unsigned long end;
>  	int error;
> @@ -1405,6 +1423,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	if (!madvise_behavior_valid(behavior))
>  		return -EINVAL;
>  
> +	if (!is_process_madvise && process_madvise_behavior_only(behavior))
> +		return -EINVAL;
> +
>  	if (!PAGE_ALIGNED(start))
>  		return -EINVAL;
>  	len = PAGE_ALIGN(len_in);
> @@ -1448,9 +1469,14 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>  	return error;
>  }
>  
> +int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
> +{
> +	return _do_madvise(mm, start, len_in, behavior, false);
> +}
> +
>  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  {
> -	return do_madvise(current->mm, start, len_in, behavior);
> +	return _do_madvise(current->mm, start, len_in, behavior, false);
>  }
>  
>  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> @@ -1504,8 +1530,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	total_len = iov_iter_count(&iter);
>  
>  	while (iov_iter_count(&iter)) {
> -		ret = do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
> -					iter_iov_len(&iter), behavior);
> +		ret = _do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
> +					iter_iov_len(&iter), behavior, true);
>  		if (ret < 0)
>  			break;
>  		iov_iter_advance(&iter, iter_iov_len(&iter));
> diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..92c67bc755da 100644
> --- a/tools/include/uapi/asm-generic/mman-common.h
> +++ b/tools/include/uapi/asm-generic/mman-common.h
> @@ -78,6 +78,7 @@
>  #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
>  
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> +#define MADV_F_COLLAPSE_LIGHT	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
>  
>  /* compatibility flags */
>  #define MAP_FILE	0
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs

