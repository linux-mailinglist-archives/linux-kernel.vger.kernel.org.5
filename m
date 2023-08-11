Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44CA7785F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjHKDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjHKDV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:21:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1EB2D66
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:21:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1f6f3884so216319466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691724116; x=1692328916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDs5LNIh5me8YgouEborQNVYYzuA+w9vmfJZGIflxcc=;
        b=MPp4Xv6NNNDgTu501EKzYTdB8JE5+A+cN/DnQa3kzI1v4x/tM6HYgTvyRaqgqPlCFP
         5ImZYKr1k0KAronGB9wLYq8lKZH/WYqW+8N2TZTObf03JtbLSiJZMDIZkzd6/8aiECvD
         oKXz4p1gYcOmGO4qRWnKmf4fxz3hwnz9DQhsY4ECCHiPAHgCDou0PS7VwUVhKwzdgiLY
         rLo8dQBnvxyLfPMrRivyK5ywAtBUlGMfhfYzMu5IsJO9J+1wZSavERlZiMAsHr/FPD9A
         DEaQZRNtxPglFIHP3vtt6U1VhIgH9dv1ijKA8kukXMJJFvx8erVrmWwWFDZQWI7BY0Q5
         9RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691724116; x=1692328916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDs5LNIh5me8YgouEborQNVYYzuA+w9vmfJZGIflxcc=;
        b=Mb/YqbKuQemuxCvVbxTp3KWfQynNvZfbUDd/DdhvPbKF4hbxIn8hq9jkj9huE3sMDj
         OqLIq1PH6bkX+Yc5pxoBXth8x8nRVOU4USW/iViUW2utk/XwnIvB1rgeGQnLntjSIvHT
         bbgx6AJ/ldSf2AV8sNdyzElBdAGr4cxPKksUi2PfyZig5ZafPy/6ConDRnxbZVKE0AIu
         q1c7LAGAnj6bjqFpecHn6zX6HBRa/qdxlhubwINe3FItKFVCa9RvytZOahTfioKEfSCB
         Md29lnlObHC1W/zU39hu02JCF8m74Ll5FUHH9O6tbSQPb4tG0GF7w9x8fHisUTfkRtJP
         yjHg==
X-Gm-Message-State: AOJu0YySXzwLvsKENS7N1ccr6Ma4EuvXx0rYLtSL+a6RKyxsm02TuBTh
        9uFPVnF71YJMUKVrenovfQbx/BS1ZwCfQsMwr1hTyQ==
X-Google-Smtp-Source: AGHT+IF9kCuCQPv7saZs40fgdMZiRIGAk7YHtCdJHVKAiiGlGg6QlMOILUBAj6Nr4/smEHmqbyuDDqYiU/fKm595LKI=
X-Received: by 2002:a17:907:1dce:b0:99b:d098:1ffd with SMTP id
 og14-20020a1709071dce00b0099bd0981ffdmr613317ejc.62.1691724115853; Thu, 10
 Aug 2023 20:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com> <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com> <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
 <CAJD7tka17GHTgu9JZNW8-CCsH2OR67oj31h53oa-oPTTVnkQQQ@mail.gmail.com> <CAOUHufYk7ZV=YPk6uGE1+ysgTKRXdwV8T3s7qvEkpGYbGNKwEw@mail.gmail.com>
In-Reply-To: <CAOUHufYk7ZV=YPk6uGE1+ysgTKRXdwV8T3s7qvEkpGYbGNKwEw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 10 Aug 2023 20:21:19 -0700
Message-ID: <CAJD7tkZoE5is2_pBHs5w7-4Am8HuWdbkBn89OYoHfbRv5rSKsQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
To:     Yu Zhao <yuzhao@google.com>
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

