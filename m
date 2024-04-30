Return-Path: <linux-kernel+bounces-163544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978B8B6CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A831C227E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05BD1272CB;
	Tue, 30 Apr 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPw0AchB"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80466126F2C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466105; cv=none; b=opdik43ETJN5k0Pyqgz/1v8V7HmIkJenK4YH5Zvw6mGVBbEquVQV1Mv1FYxT4OPk/Ck1HGgV+MsjtzhIAVJesYtVtLF2SlHtiPIHP/WrfAFPK59UsD9Pv69uSE+QJDby13lTYis6Ot8ER09zchgfB9BAFSLrb9pN43fdjtZsgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466105; c=relaxed/simple;
	bh=pkWHCeSzTqS/reracJ9WHv117rpDARyiLszso3HTepk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnY+2Yl+jyLie/GTFWUOz8pcf4qQ0NDyqTVnou4J2+yPeD1I98+ebhZDAVUyismFZHzWnSBEmFi6nByi0gySG64IrVp/XGpVsvDdnQMn6DjqGU2W/jH988oYTxoiRQttljFJWjG5tJLHkPjtuoE6GvPVGJAL2TO0rnXXQEQmOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPw0AchB; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dac88c79f2so1636013e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714466102; x=1715070902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/rBRcHoRXlAwLG+vwR0R7sg6LprDY9hP2qmcW7kBis=;
        b=CPw0AchBqAGx2OMkGE5em4DxLSBPVzqp3IkFaLqAeawRB2s5KdELbBT6t+CtBvb/xq
         F0+m5G2HHDikcdvjdV7ZLKd8mhRx1fwSMOc8orz4JmAYVYkAhozeqxdzl7+KescFjRNy
         zHDIAfw//PHV5ZxZIVJXxv/djGZ81z/E3P51wqpVvIJaTLBN9yTjLf4bvqXItajeUO1h
         O7Lb31OWwN/P2rNHp/Lh1kHkSQHzbJQjfjtV1cJIyUbLOl8He+BoBh/KL55gGclK1LHH
         LFbssx5UGzAVgil97OtvBOkcQovJR3zmYBwyxJNh3MQsFEpe6FJZ3/0rDLmKaQ/UQ03U
         m2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466102; x=1715070902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/rBRcHoRXlAwLG+vwR0R7sg6LprDY9hP2qmcW7kBis=;
        b=by+4amOQ4V5xVdQqtFrXHoGFyStDiLbmzLnKS5Tgr4NJ0Q6WWt8BOHsmeguzqZiZ0i
         GPp9aGZI3OkYvHCQfZnkHoeLMhdjH4KjKVVqzGd9WWlM10FC95X4Dhu1G4ayEicd00bn
         98Ap0VJVwRKtTuMKfZuX4NjmXDA/BE0Ie9kViJslb70fpnDT7b6otHBX3nkhjWajlYSu
         462TYygywK8L7lP5/CAuuGG77gIK7Wi7/o81MeAWjymhe0iKyPAVzyNKWMfwhsxU3aZ4
         PBs5HNovUIKRHpIbugwzQZPEzMf2TFtJKBH0jx098uxIs0St6F69enmyUHT1Asw/HwEy
         yWlg==
X-Forwarded-Encrypted: i=1; AJvYcCXdUuLRJJe5PMl5jLoQOlUlE8dkmGSGvdtXbbduGO8mFTqz1Leeno0xBQ9mbbXwTNY3zwOpQIhynvKB27nO/aobUlKBPQidYyMrlsc1
X-Gm-Message-State: AOJu0YwrO+OUUld3QjghJFI6xbHz4EDry5wd/Vu+9DVLKNd+Wafn/67k
	+mWYjiBHy2UTKYnHVA7jRvPBjhvsg03Sr+qZwJj1Ip9COZYD7ViX3B29wdTJO59rTE6hwkzIeiu
	jyoCm9/5pGGh9CMGgB+jET2XA6rI=
X-Google-Smtp-Source: AGHT+IE2b+9xTm93X/NkRizSYwvw0aFz30OMiG5gNVvXz6AiphNeZtosWpjR+pMGckPIT2fWaAqlTbKNVg9CjZTjGbk=
X-Received: by 2002:a05:6122:4689:b0:4d4:1cb7:f57a with SMTP id
 di9-20020a056122468900b004d41cb7f57amr14645965vkb.9.1714466102388; Tue, 30
 Apr 2024 01:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429132308.38794-1-ioworker0@gmail.com> <20240429132308.38794-4-ioworker0@gmail.com>
