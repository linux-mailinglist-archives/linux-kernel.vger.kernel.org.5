Return-Path: <linux-kernel+bounces-15940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C28235F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A361F2599A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E81D52B;
	Wed,  3 Jan 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cGN0J5dg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB491D521
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d60ad5f0bso69342805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704311808; x=1704916608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQpfnnWEnHClKL5VeX0EuSbQ/gShXCqkBTi6s+0qxQc=;
        b=cGN0J5dg3ggZrtfg/sOdr7Xm5fs5I+anWLCJhCiYReS+26/nuVbrIS5mzp8Z1xi1YF
         pPc6YG+JhNMs4UrY8OM9lKgzdcvZZIZYV8QVXP4yabFphOZ9QOyLjfA5hSFL7a4JKUVw
         04as57DJzghKxBe+FVUFIL5nqrMtSFX9h7FkbBNnzOD8pCTFVCPX5OoLhovqBT/nOBzv
         ELQd7IwWGzmOwFEYRJI9E7JLiAsYLXoawJUlk6c3kYVyyxRwrDW6mDjL0B09/GvDKTJ9
         kQuX9VrmpzmrNRPd4V8j4lXNcZScECJZKtFmhLGWmQsVotQ8PWhax6lOyFsP4sLW+kuu
         jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311808; x=1704916608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQpfnnWEnHClKL5VeX0EuSbQ/gShXCqkBTi6s+0qxQc=;
        b=fHOTZhUeFwRO9XvtqoTTW+PU7WdrsWz8KJpaGx1uJl4zN7XWk4JR6MSN9qQN7N0n4r
         aSSs5cqstqNeHcUWkQUW0g1oL/Uq9prkHAOFaFUnjOTcEKN6OQ00qzaHDg//dLvX6Tb8
         GNRKb4Su8ZTM/ck+RJJG6/4IOn9Uh5fr7aaWZrNKSs9ysMjcWlmsr9kvCXJDBiqDQPmb
         33E1HnPDFsS7Ew0xmOV1yPS0mzfAXogxhGBGW/5vSpcrFDfGpV3UlsMJ17Sozz6u/V7e
         qdIH9sXNTVyYBddC0VinbK8IhROl3MVXEdOrV0r+X3YF0gz/lTBLSp7wu1Yh5yjgh1zj
         k3rg==
X-Gm-Message-State: AOJu0YymYwq0fCGvI3eGPAT5k91FcXYRtCF2OhRsIySGUwhtMe8ivqJs
	a46lwM5V2etnkiFtCF41pAWV6dqLTY9kIA==
X-Google-Smtp-Source: AGHT+IHl1CgXWvun0bw1CzClW51Zc4dr0dFkATBjeaM+4RA7PNRbWnHLE7I/Z1940e5jZa5sGKcmUQ==
X-Received: by 2002:a05:600c:4ed0:b0:40d:87be:d6d4 with SMTP id g16-20020a05600c4ed000b0040d87bed6d4mr3150765wmq.68.1704311808267;
        Wed, 03 Jan 2024 11:56:48 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id w18-20020adff9d2000000b003375083ff8esm564320wrr.32.2024.01.03.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:56:47 -0800 (PST)
Date: Wed, 3 Jan 2024 20:56:47 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Guo Ren <guoren@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
Message-ID: <20240103-d6e1246e0f45f602a32c5469@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-3-guoren@kernel.org>
 <20240102-7e62facbd8322db4dee4b0dd@orel>
 <CAJF2gTRv4UgSHMTp_tOhNGV2mQXBt1dPj6RdB2XXBGfT6iCWSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRv4UgSHMTp_tOhNGV2mQXBt1dPj6RdB2XXBGfT6iCWSw@mail.gmail.com>

On Wed, Jan 03, 2024 at 02:19:49PM +0800, Guo Ren wrote:
> On Tue, Jan 2, 2024 at 6:45 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> >
> > s/Zibop/Zicbop/ <<<$SUBJECT
> okay
> 
> >
> > On Sun, Dec 31, 2023 at 03:29:52AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Enable Linux prefetchw primitive with Zibop cpufeature, which preloads
> >
> > Also s/Zibop/Zicbop/ here
> okay, thx.
> 
> >
> > > cache line into L1 cache for the next write operation.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > index f19f861cda54..8d3a2ab37678 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -13,6 +13,9 @@
> > >  #include <vdso/processor.h>
> > >
> > >  #include <asm/ptrace.h>
> > > +#include <asm/insn-def.h>
> > > +#include <asm/alternative-macros.h>
> > > +#include <asm/hwcap.h>
> > >
> > >  #ifdef CONFIG_64BIT
> > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > @@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
> > >  #define KSTK_EIP(tsk)                (task_pt_regs(tsk)->epc)
> > >  #define KSTK_ESP(tsk)                (task_pt_regs(tsk)->sp)
> > >
> > > +#ifdef CONFIG_RISCV_ISA_ZICBOP
> > > +#define ARCH_HAS_PREFETCHW
> > > +
> > > +#define PREFETCHW_ASM(x)                                             \
> > > +     ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,                 \
> > > +                 RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
> > > +
> > > +
> > > +static inline void prefetchw(const void *x)
> > > +{
> > > +     __asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
> > > +}
> >
> > Shouldn't we create an interface which exposes the offset input of
> > the instruction, allowing a sequence of calls to be unrolled? But
> > I guess that could be put off until there's a need for it.
> I want to put it off until there's a user. Let's keep the whole
> imm[11:0] zero for the current.

Yeah, my suggestion didn't make sense in this context anyway since we need
to match the interface in linux/prefetch.h. Considering linux/prefetch.h,
is there some reason we don't also add prefetch() at the same time?

Thanks,
drew

> 
> >
> > > +#endif /* CONFIG_RISCV_ISA_ZICBOP */
> > >
> > >  /* Do necessary setup to start up a newly executed thread. */
> > >  extern void start_thread(struct pt_regs *regs,
> > > --
> > > 2.40.1
> > >
> >
> > Thanks,
> > drew
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren

