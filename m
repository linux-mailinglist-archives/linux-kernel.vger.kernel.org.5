Return-Path: <linux-kernel+bounces-95226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22D874AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCE1F297C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31583A18;
	Thu,  7 Mar 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei+QbaIp"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264483A11
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804018; cv=none; b=lkY49aETfLDwmA/Xl//f/3n5EUuvmSTp7yiDVstj9lohCW6Jm043Ll+BtDI9bNS48R0mCl8yxra+5nakinZL3h+8As8tctTz4nGzlEqPnXUGoKSpNOZeE8VBamy7qKFSaVyDjw/i+XCPpSpTLw+JKxFhLhxPOgJl/XsPjmpBw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804018; c=relaxed/simple;
	bh=czbL4mY+EKXnvexXAxd4lMQOmi54mVQzkBgn+VIDBrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rouNN7OxgackNuP098GYTnGty7nnncurLbQjRY6/kFvNGsONw9AQEO5SjBQOpGdWHxxBU9W1Gp4JAx5WVLUILX6TE0Ysj6dhRe0AeAavKVR1jOq7qrs0HGo+XdUP9xHoF2UQdhKfeBBtm1Fz38zFm8wHGpwbKCs1lQRxM6biT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei+QbaIp; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d34dadcb23so195334e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709804015; x=1710408815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5iyspmW82t1StzHb9XDZVrU2N3DjfFCe8T16xq2KL4=;
        b=Ei+QbaIpmpyNAjTt3mWIxVFI2GmcRIp202IPN5Un7ZvXTGj5qk8pVm6+R6LaieCD8c
         gkhyb+Zd/u0rb6yevw0uTvnPUu4744os/T3kIguTBhitCsTl62pEy2Lk9wjLedbc0TQb
         1oswtTYbTMHGtpdaF0E3MWh07/nK/DuMdsHRtA8Y3Au+DxcsegcumE/MHHUPRyqBJOTU
         1z7fL2fhw9nMlzD7V9dwBS2fI82E7Ew+EfEXh4SuBDjaAflnSfBN8UNk0S48wc4TBqip
         ynEnYrKR9h9w3j7ALFdqknuQreNFuN8iGz7HqwlfuhU6HeoERH/cl+HWSV+XR75fT0fk
         KcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804015; x=1710408815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5iyspmW82t1StzHb9XDZVrU2N3DjfFCe8T16xq2KL4=;
        b=UqLUavoinzPP5nFnmZzfIX5tqIrGj6pn3EX0PcZMYlzYd5ZJXF2jRfHJXdCH/iccLV
         ceeegCLOg3TOERJu7Z3RwtOdiMKOyFiT9k5Ewd1X1KMx1hxYmcM62ixmI68t1AZcVTB6
         DmCy+L0Skx5YmLmPY95JIbZdXKEfVmMjf7P12LdNVgJA4TshNNc/NZiwgzPuc+Rm7v3/
         R0F9t4UCH8ZnBhsCn11taaWfvihiujMpBNeIYbGNX/o5QWE3qXYqxxVoWQ5L9wvqZF0N
         fBUSKc7x8uZffoa/Uwk0v86mXWdPxRdX8sppGiyTrbjvbPWB+J+eV/Pr1GmyHkr7OD2X
         TNmg==
X-Forwarded-Encrypted: i=1; AJvYcCV518rgHeHcKXHcKmHifeyZpA4y1fJy6djknF+ce3vSw+SiTIUapARK7aB41iG3FNTDEQZ3LqdDm69ZjUvuOSI1wbU4MvgZmDOBp1LE
X-Gm-Message-State: AOJu0Yx1CwIteIiLUGkB7lNEBNdEgje0rzZHR9nXI5mT1gxD5oQzoSkD
	SYNH/0IGFcAtAxWEma7nFzRiFg+JEawBiKdRBNm9SJC4CsnSxmpBmR+HFwrdGtZ/a23stLFXZlH
	qLt9v5MeOgn2sycgxfHfit4tKyOs=
X-Google-Smtp-Source: AGHT+IFwZ0/NxnMJuhm1i7tCEtWA4Pu5ZT4reuhxrQePQ9UGJCtYkjHfEq0qQ8+t6eg6pK8K/iQCcHAehPqaht6H8R0=
X-Received: by 2002:a05:6122:3683:b0:4cd:b55a:bb0d with SMTP id
 ec3-20020a056122368300b004cdb55abb0dmr9164123vkb.2.1709804015493; Thu, 07 Mar
 2024 01:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com> <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
