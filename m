Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4CF759A12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGSPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:44:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E9B7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:44:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2048750a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689781494; x=1692373494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvTRswu0hNwAHamKZsbNQPwa1H7EMVRdLQIS+OpsXqk=;
        b=updgacmJGqD0Vkf6dmMGGr1c5ss1RfXYXFZCF6aa0VJ7tK5drD69T9VXxxfY0K+5Jp
         tSBG+avaOK2SafoVJrna/vznv87ChWqBUh1qjM4ejfTplwI/xgVEPchs++rUHuBu27gk
         bWGuZgIcSojwjVHBJqAUPM+Yern8N5QPScE27VaEeFeXwjiQ/ca0J7CXOoUatMfy+0Hf
         /CkpTffwOaOZL+rKZGD1TrXrDxp2yrlxCOKWYjiQp6W13CwBsxDPIJw2XFDCbDJDZsBQ
         bLKGwk29sK+D8foW7xTv/uHvtDgVts073TdTJU/N9a4jjlf3Eu6e2Vin1P5zbXmBDQZw
         pQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781494; x=1692373494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvTRswu0hNwAHamKZsbNQPwa1H7EMVRdLQIS+OpsXqk=;
        b=ENbpu4E60YuE761I53gZTscEijtB4qlUq4LzXmAc8xrhp627D1jJQan5vHzdgarqUq
         fVsYhVd1d/xhV4Koo0Nfbe+FZ9nK+FIcC1Dxvbd+GiT2XNGYeeHaRaYd8bgwQ7wTKn4W
         1ErQGPEGDI1foBugWNUrOP0+wCsReSgJu9WI2WJs7ptDoMcjA0Yuaxi2T6cGWMe+cGQN
         zi9Dcj3OuLpQvVFkRZUj9wssKAIENTCSPxuW7OVW57awOg4p9ahpD+Y23BO3Pb1C6E2b
         vdACDC/k7oZSucTic59QRsLqYVMS9IEkIUKOf1t6CoCZrFsSF0hLRp1kjZTl0RbYMQOd
         ZNPQ==
X-Gm-Message-State: ABy/qLYFjS4UxYkGZOCIZTuEQUBiUw9c5xCx1KGZCfRdL6gs8/DTUTao
        zol+xUX5o/UbDj99dkRodfwKjHG5DvJbw5OwEdQJPQ==
X-Google-Smtp-Source: APBJJlHf+g/spbm8AIPdeL6lOUB/vFhqyar65psraZkp9NEeHY9jCu+ydUPJeNcJqtCQKdugl2YoGqCKx0hEwzS8DIg=
X-Received: by 2002:a17:907:a42c:b0:978:8979:c66c with SMTP id
 sg44-20020a170907a42c00b009788979c66cmr2880098ejc.18.1689781493979; Wed, 19
 Jul 2023 08:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com> <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com> <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com> <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com> <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
 <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com> <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
In-Reply-To: <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 19 Jul 2023 08:44:17 -0700
Message-ID: <CAJD7tkaMycnAaY-8Gu=kUwbYqDzihP4BQDzCC2M4BTYAKgG6Qg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Hugh Dickins <hughd@google.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
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

On Wed, Jul 19, 2023 at 7:26=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Wed, 19 Jul 2023, Yin Fengwei wrote:
> > >>>>>>>>> Could this also happen against normal 4K page? I mean when us=
er try to munlock
> > >>>>>>>>> a normal 4K page and this 4K page is isolated. So it become u=
nevictable page?
> > >>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio(=
) and
> > >>>>>>>> cpu 2 is isolating the folio for any purpose:
> > >>>>>>>>
> > >>>>>>>> cpu1                        cpu2
> > >>>>>>>>                             isolate folio
> > >>>>>>>> folio_test_clear_lru() // 0
> > >>>>>>>>                             putback folio // add to unevictabl=
e list
> > >>>>>>>> folio_test_clear_mlocked()
> > >>>>>                                folio_set_lru()
> > Let's wait the response from Huge and Yu. :).
>
> I haven't been able to give it enough thought, but I suspect you are righ=
t:
> that the current __munlock_folio() is deficient when folio_test_clear_lru=
()
> fails.
>
> (Though it has not been reported as a problem in practice: perhaps becaus=
e
> so few places try to isolate from the unevictable "list".)
>
> I forget what my order of development was, but it's likely that I first
> wrote the version for our own internal kernel - which used our original
> lruvec locking, which did not depend on getting PG_lru first (having got
> lru_lock, it checked memcg, then tried again if that had changed).

Right. Just holding the lruvec lock without clearing PG_lru would not
protect against memcg movement in this case.

>
> I was uneasy with the PG_lru aspect of upstream lru_lock implementation,
> but it turned out to work okay - elsewhere; but it looks as if I missed
> its implication when adapting __munlock_page() for upstream.
>
> If I were trying to fix this __munlock_folio() race myself (sorry, I'm
> not), I would first look at that aspect: instead of folio_test_clear_lru(=
)
> behaving always like a trylock, could "folio_wait_clear_lru()" or whateve=
r
> spin waiting for PG_lru here?

+Matthew Wilcox

It seems to me that before 70dea5346ea3 ("mm/swap: convert lru_add to
a folio_batch"), __pagevec_lru_add_fn() (aka lru_add_fn()) used to do
folio_set_lru() before checking folio_evictable(). While this is
probably extraneous since folio_batch_move_lru() will set it again
afterwards, it's probably harmless given that the lruvec lock is held
throughout (so no one can complete the folio isolation anyway), and
given that there were no problems introduced by this extra
folio_set_lru() as far as I can tell.

If we restore folio_set_lru() to lru_add_fn(), and revert 2262ace60713
("mm/munlock:
delete smp_mb() from __pagevec_lru_add_fn()") to restore the strict
ordering between manipulating PG_lru and PG_mlocked, I suppose we can
get away without having to spin. Again, that would only be possible if
reworking mlock_count [1] is acceptable. Otherwise, we can't clear
PG_mlocked before PG_lru in __munlock_folio().

I am not saying this is necessarily better than spinning, just a note
(and perhaps selfishly making [1] more appealing ;)).

[1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.=
com/

>
> Hugh
