Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206A758B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGSCBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:01:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FFFFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:01:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-993a37b79e2so847640866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689732071; x=1692324071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJxttgCms2UBUENv/ecjfyY+jsuBATcIGCNjI4vFRsw=;
        b=HF4xu4BibgPaAP86DjGRepVLlt2JlKYethGSpA1NoyQHLqXUSQ0dfCOwMxNria384q
         4kCqyEP9Oegj/h9zH1llGHwtE7Esap9f2DvWyWKCSjJPw+3XEWFJ5lQs+62yBMSixMhC
         oyYIB9Y8KEQf1gUN4zOTmesrPISe3N3gHvqiz7x6lav3srY3paxgYC/3Zc0nXsGDkpb4
         zajmx8st33tk7jRoZcICIdzgQMSIgW/Q/Tx7dFKpHB2SSO2+CYB8KqurSgxuU6LAq1+x
         txZLINpU9m2aBZln9AydbbrCoTxhXGUdSJEa+FT4aZZcO9F7ySJZxH8l45wKSFxdRddl
         MqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689732071; x=1692324071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJxttgCms2UBUENv/ecjfyY+jsuBATcIGCNjI4vFRsw=;
        b=d5F2eQK7UaKB9E/EY6qWAp0Tzbk5bqDxzUg0KvYEz9tblUpdNPF/N4U2rIIvLC49F+
         Fmn6VkThMLadu2RwLB1UqBA9kevYT7/NKbYPn0k1ptx4rtZ1GvSAo2S0nyheilrd90TL
         89no8Cz/6s6iCQBbvMeuYAwflqCmZ1opAIqHWmJ36UrrmfqxIKosE/2OCaKdloMjphar
         vjFSRGkQTReogrlmSjVIEKHbWOis/SMa+BcHehjonhrk2WWDtsoxR91M2XjQkDjZPrSh
         lbV4LnPxag26JmrXiPBYRKRrTDB9cvrQR6cxEi5p8hLMm5mNnfXjlm6fslxS6z5eWJeD
         vJPA==
X-Gm-Message-State: ABy/qLYUM16tS1xfOl+RevYN8UiLxignEZY1Lig5tbshQft1HPKcfaiI
        8i4IMhOFJIaivbSYv+qEY+6SqmjKdObMimZcEaXC8zFry2xDUu73pXUI7w==
X-Google-Smtp-Source: APBJJlEu/j2ZuGIw4EeIaNQEWaqjUUguApp/aD3uSFg5uF4Sc+vREmT5lODsu4TxjgA294QOG5KSyeLLXgMEAbo3Mj4=
X-Received: by 2002:a17:907:8d11:b0:992:a838:a564 with SMTP id
 tc17-20020a1709078d1100b00992a838a564mr914789ejc.28.1689732070874; Tue, 18
 Jul 2023 19:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com> <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com> <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com> <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
In-Reply-To: <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Jul 2023 19:00:34 -0700
Message-ID: <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 6:57=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
> On 7/19/23 09:52, Yosry Ahmed wrote:
> > On Tue, Jul 18, 2023 at 6:32=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >> On Tue, Jul 18, 2023 at 4:47=E2=80=AFPM Yin Fengwei <fengwei.yin@intel=
.com> wrote:
> >>>
> >>>
> >>> On 7/19/23 06:48, Yosry Ahmed wrote:
> >>>> On Sun, Jul 16, 2023 at 6:58=E2=80=AFPM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 7/17/23 08:35, Yu Zhao wrote:
> >>>>>> On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yin@=
intel.com> wrote:
> >>>>>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> >>>>>>>> There is a problem here that I didn't have the time to elaborate=
: we
> >>>>>>>> can't mlock() a folio that is within the range but not fully map=
ped
> >>>>>>>> because this folio can be on the deferred split queue. When the =
split
> >>>>>>>> happens, those unmapped folios (not mapped by this vma but are m=
apped
> >>>>>>>> into other vmas) will be stranded on the unevictable lru.
> >>>>>>> This should be fine unless I missed something. During large folio=
 split,
> >>>>>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio =
will be
> >>>>>>> munlocked in unmap_folio(). So the head/tail pages will be evicta=
ble always.
> >>>>>> It's close but not entirely accurate: munlock can fail on isolated=
 folios.
> >>>>> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable =
left.
> >>>>>
> >>>>> Could this also happen against normal 4K page? I mean when user try=
 to munlock
> >>>>> a normal 4K page and this 4K page is isolated. So it become unevict=
able page?
> >>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
> >>>> cpu 2 is isolating the folio for any purpose:
> >>>>
> >>>> cpu1                                        cpu2
> >>>>                                                 isolate folio
> >>>> folio_test_clear_lru() // 0
> >>>>                                                 putback folio // add
> >>>> to unevictable list
> >>>> folio_test_clear_mlocked()
> >>> Yes. Yu showed this sequence to me in another email. I thought the pu=
tback_lru()
> >>> could correct the none-mlocked but unevictable folio. But it doesn't =
because
> >>> of this race.
> >> (+Hugh Dickins for vis)
> >>
> >> Yu, I am not familiar with the split_folio() case, so I am not sure it
> >> is the same exact race I stated above.
> >>
> >> Can you confirm whether or not doing folio_test_clear_mlocked() before
> >> folio_test_clear_lru() would fix the race you are referring to? IIUC,
> >> in this case, we make sure we clear PG_mlocked before we try to to
> >> clear PG_lru. If we fail to clear it, then someone else have the folio
> >> isolated after we clear PG_mlocked, so we can be sure that when they
> >> put the folio back it will be correctly made evictable.
> >>
> >> Is my understanding correct?
> > Hmm, actually this might not be enough. In folio_add_lru() we will
> > call folio_batch_add_and_move(), which calls lru_add_fn() and *then*
> > sets PG_lru. Since we check folio_evictable() in lru_add_fn(), the
> > race can still happen:
> >
> >
> > cpu1                              cpu2
> >                                       folio_evictable() //false
> > folio_test_clear_mlocked()
> > folio_test_clear_lru() //false
> >                                       folio_set_lru()
> >
> > Relying on PG_lru for synchronization might not be enough with the
> > current code. We might need to revert 2262ace60713 ("mm/munlock:
> > delete smp_mb() from __pagevec_lru_add_fn()").
> >
> > Sorry for going back and forth here, I am thinking out loud.
>
> Yes. Currently, the order in lru_add_fn() is not correct.
>
> I think we should move folio_test_clear_lru(folio) into
>
> lru locked range. As the lru lock here was expected to
>
> use for sync here. Check the comment in lru_add_fn().

Right, I am wondering if it would be better to just revert
2262ace60713 and rely on the memory barrier and operations ordering
instead of the lru lock. The lru lock is heavily contended as-is, so
avoiding using it where possible is preferable I assume.

>
>
> Regards
>
> Yin, Fengwei
>
>
> >
> >> If yes, I can add this fix to my next version of the RFC series to
> >> rework mlock_count. It would be a lot more complicated with the
> >> current implementation (as I stated in a previous email).
> >>
> >>>>
> >>>> The page would be stranded on the unevictable list in this case, no?
> >>>> Maybe we should only try to isolate the page (clear PG_lru) after we
> >>>> possibly clear PG_mlocked? In this case if we fail to isolate we kno=
w
> >>>> for sure that whoever has the page isolated will observe that
> >>>> PG_mlocked is clear and correctly make the page evictable.
> >>>>
> >>>> This probably would be complicated with the current implementation, =
as
> >>>> we first need to decrement mlock_count to determine if we want to
> >>>> clear PG_mlocked, and to do so we need to isolate the page as
> >>>> mlock_count overlays page->lru. With the proposal in [1] to rework
> >>>> mlock_count, it might be much simpler as far as I can tell. I intend
> >>>> to refresh this proposal soon-ish.
> >>>>
> >>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@=
google.com/
> >>>>
> >>>>>
> >>>>> Regards
> >>>>> Yin, Fengwei
> >>>>>
