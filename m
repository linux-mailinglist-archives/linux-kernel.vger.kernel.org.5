Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5F75BCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGUDk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGUDkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:40:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3AE2729
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:40:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso237966466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689910819; x=1690515619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fWKhpf+MYR9ihAE8ZGQSFtOLqA2Qlrb9gXRTnhKSJw=;
        b=SNsaBwWz2Ha+2HPCKbmCI0FTmfoO2yoqAwp8X84Ni6GSFrSxcBFTh7b1uqe2OwY/fA
         jQ6uKrddDbcHlULo/tzgDupEJrywTVVGUZtC/lfBxaiDZSwa7v0KqpYBd1qVYy9WdhAG
         E2QsUX+JBr0LiASw6PWKl8em12JruFlJCCZvsA+Ww1L9Gi+uEKTKeHUQdw9BAzsL14Tb
         qcxg4cn59H7YEz0MK1MdxQENBTLW9THLdQ5uW5CSwTCNhIT0vz7lSbxuH19h4nYW0TCr
         Lp+K6yBjHfG6mREu6qym1sPdksBbt9Iz0Yg/DzGlgfTIUQO9howQiPirfmHEiF6MPyz1
         X52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689910819; x=1690515619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fWKhpf+MYR9ihAE8ZGQSFtOLqA2Qlrb9gXRTnhKSJw=;
        b=DSHT9zvK/RnkKOAOZMDf/kfWwrXCOIe+mZLGFnkoBNQaOO/UxC8ujdQ+tG9jgXO5fL
         FMD/xpBRIlH8/1u8EYhs3OF+2m572/h6WYT+dUPwV7uvpsHCZZC6dIQtsb1HF4hjra59
         xbXRSkJSvG/O4NfxT40VNbQ+6ZdUrRt91pVBmLXQ09jMmD1Z/fGRvlaMLHP/Cnp4i7wK
         cKMQoHQlG3lqpZnqbuFHLPdOkhKrA5O42NmQ29OARt+jB4z9Rz7Iy/T3vIAtFWCc2jmU
         u++KKWNI3gqLEML7WFCD4SZBLJwDOWoagfomM4CsJgi0QJ8AvtH7j1haXnwS5/xB4/sU
         /JKw==
X-Gm-Message-State: ABy/qLZntbf9wXFt75QHJki88yKXrguOVfuPNt8RZbjBiVGv/GHRqAcI
        Vp22F2wASp5FvjVZt+/kLktUQPjv7uaG6CXFW2KEwP+nsPiK+jEGwOg=
X-Google-Smtp-Source: APBJJlENXUFW8nB+lJPMnmO3Y0bByPlKuB2KPlP2C6Y8m4gZvyE0lvSdOKgvxXF4G0iVx2X5MgHcF0S9KmFISW6zVP4=
X-Received: by 2002:a17:906:5a5d:b0:99b:5a73:4d06 with SMTP id
 my29-20020a1709065a5d00b0099b5a734d06mr610999ejc.20.1689910818761; Thu, 20
 Jul 2023 20:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com> <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com> <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com> <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
 <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com> <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
 <CAJD7tkaMycnAaY-8Gu=kUwbYqDzihP4BQDzCC2M4BTYAKgG6Qg@mail.gmail.com>
 <d2ae87ee-8ee3-0758-a433-8c937e5e3fb5@intel.com> <CAJD7tkbuU9Op_TmUET9N+Mug=AS7N3S16tZifVajVBL0yaYv4w@mail.gmail.com>
 <c8ea2617-df48-a1cf-e910-71eeba353d67@intel.com> <CAJD7tkYH-9YoLMSc4RLd0P4hmMcV4mzko8oijLXNOA_dquHJqA@mail.gmail.com>
 <c9b53e12-80bc-7447-af2e-71920e4179d0@intel.com>
In-Reply-To: <c9b53e12-80bc-7447-af2e-71920e4179d0@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 20:39:42 -0700
Message-ID: <CAJD7tkZJFG=7xs=9otc5CKs6odWu48daUuZP9Wd9Z-sZF07hXg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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

