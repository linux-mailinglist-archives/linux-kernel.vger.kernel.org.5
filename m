Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D617A23E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjIOQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjIOQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:48:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE222271C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:48:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso39347611fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694796507; x=1695401307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f48oEfgEOe9ogBfu1uEucT841SwYN2NFGrQaThSx3KU=;
        b=2cQE2YjAEOZC3zlxhZEtqig0zLQ6M/KpXeJYz3Gq/El+6mTuWGutpCGlU68whKelL3
         4dn2qXOtD17CgJ1TUeg/W1onVvzm5a7isLkQ8CZ/E0l+C1H8H8A6e1rhPb9Jy/5VoBlu
         f6+89BSI/MxmqtUAIL8kwlZWZae9LoJQ+OB9f78+M4X2D2M9gh68P0APrsZpAwZHXkPK
         5hw7CXTAzchSnsmfvaYhQPhPLvsd7BkYOQaIZqtIJ7VN4xypRDhl5wLopX+NrQIFwF14
         hKaen+dEr5AMAKdnY01RPG6bw9FCMFJfN+yjGKJyO+XBcVmkLNFKkpd0MgWUFmu2yuDm
         Ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796507; x=1695401307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f48oEfgEOe9ogBfu1uEucT841SwYN2NFGrQaThSx3KU=;
        b=uJDAiQnUu19C74LV7DvjI1mmRttkIVmWTT4EPlL8LRp77Q3Vu8gTR6xTgscbl8vmys
         gVon3NHjVaxIu+zvq1db2ynV3nyCKmXlwoBZWgltxjn9bEBg5eUAjynCjJQNWlFRokJm
         oaV4h+yDsQrKg8xMvUMDFcsPmx4TgixgcsOhvxe303dnigb6NiB4BBapyqquDjTarDiF
         bVW7atRDx4tj8PT12EvQK/A6TB3bZmIpScuJAFxkQIyoYGrEJYcH+Qnu9ZH/GaDJErG6
         lpcGh0VJnbH8oUHLzARlX9jxQP0ehYWalPi5ewWdCvRfkmHw6quPIrChUBNewkdow+fH
         PDjg==
X-Gm-Message-State: AOJu0YxQBl9WUWLuzP+fwY8fRymZdZUEhzvaSnyLdbAWqwAchnsnQBzA
        UICi/9wxOlVnnkINKV01rzML/rMh6gU3Gs6J+muzeA==
X-Google-Smtp-Source: AGHT+IFyBsKuU+fIikkzmfTWGb2MylxPkm9jEpWf6DwpqcUh3gp60JfTnhUQk8RrjTtyx+LcVvhzhU7p33OTxZwfnXA=
X-Received: by 2002:a05:651c:116:b0:2bd:102c:4161 with SMTP id
 a22-20020a05651c011600b002bd102c4161mr1948688ljb.43.1694796507080; Fri, 15
 Sep 2023 09:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
 <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
 <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com> <CALs-Hstcz3OAxUi80nm+U0R56VBUUPQT=+XMOLpVJsn2ZOcM1A@mail.gmail.com>
 <172bc43cc2ac45239ec40477d53d263a@AcuMS.aculab.com> <CALs-HsvMfrsPsG2b9imLNOJFH6Xk45G0=UPWGtExePiMKV6+1Q@mail.gmail.com>
 <abdde70ac5b947508c8c71d72ec4f294@AcuMS.aculab.com>
In-Reply-To: <abdde70ac5b947508c8c71d72ec4f294@AcuMS.aculab.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 15 Sep 2023 09:47:51 -0700
Message-ID: <CALs-HssjGFjRsQTx5TrjS5TXDY+qFcGuctoP6xM-__P98hB9Bg@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:57=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Evan Green
> > Sent: 14 September 2023 17:37
> >
> > On Thu, Sep 14, 2023 at 8:55=E2=80=AFAM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Evan Green
> > > > Sent: 14 September 2023 16:01
> > > >
> > > > On Thu, Sep 14, 2023 at 1:47=E2=80=AFAM David Laight <David.Laight@=
aculab.com> wrote:
> > > > >
> > > > > From: Geert Uytterhoeven
> > > > > > Sent: 14 September 2023 08:33
> > > > > ...
> > > > > > > >     rzfive:
> > > > > > > >         cpu0: Ratio of byte access time to unaligned word a=
ccess is
> > > > > > > > 1.05, unaligned accesses are fast
> > > > > > >
> > > > > > > Hrm, I'm a little surprised to be seeing this number come out=
 so close
