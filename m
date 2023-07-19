Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984DB758B09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGSBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:52:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59403FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:52:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9939fbb7191so66889066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689731566; x=1692323566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm8UsgnXaymaPZWlJt+yM3rqUkl+oIHbLCaIfDuxi60=;
        b=mo41huiFOp4/LAQot5cnPMGXdzt4LO4jLSKIKDb2tXvojrOpRthxN7keBAr+vOg9Td
         JN2PJUwPl4Bsph6C9KLtjW9SxnefSU3H5iFyb2Vg4CthS/AI4atcu0zselh7c6HId4Lt
         8r78egy2N9bumGVSEYj6qX2288xTQ+cv3xRaEK7fjcmDeFxqr7IBxFhBGO6Ny9ZrhZ9I
         S/aTKEAchuOxmK48OnHv15YEF+ZhsXeHM6DLUrRdFX1vYTJ+dsqRTbuVN7ltKYOr+qVo
         YEEiounkKh2m6dk8rT5RsMAE5C3I8W0n6vmiVk585J9Ao3ao+2KHY3SJI0j5FPunsP8n
         Vesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689731566; x=1692323566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm8UsgnXaymaPZWlJt+yM3rqUkl+oIHbLCaIfDuxi60=;
        b=Z4v4S/e5gD9Bkpk1wbKopZjSLXRb4AL9Sdowq6AKZpMf+ODCdJmI0L/UzUOsD8G/sE
         xDoV0Jk4j4To/f15J02+p9m8DsM754MXCkiyDCZqyZc7GJi0PXvJvig/INnJY9ueoQjL
         Kh0RmArSUUs/jDjwmdWhfLXYUrqqy2+Bk4dNk1ZR5MvPylNhZu/+MnrYFBoC5H2AvAf2
         vZhPfXguC6VtIFAi3luqff7aSDQVSUgIS0PoXC7fkIKHZ6WJoJAAIM830tdD3Kb1qsCO
         lYod94HB8pSwkXt+Ao84sdWBicTs+RxLCGtCsrniERID3Q2bFOvyULIlO2aH33M0drrZ
         3qZw==
X-Gm-Message-State: ABy/qLaKL/4kcGScHIf9DGczXEUsxuAOKEfjlBTNo4o1HOwRGbLST4jq
        h/dPBzsYlO0rYglqFIzx6U5Qtckf/uOguEt2Mw6XkQ==
X-Google-Smtp-Source: APBJJlGYxqE9W3VQnXNQBmfNYSj9BiqiGm6XNyY2ubOaY1wGxJAlXmw5qiQJVpqpUcXM/CXJZWvyvjCCm/fNTFRWKcM=
X-Received: by 2002:a17:907:3ea0:b0:993:f9d8:9fd0 with SMTP id
 hs32-20020a1709073ea000b00993f9d89fd0mr996265ejc.1.1689731565653; Tue, 18 Jul
 2023 18:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com> <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com> <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
In-Reply-To: <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Jul 2023 18:52:09 -0700
Message-ID: <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 6:32=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jul 18, 2023 at 4:47=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.co=
m> wrote:
> >
> >
> >
> > On 7/19/23 06:48, Yosry Ahmed wrote:
> > > On Sun, Jul 16, 2023 at 6:58=E2=80=AFPM Yin Fengwei <fengwei.yin@inte=
l.com> wrote:
> > >>
> > >>
> > >>
> > >> On 7/17/23 08:35, Yu Zhao wrote:
> > >>> On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yin@i=
ntel.com> wrote:
> > >>>>
> > >>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> > >>>>> There is a problem here that I didn't have the time to elaborate:=
 we
> > >>>>> can't mlock() a folio that is within the range but not fully mapp=
ed
> > >>>>> because this folio can be on the deferred split queue. When the s=
plit
> > >>>>> happens, those unmapped folios (not mapped by this vma but are ma=
pped
> > >>>>> into other vmas) will be stranded on the unevictable lru.
> > >>>>
> > >>>> This should be fine unless I missed something. During large folio =
split,
> > >>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio w=
ill be
> > >>>> munlocked in unmap_folio(). So the head/tail pages will be evictab=
le always.
> > >>>
> > >>> It's close but not entirely accurate: munlock can fail on isolated =
folios.
> > >> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable l=
eft.
> > >>
> > >> Could this also happen against normal 4K page? I mean when user try =
to munlock
> > >> a normal 4K page and this 4K page is isolated. So it become unevicta=
ble page?
> > >
> > > Looks like it can be possible. If cpu 1 is in __munlock_folio() and
> > > cpu 2 is isolating the folio for any purpose:
> > >
> > > cpu1                                        cpu2
> > >                                                 isolate folio
> > > folio_test_clear_lru() // 0
> > >                                                 putback folio // add
> > > to unevictable list
> > > folio_test_clear_mlocked()
> > Yes. Yu showed this sequence to me in another email. I thought the putb=
ack_lru()
> > could correct the none-mlocked but unevictable folio. But it doesn't be=
cause
> > of this race.
>
> (+Hugh Dickins for vis)
>
> Yu, I am not familiar with the split_folio() case, so I am not sure it
> is the same exact race I stated above.
>
> Can you confirm whether or not doing folio_test_clear_mlocked() before
> folio_test_clear_lru() would fix the race you are referring to? IIUC,
> in this case, we make sure we clear PG_mlocked before we try to to
> clear PG_lru. If we fail to clear it, then someone else have the folio
> isolated after we clear PG_mlocked, so we can be sure that when they
> put the folio back it will be correctly made evictable.
>
> Is my understanding correct?

Hmm, actually this might not be enough. In folio_add_lru() we will
call folio_batch_add_and_move(), which calls lru_add_fn() and *then*
sets PG_lru. Since we check folio_evictable() in lru_add_fn(), the
race can still happen:


cpu1                              cpu2
                                      folio_evictable() //false
folio_test_clear_mlocked()
folio_test_clear_lru() //false
                                      folio_set_lru()

Relying on PG_lru for synchronization might not be enough with the
current code. We might need to revert 2262ace60713 ("mm/munlock:
delete smp_mb() from __pagevec_lru_add_fn()").

Sorry for going back and forth here, I am thinking out loud.

>
> If yes, I can add this fix to my next version of the RFC series to
> rework mlock_count. It would be a lot more complicated with the
> current implementation (as I stated in a previous email).
>
> >
> > >
> > >
> > > The page would be stranded on the unevictable list in this case, no?
> > > Maybe we should only try to isolate the page (clear PG_lru) after we
> > > possibly clear PG_mlocked? In this case if we fail to isolate we know
> > > for sure that whoever has the page isolated will observe that
> > > PG_mlocked is clear and correctly make the page evictable.
> > >
> > > This probably would be complicated with the current implementation, a=
s
> > > we first need to decrement mlock_count to determine if we want to
> > > clear PG_mlocked, and to do so we need to isolate the page as
> > > mlock_count overlays page->lru. With the proposal in [1] to rework
> > > mlock_count, it might be much simpler as far as I can tell. I intend
> > > to refresh this proposal soon-ish.
> > >
> > > [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@g=
oogle.com/
> > >
> > >>
> > >>
> > >> Regards
> > >> Yin, Fengwei
> > >>
