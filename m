Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC417A0AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjINQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:37:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78661FDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:37:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bf78950354so18985511fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694709442; x=1695314242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INzY5mzDJkNITQ5vOtkJ6OyVulyDxlKzw3k+lMybVJM=;
        b=guAlihucWu1zM4rFx9cXRd2Y0cikYetfxeCc7beCXaHTgQc5vSYzUi9zTL5XWBLrkh
         LOualqFxGKP9ZUBF/xBhCXb2pJbFw1LCpBHNGMbeSoHUcrF4NacXpG9NhG69n/L8u1ut
         uHJEHLW0TBvW4Js6Cb4Uj3FPpcIxYrYzlZwkDUChUKYlkRJzVAt3J53fdRJ49Xb2Q+L/
         R6O7IhJoB6LzLfsjkTjWxbdQHETXzf5/lqJqRmKb1A+wA1wERxQsXAsLiHixhy03WL7J
         lWwORo0YZEwEeg4VDgC3jazrMrrhdVMuRcv+b5EqbfKBARIL1orYNm35VSa7o3/IWIyS
         2EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709442; x=1695314242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INzY5mzDJkNITQ5vOtkJ6OyVulyDxlKzw3k+lMybVJM=;
        b=CLqpesS+Zd9SciRlHKhpi6eyO3So2bs9bNd6s5w7Z+EIzFrANO+syIn2cMCcDroLav
         EPGezLm+lD13gbsiNbNrjR+UlP2QWbjN4DOVKfiMIEtt3iKxm6iUiEnceX31GrTTDiGW
         xRbjWLv7PtUWuir1qXoGE3ymhzzrv3q/E+uy8cl0WGILtIE3x5RLftqWTd3FKBWOLYkw
         VJMZqd6lNRQej6ZhOM4jZH4PVV645BYDtBSWSP78uqksONnz6CWrTup8bXjV3JJpKcx8
         Fmgs9zftjmGMIFmppKP5tf1f3SMYn39ojRM0PCrC+oymkcIehDd4OWxesK8JbilwQrMN
         Xk4A==
X-Gm-Message-State: AOJu0YzQY1f+Nac6wzxQSSBR9kWiVJ8LXA240qC3jv6Zv+hpdyW03zpI
        aw01jzm8iYkkJ6IyqbmTktzoNQPXPYSgkaGSuHIZ8w==
X-Google-Smtp-Source: AGHT+IGXhAInxFKQbKfHLY9/qgI04l1AFAvp7t0z7LIBOucUx5X+JWNDSTLpNWQ3GuOUiWNkbDCKY1C8vRn4pJDvDqg=
X-Received: by 2002:a2e:9455:0:b0:2bc:c11c:4471 with SMTP id
 o21-20020a2e9455000000b002bcc11c4471mr5726081ljh.21.1694709441979; Thu, 14
 Sep 2023 09:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
 <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
 <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com> <CALs-Hstcz3OAxUi80nm+U0R56VBUUPQT=+XMOLpVJsn2ZOcM1A@mail.gmail.com>
 <172bc43cc2ac45239ec40477d53d263a@AcuMS.aculab.com>
In-Reply-To: <172bc43cc2ac45239ec40477d53d263a@AcuMS.aculab.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 14 Sep 2023 09:36:45 -0700
Message-ID: <CALs-HsvMfrsPsG2b9imLNOJFH6Xk45G0=UPWGtExePiMKV6+1Q@mail.gmail.com>
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

On Thu, Sep 14, 2023 at 8:55=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Evan Green
> > Sent: 14 September 2023 16:01
> >
> > On Thu, Sep 14, 2023 at 1:47=E2=80=AFAM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Geert Uytterhoeven
> > > > Sent: 14 September 2023 08:33
> > > ...
> > > > > >     rzfive:
> > > > > >         cpu0: Ratio of byte access time to unaligned word acces=
s is
> > > > > > 1.05, unaligned accesses are fast
> > > > >
> > > > > Hrm, I'm a little surprised to be seeing this number come out so =
close
> > > > > to 1. If you reboot a few times, what kind of variance do you get=
 on
