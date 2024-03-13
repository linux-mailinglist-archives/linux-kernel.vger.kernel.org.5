Return-Path: <linux-kernel+bounces-101442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207287A723
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908941C20CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60333F8E2;
	Wed, 13 Mar 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvaDTW0v"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007A1E892
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329847; cv=none; b=JIYw75qYGeAW9PYUvtWnnmKIKFgvjCz8NezZAID6DQWye0fp5m0EfOSvCJYNu/hSSeOw2q/Jcfr3O0Qh1xPI59zgfZQ5yhGEu8Io5hVrGDL99iJHRxm7vskAqwdE9ZcUlIBRHDEeNErZGO8sf6XVPuOk+g+5MIZyYOgwx6wK61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329847; c=relaxed/simple;
	bh=HpwfM/8IsDAfKbzxU4riBdWaLQFmj/GBeyEp7zkXslk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V24BDLsJhhDKzCVXEpkKKvGv9rhWeLmsAcjZERUPXJHzB9zV+ShHBMO94Na2vdUOBZQwJ5lnpzgU97IyrN5OtOO5fI8QX2dMQ96jpTl6ydZ+gNVbXSJ2cL84LGwa0jioI1SaFu7Zi7culi0+n4OrbROCA/n6S6NO8I0r/w3DWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvaDTW0v; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-473ac7bbe64so567937137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710329843; x=1710934643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjRnjtzpV+uCo3l3VhygApoQp+hOFij2LJqpdk2jAWo=;
        b=hvaDTW0v5g4+x7sE/KfjSuo8odHPx5i6SEA1mgmWfUQsIhompZ24Z8Oe4fePeqIUwM
         HdyjoLw5I3ku3y2ty+FN8XJdHWm9HKFQe1T2WyvjrTd6r+o/WtngF7gquunMASk5GkJq
         g42T0n6fHuZuyI/F5oCalgtvfcr3SHh1WqCwWnh36650DoxVmha9uuYpz7v45fE2nxLl
         uD83k6uf/d8p322BppSWfzh6Q31wRW2cqwVyA7jML+db3dFu4RWp++KG8m8m1h/sQZgq
         TFHlIAZhK6IT9wQm5aMPTued+c85q1lSPYZ7g7vHz0cQ3E848R6Dwno8aJ1APUqrPEYh
         Nfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710329843; x=1710934643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjRnjtzpV+uCo3l3VhygApoQp+hOFij2LJqpdk2jAWo=;
        b=h9jfXfXOLh5ElR1wrF99J2KzYJBDeVOlP9OlHV3tG4DRwKfaIMVRP6EzXKH/JhM9fn
         +XTbmEB5nho0qNXMhD0pxkqviwj4elIHYPjjBg1weEnGYqhjbY0/s48Ek9Mc29u2PgBB
         maNlFQkKXl+l31+ssUYbnoOnb5mHP7Rl8vnvYCH+0BZi4mwd/Wr4jdMQ+UfX3sb7yMut
         ymG0QYbIck6MbZJzgKosFcFbh4aFZMKLGHX5IJmGP5Ubzq+qyLSs5J7a2WUpQ2npE+fn
         ftWRpi7URxfdGLlxXg1amNXjatnqvaaW4GU6FJVvjcVbmwJGWiJlefZu9O8+JvWaN3Lv
         JafA==
X-Forwarded-Encrypted: i=1; AJvYcCWXMFQy1sTBa0DUKOWi+rDH5N4T07FOKjD0Ix19iFpxx3A6Db3IQRSVwy6Im770YHqRw4rS/lZlYiSvBPtaOfY4YXhmgZwq+m5FtewN
X-Gm-Message-State: AOJu0YxUsxIm2Vz+Ch60Cf4mhIiVRolFFkcjyKPiGoLc9ZleOMjjlB8C
	DDLzVxBemjSc6zMETUpZvO+5nd24es5GUZgOVaasMeLyetkHrkrg30qhywwmDCT/ReJiElx2wT8
	jaw/fdSRhwX6dqoKexxKT7vKUo6w=