In-Reply-To: <20240429132308.38794-4-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Apr 2024 20:34:51 +1200
Message-ID: <CAGsJ_4yYDZfpmp6UTmZSZs74otu4wOKqJ3xfvzQ=pbmfsmmc=g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 1:23=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> When the user no longer requires the pages, they would use
> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> typically would not re-write to that memory again.
>
> During memory reclaim, if we detect that the large folio and its PMD are
> both still marked as clean and there are no unexpected references
> (such as GUP), so we can just discard the memory lazily, improving the
> efficiency of memory reclamation in this case.
>
> On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
>
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  2 ++
>  mm/huge_memory.c        | 75 +++++++++++++++++++++++++++++++++++++++++
>  mm/rmap.c               |  3 ++
>  3 files changed, 80 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2daadfcc6776..fd330f72b4f3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -38,6 +38,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_a=
rea_struct *vma,
>                     unsigned long cp_flags);
>  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long add=
ress,
>                            pmd_t *pmd, bool freeze, struct folio *folio);
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long add=
r,
> +                          pmd_t *pmdp, struct folio *folio);
>
>  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool writ=
e);
>  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool writ=
e);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 145505a1dd05..d35d526ed48f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2690,6 +2690,81 @@ static void unmap_folio(struct folio *folio)
>         try_to_unmap_flush();
>  }
>
> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> +                                      unsigned long addr, pmd_t *pmdp,
> +                                      struct folio *folio)
> +{
> +       struct mm_struct *mm =3D vma->vm_mm;
> +       int ref_count, map_count;
> +       pmd_t orig_pmd =3D *pmdp;
> +       struct mmu_gather tlb;
> +       struct page *page;
> +
> +       if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> +               return false;
> +       if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd))=
)
> +               return false;
> +
> +       page =3D pmd_page(orig_pmd);
> +       if (unlikely(page_folio(page) !=3D folio))
> +               return false;
> +
> +       tlb_gather_mmu(&tlb, mm);
> +       orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> +       tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> +
> +       /*
> +        * Syncing against concurrent GUP-fast:
> +        * - clear PMD; barrier; read refcount
> +        * - inc refcount; barrier; read PMD
> +        */
> +       smp_mb();
> +
> +       ref_count =3D folio_ref_count(folio);
> +       map_count =3D folio_mapcount(folio);
> +
> +       /*
> +        * Order reads for folio refcount and dirty flag
> +        * (see comments in __remove_mapping()).
> +        */
> +       smp_rmb();
> +
> +       /*
> +        * If the PMD or folio is redirtied at this point, or if there ar=
e
> +        * unexpected references, we will give up to discard this folio
> +        * and remap it.
> +        *
> +        * The only folio refs must be one from isolation plus the rmap(s=
).
> +        */
> +       if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> +           pmd_dirty(orig_pmd)) {
> +               set_pmd_at(mm, addr, pmdp, orig_pmd);
> +               return false;
> +       }
> +
> +       folio_remove_rmap_pmd(folio, page, vma);
> +       zap_deposited_table(mm, pmdp);
> +       add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +       folio_put(folio);
> +
> +       return true;
> +}
> +
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long add=
r,
> +                          pmd_t *pmdp, struct folio *folio)
> +{
> +       VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> +       VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> +       VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> +               return __discard_trans_pmd_locked(vma, addr, pmdp, folio)=
;
> +#endif

this is weird and huge_memory.c is only built with
CONFIG_TRANSPARENT_HUGEPAGE =3D y;

mm/Makefile:
obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o

> +
> +       return false;
> +}
> +
>  static void remap_page(struct folio *folio, unsigned long nr)
>  {
>         int i =3D 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e42f436c7ff3..ab37af4f47aa 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1677,6 +1677,9 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>                 }
>
>                 if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> +                       if (unmap_huge_pmd_locked(vma, range.start, pvmw.=
pmd,
> +                                                 folio))
> +                               goto walk_done;

this is making
mm/rmap.c:1680: undefined reference to `unmap_huge_pmd_locked'
mm/rmap.c:1687: undefined reference to `split_huge_pmd_locked'

>                         /*
>                          * We temporarily have to drop the PTL and start =
once
>                          * again from that now-PTE-mapped page table.
> --
> 2.33.1
>

