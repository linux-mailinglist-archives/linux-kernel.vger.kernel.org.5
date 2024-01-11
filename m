Return-Path: <linux-kernel+bounces-23408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E200C82AC65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A54280F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8AB14F96;
	Thu, 11 Jan 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V0J9QG4B"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FA14F8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so5716046e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704969949; x=1705574749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pp/RzTW2ENIeMjvlT7QtnBz9isedj0q651h0e5oZKPg=;
        b=V0J9QG4BRxY3YtMBaCpXyyTOxk7Hteiz2xmFQOONf7rzeW5PqPGNyZ1mEgy/vqrA3r
         6rHuzxGi3nhoZRli3xks55xFyv3M7x0vVb1QUc8BXq8imbEiPfxaGygD+Cd2WWcafvXz
         zGA4a7WpwVkjRQe4FoheS8G4cfn0p/siBXKLOH6/YrF0VhaI0muyhBrkLn/iMJLxduq0
         uLjXPp2LVAYqVX8gerI9AvhEh+KNV9G6v49F9WLHYT53c/VLFy8t0lJ+cbPKOrbUOXzv
         SF2u0Vc3pqI+ga6lOdUPPNyPl2H6cCZGa/qRcIaZqRwxbmsEkV7uHsZ3GwI4A23+dx0d
         GFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969949; x=1705574749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp/RzTW2ENIeMjvlT7QtnBz9isedj0q651h0e5oZKPg=;
        b=WQOmsY89W7jyVIJcfFaZoqk1aS2iWcMT00NvIbXp+bJIoRH/zFUvppbQDr5OVi/fEj
         fmy1mjCoAIIt6wVWOw8f2jKmth8gIYrx1VDIz32T5ABX3/YN0cbJ2tnU9UN1lzGz36Id
         sPBKO2W8w2mZ7ZHUn3XXVjmPtrr+eQa7wjXUTg/IGKrvhzai94mjPQ658a0ea8N+N+0t
         lzn38xn1p0AVoZzhl0JBm3B18S3NHKadUcmJ5oWf2kXQcNgTMDzOA1Mw04PUVfSlXNjA
         qEq9RzsbEOyxKS5+fsdQe9S1FVVv1DlEA/mlI1aJ5uuZuoPJcXm1UzSvqHhKgFWM6kOk
         7nNA==
X-Gm-Message-State: AOJu0YwEtecSi+M07oyI/eaDE6qdxyTOHHBew2clcyC8ZK+gQ4T6d8xh
	g0d4Bo+rtQ9GiA168Io5f1BdPnMcgNfInA==
X-Google-Smtp-Source: AGHT+IGW0ew9/5bfKezah2jEzOP3drhNFEIse7ZrReUyXJN7PysmLkabQFgAofPsMXAVqeDNTFjRcw==
X-Received: by 2002:a05:6512:11c8:b0:50e:3e26:8e54 with SMTP id h8-20020a05651211c800b0050e3e268e54mr398666lfr.60.1704969948566;
        Thu, 11 Jan 2024 02:45:48 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090654c300b00a2a2426728bsm421171ejp.178.2024.01.11.02.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:45:48 -0800 (PST)
Date: Thu, 11 Jan 2024 11:45:47 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: guoren@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, 
	conor.dooley@microchip.com, leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org
Subject: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Message-ID: <20240111-416377ebfcaff924b71fb419@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <6bce1adb-6808-40df-8dd7-b0b2c6031547@rivosinc.com>
 <20240103-77f6b0856efb7a9f4591c53b@orel>
 <331610f6-9987-4d1b-8d57-f21311a43f5d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <331610f6-9987-4d1b-8d57-f21311a43f5d@rivosinc.com>

