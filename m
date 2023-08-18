Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96062780B80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376779AbjHRMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376787AbjHRMEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:04:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228CA3C0F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:04:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313e742a787so513358f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692360268; x=1692965068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZdQfOSfjb7jYvSj08bFptXj69b81GU/KGqpyvuaZ5w=;
        b=iDsrk9/cifcSjXR+nr+gTAPzO+df+W0llBMvPiBUMarijotRiy2Am70KIeL5imF6Kx
         m5133LT8vky4Od4sX1UwDrhvkYpf7h9mJWCPl4D1NVuFx6veBut1QaFGDMTQ8gDazyez
         UBgNJPsHeDx07e6xmg5kdAFibsl4hSS+sCR3FPlpHgsS0yd80Xs9fVO3b2OzvM6lFl71
         dNjrnpelzhALDCXHYbCLgnH0lX4dp802k3maSlKHrh2Yo970U/5TbtsA9VSRRgfqlnzb
         P0ndWMga1p8lEARrJmhRa3H5VwShenvVI8kfRx2U3xLxmsX2YMmCJ44/ZIeawj0uW2nN
         JKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692360268; x=1692965068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZdQfOSfjb7jYvSj08bFptXj69b81GU/KGqpyvuaZ5w=;
        b=dPyZhWck2t993EA69oX6tx4sWZ/BzhrsalDfLGn/zITRKqaAIH9B+z6cAQraTAY8xW
         pEY9HdLZ540IJPc8wOyH1fuZogzHec46LZr7tB/Ez1unp9Q0qFoJQ5CQpt89miknoMOn
         8JnPybQXECIKg8bEeTca0iXtrAHwY4ppqtGSQlelxjhBQDAWWSeZ9QkziuWrevmNty90
         cXM5ZVCsClURwCfqGTMZ53Z3lS4YlY9Uk1/9zuoboX1FH4p3tM+I6K83FveYsa+sczcM
         0KBo96KRXFdULjIEOuiXNOB7PA6JeyAN5efDXErVXEYl1s5LdLLtFLr+56iZgRe6274A
         zuFw==
X-Gm-Message-State: AOJu0Yw8IFl328BbkB94NtdftauL1hvf+L5NrbtI4NbONd1Y8VsGXtx/
        xKnPdgkfTmePaCMBDkGIYr3agVu8mrXhYK/dZsuQWA==
X-Google-Smtp-Source: AGHT+IEkfjwtc76KHGFOS61DemLriDUYPGx1HD/1+fhhgM0utSuzqb3nhbuUGfwJ7daMooYnhiIRVXybkfCzmjvKChI=
X-Received: by 2002:a05:6000:1106:b0:317:dcdd:3fa2 with SMTP id
 z6-20020a056000110600b00317dcdd3fa2mr1456519wrw.31.1692360268611; Fri, 18 Aug
 2023 05:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230817114130.24662-1-cuiyunhui@bytedance.com> <87msyphk99.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msyphk99.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Fri, 18 Aug 2023 20:04:17 +0800
Message-ID: <CAEEQ3wn13-etJ=3OHA7yR2GtYYWkKNb6G0DiDjVwqfxGvZOLfw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] riscv: add userland instruction dump to
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
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn=EF=BC=8C

On Thu, Aug 17, 2023 at 9:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>
> > Added userland instruction dump in dump_kernel_instr().
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
> >  arch/riscv/kernel/traps.c | 10 +++++++---
> >  include/linux/uaccess.h   |  5 +++++
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f910dfccbf5d..a6a850e42d59 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -33,7 +33,7 @@ int show_unhandled_signals =3D 1;
> >
> >  static DEFINE_SPINLOCK(die_lock);
> >
> > -static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs=
)
> > +static void dump_instr(const char *loglvl, struct pt_regs *regs)
> >  {
> >       char str[sizeof("0000 ") * 12 + 2 + 1], *p =3D str;
> >       const u16 *insns =3D (u16 *)instruction_pointer(regs);
> > @@ -42,7 +42,10 @@ static void dump_kernel_instr(const char *loglvl, st=
ruct pt_regs *regs)
> >       int i;
> >
> >       for (i =3D -10; i < 2; i++) {
> > -             bad =3D get_kernel_nofault(val, &insns[i]);
> > +             if (user_mode(regs))
> > +                     bad =3D get_user_nofault(val, &insns[i]);
> > +             else
> > +                     bad =3D get_kernel_nofault(val, &insns[i]);
> >               if (!bad) {
> >                       p +=3D sprintf(p, i =3D=3D 0 ? "(%04hx) " : "%04h=
x ", val);
> >               } else {
> > @@ -71,7 +74,7 @@ void die(struct pt_regs *regs, const char *str)
> >       print_modules();
> >       if (regs) {
> >               show_regs(regs);
> > -             dump_kernel_instr(KERN_EMERG, regs);
> > +             dump_instr(KERN_EMERG, regs);
> >       }
> >
> >       cause =3D regs ? regs->cause : -1;
> > @@ -104,6 +107,7 @@ void do_trap(struct pt_regs *regs, int signo, int c=
ode, unsigned long addr)
> >               print_vma_addr(KERN_CONT " in ", instruction_pointer(regs=
));
> >               pr_cont("\n");
> >               __show_regs(regs);
> > +             dump_instr(KERN_EMERG, regs);
> >       }
> >
> >       force_sig_fault(signo, code, (void __user *)addr);
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 3064314f4832..ba8cb37a7241 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -385,6 +385,11 @@ long strncpy_from_user_nofault(char *dst, const vo=
id __user *unsafe_addr,
> >               long count);
> >  long strnlen_user_nofault(const void __user *unsafe_addr, long count);
> >
> > +#define get_user_nofault(val, ptr) ({                                \
> > +     const typeof(val) *__gk_ptr =3D (ptr);                    \
> > +     copy_from_user_nofault(&(val), __gk_ptr, sizeof(val));\
> > +})
> > +
>
> Your previous version had a check:
>   |         /* The user space code from other tasks cannot be accessed. *=
/
>   |         if (regs !=3D task_pt_regs(current))
>   |                 return -EPERM;
>
> Why was that left out? Is it not needed?
>
> Your get_user_nofault is only used in this file, so maybe it's better to
> do what x86 does, and introduce a static "copy_code()" that deals with
> the user/kernel checks/copy?
Okay=EF=BC=8C i=E2=80=98ll update it to v4.

Thanks=EF=BC=8C
Yunhui
