Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035AC758ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGSBcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:32:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8AD134
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:32:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-997c4107d62so345569366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689730368; x=1692322368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu8yrI0vurtxA36w+DQeue49ZjuZ2e3VFUWp6JueYOg=;
        b=1QaXmQoU6kXcXGavL9t2Q8nTz66m7Csb56F6wlwnjDHZ0H4As3ER87l+U783RQdoYc
         rktnWOv9E2/P/PlZprRb0WYGFl2QSz5FrrpDrlw7bRetKw3O9dPJIBT2u86dcROFkiZ2
         fhHd+hBjv+1hL1J0QMAx8LTW1UR4aYeF++uCqmUHn4fZ7kNO8yWkuvHT7Tqyt5N+kKjQ
         aq82srs83oaNxNIbZiOEBZExFNX33vDYz6ZvIFEHcio5ahIEmOI+pDnke6q5ZQ+yrJDY
         psaBqwXXVtbem3RafmS7nOZRROuCDYob2L6H9gC9patepFz/UFut0VeNegk1XxuhZYMI
         KHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689730368; x=1692322368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu8yrI0vurtxA36w+DQeue49ZjuZ2e3VFUWp6JueYOg=;
        b=EVW3iH7xiszKZ8VAi5dtT/7dx/j0ZK03KwLaiZpg14005dWzB9rfIQ/Y8rGAnANQ6I
         JlGT3kdhUVMxSp5tGrsiqWJvfBVCDo/3MruWTReDaVDqkDWF9NSZjmKX5Umbxocc3RbZ
         KIRNfKhgomaVpUiPpeSoa+0jfaNvxIjJIyMRx+U7pQ/J9rDFW2Qmw+IC7av622AaJGqZ
         9uaz2GkKLIo2kndmqTWSdJLeGtcP80wEv17MbRIuBws9xrFtB7He4ZRvEcrZPQcCROn8
         W+mxDQxb4EroIZK6pmx1JlvYa+esqarJY3zaLBMR+IJ3EdEHyk+SGVb7kunHaixJdNqf
         S2iA==
X-Gm-Message-State: ABy/qLZfjRAJnVUJAQ4NGU/1BLLGhvPRW6+byYavQwEjHRnTzyyldxqq
        yDF5zoaHrNvBDXs2XC1A5L1ILVoq3zrKpCVXej/QXxzzmiRfaQnu4I8ltg==
X-Google-Smtp-Source: APBJJlEeV1IRzZGOhhfpYnXEynBj5QzTy/aA/9A7p9dx7ZAJZ1quY7N3Fd332XX5HPDbX+BEQO3RCmmVi1fmEeCpFLM=
X-Received: by 2002:a17:906:5187:b0:992:1653:3416 with SMTP id
 y7-20020a170906518700b0099216533416mr1575308ejk.0.1689730368452; Tue, 18 Jul
 2023 18:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com> <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
In-Reply-To: <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Jul 2023 18:32:12 -0700
Message-ID: <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        Yin Fengwei <fengwei.yin@intel.com>,
        Hugh Dickins <hughd@google.com>
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

On Tue, Jul 18, 2023 at 4:47=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 7/19/23 06:48, Yosry Ahmed wrote:
> > On Sun, Jul 16, 2023 at 6:58=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >>
> >>
> >> On 7/17/23 08:35, Yu Zhao wrote:
> >>> On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>>
> >>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> >>>>> There is a problem here that I didn't have the time to elaborate: w=
e
> >>>>> can't mlock() a folio that is within the range but not fully mapped
> >>>>> because this folio can be on the deferred split queue. When the spl=
it
> >>>>> happens, those unmapped folios (not mapped by this vma but are mapp=
ed
> >>>>> into other vmas) will be stranded on the unevictable lru.
> >>>>
> >>>> This should be fine unless I missed something. During large folio sp=
lit,
> >>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio wil=
l be
> >>>> munlocked in unmap_folio(). So the head/tail pages will be evictable=
 always.
> >>>
> >>> It's close but not entirely accurate: munlock can fail on isolated fo=
lios.
> >> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable lef=
t.
> >>
> >> Could this also happen against normal 4K page? I mean when user try to=
 munlock
> >> a normal 4K page and this 4K page is isolated. So it become unevictabl=
e page?
> >
> > Looks like it can be possible. If cpu 1 is in __munlock_folio() and
> > cpu 2 is isolating the folio for any purpose:
> >
> > cpu1                                        cpu2
> >                                                 isolate folio
> > folio_test_clear_lru() // 0
> >                                                 putback folio // add
> > to unevictable list
> > folio_test_clear_mlocked()
> Yes. Yu showed this sequence to me in another email. I thought the putbac=
k_lru()
> could correct the none-mlocked but unevictable folio. But it doesn't beca=
use
> of this race.

(+Hugh Dickins for vis)

Yu, I am not familiar with the split_folio() case, so I am not sure it
is the same exact race I stated above.

Can you confirm whether or not doing folio_test_clear_mlocked() before
folio_test_clear_lru() would fix the race you are referring to? IIUC,
in this case, we make sure we clear PG_mlocked before we try to to
clear PG_lru. If we fail to clear it, then someone else have the folio
isolated after we clear PG_mlocked, so we can be sure that when they
put the folio back it will be correctly made evictable.

Is my understanding correct?

If yes, I can add this fix to my next version of the RFC series to
rework mlock_count. It would be a lot more complicated with the
current implementation (as I stated in a previous email).

>
> >
> >
> > The page would be stranded on the unevictable list in this case, no?
> > Maybe we should only try to isolate the page (clear PG_lru) after we
> > possibly clear PG_mlocked? In this case if we fail to isolate we know
> > for sure that whoever has the page isolated will observe that
> > PG_mlocked is clear and correctly make the page evictable.
> >
> > This probably would be complicated with the current implementation, as
> > we first need to decrement mlock_count to determine if we want to
> > clear PG_mlocked, and to do so we need to isolate the page as
> > mlock_count overlays page->lru. With the proposal in [1] to rework
> > mlock_count, it might be much simpler as far as I can tell. I intend
> > to refresh this proposal soon-ish.
> >
> > [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@goo=
gle.com/
> >
> >>
> >>
> >> Regards
> >> Yin, Fengwei
> >>