On Thu, Jan 11, 2024 at 11:31:32AM +0100, Cl�ment L�ger wrote:
> 
> 
> On 03/01/2024 13:00, Andrew Jones wrote:
> > On Wed, Jan 03, 2024 at 10:31:37AM +0100, Cl�ment L�ger wrote:
> >>
> >>
> >> On 31/12/2023 09:29, guoren@kernel.org wrote:
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> Cache-block prefetch instructions are HINTs to the hardware to
> >>> indicate that software intends to perform a particular type of
> >>> memory access in the near future. This patch adds prefetch.i,
> >>> prefetch.r and prefetch.w instruction definitions by
> >>> RISCV_ISA_EXT_ZICBOP cpufeature.
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>> ---
> >>>  arch/riscv/Kconfig                | 15 ++++++++
> >>>  arch/riscv/include/asm/hwcap.h    |  1 +
> >>>  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++++++
> >>>  arch/riscv/kernel/cpufeature.c    |  1 +
> >>>  4 files changed, 77 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index 24c1799e2ec4..fcbd417d65ea 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
> >>>  
> >>>  	   If you don't know what to do here, say Y.
> >>>  
> >>> +config RISCV_ISA_ZICBOP
> >>> +	bool "Zicbop extension support for cache block prefetch"
> >>> +	depends on MMU
> >>> +	depends on RISCV_ALTERNATIVE
> >>> +	default y
> >>> +	help
> >>> +	  Adds support to dynamically detect the presence of the ZICBOP
> >>> +	  extension (Cache Block Prefetch Operations) and enable its
> >>> +	  usage.
> >>> +
> >>> +	  The Zicbop extension can be used to prefetch cache block for
> >>> +	  read/write fetch.
> >>> +
> >>> +	  If you don't know what to do here, say Y.
> >>> +
> >>>  config TOOLCHAIN_HAS_ZIHINTPAUSE
> >>>  	bool
> >>>  	default y
> >>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> >>> index 06d30526ef3b..77d3b6ee25ab 100644
> >>> --- a/arch/riscv/include/asm/hwcap.h
> >>> +++ b/arch/riscv/include/asm/hwcap.h
> >>> @@ -57,6 +57,7 @@
> >>>  #define RISCV_ISA_EXT_ZIHPM		42
> >>>  #define RISCV_ISA_EXT_SMSTATEEN		43
> >>>  #define RISCV_ISA_EXT_ZICOND		44
> >>> +#define RISCV_ISA_EXT_ZICBOP		45
> >>
> >> Hi Guo,
> >>
> >> Since you are adding support for the Zicbop extension, you could
> >> probably also allow to probe it from userspace using hwprobe. Add a few
> >> definitions to sys_riscv.c/hwprobe.h and it will be fine.
> > 
> > To expose to userspace, we should also start parsing the block size,
> > so it can also be exposed to userspace. Starting to parse the block
> > size first requires that we decide we need to parse the block size
> > (see [1]).
> 
> Hi Andrew, thanks for the thread.
> 
> I read it (and the other ones that are related to it) and basically, it
> seems there was a first decision (expose Zicbop block size indivudally)
> due to the fact the specification did not mentioned anything specific
> about clock sizes  but then after that, there was a clarification in the
> spec stating that Zicbop and Zicbom have the same block size so the
> first decision was questioned again.
> 
> From a user coherency point of view, I think it would make more sense to
> expose it individually in hwprobe  so that zicboz, zicbop and zicbom
> have their "own" block size (even though zicbop and zicbom would use the
> same one). Moreover, it would allow us for future evolution easily
> without breaking any userspace later if zicbop and zicbom block size are
> decoupled.

I agree and QEMU has already headed down the road of generating
riscv,cbop-block-size (I guess Conor's ack on [1] was interpreted as
being sufficient to merge the QEMU bits), so we can add the Linux
support and test with QEMU now. The work could probably be a separate
series to this one, though.

Thanks,
drew