X-Google-Smtp-Source: AGHT+IEl5DAH9ljE8P51bblxPb7xw1TbJLdWxSKuLlfolN++w7AIkRLli11onb8TUzBGv3OmsbVK/l5XKJWhAT1xdlw=
X-Received: by 2002:a05:6102:1981:b0:473:1f3d:4cc9 with SMTP id
 jm1-20020a056102198100b004731f3d4cc9mr2432714vsb.23.1710329843355; Wed, 13
 Mar 2024 04:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com> <CAGsJ_4wodFkL4YZ1iQveUjK6QL7sNajyayBq4hJ3-GPoWJ6foQ@mail.gmail.com>
 <00a3ba1d-98e1-409b-ae6e-7fbcbdcd74d5@arm.com> <CAGsJ_4xpiyCaNmSK4P3PitKeOsDBmOzf-4AZPnHcv4S=-TmtzQ@mail.gmail.com>
 <f83d30ff-fe31-48c3-9c59-514f39c702f4@arm.com>
In-Reply-To: <f83d30ff-fe31-48c3-9c59-514f39c702f4@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 13 Mar 2024 19:37:11 +0800
Message-ID: <CAGsJ_4yFzCW1s=UGu2yT7Zh75_9awo9+Rwxeu3JHkAm=nEoRRQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:08=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 13/03/2024 10:37, Barry Song wrote:
> > On Wed, Mar 13, 2024 at 10:36=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>
> >> On 13/03/2024 09:16, Barry Song wrote:
> >>> On Wed, Mar 13, 2024 at 10:03=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>
> >>>> On 13/03/2024 07:19, Barry Song wrote:
> >>>>> On Tue, Mar 12, 2024 at 4:01=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>
> >>>>>> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any =
large
> >>>>>> folio that is fully and contiguously mapped in the pageout/cold vm
> >>>>>> range. This change means that large folios will be maintained all =
the
> >>>>>> way to swap storage. This both improves performance during swap-ou=
t, by
> >>>>>> eliding the cost of splitting the folio, and sets us up nicely for
> >>>>>> maintaining the large folio when it is swapped back in (to be cove=
red in
> >>>>>> a separate series).
> >>>>>>
> >>>>>> Folios that are not fully mapped in the target range are still spl=
it,
> >>>>>> but note that behavior is changed so that if the split fails for a=
ny
> >>>>>> reason (folio locked, shared, etc) we now leave it as is and move =
to the
> >>>>>> next pte in the range and continue work on the proceeding folios.
> >>>>>> Previously any failure of this sort would cause the entire operati=
on to
> >>>>>> give up and no folios mapped at higher addresses were paged out or=
 made
