Return-Path: <linux-kernel+bounces-20283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B51827CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B318A1F24366
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE833259D;
	Tue,  9 Jan 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1F2wpBk7"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0523B1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3f8af8297so9419575ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704766858; x=1705371658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVG8c40f68G3korcyEKi0z8ULvfpyOFV+s3GtOXVEHo=;
        b=1F2wpBk7F5WZV0KDV4EUPOhKPnarcGdL1A8WWZtSUqfjZJ/70wewamBM8hRj7c1ib3
         V1HKJiagBjCylBltt5spy9lKJdy5ad3TYNBWwcC5Sftk0zBn00VXvxG14awwN16trbsr
         Hu8gOnGYgwt1OuPb+P7D25h96NL3awnoxOACJ1XLxNdlCB5pmGE6krw4bnyjkIfZR4a6
         x1dx+FBp3BwSCbvKbSf1GLZDEsBEbAXsDKtKth99gjehjL1+I31QvRJfXQT0576kGXNP
         DTLxtb9gRr/IsjRWkot8v6OAJ7FnKHSdpF3DSjTtouMT+OLyG+rSD2LzsWJQynKduqUv
         Jbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704766858; x=1705371658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVG8c40f68G3korcyEKi0z8ULvfpyOFV+s3GtOXVEHo=;
        b=hS0DtniBZ466jn7U75iBwLPgd2iGlH3Ya9+eC0Fg2UMMqiuwEXhOdvmjQS9qTb6059
         zo8V8mpn1Bqq3Su4ZkWQJocyVcVwd5Nk+ZfOYQ8UKEghfyG5067TEewO6jUBBF83RkMG
         uwrHbQV2G9M/a0r57XSI+Y3ODlyX1yUJqoMzdhrhfLuIf6ekxkqgDT40OQtkNsXx2anW
         Boedh/x2iyjuLozhty/JXsTlfFJtlvjdZR/KHUclTvryGjxnmeVY7yGPRnm9g6TuDju8
         lKtfFTL56iyUj9pojWRzQmSAUABBw8OnZ7vBhiObqKRNsoJHDmmn5+TlpykSs3mcqDt9
         UrWQ==
X-Gm-Message-State: AOJu0YyQQ0SKHqbOUTup9QQqfV/5MpoItPLddB8Ar8LbnaF7QXB8b6zG
	RfREewLg1iVfbb5MTzV6BtLTyZD2ylK2YuF3ZEjPptRBYe0=
X-Google-Smtp-Source: AGHT+IGXYRm5IEE3b4P8Xco9rGgrHSS8TganxZJswq3boRda5meQG0P0cEGLQN2/znprRxf6er9ZaQ==
X-Received: by 2002:a17:902:740b:b0:1d3:ec6f:3c47 with SMTP id g11-20020a170902740b00b001d3ec6f3c47mr2406282pll.71.1704766858597;
        Mon, 08 Jan 2024 18:20:58 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902c19300b001bc930d4517sm567240pld.42.2024.01.08.18.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 18:20:58 -0800 (PST)
Date: Mon, 8 Jan 2024 18:20:55 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Message-ID: <ZZyth6Ijtsmy5D84@ghost>
References: <20240108-fencei-v5-0-aa1e51d7222f@rivosinc.com>
 <20240108-fencei-v5-2-aa1e51d7222f@rivosinc.com>
 <CAOnJCUJQ-M1bVC_VhogMLo47mRyk3Pzq-GFH5P7ADn70BN9ObA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCUJQ-M1bVC_VhogMLo47mRyk3Pzq-GFH5P7ADn70BN9ObA@mail.gmail.com>

On Mon, Jan 08, 2024 at 05:24:47PM -0800, Atish Patra wrote:
> On Mon, Jan 8, 2024 at 10:42 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Provide documentation that explains how to properly do CMODX in riscv.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++++++++++++
> >  Documentation/arch/riscv/index.rst |  1 +
> >  2 files changed, 89 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
> > new file mode 100644
> > index 000000000000..afd7086c222c
> > --- /dev/null
> > +++ b/Documentation/arch/riscv/cmodx.rst
> > @@ -0,0 +1,88 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==============================================================================
> > +Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
> > +==============================================================================
> > +
> > +CMODX is a programming technique where a program executes instructions that were
> > +modified by the program itself. Instruction storage and the instruction cache
> > +(icache) are not guaranteed to be synchronized on RISC-V hardware. Therefore, the
> > +program must enforce its own synchronization with the unprivileged fence.i
> > +instruction.
> > +
> > +However, the default Linux ABI prohibits the use of fence.i in userspace
> > +applications. At any point the scheduler may migrate a task onto a new hart. If
> > +migration occurs after the userspace synchronized the icache and instruction
> > +storage with fence.i, the icache will no longer be clean. This is due to the
> > +behavior of fence.i only affecting the hart that it is called on. Thus, the hart
> > +that the task has been migrated to may not have synchronized instruction storage
> > +and icache.
> > +
> > +There are two ways to solve this problem: use the riscv_flush_icache() syscall,
> > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
> > +userspace. The syscall performs a one-off icache flushing operation. The prctl
> > +changes the Linux ABI to allow userspace to emit icache flushing operations.
> > +
> > +prctl() Interface
> > +---------------------
> > +
> > +Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first argument. The
> > +remaining arguments will be delegated to the riscv_set_icache_flush_ctx
> > +function detailed below.
> > +
> > +.. kernel-doc:: arch/riscv/mm/cacheflush.c
> > +       :identifiers: riscv_set_icache_flush_ctx
> > +
> 
> Document the arguments of the prctl as well ?

Do you mean to include the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` key in the
comment of riscv_set_icache_flush_ctx? The args to
riscv_set_icache_flush_ctx are the args to the prctl except for the key.

- Charlie

> 
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
> > +               prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, 0);
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
> 
> 
> --
> Regards,
> Atish

