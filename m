Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A019758B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGSCXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSCXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:23:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369A127
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:23:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992e22c09edso767927466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689733412; x=1692325412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spyr4XDuSVVg1JGaqXQzVfB+T48wUUZI+CE5XyVeOog=;
        b=NSYhkFwGJyGXA8kXMuIaaP59GXVbd9Z9T483G8QqAEOdktap7SyHAsTJniJgWnQvGn
         TTBE+UOyJyTj0DPAe/IPgaVxw20aX1pVBPzRSsvw4fZe76cD0AUJe/hSVOF0sGmVhUtN
         xQV8sGMjoZqKJjzFoEQ79+4o1QBQE5ioFJCt0cFMDGPcUqYF3lpYuK/Nv8dsFhGhBoty
         XkviYtw6nSeiY/xKjsEwkzg0IN67HlUkqiDUYBh3CP+AQ3BpF+YWtvn3RcpwmWhoeXsh
         m9sZ6V+SAI5+5i0pq/qdjCxbRfX1H3cQzS0VOjeKeyVuGRSQYweL1xQybmSBC3PSbtzu
         fmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689733412; x=1692325412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spyr4XDuSVVg1JGaqXQzVfB+T48wUUZI+CE5XyVeOog=;
        b=Wptw1GNKI5TnaMpABQaCL8S/KrWoU1XSe5wpSSGjtVPDiA4lVJ+DaNST0uLvINd4IE
         5SJ0fsNFUfDu6T+QI6QivBcf1vmnIZd3KDJbxPDQe35R0MFGUN0OnYcWYrDpG+jbK2yx
         AtXeYNaRSh6T401lQQka5XiL4FkwO158lAYfVrZOI1IP7r3v9IWh1QeOaaoiCbUtEFgH
         NuM/W2g1dhwrRqNiKS75jDuO/hYZGxoD5pM/P78fMytwP5smPBR8DLQ956WyOnHRmDPs
         mhdO1USTvNK1+mcXSvCE2NpALhehsgxze8zW6c5Nx1QndaEDvI6/N39ZtMy76ogFRBCp
         Rhpw==
X-Gm-Message-State: ABy/qLYNQCw3X7ihUucysChRqET9NlTgSyIUO8aA04OjcXmVrrbtbYM3
        bE/0XKiqEOk6pJ33ZMMJ5vsrSUwM9fdH8WNIzDRP8g==
X-Google-Smtp-Source: APBJJlGjuC/qPk01y0NULRH38EIrCDYd7zVu6fIoK8k9lJSmY+V4i0zq4fdsoh45FErS3MYwtGHSQlKofRwsZIvQs6Y=
X-Received: by 2002:a17:907:77ca:b0:991:f427:2fdf with SMTP id
 kz10-20020a17090777ca00b00991f4272fdfmr1217475ejc.76.1689733411647; Tue, 18
 Jul 2023 19:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com> <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com> <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com> <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
In-Reply-To: <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Jul 2023 19:22:53 -0700
Message-ID: <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com, Hugh Dickins <hughd@google.com>
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