In-Reply-To: <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Mar 2024 22:33:23 +1300
Message-ID: <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, david@redhat.com, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 07/03/2024 08:10, Barry Song wrote:
> > On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@gmail.com>=
 wrote:
> >>
> >> Hey Barry,
> >>
> >> Thanks for taking time to review!
> >>
> >> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>>
> >>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gmail.co=
m> wrote:
> >>>>
> >> [...]
> >>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr=
,
> >>>> +                                                struct folio *folio=
, pte_t *start_pte)
> >>>> +{
> >>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> >>>> +
> >>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>> +               if (page_mapcount(folio_page(folio, i)) !=3D 1)
> >>>> +                       return false;
> >>>
> >>> we have moved to folio_estimated_sharers though it is not precise, so
> >>> we don't do
> >>> this check with lots of loops and depending on the subpage's mapcount=
.
> >>
> >> If we don't check the subpage=E2=80=99s mapcount, and there is a cow f=
olio associated
> >> with this folio and the cow folio has smaller size than this folio,
> >> should we still
> >> mark this folio as lazyfree?
> >
> > I agree, this is true. However, we've somehow accepted the fact that
> > folio_likely_mapped_shared
> > can result in false negatives or false positives to balance the
> > overhead.  So I really don't know :-)
> >
> > Maybe David and Vishal can give some comments here.
> >
> >>
> >>> BTW, do we need to rebase our work against David's changes[1]?
> >>> [1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@re=
dhat.com/
> >>
> >> Yes, we should rebase our work against David=E2=80=99s changes.
> >>
> >>>
> >>>> +
> >>>> +       return nr_pages =3D=3D folio_pte_batch(folio, addr, start_pt=
e,
> >>>> +                                        ptep_get(start_pte), nr_pag=
es, flags, NULL);
> >>>> +}
> >>>> +
> >>>>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >>>>                                 unsigned long end, struct mm_walk *w=
alk)
> >>>>
> >>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, =
unsigned long addr,
> >>>>                  */
> >>>>                 if (folio_test_large(folio)) {
> >>>>                         int err;
> >>>> +                       unsigned long next_addr, align;
> >>>>
> >>>> -                       if (folio_estimated_sharers(folio) !=3D 1)
> >>>> -                               break;
> >>>> -                       if (!folio_trylock(folio))
> >>>> -                               break;
> >>>> +                       if (folio_estimated_sharers(folio) !=3D 1 ||
> >>>> +                           !folio_trylock(folio))
> >>>> +                               goto skip_large_folio;
> >>>
> >>>
> >>> I don't think we can skip all the PTEs for nr_pages, as some of them =
might be
> >>> pointing to other folios.
> >>>
> >>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-1=
6),
> >>> and write the memory of PTE15 and PTE16, you get page faults, thus PT=
E15
> >>> and PTE16 will point to two different small folios. We can only skip =
when we
> >>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>
> >> Agreed. Thanks for pointing that out.
> >>
> >>>
> >>>> +
> >>>> +                       align =3D folio_nr_pages(folio) * PAGE_SIZE;
> >>>> +                       next_addr =3D ALIGN_DOWN(addr + align, align=
);
> >>>> +
> >>>> +                       /*
> >>>> +                        * If we mark only the subpages as lazyfree,=
 or
> >>>> +                        * cannot mark the entire large folio as laz=
yfree,
> >>>> +                        * then just split it.
> >>>> +                        */
> >>>> +                       if (next_addr > end || next_addr - addr !=3D=
 align ||
> >>>> +                           !can_mark_large_folio_lazyfree(addr, fol=
io, pte))
> >>>> +                               goto split_large_folio;
> >>>> +
> >>>> +                       /*
> >>>> +                        * Avoid unnecessary folio splitting if the =
large
> >>>> +                        * folio is entirely within the given range.
> >>>> +                        */
> >>>> +                       folio_clear_dirty(folio);
> >>>> +                       folio_unlock(folio);
> >>>> +                       for (; addr !=3D next_addr; pte++, addr +=3D=
 PAGE_SIZE) {
> >>>> +                               ptent =3D ptep_get(pte);
> >>>> +                               if (pte_young(ptent) || pte_dirty(pt=
ent)) {
> >>>> +                                       ptent =3D ptep_get_and_clear=
_full(
> >>>> +                                               mm, addr, pte, tlb->=
fullmm);
> >>>> +                                       ptent =3D pte_mkold(ptent);
> >>>> +                                       ptent =3D pte_mkclean(ptent)=
;
> >>>> +                                       set_pte_at(mm, addr, pte, pt=
ent);
> >>>> +                                       tlb_remove_tlb_entry(tlb, pt=
e, addr);
> >>>> +                               }
> >>>
> >>> Can we do this in batches? for a CONT-PTE mapped large folio, you are=
 unfolding
> >>> and folding again. It seems quite expensive.
>
> I'm not convinced we should be doing this in batches. We want the initial
> folio_pte_batch() to be as loose as possible regarding permissions so tha=
t we
> reduce our chances of splitting folios to the min. (e.g. ignore SW bits l=
ike
> soft dirty, etc). I think it might be possible that some PTEs are RO and =
other
> RW too (e.g. due to cow - although with the current cow impl, probably no=
t. But
> its fragile to assume that). Anyway, if we do an initial batch that ignor=
es all

You are correct. I believe this scenario could indeed occur. For instance,
if process A forks process B and then unmaps itself, leaving B as the
sole process owning the large folio.  The current wp_page_reuse() function
will reuse PTE one by one while the specific subpage is written. This can
make a part of PTE writable while the others are read-only.

> that then do this bit as a batch, you will end up smeering all the ptes w=
ith
> whatever properties were set on the first pte, which probably isn't right=
.
>
> I've done a similar conversion for madvise_cold_or_pageout_pte_range() as=
 part
> of my swap-out series v4 (hoping to post imminently, but still working ou=
t a
> latent bug that it triggers). I use ptep_test_and_clear_young() in that, =
which
> arm64 can apply per-pte but avoid doing a contpte unfold/fold. I know you=
 have
> to clear dirty here too, but I think this pattern is preferable.

nice to know ptep_test_and_clear_young() won't unfold and fold CONT-PTE.
I probably have missed this part of your CONT-PTE series as I was quite bus=
y
with others :-)

