Return-Path: <linux-kernel+bounces-18474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BAF825E2A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E03B1C23B88
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72E4694;
	Sat,  6 Jan 2024 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oB1wZTXN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988A440A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59502aa878aso128402eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 19:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704513178; x=1705117978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2aOIl4UNnpRK6RyeoDnHpQHzACVL3QRju2SnuNTBm0=;
        b=oB1wZTXN8MruiWXHtaPpZkFJlPviDCbnZkvZoriNCUHDVJVMGBtuvddGG7R7kVJ8jj
         j8olInbE6OiS2D90BsVp3j/CyvKHouXnUpr9mqF+7M7KU9qEsHUyiWn88p8CcJWLteRY
         5XPLwO5Uj0LcaWGTtqEF8zMuyGBfg/jNqRO06B4JmrlFafEm07xUvZOTL4HFlve+V7Y8
         afPLs+B5gVcu5yzBHHJYnbzO3iWY6RrFFQoMMa1YxB0k0R+Csa5fHrthla74pZG16GHN
         3o2/mbaqIK2MxLgnRzcalCdg6h8XITAYkLFjqxso0Y2VgmgvUBObL3YyWG2DGIZonB4v
         Uiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704513178; x=1705117978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2aOIl4UNnpRK6RyeoDnHpQHzACVL3QRju2SnuNTBm0=;
        b=v1lo+msxyJ/IXlnNJwp97YQHg6aTH3ZRXgf2l5ikb4w+i4sTEcURazGTlNO17w8oMH
         xhs8VKCM/h0nNrJJpinpkTWLet6jg9ySFYXRbVvEshuwV3TfPfvUfTsAfPG8FLHQC+WK
         /IrRQbUqrSp/6z5pKdaWjVFXtiqIJGNZGBmwP9MQnBus+160rk1gdZSsGYyiLGU3oua5
         6CjvKldfjXxlVRimZEiB8lKtuUIC49wb8mYdimB193tjAIMTWRjBXfezfWBg11ZlOZ/o
         TV41Yc0OSwQeD8Ct3mNsrwRQsVB9xoe5q25bbI4V02Jp7W+MwwjTKsmEVFFoc7FjFY3P
         ER/A==
X-Gm-Message-State: AOJu0YxfXCEl4ATsOAjqJKFGWVAyybn0nFCP6L+tebo+UEPq5omCryuh
	HCVVTeKnNYvIqabiHGor4+mCz9cgPxFZCg==
X-Google-Smtp-Source: AGHT+IFZdiX5/Chz2pb3J2lpmWZK0wj7liYYlV3sycKkqbhQFnl4yRMsyYKAzwdDC9bujM3U8Qb0KA==
X-Received: by 2002:a05:6358:4406:b0:172:e3d3:4906 with SMTP id z6-20020a056358440600b00172e3d34906mr489239rwc.34.1704513178245;
        Fri, 05 Jan 2024 19:52:58 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:73c:7a5f:bc03:fe77])
        by smtp.gmail.com with ESMTPSA id mv2-20020a17090b198200b0028c361b5c7csm2079193pjb.23.2024.01.05.19.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 19:52:57 -0800 (PST)
Date: Fri, 5 Jan 2024 19:52:55 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Message-ID: <ZZjOl1zDhUYbzpF9@ghost>
References: <20231213-fencei-v3-0-b75158238eb7@rivosinc.com>
 <20231213-fencei-v3-2-b75158238eb7@rivosinc.com>
 <CAOnJCULhAMmz22bH6A5AXv7aaJpH8SVGBATQyx-bfKAn4eFxsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCULhAMmz22bH6A5AXv7aaJpH8SVGBATQyx-bfKAn4eFxsQ@mail.gmail.com>

