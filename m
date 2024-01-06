Return-Path: <linux-kernel+bounces-18486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7ED825E48
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096761F2412C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DEC33FB;
	Sat,  6 Jan 2024 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="FL3LgGys"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E01FAA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so2162391fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1704517658; x=1705122458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdsJvNw+S61yFx06ykjDuNz71ruDBHUkh0JS9Shi/8o=;
        b=FL3LgGysgIsX1IrvoSDup0WkB1AiMBXDXjqTpWsNTL5nOGovVEiXnCQQ3Ci8MvWXmi
         10vY08IulJFLKSdNMh7HLZiQYkZWtdw5bWYlkVluch4P2Maj2jFZ3fKG9azZanxbgBZo
         0U7aauIBPkV2aXBR84KtXionwxc/ZnkX0IxuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704517658; x=1705122458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdsJvNw+S61yFx06ykjDuNz71ruDBHUkh0JS9Shi/8o=;
        b=tkL+IS7SX/V2hs+SGdQX463uE/mBDRYGjuocVp3Yg7Xc+Gg3Q7/VZ+ZaJJwyNeHkVi
         BQhATpZGK8A/122Z44cp9UjxOaNzuK+Aorz4UPsPiui5KzzjKgxY+nLxvKrNmRUdttkg
         XhrGIkmlqS9CTmmC7xoqbuthzU63KHqN7FcUizedcln8er3vMbuUdC36FhOdoBJ/+ZAs
         e7K4qEA6eMqB8DzecTvi5qRWnSyrsbFK8hw1WjuaJ03dSGzcTvvzRppGDM0FpiPSYXtY
         Zm55HGIot3Xz0pI0MsFv+dhp0zFyfmEAlrAW6jW8fF/UbodpeNNkb6108hsWNMtkjZhQ
         01PQ==
X-Gm-Message-State: AOJu0Yzwhe/+6uz8O4Y4qh89C6iNN0DorLDmb/C1JtGsNQZjPW9VpcnZ
	Iqfjk0bpezKGlCR4N9gMjD+hEJE92lpC0pZ/gkDMmpNeeVad
X-Google-Smtp-Source: AGHT+IHV1AaqA8Lv+NfpC3I7Lvu9C4ode3QKecQzGTshHx1YABmNu+HST49TV5RcvY3UVlKOb2VZJssIbgdqVPhuQsA=
X-Received: by 2002:a05:651c:22b:b0:2cc:a253:a4a4 with SMTP id
 z11-20020a05651c022b00b002cca253a4a4mr169403ljn.21.1704517657577; Fri, 05 Jan
 2024 21:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-fencei-v3-0-b75158238eb7@rivosinc.com>
 <20231213-fencei-v3-2-b75158238eb7@rivosinc.com> <CAOnJCULhAMmz22bH6A5AXv7aaJpH8SVGBATQyx-bfKAn4eFxsQ@mail.gmail.com>
 <ZZjOl1zDhUYbzpF9@ghost>
In-Reply-To: <ZZjOl1zDhUYbzpF9@ghost>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 5 Jan 2024 21:07:26 -0800
Message-ID: <CAOnJCUJ4ESeh1GxKhjdxRjFpV4R+TwxEB+uhJwgjN6xVhVZa5w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX
 prctl
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 7:52=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Fri, Jan 05, 2024 at 06:52:12PM -0800, Atish Patra wrote:
> > On Wed, Dec 13, 2023 at 2:48=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > Provide documentation that explains how to properly do CMODX in riscv=
.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++=
++++++++++
> > >  Documentation/arch/riscv/index.rst |  1 +
> > >  2 files changed, 99 insertions(+)
> > >
> > > diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/=
riscv/cmodx.rst
> > > new file mode 100644
> > > index 000000000000..20f327d85116
> > > --- /dev/null
> > > +++ b/Documentation/arch/riscv/cmodx.rst
> > > @@ -0,0 +1,98 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > +Concurrent Modification and Execution of Instructions (CMODX) for RI=
SC-V Linux
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > +
> > > +CMODX is a programming technique where a program executes instructio=
ns that were
> > > +modified by the program itself. Instruction storage and the instruct=
ion cache
> > > +(icache) is not guaranteed to be synchronized on RISC-V hardware. Th=
erefore, the
> > > +program must enforce its own synchonization with the unprivileged fe=
nce.i/
> >
> > /s/synchonization/synchronization
> >
> > > +instruction.
> > > +
> > > +However, the default Linux ABI prohibits the use of fence.i in users=
pace
> > > +applications. At any point the scheduler may migrate a task onto a n=
ew hart. If
> > > +migration occurs after the userspace synchronized the icache and ins=
truction
> > > +storage with fence.i, the icache will no longer be clean. This is du=
e to the
> > > +behavior of fence.i only affecting the hart that it is called on. Th=
us, the hart
> > > +that the task has been migrated to, may not have synchronized instru=
ction
> > > +storage and icache.
> > > +
> > > +There are two ways to solve this problem: use the riscv_flush_icache=
() syscall,
> > > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl(). The syscall sh=
ould be used
> > > +when the application very rarely needs to flush the icache. If the i=
cache will
> >
> > The syscall is a one time operation while prctl is sticky.
> > It would be great if we can add a little more context why the syscall
> > behaves this way compared to prctl.
>
> I can highlight the point that the prctl is sticky and the syscall is
> not.
>
> As for "why", they simply fill different roles. It is useful to have
> both a sticky and a non-sticky option. I chose the sticky operation to
> be a prctl rather than a generic syscall because the semantics of prctl
> is that they operate on process or thread scoped behavior which is what
> was needed.
>

Yeah.  That's what I was suggesting. It is enough for readers to understand
the difference between the two approaches without reading the kernel
source code.

> - Charlie
>
> >
> > > +need to be flushed many times in the lifetime of the application, th=
e prctl
> > > +should be used.
> > > +
> > > +The prctl informs the kernel that it must emit synchronizing instruc=
tions upon
> > > +task migration. The program itself must emit synchonizing instructio=
ns when
> >
> > /s/synchonizing/synchronizing
> >
> > > +necessary as well.
> > > +
> > > +1.  prctl() Interface
> > > +---------------------
> > > +
> > > +Before the program emits their first icache flushing instruction, th=
e program
> > > +must call this prctl().
> > > +
> > > +* prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, unsigned long ctx, unsigned l=
ong per_thread)
> > > +
> > > +       Sets the icache flushing context. If per_thread is 0, context=
 will be
> > > +       applied per process, otherwise if per_thread is 1 context wil=
l be
> > > +       per-thread. Any other number will have undefined behavior.
> > > +
> > > +       * :c:macro:`PR_RISCV_CTX_SW_FENCEI`: Allow fence.i to be call=
ed in
> > > +         userspace.
> > > +
> > > +Example usage:
> > > +
> > > +The following files are meant to be compiled and linked with each ot=
her. The
> > > +modify_instruction() function replaces an add with 0 with an add wit=
h one,
> > > +causing the instruction sequence in get_value() to change from retur=
ning a zero
> > > +to returning a one.
> > > +
> > > +cmodx.c::
> > > +
> > > +       #include <stdio.h>
> > > +       #include <sys/prctl.h>
> > > +
> > > +       extern int get_value();
> > > +       extern void modify_instruction();
> > > +
> > > +       int main()
> > > +       {
> > > +               int value =3D get_value();
> > > +               printf("Value before cmodx: %d\n", value);
> > > +
> > > +               // Call prctl before first fence.i is called inside m=
odify_instruction
> > > +               prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_=
FENCEI, 0);
> > > +               modify_instruction();
> > > +
> > > +               value =3D get_value();
> > > +               printf("Value after cmodx: %d\n", value);
> > > +               return 0;
> > > +       }
> > > +
> > > +cmodx.S::
> > > +
> > > +       .option norvc
> > > +
> > > +       .text
> > > +       .global modify_instruction
> > > +       modify_instruction:
> > > +       lw a0, new_insn
> > > +       lui a5,%hi(old_insn)
> > > +       sw  a0,%lo(old_insn)(a5)
> > > +       fence.i
> > > +       ret
> > > +
> > > +       .section modifiable, "awx"
> > > +       .global get_value
> > > +       get_value:
> > > +       li a0, 0
> > > +       old_insn:
> > > +       addi a0, a0, 0
> > > +       ret
> > > +
> > > +       .data
> > > +       new_insn:
> > > +       addi a0, a0, 1
> > > diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/=
riscv/index.rst
> > > index 4dab0cb4b900..eecf347ce849 100644
> > > --- a/Documentation/arch/riscv/index.rst
> > > +++ b/Documentation/arch/riscv/index.rst
> > > @@ -13,6 +13,7 @@ RISC-V architecture
> > >      patch-acceptance
> > >      uabi
> > >      vector
> > > +    cmodx
> > >
> > >      features
> > >
> > >
> > > --
> > > 2.43.0
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish

