Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B5778428
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjHJXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHJXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:32:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80268270F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:32:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99cce6f7de2so203368166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691710377; x=1692315177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5baYHlZ9G5uI95pRDPHfp+N5Jx3ZHWHwVES8s8OdK+g=;
        b=J1gGVvQUu57cNUd6MpCeAqEnft5a3l3EWu0FNY8aP1bWi3ZwAPkMMJs33AkktlXmta
         1kUm7NQBjfKqHzpgnjoH5NQb/bQjv0zsS9vfL8kt/W5E5dT4CVDhclUMs1w1nlHWF35I
         5htxESHyuVz49R2L6s4m8ydNNFm01XzwmL1SdhZ9uJHN5X5ql3APdNV/Ukaapi7FU2ti
         pvnMhjE9evg9ks3ZGcPbmNek7u+9qMJ4pwy7SIZ0IMzx2WGBf7hR+IA2BtZ12zU3oUez
         vFliFE5mb6dm+Yg/XvcpwaDpvA78zM7E6qnJG1AiwKH2rOcQPIucudbqNC59nk5+AiTN
         5HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691710377; x=1692315177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5baYHlZ9G5uI95pRDPHfp+N5Jx3ZHWHwVES8s8OdK+g=;
        b=EDI3HLHWuIIKYfjAhh/5Uhu92FQZvRlBOEY+oG3EltH8uLNeMC2kcs6Q0enJlMC+Y2
         AssKNLWEM7DHNUvLvwTaLEDwvs4VfmgsomYxDzK/UpR9ySnOGYlTwMWBkSsqyaIJWp/9
         exDsAoitYL78qWIeiZOf37iz+2EALjk3zhuqBpvlh6v9Wmnk+qERca0diP9rT26p/2cG
         Pt5Ibu5ncIWL11iE+NUQOFWHA2IK4q48k0ACwj0hAVJhbMsoJq+NUVyA8W67/sFe5p+8
         t7jjltsSapSD92Bid1ECGaGxK1l1HahFNlBFBRx7zJdCbXffOVxFJKi7sU18Ye8sK0U1
         wQOQ==
X-Gm-Message-State: AOJu0YxIxCyU07hRSlTTNwTk9Gy7buh1/vlJPlsQXsW90Vn+SGIziq/t
        B+UDZuK0sxl1khcfhbPXOCMKW5kAH8A8mcccqfHocw==
X-Google-Smtp-Source: AGHT+IHjmqqcMLWpu0WJC52djU0rBOU1pXvwxOutRA8dTl/dVA1sRDsW1ls6o2Sj0jrAprEQ3X2km+16kqvqfdAKeu8=
X-Received: by 2002:a17:906:538d:b0:96f:d780:5734 with SMTP id
 g13-20020a170906538d00b0096fd7805734mr250482ejo.65.1691710376746; Thu, 10 Aug
 2023 16:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com> <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
In-Reply-To: <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 10 Aug 2023 16:32:20 -0700
Message-ID: <CAJD7tkYSu6kmp-J0qDeFaHtef49TMCS1=NHVcO3ZxV_jgKBdNg@mail.gmail.com>
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:31=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 8/11/2023 7:15 AM, Yosry Ahmed wrote:
> > On Thu, Aug 10, 2023 at 4:09=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> >>
> >>
> >>
> >> On 8/11/2023 2:44 AM, Yu Zhao wrote:
> >>> On Thu, Aug 10, 2023 at 3:58=E2=80=AFAM Yin Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>>
> >>>> With mm-unstable branch, if trigger swap activity and it's possible
> >>>> see following warning:
> >>>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 z=
swap_load+0x67/0x570
> >>>> [  178.095155][  T651] Modules linked in:
> >>>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0=
-rc4-00492-gad3232df3e41 #148
> >>>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PII=
X,1996), BIOS 1.14.0-2 04/01/2014
> >>>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
> >>>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 =
01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 =
c4
> >>>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
> >>>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 R=
CX:ffffc900011b37dc
> >>>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 R=
DI:ffffea0004a991c0
> >>>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R=
09:00000000c9a1aafc
> >>>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R=
12:0000000000014b9c
> >>>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R=
15:0000000000000000
> >>>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc800=
00(0000) knlGS:0000000000000000
> >>>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> >>>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 C=
R4:0000000000370ee0
> >>>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 D=
R2:0000000000000000
> >>>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 D=
R7:0000000000000400
> >>>> [  178.121087][  T651] Call Trace:
> >>>> [  178.121654][  T651]  <TASK>
> >>>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
> >>>> [  178.122658][  T651]  ? __warn+0x81/0x170
> >>>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
> >>>> [  178.123608][  T651]  ? report_bug+0x167/0x190
> >>>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
> >>>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
> >>>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
> >>>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
> >>>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
> >>>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
> >>>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
> >>>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
> >>>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
> >>>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
> >>>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
> >>>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
> >>>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
> >>>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
> >>>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
> >>>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
> >>>>
> >>>> It's possible that swap_readpage() is called with none swapcache fol=
io
> >>>> in do_swap_page() and trigger this warning. So we shouldn't assume
> >>>> zswap_load() always takes swapcache folio.
> >>>
> >>> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
> >>> like a bug to me.
> >> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Tha=
nks.
> >
> > Does it make sense to keep the warning and instead change it to check
> > SWP_SYNCHRONOUS_IO as well? Something like:
> >
> > VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
> > !swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);
> >
> > Of course this is too ugly, so perhaps we want a helper to check if a
> > swapfile is synchronous.
> My understanding was that the WARN here is zswap_load() doesn't expect
> a folio not in swapcache. With zram, swap_readpage() must accept the
> folio not in swapcache. So this warn should not be there.
>
> But your comment make more sense to me. I will update the patch not
> to remove this WARN. Thanks.

Thanks. What I have in mind is that usually zram & zswap are not used
together (which is probably why no one reported this warning before),
so in the common case this warning is valuable.

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
> >>
> >
