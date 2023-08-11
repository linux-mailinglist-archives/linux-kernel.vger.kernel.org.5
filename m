Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D37785CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjHKDM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjHKDMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:12:19 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284E2D68
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:12:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so98111cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691723538; x=1692328338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyNF4fan0gAR+nl62OehNXrtcsZRwJMSypjeAFGug5M=;
        b=Ny5dWJw2wnpPA5SzXkeiAgVClEEqrNr0uW9COYuxAMS7DLw94C7qBtjxe72OMAbLuS
         nXs0GmZ0reKbMxZ1ddK+xYc7KnS0TpJ9E6a98sBusfamJOwpzQIJw5vewehx7E+fY1hA
         IQ5PH6umdCEu/SIHvMMtcm1xomnojt1LtF0INhrfxxKSu5lNNSZ5TUCWXPZ6WYPojAxX
         LQ8fanxRU4P97RXtdRUIUFMcBt196o2I1G4YgXrt/Jit5RZsoNTHra/I8s2Hj145asSZ
         Mrh3RkpRpKe847DIllPdRonNZ+ZM1em7ljGrLBmh9geXvhJmN+kAH3looD0y6re7JJQV
         1Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691723538; x=1692328338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyNF4fan0gAR+nl62OehNXrtcsZRwJMSypjeAFGug5M=;
        b=dRjRz9DL69b00tZIx64/8I12H5DyDpxDlcRXtdBXkktKh2SgEApwVsGoBMH0YgjI0p
         Z/QK7hAmU44fF8BBcoM0NJmcWeYxxXmlC2dK/cTf3U2ENC1Wb9lMR0au6AN4joLgcoaR
         j0fKKwIEorfz8jlyQsDEuXAkMXmKWVXcWGmdwjrZHhrT2lelVecXG6ADUMmQqILsefSI
         LyY2igS/BG8ef2DgcAmCY5/by9k6iAJPr84hPz6Vrabv+tPbg8tHB5Ew590rpStXPfAT
         CwySsrp9SInDB5WITyd5pdLSY+7GtBcvJT1w3yKDqtVYSRI7/Z/lj5zpmEWCtdRMVE6p
         78ew==
X-Gm-Message-State: AOJu0Ywzzftaux29iUqI/+OeAbIquJzNv5TRWggOVMP98pr2aaKQVAs3
        6GRl1+0NGl6508pzE73YTqc3mU6mN2j7t/pFU/9XvQ==
X-Google-Smtp-Source: AGHT+IGye13cB7btd+DnmXhedag4jlgNdeB65TdHbW70UkB5A5aZi3BB6NNLhdG0mNINbWJDXy4SO1UQ213MUz1V2KQ=
X-Received: by 2002:a05:622a:54:b0:3ef:5f97:258f with SMTP id
 y20-20020a05622a005400b003ef5f97258fmr132021qtw.16.1691723537771; Thu, 10 Aug
 2023 20:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com> <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com> <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
 <CAJD7tka17GHTgu9JZNW8-CCsH2OR67oj31h53oa-oPTTVnkQQQ@mail.gmail.com>
In-Reply-To: <CAJD7tka17GHTgu9JZNW8-CCsH2OR67oj31h53oa-oPTTVnkQQQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Aug 2023 21:11:41 -0600
Message-ID: <CAOUHufYk7ZV=YPk6uGE1+ysgTKRXdwV8T3s7qvEkpGYbGNKwEw@mail.gmail.com>
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 5:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Aug 10, 2023 at 4:44=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Thu, Aug 10, 2023 at 5:31=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> > >
> > >
> > >
> > > On 8/11/2023 7:15 AM, Yosry Ahmed wrote:
> > > > On Thu, Aug 10, 2023 at 4:09=E2=80=AFPM Yin, Fengwei <fengwei.yin@i=
ntel.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 8/11/2023 2:44 AM, Yu Zhao wrote:
> > > >>> On Thu, Aug 10, 2023 at 3:58=E2=80=AFAM Yin Fengwei <fengwei.yin@=
intel.com> wrote:
> > > >>>>
> > > >>>> With mm-unstable branch, if trigger swap activity and it's possi=
ble
> > > >>>> see following warning:
> > > >>>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:13=
87 zswap_load+0x67/0x570
> > > >>>> [  178.095155][  T651] Modules linked in:
> > > >>>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6=
.5.0-rc4-00492-gad3232df3e41 #148
> > > >>>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX +=
 PIIX,1996), BIOS 1.14.0-2 04/01/2014
> > > >>>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
> > > >>>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00=
 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f=
 85 c4
> > > >>>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 000102=
46
> > > >>>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991=
c0 RCX:ffffc900011b37dc
> > > >>>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 00000000000000=
01 RDI:ffffea0004a991c0
> > > >>>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 00000000000002=
43 R09:00000000c9a1aafc
> > > >>>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657=
db R12:0000000000014b9c
> > > >>>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d5910=
00 R15:0000000000000000
> > > >>>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813b=
c80000(0000) knlGS:0000000000000000
> > > >>>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> > > >>>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 00000001314500=
02 CR4:0000000000370ee0
> > > >>>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 00000000000000=
00 DR2:0000000000000000
> > > >>>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0f=
f0 DR7:0000000000000400
> > > >>>> [  178.121087][  T651] Call Trace:
> > > >>>> [  178.121654][  T651]  <TASK>
> > > >>>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
> > > >>>> [  178.122658][  T651]  ? __warn+0x81/0x170
> > > >>>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
> > > >>>> [  178.123608][  T651]  ? report_bug+0x167/0x190
> > > >>>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
> > > >>>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
> > > >>>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
> > > >>>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
> > > >>>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
> > > >>>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
> > > >>>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
> > > >>>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
> > > >>>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
> > > >>>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
> > > >>>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
> > > >>>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
> > > >>>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
> > > >>>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
> > > >>>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
> > > >>>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
> > > >>>>
> > > >>>> It's possible that swap_readpage() is called with none swapcache=
 folio
> > > >>>> in do_swap_page() and trigger this warning. So we shouldn't assu=
me
> > > >>>> zswap_load() always takes swapcache folio.
> > > >>>
> > > >>> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it soun=
ds
> > > >>> like a bug to me.
> > > >> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set.=
 Thanks.
> > > >
> > > > Does it make sense to keep the warning and instead change it to che=
ck
> > > > SWP_SYNCHRONOUS_IO as well? Something like:
> > > >
> > > > VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
> > > > !swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);
> > > >
> > > > Of course this is too ugly, so perhaps we want a helper to check if=
 a
> > > > swapfile is synchronous.
> > > My understanding was that the WARN here is zswap_load() doesn't expec=
t
> > > a folio not in swapcache. With zram, swap_readpage() must accept the
> > > folio not in swapcache. So this warn should not be there.
> > >
> > > But your comment make more sense to me. I will update the patch not
> > > to remove this WARN. Thanks.
> >
> > That can cause another warning.
> >
> > Please don't overegineer.
>
> How so?
>
> Using zswap with zram is a weird combination

Not at all -- it can achieve tiering between different compressors:
fast but low compression ratio for zswap but the opposite for zram.

> if anything I would
> prefer leaving the warning as-is than removing it to be honest.
