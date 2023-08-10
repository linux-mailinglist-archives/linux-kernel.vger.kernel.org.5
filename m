Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4793F778404
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjHJXQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHJXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:16:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401772690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:16:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso2287711e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691709394; x=1692314194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rGQ9Py9pERUpRDN5xhuNohTgelLDMrFaS27ePXSIqI=;
        b=iP8bvxcWSy2WRDc/fthlBMuD16N9seuxTX4Y74WxV0dFrOrrvdRXnNVB4lyhCOJ+K2
         ckI8CtZxMa/RGi5VilvfHHXO2mzTidTwZgcep5H4k3Oyd9FkCBFTUPnnxAGTWZY1ooA3
         BHX2nrbfOyq/OaqnSyJ4La4rjXA/w/yK8cclIgWfHBxsO/JR3CyOMrJS+BQX0Y56dlrc
         eM1qprw+UQFxSvyZB+uAM7lz8n/7nXk5Svnc23zqRx/wqZ6+ZjOw2IQR/7giir6JxtUz
         XnQNCD8u7pUkKwA8DLqAZGtjWZVqSMWhcdLRQvoiBdKSxnkwMtuKNogZA3vx2iJChL3J
         +zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691709394; x=1692314194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rGQ9Py9pERUpRDN5xhuNohTgelLDMrFaS27ePXSIqI=;
        b=CpWSxKPOKNRstoGU8edSvp0mV6G1/DZEUqQlys0WziTtw9NiZDgUnZvTef1j4PV8YW
         fdWKMMYPjlJ2U4kjFwXg2s81KByFI+b2S7KK4gs8an+JH4MNIMZ2YI2D3s/fTaqlvqQM
         erR2laJzCDsgp1NI9ArsMAUfq89h0Q2/cS8bQE7MvNOzLA2Y7pnrlS1bmHR0DFMlruUy
         02N9rz2BiPU3cTCPlocQBPEnYr04lhyaweNTJfIszoVg2JAJ7ci3xnadVPvkfXcBXlNE
         d/kV0jDX0UCamg1OBgIYnPEhhPSzhIEhZ4sfn/zLtIfn5ZBTwOsVYZA5BSB3Oe8DjaPt
         UdQw==
X-Gm-Message-State: AOJu0YyHPVRPPJxz+pRAqT2etuQFumH4FANkeBjrcpWaGpAR6UQ9B9Q6
        QJzEm03FLEyc7Yow+lgbnrkglgs5arTJnXGP+//Zdr/cJn9qXlZaFEL9JQ==
X-Google-Smtp-Source: AGHT+IGNK4uyE/Tr8yc4HFri/kdX48VsivQD+lAEPIYM7KRgcSjILo0I7ai2sDqt9GcQcGZQuIJH8PJ5jFQAvgrXpQA=
X-Received: by 2002:a05:6512:308e:b0:4fe:5fc:9c4b with SMTP id
 z14-20020a056512308e00b004fe05fc9c4bmr113879lfd.15.1691709394136; Thu, 10 Aug
 2023 16:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com> <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
In-Reply-To: <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 10 Aug 2023 16:15:57 -0700
Message-ID: <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        hannes@cmpxchg.org
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

On Thu, Aug 10, 2023 at 4:09=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 8/11/2023 2:44 AM, Yu Zhao wrote:
> > On Thu, Aug 10, 2023 at 3:58=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> With mm-unstable branch, if trigger swap activity and it's possible
> >> see following warning:
> >> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zsw=
ap_load+0x67/0x570
> >> [  178.095155][  T651] Modules linked in:
> >> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-r=
c4-00492-gad3232df3e41 #148
> >> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,=
1996), BIOS 1.14.0-2 04/01/2014
> >> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
> >> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01=
 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
> >> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
> >> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX=
:ffffc900011b37dc
> >> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI=
:ffffea0004a991c0
> >> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09=
:00000000c9a1aafc
> >> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12=
:0000000000014b9c
> >> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15=
:0000000000000000
> >> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000=
(0000) knlGS:0000000000000000
> >> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> >> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4=
:0000000000370ee0
> >> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2=
:0000000000000000
> >> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7=
:0000000000000400
> >> [  178.121087][  T651] Call Trace:
> >> [  178.121654][  T651]  <TASK>
> >> [  178.122109][  T651]  ? zswap_load+0x67/0x570
> >> [  178.122658][  T651]  ? __warn+0x81/0x170
> >> [  178.123119][  T651]  ? zswap_load+0x67/0x570
> >> [  178.123608][  T651]  ? report_bug+0x167/0x190
> >> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
> >> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
> >> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
> >> [  178.125753][  T651]  ? zswap_load+0x67/0x570
> >> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
> >> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
> >> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
> >> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
> >> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
> >> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
> >> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
> >> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
> >> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
> >> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
> >> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
> >> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
> >>
> >> It's possible that swap_readpage() is called with none swapcache folio
> >> in do_swap_page() and trigger this warning. So we shouldn't assume
> >> zswap_load() always takes swapcache folio.
> >
> > Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
> > like a bug to me.
> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Thanks=
.

Does it make sense to keep the warning and instead change it to check
SWP_SYNCHRONOUS_IO as well? Something like:

VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
!swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);

Of course this is too ugly, so perhaps we want a helper to check if a
swapfile is synchronous.

>
>
> Regards
> Yin, Fengwei
>
>
