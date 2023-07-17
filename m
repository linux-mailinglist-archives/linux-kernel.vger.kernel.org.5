Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1B756926
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGQQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjGQQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:30:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C06F1722
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:29:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403f21d3c2dso192021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689611397; x=1692203397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbeYNfnz8jWi/nxzcYBnRg/O53FAY/0l+xGf/60VJq4=;
        b=iNg0y5UHik6PTw5tTqzzM1OZ3sVQWkF5RazYr18+fPVe12rD97ZxOYHsOBawjYSlNT
         u9l3rNrobP4MMlTldiFRuU01eo9zjrN05kfosfIqBP0wFN9Gas5ENAiNBXUrgwWRihRW
         II5xp8g/qPz4qeJNQ+VcwG2v/Fkf+zZnzUPAF4NqYz3mhN6Tn7QTegi7xeMflrrKv1JH
         W/Guh/M1x0L5Z3K7XTC98Ilo3Qb6ALuaJgTop6D7RvwJzcE9TQWJaTO1I1ir9vjY6rK2
         BeQ0vTsACv7zUJxo71xkRl8TerGRnbLXarBGxWHcDtjFjAsSqTFjJBFURbovDR9pDtPZ
         1WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611397; x=1692203397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbeYNfnz8jWi/nxzcYBnRg/O53FAY/0l+xGf/60VJq4=;
        b=Ox/wAH9e+eWyRzlW+/mR+O/cQtkKhZBI7hZwfIdptrK1PLbhZA121dCRw10tZ6dLZB
         BFBNySrer7cX0SMJj4ib+PNytm5Mu753aw4ztjVpRzzjAjBFIlwYt1r4kND02DuaqxIF
         PsfbrUzuGNayhmilmpPlmUip9kDKkvJhklTfhhg+j6zQsc9Lw6AdfUOhEei4hm+ylAaV
         XwOkK1aO6clDAvEAPlACXcuuNgNhuWX8rQxGUr2r5Pc5BPOIurkqDDS9FSpMqz7nsKim
         UvwhITjbrRt+FcSqRv+3PIf4FCE5wamFSTnb4IfOgef1Rp2sx1aBi994HjTQhzRp+E8L
         +iSg==
X-Gm-Message-State: ABy/qLbi1eNbA9Z94Md3O/Fw1KUI92WQzriDa5KUa/2y2lNbL+acU5qL
        yaiGZFkDqhsIXTTxkTSLT2ArFB6IW5O8YJeqiKIw/Q==
X-Google-Smtp-Source: APBJJlG1+6eKjX0YOpNCtGwodJwcO3myqjLPem3EMPl/avx3O/U/0g2LQcKCKWUqFDr3r+FtaFzDoUXIUWKadgsrCLI=
X-Received: by 2002:ac8:59ce:0:b0:3f8:8c06:c53b with SMTP id
 f14-20020ac859ce000000b003f88c06c53bmr1509542qtf.0.1689611396666; Mon, 17 Jul
 2023 09:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufZBoV-ujMF3v60Sj4bARb5vRg7cpcRsqTiKHB4CKZc_fw@mail.gmail.com>
 <7e09d69e-50a7-04c5-0a40-065e2d6fd658@intel.com> <CAOUHufahGsPLm9LWpTJ75MPa6pY11rFvnoqWM7bQgVGWyWEAAw@mail.gmail.com>
 <bbfc02f4-8d3d-bd6f-aeef-5d7bb3ff46f7@intel.com>
In-Reply-To: <bbfc02f4-8d3d-bd6f-aeef-5d7bb3ff46f7@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 17 Jul 2023 10:29:20 -0600
Message-ID: <CAOUHufYGVW3ojHUmPcsee5okreuWBdFVcSHLKPBTW-tpr3U52A@mail.gmail.com>
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
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

