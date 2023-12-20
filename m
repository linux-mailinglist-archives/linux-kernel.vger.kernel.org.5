Return-Path: <linux-kernel+bounces-7143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9C81A229
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A03B25B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BD4C3A8;
	Wed, 20 Dec 2023 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ea01qAV6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5074BAA7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso48685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703085411; x=1703690211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv8bozQkFa6PPje43LsZtl2v4AnPzE/ZYxuMwvQWpw8=;
        b=Ea01qAV6OOoHx5LBJc7o/NA+HR3feawP2Ksa3EXuuE7kiaNlb8z1n/Mh8Rc4WqsEDM
         WHv3vJ0H76hh1iH5AMu/0PB5+3lR+A1X5deulRT4r3Pndi7gP3dGkcqyvQw9EZwXLgla
         WTdAbyK/lD4vEWf8cTfckuNkMuM1DcRx/2wqR6P0w9f9K8RhtiaIP6evZchJaq/Zu5+g
         A5xS3yR/tSiHcw/Jzjr8w+RiwqljtRMlw7Vy/5Dv9xUIaZJILk+5SpsCLZ3q0XTjuYbf
         ZL54mxfg9bVEmaif+siNJAQzwlKmnaaWtablp+PLMfnWRTXFjNW1pL77/+zKgE6KgwuF
         4DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085411; x=1703690211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv8bozQkFa6PPje43LsZtl2v4AnPzE/ZYxuMwvQWpw8=;
        b=RMY73WNk2i5Yts98ynr89DyGZ6yULU5Vyy8/QUE7VN+7O5mDZf7TsB2WLEFAfvAAJe
         sVFbC16mU/i00t78rKez2JI/bU2V8Se3prju042SwczTPa3veXd/lToboP9RuOWAlXmT
         gvBBvitldGYJ8r3BYCCqbsnMVAqiKP1SQnrMluXXko7j+JXtrp3CEKjU8j9Ept/F0Z0h
         nd/9t3NCZM0qE7ZQrVcWma/RIc4CxP/oTimlIs8nknn9uHuCaWo8zKCcjBKlqh3N5R4b
         txuMaVJm9lZu+pJd6m2mwiGb4cqo4NRgv8wtK2SABmkg3sF5YmQwBIyTwu4jGunw112H
         qqPA==
X-Gm-Message-State: AOJu0YylKWsqFpqTQkHkUqjiAL04hHRG0oR4hw4RF2A2PU4OB82wGU4X
	4k6ksnYRJYeCZchjDa4UaakNRqd3DfKvRFPK2Tl5enbvImMk
X-Google-Smtp-Source: AGHT+IGSDIkLfab95qwSdrd1KWtLRBQD93MvXgb37SthLf+GHm1wG0U815RbZ2UX9X8j8ckCuqY2HwzAFfY0u88kcjk=
X-Received: by 2002:a05:600c:1c9a:b0:40d:2bc7:e9b with SMTP id
 k26-20020a05600c1c9a00b0040d2bc70e9bmr171420wms.4.1703085410638; Wed, 20 Dec
 2023 07:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220040037.883811-1-kinseyho@google.com> <CAOUHufaK3X0d9ovEMkFfb3cugqzcnxxqn=o6O-1oohaYANtB0A@mail.gmail.com>
 <7baea98a-90ff-4c2d-9d00-d3ddc715c235@linux.vnet.ibm.com>
In-Reply-To: <7baea98a-90ff-4c2d-9d00-d3ddc715c235@linux.vnet.ibm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 20 Dec 2023 08:16:11 -0700
Message-ID: <CAOUHufZQA+TVo6k+4OXcRXmpUd3GJ3fapXUZidm5TrRDwYXfnw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 0/4] mm/mglru: Kconfig cleanup
To: Donet Tom <donettom@linux.vnet.ibm.com>
Cc: Kinsey Ho <kinseyho@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 6:45=E2=80=AFAM Donet Tom <donettom@linux.vnet.ibm.=
com> wrote:
>
>
> On 12/20/23 09:46, Yu Zhao wrote:
> > On Tue, Dec 19, 2023 at 9:01=E2=80=AFPM Kinsey Ho <kinseyho@google.com>=
 wrote:
