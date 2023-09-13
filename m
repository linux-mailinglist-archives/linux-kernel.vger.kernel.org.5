Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD179F095
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjIMRq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIMRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:46:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FEA19AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502a4f33440so73314e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694627209; x=1695232009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaTGM+r0T4ix55Ks/rV8r7oM4itiRsvvp6UH3VlxOdQ=;
        b=nLNYT44B2Hmz5KRFu6b/7oFMIkxs6cpiAJOUCwiB5bgI3Fn6IOEU5hBc11IbhnzNNM
         hP/1EppfpsYGdLS7IWWm/7gQyzQY8gMJkDAy/yLbdOvnFj70EJD4Xjw/xnwKxCa/0ZEz
         AZjQR4YQEnovO2UtMQ2FyxVN4Y0dUpgtDc0vE7C68mlw0m61dYY2cUL6SFCfpgRcbPZV
         /PvQZejQJezoB/6QvbnJUKazk8gQr8G4TBvHrjosHt9Ts7GEjG4TxzdvwpwL80bMCXOG
         /2M4Qy18VF+oe+/zVsY87g177JveQm9zMunSJoEwIfgQATnH4IYHCzp6uM/8aESvQIBt
         xsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627209; x=1695232009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaTGM+r0T4ix55Ks/rV8r7oM4itiRsvvp6UH3VlxOdQ=;
        b=dfOUQ85+1Xu+uQ3quMvxmZEtFz2xtgwfgi6Kvs9J+q7FCp/bhg/cPogl/0ZC/YRiHi
         qrPMFqv9GoxckndMGEkEmgbznSwoeH8NTmIqsufqLv3duT0sP2tmaxNbNTNX0c99l5pY
         DavlsBVHkcJkWtBANm/ADUjMiM6bZv+St8q/nNiuPniPE2aJa8XoyHpvOFswGeGUl3bq
         hmq6MWD1bNmei9qyXCPpCoJhxsmQfDtvBPMD0NeFY0Y4pvBh0rOyDVa7uUmMOmihsiBJ
         id0R/414gywJuGChXKFbsmZspmjBeVLk8koMbAT1i267tkpv7ACQ2LsF1tbxrXNkaxh9
         KWGg==
X-Gm-Message-State: AOJu0YwzKW7VvfvBpPSs9RzVVS63LB2gr1SKyu1I0MI1uSZtzqLDK/Lr
        ty7C+mYs/VyRd1xv28cF3JK9OZ1sYndgBKrRv7HUwA==
X-Google-Smtp-Source: AGHT+IE8E3aGdajd07Jo/Ih9J3B6jb58k/6rIP3DKaSrxVurSVnQGYrTxs5UZkMcis8uKeqpgsLkQQJT1GTPpmQeX2Q=
X-Received: by 2002:a05:6512:3e26:b0:4fd:ddbc:1577 with SMTP id
 i38-20020a0565123e2600b004fdddbc1577mr3100760lfv.2.1694627209317; Wed, 13 Sep
 2023 10:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 13 Sep 2023 10:46:13 -0700
