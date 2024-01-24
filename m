Return-Path: <linux-kernel+bounces-37554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A618183B192
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B6C284E94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9B13175C;
	Wed, 24 Jan 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1yoC7uC/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E81EA85
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122521; cv=none; b=Zf3PcaHzKSm88lgvX7MNrzZxoo0wUQGpcJtzuSJENpXYnaPjurGlCCWuDNuWfTT44jhQWoDP9146FsuUWxBfEfOvU6WqBn/5pgCYNQz3Mmmc/+q5PlQh73X6PsEpi43utf4eAyzNuTV5Y4CvQa/ypMWsMJshIqSVG3a5v+TSvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122521; c=relaxed/simple;
	bh=oWD5VLSXRA+rwKDmOK0WcQfre24wTxNEWYYxv4RGXoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqdbV16vF1F08/sI0eet2JZ5AWa16HH8pSG+fkfpciZ87XSSLS1mvBJg1I58fE0AHwE3Vi9SBU7ttRLzrcYsUYy5DUA33bH2jbog4zCoGbXU3KF+O3UE32p3nVif5tkw9yUIomfdTP2iBliuwwIFSqVMMMrRv4SP1G7oOjgzH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1yoC7uC/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7431e702dso27666445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706122519; x=1706727319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDj/r0j6wjrBeKVb5gL0FLzmDiXz6FHRYIwfCvn46Xc=;
        b=1yoC7uC/hCY8BTp//3vVQjs2fRNi6cyFkfIHtPN6N6jHHHktsbh7IlTpm6c5kf+Gws
         QQzmoGSw0qCswbL2GozTeiEoDhFcskhTFsHK3Jarwkk4id+wtSV5N5rg76d6X2FTPGMD
         q8MRneyYV4rGpab3Lq5qJsnUTNcmfdlyFXDXHs6KjT+19e9JRglz9l31kTsF3EkyurWI
         W3stkLM6awyOJBw/ko7XbHRMWrTb6lBDoj6R7EsDL2GkYBdKhVnEiTShZ35HOUQ+gv/t
         YXN0uGkVTsDnZYUSHSShiGP541XuSDHzJPH3Hm9XU55D9JkxmnLErCuZpmO9JnIj/uoc
         9k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122519; x=1706727319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDj/r0j6wjrBeKVb5gL0FLzmDiXz6FHRYIwfCvn46Xc=;
        b=e6tZi8BzoKpAe+GwWm7HgaujA0kPlU4/aBaCZQlOuIeGA+9n3ork+nIZlc7MQTfI6p
         80ztfT+gBWrmnMM3056ZZBcZbZogOciJH9SuI1YO3yyKgHvbx3pUTLGVp7DM4IHWzm7d
         zzzbsqByf/6adR0q2wzlvXMKZi9o5G8XHHK1AXpzmrscvmaN4HM2vVRd3QZWR8ihkown
         Iqpz3DQ49EC1Y9d9X+siYpdCXm4iWNxLkBbQ29aAgUhXkxaBdSbssu+BgjrzMKoTHAQ0
         1k0CuuhGZKUswRfAWPw5gcb1iJoyDoE/ZQ/xdmSCImAvrEc+iK7pVW9ZSW7MKuGwwGg0
         fF+w==
X-Gm-Message-State: AOJu0YxPBsadvcMktdv8DIEI3Y7Xs6gvkZgul66C3S9S0kG5uy1BURD0
	q4Pt47QTKUzaT2PAxGcmDlbW1Xl6ltWGPqH9NZ7EDhB5/X6fergvuixqHydkK9A=
X-Google-Smtp-Source: AGHT+IEIpZf36EhWLz+OQgHES8qLiyZ0UwP9vaFkyqYaaf3TE93IIKGP2XO1CzR3BfCEE2NcFO6xbw==
X-Received: by 2002:a17:902:d4ce:b0:1d7:8e11:14a0 with SMTP id o14-20020a170902d4ce00b001d78e1114a0mr887617plg.91.1706122518713;
        Wed, 24 Jan 2024 10:55:18 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709028f8700b001d71935e5c1sm9210654plo.195.2024.01.24.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:55:18 -0800 (PST)
Date: Wed, 24 Jan 2024 10:55:16 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v9 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Message-ID: <ZbFdFARPQzjRd2g8@ghost>
References: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
 <20240123-fencei-v9-2-71411bfe8d71@rivosinc.com>
 <26808f34-d9c4-404a-bf09-45c4aff139ad@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26808f34-d9c4-404a-bf09-45c4aff139ad@ghiti.fr>

On Wed, Jan 24, 2024 at 08:19:42AM +0100, Alexandre Ghiti wrote:
> On 24/01/2024 00:29, Charlie Jenkins wrote:
> > Provide documentation that explains how to properly do CMODX in riscv.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   Documentation/arch/riscv/cmodx.rst | 96 ++++++++++++++++++++++++++++++++++++++
> >   Documentation/arch/riscv/index.rst |  1 +
> >   2 files changed, 97 insertions(+)
> > 
> > diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
> > new file mode 100644
> > index 000000000000..2ad46129d812
> > --- /dev/null
> > +++ b/Documentation/arch/riscv/cmodx.rst
> > @@ -0,0 +1,96 @@
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
> 
> 
> Nit: I think you mean "the icache on the new hart will no longer be clean".

Aw yes, that should be more explicit.

- Charlie

> 
> 
> > +behavior of fence.i only affecting the hart that it is called on. Thus, the hart
> > +that the task has been migrated to may not have synchronized instruction storage
> > +and icache.
> > +
> > +There are two ways to solve this problem: use the riscv_flush_icache() syscall,
> > +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
> > +userspace. The syscall performs a one-off icache flushing operation. The prctl
> > +changes the Linux ABI to allow userspace to emit icache flushing operations.
> > +
> > +As an aside, "deferred" icache flushes can sometimes be triggered in the kernel.
> > +At the time of writing, this only occurs during the riscv_flush_icache() syscall
> > +and when the kernel uses copy_to_user_page(). These deferred flushes happen only
> > +when the memory map being used by a hart changes. If the prctl() context caused
> > +an icache flush, this deferred icache flush will be skipped as it is redundant.
> > +Therefore, there will be no additional flush when using the riscv_flush_icache()
> > +syscall inside of the prctl() context.
> > +
> > +prctl() Interface
> > +---------------------
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
> > +		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
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
> >       patch-acceptance
> >       uabi
> >       vector
> > +    cmodx
> >       features
> > 
> 
> I don't know how man pages are synchronized with new additions in the
> kernel, do you? It would be nice to have this new prctl documented for
> userspace.
> 
> Thanks,
> 
> Alex
> 

