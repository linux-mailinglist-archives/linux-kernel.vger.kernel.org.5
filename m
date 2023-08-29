Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185478BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjH2EL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjH2EK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E9102;
        Mon, 28 Aug 2023 21:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C465C60C0B;
        Tue, 29 Aug 2023 04:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D5BC433C9;
        Tue, 29 Aug 2023 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693282253;
        bh=e61YW9z8sSyOydpn/mt7ysbYiNTT8b66TH3zeN8UZh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p984stq2u6i10BhDiL84RSW02XukBbdYjBt1uVcOWbv3XdI4yDdIgMnzKIX9kEOZY
         M7FsXAxRTpgC7bY2HFEa7Rrv66D/P79FIiuOXWlVzcyFeloqa6rW7G/Q1X7e3DBbEY
         dZHVRXtCyho8Q9p6EPHqMFaK8X/rncNLC+UN2xZPORbEWqN6neBuc7nPxDX2ZyMBfH
         g9v4o960OpY6gR5OQe1gJ1hZiDVT6jcHxDdLNWmHhq7NFkgLpmSAWzub+GNHARUNrr
         7kyfQ4EzN5O1AmiCk/0qDe0gO+Glo//8AhW4K5DTa0uJ8I3yILCu5Q/1LxQREyR9m2
         mSYzXJu49f2Gg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso502274266b.1;
        Mon, 28 Aug 2023 21:10:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yym/ORkHTcbz20a59sf7ETGXt2GBJoDyVgmOT7T9PQMC/iCNRya
        aq8RaQgfVMlE06SIZbnj409sH8knC45uRdBJZvk=
X-Google-Smtp-Source: AGHT+IHTBqcN7JgEZEiZ4TVhXOQ4t2Usjo3CZ733GSFdr/OaQwtN/JiOsIalrYiZ9NBQJg1woMFxbv/8ZdR6civzsug=
X-Received: by 2002:a17:907:60c6:b0:9a2:ecd:d95d with SMTP id
 hv6-20020a17090760c600b009a20ecdd95dmr10056677ejc.68.1693282251436; Mon, 28
 Aug 2023 21:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150220.31624576@canb.auug.org.au> <106e0bb2-1fa6-5914-67f6-269755779e61@infradead.org>
In-Reply-To: <106e0bb2-1fa6-5914-67f6-269755779e61@infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 29 Aug 2023 12:10:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Qr1wVOqmha_beug+ub6kkg+q+PeHGE_vpeoYPOKYKyg@mail.gmail.com>
Message-ID: <CAAhV-H7Qr1wVOqmha_beug+ub6kkg+q+PeHGE_vpeoYPOKYKyg@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 28 (loongarch: kgdb)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

On Tue, Aug 29, 2023 at 8:38=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 8/27/23 22:02, Stephen Rothwell wrote:
> > Hi all,
> >
> > Please do *not* include material destined for v6.7 in your linux-next
> > included branches until *after* v6.6-rc1 has been released.  Also,
> > do *not* rebase you linu-next included branches onto v6.5.
> >
> > Changes since 20230825:
> >
>
> There are many build errors when CONFIG_PERF_EVENTS =3D> HAVE_HW_BREAKPOI=
NT
> are not set.
> This is a reduced list of the build errors:
>
> ../arch/loongarch/kernel/kgdb.c: In function 'hw_break_reserve_slot':
> ../arch/loongarch/kernel/kgdb.c:515:21: error: implicit declaration of fu=
nction 'dbg_reserve_bp_slot'; did you mean 'reserve_bp_slot'? [-Werror=3Dim=
plicit-function-declaration]
>   515 |                 if (dbg_reserve_bp_slot(*pevent))
>       |                     ^~~~~~~~~~~~~~~~~~~
>       |                     reserve_bp_slot
> ../arch/loongarch/kernel/kgdb.c:527:17: error: implicit declaration of fu=
nction 'dbg_release_bp_slot'; did you mean 'release_bp_slot'? [-Werror=3Dim=
plicit-function-declaration]
>   527 |                 dbg_release_bp_slot(*pevent);
>       |                 ^~~~~~~~~~~~~~~~~~~
>       |                 release_bp_slot
> ../arch/loongarch/kernel/kgdb.c: In function 'kgdb_disable_hw_break':
> ../arch/loongarch/kernel/kgdb.c:640:23: error: 'struct perf_event' has no=
 member named 'attr'
>   640 |                 if (bp->attr.disabled =3D=3D 1)
>       |                       ^~
> ../arch/loongarch/kernel/kgdb.c: In function 'kgdb_arch_late':
> ../arch/loongarch/kernel/kgdb.c:732:9: error: implicit declaration of fun=
ction 'hw_breakpoint_init'; did you mean 'hw_breakpoint_slots'? [-Werror=3D=
implicit-function-declaration]
>   732 |         hw_breakpoint_init(&attr);
>       |         ^~~~~~~~~~~~~~~~~~
>       |         hw_breakpoint_slots
> ../arch/loongarch/kernel/kgdb.c:752:38: error: 'struct perf_event' has no=
 member named 'destroy'
>   752 |                         if (pevent[0]->destroy) {
>       |                                      ^~
> cc1: some warnings being treated as errors
Thank you very much for pointing out, I will fix it later.

Huacai
>
>
> --
> ~Randy
>
