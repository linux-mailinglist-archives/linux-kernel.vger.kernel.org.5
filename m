Return-Path: <linux-kernel+bounces-97575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B724E876C0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E41C216D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54E5F463;
	Fri,  8 Mar 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhh3jga4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A55E077;
	Fri,  8 Mar 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931226; cv=none; b=nXQCBTPtF0nhg04F3ClM9s1tsZRbWH41uVwb4tl+7gEs1Y5tvYAi8pJT4PAVdoO5srDQR+enVj4xtb7F7E3f9LgGTUdwMzLlXZt30vJoakkxysemqFyej5Zjuyp1BqpkeIUgUzbWB7+OmeFqb6qo9oEFrcrJx9JK8oy+ri8/cXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931226; c=relaxed/simple;
	bh=mZHwASnNiA+0JOdqGd28VuUM0QHLH5hUItAzYpemHCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/zWzKbDN6NYRH3lPZe85DXjRhxlsAOtPeB3sGrP24lV5MBz7204WNMWExj+jQg4zTXZYEbSheJayJbp+Y8/C5q6h5QImFMnRR+ruyLUfCzbM0BWw6bl3zOQ5AFnFs8oRKKUo4G6RbZPh7taKTmvI2Z2aVV5e+OQuM+A9XybJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhh3jga4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd6198c4e2so14357785ad.2;
        Fri, 08 Mar 2024 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709931224; x=1710536024; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k3FyJJXkStTdlH41VSk6TL63Vo5zy8Q5BFHWuyAluFE=;
        b=nhh3jga4KeoJy1eXXTHVeyA+1IvpRSwrr/CojtFG9UnPsYabh6q6pwHqtlH129ZK5S
         4zKL+GfgtMch8SJb/XT+oXQ0xxFH41aNZm1zWpivqrMuXiZ+LFwd/dVzMHqmxnhJbOTK
         7vPOgSwZI3GI075dlXGXIK9N17CG2KoqV4LwJQyuk8DpcsO8rBF1UNB6cG5APy/bBxwm
         nPH0sg1P8S/+dRs+KsDElBCAjFBA+czkKCyzaZ+r2AJnWT/s3AsCvsrubd28qMaxqk0+
         5eaI+43nZd5pOd8f4GUl8hCOmpXhnfqpU6cjju7FUkgMciOQVo3jW+O7NNkF8gmDRGNO
         iW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709931224; x=1710536024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3FyJJXkStTdlH41VSk6TL63Vo5zy8Q5BFHWuyAluFE=;
        b=cenyBycBcZ//nh4YamNGhcQjVa744Uf7DZeq3kwRyz9r3wN5yQaRva1Gss33HPgVeS
         svPOycCynsKZskE4P0qEhE+o7yKfKI+UIsm3y/04/W+cmwKRVlwPcB5uMRBkeIB1oDlX
         RWgfZtjgft/6nAmFWhBemFyRWDNEFVeeJ4xu0Ue9Pgv6HM+Z2O7vSeZ8x/0sK5df5/fB
         CvOI3I19bX/TYOxW1+0A+JZE73HVyUsvzG8yN7K8m488KkH8jF2/fy/cqo/6RsuvZSfm
         WsRnGs4nQluI+EoySHJ41ckGQ4ZFlPNswufNqRsQWc7VjDj/v2oOx0FcVo6zttVWdnxR
         ek0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMnZ0CW1Rv1mpZfLdvvuhtnCePCYMWzFoJEmxlEyJBTYsleN8X/psnOQI8J9Mrye2gkDvrtSTTCWniyHLNUL8cRDOEL071qcKd2NTdxzG4MYfAMryVI1FUpeTf4hbZfmmEvRXi4NxCslrnO8CiSYiOWSJ9mEikux+gX0wqvW9JSA==
X-Gm-Message-State: AOJu0Ywi4lY5OIDBcKd9xz8OeHHkR1q16zQcLXTzccQxrG7xGxnQaUoU
	wstBvcW5lz8U5zEyg+krNVJfA8FdPaVoT/FB6St1OwxSz7b+89rk
X-Google-Smtp-Source: AGHT+IEZ4C7lx2v17kFxsEX8KT9D5zuIweUrqZ5jV/dRO0aBQtjZ/MWRfKM9TJEsG4RM1AcT5MH8nw==
X-Received: by 2002:a17:903:41c3:b0:1dc:bb8e:d28f with SMTP id u3-20020a17090341c300b001dcbb8ed28fmr249406ple.66.1709931224231;
        Fri, 08 Mar 2024 12:53:44 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001da001aed18sm73346plg.54.2024.03.08.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:53:43 -0800 (PST)
Date: Fri, 8 Mar 2024 12:53:41 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/4] module: mm: Make module_alloc() generally
 available
Message-ID: <Zet61a2jTaSV1eF0@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <a6b162aed1e6fea7f565ef9dd0204d6f2284bcce.1709676663.git.jcalvinowens@gmail.com>
 <267d9173-2a0e-4006-a858-4e94aeff94df@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <267d9173-2a0e-4006-a858-4e94aeff94df@csgroup.eu>

