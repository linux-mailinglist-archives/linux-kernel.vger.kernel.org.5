Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134F87DCFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbjJaPAu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbjJaPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:00:47 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C78DB;
        Tue, 31 Oct 2023 08:00:44 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e993765c1bso3901079fac.3;
        Tue, 31 Oct 2023 08:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764443; x=1699369243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFk7CTu0sTNMbN/yyWrgJyegrXLrps7A3T0HAuISYtg=;
        b=TBqRDNhMZPjxqN9c4ufMRIhPRwvRX/I7WBFP9K6BHjJUet6lMinKXozb6Vjsl4Kvb4
         9rEQQHAyA8GD14x4X/gEAM4G2PHH3Y7FptQlBpqqW8MoJPfBqrc91yQNg/p4qCB64jow
         NzXFkO2inNw7Fcui/76+6q/GPo0wD6Y3PWR0dmuJ1zShFskyvVPTvh30aKSNBuli6QGU
         YmEL7I3DfBJWrWamsYzJb50OMoK3lCDG9fYDUtIikHZNTxVQ3e3va2knDN+LHCizwXrM
         ABqey31CIoB5WuFLWvGalkEwDbfj30fDpDjkaJXuC3X+AIRinDvqIx5YaOUIfj/Rhh8w
         UM0A==
X-Gm-Message-State: AOJu0Ywma0p1NkutxlBojlCAtGg+EGmiLe5FLMkkwvZSAH20saEE2Zl+
        W3kc9sFQcdZ103xEM1Jz9RjzFenglmadHw==
X-Google-Smtp-Source: AGHT+IE0slbHt809PdGr+3wxZB301IeoV6MzJh77vHSWgA0R0+p8Pq3VrIX79dRBSpqv34URObAhTQ==
X-Received: by 2002:a05:6870:9d82:b0:1f0:b5f:8898 with SMTP id pv2-20020a0568709d8200b001f00b5f8898mr2758642oab.55.1698764441942;
        Tue, 31 Oct 2023 08:00:41 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm891774ybj.50.2023.10.31.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 08:00:41 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7dd65052aso59607207b3.0;
        Tue, 31 Oct 2023 08:00:41 -0700 (PDT)
X-Received: by 2002:a81:ed0b:0:b0:5a7:ccf3:7163 with SMTP id
 k11-20020a81ed0b000000b005a7ccf37163mr11497141ywm.15.1698764441239; Tue, 31
 Oct 2023 08:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
 <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com> <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan>
In-Reply-To: <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Oct 2023 16:00:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
Message-ID: <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs for v6.7
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_SBL_A autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

On Tue, Oct 31, 2023 at 3:45 PM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, Oct 31, 2023 at 01:47:02PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Oct 30, 2023 at 3:56 PM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > >
> > >   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30
> > >
> > > for you to fetch changes up to b827ac419721a106ae2fccaa40576b0594edad92:
> > >
> > >   exportfs: Change bcachefs fid_type enum to avoid conflicts (2023-10-26 16:41:00 -0400)
> > >
> > > ----------------------------------------------------------------
> > > Initial bcachefs pull request for 6.7-rc1
> > >
> > > Here's the bcachefs filesystem pull request.
> > >
> > > One new patch since last week: the exportfs constants ended up
> > > conflicting with other filesystems that are also getting added to the
> > > global enum, so switched to new constants picked by Amir.
> > >
> > > I'll also be sending another pull request later on in the cycle bringing
> > > things up to date my master branch that people are currently running;
> > > that will be restricted to fs/bcachefs/, naturally.
> > >
> > > Testing - fstests as well as the bcachefs specific tests in ktest:
> > >   https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-upstream
> > >
> > > It's also been soaking in linux-next, which resulted in a whole bunch of
> > > smatch complaints and fixes and a patch or two from Kees.
> > >
> > > The only new non fs/bcachefs/ patch is the objtool patch that adds
> > > bcachefs functions to the list of noreturns. The patch that exports
> > > osq_lock() has been dropped for now, per Ingo.
> >
> > Thanks for your PR!
> >
> > >  fs/bcachefs/mean_and_variance.c                 |  159 ++
> > >  fs/bcachefs/mean_and_variance.h                 |  198 ++
> > >  fs/bcachefs/mean_and_variance_test.c            |  240 ++
> >
> > Looking into missing dependencies for MEAN_AND_VARIANCE_UNIT_TEST and
> > failing mean_and_variance tests, this does not seem to match what was
> > submitted for public review?
> >
> > Lore only has:
> > "[PATCH 31/32] lib: add mean and variance module."
> > https://lore.kernel.org/all/20230509165657.1735798-32-kent.overstreet@linux.dev/
>
> It was later moved back into fs/bcachefs/, yes. I want to consolidate
> the time stats code in bcachefs and bcachefs, so I'll be sending a PR to
> move it back out at some point.

OK.

> Can you point me at what's failing?

MEAN_AND_VARIANCE_UNIT_TEST should depend on BCACHEFS_FS, as the actual
mean_and_variance code is only compiled if BCACHEFS_FS is enabled.

On m68k (ARAnyM), it fails with:

KTAP version 1
1..1
    KTAP version 1
    # Subtest: mean and variance tests
    # module: mean_and_variance_test
    1..9
    ok 1 mean_and_variance_fast_divpow2
    ok 2 mean_and_variance_u128_basic_test
    ok 3 mean_and_variance_basic_test
    ok 4 mean_and_variance_weighted_test
    ok 5 mean_and_variance_weighted_advanced_test
    ok 6 mean_and_variance_test_1
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 22 (0x16)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 32 (0x20)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 21 (0x15)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 29 (0x1d)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 20 (0x14)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 28 (0x1c)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 19 (0x13)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 27 (0x1b)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 18 (0x12)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 26 (0x1a)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 17 (0x11)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 25 (0x19)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 16 (0x10)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 24 (0x18)
        stddev[i] == 9 (0x9)
    not ok 7 mean_and_variance_test_2
    ok 8 mean_and_variance_test_3
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 22 (0x16)
        mean[i] == 10 (0xa)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 32 (0x20)
        stddev[i] == 9 (0x9)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 32 (0x20)
        mean[i] == 11 (0xb)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 39 (0x27)
        stddev[i] == 13 (0xd)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 40 (0x28)
        mean[i] == 12 (0xc)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 42 (0x2a)
        stddev[i] == 15 (0xf)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 46 (0x2e)
        mean[i] == 13 (0xd)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 44 (0x2c)
        stddev[i] == 17 (0x11)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 50 (0x32)
        mean[i] == 14 (0xe)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) == stddev[i], but
        mean_and_variance_get_stddev(mv) == 45 (0x2d)
        stddev[i] == 19 (0x13)
    not ok 9 mean_and_variance_test_4
# mean and variance tests: pass:7 fail:2 skip:0 total:9
# Totals: pass:7 fail:2 skip:0 total:9
not ok 1 mean and variance tests

Haven't tried the test on any other platform yet, so this could be a
big-endian, 32-bit, m68k-specific, or even a generic problem.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