>
> FYI, my swap-out series also halfway-batches madvise_free_pte_range() so =
that I
> can batch free_swap_and_cache() for the swap entry case. Ideally the work=
 you
> are doing here would be rebased on top of that and plug-in to the approac=
h
> implemented there. (subject to others' views of course).
>
> I'll cc you when I post it.
>
> >>
> >> Thanks for your suggestion. I'll do this in batches in v3.
> >>
> >> Thanks again for your time!
> >>
> >> Best,
> >> Lance
> >>
> >>>
> >>>> +                       }
> >>>> +                       folio_mark_lazyfree(folio);
> >>>> +                       goto next_folio;
> >>>> +
> >>>> +split_large_folio:
> >>>>                         folio_get(folio);
> >>>>                         arch_leave_lazy_mmu_mode();
> >>>>                         pte_unmap_unlock(start_pte, ptl);
> >>>> @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, =
unsigned long addr,
> >>>>                         err =3D split_folio(folio);
> >>>>                         folio_unlock(folio);
> >>>>                         folio_put(folio);
> >>>> -                       if (err)
> >>>> -                               break;
> >>>> -                       start_pte =3D pte =3D
> >>>> -                               pte_offset_map_lock(mm, pmd, addr, &=
ptl);
> >>>> -                       if (!start_pte)
> >>>> -                               break;
> >>>> -                       arch_enter_lazy_mmu_mode();
> >>>> +
> >>>> +                       /*
> >>>> +                        * If the large folio is locked or cannot be=
 split,
> >>>> +                        * we just skip it.
> >>>> +                        */
> >>>> +                       if (err) {
> >>>> +skip_large_folio:
> >>>> +                               if (next_addr >=3D end)
> >>>> +                                       break;
> >>>> +                               pte +=3D (next_addr - addr) / PAGE_S=
IZE;
> >>>> +                               addr =3D next_addr;
> >>>> +                       }
> >>>> +
> >>>> +                       if (!start_pte) {
> >>>> +                               start_pte =3D pte =3D pte_offset_map=
_lock(
> >>>> +                                       mm, pmd, addr, &ptl);
> >>>> +                               if (!start_pte)
> >>>> +                                       break;
> >>>> +                               arch_enter_lazy_mmu_mode();
> >>>> +                       }
> >>>> +
> >>>> +next_folio:
> >>>>                         pte--;
> >>>>                         addr -=3D PAGE_SIZE;
> >>>>                         continue;
> >>>> --
> >>>> 2.33.1
> >>>>
> >

Thanks
 Barry