On Sun, Jul 16, 2023 at 5:52=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
> On 7/14/2023 11:41 PM, Yu Zhao wrote:
> > On Thu, Jul 13, 2023 at 11:57=E2=80=AFPM Yin, Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>
> >>
> >>>> -               if (pageout_anon_only_filter && !folio_test_anon(fol=
io))
> >>>> +               /* Do not interfere with other mappings of this foli=
o */
> >>>> +               if (folio_mapcount(folio) !=3D 1)
> >>>>                         continue;
> >>>>
> >>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>> -
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
> >>>> -               /*
> >>>> -                * We are deactivating a folio for accelerating recl=
aiming.
> >>>> -                * VM couldn't reclaim the folio unless we clear PG_=
young.
> >>>> -                * As a side effect, it makes confuse idle-page trac=
king
> >>>> -                * because they will miss recent referenced history.
> >>>> -                */
> >>>> -               folio_clear_referenced(folio);
> >>>> -               folio_test_clear_young(folio);
> >>>> -               if (folio_test_active(folio))
> >>>> -                       folio_set_workingset(folio);
> >>>> +pageout_cold_folio:
> >>>>                 if (pageout) {
> >>>>                         if (folio_isolate_lru(folio)) {
> >>>>                                 if (folio_test_unevictable(folio))
> >>>> @@ -529,8 +542,30 @@ static int madvise_cold_or_pageout_pte_range(pm=
d_t *pmd,
> >>>>                 arch_leave_lazy_mmu_mode();
> >>>>                 pte_unmap_unlock(start_pte, ptl);
> >>>>         }
> >>>> -       if (pageout)
> >>>> -               reclaim_pages(&folio_list);
> >>>> +
> >>>> +       if (pageout) {
> >>>> +               LIST_HEAD(reclaim_list);
> >>>> +
> >>>> +               while (!list_empty(&folio_list)) {
> >>>> +                       int refs;
> >>>> +                       unsigned long flags;
> >>>> +                       struct mem_cgroup *memcg =3D folio_memcg(fol=
io);
> >>>> +
> >>>> +                       folio =3D lru_to_folio(&folio_list);
> >>>> +                       list_del(&folio->lru);
> >>>> +
> >>>> +                       refs =3D folio_referenced(folio, 0, memcg, &=
flags);
> >>>> +
> >>>> +                       if ((flags & VM_LOCKED) || (refs =3D=3D -1))=
 {
> >>>> +                               folio_putback_lru(folio);
> >>>> +                               continue;
> >>>> +                       }
> >>>> +
> >>>> +                       folio_test_clear_referenced(folio);
> >>>> +                       list_add(&folio->lru, &reclaim_list);
> >>>> +               }
> >>>> +               reclaim_pages(&reclaim_list);
> >>>> +       }
> >>>
> >>> i overlooked the chunk above -- it's unnecessary: after we split the
> >>> large folio (and splice the base folios onto the same LRU list), we
> >>> continue at the position of the first base folio because of:
> >>>
> >>>   pte--;
> >>>   addr -=3D PAGE_SIZE;
> >>>   continue;
> >>>
> >>> And then we do pte_mkold(), which takes care of the A-bit.
> >> This patch moves the A-bit clear out of the folio isolation loop. So
> >> even the folio is split and loop restarts from the first base folio,
> >> the A-bit is not cleared. A-bit is only cleared in reclaim loop.
> >>
> >> There is one option for A-bit clearing:
> >>   - clear A-bit of base 4K page in isolation loop and leave large foli=
o
> >>     A-bit clearing to reclaim loop.
> >>
> >> This patch didn't use it because don't want to introduce A-bit clearin=
g
> >> in two places. But I am open about clearing base 4K page A-bit cleared=
 in
> >> isolation loop. Thanks.
> >
> > Sorry but why are we trying to do multiple things in one patch that I
> > assumed is supposed to simply fix madvise() for large anon folios? And
> > none of those things seems to have a clear rationale behind it.
> >
> > The only patch that makes sense at the moment (or the first patch of a
> > series) is what I said before:
> >
> > -  if (folio_mapcount(folio) !=3D 1)
> > +  if (folio_estimated_sharers(folio) !=3D 1)
> Definitely. As I replied to you, I will split the patch to two parts:
>   - just bug fixing. Include the filio_mapcount() -> folio_estimated_shar=
es().

I'm onboard with this fix.

>     And using ptep_clear_flush_young_notify() to clear the young of PTEs.

This is another fix (if it's a real problem), hence a separate patch.

>   - refactor for large folio.

Minchan will look at the last two.

> Let me know if this is OK. Thanks.

SGTM. Thanks.