On Thursday 03/07 at 14:43 +0000, Christophe Leroy wrote:
> Hi Calvin,
> 
> Le 06/03/2024 à 21:05, Calvin Owens a écrit :
> > [Vous ne recevez pas souvent de courriers de jcalvinowens@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Both BPF_JIT and KPROBES depend on CONFIG_MODULES, but only require
> > module_alloc() itself, which can be easily separated into a standalone
> > allocator for executable kernel memory.
> 
> Easily maybe, but not as easily as you think, see below.
> 
> > 
> > Thomas Gleixner sent a patch to do that for x86 as part of a larger
> > series a couple years ago:
> > 
> >      https://lore.kernel.org/all/20220716230953.442937066@linutronix.de/
> > 
> > I've simply extended that approach to the whole kernel.
> > 
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> >   arch/Kconfig                     |   2 +-
> >   arch/arm/kernel/module.c         |  35 ---------
> >   arch/arm/mm/Makefile             |   2 +
> >   arch/arm/mm/module_alloc.c       |  40 ++++++++++
> >   arch/arm64/kernel/module.c       | 127 ------------------------------
> >   arch/arm64/mm/Makefile           |   1 +
> >   arch/arm64/mm/module_alloc.c     | 130 +++++++++++++++++++++++++++++++
> >   arch/loongarch/kernel/module.c   |   6 --
> >   arch/loongarch/mm/Makefile       |   2 +
> >   arch/loongarch/mm/module_alloc.c |  10 +++
> >   arch/mips/kernel/module.c        |  10 ---
> >   arch/mips/mm/Makefile            |   2 +
> >   arch/mips/mm/module_alloc.c      |  13 ++++
> >   arch/nios2/kernel/module.c       |  20 -----
> >   arch/nios2/mm/Makefile           |   2 +
> >   arch/nios2/mm/module_alloc.c     |  22 ++++++
> >   arch/parisc/kernel/module.c      |  12 ---
> >   arch/parisc/mm/Makefile          |   1 +
> >   arch/parisc/mm/module_alloc.c    |  15 ++++
> >   arch/powerpc/kernel/module.c     |  36 ---------
> >   arch/powerpc/mm/Makefile         |   1 +
> >   arch/powerpc/mm/module_alloc.c   |  41 ++++++++++
> 
> Missing several powerpc changes to make it work. You must audit every 
> use of CONFIG_MODULES inside powerpc. Here are a few exemples:
> 
> Function get_patch_pfn() to enable text code patching.
> 
> arch/powerpc/Kconfig : 	select KASAN_VMALLOC			if KASAN && MODULES
> 
> arch/powerpc/include/asm/kasan.h:
> 
> #if defined(CONFIG_MODULES) && defined(CONFIG_PPC32)
> #define KASAN_KERN_START	ALIGN_DOWN(PAGE_OFFSET - SZ_256M, SZ_256M)
> #else
> #define KASAN_KERN_START	PAGE_OFFSET
> #endif
> 
> arch/powerpc/kernel/head_8xx.S and arch/powerpc/kernel/head_book3s_32.S: 
> InstructionTLBMiss interrupt handler must know that there is executable 
> kernel text outside kernel core.
> 
> Function is_module_segment() to identified segments used for module text 
> and set NX (NoExec) MMU flag on non-module segments.

Thanks Christophe, I'll fix that up.

I'm sure there are many other issues like this in the arch stuff here,
I'm going to run them all through QEMU to catch everything I can before
the next respin.

> >   arch/riscv/kernel/module.c       |  11 ---
> >   arch/riscv/mm/Makefile           |   1 +
> >   arch/riscv/mm/module_alloc.c     |  17 ++++
> >   arch/s390/kernel/module.c        |  37 ---------
> >   arch/s390/mm/Makefile            |   1 +
> >   arch/s390/mm/module_alloc.c      |  42 ++++++++++
> >   arch/sparc/kernel/module.c       |  31 --------
> >   arch/sparc/mm/Makefile           |   2 +
> >   arch/sparc/mm/module_alloc.c     |  31 ++++++++
> >   arch/x86/kernel/ftrace.c         |   2 +-
> >   arch/x86/kernel/module.c         |  56 -------------
> >   arch/x86/mm/Makefile             |   2 +
> >   arch/x86/mm/module_alloc.c       |  59 ++++++++++++++
> >   fs/proc/kcore.c                  |   2 +-
> >   kernel/module/Kconfig            |   1 +
> >   kernel/module/main.c             |  17 ----
> >   mm/Kconfig                       |   3 +
> >   mm/Makefile                      |   1 +
> >   mm/module_alloc.c                |  21 +++++
> >   mm/vmalloc.c                     |   2 +-
> >   42 files changed, 467 insertions(+), 402 deletions(-)
> 
> ...
> 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ffc3a2ba3a8c..92bfb5ae2e95 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1261,6 +1261,9 @@ config LOCK_MM_AND_FIND_VMA
> >   config IOMMU_MM_DATA
> >          bool
> > 
> > +config MODULE_ALLOC
> > +       def_bool n
> > +
> 
> I'd call it something else than CONFIG_MODULE_ALLOC as you want to use 
> it when CONFIG_MODULE is not selected.
> 
> Something like CONFIG_EXECMEM_ALLOC or CONFIG_DYNAMIC_EXECMEM ?
> 
> 
> 
> Christophe