> > > > > this?
> > > >
> > > > Rock-solid at 1.05 (even with increased resolution: 1.05853 on 3 tr=
ies)
> > >
> > > Would that match zero overhead unless the access crosses a
> > > cache line boundary?
> > > (I can't remember whether the test is using increasing addresses.)
> >
> > Yes, the test does use increasing addresses, it copies across 4 pages.
> > We start with a warmup, so caching effects beyond L1 are largely not
> > taken into account.
>
> That seems entirely excessive.
> If you want to avoid data cache issues (which probably do)
> then just repeating a single access would almost certainly
> suffice.
> Repeatedly using a short buffer (say 256 bytes) won't add
> much loop overhead.
> Although you may want to do a test that avoids transfers
> that cross cache line and especially page boundaries.
> Either of those could easily be much slower than a read
> that is entirely within a cache line.

We won't be faulting on any of these pages, and they should remain in
the TLB, so I don't expect many page boundary specific effects. If
there is a steep penalty for misaligned loads across a cache line,
such that it's worse than doing byte accesses, I want the test results
to be dinged for that.

>
> ...
> > > > > >     vexriscv/orangecrab:
> > > > > >
> > > > > >         cpu0: Ratio of byte access time to unaligned word acces=
s is
> > > > > > 0.00, unaligned accesses are slow
> > > >
> > > > cpu0: Ratio of byte access time to unaligned word access is 0.00417=
,
> > > > unaligned accesses are slow
> > > >
> > > > > > I am a bit surprised by the near-zero values.  Are these expect=
ed?
> > > > >
> > > > > This could be expected, if firmware is trapping the unaligned acc=
esses
> > > > > and coming out >100x slower than a native access. If you're inter=
ested
> > > > > in getting a little more resolution, you could try to print a few=
 more
> > > > > decimal places with something like (sorry gmail mangles the white=
space
> > > > > on this):
> > >
> > > I'd expect one of three possible values:
> > > - 1.0x: Basically zero cost except for cache line/page boundaries.
> > > - ~2: Hardware does two reads and merges the values.
> > > - >100: Trap fixed up in software.
> > >
> > > I'd think the '2' case could be considered fast.
> > > You only need to time one access to see if it was a fault.
> >
> > We're comparing misaligned word accesses with byte accesses of the
> > same total size. So 1.0 means a misaligned load is basically no
> > different from 8 byte loads. The goal was to help people that are
> > forced to do odd loads and stores decide whether they are better off
> > moving by bytes or by misaligned words. (In contrast, the answer to
> > "should I do a misaligned word load or an aligned word load" is
> > generally always "do the aligned one if you can", so comparing those
> > two things didn't seem as useful).
>
> Ah, I'd have compared the cost of aligned accesses with misaligned ones.
> That would tell you whether you really need to avoid them.
> The cost of byte and aligned word accesses should be much the same
> (for each access that is) - if not you've got a real bottleneck.
>
> If a misaligned access is 8 times slower than an aligned one
> it is still 'quite slow'.
> I'd definitely call that 8 not 1 - even if you treat it as 'fast'.

The number itself isn't exported or saved anywhere, it's just printed
as diagnostic explanation into the final fast/slow designation.

Misaligned word loads are never going to be faster than aligned ones,
and aren't really going to be equal either. It's also generally not
something that causes software a lot of angst: we align most of our
buffers and structures with help from the compiler, and generally do
an aligned access whenever possible. It's the times when we're forced
to do odd sizes or accesses we know are already misaligned that this
hwprobe bit was designed to help. In those cases, users are forced to
decide if they should do a misaligned word access or byte accesses, so
we aim to provide that result.

If there's a use case for knowing "misaligned accesses are exactly as
fast as aligned ones", we could detect this threshold in the same
test, and add another hwprobe bit for it.

-Evan

>
> For comparison you (well I) can write x64-64 asm for the ip-checksum
> loop that will execute 1 memory read every clock (8 bytes/clock).
> It is very slightly slower for misaligned buffers, but by less
> than 1 clock per cache line.
> That's what I'd call 1.0 :-)
>
> I'd expect even simple hardware to do misaligned reads as two
> reads and then merge the data - so should really be no slower
> than two separate aligned reads.
> Since you'd expect a cpu to do an L1 data cache read every clock
> (probably pipelined) the misaligned read should just add 1 clock.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
