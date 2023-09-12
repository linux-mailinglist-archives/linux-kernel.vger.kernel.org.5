Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5C79C428
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbjILDbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjILDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:31:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650099033
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:13:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso56451965e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694484835; x=1695089635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UYT8P+Az/aDX+thtBtGmohMlRv8wMTglFHJw+7ZRyA=;
        b=B51g183fFppTZA9Vpfhdf5qq6quXslk17hmJuztg9PbRyn7i7zdl4SEd0iFTp1LYdd
         toRK40F+xJPuyovHU3La1JF9NFaW1ZdzFHjDM/jl6mlGlRI09xH/2c1/6VGNEgMkP1RV
         z6yYHG18TyCHLHdfoG9k/PuL34N9G87/sDrQgPfjr4pZsxcznnldpcfWZ7vyM1cI6eAF
         0pDBr3Xt2MxkfKzhz8bb5eRBqaZ/49+pzowJ9EFtMvueJ2Ovt8r8uFcyxkie1jWtFQpP
         GRmQdOK8urjAVUeeX5dW+7/IZVSkdcpnKzZMCnKqBM/zTxIhwG9MuU/scvWElj6eLazB
         SzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484835; x=1695089635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UYT8P+Az/aDX+thtBtGmohMlRv8wMTglFHJw+7ZRyA=;
        b=teUK7zN6RVPGLPRBmnun81opFOAiPl1438iCuugLqFngUQv2NYL4nMr+o2o9eBUaeg
         74AyegsAVbQCAybuTLd0MpQmvBhuaF1l1D5UdKUEfdecsJEtA9Xrwn59XWlfFSgBCpup
         ifo70MogGrdF3P5wRUVvIyNzbm2cz8+5iTMmOcBthtsfStaL7Yjw6qdUZEqUB+tMMjdU
         zeUnLR0VvewqngeIp9pKM5aeoxE9oiuJTI1ej74uaZIY+cdZXz+Xu+FEsFN2LK4qG8IK
         gFCZHt/qxdX+hAFeSIM/9InZSGk39BMEg3XdVaDBrRkJtDY2cQalTUxby/r//Qcub0/w
         NOUQ==
X-Gm-Message-State: AOJu0YwDZGM57xOKz6unlEz6mxgfU3DND20mC6ePqV2UyG7nautfUCVU
        t/asXJC4PUN9LH58AdV6jPnaViEHeMPxh2E5VkbWQQ==
X-Google-Smtp-Source: AGHT+IFEBw3uGqO4onJjhH/X7HaKsAARQJMJLAntaYOU/ktDH6byKAC8HTddWq98Y57uIdBtG512WvaoNRzU06e1coE=
X-Received: by 2002:a1c:7719:0:b0:400:2dc5:2006 with SMTP id
 t25-20020a1c7719000000b004002dc52006mr9174781wmi.36.1694484834642; Mon, 11
 Sep 2023 19:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230901123043.73700-1-cuiyunhui@bytedance.com>
 <878r9hvn3m.fsf@all.your.base.are.belong.to.us> <CAEEQ3wnDAJOMo2SZAB23aZgOhBKPmZegC9E048YJaFhiXEkA-A@mail.gmail.com>
 <87r0n8pmso.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0n8pmso.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Tue, 12 Sep 2023 10:13:43 +0800
Message-ID: <CAEEQ3wkPnoyB-35Q3_=Re8EXe3Et330oE8zGrT3DQvuAxaTv1w@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn,

On Sat, Sep 9, 2023 at 2:01=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> yunhui cui <cuiyunhui@bytedance.com> writes:
>
> > Hi Bj=C3=B6rn=EF=BC=8C
> >
> > On Fri, Sep 8, 2023 at 2:45=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
> >>
> >> Yunhui Cui <cuiyunhui@bytedance.com> writes:
> >>
> >> > Add userland instruction dump and rename dump_kernel_instr()
> >> > to dump_instr().
> >> >
> >> > An example:
> >> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> >> > [    0.823817] Run /init as init process
> >> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x00000000000=
5be18 in bb[10000+5fb000]
> >> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049=
-gbd644290aa72-dirty #187
> >> > [    0.841373] Hardware name:  , BIOS
> >> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 000=
0003fffcafda0
> >> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 000=
0000000000000
> >> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 000=
0000000000000
> >> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 000=
0003fffcafe18
> >> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 000=
0000000000000
> >> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000=
0000000000000
> >> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 000=
0000000000000
> >> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 000=
0000000000000
> >> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000=
0000000000000
> >> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 000=
0000000000000
> >> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> >> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 ca=
use: 0000000000000002
> >> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 00=
00 (8053) f002
> >> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! e=
xitcode=3D0x00000004
> >> >
> >> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> > ---
> >> >  arch/riscv/kernel/traps.c | 19 ++++++++++++++++---
> >> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> > index f798c853bede..923b49c38985 100644
> >> > --- a/arch/riscv/kernel/traps.c
> >> > +++ b/arch/riscv/kernel/traps.c
> >> > @@ -33,7 +33,19 @@ int show_unhandled_signals =3D 1;
> >> >
> >> >  static DEFINE_SPINLOCK(die_lock);
> >> >
> >> > -static void dump_kernel_instr(const char *loglvl, struct pt_regs *r=
egs)
> >> > +static int copy_code(struct pt_regs *regs, u16 *val, const u16 *ins=
ns)
> >> > +{
> >> > +     if (!user_mode(regs))
> >> > +             return get_kernel_nofault(*val, insns);
> >> > +
> >> > +     /* The user space code from other tasks cannot be accessed. */
> >> > +     if (regs !=3D task_pt_regs(current))
> >> > +             return -EPERM;
> >> > +
> >> > +     return copy_from_user_nofault(val, insns, sizeof(*val));
> >>
> >> Hmm, I think you missed the actual problem in [1]. I'm still getting:
> >>
> >>   |   CHECK   arch/riscv/kernel/traps.c
> >>   | arch/riscv/kernel/traps.c:46:44: warning: incorrect type in argume=
nt 2 (different address spaces)
> >>   | arch/riscv/kernel/traps.c:46:44:    expected void const [noderef] =
__user *src
> >>   | arch/riscv/kernel/traps.c:46:44:    got unsigned short const [user=
type] *insns
> >>
> >
> > How did the warnings above come about? I don't have one locally. What
> > is your risc-v gcc version?
>
> It's from the "sparse" tool. Pass "C=3D1" to make. Unfortunately RV spars=
e
> needs to be built manually: https://github.com/ConchuOD/sparse
>
>  | make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- C=3D1 W=3D1 arch/=
riscv/kernel/traps.o

I used sparse to check locally and found that there were indeed
warnings. I'll post v6 to solve it.


Thanks=EF=BC=8C
Yunhui