On Fri, Jan 05, 2024 at 06:52:12PM -0800, Atish Patra wrote:
> On Wed, Dec 13, 2023 at 2:48 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Provide documentation that explains how to properly do CMODX in riscv.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++++++++++++
> >  Documentation/arch/riscv/index.rst |  1 +
> >  2 files changed, 99 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
> > new file mode 100644
> > index 000000000000..20f327d85116
> > --- /dev/null
> > +++ b/Documentation/arch/riscv/cmodx.rst
> > @@ -0,0 +1,98 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==============================================================================
> > +Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
> > +==============================================================================
> > +
> > +CMODX is a programming technique where a program executes instructions that were
> > +modified by the program itself. Instruction storage and the instruction cache
> > +(icache) is not guaranteed to be synchronized on RISC-V hardware. Therefore, the
> > +program must enforce its own synchonization with the unprivileged fence.i/
> 
> /s/synchonization/synchronization
> 
> > +instruction.
> > +
> > +However, the default Linux ABI prohibits the use of fence.i in userspace
> > +applications. At any point the scheduler may migrate a task onto a new hart. If
> > +migration occurs after the userspace synchronized the icache and instruction
> > +storage with fence.i, the icache will no longer be clean. This is due to the
> > +behavior of fence.i only affecting the hart that it is called on. Thus, the hart
> > +that the task has been migrated to, may not have synchronized instruction
> > +storage and icache.
> > +
> > +There are two ways to solve this problem: use the riscv_flush_icache() syscall,
> > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl(). The syscall should be used
> > +when the application very rarely needs to flush the icache. If the icache will
> 
> The syscall is a one time operation while prctl is sticky.
> It would be great if we can add a little more context why the syscall
> behaves this way compared to prctl.

I can highlight the point that the prctl is sticky and the syscall is
not.

As for "why", they simply fill different roles. It is useful to have
both a sticky and a non-sticky option. I chose the sticky operation to
be a prctl rather than a generic syscall because the semantics of prctl
is that they operate on process or thread scoped behavior which is what
was needed.

- Charlie

> 
> > +need to be flushed many times in the lifetime of the application, the prctl
> > +should be used.
> > +
> > +The prctl informs the kernel that it must emit synchronizing instructions upon
> > +task migration. The program itself must emit synchonizing instructions when
> 
> /s/synchonizing/synchronizing
> 
> > +necessary as well.
> > +
> > +1.  prctl() Interface
> > +---------------------
> > +
> > +Before the program emits their first icache flushing instruction, the program
> > +must call this prctl().
> > +
> > +* prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, unsigned long ctx, unsigned long per_thread)
> > +
> > +       Sets the icache flushing context. If per_thread is 0, context will be
> > +       applied per process, otherwise if per_thread is 1 context will be
> > +       per-thread. Any other number will have undefined behavior.
> > +
> > +       * :c:macro:`PR_RISCV_CTX_SW_FENCEI`: Allow fence.i to be called in
> > +         userspace.
> > +
> > +Example usage:
> > +
> > +The following files are meant to be compiled and linked with each other. The
> > +modify_instruction() function replaces an add with 0 with an add with one,
> > +causing the instruction sequence in get_value() to change from returning a zero
> > +to returning a one.
> > +
> > +cmodx.c::
> > +
> > +       #include <stdio.h>
> > +       #include <sys/prctl.h>
> > +
> > +       extern int get_value();
> > +       extern void modify_instruction();
> > +
> > +       int main()
> > +       {
> > +               int value = get_value();
> > +               printf("Value before cmodx: %d\n", value);
> > +
> > +               // Call prctl before first fence.i is called inside modify_instruction
> > +               prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI, 0);
> > +               modify_instruction();
> > +
> > +               value = get_value();
> > +               printf("Value after cmodx: %d\n", value);
> > +               return 0;
> > +       }
> > +
> > +cmodx.S::
> > +
> > +       .option norvc
> > +
> > +       .text
> > +       .global modify_instruction
> > +       modify_instruction:
> > +       lw a0, new_insn
> > +       lui a5,%hi(old_insn)
> > +       sw  a0,%lo(old_insn)(a5)
> > +       fence.i
> > +       ret
> > +
> > +       .section modifiable, "awx"
> > +       .global get_value
> > +       get_value:
> > +       li a0, 0
> > +       old_insn:
> > +       addi a0, a0, 0
> > +       ret
> > +
> > +       .data
> > +       new_insn:
> > +       addi a0, a0, 1
> > diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
> > index 4dab0cb4b900..eecf347ce849 100644
> > --- a/Documentation/arch/riscv/index.rst
> > +++ b/Documentation/arch/riscv/index.rst
> > @@ -13,6 +13,7 @@ RISC-V architecture
> >      patch-acceptance
> >      uabi
> >      vector
> > +    cmodx
> >
> >      features
> >
> >
> > --
> > 2.43.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> -- 
> Regards,
> Atish

