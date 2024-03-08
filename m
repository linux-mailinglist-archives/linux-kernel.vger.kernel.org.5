Return-Path: <linux-kernel+bounces-97430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EC7876A57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9931C216AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8F495CC;
	Fri,  8 Mar 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhVVB2en"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43537282EB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920898; cv=none; b=YEjunyK2PiWbPrGufVb/jExsBvJNYP83UB23ae6q3kx2zuWxH/SMD0pryhyKxkxPcOgm7H0YOoM3H4K/kplo0P+R7y3RMllXtAq7yYc5U/6wa3FXN3NzYPO9v1JTbF1dzWHmb5Hxc+dyL2eZqeESe3blyL2YN7WpuVOs6vEuCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920898; c=relaxed/simple;
	bh=UHMjcfK1m3HBwA1jwiAWKdXRHDFgMIGkPO4QG3zfy0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpCKmd2JY6anGe5ADT8Y9HCV6MCfXoqyy4kOkMOi9gp31+9nw64b1IMChM+T4LeNDGQJeXxPPhCtMbiSxfFbCUNhdE/AQV9ZYxwRXPE4kqjR9J6Ac2RNueoD2OSYEZS2Ud0bNDui62ZAZWU9DaXUaZTWy//dyt/Pe4FH75PAj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhVVB2en; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d3cf0c74e5so118198e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709920895; x=1710525695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbQcqxp3h2Vdx42ene+gxiSaumSLIpwjEluWYDMZUT4=;
        b=IhVVB2enJivLLIHCf+pgqb0a4K8dM9KGIAbPsM3taqUUJaO0fg6ECSfkGBd+jWw1Co
         3IipMffi9UL/VMe7JBo3HuLCFkQa8uZ9jnVGBGYA81TvpjS7/Y/i2FHKwm2un1C2jWNz
         R/J/Vb0incW5vvPqy3j/GDy+FAIOeMbvqMthevqvhzVd/MHlyVO5CLX4OW8dawcxeIwl
         2mRY6zOUBJ+qhzxgex+ZFVFHyOYht4bIM45oAVagxND6gLRDEP651SD2HtEwqoTcP6pR
         rjPiRbdQet/cwxnvkskNh7dvDE9YZYVW3uPlhDCW4FAT/Uqi6FxEPq4gbFKHIrxw4RW5
         H9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920895; x=1710525695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbQcqxp3h2Vdx42ene+gxiSaumSLIpwjEluWYDMZUT4=;
        b=aQzMffP1bwlf4KZgwdzmh4QeRGC+T3Sy8/x41WvustBDFQOjvQUgbk5uHKo47lhsnm
         cChZqP71waLpYWxNKap2c8047bGgVmAZpbnHxciyoLlDPeEzlNWizUw6/xO4ogcC5E1p
         GFtxV6pQkdWvWsIqgaLjUZ3JSq7q6g/VwFT5xPdNpFxYYVYekkuw1p9dGqjLIUHZeEqg
         D9U54v9Cvw6TYIhhal+1/7rNKhfR//951hKkHKi7LbNizZcySEjkuCSjawYbadw9tzQq
         hsKTdo75TgIF5Pw/wCUd+cAqL7Yqx7iqAymFjk1ViFDj0mOL3JncisMlgVRS7FeMxkrN
         VJgg==
X-Forwarded-Encrypted: i=1; AJvYcCXbY60e5S0MW1rGrM40eFYuYyL4dMuuFZihmN0ZQ6Do0qviuS6oMWSGfHCnnwIdf8tsD5it2/8cd5sXqvBKkJ5rr0xaxgVE4mVU0rpq
X-Gm-Message-State: AOJu0YwyaimUX7GNlIMtVlVzL53o+6kHobnrLByBmixl4oH0SsnIt7C8
	OYfKWNKcCIo0cK/Xboi+zYJFMmbDIsGS4I8D5bUruXqgLDWWe4NDGuu+kF1beMbl/7FzR216eGJ
	fy5HF1bpAPYt/yRc+udHaO9RUieU=
X-Google-Smtp-Source: AGHT+IHuB5A/FPA1bD3/ChfkG9ePX6+irzv80qlC+4gl0P8ZZgyBbwpjuWeW1xZfeTVsZ0ILejcdeEzhCMfaa5oQAUk=
X-Received: by 2002:a05:6122:7ca:b0:4c7:7407:e8ab with SMTP id
 l10-20020a05612207ca00b004c77407e8abmr20694vkr.12.1709920894828; Fri, 08 Mar
 2024 10:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com> <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com> <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com> <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
 <a07deb2c-49e1-4324-8e70-e897605faa9d@redhat.com> <b1bf4b62-8e9b-470f-a300-d13c24177688@arm.com>
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com> <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
 <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com> <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
 <60dc7309-cb38-45e3-b2c0-ff0119202a12@arm.com>
In-Reply-To: <60dc7309-cb38-45e3-b2c0-ff0119202a12@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 9 Mar 2024 02:01:22 +0800
Message-ID: <CAGsJ_4yaJ5weXd8N=zwoo1xa8jvEdZnFOGQ0pjUXB1EUsrRTcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:05=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 07/03/2024 18:54, Barry Song wrote:
> > On Fri, Mar 8, 2024 at 12:31=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 07/03/2024 12:01, Barry Song wrote:
> >>> On Thu, Mar 7, 2024 at 7:45=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 07.03.24 12:42, Ryan Roberts wrote:
> >>>>> On 07/03/2024 11:31, David Hildenbrand wrote:
> >>>>>> On 07.03.24 12:26, Barry Song wrote:
> >>>>>>> On Thu, Mar 7, 2024 at 7:13=E2=80=AFPM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 07/03/2024 10:54, David Hildenbrand wrote:
> >>>>>>>>> On 07.03.24 11:54, David Hildenbrand wrote:
> >>>>>>>>>> On 07.03.24 11:50, Ryan Roberts wrote:
> >>>>>>>>>>> On 07/03/2024 09:33, Barry Song wrote:
> >>>>>>>>>>>> On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.r=
oberts@arm.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
> >>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworke=
r0@gmail.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Hey Barry,
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Thanks for taking time to review!
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnba=
o@gmail.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <iowor=
ker0@gmail.com> wrote:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> [...]
> >>>>>>>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsig=
ned long addr,
> >>>>>>>>>>>>>>>>> +                                                struct=
 folio *folio,
> >>>>>>>>>>>>>>>>> pte_t *start_pte)
> >>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>>>>>>>>>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_S=
OFT_DIRTY;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>>>>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i))=
 !=3D 1)
> >>>>>>>>>>>>>>>>> +                       return false;
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> we have moved to folio_estimated_sharers though it is no=
t precise, so
> >>>>>>>>>>>>>>>> we don't do
> >>>>>>>>>>>>>>>> this check with lots of loops and depending on the subpa=
ge's mapcount.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> If we don't check the subpage=E2=80=99s mapcount, and the=
re is a cow folio
> >>>>>>>>>>>>>>> associated
> >>>>>>>>>>>>>>> with this folio and the cow folio has smaller size than t=
his folio,
> >>>>>>>>>>>>>>> should we still
> >>>>>>>>>>>>>>> mark this folio as lazyfree?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I agree, this is true. However, we've somehow accepted the=
 fact that
> >>>>>>>>>>>>>> folio_likely_mapped_shared
> >>>>>>>>>>>>>> can result in false negatives or false positives to balanc=
e the
> >>>>>>>>>>>>>> overhead.  So I really don't know :-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Maybe David and Vishal can give some comments here.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> BTW, do we need to rebase our work against David's chang=
es[1]?
> >>>>>>>>>>>>>>>> [1]
> >>>>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1=
-david@redhat.com/
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Yes, we should rebase our work against David=E2=80=99s ch=
anges.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, a=
ddr, start_pte,
> >>>>>>>>>>>>>>>>> +                                        ptep_get(start=
_pte), nr_pages,
> >>>>>>>>>>>>>>>>> flags, NULL);
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>      static int madvise_free_pte_range(pmd_t *pmd, unsi=
gned long addr,
> >>>>>>>>>>>>>>>>>                                     unsigned long end, =
struct mm_walk
> >>>>>>>>>>>>>>>>> *walk)
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range=
(pmd_t *pmd,
> >>>>>>>>>>>>>>>>> unsigned long addr,
> >>>>>>>>>>>>>>>>>                      */
> >>>>>>>>>>>>>>>>>                     if (folio_test_large(folio)) {
> >>>>>>>>>>>>>>>>>                             int err;
> >>>>>>>>>>>>>>>>> +                       unsigned long next_addr, align;
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> -                       if (folio_estimated_sharers(fol=
io) !=3D 1)
> >>>>>>>>>>>>>>>>> -                               break;
> >>>>>>>>>>>>>>>>> -                       if (!folio_trylock(folio))
> >>>>>>>>>>>>>>>>> -                               break;
> >>>>>>>>>>>>>>>>> +                       if (folio_estimated_sharers(fol=
io) !=3D 1 ||
> >>>>>>>>>>>>>>>>> +                           !folio_trylock(folio))
> >>>>>>>>>>>>>>>>> +                               goto skip_large_folio;
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as =
some of them
> >>>>>>>>>>>>>>>> might be
> >>>>>>>>>>>>>>>> pointing to other folios.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_=
DONTNEED(15-16),
> >>>>>>>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page fa=
ults, thus PTE15
> >>>>>>>>>>>>>>>> and PTE16 will point to two different small folios. We c=
an only skip
> >>>>>>>>>>>>>>>> when we
> >>>>>>>>>>>>>>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Agreed. Thanks for pointing that out.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +                       align =3D folio_nr_pages(folio)=
 * PAGE_SIZE;
> >>>>>>>>>>>>>>>>> +                       next_addr =3D ALIGN_DOWN(addr +=
 align, align);
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +                       /*
> >>>>>>>>>>>>>>>>> +                        * If we mark only the subpages=
 as lazyfree, or
> >>>>>>>>>>>>>>>>> +                        * cannot mark the entire large=
 folio as
> >>>>>>>>>>>>>>>>> lazyfree,
> >>>>>>>>>>>>>>>>> +                        * then just split it.
> >>>>>>>>>>>>>>>>> +                        */
> >>>>>>>>>>>>>>>>> +                       if (next_addr > end || next_add=
r - addr !=3D
> >>>>>>>>>>>>>>>>> align ||
> >>>>>>>>>>>>>>>>> +                           !can_mark_large_folio_lazyf=
ree(addr, folio,
> >>>>>>>>>>>>>>>>> pte))
> >>>>>>>>>>>>>>>>> +                               goto split_large_folio;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +                       /*
> >>>>>>>>>>>>>>>>> +                        * Avoid unnecessary folio spli=
tting if the
> >>>>>>>>>>>>>>>>> large
> >>>>>>>>>>>>>>>>> +                        * folio is entirely within the=
 given range.
> >>>>>>>>>>>>>>>>> +                        */
> >>>>>>>>>>>>>>>>> +                       folio_clear_dirty(folio);
> >>>>>>>>>>>>>>>>> +                       folio_unlock(folio);
> >>>>>>>>>>>>>>>>> +                       for (; addr !=3D next_addr; pte=
++, addr +=3D
> >>>>>>>>>>>>>>>>> PAGE_SIZE) {
> >>>>>>>>>>>>>>>>> +                               ptent =3D ptep_get(pte)=
;
> >>>>>>>>>>>>>>>>> +                               if (pte_young(ptent) ||
> >>>>>>>>>>>>>>>>> pte_dirty(ptent)) {
> >>>>>>>>>>>>>>>>> +                                       ptent =3D
> >>>>>>>>>>>>>>>>> ptep_get_and_clear_full(
> >>>>>>>>>>>>>>>>> +                                               mm, add=
r, pte,
> >>>>>>>>>>>>>>>>> tlb->fullmm);
> >>>>>>>>>>>>>>>>> +                                       ptent =3D pte_m=
kold(ptent);
> >>>>>>>>>>>>>>>>> +                                       ptent =3D pte_m=
kclean(ptent);
> >>>>>>>>>>>>>>>>> +                                       set_pte_at(mm, =
addr, pte,
> >>>>>>>>>>>>>>>>> ptent);
> >>>>>>>>>>>>>>>>> +                                       tlb_remove_tlb_=
entry(tlb, pte,
> >>>>>>>>>>>>>>>>> addr);
> >>>>>>>>>>>>>>>>> +                               }
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large f=
olio, you are
> >>>>>>>>>>>>>>>> unfolding
> >>>>>>>>>>>>>>>> and folding again. It seems quite expensive.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'm not convinced we should be doing this in batches. We wa=
nt the initial
> >>>>>>>>>>>>> folio_pte_batch() to be as loose as possible regarding perm=
issions so
> >>>>>>>>>>>>> that we
> >>>>>>>>>>>>> reduce our chances of splitting folios to the min. (e.g. ig=
nore SW bits
> >>>>>>>>>>>>> like
> >>>>>>>>>>>>> soft dirty, etc). I think it might be possible that some PT=
Es are RO and
> >>>>>>>>>>>>> other
> >>>>>>>>>>>>> RW too (e.g. due to cow - although with the current cow imp=
l, probably not.
> >>>>>>>>>>>>> But
> >>>>>>>>>>>>> its fragile to assume that). Anyway, if we do an initial ba=
tch that ignores
> >>>>>>>>>>>>> all
> >>>>>>>>>>>>
> >>>>>>>>>>>> You are correct. I believe this scenario could indeed occur.=
 For instance,
> >>>>>>>>>>>> if process A forks process B and then unmaps itself, leaving=
 B as the
> >>>>>>>>>>>> sole process owning the large folio.  The current wp_page_re=
use() function
> >>>>>>>>>>>> will reuse PTE one by one while the specific subpage is writ=
ten.
> >>>>>>>>>>>
> >>>>>>>>>>> Hmm - I thought it would only reuse if the total mapcount for=
 the folio
> >>>>>>>>>>> was 1.
> >>>>>>>>>>> And since it is a large folio with each page mapped once in p=
roc B, I thought
> >>>>>>>>>>> every subpage write would cause a copy except the last one? I=
 haven't
> >>>>>>>>>>> looked at
> >>>>>>>>>>> the code for a while. But I had it in my head that this is an=
 area we need to
> >>>>>>>>>>> improve for mTHP.
> >>>>>>>
> >>>>>>> So sad I am wrong again =F0=9F=98=A2
> >>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> wp_page_reuse() will currently reuse a PTE part of a large fol=
io only if
> >>>>>>>>>> a single PTE remains mapped (refcount =3D=3D 0).
> >>>>>>>>>
> >>>>>>>>> ^ =3D=3D 1
> >>>>>>>
> >>>>>>> seems this needs improvement. it is a waste the last subpage can
> >>>>>>
> >>>>>> My take that is WIP:
> >>>>>>
> >>>>>> https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.c=
om/T/#u
> >>>>>>
> >>>>>>> reuse the whole large folio. i was doing it in a quite different =
way,
> >>>>>>> if the large folio had only one subpage left, i would do copy and
> >>>>>>> released the large folio[1]. and if i could reuse the whole large=
 folio
> >>>>>>> with CONT-PTE, i would reuse the whole large folio[2]. in mainlin=
e,
> >>>>>>> we don't have this cont-pte luxury exposed to mm, so i guess we c=
an
> >>>>>>> not do [2] easily, but [1] seems to be an optimization.
> >>>>>>
> >>>>>> Yeah, I had essentially the same idea: just free up the large foli=
o if most of
> >>>>>> the stuff is unmapped. But that's rather a corner-case optimizatio=
n, so I did
> >>>>>> not proceed with that.
> >>>>>>
> >>>>>
> >>>>> I'm not sure it's a corner case, really? - process forks, then both=
 parent and
> >>>>> child and write to all pages in what was previously a fully & conti=
guously
> >>>>> mapped large folio?
> >>>>
> >>>> Well, with 2 MiB my assumption was that while it can happen, it's ra=
ther
> >>>> rare. With smaller THP it might get more likely, agreed.
> >>>>
> >>>>>
> >>>>> Reggardless, why is it an optimization to do the copy for the last =
subpage and
> >>>>> syncrhonously free the large folio? It's already partially mapped s=
o is on the
> >>>>> deferred split list and can be split if memory is tight.
> >>>
> >>> we don't want reclamation overhead later. and we want memories immedi=
ately
> >>> available to others.
> >>
> >> But by that logic, you also don't want to leave the large folio partia=
lly mapped
> >> all the way until the last subpage is CoWed. Surely you would want to =
reclaim it
> >> when you reach partial map status?
> >
> > To some extent, I agree. But then we will have two many copies. The las=
t
> > subpage is small, and a safe place to copy instead.
> >
> > We actually had to tune userspace to decrease partial map as too much
> > partial map both unfolded CONT-PTE and wasted too much memory. if a
> > vma had too much partial map, we disabled mTHP on this VMA.
>
> I actually had a whacky idea around introducing selectable page size ABI
> per-process that might help here. I know Android is doing work to make th=
e
> system 16K page compatible. You could run most of the system processes wi=
th 16K
> ABI on top of 4K kernel. Then those processes don't even have the ability=
 to
> madvise/munmap/mprotect/mremap anything less than 16K alignment so that a=
cts as
> an anti-fragmentation mechanism while allowing non-16K capable processes =
to run
> side-by-side. Just a passing thought...

Right, this project faces a challenge in supporting legacy
4KiB-aligned applications.
but I don't find it will be an issue to run 16KiB-aligned applications
on a kernel whose
page size is 4KiB.

>
> >
> >>
> >>> reclamation will always cause latency and affect User
> >>> experience. split_folio is not cheap :-)
> >>
> >> But neither is memcpy(4K) I'd imagine. But I get your point.
> >
> > In a real product scenario, we need to consider the success rate of
> > allocating large folios.
> > Currently, it's only 7%, as reported here[1], with no method to keep
> > large folios intact in a
> > buddy system.
>
> Yes I saw that email - interesting. Is that 7% number for the Oppo
> implementation or upstream implementation? (I think Oppo?). Do you know h=
ow the
> other one compares (my guess is that upstream isn't complete enough yet t=
o give
> viable numbers)? And I'm guessing you are running on a kernel/fs that doe=
sn't
> support large folios in the page cache? What about large folio swap? My f=
eeling
> is that once we have all these features, that number should significantly
> increase because you can create a system that essentially uses large quan=
tities
> of a couple of sizes of page (e.g. 4K & (16K | 64K)) and fragmentation wi=
ll be
> less of a problem. Perhaps that's wishful thinking though.

This is the number of OPPO's implementations which supports one kind of
large folio size - 64KiB only. Meanwhile, OPPO has a TAO-like
optimization by extending
migrate_type and marking some pageblocks dedicated for large folios(except =
some
corner cases , 3-order can also use them), it brings success rate to
around 50% in
do_anon_page and more than 90% in do_swap_page(we give this lower water as
we save large objects in zsmalloc/zram - compressing and decompressing 64Ki=
B
as a whole instead of doing 16 * 4KiB).

The reported data is disabling the TAO-like optimization and just using bud=
dy.

BTW, based on the previous observation, 16KiB allocation could still
be a problem
on phones, for example, kernel stacks allocation was a pain before it
was changed to
vmalloc.

>
> >
> > Yu's TAO[2] chose to release the large folio entirely after copying
> > the mapped parts
> > onto smaller folios in vmscan,
>
> Yes, TAO looks very interesting! It essentially partitions the memory IIU=
C?

kind of, adding two virtual zones to decrease compaction and keep
large folios intact/not being splitted.

>
> >
> > [1] https://lore.kernel.org/linux-mm/20240305083743.24950-1-21cnbao@gma=
il.com/
> > [2] https://lore.kernel.org/linux-mm/20240229183436.4110845-1-yuzhao@go=
ogle.com/
> >
> >>
> >>> if the number of this kind of
> >>> large folios
> >>> is huge, the waste can be huge for some while.
> >>>
> >>> it is not a corner case for large folio swap-in. while someone writes
> >>> one subpage, I swap-in a large folio, wp_reuse will immediately
> >>> be called. This can cause waste quite often. One outcome of this
> >>> discussion is that I realize I should investigate this issue immediat=
ely
> >>> in the swap-in series as my off-tree code has optimized reuse but
> >>> mainline hasn't.
> >>>
> >>>>
> >>>> At least for 2 MiB THP, it might make sense to make that large folio
> >>>> available immediately again, even without memory pressure. Even
> >>>> compaction would not compact it.
> >>>
> >>> It is also true for 64KiB. as we want other processes to allocate
> >>> 64KiB successfully as much as possible, and reduce the rate of
> >>> falling back to small folios. by releasing 64KiB directly to buddy
> >>> rather than splitting and returning 15*4KiB in shrinker, we reduce
> >>> buddy fragmentation too.
> >>>
> >>>>
> >>>> --
> >>>> Cheers,
> >>>>
> >>>> David / dhildenb
> >
Thanks
 Barry
>