> > > > > > > to 1. If you reboot a few times, what kind of variance do you=
 get on
> > > > > > > this?
> > > > > >
> > > > > > Rock-solid at 1.05 (even with increased resolution: 1.05853 on =
3 tries)
> > > > >
> > > > > Would that match zero overhead unless the access crosses a
> > > > > cache line boundary?
> > > > > (I can't remember whether the test is using increasing addresses.=
)
> > > >
> > > > Yes, the test does use increasing addresses, it copies across 4 pag=
es.
> > > > We start with a warmup, so caching effects beyond L1 are largely no=
t
> > > > taken into account.
> > >
> > > That seems entirely excessive.
> > > If you want to avoid data cache issues (which probably do)
> > > then just repeating a single access would almost certainly
> > > suffice.
> > > Repeatedly using a short buffer (say 256 bytes) won't add
> > > much loop overhead.
> > > Although you may want to do a test that avoids transfers
> > > that cross cache line and especially page boundaries.
> > > Either of those could easily be much slower than a read
> > > that is entirely within a cache line.
> >
> > We won't be faulting on any of these pages, and they should remain in
> > the TLB, so I don't expect many page boundary specific effects. If
> > there is a steep penalty for misaligned loads across a cache line,
> > such that it's worse than doing byte accesses, I want the test results
> > to be dinged for that.
>
> That is an entirely different issue.
>
> Are you absolutely certain that the reason 8 byte loads take
> as long as a 64-bit mis-aligned load isn't because the entire
> test is limited by L1 cache fills?

Fair question. I hacked up a little code [1] to retry the test at
several different sizes, as well as printing out the best and worst
times. I only have one piece of real hardware, the THead C906, which
has a 32KB L1 D-cache.

Here are the results at various sizes, starting with the original:
[    0.047556] cpu0: Ratio of byte access time to unaligned word
access is 4.35, unaligned accesses are fast
[    0.047578] EVAN size 0x1f80 word cycles best 69 worst 29e, byte
cycles best 1c9 worst 3b7
[    0.071549] cpu0: Ratio of byte access time to unaligned word
access is 4.29, unaligned accesses are fast
[    0.071566] EVAN size 0x1000 word cycles best 36 worst 210, byte
cycles best e8 worst 2b2
[    0.095540] cpu0: Ratio of byte access time to unaligned word
access is 4.14, unaligned accesses are fast
[    0.095556] EVAN size 0x200 word cycles best 7 worst 1d9, byte
cycles best 1d worst 1d5
[    0.119539] cpu0: Ratio of byte access time to unaligned word
access is 5.00, unaligned accesses are fast
[    0.119555] EVAN size 0x100 word cycles best 3 worst 1a8, byte
cycles best f worst 1b5
[    0.143538] cpu0: Ratio of byte access time to unaligned word
access is 3.50, unaligned accesses are fast
[    0.143556] EVAN size 0x80 word cycles best 2 worst 1a5, byte
cycles best 7 worst 1aa

[1] https://pastebin.com/uwwU2CVn

I don't see any cliffs as the numbers get smaller, so it seems to me
there are no working set issues. Geert, it might be interesting to see
these same results on the rzfive. The thing that made me uncomfortable
with the smaller buffer sizes is it starts to bump up against the
resolution of the timer. Another option would have been to time
several iterations, but I went with the larger buffer instead as I'd
hoped it would minimize other overhead like the function calls, branch
prediction, C loop management, etc.

-Evan