On Thu, Jul 20, 2023 at 8:19=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/21/2023 9:35 AM, Yosry Ahmed wrote:
> > On Thu, Jul 20, 2023 at 6:12=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> >>
> >>
> >>
> >> On 7/21/2023 4:51 AM, Yosry Ahmed wrote:
> >>> On Thu, Jul 20, 2023 at 5:03=E2=80=AFAM Yin, Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/19/2023 11:44 PM, Yosry Ahmed wrote:
> >>>>> On Wed, Jul 19, 2023 at 7:26=E2=80=AFAM Hugh Dickins <hughd@google.=
com> wrote:
> >>>>>>
> >>>>>> On Wed, 19 Jul 2023, Yin Fengwei wrote:
> >>>>>>>>>>>>>>>> Could this also happen against normal 4K page? I mean wh=
en user try to munlock
> >>>>>>>>>>>>>>>> a normal 4K page and this 4K page is isolated. So it bec=
ome unevictable page?
> >>>>>>>>>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_f=
olio() and
> >>>>>>>>>>>>>>> cpu 2 is isolating the folio for any purpose:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> cpu1                        cpu2
> >>>>>>>>>>>>>>>                             isolate folio
> >>>>>>>>>>>>>>> folio_test_clear_lru() // 0
> >>>>>>>>>>>>>>>                             putback folio // add to unevi=
ctable list
> >>>>>>>>>>>>>>> folio_test_clear_mlocked()
> >>>>>>>>>>>>                                folio_set_lru()
> >>>>>>> Let's wait the response from Huge and Yu. :).
> >>>>>>
> >>>>>> I haven't been able to give it enough thought, but I suspect you a=
re right:
> >>>>>> that the current __munlock_folio() is deficient when folio_test_cl=
ear_lru()
> >>>>>> fails.
> >>>>>>
> >>>>>> (Though it has not been reported as a problem in practice: perhaps=
 because
> >>>>>> so few places try to isolate from the unevictable "list".)
> >>>>>>
> >>>>>> I forget what my order of development was, but it's likely that I =
first
> >>>>>> wrote the version for our own internal kernel - which used our ori=
ginal
> >>>>>> lruvec locking, which did not depend on getting PG_lru first (havi=
ng got
> >>>>>> lru_lock, it checked memcg, then tried again if that had changed).
> >>>>>
> >>>>> Right. Just holding the lruvec lock without clearing PG_lru would n=
ot
> >>>>> protect against memcg movement in this case.
> >>>>>
> >>>>>>
> >>>>>> I was uneasy with the PG_lru aspect of upstream lru_lock implement=
ation,
> >>>>>> but it turned out to work okay - elsewhere; but it looks as if I m=
issed
> >>>>>> its implication when adapting __munlock_page() for upstream.
> >>>>>>
> >>>>>> If I were trying to fix this __munlock_folio() race myself (sorry,=
 I'm
> >>>>>> not), I would first look at that aspect: instead of folio_test_cle=
ar_lru()
> >>>>>> behaving always like a trylock, could "folio_wait_clear_lru()" or =
whatever
> >>>>>> spin waiting for PG_lru here?
> >>>>>
> >>>>> +Matthew Wilcox
> >>>>>
> >>>>> It seems to me that before 70dea5346ea3 ("mm/swap: convert lru_add =
to
> >>>>> a folio_batch"), __pagevec_lru_add_fn() (aka lru_add_fn()) used to =
do
> >>>>> folio_set_lru() before checking folio_evictable(). While this is
> >>>>> probably extraneous since folio_batch_move_lru() will set it again
> >>>>> afterwards, it's probably harmless given that the lruvec lock is he=
ld
> >>>>> throughout (so no one can complete the folio isolation anyway), and
> >>>>> given that there were no problems introduced by this extra
> >>>>> folio_set_lru() as far as I can tell.
> >>>> After checking related code, Yes. Looks fine if we move folio_set_lr=
u()
> >>>> before if (folio_evictable(folio)) in lru_add_fn() because of holdin=
g
> >>>> lru lock.
> >>>>
> >>>>>
> >>>>> If we restore folio_set_lru() to lru_add_fn(), and revert 2262ace60=
713
> >>>>> ("mm/munlock:
> >>>>> delete smp_mb() from __pagevec_lru_add_fn()") to restore the strict
> >>>>> ordering between manipulating PG_lru and PG_mlocked, I suppose we c=
an
> >>>>> get away without having to spin. Again, that would only be possible=
 if
> >>>>> reworking mlock_count [1] is acceptable. Otherwise, we can't clear
> >>>>> PG_mlocked before PG_lru in __munlock_folio().
> >>>> What about following change to move mlocked operation before check l=
ru
> >>>> in __munlock_folio()?
> >>>
> >>> It seems correct to me on a high level, but I think there is a subtle=
 problem:
> >>>
> >>> We clear PG_mlocked before trying to isolate to make sure that if
> >>> someone already has the folio isolated they will put it back on an
> >>> evictable list, then if we are able to isolate the folio ourselves an=
d
> >>> find that the mlock_count is > 0, we set PG_mlocked again.
> >>>
> >>> There is a small window where PG_mlocked might be temporarily cleared
> >>> but the folio is not actually munlocked (i.e we don't update the
> >>> NR_MLOCK stat). In that window, a racing reclaimer on a different cpu
> >>> may find VM_LOCKED from in a different vma, and call mlock_folio(). I=
n
> >>> mlock_folio(), we will call folio_test_set_mlocked(folio) and see tha=
t
> >>> PG_mlocked is clear, so we will increment the MLOCK stats, even thoug=
h
> >>> the folio was already mlocked. This can cause MLOCK stats to be
> >>> unbalanced (increments more than decrements), no?
> >> Looks like NR_MLOCK is always connected to PG_mlocked bit. Not possibl=
e
> >> to be unbalanced.
> >>
> >> Let's say:
> >>   mlock_folio()  NR_MLOCK increase and set mlocked
> >>   mlock_folio()  NR_MLOCK NO change as folio is already mlocked
> >>
> >>   __munlock_folio() with isolated folio. NR_MLOCK decrease (0) and
> >>                                          clear mlocked
> >>
> >>   folio_putback_lru()
> >>   reclaimed mlock_folio()  NR_MLOCK increase and set mlocked
> >>
> >>   munlock_folio()  NR_MLOCK decrease (0) and clear mlocked
> >>   munlock_folio()  NR_MLOCK NO change as folio has no mlocked set
> >
> > Right. The problem with the diff is that we temporarily clear
> > PG_mlocked *without* updating NR_MLOCK.
> >
> > Consider a folio that is mlocked by two vmas. NR_MLOCK =3D folio_nr_pag=
es.
> >
> > Assume cpu 1 is doing __munlock_folio from one of the vmas, while cpu
> > 2 is doing reclaim.
> >
> > cpu 1                                        cpu2
> > clear PG_mlocked
> >                                                  folio_referenced()
> >                                                    mlock_folio()
> >                                                      set PG_mlocked
> >                                                        add to NR_MLOCK
> > mlock_count > 0
> > set PG_mlocked
> > goto out
> >
> > Result: NR_MLOCK =3D folio_nr_pages * 2.
> >
> > When the folio is munlock()'d later from the second vma, NR_MLOCK will
> > be reduced to folio_nr_pages, but there are not mlocked folios.
> >
> > This is the scenario that I have in mind. Please correct me if I am wro=
ng.
> Yes. Looks possible even may be difficult to hit.
>
> My first thought was it's not possible because unevictable folio will not
> be picked by reclaimer. But it's possible case if things happen between
> clear_mlock and test_and_clear_lru:
>     folio_putback_lru() by other isolation user like migration
>     reclaimer pick the folio and call mlock_folio()
>     reclaimer call folio
>
> The fixing can be following the rules (combine NR_LOCK with PG_mlocked bi=
t)
> strictly.

Yeah probably. I believe restoring the old ordering of manipulating
PG_lru and PG_mlocked with the memory barrier would be a simpler fix,
but this is only possible if the mlock_count rework gets merged.

>
>
> Regards
> Yin, Fengwei
>
> >
> >>
> >>
> >> Regards
> >> Yin, Fengwei
> >>
> >>>
> >>>>
> >>>> diff --git a/mm/mlock.c b/mm/mlock.c
> >>>> index 0a0c996c5c21..514f0d5bfbfd 100644
> >>>> --- a/mm/mlock.c
> >>>> +++ b/mm/mlock.c
> >>>> @@ -122,7 +122,9 @@ static struct lruvec *__mlock_new_folio(struct f=
olio *folio, struct lruvec *lruv
> >>>>  static struct lruvec *__munlock_folio(struct folio *folio, struct l=
ruvec *lruvec)
> >>>>  {
> >>>>         int nr_pages =3D folio_nr_pages(folio);
> >>>> -       bool isolated =3D false;
> >>>> +       bool isolated =3D false, mlocked =3D true;
> >>>> +
> >>>> +       mlocked =3D folio_test_clear_mlocked(folio);
> >>>>
> >>>>         if (!folio_test_clear_lru(folio))
> >>>>                 goto munlock;
> >>>> @@ -134,13 +136,17 @@ static struct lruvec *__munlock_folio(struct f=
olio *folio, struct lruvec *lruvec
> >>>>                 /* Then mlock_count is maintained, but might underco=
unt */
> >>>>                 if (folio->mlock_count)
> >>>>                         folio->mlock_count--;
> >>>> -               if (folio->mlock_count)
> >>>> +               if (folio->mlock_count) {
> >>>> +                       if (mlocked)
> >>>> +                               folio_set_mlocked(folio);
> >>>>                         goto out;
> >>>> +               }
> >>>>         }
> >>>>         /* else assume that was the last mlock: reclaim will fix it =
if not */
> >>>>
> >>>>  munlock:
> >>>> -       if (folio_test_clear_mlocked(folio)) {
> >>>> +       if (mlocked) {
> >>>>                 __zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
> >>>>                 if (isolated || !folio_test_unevictable(folio))
> >>>>                         __count_vm_events(UNEVICTABLE_PGMUNLOCKED, n=
r_pages);
> >>>>
> >>>>
> >>>>>
> >>>>> I am not saying this is necessarily better than spinning, just a no=
te
> >>>>> (and perhaps selfishly making [1] more appealing ;)).
> >>>>>
> >>>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed=
@google.com/
> >>>>>
> >>>>>>
> >>>>>> Hugh