On Tue, Jul 18, 2023 at 7:10=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 7/19/23 10:00, Yosry Ahmed wrote:
> > On Tue, Jul 18, 2023 at 6:57=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >>
> >> On 7/19/23 09:52, Yosry Ahmed wrote:
> >>> On Tue, Jul 18, 2023 at 6:32=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> >>>> On Tue, Jul 18, 2023 at 4:47=E2=80=AFPM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 7/19/23 06:48, Yosry Ahmed wrote:
> >>>>>> On Sun, Jul 16, 2023 at 6:58=E2=80=AFPM Yin Fengwei <fengwei.yin@i=
ntel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 7/17/23 08:35, Yu Zhao wrote:
> >>>>>>>> On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yi=
n@intel.com> wrote:
> >>>>>>>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> >>>>>>>>>> There is a problem here that I didn't have the time to elabora=
te: we
> >>>>>>>>>> can't mlock() a folio that is within the range but not fully m=
apped
> >>>>>>>>>> because this folio can be on the deferred split queue. When th=
e split
> >>>>>>>>>> happens, those unmapped folios (not mapped by this vma but are=
 mapped
> >>>>>>>>>> into other vmas) will be stranded on the unevictable lru.
> >>>>>>>>> This should be fine unless I missed something. During large fol=
io split,
> >>>>>>>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Foli=
o will be
> >>>>>>>>> munlocked in unmap_folio(). So the head/tail pages will be evic=
table always.
> >>>>>>>> It's close but not entirely accurate: munlock can fail on isolat=
ed folios.
> >>>>>>> Yes. The munlock just clear PG_mlocked bit but with PG_unevictabl=
e left.
> >>>>>>>
> >>>>>>> Could this also happen against normal 4K page? I mean when user t=
ry to munlock
> >>>>>>> a normal 4K page and this 4K page is isolated. So it become unevi=
ctable page?
> >>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() an=
d
> >>>>>> cpu 2 is isolating the folio for any purpose:
> >>>>>>
> >>>>>> cpu1                                        cpu2
> >>>>>>                                                 isolate folio
> >>>>>> folio_test_clear_lru() // 0
> >>>>>>                                                 putback folio // a=
dd
> >>>>>> to unevictable list
> >>>>>> folio_test_clear_mlocked()
> >>>>> Yes. Yu showed this sequence to me in another email. I thought the =
putback_lru()
> >>>>> could correct the none-mlocked but unevictable folio. But it doesn'=
t because
> >>>>> of this race.
> >>>> (+Hugh Dickins for vis)
> >>>>
> >>>> Yu, I am not familiar with the split_folio() case, so I am not sure =
it
> >>>> is the same exact race I stated above.
> >>>>
> >>>> Can you confirm whether or not doing folio_test_clear_mlocked() befo=
re
> >>>> folio_test_clear_lru() would fix the race you are referring to? IIUC=
,
> >>>> in this case, we make sure we clear PG_mlocked before we try to to
> >>>> clear PG_lru. If we fail to clear it, then someone else have the fol=
io
> >>>> isolated after we clear PG_mlocked, so we can be sure that when they
> >>>> put the folio back it will be correctly made evictable.
> >>>>
> >>>> Is my understanding correct?
> >>> Hmm, actually this might not be enough. In folio_add_lru() we will
> >>> call folio_batch_add_and_move(), which calls lru_add_fn() and *then*
> >>> sets PG_lru. Since we check folio_evictable() in lru_add_fn(), the
> >>> race can still happen:
> >>>
> >>>
> >>> cpu1                              cpu2
> >>>                                       folio_evictable() //false
> >>> folio_test_clear_mlocked()
> >>> folio_test_clear_lru() //false
> >>>                                       folio_set_lru()
> >>>
> >>> Relying on PG_lru for synchronization might not be enough with the
> >>> current code. We might need to revert 2262ace60713 ("mm/munlock:
> >>> delete smp_mb() from __pagevec_lru_add_fn()").
> >>>
> >>> Sorry for going back and forth here, I am thinking out loud.
> >>
> >> Yes. Currently, the order in lru_add_fn() is not correct.
> >>
> >> I think we should move folio_test_clear_lru(folio) into
> >>
> >> lru locked range. As the lru lock here was expected to
> >>
> >> use for sync here. Check the comment in lru_add_fn().
> >
> > Right, I am wondering if it would be better to just revert
> > 2262ace60713 and rely on the memory barrier and operations ordering
> > instead of the lru lock. The lru lock is heavily contended as-is, so
> > avoiding using it where possible is preferable I assume.
> My understanding is set_lru after add folio to lru list is correct.
> Once folio_set_lru(), others can do isolation of this folio. But if
> this folio is not in lru list yet, what could happen? It's not required
> to hold lru lock to do isolation.

IIUC, clearing PG_lru is an atomic lockless operation to make sure no
one else is isolating the folio, but then you need to hold the lruvec
lock and actually delete the folio from the lru to complete its
isolation. This is my read of folio_isolate_lru().

Anyway, whether we rely on the lruvec lock or memory barrier +
operation ordering doesn't make a huge difference (I think?). The code
seemed to work with the latter before mlock_count was introduced.

If we decide to go with the latter, I can integrate the fix into the
refresh of my mlock_count rework RFC series (as it would be dependent
on that series). If we decide to go with the lruvec, then it can be
done as part of this series, or separately.

Thanks.

>
> >
> >>
> >>
> >> Regards
> >>
> >> Yin, Fengwei
> >>
> >>
> >>>
> >>>> If yes, I can add this fix to my next version of the RFC series to
> >>>> rework mlock_count. It would be a lot more complicated with the
> >>>> current implementation (as I stated in a previous email).
> >>>>
> >>>>>>
> >>>>>> The page would be stranded on the unevictable list in this case, n=
o?
> >>>>>> Maybe we should only try to isolate the page (clear PG_lru) after =
we
> >>>>>> possibly clear PG_mlocked? In this case if we fail to isolate we k=
now
> >>>>>> for sure that whoever has the page isolated will observe that
> >>>>>> PG_mlocked is clear and correctly make the page evictable.
> >>>>>>
> >>>>>> This probably would be complicated with the current implementation=
, as
> >>>>>> we first need to decrement mlock_count to determine if we want to
> >>>>>> clear PG_mlocked, and to do so we need to isolate the page as
> >>>>>> mlock_count overlays page->lru. With the proposal in [1] to rework
> >>>>>> mlock_count, it might be much simpler as far as I can tell. I inte=
nd
> >>>>>> to refresh this proposal soon-ish.
> >>>>>>
> >>>>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahme=
d@google.com/
> >>>>>>
> >>>>>>>
> >>>>>>> Regards
> >>>>>>> Yin, Fengwei
> >>>>>>>
