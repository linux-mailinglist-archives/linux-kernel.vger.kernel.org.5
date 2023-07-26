Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771776293F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGZD1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZD1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:27:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869772682
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:27:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so208751cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690342050; x=1690946850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6xj4wxFn0rypQoF1PGqlJBlsHAu3fI3DlYhEQlJySM=;
        b=MC43VpmA9s5GMATDplIXFmcJYSGXim3w1RXDdeAWzYf1BVnVkWEdmq8neZAzx9h9uI
         afOsinbCBFeIWwnJJZzGKH3JQ62MWlvCycZ1KpNTTBmbfokMx0qjNFrj58EsvO1Fk1Wy
         Oyejq9HJZ3XwSq3YEkPetcQcLkPqPe4yKyHsA1XK1pWD10eK4V+vfq7k53UGGMqJ9yh1
         Gt8IidEtFQtMrs4G30Hb204rwjBIzzvJuMgflkzScapjW3QnXxb9BMe3jnoVjq5ScV+n
         bUwjgZQQ4xeq62+1s49FMyEQF0aRBqShRZ7CZ4BBqqaWXlm6ONAt/hyFirDqEk7g5cqO
         Fdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690342050; x=1690946850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6xj4wxFn0rypQoF1PGqlJBlsHAu3fI3DlYhEQlJySM=;
        b=H5RscIkmR8lgqg4mWNybNoOyiCDQYFziXnGhl8GZ2LXc+ZcDCm9Ds9mw4sTr72dGQi
         Q8LI5LV5fvM8hEnsRSdFOpR2a33YtHWZJcQsbtcIbWiLem55WaaGaCWbHACM6e5zAMr2
         hJZphB1M2vi9Y3p9hVoaviwjUkuiDC3o3R1fEJoFLV+Mco/jTPTSWDMI49T0QmwXgAzP
         hOpNmcFGPvjgqV4r5s4FPHq5jXwAZfHxDEmd1A8794Ij46oFYqvEAxrra6oGM53J6uFc
         uzG+a2Lemds75hXQVI3iU+v3nqdDMwua3VzSANjMMWpxZMR9zBCKXTLhwGbR0sAV9kJB
         UvZQ==
X-Gm-Message-State: ABy/qLadlBtdI8OM5jpEuR0quuLl9pOKvsbqeK/pJXmgh8rD5wFR0JYU
        411SkyM3bm06SoVFsBviITVT5SUnF+rLfJpq7/uCEg==
X-Google-Smtp-Source: APBJJlFdoxX78Vk/RXp8V+I4N+9q9PbH0elQr7zNdlT4hfEMCNNjyi+LpianjrSduzy/W259yQruvpYdAXsXV30pwCg=
X-Received: by 2002:ac8:7d55:0:b0:403:f3f5:1a8 with SMTP id
 h21-20020ac87d55000000b00403f3f501a8mr412509qtb.12.1690342050506; Tue, 25 Jul
 2023 20:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-3-fengwei.yin@intel.com> <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
 <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com>
In-Reply-To: <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 25 Jul 2023 21:26:54 -0600
Message-ID: <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
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

On Tue, Jul 25, 2023 at 8:49=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
> On 7/25/23 13:55, Yu Zhao wrote:
> > On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> Currently, in function madvise_cold_or_pageout_pte_range(), the
> >> young bit of pte/pmd is cleared notify subscripter.
> >>
> >> Using notify-able API to make sure the subscripter is signaled about
> >> the young bit clearing.
> >>
> >> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >> ---
> >>  mm/madvise.c | 18 ++----------------
> >>  1 file changed, 2 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index f12933ebcc24..b236e201a738 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >>                         return 0;
> >>                 }
> >>
> >> -               if (pmd_young(orig_pmd)) {
> >> -                       pmdp_invalidate(vma, addr, pmd);
> >> -                       orig_pmd =3D pmd_mkold(orig_pmd);
> >> -
> >> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
> >> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> >> -               }
> >> -
> >> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
> >>                 folio_clear_referenced(folio);
> >>                 folio_test_clear_young(folio);
> >>                 if (folio_test_active(folio))
> >> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >>
> >>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>
> >> -               if (pte_young(ptent)) {
> >> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pt=
e,
> >> -                                                       tlb->fullmm);
> >> -                       ptent =3D pte_mkold(ptent);
> >> -                       set_pte_at(mm, addr, pte, ptent);
> >> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >> -               }
> >> -
> >> +               ptep_clear_flush_young_notify(vma, addr, pte);
> >
> > These two places are tricky.
> >
> > I agree there is a problem here, i.e., we are not consulting the mmu
> > notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
> > known problem to me for a while (not a high priority one).
> >
> > tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
> > not. But, on x86, we might see a performance improvement since
> > ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there might
> > be regressions though.
> >
> > I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
> > prefers flush. So I'll let him chime in.
> I am OK with either way even no flush way here is more efficient for
> arm64. Let's wait for Minchan's comment.

Yes, and I don't think there would be any "negative" consequences
without tlb flushes when clearing the A-bit.

> > If we do end up with ptep_clear_young_notify(), please remove
> > mmu_gather -- it should have been done in this patch.
>
> I suppose "remove mmu_gather" means to trigger flush tlb operation in
> batched way to make sure no stale data in TLB for long time on arm64
> platform.

In madvise_cold_or_pageout_pte_range(), we only need struct
mmu_gather *tlb because of tlb_remove_pmd_tlb_entry(), i.e., flushing
tlb after clearing the A-bit. There is no correction, e.g., potential
data corruption, involved there.