> >> This series is the result of the following discussion:
> >> https://lore.kernel.org/47066176-bd93-55dd-c2fa-002299d9e034@linux.ibm=
.com/
> >>
> >> It mainly avoids building the code that walks page tables on CPUs that
> >> use it, i.e., those don't support hardware accessed bit. Specifically,
> >> it introduces a new Kconfig to guard some of functions added by
> >> commit bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> >> on CPUs like POWER9, on which the series was tested.
> >>
> >>
> >> Kinsey Ho (4):
> >>    mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
> >>    mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
> >>    mm/mglru: remove CONFIG_MEMCG
> >>    mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
> >>
> >>   arch/Kconfig                   |   8 +
> >>   arch/arm64/Kconfig             |   1 +
> >>   arch/x86/Kconfig               |   1 +
> >>   arch/x86/include/asm/pgtable.h |   6 -
> >>   include/linux/memcontrol.h     |   2 +-
> >>   include/linux/mm_types.h       |  16 +-
> >>   include/linux/mmzone.h         |  28 +---
> >>   include/linux/pgtable.h        |   2 +-
> >>   kernel/fork.c                  |   2 +-
> >>   mm/Kconfig                     |   4 +
> >>   mm/vmscan.c                    | 271 ++++++++++++++++++-------------=
--
> >>   11 files changed, 174 insertions(+), 167 deletions(-)
> > +Donet Tom <donettom@linux.vnet.ibm.com>
> > who is also working on this.
> >
> > Donet, could try this latest version instead? If it works well as the
> > old one you've been using, can you please provide your Tested-by tag?
> > Thanks.
>
> Hi Yu Zhao,
>
> This patch set looks promising.
>
> I have conducted tests on PowerPC and x86.
>
> In old patch set there is a cleanup patch which removes
> struct scan_control *sc argument from try_to_inc_max_seq() and
> run_aging(), Do we need to include that patch?

Sorry not for including that patch in this series.

It's the first patch in the next cleanup series, which we haven't
fully tested yet. It'll be the first order of business after the
holiday season (mid Jan), does the schedule work for you?

> =3D>Here are some test results from PowerPC.
>
> # ls -l vmscan.o
> -rw-r--r--. 1 root root 3600080 Dec 19 22:35 vmscan.o
>
> # size vmscan.o
>    text       data           bss      dec         hex filename
>    95086      27412          0        122498      1de82 vmscan.o
>
> # ./scripts/bloat-o-meter vmscan.o.old vmscan.o
> add/remove: 4/8 grow/shrink: 7/9 up/down: 860/-2524 (-1664)
> Function                              old       new     delta
> should_abort_scan                      -        472     +472
> inc_max_seq.isra                      1472      1612    +140
> shrink_one                            680       760     +80
> lru_gen_release_memcg                 508       556     +48
> lru_gen_init_pgdat                    92        132     +40
> shrink_node                           4040      4064    +24
> lru_gen_online_memcg                  680       696     +16
> lru_gen_change_state                  3968      3984    +16
> ------
> shrink_lruvec                         2168      2152    -16
> lru_gen_seq_write                     1980      1964    -16
> isolate_folios                        6904      6888    -16
> lru_gen_init_memcg                    32        12      -20
> mm_list                               24        -       -24
> lru_gen_exit_memcg                    388       344     -44
> try_to_shrink_lruvec                  904       816     -88
> lru_gen_rotate_memcg                  832       700     -132
> lru_gen_migrate_mm                    132       -       -132
> lru_gen_seq_show                      1484      1308    -176
> iterate_mm_list_nowalk                288       -       -288
> lru_gen_look_around                   2284      1984    -300
> lru_gen_add_mm                        528       -       -528
> lru_gen_del_mm                        720       -       -720
> Total: Before=3D116213, After=3D114549, chg -1.43%
>
> =3D>Here are some test results from x86.
>
> $ ls -l vmscan.o
> -rw-r--r--. 1 donettom donettom 2545792 Dec 20 15:16 vmscan.o
>
> $ size vmscan.o
>    text          data          bss    dec        hex filename
>    109751        32189         0      141940     22a74 vmscan.o
> $
>
> $ ./scripts/bloat-o-meter vmscan.o.old vmscan.o
> add/remove: 7/3 grow/shrink: 14/4 up/down: 2307/-1534 (773)
> Function                                old       new      delta
> inc_max_seq                             -         1470     +1470
> should_abort_scan                       -         229      +229
> isolate_folios                          4469      4562     +93
> lru_gen_rotate_memcg                    641       731      +90
> lru_gen_init_memcg                      41        99       +58
> lru_gen_release_memcg                   282       336      +54
> lru_gen_exit_memcg                      306       350      +44
> walk_pud_range                          2502      2543     +41
> shrink_node                             2912      2951     +39
> lru_gen_online_memcg                    402       434      +32
> lru_gen_seq_show                        1112      1140     +28
> lru_gen_add_folio                       740       757      +17
> lru_gen_look_around                     1217      1233     +16
> __pfx_should_abort_scan                 -         16       +16
> __pfx_inc_max_seq                       -         16       +16
> iterate_mm_list_nowalk                  277       292      +15
> shrink_one                              413       426      +13
> lru_gen_init_lruvec                     190       202      +12
> -----
> try_to_shrink_lruvec                    717       643      -74
> lru_gen_init_pgdat                      196       82       -114
> try_to_inc_max_seq.isra                 2897      1578     -1319
> Total: Before=3D101095, After=3D101868, chg +0.76%
> $
>
>
> Tested-by: Donet Tom <donettom@linux.vnet.ibm.com>

Thanks!

Acked-by: Yu Zhao <yuzhao@google.com>

