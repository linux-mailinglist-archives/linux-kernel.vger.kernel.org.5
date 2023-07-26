Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7D762AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjGZFlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGZFlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:41:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA710CB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:41:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40540a8a3bbso158641cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690350093; x=1690954893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vB3ZsOk9cBST7fTSWJNjOBqYs2YpfH524LGGeQPGGI=;
        b=UHzaH3GMBlUN53PXMgiPoDwHZvBsNNsXvdAXb1Ekxe6UUmqyn7kMSP90Lzj6GFrH/P
         Y0MI9lNMzk9XywbShvsxGRsiQ5et4/rn9WQcy5TyHqtJpoPfUzVGSsidg2FLy6xQy5kS
         A6WCbsca1dyj0G2yTj4GJVY4w5Ix+Erg92OuC8cFyi5vhuMGEulFcnpFUFDOfuDxfzEt
         wfVM9TLPOz5GpESsZtAcHne/Z3ervD77SSsoz52/AxGzJJ4rr9UrwtwJvaSgJDcAj/y+
         lNuopdHog6PPBtDPCt4wU00ZSdn1mn6x7jcvW79M0d7uqetC4LF9llDAMC6Q/izdCsFa
         sydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690350093; x=1690954893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vB3ZsOk9cBST7fTSWJNjOBqYs2YpfH524LGGeQPGGI=;
        b=S5SQaDlofkLjtRTAaHFZ/pA64O9FtUKTHTxEhSl5YNvQBH6sfOiyow7EF386VMFQSE
         V2qzn17eq6M8V2BjwgtqrmlNzRmxBRXRBHRcHbMo1mPJuuFyuOFF1qOwJpheqpg/d00z
         Ww74VQMPp4r2WZ3d1l/k9nv6IwsCh/IR/KSzQRSDnYK0Gdbo9Sz3YQeJGrOEKfFTKzy/
         Q0Evgq1O0xxSILLpE7bw5ndQLiFeyfNCm5f7/jeUUpgGx7l2pSX2BWnrW/unW6UCmYBi
         3c3AkJ8cZkbqsG9eB+Ln3tOm/cxIQi/Dw3S5n+K6VzI3flcv1VUk+HoEWFPrrIjNI0Se
         hU1g==
X-Gm-Message-State: ABy/qLZiuVh8RQ5D32bPfiKI1gtCbPm78GMSeZUOFaMCXR6AcKylDhot
        hZxQoOj1kOiNq9Kw+N/LI5vmkxUo9ZVS63Cn/rdtyw==
X-Google-Smtp-Source: APBJJlEj+qdOhXPl2y8FC9vEJhkxeCPvWBDORu6ehn7BGavUlsMyMd3oTqBekQxBjtl/mHLHK4C/W3zyH0YTgme3mCo=
X-Received: by 2002:a05:622a:1756:b0:3f8:e0a:3e66 with SMTP id
 l22-20020a05622a175600b003f80e0a3e66mr369800qtk.3.1690350092955; Tue, 25 Jul
 2023 22:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-3-fengwei.yin@intel.com> <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
 <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com> <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
 <feb58221-e481-3d71-8707-6ffe90158b66@intel.com>
In-Reply-To: <feb58221-e481-3d71-8707-6ffe90158b66@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 25 Jul 2023 23:40:56 -0600
Message-ID: <CAOUHufa9rFS-VjbCRG6KGjb4YKOZioH=dLdTyFLWqEFePoL+wQ@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:44=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/26/23 11:26, Yu Zhao wrote:
> > On Tue, Jul 25, 2023 at 8:49=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >>
> >> On 7/25/23 13:55, Yu Zhao wrote:
> >>> On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>>
> >>>> Currently, in function madvise_cold_or_pageout_pte_range(), the
> >>>> young bit of pte/pmd is cleared notify subscripter.
> >>>>
> >>>> Using notify-able API to make sure the subscripter is signaled about
> >>>> the young bit clearing.
> >>>>
> >>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >>>> ---
> >>>>  mm/madvise.c | 18 ++----------------
> >>>>  1 file changed, 2 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>> index f12933ebcc24..b236e201a738 100644
> >>>> --- a/mm/madvise.c
> >>>> +++ b/mm/madvise.c
> >>>> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pm=
d_t *pmd,
> >>>>                         return 0;
> >>>>                 }
> >>>>
> >>>> -               if (pmd_young(orig_pmd)) {
> >>>> -                       pmdp_invalidate(vma, addr, pmd);
> >>>> -                       orig_pmd =3D pmd_mkold(orig_pmd);
> >>>> -
> >>>> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
> >>>> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> >>>> -               }
> >>>> -
> >>>> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
> >>>>                 folio_clear_referenced(folio);
> >>>>                 folio_test_clear_young(folio);
> >>>>                 if (folio_test_active(folio))
> >>>> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pm=
d_t *pmd,
> >>>>
> >>>>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>>
> >>>> -               if (pte_young(ptent)) {
> >>>> -                       ptent =3D ptep_get_and_clear_full(mm, addr, =
pte,
> >>>> -                                                       tlb->fullmm)=
;
> >>>> -                       ptent =3D pte_mkold(ptent);
> >>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>> -               }
> >>>> -
> >>>> +               ptep_clear_flush_young_notify(vma, addr, pte);
> >>>
> >>> These two places are tricky.
> >>>
> >>> I agree there is a problem here, i.e., we are not consulting the mmu
> >>> notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
> >>> known problem to me for a while (not a high priority one).
> >>>
> >>> tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
> >>> not. But, on x86, we might see a performance improvement since
> >>> ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there migh=
t
> >>> be regressions though.
> >>>
> >>> I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
> >>> prefers flush. So I'll let him chime in.
> >> I am OK with either way even no flush way here is more efficient for
> >> arm64. Let's wait for Minchan's comment.
> >
> > Yes, and I don't think there would be any "negative" consequences
> > without tlb flushes when clearing the A-bit.
> >
> >>> If we do end up with ptep_clear_young_notify(), please remove
> >>> mmu_gather -- it should have been done in this patch.
> >>
> >> I suppose "remove mmu_gather" means to trigger flush tlb operation in
> >> batched way to make sure no stale data in TLB for long time on arm64
> >> platform.
> >
> > In madvise_cold_or_pageout_pte_range(), we only need struct
> > mmu_gather *tlb because of tlb_remove_pmd_tlb_entry(), i.e., flushing
> > tlb after clearing the A-bit. There is no correction, e.g., potential
> > data corruption, involved there.
>
> From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
> the reason that arm64 didn't drop whole flush tlb in ptep_clear_flush_you=
ng()
> is to prevent the stale data in TLB. I suppose there is no correction iss=
ue
> there also.
>
> So why keep stale data in TLB in madvise_cold_or_pageout_pte_range() is f=
ine?

Sorry, I'm not sure I understand your question here.

In this patch, you removed tlb_remove_tlb_entry(), so we don't need
struct mmu_gather *tlb any more.

If you are asking why I prefer ptep_clear_young_notify() (no flush),
which also doesn't need tlb_remove_tlb_entry(), then the answer is
that the TLB size doesn't scale like DRAM does: the gap has been
growing exponentially. So there is no way TLB can hold stale entries
long enough to cause a measurable effect on the A-bit. This isn't a
conjecture -- it's been proven conversely: we encountered bugs (almost
every year) caused by missing TLB flushes and resulting in data
corruption. They were never easy to reproduce, meaning stale entries
never stayed long in TLB.