> >>>>>> cold. Given large folios are becoming more common, this old behavi=
or
> >>>>>> would have likely lead to wasted opportunities.
> >>>>>>
> >>>>>> While we are at it, change the code that clears young from the pte=
s to
> >>>>>> use ptep_test_and_clear_young(), which is more efficent than
> >>>>>> get_and_clear/modify/set, especially for contpte mappings on arm64=
,
> >>>>>> where the old approach would require unfolding/refolding and the n=
ew
> >>>>>> approach can be done in place.
> >>>>>>
> >>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>
> >>>>> This looks so much better than our initial RFC.
> >>>>> Thank you for your excellent work!
> >>>>
> >>>> Thanks - its a team effort - I had your PoC and David's previous bat=
ching work
> >>>> to use as a template.
> >>>>
> >>>>>
> >>>>>> ---
> >>>>>>  mm/madvise.c | 89 ++++++++++++++++++++++++++++++-----------------=
-----
> >>>>>>  1 file changed, 51 insertions(+), 38 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>>>> index 547dcd1f7a39..56c7ba7bd558 100644
> >>>>>> --- a/mm/madvise.c
> >>>>>> +++ b/mm/madvise.c
> >>>>>> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(p=
md_t *pmd,
> >>>>>>         LIST_HEAD(folio_list);
> >>>>>>         bool pageout_anon_only_filter;
> >>>>>>         unsigned int batch_count =3D 0;
> >>>>>> +       int nr;
> >>>>>>
> >>>>>>         if (fatal_signal_pending(current))
> >>>>>>                 return -EINTR;
> >>>>>> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(p=
md_t *pmd,
> >>>>>>                 return 0;
> >>>>>>         flush_tlb_batched_pending(mm);
> >>>>>>         arch_enter_lazy_mmu_mode();
> >>>>>> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> >>>>>> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) =
{
> >>>>>> +               nr =3D 1;
> >>>>>>                 ptent =3D ptep_get(pte);
> >>>>>>
> >>>>>>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >>>>>> @@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range=
(pmd_t *pmd,
> >>>>>>                         continue;
> >>>>>>
> >>>>>>                 /*
> >>>>>> -                * Creating a THP page is expensive so split it on=
ly if we
> >>>>>> -                * are sure it's worth. Split it if we are only ow=
ner.
> >>>>>> +                * If we encounter a large folio, only split it if=
 it is not
> >>>>>> +                * fully mapped within the range we are operating =
on. Otherwise
> >>>>>> +                * leave it as is so that it can be swapped out wh=
ole. If we
> >>>>>> +                * fail to split a folio, leave it in place and ad=
vance to the
> >>>>>> +                * next pte in the range.
> >>>>>>                  */
> >>>>>>                 if (folio_test_large(folio)) {
> >>>>>> -                       int err;
> >>>>>> -
> >>>>>> -                       if (folio_estimated_sharers(folio) > 1)
> >>>>>> -                               break;
> >>>>>> -                       if (pageout_anon_only_filter && !folio_tes=
t_anon(folio))
> >>>>>> -                               break;
> >>>>>> -                       if (!folio_trylock(folio))
> >>>>>> -                               break;
> >>>>>> -                       folio_get(folio);
> >>>>>> -                       arch_leave_lazy_mmu_mode();
> >>>>>> -                       pte_unmap_unlock(start_pte, ptl);
> >>>>>> -                       start_pte =3D NULL;
> >>>>>> -                       err =3D split_folio(folio);
> >>>>>> -                       folio_unlock(folio);
> >>>>>> -                       folio_put(folio);
> >>>>>> -                       if (err)
> >>>>>> -                               break;
> >>>>>> -                       start_pte =3D pte =3D
> >>>>>> -                               pte_offset_map_lock(mm, pmd, addr,=
 &ptl);
> >>>>>> -                       if (!start_pte)
> >>>>>> -                               break;
> >>>>>> -                       arch_enter_lazy_mmu_mode();
> >>>>>> -                       pte--;
> >>>>>> -                       addr -=3D PAGE_SIZE;
> >>>>>> -                       continue;
> >>>>>> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY=
 |
> >>>>>> +                                               FPB_IGNORE_SOFT_DI=
RTY;
> >>>>>> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> >>>>>> +
> >>>>>> +                       nr =3D folio_pte_batch(folio, addr, pte, p=
tent, max_nr,
> >>>>>> +                                            fpb_flags, NULL);
> >>>>>
> >>>>> I wonder if we have a quick way to avoid folio_pte_batch() if users
> >>>>> are doing madvise() on a portion of a large folio.
> >>>>
> >>>> Good idea. Something like this?:
> >>>>
> >>>>         if (pte_pfn(pte) =3D=3D folio_pfn(folio)
> >>>
> >>> what about
> >>>
> >>> "If (pte_pfn(pte) =3D=3D folio_pfn(folio) && max_nr >=3D nr_pages)"
> >>>
> >>>  just to account for cases where the user's end address falls within
> >>> the middle of a large folio?
> >>
> >> yes, even better. I'll add this for the next version.
> >>
> >>>
> >>>
> >>> BTW, another minor issue is here:
> >>>
> >>>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >>>                         batch_count =3D 0;
> >>>                         if (need_resched()) {
> >>>                                 arch_leave_lazy_mmu_mode();
> >>>                                 pte_unmap_unlock(start_pte, ptl);
> >>>                                 cond_resched();
> >>>                                 goto restart;
> >>>                         }
> >>>                 }
> >>>
> >>> We are increasing 1 for nr ptes, thus, we are holding PTL longer
> >>> than small folios case? we used to increase 1 for each PTE.
> >>> Does it matter?
> >>
> >> I thought about that, but the vast majority of the work is per-folio, =
not
> >> per-pte. So I concluded it would be best to continue to increment per-=
folio.
> >
> > Okay. The original patch commit b2f557a21bc8 ("mm/madvise: add
> > cond_resched() in madvise_cold_or_pageout_pte_range()")
> > primarily addressed the real-time wake-up latency issue. MADV_PAGEOUT
> > and MADV_COLD are much less critical compared
> > to other scenarios where operations like do_anon_page or do_swap_page
> > necessarily need PTL to progress. Therefore, adopting
> > an approach that relatively aggressively releases the PTL seems to
> > neither harm MADV_PAGEOUT/COLD nor disadvantage
> > others.
> >
> > We are slightly increasing the duration of holding the PTL due to the
> > iteration of folio_pte_batch() potentially taking longer than
> > the case of small folios, which do not require it.
>
> If we can't scan all the PTEs in a page table without dropping the PTL
> intermittently we have bigger problems. This all works perfectly fine in =
all the
> other PTE iterators; see zap_pte_range() for example.

I've no doubt about folio_pte_batch(). was just talking about the
original rt issue
it might affect.

>
> > However, compared
> > to operations like folio_isolate_lru() and folio_deactivate(),
> > this increase seems negligible. Recently, we have actually removed
> > ptep_test_and_clear_young() for MADV_PAGEOUT,
> > which should also benefit real-time scenarios. Nonetheless, there is a
> > small risk with large folios, such as 1 MiB mTHP, where
> > we may need to loop 256 times in folio_pte_batch().
>
> As I understand it, RT and THP are mutually exclusive. RT can't handle th=
e extra
> latencies THPs can cause in allocation path, etc. So I don't think you wi=
ll see
> a problem here.

I was actually taking a different approach on the phones as obviously
we have some
UX(user-experience)/UI/audio related tasks which cannot tolerate
allocation latency. with
a TAO-similar optimization(we did it by ext_migratetype for some pageblocks=
), we
actually don't push buddy to do compaction or reclamation for forming
64KiB folio.
We immediately fallback to small folios if a zero-latency 64KiB
allocation can't be
obtained from some kinds of pools - ext_migratetype pageblocks.

>
> >
> > I would vote for increasing 'nr' or maybe max(log2(nr), 1) rather than
> > 1 for two reasons:
> >
> > 1. We are not making MADV_PAGEOUT/COLD worse; in fact, we are
> > improving them by reducing the time taken to put the same
> > number of pages into the reclaim list.
> >
> > 2. MADV_PAGEOUT/COLD scenarios are not urgent compared to others that
> > genuinely require the PTL to progress. Moreover,
> > the majority of time spent on PAGEOUT is actually reclaim_pages().
>
> I understand your logic. But I'd rather optimize for fewer lock acquisiti=
ons for
> the !RT+THP case, since RT+THP is not supported.

Fair enough. I agree we can postpone this until RT and THP become an
available option.
For now, keeping this patch simpler seems to be better.

>
> >
> >>>
> >>>>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_=
nr,
> >>>>                                      fpb_flags, NULL);
> >>>>
> >>>> If we are not mapping the first page of the folio, then it can't be =
a full
> >>>> mapping, so no need to call folio_pte_batch(). Just split it.
> >>>>
> >>>>>
> >>>>>> +
> >>>>>> +                       if (nr < folio_nr_pages(folio)) {
> >>>>>> +                               int err;
> >>>>>> +
> >>>>>> +                               if (folio_estimated_sharers(folio)=
 > 1)
> >>>>>> +                                       continue;
> >>>>>> +                               if (pageout_anon_only_filter && !f=
olio_test_anon(folio))
> >>>>>> +                                       continue;
> >>>>>> +                               if (!folio_trylock(folio))
> >>>>>> +                                       continue;
> >>>>>> +                               folio_get(folio);
> >>>>>> +                               arch_leave_lazy_mmu_mode();
> >>>>>> +                               pte_unmap_unlock(start_pte, ptl);
> >>>>>> +                               start_pte =3D NULL;
> >>>>>> +                               err =3D split_folio(folio);
> >>>>>> +                               folio_unlock(folio);
> >>>>>> +                               folio_put(folio);
> >>>>>> +                               if (err)
> >>>>>> +                                       continue;
> >>>>>> +                               start_pte =3D pte =3D
> >>>>>> +                                       pte_offset_map_lock(mm, pm=
d, addr, &ptl);
> >>>>>> +                               if (!start_pte)
> >>>>>> +                                       break;
> >>>>>> +                               arch_enter_lazy_mmu_mode();
> >>>>>> +                               nr =3D 0;
> >>>>>> +                               continue;
> >>>>>> +                       }
> >>>>>>                 }
> >>>>>>
> >>>>>>                 /*
> >>>>>>                  * Do not interfere with other mappings of this fo=
lio and
> >>>>>> -                * non-LRU folio.
> >>>>>> +                * non-LRU folio. If we have a large folio at this=
 point, we
> >>>>>> +                * know it is fully mapped so if its mapcount is t=
he same as its
> >>>>>> +                * number of pages, it must be exclusive.
> >>>>>>                  */
> >>>>>> -               if (!folio_test_lru(folio) || folio_mapcount(folio=
) !=3D 1)
> >>>>>> +               if (!folio_test_lru(folio) ||
> >>>>>> +                   folio_mapcount(folio) !=3D folio_nr_pages(foli=
o))
> >>>>>>                         continue;
> >>>>>
> >>>>> This looks so perfect and is exactly what I wanted to achieve.
> >>>>>
> >>>>>>
> >>>>>>                 if (pageout_anon_only_filter && !folio_test_anon(f=
olio))
> >>>>>>                         continue;
> >>>>>>
> >>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>>>> -
> >>>>>> -               if (!pageout && pte_young(ptent)) {
> >>>>>> -                       ptent =3D ptep_get_and_clear_full(mm, addr=
, pte,
> >>>>>> -                                                       tlb->fullm=
m);
> >>>>>> -                       ptent =3D pte_mkold(ptent);
> >>>>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>>>> +               if (!pageout) {
> >>>>>> +                       for (; nr !=3D 0; nr--, pte++, addr +=3D P=
AGE_SIZE) {
> >>>>>> +                               if (ptep_test_and_clear_young(vma,=
 addr, pte))
> >>>>>> +                                       tlb_remove_tlb_entry(tlb, =
pte, addr);
> >>>>>> +                       }
> >>>>>
> >>>>> This looks so smart. if it is not pageout, we have increased pte
> >>>>> and addr here; so nr is 0 and we don't need to increase again in
> >>>>> for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >>>>>
> >>>>> otherwise, nr won't be 0. so we will increase addr and
> >>>>> pte by nr.
> >>>>
> >>>> Indeed. I'm hoping that Lance is able to follow a similar pattern fo=
r
> >>>> madvise_free_pte_range().
> >>>>
> >>>>
> >>>>>
> >>>>>
> >>>>>>                 }
> >>>>>>
> >>>>>>                 /*
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>>
> >>>>>
> >>>>> Overall, LGTM,
> >>>>>
> >>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> Thanks!
> >>>>
> >
> > Thanks
> > Barry
>

