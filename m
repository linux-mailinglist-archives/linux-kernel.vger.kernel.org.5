Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C778D1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbjH3BeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbjH3Bdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044AECC2;
        Tue, 29 Aug 2023 18:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92BB562161;
        Wed, 30 Aug 2023 01:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBDCC433CA;
        Wed, 30 Aug 2023 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693359230;
        bh=0IkWF8LrrkyObRBD9S6M92eVSQrptKdvrjNFqTYbTh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sBqkLJjq3J8gxEPjBusB135xbTA5UOCLkbfagRD17UdlcmaBY17aCSS6fWOrotPv5
         QVXyy7jl5FMypEzx8A0xbGM/fIFVuXr7Z3dMeye0WAPSOrYsK2Mg+7hQPbJ6iyijeE
         aheDd9F2vY3bqSHwMlLYX92FP8Z9JRntAxEenQGPLvN4B92PQS/DU3dOOu0sgyGo4O
         c5p6b1YA7+pPUnu/h5hx++0DBW8NSpuwIo3J6RvSX/r3YQEXr50fhshZthjGv+BCvP
         NG1wT+Y5acu6p2KZ2H6aHYV/FsUyT8iZEPMnKtbeTqqbjX5wABZQJeWRfGExtI2kN6
         7mfLQcxhA+BTw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so6959423a12.1;
        Tue, 29 Aug 2023 18:33:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4wGfJmFvjbGgcPAQVWhdPX9SxbrRWnnXGeg4qmIhMKa0WowmF
        +UPv48D1+HSQDSIAkMRM1Lhd+R3HxECeuABnmy0=
X-Google-Smtp-Source: AGHT+IGCP8ODNaDzAW8+JW1AXu0zpQ3+0DluX5V6DB6Sri2Vub35e6FgyVX5YTNW0D4fer6/KebqwvsRN2PrZfv4jp4=
X-Received: by 2002:a05:6402:3442:b0:523:2dd6:62bf with SMTP id
 l2-20020a056402344200b005232dd662bfmr762134edc.34.1693359228198; Tue, 29 Aug
 2023 18:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
 <CAHk-=wjtBk23T4bsA4wxyogvDAP0mWmPPvy=qaMWsySM=WOC9A@mail.gmail.com> <ZO532zzLXSKvpvb0@casper.infradead.org>
In-Reply-To: <ZO532zzLXSKvpvb0@casper.infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 30 Aug 2023 09:33:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQXXMwmSZnWkBgyCS6XYDStgpw4aF5N--Rj-R=tHgfhtA@mail.gmail.com>
Message-ID: <CAJF2gTQXXMwmSZnWkBgyCS6XYDStgpw4aF5N--Rj-R=tHgfhtA@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.6-rc1
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 30, 2023 at 6:57=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Aug 29, 2023 at 02:31:38PM -0700, Linus Torvalds wrote:
> > On Mon, 28 Aug 2023 at 18:43, Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> > >
> > > csky tree, arch/csky/abiv2/cacheflush.c:
> > > https://lkml.kernel.org/r/20230815104604.54f65293@canb.auug.org.au
> >
> > At least this resolution in linux-next was wrong. It would just keep
> > on doing a cache invalidate on the same one-page address range over
> > and over again.
> >
> > I think I did it right, but obviously can't test (and am too lazy to
> > build-test too).
> >
> > Of course, it won't actually matter unless you have large folio on
> > csky, which is probably hard to impossible to trigger in practice, but
> > I thought I'd mention it if for no other reason than Guo Ren to be
> > aware and at least test-build and maybe think about it.
>
> As far as I can tell, csky doesn't enable support for HUGETLBFS nor for
> TRANSPARENT_HUGEPAGE and large folios are currently disabled unless you
> have TRANSPARENT_HUGEPAGE, simply because they rely on infrastructure
> that's only built for TRANSPARENT_HUGEPAGE.  We should probably fix that
> at some point; allocating in larger chunks is beneficial even if you don'=
t
> have PMD sized TLB entries.  But the motivation to do that work has been
> lacking; there are plenty of more important projects in the queue.

Yes, csky (a 32-bit architecture) doesn't have the plan to support HUGEPAGE=
.

So, below only gets one loop and is no different from before, right?
+ for (i =3D 0; i < folio_nr_pages(folio); i++) {

Next, I would test more after folio feature merged.

--=20
Best Regards
 Guo Ren
