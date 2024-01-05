Return-Path: <linux-kernel+bounces-17879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB282547E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB391C21B99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDA2D61B;
	Fri,  5 Jan 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T2rSBTry"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C72D609
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a27cd5850d6so168528966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704461500; x=1705066300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgP+th0N7B9odu3YvrC1EGNYppOPseXtnsirIxKlnzQ=;
        b=T2rSBTry2/mDpiuajiNPPpZdKnz1lWBMk6CVmwc7+qH8meFgkwN8iCJXL1PlMwZVAf
         exSS/IxZ9wykmVhnQwuWPPToZAH9rLzDg3k84dek4peCydbieojVLpUy1GGJCgsX8uqY
         FlfYEunHeb99zbDVtFu65nXvUqJdJRfR0B+xzy/MoNtbWbgjBPC+3j7Q+R5M0oRjsaeI
         hfT79ZjnYxI3DJS3WpYCFeuET49xjqM0nqmTq2oFBVWaE87zaEWvSKLl61Y2xgnq+HPc
         zdUDVoWmL31am6eu91hO+S3kaUNR33L2dF48e7q/TpJVtGyYVMwHm7bT5pZZeY8A4cUM
         W4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461500; x=1705066300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgP+th0N7B9odu3YvrC1EGNYppOPseXtnsirIxKlnzQ=;
        b=M0iIjSEgQFpg8AQYerZC6pymzJZnR2RgHg1i4piBdfsL2SwNnoSG7R3E77gbXejGBU
         2RGimbmx8QjlgJEaHKmjECvgo0qdzPY8HCr4YdRheyWHI2sERSlQM4qD39Ll00iVEH8F
         ZAv/SGcVK/sx+d+KgDppkhfHovPe/Wh/IH+doAHpQ2P4TUnJEeCJPvEIPCYFgAnDGxIP
         mqzNRFvHVGCAYh5MRjuEYE6fqNYCRmr8/gn26M6ZqV4GozLA79gi22hogXux2VT5qBjt
         QYqnp3uGP43iw+jbUX1UcEQ6qKCjLHOl3opRnPKZRU+3HKRU3/dJGvDf67QNFgMVhzqc
         7ZqA==
X-Gm-Message-State: AOJu0YywQGSEoISkvRxkPCLyrCC4C96kEzmdYreeYuuUmpexx85Ruozg
	4FCg5B0S+iu13SDtOdIQ41iEqf454yf0wQ==
X-Google-Smtp-Source: AGHT+IHsDn1zlEL9dKqlyookSTiwAgSDkb7D5CEkubKbDV9ro1vL62QGKpKBt5CAdUiG8cQsJUxVQw==
X-Received: by 2002:a17:906:aad3:b0:a28:b21b:ee5 with SMTP id kt19-20020a170906aad300b00a28b21b0ee5mr1051218ejb.75.1704461500565;
        Fri, 05 Jan 2024 05:31:40 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id k27-20020a1709061c1b00b00a272de16f52sm885194ejg.112.2024.01.05.05.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:31:39 -0800 (PST)
Date: Fri, 5 Jan 2024 14:31:39 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
Message-ID: <20240105-6dba80fb50413c0869b0beb3@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-3-guoren@kernel.org>
 <20240102-7e62facbd8322db4dee4b0dd@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-7e62facbd8322db4dee4b0dd@orel>

On Tue, Jan 02, 2024 at 11:45:08AM +0100, Andrew Jones wrote:
> 
> s/Zibop/Zicbop/ <<<$SUBJECT
> 
> On Sun, Dec 31, 2023 at 03:29:52AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Enable Linux prefetchw primitive with Zibop cpufeature, which preloads
> 
> Also s/Zibop/Zicbop/ here
> 
> > cache line into L1 cache for the next write operation.
> > 
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..8d3a2ab37678 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -13,6 +13,9 @@
> >  #include <vdso/processor.h>
> >  
> >  #include <asm/ptrace.h>
> > +#include <asm/insn-def.h>
> > +#include <asm/alternative-macros.h>
> > +#include <asm/hwcap.h>
> >  
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > @@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
> >  #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
> >  #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
> >  
> > +#ifdef CONFIG_RISCV_ISA_ZICBOP
> > +#define ARCH_HAS_PREFETCHW
> > +
> > +#define PREFETCHW_ASM(x)						\
> > +	ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,			\
> > +		    RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
> > +
> > +
> > +static inline void prefetchw(const void *x)
> > +{
> > +	__asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
> > +}
> 
> Shouldn't we create an interface which exposes the offset input of
> the instruction, allowing a sequence of calls to be unrolled? But
> I guess that could be put off until there's a need for it.

If we did expose offset, then, because it must be constant and also must
only have bits 5-11 set, then we could add a static assert. Something like

 #define prefetchw_offset(base, offset) \
 ({ \
     static_assert(__builtin_constant_p(offset) && !(offset & ~GENMASK(11, 5))); \
     __asm__ __volatile__(PREFETCHW_ASM(%0, %1) : : "r" (x), "I" (offset) : "memory"); \
 })

Probably overkill though...

Thanks,
drew

