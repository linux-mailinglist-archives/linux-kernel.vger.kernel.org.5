Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785F7A085E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjINPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjINPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:01:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F61FC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:01:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso17258041fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694703698; x=1695308498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lwTM7NAptIePULa3PTJyJA+6Q6I8uSQc1kUpAUbvFQ=;
        b=1Syv2zJWmxiQ6pPkv2QJ51AApAxlWXTsG487yIIBvCUp4u6gerOaHS4mMOFmERmI0K
         0+UG2zO6JGeCPFk7eIaZp4n62HSQ2o1CMOWpQqo6nQRlGVtaSI//orjgQeAmAtGE//+L
         GwesjaYoI7DSsnO7UbuL+M1Ul4WJDxe2lK5TnJS33AeLKakwPlb6KMRE2p8+CEpS6A5U
         ZUcNoGRBZ4ScGRwIVyl9FLwafX1z8G7UauBF5R5nPLb3TpRAeNrCagPochqc/yVpiE7q
         /Q7WrYqVTEoqxiz0yAMOWHEkjb5aHd3WsIln1u9rJ+bvT/NF+h3S/xGZWdppCw501xcv
         YyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703698; x=1695308498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lwTM7NAptIePULa3PTJyJA+6Q6I8uSQc1kUpAUbvFQ=;
        b=dpu2592IhLYUcS+/nPVVj2yt4dwZnlTZrN8LCKIw4uiTgu82OMCOQnBCR0oO5XdNYL
         BazMs1XquB6GKXCI8T2lJ1rUtjoF9NXd8gPzuxE26raLfTdDHMNUPFBgo2L9RR2mVltP
         LZIokl9Wrv61qcKC0PAolvd+I+Dq5VjoL+1Ux0AWEzml1UrxvArpaZehImTJnCK9TDTZ
         VXuql7+xTdDV09zZ+nDTZdqV+Z6yd2CQx3x4KECctKTaBkPITI5XS7DoFY448wnpW5c3
         aRGD4v7oGmcYko7l2UNcmDFlr3hMPp7MP7taOmciXJwl63c4RDjIFMtyDtLiNEGzHa7U
         0Olw==
X-Gm-Message-State: AOJu0YzGRcrfg1HzvK8OsbLukA2McmNHkv1VrmC4OGqnEhd5togEuaT2
        yZx5zscHxYSPl/KJt6+EbJ1bjawI8rA7SAfQSF9Jbg==
X-Google-Smtp-Source: AGHT+IFcyTtDdaB1eVUQNQHCHqX6jsxMHYXjYH0JAqO643ytu1xJEJomtzaxCmNjZVzVVmvB2enLxjJb9sajIitl9Q0=
X-Received: by 2002:a05:6512:39c2:b0:500:bddc:56d5 with SMTP id
 k2-20020a05651239c200b00500bddc56d5mr5478034lfu.37.1694703697683; Thu, 14 Sep
 2023 08:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
 <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com> <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com>
In-Reply-To: <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 14 Sep 2023 08:01:01 -0700
Message-ID: <CALs-Hstcz3OAxUi80nm+U0R56VBUUPQT=+XMOLpVJsn2ZOcM1A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
To:     David Laight <David.Laight@aculab.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 1:47=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Geert Uytterhoeven
> > Sent: 14 September 2023 08:33
> ...
> > > >     rzfive:
> > > >         cpu0: Ratio of byte access time to unaligned word access is
> > > > 1.05, unaligned accesses are fast
> > >
> > > Hrm, I'm a little surprised to be seeing this number come out so clos=
e
> > > to 1. If you reboot a few times, what kind of variance do you get on
> > > this?
> >
> > Rock-solid at 1.05 (even with increased resolution: 1.05853 on 3 tries)
>
> Would that match zero overhead unless the access crosses a
> cache line boundary?
> (I can't remember whether the test is using increasing addresses.)

Yes, the test does use increasing addresses, it copies across 4 pages.
We start with a warmup, so caching effects beyond L1 are largely not
taken into account.

>
> ...
> > > >     vexriscv/orangecrab:
> > > >
> > > >         cpu0: Ratio of byte access time to unaligned word access is
> > > > 0.00, unaligned accesses are slow
> >
> > cpu0: Ratio of byte access time to unaligned word access is 0.00417,
> > unaligned accesses are slow
> >
> > > > I am a bit surprised by the near-zero values.  Are these expected?
> > >
> > > This could be expected, if firmware is trapping the unaligned accesse=
s
> > > and coming out >100x slower than a native access. If you're intereste=
d
> > > in getting a little more resolution, you could try to print a few mor=
e
> > > decimal places with something like (sorry gmail mangles the whitespac=
e
> > > on this):
>
> I'd expect one of three possible values:
> - 1.0x: Basically zero cost except for cache line/page boundaries.
> - ~2: Hardware does two reads and merges the values.
> - >100: Trap fixed up in software.
>
> I'd think the '2' case could be considered fast.
> You only need to time one access to see if it was a fault.

We're comparing misaligned word accesses with byte accesses of the
same total size. So 1.0 means a misaligned load is basically no
different from 8 byte loads. The goal was to help people that are
forced to do odd loads and stores decide whether they are better off
moving by bytes or by misaligned words. (In contrast, the answer to
"should I do a misaligned word load or an aligned word load" is
generally always "do the aligned one if you can", so comparing those
two things didn't seem as useful).

We opted for 1.0 as a cutoff, since even at 1.05, you get a boost from
doing misaligned word loads over byte copies. I asked about the
variance because I don't want to see machines that change their mind
from boot to boot. I originally considered trying to create a "gray
zone" where the answer goes back to UNKNOWN, but in the end that just
moves the fiddly point rather than really eliminating it.

You're right that in theory we just need one perfect access to test,
but testing only once makes it susceptible to hiccups. We went with
doing it many times in a fixed period and taking the minimum to
hopefully remove noise like NMI-like things, branch prediction misses,
or cache eviction.

Geert,
Thanks for providing the numbers. Yes, we could add another digit to
the print. Though if you already know you're at least 100x slower,
maybe knowing exactly how much slower isn't super meaningful, just
very much avoid unaligned accesses on these systems :). Hopefully over
time the number of systems like this will dwindle.

-Evan
