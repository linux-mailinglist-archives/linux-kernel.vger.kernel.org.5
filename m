Return-Path: <linux-kernel+bounces-163618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76B8B6DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B241F23B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C79127B69;
	Tue, 30 Apr 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4anZHzp"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CC28DDF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468093; cv=none; b=pLrk6vMt2QTRBaVUpCSREboqGxEmVPJY/dQBRnfLYQGlnhBO6BLi22lzeDM+cGjFxEgbp9jLXBT8lJ30W2kM9Sf5ZR2ZtMfNQQhaq/ybYDo2y0NufANKb1h5uy3MnuGXabPVu5HxnZcq7QR61kmOA6G9KbIjn+pbLuTe9Jge+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468093; c=relaxed/simple;
	bh=5/OXGDZRxsnhhT6vbdCbai2PRzIP9OrgERBgOIAFRV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhKAR2fvDSt8xaN0afeUXCj8nPsxFgNvIihU8cuy2taxiD+ahxMZd8PFtZuPIaFZF3ZZBtYUSPw9w8ngoBt6vQjlnIKfxuZadukqQOd13cLGpC3ocMSvMnJ/EiunOeTLTZW6ofq+4vp9d6vkxzHaibqN6sSn5XvoAinTut60OJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4anZHzp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51e1b9fba81so1427870e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468090; x=1715072890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cw7QgYMfe5BKxdCLjTtCJc37gLu0B8DTR7jLTXUhP8=;
        b=P4anZHzpa0rfLO9wVUnJWpaBwX0bUZPxdRdQvgFs6mNSKIZJxk0/I5rQRi3gtxxlf0
         LZ8BwVyKgy/uI0u3IS4YFo8G91dTqeqmdXNdgzzEpN8vsRumqVohHJ44pZxlZyPgcEVC
         7xaJVzqxWvm7pI1VlRtQAREWflhgiRirCGpyyizmyQ9w8OPwKKGw+/OSgqG+HoKLzPO9
         DzrP6XyrhfaQSDUqROJyjopjdTf+JWW6WH+A0vWhDPiSCP58BpjWmSaC/BWw/XH7GfuZ
         0Os0EPm5VHgkZCuzwFeMjMCGA99hHWOsw5astR4BCcUt2FZA/FqP62d7O+ThviXy/7sk
         REeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468090; x=1715072890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cw7QgYMfe5BKxdCLjTtCJc37gLu0B8DTR7jLTXUhP8=;
        b=AlHyqiAfC6sFjNZsm7R6FyYrWMYX8jjblNuFxLOWFWpOtjIZM22lkfy6k7jx6UEn2I
         iHzlsOXTo7yYS5mgiNfFKDd9Oso2ZIijHoCAQf59hNDJBNPzVkFbJRCGECjXhMrmUSUO
         hg2gZuoITPP4wJ6Lp7OfnDyfYEXCf5YmvRmx+55hXXH7HjsNRgheO1NtngH9T5KdVG7i
         IgCiTSgvAKwsiZMpqZUkhDhVQLQhrNlYbgRqyGkhj5Pl6G1L+ROQvCG5bDeJpY6zxRq3
         Nn+lMlNKW93ksIJ7ret8VCU50St4ZWBTHNSVWeRO4AIZk5iUJW+6FEy3Sy6QFytLrcCT
         T5pw==
X-Forwarded-Encrypted: i=1; AJvYcCVtZvyuhG/DNNZdBqM14ryGzfVL8k+m3x/8oEqdcw4YK1Xu0DCR9orlJGhJsIK0anlt/Z+wai0h+gPf3kaQRt0vCbuKrON3B56eGhe1
X-Gm-Message-State: AOJu0YzVSgY4gHZe50HbbzMo5mKUbr3+5srYtM6Q3U0lASyWU5PWr8XB
	lQlTr5QAtUswmmVshETBwsmWiy7WJgPV8jmcSYiQOG8b2iXRZ6rZN3aekABYhfwXp/kar+ZdsCV
	/jtiuVjoN5FoD+ou1QdsFCZh85LY=
X-Google-Smtp-Source: AGHT+IGgPWtTDIqP1ZJ2Fu63evtzs/5+O2Qqb8eBhweiGg6h/4Txy+rlKzwaqOIVYMLzTL0iZ3XF1qGKUHHeYUWKJpY=
X-Received: by 2002:a19:ca48:0:b0:51a:c2fe:9f73 with SMTP id
 h8-20020a19ca48000000b0051ac2fe9f73mr9138082lfj.51.1714468089480; Tue, 30 Apr
 2024 02:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429132308.38794-1-ioworker0@gmail.com> <20240429132308.38794-4-ioworker0@gmail.com>
 <CAGsJ_4yYDZfpmp6UTmZSZs74otu4wOKqJ3xfvzQ=pbmfsmmc=g@mail.gmail.com>
