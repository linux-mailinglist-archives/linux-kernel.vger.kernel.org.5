Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA2764459
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjG0D3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjG0D3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:29:30 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E801BF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:29:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40631c5b9e9so105001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690428568; x=1691033368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR/aQf8pqvQCFkWUb4QSR05Ljl1WefLU+jERptRur3s=;
        b=6VJzOsbIAYsiIIZqk8CErimyT8lGuAE11I/fcrZV2DEC3YRi27OMEhvT9FJVCtmIFJ
         zQt6yprsDWDi5PdSqY6+jhePkHVM81URbCd/x2yARUxP3AGfQKta1IqGG2SjaYxHscpQ
         xHjHoUVGrlg8O6k7XJuPgiOVjm6HCx2myycweW0ZfL9Sc92IGJcN9iAVNU2qlcOLiM5v
         Vj51dmIcHcx4c9HrnkXG7jraqzICDhmGIU4K1rmb7GjxMHhnE/1KSZIkc7DZCmGsyOWO
         jnXOHFiuLv+m3YzFEFmPUMcwPpG2iMgvCDvi7SFzqsIO8C+zUcchauC38jXo8+63+xRv
         toww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690428568; x=1691033368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UR/aQf8pqvQCFkWUb4QSR05Ljl1WefLU+jERptRur3s=;
        b=fiTiKneMeeuqpz7+JeEQ1GCMd9a3X5z8D7TDUQhWwxqNlqaxbAuOw/4R6w5lFxiO1B
         wN6dRfZ62gmt1O2e5Jdg8tru3+nvq5wOLtwINwvhju01LuNX4wI0RYG73sUn4rl1Z05y
         rAos5yw27fkekod+sxYd3ui9y3r+7vQIoifXDtTgcSJ1jy7NtZ75Q+6Pu1T/OqJOl/CN
         Xvu7avfghB/pMmp2tPjBjUktR4KC4Bhl3cz1yT6SzWoUmsWxIBQp+C8rDU7MLCNUlgG5
         YQ218AMktHchBQASEVAg+q9BtHHxt1SGXqo09tKP+EWvTePJ6V4cz+y5ArpjedhRuZJF
         bWKw==
X-Gm-Message-State: ABy/qLbsY7NRPm3QlEcAX9tf0CxT3jyPy/Mhu0/lyMXV8Ym+4GUquM6P
        IDsfJs8LhExOzr0sDCA0tos9ceAPffkP2Mlx74SCVQ==
X-Google-Smtp-Source: APBJJlH1hADbkX3AZtozELz5dTYwcP5hurIMd+CUwoyThEbw36gzKuxHDm49vv/xeg7dq5lSs/Bxy/SPutrN1GAE6KA=
X-Received: by 2002:ac8:7d0c:0:b0:405:3a65:b3d6 with SMTP id
 g12-20020ac87d0c000000b004053a65b3d6mr87323qtb.13.1690428568042; Wed, 26 Jul
 2023 20:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-3-fengwei.yin@intel.com> <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
 <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com> <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
 <feb58221-e481-3d71-8707-6ffe90158b66@intel.com> <CAOUHufa9rFS-VjbCRG6KGjb4YKOZioH=dLdTyFLWqEFePoL+wQ@mail.gmail.com>
 <0843fb4d-ab0b-2766-281c-ef32b6031dd7@intel.com>