Message-ID: <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
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
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 5:36=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Evan,
>
> On Fri, Aug 18, 2023 at 9:44=E2=80=AFPM Evan Green <evan@rivosinc.com> wr=
ote:
> > Rather than deferring unaligned access speed determinations to a vendor
> > function, let's probe them and find out how fast they are. If we
> > determine that an unaligned word access is faster than N byte accesses,
> > mark the hardware's unaligned access as "fast". Otherwise, we mark
> > accesses as slow.
> >
> > The algorithm itself runs for a fixed amount of jiffies. Within each
> > iteration it attempts to time a single loop, and then keeps only the be=
st
> > (fastest) loop it saw. This algorithm was found to have lower variance =
from
> > run to run than my first attempt, which counted the total number of
> > iterations that could be done in that fixed amount of jiffies. By takin=
g
> > only the best iteration in the loop, assuming at least one loop wasn't
> > perturbed by an interrupt, we eliminate the effects of interrupts and
> > other "warm up" factors like branch prediction. The only downside is it
> > depends on having an rdtime granular and accurate enough to measure a
> > single copy. If we ever manage to complete a loop in 0 rdtime ticks, we
> > leave the unaligned setting at UNKNOWN.
> >
> > There is a slight change in user-visible behavior here. Previously, all
> > boards except the THead C906 reported misaligned access speed of
> > UNKNOWN. C906 reported FAST. With this change, since we're now measurin=
g
> > misaligned access speed on each hart, all RISC-V systems will have this
> > key set as either FAST or SLOW.
> >
> > Currently, we don't have a way to confidently measure the difference be=
tween
> > SLOW and EMULATED, so we label anything not fast as SLOW. This will
> > mislabel some systems that are actually EMULATED as SLOW. When we get
> > support for delegating misaligned access traps to the kernel (as oppose=
d
> > to the firmware quietly handling it), we can explicitly test in Linux t=
o
> > see if unaligned accesses trap. Those systems will start to report
> > EMULATED, though older (today's) systems without that new SBI mechanism
> > will continue to report SLOW.
> >
> > I've updated the documentation for those hwprobe values to reflect
> > this, specifically: SLOW may or may not be emulated by software, and FA=
ST
> > represents means being faster than equivalent byte accesses. The change
> > in documentation is accurate with respect to both the former and curren=
t
> > behavior.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks for your patch, which is now commit 584ea6564bcaead2 ("RISC-V:
> Probe for unaligned access speed") in v6.6-rc1.
>
> On the boards I have, I get:
>
>     rzfive:
>         cpu0: Ratio of byte access time to unaligned word access is
> 1.05, unaligned accesses are fast

Hrm, I'm a little surprised to be seeing this number come out so close
to 1. If you reboot a few times, what kind of variance do you get on
this?

>
>     icicle:
>
>         cpu1: Ratio of byte access time to unaligned word access is
> 0.00, unaligned accesses are slow
>         cpu2: Ratio of byte access time to unaligned word access is
> 0.00, unaligned accesses are slow
>         cpu3: Ratio of byte access time to unaligned word access is
> 0.00, unaligned accesses are slow
>
>         cpu0: Ratio of byte access time to unaligned word access is
> 0.00, unaligned accesses are slow
>
>     k210:
>
>         cpu1: Ratio of byte access time to unaligned word access is
> 0.02, unaligned accesses are slow
>         cpu0: Ratio of byte access time to unaligned word access is
> 0.02, unaligned accesses are slow
>
>     starlight:
>
>         cpu1: Ratio of byte access time to unaligned word access is
> 0.01, unaligned accesses are slow
>         cpu0: Ratio of byte access time to unaligned word access is
> 0.02, unaligned accesses are slow
>
>     vexriscv/orangecrab:
>
>         cpu0: Ratio of byte access time to unaligned word access is
> 0.00, unaligned accesses are slow
>
> I am a bit surprised by the near-zero values.  Are these expected?
> Thanks!

This could be expected, if firmware is trapping the unaligned accesses
and coming out >100x slower than a native access. If you're interested
in getting a little more resolution, you could try to print a few more
decimal places with something like (sorry gmail mangles the whitespace
on this):

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.=
c
index 1cfbba65d11a..2c094037658a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -632,11 +632,11 @@ void check_unaligned_access(int cpu)
        if (word_cycles < byte_cycles)
                speed =3D RISCV_HWPROBE_MISALIGNED_FAST;

-       ratio =3D div_u64((byte_cycles * 100), word_cycles);
-       pr_info("cpu%d: Ratio of byte access time to unaligned word
access is %d.%02d, unaligned accesses are %s\n",
+       ratio =3D div_u64((byte_cycles * 100000), word_cycles);
+       pr_info("cpu%d: Ratio of byte access time to unaligned word
access is %d.%05d, unaligned accesses are %s\n",
                cpu,
-               ratio / 100,
-               ratio % 100,
+               ratio / 100000,
+               ratio % 100000,
                (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "sl=
ow");

        per_cpu(misaligned_access_speed, cpu) =3D speed;

If you did, I'd be interested to see the results.
-Evan