On Thu, Aug 10, 2023 at 8:12=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Aug 10, 2023 at 5:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 10, 2023 at 4:44=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Thu, Aug 10, 2023 at 5:31=E2=80=AFPM Yin, Fengwei <fengwei.yin@int=
el.com> wrote:
> > > >
> > > >
> > > >
> > > > On 8/11/2023 7:15 AM, Yosry Ahmed wrote:
> > > > > On Thu, Aug 10, 2023 at 4:09=E2=80=AFPM Yin, Fengwei <fengwei.yin=
@intel.com> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >> On 8/11/2023 2:44 AM, Yu Zhao wrote:
> > > > >>> On Thu, Aug 10, 2023 at 3:58=E2=80=AFAM Yin Fengwei <fengwei.yi=
n@intel.com> wrote:
> > > > >>>>
> > > > >>>> With mm-unstable branch, if trigger swap activity and it's pos=
sible
> > > > >>>> see following warning:
> > > > >>>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:=
1387 zswap_load+0x67/0x570
> > > > >>>> [  178.095155][  T651] Modules linked in:
> > > > >>>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted=
 6.5.0-rc4-00492-gad3232df3e41 #148
> > > > >>>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX=
 + PIIX,1996), BIOS 1.14.0-2 04/01/2014
> > > > >>>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
> > > > >>>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b =
00 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 =
0f 85 c4
> > > > >>>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 0001=
0246
> > > > >>>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a9=
91c0 RCX:ffffc900011b37dc
> > > > >>>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 000000000000=
0001 RDI:ffffea0004a991c0
> > > > >>>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 000000000000=
0243 R09:00000000c9a1aafc
> > > > >>>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c96=
57db R12:0000000000014b9c
> > > > >>>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d59=
1000 R15:0000000000000000
> > > > >>>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff8881=
3bc80000(0000) knlGS:0000000000000000
> > > > >>>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> > > > >>>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 000000013145=
0002 CR4:0000000000370ee0
> > > > >>>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 000000000000=
0000 DR2:0000000000000000
> > > > >>>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe=
0ff0 DR7:0000000000000400
> > > > >>>> [  178.121087][  T651] Call Trace:
> > > > >>>> [  178.121654][  T651]  <TASK>
> > > > >>>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
> > > > >>>> [  178.122658][  T651]  ? __warn+0x81/0x170
> > > > >>>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
> > > > >>>> [  178.123608][  T651]  ? report_bug+0x167/0x190
> > > > >>>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
> > > > >>>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
> > > > >>>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
> > > > >>>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
> > > > >>>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
> > > > >>>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
> > > > >>>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
> > > > >>>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
> > > > >>>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
> > > > >>>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
> > > > >>>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
> > > > >>>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
> > > > >>>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
> > > > >>>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
> > > > >>>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
> > > > >>>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
> > > > >>>>
> > > > >>>> It's possible that swap_readpage() is called with none swapcac=
he folio
> > > > >>>> in do_swap_page() and trigger this warning. So we shouldn't as=
sume
> > > > >>>> zswap_load() always takes swapcache folio.
> > > > >>>
> > > > >>> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it so=
unds
> > > > >>> like a bug to me.
> > > > >> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS se=
t. Thanks.
> > > > >
> > > > > Does it make sense to keep the warning and instead change it to c=
heck
> > > > > SWP_SYNCHRONOUS_IO as well? Something like:
> > > > >
> > > > > VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
> > > > > !swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);
> > > > >
> > > > > Of course this is too ugly, so perhaps we want a helper to check =
if a
> > > > > swapfile is synchronous.
> > > > My understanding was that the WARN here is zswap_load() doesn't exp=
ect
> > > > a folio not in swapcache. With zram, swap_readpage() must accept th=
e
> > > > folio not in swapcache. So this warn should not be there.
> > > >
> > > > But your comment make more sense to me. I will update the patch not
> > > > to remove this WARN. Thanks.
> > >
> > > That can cause another warning.
> > >
> > > Please don't overegineer.
> >
> > How so?
> >
> > Using zswap with zram is a weird combination
>
> Not at all -- it can achieve tiering between different compressors:
> fast but low compression ratio for zswap but the opposite for zram.

That's definitely an interesting use case, thanks for pointing this out.

I would prefer creating a helper and using it in both do_swap_fault()
and zswap_load() in the WARN_ON (with data_race()), but I am not
against just removing the WARN_ON either. I will leave it up to you
and Yin :)

>
> > if anything I would
> > prefer leaving the warning as-is than removing it to be honest.