In-Reply-To: <CAGsJ_4yYDZfpmp6UTmZSZs74otu4wOKqJ3xfvzQ=pbmfsmmc=g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Apr 2024 17:07:58 +0800
Message-ID: <CAK1f24kMKNSL2csXzA0KppT1Kewd5KLZk0B-WGQJqvh-aLs0yw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Barry,

Thanks for taking time to review!

On Tue, Apr 30, 2024 at 4:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Apr 30, 2024 at 1:23=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > When the user no longer requires the pages, they would use
> > madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> > typically would not re-write to that memory again.
> >
> > During memory reclaim, if we detect that the large folio and its PMD ar=
e
> > both still marked as clean and there are no unexpected references
> > (such as GUP), so we can just discard the memory lazily, improving the
> > efficiency of memory reclamation in this case.
> >
> > On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > Suggested-by: Zi Yan <ziy@nvidia.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  2 ++
> >  mm/huge_memory.c        | 75 +++++++++++++++++++++++++++++++++++++++++
> >  mm/rmap.c               |  3 ++
> >  3 files changed, 80 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2daadfcc6776..fd330f72b4f3 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -38,6 +38,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm=
_area_struct *vma,
> >                     unsigned long cp_flags);
> >  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> >                            pmd_t *pmd, bool freeze, struct folio *folio=
);
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                          pmd_t *pmdp, struct folio *folio);
> >
> >  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool wr=
ite);
> >  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool wr=
ite);
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 145505a1dd05..d35d526ed48f 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2690,6 +2690,81 @@ static void unmap_folio(struct folio *folio)
> >         try_to_unmap_flush();
> >  }
> >
> > +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> > +                                      unsigned long addr, pmd_t *pmdp,
> > +                                      struct folio *folio)
> > +{
> > +       struct mm_struct *mm =3D vma->vm_mm;
> > +       int ref_count, map_count;
> > +       pmd_t orig_pmd =3D *pmdp;
> > +       struct mmu_gather tlb;
> > +       struct page *page;
> > +
> > +       if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> > +               return false;
> > +       if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd=
)))
> > +               return false;
> > +
> > +       page =3D pmd_page(orig_pmd);
> > +       if (unlikely(page_folio(page) !=3D folio))
> > +               return false;
> > +
> > +       tlb_gather_mmu(&tlb, mm);
> > +       orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> > +       tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> > +
> > +       /*
> > +        * Syncing against concurrent GUP-fast:
> > +        * - clear PMD; barrier; read refcount
> > +        * - inc refcount; barrier; read PMD
> > +        */
> > +       smp_mb();
> > +
> > +       ref_count =3D folio_ref_count(folio);
> > +       map_count =3D folio_mapcount(folio);
> > +
> > +       /*
> > +        * Order reads for folio refcount and dirty flag
> > +        * (see comments in __remove_mapping()).
> > +        */
> > +       smp_rmb();
> > +
> > +       /*
> > +        * If the PMD or folio is redirtied at this point, or if there =
are
> > +        * unexpected references, we will give up to discard this folio
> > +        * and remap it.
> > +        *
> > +        * The only folio refs must be one from isolation plus the rmap=
(s).
> > +        */
> > +       if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> > +           pmd_dirty(orig_pmd)) {
> > +               set_pmd_at(mm, addr, pmdp, orig_pmd);
> > +               return false;
> > +       }
> > +
> > +       folio_remove_rmap_pmd(folio, page, vma);
> > +       zap_deposited_table(mm, pmdp);
> > +       add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +       folio_put(folio);
> > +
> > +       return true;
> > +}
> > +
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                          pmd_t *pmdp, struct folio *folio)
> > +{
> > +       VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +       VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > +       VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > +               return __discard_trans_pmd_locked(vma, addr, pmdp, foli=
o);
> > +#endif
>
> this is weird and huge_memory.c is only built with
> CONFIG_TRANSPARENT_HUGEPAGE =3D y;
>
> mm/Makefile:
> obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o

Thanks for pointing that out!
I'll drop the conditional compilation directives :)

>
> > +
> > +       return false;
> > +}
> > +
> >  static void remap_page(struct folio *folio, unsigned long nr)
> >  {
> >         int i =3D 0;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index e42f436c7ff3..ab37af4f47aa 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1677,6 +1677,9 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >                 }
> >
> >                 if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > +                       if (unmap_huge_pmd_locked(vma, range.start, pvm=
w.pmd,
> > +                                                 folio))
> > +                               goto walk_done;
>
> this is making
> mm/rmap.c:1680: undefined reference to `unmap_huge_pmd_locked'
> mm/rmap.c:1687: undefined reference to `split_huge_pmd_locked'

You're right!

It's my oversight, and I'll make sure to address it in the next version.

Thanks again for the review!
Lance

>
> >                         /*
> >                          * We temporarily have to drop the PTL and star=
t once
> >                          * again from that now-PTE-mapped page table.
> > --
> > 2.33.1
> >

