Return-Path: <linux-kernel+bounces-15335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34ED822A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94A2285543
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F925182CC;
	Wed,  3 Jan 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lQemXYE7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6D182BD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33728f82a71so649446f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704274299; x=1704879099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9uDezisEo7XMuHV8wwAXU0SFJzFSRTpyjItegN/kow=;
        b=lQemXYE7aYoBAzzoyUP5KMskY9C1+b8te6Kf7U5DkMnLA1819B8xh6jDa1CriFMri1
         +4Uq0fxsHsSVmrHdeqTIiFDdlVoXnRSCe1IhGWO8aH2ZG+uXIn/5XL9eR//DnV/3dvVW
         ZDZJ9lqWWxznPBCRlNajtu7TKv8XMixj9weY9nmLwnkWTh9JykK8+fyGBhhZHE7nhnSL
         huSYyzMEG8MdlxNrYhNGfPLkmHaHbvLaRDlcMHd+aR5RqFWhenJ5VMXbcGJ/O0ZNGn4K
         WrYyQMJWONHU/mJvIP0ksT4XgTaWf64SJqNhwfDFn05ZNYXnvH/6ofCWeLggaeD5Etv6
         B8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704274299; x=1704879099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9uDezisEo7XMuHV8wwAXU0SFJzFSRTpyjItegN/kow=;
        b=gW+aiN15D9/xOxU6mXDBGlhZcB+Ue6G143Oz1vdlFMgvC+/U2VrqBW2/3ybt+Z+m4w
         J0Nm/Ckgquhjxnv55cOxfWEgdzj/HUrxVmG7kuMuKGCCoFnzCQ6dHowvhSd/Z6TrxzsX
         c6qGzsZgpba0ULVZx9KqYg3SgWmE78ibyAW/1WXv+p/tECQyez4Sk4WItokqhEOuS6Vg
         kIFls9j8nOqf3NU9KkgGx93qnKcZdLk2+eONpZqVXpKHQ+gvPLQkdC6ECyMGTOg2yLk8
         wnJ/B5fYUM09sxJMMbke9Affm2HSBd8cZR/3GiIDIDQVVWKf/uS2Wedg41LGgqOSZ3gO
         0cdQ==
X-Gm-Message-State: AOJu0YzcaMXO1EKBN0M8lpW5aFj8z77Ha8/hfBjtYxi0u8cyi3KJXCV/
	hqTsT2FXSgo/8uyQL0AZUBOYrtnGgWPkQw==
X-Google-Smtp-Source: AGHT+IFVbuWhDuB7pWxpAAjAafAMRBk4uSRXoyfpkcdql8o7BYqtqGOW9meffxeVI8BmE1VJLjrePg==
X-Received: by 2002:adf:ed50:0:b0:337:476f:9964 with SMTP id u16-20020adfed50000000b00337476f9964mr2526039wro.3.1704274299396;
        Wed, 03 Jan 2024 01:31:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:3fe4:3880:d961:d4bf? ([2a01:e0a:999:a3a0:3fe4:3880:d961:d4bf])
        by smtp.gmail.com with ESMTPSA id p9-20020adfcc89000000b003368100ff71sm30147851wrj.10.2024.01.03.01.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:31:38 -0800 (PST)
Message-ID: <6bce1adb-6808-40df-8dd7-b0b2c6031547@rivosinc.com>
Date: Wed, 3 Jan 2024 10:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Content-Language: en-US
To: guoren@kernel.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guo Ren <guoren@linux.alibaba.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com,
 conor.dooley@microchip.com, leobras@redhat.com, peterz@infradead.org,
 keescook@chromium.org, wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com,
 chao.wei@sophgo.com, unicorn_wang@outlook.com, uwu@icenowy.me,
 jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org,
 ajones@ventanamicro.com
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231231082955.16516-2-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/12/2023 09:29, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Cache-block prefetch instructions are HINTs to the hardware to
> indicate that software intends to perform a particular type of
> memory access in the near future. This patch adds prefetch.i,
> prefetch.r and prefetch.w instruction definitions by
> RISCV_ISA_EXT_ZICBOP cpufeature.
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

Hi Guo,

Since you are adding support for the Zicbop extension, you could
probably also allow to probe it from userspace using hwprobe. Add a few
definitions to sys_riscv.c/hwprobe.h and it will be fine.

Thanks,

Clément

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
>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