> 
> Cl�ment
> 
> > 
> > [1] https://lore.kernel.org/all/20231029123500.739409-1-dbarboza@ventanamicro.com/
> > 
> > Thanks,
> > drew
> > 
> > 
> >>
> >> Thanks,
> >>
> >> Cl�ment
> >>
> >>>  
> >>>  #define RISCV_ISA_EXT_MAX		64
> >>>  
> >>> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> >>> index e27179b26086..bbda350a63bf 100644
> >>> --- a/arch/riscv/include/asm/insn-def.h
> >>> +++ b/arch/riscv/include/asm/insn-def.h
> >>> @@ -18,6 +18,13 @@
> >>>  #define INSN_I_RD_SHIFT			 7
> >>>  #define INSN_I_OPCODE_SHIFT		 0
> >>>  
> >>> +#define INSN_S_SIMM7_SHIFT		25
> >>> +#define INSN_S_RS2_SHIFT		20
> >>> +#define INSN_S_RS1_SHIFT		15
> >>> +#define INSN_S_FUNC3_SHIFT		12
> >>> +#define INSN_S_SIMM5_SHIFT		 7
> >>> +#define INSN_S_OPCODE_SHIFT		 0
> >>> +
> >>>  #ifdef __ASSEMBLY__
> >>>  
> >>>  #ifdef CONFIG_AS_HAS_INSN
> >>> @@ -30,6 +37,10 @@
> >>>  	.insn	i \opcode, \func3, \rd, \rs1, \simm12
> >>>  	.endm
> >>>  
> >>> +	.macro insn_s, opcode, func3, rs2, simm12, rs1
> >>> +	.insn	s \opcode, \func3, \rs2, \simm12(\rs1)
> >>> +	.endm
> >>> +
> >>>  #else
> >>>  
> >>>  #include <asm/gpr-num.h>
> >>> @@ -51,10 +62,20 @@
> >>>  		 (\simm12 << INSN_I_SIMM12_SHIFT))
> >>>  	.endm
> >>>  
> >>> +	.macro insn_s, opcode, func3, rs2, simm12, rs1
> >>> +	.4byte	((\opcode << INSN_S_OPCODE_SHIFT) |		\
> >>> +		 (\func3 << INSN_S_FUNC3_SHIFT) |		\
> >>> +		 (.L__gpr_num_\rs2 << INSN_S_RS2_SHIFT) |	\
> >>> +		 (.L__gpr_num_\rs1 << INSN_S_RS1_SHIFT) |	\
> >>> +		 ((\simm12 & 0x1f) << INSN_S_SIMM5_SHIFT) |	\
> >>> +		 (((\simm12 >> 5) & 0x7f) << INSN_S_SIMM7_SHIFT))
> >>> +	.endm
> >>> +
> >>>  #endif
> >>>  
> >>>  #define __INSN_R(...)	insn_r __VA_ARGS__
> >>>  #define __INSN_I(...)	insn_i __VA_ARGS__
> >>> +#define __INSN_S(...)	insn_s __VA_ARGS__
> >>>  
> >>>  #else /* ! __ASSEMBLY__ */
> >>>  
> >>> @@ -66,6 +87,9 @@
> >>>  #define __INSN_I(opcode, func3, rd, rs1, simm12)	\
> >>>  	".insn	i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
> >>>  
> >>> +#define __INSN_S(opcode, func3, rs2, simm12, rs1)	\
> >>> +	".insn	s " opcode ", " func3 ", " rs2 ", " simm12 "(" rs1 ")\n"
> >>> +
> >>>  #else
> >>>  
> >>>  #include <linux/stringify.h>
> >>> @@ -92,12 +116,26 @@
> >>>  "		 (\\simm12 << " __stringify(INSN_I_SIMM12_SHIFT) "))\n"	\
> >>>  "	.endm\n"
> >>>  
> >>> +#define DEFINE_INSN_S							\
> >>> +	__DEFINE_ASM_GPR_NUMS						\
> >>> +"	.macro insn_s, opcode, func3, rs2, simm12, rs1\n"		\
> >>> +"	.4byte	((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"	\
> >>> +"		 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"	\
> >>> +"		 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> >>> +"		 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> >>> +"		 ((\\simm12 & 0x1f) << " __stringify(INSN_S_SIMM5_SHIFT) ") |" \
> >>> +"		 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> >>> +"	.endm\n"
> >>> +
> >>>  #define UNDEFINE_INSN_R							\
> >>>  "	.purgem insn_r\n"
> >>>  
> >>>  #define UNDEFINE_INSN_I							\
> >>>  "	.purgem insn_i\n"
> >>>  
> >>> +#define UNDEFINE_INSN_S							\
> >>> +"	.purgem insn_s\n"
> >>> +
> >>>  #define __INSN_R(opcode, func3, func7, rd, rs1, rs2)			\
> >>>  	DEFINE_INSN_R							\
> >>>  	"insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
> >>> @@ -108,6 +146,11 @@
> >>>  	"insn_i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n" \
> >>>  	UNDEFINE_INSN_I
> >>>  
> >>> +#define __INSN_S(opcode, func3, rs2, simm12, rs1)			\
> >>> +	DEFINE_INSN_S							\
> >>> +	"insn_s " opcode ", " func3 ", " rs2 ", " simm12 ", " rs1 "\n"	\
> >>> +	UNDEFINE_INSN_S
> >>> +
> >>>  #endif
> >>>  
> >>>  #endif /* ! __ASSEMBLY__ */
> >>> @@ -120,6 +163,10 @@
> >>>  	__INSN_I(RV_##opcode, RV_##func3, RV_##rd,		\
> >>>  		 RV_##rs1, RV_##simm12)
> >>>  
> >>> +#define INSN_S(opcode, func3, rs2, simm12, rs1)			\
> >>> +	__INSN_S(RV_##opcode, RV_##func3, RV_##rs2,		\
> >>> +		 RV_##simm12, RV_##rs1)
> >>> +
> >>>  #define RV_OPCODE(v)		__ASM_STR(v)
> >>>  #define RV_FUNC3(v)		__ASM_STR(v)
> >>>  #define RV_FUNC7(v)		__ASM_STR(v)
> >>> @@ -133,6 +180,7 @@
> >>>  #define RV___RS2(v)		__RV_REG(v)
> >>>  
> >>>  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> >>> +#define RV_OPCODE_OP_IMM	RV_OPCODE(19)
> >>>  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> >>>  
> >>>  #define HFENCE_VVMA(vaddr, asid)				\
> >>> @@ -196,4 +244,16 @@
> >>>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> >>>  	       RS1(base), SIMM12(4))
> >>>  
> >>> +#define CBO_PREFETCH_I(base, offset)				\
> >>> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> >>> +	       SIMM12(offset), RS1(base))
> >>> +
> >>> +#define CBO_PREFETCH_R(base, offset)				\
> >>> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> >>> +	       SIMM12(offset), RS1(base))
> >>> +
> >>> +#define CBO_PREFETCH_W(base, offset)				\
> >>> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> >>> +	       SIMM12(offset), RS1(base))
> >>> +
> >>>  #endif /* __ASM_INSN_DEF_H */
> >>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> >>> index b3785ffc1570..bdb02b066041 100644
> >>> --- a/arch/riscv/kernel/cpufeature.c
> >>> +++ b/arch/riscv/kernel/cpufeature.c
> >>> @@ -168,6 +168,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >>>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> >>>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >>>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> >>> +	__RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
> >>>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> >>>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
> >>>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

