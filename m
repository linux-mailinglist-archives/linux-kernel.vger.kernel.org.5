Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72897987AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbjIHNQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIHNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:16:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C819B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:15:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso22724295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694178940; x=1694783740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yqcWt1Hglud++CQfzsuwf09IKfawpsHYMpmq0AjR8Y=;
        b=hbZetuWjfip9IyRTt/PIMFzKpEHgluPYzsjn1TjLrS+sotnp9zI2wOia4g85Zbt3BF
         rPm+9XFDoqs2k2yyYYX0X/sU2xE6OS8Zp+Bh4rDA7d6bZF+j0Efk3WJ3ONmejXgTQzl2
         SZsSadKdc8kMhRsrx2ifBM0BgA1HWffp3nKuOYpIFFc6/lTywhxkAQxmQp/AOYa23pH9
         YZVGrJY2BDzNt3JOr2NDE+miwb1zH0ezwIXJU13ixUaR6444ZZ3JjcBiCHbztZLqFWIj
         fJRx9fBKoty75JYX1kQoKUn1I1QWsS+5uCjiYIG8AmmnHVL9Dq4YMZD0iaQQWnFMHTg3
         WUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694178940; x=1694783740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yqcWt1Hglud++CQfzsuwf09IKfawpsHYMpmq0AjR8Y=;
        b=anMvoFiZHZn7Sq6yueSI3JRBJZLX09SfAoQtijUHfSxeeRCaRrtWnyTmjYovV5YYHq
         mMvXGJCAEEqTN0zsR5yczbuEVPARxXsjn3VaE7/h1EpQu2qT84Hc0qVsrcATFZudzYA+
         YvC5Se6lVI4Z85jgmW1LpAdBdCh3xl3Nz6w3bTxoju1zh5Mw95EN4CbB4HhntVDgk/hm
         XTaFEZ6swOAU0qY18P5AMQda7hOFToUNPuJGQskhsEv9v22A265mxgRLdlvl0yA286wp
         NJTiIMnJd3StF+hFrQk7PtRMi4aolLbiOghWi6D+d8f26D6vc7ZkDtaabr+vgJn3o+Uo
         x9Rg==
X-Gm-Message-State: AOJu0Yx4jSbHqOcSN77cZm9YDyfsEMP0y1BdMfRs9oG6QA9hlXkiao1O
        R4J8yHeziJc6xZ44xGbcu4bgZq4RK8S0jpSfTAtpjg==
X-Google-Smtp-Source: AGHT+IEqG2gHm77D4R94T0nPTziGoxtx/t04mDshmmzgzQlaZtiktBRrZdCc6fRZT9fX5FgfUeD8n07AkMBwtMkZ0bg=
X-Received: by 2002:a05:6000:cd:b0:314:3a4b:6cc6 with SMTP id
 q13-20020a05600000cd00b003143a4b6cc6mr2072972wrx.53.1694178939673; Fri, 08
 Sep 2023 06:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230901123043.73700-1-cuiyunhui@bytedance.com> <878r9hvn3m.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <878r9hvn3m.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Fri, 8 Sep 2023 21:15:28 +0800
Message-ID: <CAEEQ3wnDAJOMo2SZAB23aZgOhBKPmZegC9E048YJaFhiXEkA-A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5] riscv: add userland instruction dump to
 RISC-V splats
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn=EF=BC=8C

On Fri, Sep 8, 2023 at 2:45=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>
> > Add userland instruction dump and rename dump_kernel_instr()
> > to dump_instr().
> >
> > An example:
> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> > [    0.823817] Run /init as init process
> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be=
18 in bb[10000+5fb000]
> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gb=
d644290aa72-dirty #187
> > [    0.841373] Hardware name:  , BIOS
> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 000000=
3fffcafda0
> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 000000=
0000000000
> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 000000=
0000000000
> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 000000=
3fffcafe18
> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 000000=
0000000000
> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000000=
0000000000
> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 000000=
0000000000
> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 000000=
0000000000
> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000000=
0000000000
> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 000000=
0000000000
> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause=
: 0000000000000002
> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 =
(8053) f002
> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000004
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/traps.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f798c853bede..923b49c38985 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -33,7 +33,19 @@ int show_unhandled_signals =3D 1;
> >
> >  static DEFINE_SPINLOCK(die_lock);
> >
> > -static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs=
)
> > +static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
> > +{
> > +     if (!user_mode(regs))
> > +             return get_kernel_nofault(*val, insns);
> > +
> > +     /* The user space code from other tasks cannot be accessed. */
> > +     if (regs !=3D task_pt_regs(current))
> > +             return -EPERM;
> > +
> > +     return copy_from_user_nofault(val, insns, sizeof(*val));
>
> Hmm, I think you missed the actual problem in [1]. I'm still getting:
>
>   |   CHECK   arch/riscv/kernel/traps.c
>   | arch/riscv/kernel/traps.c:46:44: warning: incorrect type in argument =
2 (different address spaces)
>   | arch/riscv/kernel/traps.c:46:44:    expected void const [noderef] __u=
ser *src
>   | arch/riscv/kernel/traps.c:46:44:    got unsigned short const [usertyp=
e] *insns
>

How did the warnings above come about? I don't have one locally. What
is your risc-v gcc version?

This is mine:

/opt/riscv/bin/riscv64-unknown-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3D/opt/riscv/bin/riscv64-unknown-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/opt/riscv/libexec/gcc/riscv64-unknown-linux-gnu/12.2=
.0/lto-wrapper
Target: riscv64-unknown-linux-gnu
Configured with: .../riscv-gnu-toolchain/gcc/configure
--target=3Driscv64-unknown-linux-gnu --prefix=3D/opt/riscv
--with-sysroot=3D/opt/riscv/sysroot --with-pkgversion=3Dg2ee5e430018
--with-system-zlib --enable-shared --enable-tls
--enable-languages=3Dc,c++,fortran --disable-libmudflap --disable-libssp
--disable-libquadmath --disable-libsanitizer --disable-nls
--disable-bootstrap --src=3D.../riscv_acpi/riscv-gnu-toolchain/gcc
--disable-multilib --with-abi=3Dlp64d --with-arch=3Drv64imafdc
--with-tune=3Drocket --with-isa-spec=3D2.2 'CFLAGS_FOR_TARGET=3D-O2
-mcmodel=3Dmedlow' 'CXXFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 12.2.0 (g2ee5e430018)

Thanks,
Yunhui