In-Reply-To: <0843fb4d-ab0b-2766-281c-ef32b6031dd7@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 26 Jul 2023 21:28:52 -0600
Message-ID: <CAOUHufaZCCVr1C19tZH=+wmWN7pPoJMLuivr=e90Akj29X1evw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] madvise: Use notify-able API to clear and
 flush page table entries
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:21=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
> On 7/26/23 13:40, Yu Zhao wrote:
> > On Tue, Jul 25, 2023 at 10:44=E2=80=AFPM Yin Fengwei <fengwei.yin@intel=
.com> wrote:
> >>
> >>
> >> On 7/26/23 11:26, Yu Zhao wrote:
> >>> On Tue, Jul 25, 2023 at 8:49=E2=80=AFPM Yin Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>>
> >>>>
> >>>> On 7/25/23 13:55, Yu Zhao wrote:
> >>>>> On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@in=
tel.com> wrote:
> >>>>>>
> >>>>>> Currently, in function madvise_cold_or_pageout_pte_range(), the
> >>>>>> young bit of pte/pmd is cleared notify subscripter.
> >>>>>>
> >>>>>> Using notify-able API to make sure the subscripter is signaled abo=
ut
> >>>>>> the young bit clearing.
> >>>>>>
> >>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >>>>>> ---
> >>>>>>  mm/madvise.c | 18 ++----------------
> >>>>>>  1 file changed, 2 insertions(+), 16 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>>>> index f12933ebcc24..b236e201a738 100644
> >>>>>> --- a/mm/madvise.c
> >>>>>> +++ b/mm/madvise.c
> >>>>>> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(=
pmd_t *pmd,
> >>>>>>                         return 0;
> >>>>>>                 }
> >>>>>>
> >>>>>> -               if (pmd_young(orig_pmd)) {
> >>>>>> -                       pmdp_invalidate(vma, addr, pmd);
> >>>>>> -                       orig_pmd =3D pmd_mkold(orig_pmd);
> >>>>>> -
> >>>>>> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
> >>>>>> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> >>>>>> -               }
> >>>>>> -
> >>>>>> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
> >>>>>>                 folio_clear_referenced(folio);
> >>>>>>                 folio_test_clear_young(folio);
> >>>>>>                 if (folio_test_active(folio))
> >>>>>> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(=
pmd_t *pmd,
> >>>>>>
> >>>>>>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>>>>
> >>>>>> -               if (pte_young(ptent)) {
> >>>>>> -                       ptent =3D ptep_get_and_clear_full(mm, addr=
, pte,
> >>>>>> -                                                       tlb->fullm=
m);
> >>>>>> -                       ptent =3D pte_mkold(ptent);
> >>>>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>>>> -               }
> >>>>>> -
> >>>>>> +               ptep_clear_flush_young_notify(vma, addr, pte);
> >>>>>
> >>>>> These two places are tricky.
> >>>>>
> >>>>> I agree there is a problem here, i.e., we are not consulting the mm=
u
> >>>>> notifier. In fact, we do pageout on VMs on ChromeOS, and it's been =
a
> >>>>> known problem to me for a while (not a high priority one).
> >>>>>
> >>>>> tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() i=
s
> >>>>> not. But, on x86, we might see a performance improvement since
> >>>>> ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there mi=
ght
> >>>>> be regressions though.
> >>>>>
> >>>>> I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned =
he
> >>>>> prefers flush. So I'll let him chime in.
> >>>> I am OK with either way even no flush way here is more efficient for
> >>>> arm64. Let's wait for Minchan's comment.
> >>>
> >>> Yes, and I don't think there would be any "negative" consequences
> >>> without tlb flushes when clearing the A-bit.
> >>>
> >>>>> If we do end up with ptep_clear_young_notify(), please remove
> >>>>> mmu_gather -- it should have been done in this patch.
> >>>>
> >>>> I suppose "remove mmu_gather" means to trigger flush tlb operation i=
n
> >>>> batched way to make sure no stale data in TLB for long time on arm64
> >>>> platform.
> >>>
> >>> In madvise_cold_or_pageout_pte_range(), we only need struct
> >>> mmu_gather *tlb because of tlb_remove_pmd_tlb_entry(), i.e., flushing
> >>> tlb after clearing the A-bit. There is no correction, e.g., potential
> >>> data corruption, involved there.
> >>
> >> From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
> >> the reason that arm64 didn't drop whole flush tlb in ptep_clear_flush_=
young()
> >> is to prevent the stale data in TLB. I suppose there is no correction =
issue
> >> there also.
> >>
> >> So why keep stale data in TLB in madvise_cold_or_pageout_pte_range() i=
s fine?
> >
> > Sorry, I'm not sure I understand your question here.
> Oh. Sorry for the confusion. I will explain my understanding and
> question in detail.
>
> >
> > In this patch, you removed tlb_remove_tlb_entry(), so we don't need
> > struct mmu_gather *tlb any more.
> Yes. You are right.
>
> >
> > If you are asking why I prefer ptep_clear_young_notify() (no flush),
> > which also doesn't need tlb_remove_tlb_entry(), then the answer is
> > that the TLB size doesn't scale like DRAM does: the gap has been
> > growing exponentially. So there is no way TLB can hold stale entries
> > long enough to cause a measurable effect on the A-bit. This isn't a
> > conjecture -- it's been proven conversely: we encountered bugs (almost
> > every year) caused by missing TLB flushes and resulting in data
> > corruption. They were never easy to reproduce, meaning stale entries
> > never stayed long in TLB.
>
> when I read https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
>
> my understanding is that arm64 still keep something in ptep_clear_flush_y=
oung.
> The reason is finishing TLB flush by next context-switch to make sure no
> stale entries in TLB cross next context switch.
>
> Should we still keep same behavior (no stable entries in TLB cross next
> context switch) for madvise_cold_or_pageout_pte_range()?
>
> So two versions work (I assume we should keep same behavior) for me:
>   1. using xxx_flush_xxx() version. but with possible regression on arm64=
.
>   2. using none flush version. But do batched TLB flush.

I see. I don't think we need to flush at all, i.e., the no flush
version *without* batched TLB flush. So far nobody can actually prove
that flushing TLB while clearing the A-bit is beneficial, not even in
theory :)
