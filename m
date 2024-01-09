Return-Path: <linux-kernel+bounces-20498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24288827FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB011F25359
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C133B670;
	Tue,  9 Jan 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="AcyXuc6V"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3377B652
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so30290901fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1704786726; x=1705391526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHMsXlWZWaGsrXYEDte+sg2DqzlgrW3ZmXNJD62Sg6A=;
        b=AcyXuc6VQloyTFcTZU++WFFJ2ThQ82tf4J5BnQEcNouvrPdhpfWuX0Mas46YgFqiXF
         pKioKe7tsBJBvPM9gVYBxHwIlQW/Rdn6tmkLPANomji+wbPXc54/dwJ5iAnxCfMAOpzQ
         4rvoEco4Hb0o0QM7aT6M9Wzsvdltb1NujdkJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704786726; x=1705391526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHMsXlWZWaGsrXYEDte+sg2DqzlgrW3ZmXNJD62Sg6A=;
        b=ZvM2DkXW14blv9fS8MKli763YtcbuGlisbkEZYr2RpSR5yLi88OFOphEDqB6sajzpB
         rmTPLKgBYNUW40dFUksVKrrc3Ka4+lAUfQjyh9IMJF7iWesYoVtqFTlfMxDUcoGFEjXl
         rFPXTBvwNVQdqtQfHmMM+liKX5f2LEWbzwSV80DVLZZne6q1MzQuvgWAozr2zKe0RRl9
         3119TwPOPX4P041FsOTvPxSdlx5jyWMu+e/OHbGIIjmFKO8ZB9r1zrJVHO7l7b93RSBr
         s1niI0xcEoCtSc1diGzqt71Y9wxUm0pkW6uY1v9M1JnjL01JSoJ5utuOKPDA0gh95u5l
         F2zQ==
X-Gm-Message-State: AOJu0Yzqpy0dh4dIkSGabSXqR8SfqOor5crnk2M3VAudohDCnEpL31MP
	xiMXC+YTve2acoJAE/wGrNVhGouBrnowshYlD1+tbDEfiLVq
X-Google-Smtp-Source: AGHT+IHuTXV8NIt4gJXv79KBRfV+UGFAihQ0TgFFGOGOxerlXPw9DAp+fttPBvgWz9Og/8JF+FtL8tu+tG90k/BMnMU=
X-Received: by 2002:a2e:8894:0:b0:2cc:ea0d:f6be with SMTP id
 k20-20020a2e8894000000b002ccea0df6bemr2000733lji.86.1704786725784; Mon, 08
 Jan 2024 23:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-fencei-v5-0-aa1e51d7222f@rivosinc.com>
 <20240108-fencei-v5-2-aa1e51d7222f@rivosinc.com> <CAOnJCUJQ-M1bVC_VhogMLo47mRyk3Pzq-GFH5P7ADn70BN9ObA@mail.gmail.com>
 <ZZyth6Ijtsmy5D84@ghost>
In-Reply-To: <ZZyth6Ijtsmy5D84@ghost>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 8 Jan 2024 23:51:54 -0800
Message-ID: <CAOnJCUL60H16edo6icR-1bzTVk0Tdr+hRf3izharUEEvxCrwhA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX
 prctl
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:20=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Mon, Jan 08, 2024 at 05:24:47PM -0800, Atish Patra wrote:
> > On Mon, Jan 8, 2024 at 10:42=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > Provide documentation that explains how to properly do CMODX in riscv=
.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++=
++++++++++
> > >  Documentation/arch/riscv/index.rst |  1 +
> > >  2 files changed, 89 insertions(+)
> > >
> > > diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/=
riscv/cmodx.rst
> > > new file mode 100644
> > > index 000000000000..afd7086c222c
> > > --- /dev/null
> > > +++ b/Documentation/arch/riscv/cmodx.rst
> > > @@ -0,0 +1,88 @@
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
> > > +(icache) are not guaranteed to be synchronized on RISC-V hardware. T=
herefore, the
> > > +program must enforce its own synchronization with the unprivileged f=
ence.i
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
> > > +that the task has been migrated to may not have synchronized instruc=
tion storage
> > > +and icache.
> > > +
> > > +There are two ways to solve this problem: use the riscv_flush_icache=
() syscall,
> > > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.=
i in
> > > +userspace. The syscall performs a one-off icache flushing operation.=
 The prctl
> > > +changes the Linux ABI to allow userspace to emit icache flushing ope=
rations.
> > > +
> > > +prctl() Interface
> > > +---------------------
> > > +
> > > +Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first arg=
ument. The
> > > +remaining arguments will be delegated to the riscv_set_icache_flush_=
ctx
> > > +function detailed below.
> > > +
> > > +.. kernel-doc:: arch/riscv/mm/cacheflush.c
> > > +       :identifiers: riscv_set_icache_flush_ctx
> > > +
> >
> > Document the arguments of the prctl as well ?
>
> Do you mean to include the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` key in the
> comment of riscv_set_icache_flush_ctx? The args to
> riscv_set_icache_flush_ctx are the args to the prctl except for the key.
>

No, I mean describe the argument2(ctx) and argument3(per_thread) as well.
Since this is a documentation of the new prctl, we should document all
args so that an user
can use it without grepping through the kernel sources.

> - Charlie
>
> >
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
> > > +               prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_=
SW_FENCEI, 0);
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
> >
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish

