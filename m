Return-Path: <linux-kernel+bounces-18461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C5825DFC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D361F245F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49817CB;
	Sat,  6 Jan 2024 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="cbY/qe/X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA515AC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccbc328744so1464941fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 18:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1704509545; x=1705114345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKh9BmOj21iuAqSENO/xdERxW3QeKR5djoMlE8KCUEE=;
        b=cbY/qe/Xj+Dg0MT0WIXQlsmi0I3uDeBzMPP3Ny+/Z2tLReqt7wQiDlXLr7azyGol/v
         XDTwUXbXmC0IOyksxZwAfCm8O58MGickCt0OP99o0KGI1MWWs38T7taezZcRQFk71AoM
         yL4K8SZDCW0ItEomvHtM4z8H9xk7j3phGl/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704509545; x=1705114345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKh9BmOj21iuAqSENO/xdERxW3QeKR5djoMlE8KCUEE=;
        b=TWD6zMIsoTKxiLD7zqbTF6DonpByNSV7P3/aTf+P0oxnRDr1mhwL4ng9/Y/4EhFi/v
         9oMfDzIt1YsY+qSEJjc5XA4hrkTegFwEMPQMREVNLS/d+wrviuoaxZUfFWg3KkjLrKiu
         JX8YU4joTjyVCl/bhLkdvNHh2PNRLtruI7RGCj2PKD9ZNif4nuYZ7Dqq6TiMb3y0zZdB
         oMEWp2nq0F08ObNVVSBx4j5Ve1OX1+We8CrSEITd2MQHaD77rSeKERaeEMbC2Goix4BB
         QcrICttGYKRTETnj3o+q3mwPP+ft1QM1W5SdoRdYrKWYb/25gvz1k77gRZXVj/T3SxtY
         N81A==
X-Gm-Message-State: AOJu0YzGMcInkzcFuR65jk7deR8TrJ4dPoZ94tvysCdoCE6IDBdDzW98
	dYz30zYxyXzAhKagg6WuAONt8n1QQnmDPIguQ8PAwy0x263R2913AFBHl9y4aQ==
X-Google-Smtp-Source: AGHT+IEmVW5WFkfcPShNUfss77u377U1lwtoz/zN0/cjZUA+a6QTwiua4e01S2bKUn5fKF5veb231gk13iU65HlSsl0=
X-Received: by 2002:a2e:979a:0:b0:2cd:2c3e:ae09 with SMTP id
 y26-20020a2e979a000000b002cd2c3eae09mr108950lji.40.1704509544147; Fri, 05 Jan
 2024 18:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-fencei-v3-0-b75158238eb7@rivosinc.com> <20231213-fencei-v3-2-b75158238eb7@rivosinc.com>
In-Reply-To: <20231213-fencei-v3-2-b75158238eb7@rivosinc.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 5 Jan 2024 18:52:12 -0800
Message-ID: <CAOnJCULhAMmz22bH6A5AXv7aaJpH8SVGBATQyx-bfKAn4eFxsQ@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 2:48=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Provide documentation that explains how to properly do CMODX in riscv.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++++++=
++++++
>  Documentation/arch/riscv/index.rst |  1 +
>  2 files changed, 99 insertions(+)
>
> diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/risc=
v/cmodx.rst
> new file mode 100644
> index 000000000000..20f327d85116
> --- /dev/null
> +++ b/Documentation/arch/riscv/cmodx.rst
> @@ -0,0 +1,98 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Concurrent Modification and Execution of Instructions (CMODX) for RISC-V=
 Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +CMODX is a programming technique where a program executes instructions t=
hat were
> +modified by the program itself. Instruction storage and the instruction =
cache
> +(icache) is not guaranteed to be synchronized on RISC-V hardware. Theref=
ore, the
> +program must enforce its own synchonization with the unprivileged fence.=
i/

/s/synchonization/synchronization

> +instruction.
> +
> +However, the default Linux ABI prohibits the use of fence.i in userspace
> +applications. At any point the scheduler may migrate a task onto a new h=
art. If
> +migration occurs after the userspace synchronized the icache and instruc=
tion
> +storage with fence.i, the icache will no longer be clean. This is due to=
 the
> +behavior of fence.i only affecting the hart that it is called on. Thus, =
the hart
> +that the task has been migrated to, may not have synchronized instructio=
n
> +storage and icache.
> +
> +There are two ways to solve this problem: use the riscv_flush_icache() s=
yscall,
> +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl(). The syscall should=
 be used
> +when the application very rarely needs to flush the icache. If the icach=
e will

The syscall is a one time operation while prctl is sticky.
It would be great if we can add a little more context why the syscall
behaves this way compared to prctl.

> +need to be flushed many times in the lifetime of the application, the pr=
ctl
> +should be used.
> +
> +The prctl informs the kernel that it must emit synchronizing instruction=
s upon
> +task migration. The program itself must emit synchonizing instructions w=
hen

/s/synchonizing/synchronizing

> +necessary as well.
> +
> +1.  prctl() Interface
> +---------------------
> +
> +Before the program emits their first icache flushing instruction, the pr=
ogram
> +must call this prctl().
> +
> +* prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, unsigned long ctx, unsigned long =
per_thread)
> +
> +       Sets the icache flushing context. If per_thread is 0, context wil=
l be
> +       applied per process, otherwise if per_thread is 1 context will be
> +       per-thread. Any other number will have undefined behavior.
> +
> +       * :c:macro:`PR_RISCV_CTX_SW_FENCEI`: Allow fence.i to be called i=
n
> +         userspace.
> +
> +Example usage:
> +
> +The following files are meant to be compiled and linked with each other.=
 The
> +modify_instruction() function replaces an add with 0 with an add with on=
e,
> +causing the instruction sequence in get_value() to change from returning=
 a zero
> +to returning a one.
> +
> +cmodx.c::
> +
> +       #include <stdio.h>
> +       #include <sys/prctl.h>
> +
> +       extern int get_value();
> +       extern void modify_instruction();
> +
> +       int main()
> +       {
> +               int value =3D get_value();
> +               printf("Value before cmodx: %d\n", value);
> +
> +               // Call prctl before first fence.i is called inside modif=
y_instruction
> +               prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENC=
EI, 0);
> +               modify_instruction();
> +
> +               value =3D get_value();
> +               printf("Value after cmodx: %d\n", value);
> +               return 0;
> +       }
> +
> +cmodx.S::
> +
> +       .option norvc
> +
> +       .text
> +       .global modify_instruction
> +       modify_instruction:
> +       lw a0, new_insn
> +       lui a5,%hi(old_insn)
> +       sw  a0,%lo(old_insn)(a5)
> +       fence.i
> +       ret
> +
> +       .section modifiable, "awx"
> +       .global get_value
> +       get_value:
> +       li a0, 0
> +       old_insn:
> +       addi a0, a0, 0
> +       ret
> +
> +       .data
> +       new_insn:
> +       addi a0, a0, 1
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/risc=
v/index.rst
> index 4dab0cb4b900..eecf347ce849 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -13,6 +13,7 @@ RISC-V architecture
>      patch-acceptance
>      uabi
>      vector
> +    cmodx
>
>      features
>
>
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish

