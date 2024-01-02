Return-Path: <linux-kernel+bounces-14247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0418219E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008BA1F222A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC900DF63;
	Tue,  2 Jan 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Y8QmCM26"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C920DF51
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a27cc66d67eso200718766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704191566; x=1704796366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+7moNHT/OR4dO2qTIN/UmqI4y92lVkHCwR4Iet1xro=;
        b=Y8QmCM26bGQYgxbxzLvyYauxNrVTHczX1m+6+DLhMjPMBZE11Sx291A7a9UkAiTdED
         fgRrKOUnw3Uwk63AbD4O7m8woTJugh8T+ufVZ+oh8HLqMPKm3x/IWyBXabVZUv0Sgkb1
         XU2PlgRRz0bOzY6Expkw6E6AQGzsnx0EFj3cDN5TxVYAdvqAGOo9xRF/otP/rXc4mf4s
         LVj45VMGWszZzpPltMe9oqt64BqAzVBhsWTg0bZM9xTj2GJfg91bZ4RsLzj3uqXdE9Wp
         po74jYbe9yqyg3+sqMWaMble4fstQ+Afo8asgIj1Ga5fVDHoKsYb0JMQqPP1yKQNEaEd
         ccsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191566; x=1704796366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+7moNHT/OR4dO2qTIN/UmqI4y92lVkHCwR4Iet1xro=;
        b=MqLUK6tlvLruIWMaLC/2QktYr6uK2UWfbezTmxiVt3b3B9Oym/ujc5Jj9tWTroHe0e
         Z20LeYY7sshAbDnAyJ4CMuumKLeLFuQAr+sEe2woW+/YNFM+HTJjh0me8bByspTHxsSq
         eHYCBWRe+Cf7aaQcH/5rpYQ4FSzI11aACNaSnIIR2GrN54iVOhqW8JCHmj/TmFdRJyv1
         e8FdCtcw//rxX3+d96QwA13y/2tUJh3KjVnw+7sj0fT+/fRH8UIq9XYXnsnGT6vUcZo2
         cBbMX3psUNFFVn9bLyVFYBRYJfZd+qAlHmpShC6rj+JeJU2iTqI1eKTBV0x4Hw/9/Fpp
         bHYw==
X-Gm-Message-State: AOJu0YyCfl5+n649DJCp7LM+prk7FLMYZ0euPBNWgBQrEvcuD5KLV0oS
	UHHP8FZ2IREqxueJVaEn2JoNB6jNpVqgPUkRO/xUnXmv2Dg=
X-Google-Smtp-Source: AGHT+IEtbbo3Y4eGqAi+tt7jMzv/FB7oFX6ON5NL7+kP5V4R1nwFSNRLvIkCvtNjXWYeta53DswsnA==
X-Received: by 2002:a17:906:6891:b0:a28:2084:edec with SMTP id n17-20020a170906689100b00a282084edecmr840102ejr.126.1704191566243;
        Tue, 02 Jan 2024 02:32:46 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26abf393d0sm11066460ejb.138.2024.01.02.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:32:45 -0800 (PST)
Date: Tue, 2 Jan 2024 11:32:44 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Message-ID: <20240102-4f12393de3c6313650a24c17@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231082955.16516-2-guoren@kernel.org>

On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Cache-block prefetch instructions are HINTs to the hardware to
> indicate that software intends to perform a particular type of
> memory access in the near future. This patch adds prefetch.i,
> prefetch.r and prefetch.w instruction definitions by
> RISCV_ISA_EXT_ZICBOP cpufeature.

It also adds S-type instruction encoding support which isn't mentioned.
Actually, it'd probably be best to put the new instruction encoding in
its own separate patch.

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                | 15 ++++++++
>  arch/riscv/include/asm/hwcap.h    |  1 +
>  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c    |  1 +
>  4 files changed, 77 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 24c1799e2ec4..fcbd417d65ea 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZICBOP
> +	bool "Zicbop extension support for cache block prefetch"
> +	depends on MMU
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	  Adds support to dynamically detect the presence of the ZICBOP
> +	  extension (Cache Block Prefetch Operations) and enable its
> +	  usage.
> +
> +	  The Zicbop extension can be used to prefetch cache block for

blocks

