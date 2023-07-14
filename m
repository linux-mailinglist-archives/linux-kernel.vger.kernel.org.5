Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ECF753F31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjGNPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:42:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB93595
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:42:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so289571cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689349350; x=1691941350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUOclPqGS2aQ6MHj235Yhr7TmUiRO+nl0WDWI9QQ9Ws=;
        b=R34y9LvmWd8rhM/1V9nkkjg7dc4EbbBQIQCNU6+5KsYOXG/DMWLF69QlmALeS5D6wH
         0PX8pyRIWNpciGpwEWqGvzW9vY7Z0vTOKQESvbp/MItD9+H2bzL4cKu75ZzhWvvf77Se
         vxz09dvSRDM8Kqqx8iiUYEfgDWvL/sXee1HYiuVq/rsaXjwLeHlZZAI9ahhxUox0OEZy
         4pwct57RG0yOC0yRl9OXfjet3OFWr3rKwoYP/LhZRna51q/PejsVhTO4tcIctdWTlgGu
         nCV6Hq5VaU4dYwE74Ts0QOufTfTtZJ/L85kg3MSxloFFTTxelXstkm99FN2xQUpKSlOx
         LkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689349350; x=1691941350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUOclPqGS2aQ6MHj235Yhr7TmUiRO+nl0WDWI9QQ9Ws=;
        b=OPthOM+6TSyQdhLreEPhHmDe1S9FMwlcNaJkKEb1eed+meKWW356v5NO3ggES7kS9z
         waMDItpyvCmC8j9cGEPpdqGVJ8AYy3xz2dNVvz+eMzs31hka8HjBSCryOIoQRVwbZrX7
         CUVSWoxu2+QZ+rzf2d2zH8ifHneTyrN01m87u/RRcEX1y+nsIJUlO23Xm9Bwh2gN5lWV
         UoNvuaOhIrp1phv54BwAH6OEBXtLiR/MJNIa5m62PpbavqtdXQ9LsjwO+gRx3MEKgSlw
         teDXAESs9qcD8psH7BUXwgt4m9geQO39PwokLN7c4JcDvTZPvxNJcYGuNVw1B+e1upRN
         Yj7A==
X-Gm-Message-State: ABy/qLYjqxzZtsrZuVisQDE4Kgo6ivE12cgdmAtA950NFCO/Cfyt+QYV
        n0I/X2Qkev75amAvoLZ/AsQveQBs8nMvswPfWO/bnw==
X-Google-Smtp-Source: APBJJlEJsh2YD+PQahW32JWtx8xYtJjW7rkcxNtKBRVndaAtXeaf+VjmDByFoLPYlc/KRUSgYAcLVY7E+tkiwu0mRCY=
X-Received: by 2002:a05:622a:38a:b0:3f5:2006:50f1 with SMTP id
 j10-20020a05622a038a00b003f5200650f1mr866730qtx.12.1689349350222; Fri, 14 Jul
 2023 08:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufZBoV-ujMF3v60Sj4bARb5vRg7cpcRsqTiKHB4CKZc_fw@mail.gmail.com> <7e09d69e-50a7-04c5-0a40-065e2d6fd658@intel.com>
In-Reply-To: <7e09d69e-50a7-04c5-0a40-065e2d6fd658@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 09:41:54 -0600
Message-ID: <CAOUHufahGsPLm9LWpTJ75MPa6pY11rFvnoqWM7bQgVGWyWEAAw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:57=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.co=
m> wrote:
>
>
> >> -               if (pageout_anon_only_filter && !folio_test_anon(folio=
))
> >> +               /* Do not interfere with other mappings of this folio =
*/
> >> +               if (folio_mapcount(folio) !=3D 1)
> >>                         continue;
> >>
> >> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >> -
> >> -               if (pte_young(ptent)) {
> >> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pt=
e,
> >> -                                                       tlb->fullmm);
> >> -                       ptent =3D pte_mkold(ptent);
> >> -                       set_pte_at(mm, addr, pte, ptent);
> >> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >> -               }
> >> -
> >> -               /*
> >> -                * We are deactivating a folio for accelerating reclai=
ming.
> >> -                * VM couldn't reclaim the folio unless we clear PG_yo=
ung.
> >> -                * As a side effect, it makes confuse idle-page tracki=
ng
> >> -                * because they will miss recent referenced history.
> >> -                */
> >> -               folio_clear_referenced(folio);
> >> -               folio_test_clear_young(folio);
> >> -               if (folio_test_active(folio))
> >> -                       folio_set_workingset(folio);
> >> +pageout_cold_folio:
> >>                 if (pageout) {
> >>                         if (folio_isolate_lru(folio)) {
> >>                                 if (folio_test_unevictable(folio))
> >> @@ -529,8 +542,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >>                 arch_leave_lazy_mmu_mode();
> >>                 pte_unmap_unlock(start_pte, ptl);
> >>         }
> >> -       if (pageout)
> >> -               reclaim_pages(&folio_list);
> >> +
> >> +       if (pageout) {
> >> +               LIST_HEAD(reclaim_list);
> >> +
> >> +               while (!list_empty(&folio_list)) {
> >> +                       int refs;
> >> +                       unsigned long flags;
> >> +                       struct mem_cgroup *memcg =3D folio_memcg(folio=
);
> >> +
> >> +                       folio =3D lru_to_folio(&folio_list);
> >> +                       list_del(&folio->lru);
> >> +
> >> +                       refs =3D folio_referenced(folio, 0, memcg, &fl=
ags);
> >> +
> >> +                       if ((flags & VM_LOCKED) || (refs =3D=3D -1)) {
> >> +                               folio_putback_lru(folio);
> >> +                               continue;
> >> +                       }
> >> +
> >> +                       folio_test_clear_referenced(folio);
> >> +                       list_add(&folio->lru, &reclaim_list);
> >> +               }
> >> +               reclaim_pages(&reclaim_list);
> >> +       }
> >
> > i overlooked the chunk above -- it's unnecessary: after we split the
> > large folio (and splice the base folios onto the same LRU list), we
> > continue at the position of the first base folio because of:
> >
> >   pte--;
> >   addr -=3D PAGE_SIZE;
> >   continue;
> >
> > And then we do pte_mkold(), which takes care of the A-bit.
> This patch moves the A-bit clear out of the folio isolation loop. So
> even the folio is split and loop restarts from the first base folio,
> the A-bit is not cleared. A-bit is only cleared in reclaim loop.
>
> There is one option for A-bit clearing:
>   - clear A-bit of base 4K page in isolation loop and leave large folio
>     A-bit clearing to reclaim loop.
>
> This patch didn't use it because don't want to introduce A-bit clearing
> in two places. But I am open about clearing base 4K page A-bit cleared in
> isolation loop. Thanks.

Sorry but why are we trying to do multiple things in one patch that I
assumed is supposed to simply fix madvise() for large anon folios? And
none of those things seems to have a clear rationale behind it.

The only patch that makes sense at the moment (or the first patch of a
series) is what I said before:

-  if (folio_mapcount(folio) !=3D 1)
+  if (folio_estimated_sharers(folio) !=3D 1)

And probably clarify (preferrably in the comments above) this is an
estimate because we think it's a better tradeoff if we do so (less
code/overhead from checking the mapcounts of the rest of folios within
the range).
