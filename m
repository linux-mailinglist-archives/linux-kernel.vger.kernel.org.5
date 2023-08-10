Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A757783FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjHJXNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHJXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:13:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9FB2D48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:13:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso63351cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691709224; x=1692314024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rc//26/31Jd4cOSTD1J3aAtcl52PyUGftq/fbg3u2dg=;
        b=qNAQlVmZWz5mr5w2Q7GzmKY2aI6s3BbZvEh57UBBSWdOfTWZPXO5WtTGweiU6mG9UN
         skfGNnHz+cG+rnVwOJlN39FLYsnkog79QGrV3dFowtWUTzaROH7gyPLjRwigBIGZ0joo
         iscFfD1gIMtZ1vI0zZ0fvH+tIvoydMQyQOeV9Sa+ao3OqOdn15n4wjBPt9tXo1vApczz
         MpVQR1gGsEIGsA4pyhE29II0UGlthBCPnwihQeq8kP5gIumUpNDlSs3vfd/+iIMlSCWl
         O1v6EFFYG6FqI0yA7NPvqHGKGJDwOe2MZxxPuegwgbiARfjZym0xqoMRjIN0Pkhazs/w
         tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691709224; x=1692314024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc//26/31Jd4cOSTD1J3aAtcl52PyUGftq/fbg3u2dg=;
        b=WgNfa8h5A2MkzrotRL5rck8MIh3ZfAKcHzzZwAiAvEcXoVOsbRsTYeTmLdsxpaGcdD
         ksp3kFSkiSjivg1PJHtXVyuXd4agvRawvT1S4fXMQfB7lfCsHYSzti9kal+u3MDOyyx8
         YZ6HOCQx6TH2ENHeE2rnSZGZyaIyrjaRgVa0Vn4MmlBhzOFftGrMnobLz2Ujb0dJu+kG
         8gEWbtnGEXbbIjCFVvXMd0c5MngnRBiwpytM3U9PV3CZRX1gjXLTzTcE/B3tjhCQzpP1
         +JEmhL+7WwLGM0FU6B0wUuUVR0WpVXvqJqsCpN5vSI0lQDeB1MSQ+o0pk0HVcE++Pzwh
         O39A==
X-Gm-Message-State: AOJu0Yyq0TpXbIwLnGiEQvnAHtACO7d5VYWuSbTrDD8ck5itA4NgstO8
        jgPz3d1X70/RRz/miof3kgHvIdjhLetaTmjx8jWA7Q==
X-Google-Smtp-Source: AGHT+IHsgm0oPYGpzGZEFgT8eaG71qDwSt8R+5gOCfug4dNC0NFtIKVXLQ9Kv/sm4riEjaAgCT6srejVdoY10T4WsJw=
X-Received: by 2002:a05:622a:1888:b0:3f5:2006:50f1 with SMTP id
 v8-20020a05622a188800b003f5200650f1mr114052qtc.12.1691709223839; Thu, 10 Aug
 2023 16:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com> <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
In-Reply-To: <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Aug 2023 17:13:07 -0600
Message-ID: <CAOUHufbbYDAaW6YfdjAED06O_8RmqYD2nLcF2MFJaa7G8cRE1w@mail.gmail.com>
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

On Thu, Aug 10, 2023 at 5:09=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
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
>
> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Thanks=
.

Reviewed-by: Yu Zhao <yuzhao@google.com>