> +	  read/write fetch.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_ZIHINTPAUSE
>  	bool
>  	default y
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 06d30526ef3b..77d3b6ee25ab 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -57,6 +57,7 @@
>  #define RISCV_ISA_EXT_ZIHPM		42
>  #define RISCV_ISA_EXT_SMSTATEEN		43
>  #define RISCV_ISA_EXT_ZICOND		44
> +#define RISCV_ISA_EXT_ZICBOP		45
>  
>  #define RISCV_ISA_EXT_MAX		64
>  
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index e27179b26086..bbda350a63bf 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -18,6 +18,13 @@
>  #define INSN_I_RD_SHIFT			 7
>  #define INSN_I_OPCODE_SHIFT		 0
>  
> +#define INSN_S_SIMM7_SHIFT		25
> +#define INSN_S_RS2_SHIFT		20
> +#define INSN_S_RS1_SHIFT		15
> +#define INSN_S_FUNC3_SHIFT		12
> +#define INSN_S_SIMM5_SHIFT		 7
> +#define INSN_S_OPCODE_SHIFT		 0
> +
>  #ifdef __ASSEMBLY__
>  
>  #ifdef CONFIG_AS_HAS_INSN
> @@ -30,6 +37,10 @@
>  	.insn	i \opcode, \func3, \rd, \rs1, \simm12
>  	.endm
>  
> +	.macro insn_s, opcode, func3, rs2, simm12, rs1
> +	.insn	s \opcode, \func3, \rs2, \simm12(\rs1)
> +	.endm
> +
>  #else
>  
>  #include <asm/gpr-num.h>
> @@ -51,10 +62,20 @@
>  		 (\simm12 << INSN_I_SIMM12_SHIFT))
>  	.endm
>  
> +	.macro insn_s, opcode, func3, rs2, simm12, rs1
> +	.4byte	((\opcode << INSN_S_OPCODE_SHIFT) |		\
> +		 (\func3 << INSN_S_FUNC3_SHIFT) |		\
> +		 (.L__gpr_num_\rs2 << INSN_S_RS2_SHIFT) |	\
> +		 (.L__gpr_num_\rs1 << INSN_S_RS1_SHIFT) |	\
> +		 ((\simm12 & 0x1f) << INSN_S_SIMM5_SHIFT) |	\
> +		 (((\simm12 >> 5) & 0x7f) << INSN_S_SIMM7_SHIFT))
> +	.endm
> +
>  #endif
>  
>  #define __INSN_R(...)	insn_r __VA_ARGS__
>  #define __INSN_I(...)	insn_i __VA_ARGS__
> +#define __INSN_S(...)	insn_s __VA_ARGS__
>  
>  #else /* ! __ASSEMBLY__ */
>  
> @@ -66,6 +87,9 @@
>  #define __INSN_I(opcode, func3, rd, rs1, simm12)	\
>  	".insn	i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
>  
> +#define __INSN_S(opcode, func3, rs2, simm12, rs1)	\
> +	".insn	s " opcode ", " func3 ", " rs2 ", " simm12 "(" rs1 ")\n"
> +
>  #else
>  
>  #include <linux/stringify.h>
> @@ -92,12 +116,26 @@
>  "		 (\\simm12 << " __stringify(INSN_I_SIMM12_SHIFT) "))\n"	\
>  "	.endm\n"
>  
> +#define DEFINE_INSN_S							\
> +	__DEFINE_ASM_GPR_NUMS						\
> +"	.macro insn_s, opcode, func3, rs2, simm12, rs1\n"		\
> +"	.4byte	((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"	\
> +"		 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"	\
> +"		 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> +"		 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> +"		 ((\\simm12 & 0x1f) << " __stringify(INSN_S_SIMM5_SHIFT) ") |" \
> +"		 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> +"	.endm\n"
> +
>  #define UNDEFINE_INSN_R							\
>  "	.purgem insn_r\n"
>  
>  #define UNDEFINE_INSN_I							\
>  "	.purgem insn_i\n"
>  
> +#define UNDEFINE_INSN_S							\
> +"	.purgem insn_s\n"
> +
>  #define __INSN_R(opcode, func3, func7, rd, rs1, rs2)			\
>  	DEFINE_INSN_R							\
>  	"insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
> @@ -108,6 +146,11 @@
>  	"insn_i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n" \
>  	UNDEFINE_INSN_I
>  
> +#define __INSN_S(opcode, func3, rs2, simm12, rs1)			\
> +	DEFINE_INSN_S							\
> +	"insn_s " opcode ", " func3 ", " rs2 ", " simm12 ", " rs1 "\n"	\
> +	UNDEFINE_INSN_S
> +
>  #endif
>  
>  #endif /* ! __ASSEMBLY__ */
> @@ -120,6 +163,10 @@
>  	__INSN_I(RV_##opcode, RV_##func3, RV_##rd,		\
>  		 RV_##rs1, RV_##simm12)
>  
> +#define INSN_S(opcode, func3, rs2, simm12, rs1)			\
> +	__INSN_S(RV_##opcode, RV_##func3, RV_##rs2,		\
> +		 RV_##simm12, RV_##rs1)
> +
>  #define RV_OPCODE(v)		__ASM_STR(v)
>  #define RV_FUNC3(v)		__ASM_STR(v)
>  #define RV_FUNC7(v)		__ASM_STR(v)
> @@ -133,6 +180,7 @@
>  #define RV___RS2(v)		__RV_REG(v)
>  
>  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> +#define RV_OPCODE_OP_IMM	RV_OPCODE(19)
>  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
>  
>  #define HFENCE_VVMA(vaddr, asid)				\
> @@ -196,4 +244,16 @@
>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
>  	       RS1(base), SIMM12(4))
>  
> +#define CBO_PREFETCH_I(base, offset)				\
> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> +	       SIMM12(offset), RS1(base))
> +
> +#define CBO_PREFETCH_R(base, offset)				\
> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> +	       SIMM12(offset), RS1(base))
> +
> +#define CBO_PREFETCH_W(base, offset)				\
> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> +	       SIMM12(offset), RS1(base))

Shouldn't we ensure the lower 5-bits of offset are zero by masking it?

> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b3785ffc1570..bdb02b066041 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -168,6 +168,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> +	__RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),

zicbop should be above zicboz (alphabetical)

>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> -- 
> 2.40.1
>

Thanks,
drew

