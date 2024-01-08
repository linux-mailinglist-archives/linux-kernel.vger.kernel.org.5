Return-Path: <linux-kernel+bounces-19933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231CE8276FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B61C20E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953BF55C23;
	Mon,  8 Jan 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CjjNn3ty"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690B55C12
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3e2972f65so4506515ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704736956; x=1705341756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLhyf5sIXfLhdOh02ua5GenSjAf22p09pniZl0gR2xc=;
        b=CjjNn3tyERbER0eNoDZezpmtO3PQ2BUtHkyiVvjL3OLOUQd0BINz721p3mtkvFw+yR
         5juLmIvNcPGeQein1WwfhxwqyguFDiS1krH0GKg11cHDJTVWK7e7Ji3YnyOgg44h22XC
         E6RPDB2f2FkXz72K1Jwvlc6UC/8s6Q1mbvIcyOMrYlHmmg3tfccoQhtV176YUAmdaIhZ
         1vFZczjKT17aVXMKye4YutpKKz1GrbRxinJ5dT627F/9KtBkCzaBJejRvARQYv6WQ2g2
         CnQZbpNNW/pCDeJLE1HW9LggQLzujEPvQa14GS5sMC4POeqmBINVHVbT4TR3chQE6saT
         Tseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736956; x=1705341756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLhyf5sIXfLhdOh02ua5GenSjAf22p09pniZl0gR2xc=;
        b=Nd43WFxECh1hqhNOuwoD2y+6UWwteqFkgtM0aUq3H+cwQNEWMiIPQkfMRtt8g55vkF
         mVUX5dt9nIvBLavTGwbTapgmrrmZlyFkOnBaPdB2Fxs58hHPr1RDCV0ECxLa0FyqfYfA
         2rt53SCDdftm45NK/qnJl+zj+svg0/sVJFkN3pFPkQMXG2NXIds0ZQpn0bDhSBDYwdIk
         NptXzTiZdybfZtdxqk3NSbOY5jkWBGkvUrONcJk4Vek0wh9CtZufKW3E+RUbBseHyS8u
         qMp4O4So2FvNki0s9i+aaVbGFRCknflTbortutGD5PTyM2SjsRzbiRS6bceP8GrNtj4O
         apQg==
X-Gm-Message-State: AOJu0YyyWbJWpi1X3P/f3OgdBqkcyhOWqu3VND10WsKxowJObmEDAjjM
	NJTrBh86rel2N6spJN6B3KbtjBSsWWugLA==
X-Google-Smtp-Source: AGHT+IF0KV6ppakYNjF2hnQktuahh7myDZAFD1mLkbcDl8/nMLb6ibIHPCTgpmQPcDHUkw/Qt6ReXg==
X-Received: by 2002:a17:903:1205:b0:1d5:4c70:262f with SMTP id l5-20020a170903120500b001d54c70262fmr692193plh.95.1704736955622;
        Mon, 08 Jan 2024 10:02:35 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:304d:b1a:4fb3:783f])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b001cff9cd5129sm174005pll.298.2024.01.08.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:02:35 -0800 (PST)
Date: Mon, 8 Jan 2024 10:02:32 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Message-ID: <ZZw4uCCahPRbHdfR@ghost>
References: <20240107-fencei-v4-0-d4cf2fb905d3@rivosinc.com>
 <20240107-fencei-v4-2-d4cf2fb905d3@rivosinc.com>
 <34f6da8c-1e63-43a5-b9d4-d6865a5d2252@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f6da8c-1e63-43a5-b9d4-d6865a5d2252@infradead.org>

On Sun, Jan 07, 2024 at 11:06:34PM -0800, Randy Dunlap wrote:
> Hi--
> 
> On 1/7/24 22:21, Charlie Jenkins wrote:
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
> > index 000000000000..71598850e131
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
> > +(icache) is not guaranteed to be synchronized on RISC-V hardware. Therefore, the
> 
>             are not
> 
> > +program must enforce its own synchronization with the unprivileged fence.i
> > +instruction.
> > +
> > +However, the default Linux ABI prohibits the use of fence.i in userspace
> > +applications. At any point the scheduler may migrate a task onto a new hart. If
> > +migration occurs after the userspace synchronized the icache and instruction
> > +storage with fence.i, the icache will no longer be clean. This is due to the
> > +behavior of fence.i only affecting the hart that it is called on. Thus, the hart
> > +that the task has been migrated to, may not have synchronized instruction
> 
>                                    to may not
> 
> > +storage and icache.
> > +
> > +There are two ways to solve this problem: use the riscv_flush_icache() syscall,
> > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
> > +userspace. The syscall performs a one-off icache flushing operation. The prctl
> > +changes the Linux ABI to allow userspace to emit icache flushing operations.
> > +
> > +1.  prctl() Interface
> > +---------------------
> 
> Why is "1." needed here? or is it?

Not needed, thank you.

- Charlie

> 
> > +
> > +Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first argument. The
> > +remaining arguments will be delegated to the riscv_set_icache_flush_ctx
> > +function detailed below.
> > +
> > +.. kernel-doc:: arch/riscv/mm/cacheflush.c
> > +	:identifiers: riscv_set_icache_flush_ctx
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
> > +	#include <stdio.h>
> > +	#include <sys/prctl.h>
> > +
> > +	extern int get_value();
> > +	extern void modify_instruction();
> > +
> > +	int main()
> > +	{
> > +		int value = get_value();
> > +		printf("Value before cmodx: %d\n", value);
> > +
> > +		// Call prctl before first fence.i is called inside modify_instruction
> > +		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, 0);
> > +		modify_instruction();
> > +
> > +		value = get_value();
> > +		printf("Value after cmodx: %d\n", value);
> > +		return 0;
> > +	}
> > +
> > +cmodx.S::
> > +
> > +	.option norvc
> > +
> > +	.text
> > +	.global modify_instruction
> > +	modify_instruction:
> > +	lw a0, new_insn
> > +	lui a5,%hi(old_insn)
> > +	sw  a0,%lo(old_insn)(a5)
> > +	fence.i
> > +	ret
> > +
> > +	.section modifiable, "awx"
> > +	.global get_value
> > +	get_value:
> > +	li a0, 0
> > +	old_insn:
> > +	addi a0, a0, 0
> > +	ret
> > +
> > +	.data
> > +	new_insn:
> > +	addi a0, a0, 1
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
> 
> Thanks.
> -- 
> #Randy

