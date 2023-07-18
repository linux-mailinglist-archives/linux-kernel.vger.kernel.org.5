Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD87588B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGRWs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGRWsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:48:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE457EE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:48:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b74310566cso98323601fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689720530; x=1692312530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64xvKcnKy5DgmAZbLYy2NqkO8PtnqPDYZ+M2QATChtA=;
        b=PBfU50Rlso2jIontKrtUVaAwaXFFweeazhC+YKqXuXYFS8JJVQy4pVS8ehe+VQZLL4
         y+slzR2h7pb6ndGjwpzFOVXGym/e2O2BvK1j7+MHYz8NnQMRgNsab0nJlEDi6mTI7Qow
         kyScqipk5OhjNsorAEm0VraYWQRGr/bQtyYWTUSBt/PpmF8boBNuhqFMOfZvp/TxjDAd
         OESLDPYtcEImtbl2qnJd1YU5bp0vHwQLrmyyePzYrGKhbo1XeLaUeQgVOMMitBFTylXA
         +1wcITGaYN69h3K6BkmW45xFVpqgONlOyG1IYZmuDwYa5pQwdX5DjSYuK2GIH1WkbNCo
         9Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720530; x=1692312530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64xvKcnKy5DgmAZbLYy2NqkO8PtnqPDYZ+M2QATChtA=;
        b=WGLwuhEdgt56169FxYtK5VrWTco6fFTMOIJ04uTkw23tk/dVMCV82FUCoUUe5MCuvE
         hz56m1/4aRQVhJoaUeJeAG/qCMnbeHBEc2WINzMEo706qrkq1Kd0QJatKMaoOR5Qb4yM
         bPawQL9vogv0m8s+mtCWsCSI1lZcfC681Aylggcc2eNIC4JASXO7EtmNpOhHnyJIrzZf
         Z3TEtJLP5TM1N4KZrzygKnJWkuSaFb1rA0mrTU706SkpEsQTEPtTHtiRu1B5mkxjqpuS
         yqvxsKqeq0tgL0s5BFV4aqHMJCfjZ10LY5UqgVbOmuvUgfKo6LV/wPbOo+c6LKSIsa/h
         dgwA==
X-Gm-Message-State: ABy/qLb2TUXgwf4b2u+e3t4Y1/598+pqur0aZZUIFI7iE5fpvqma9W7Q
        EA+CY6/awHpQjJwWLKpGIBqhjNOPJRoQh85jK/gGLw==
X-Google-Smtp-Source: APBJJlEiO9y+TmNGlE8Dp1HF6JhU0+nm56elr0V5vduRRlStDfG8bqlc89HroNCkPTytLSHF9EkuR3DP/4FEtOlkGds=
X-Received: by 2002:a2e:a410:0:b0:2b6:e13f:cfd7 with SMTP id
 p16-20020a2ea410000000b002b6e13fcfd7mr11793989ljn.4.1689720529870; Tue, 18
 Jul 2023 15:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
In-Reply-To: <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Jul 2023 15:48:13 -0700
Message-ID: <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
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

On Sun, Jul 16, 2023 at 6:58=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 7/17/23 08:35, Yu Zhao wrote:
> > On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> >>
> >> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> >>> There is a problem here that I didn't have the time to elaborate: we
> >>> can't mlock() a folio that is within the range but not fully mapped
> >>> because this folio can be on the deferred split queue. When the split
> >>> happens, those unmapped folios (not mapped by this vma but are mapped
> >>> into other vmas) will be stranded on the unevictable lru.
> >>
> >> This should be fine unless I missed something. During large folio spli=
t,
> >> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will =
be
> >> munlocked in unmap_folio(). So the head/tail pages will be evictable a=
lways.
> >
> > It's close but not entirely accurate: munlock can fail on isolated foli=
os.
> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable left.
>
> Could this also happen against normal 4K page? I mean when user try to mu=
nlock
> a normal 4K page and this 4K page is isolated. So it become unevictable p=
age?

Looks like it can be possible. If cpu 1 is in __munlock_folio() and
cpu 2 is isolating the folio for any purpose:

cpu1                                        cpu2
                                                isolate folio
folio_test_clear_lru() // 0
                                                putback folio // add
to unevictable list
folio_test_clear_mlocked()


The page would be stranded on the unevictable list in this case, no?
Maybe we should only try to isolate the page (clear PG_lru) after we
possibly clear PG_mlocked? In this case if we fail to isolate we know
for sure that whoever has the page isolated will observe that
PG_mlocked is clear and correctly make the page evictable.

This probably would be complicated with the current implementation, as
we first need to decrement mlock_count to determine if we want to
clear PG_mlocked, and to do so we need to isolate the page as
mlock_count overlays page->lru. With the proposal in [1] to rework
mlock_count, it might be much simpler as far as I can tell. I intend
to refresh this proposal soon-ish.

[1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.=
com/

>
>
> Regards
> Yin, Fengwei
>
