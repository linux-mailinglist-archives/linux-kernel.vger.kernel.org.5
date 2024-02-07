Return-Path: <linux-kernel+bounces-57249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81984D5A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C1F1C24BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAB200AE;
	Wed,  7 Feb 2024 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vxXMfrUv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE8FC1D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343731; cv=none; b=JfW2pd9LVXI1LW7vYa9vyL8mVxlMkAzTrIsD9rd9u6bgBA35YCMyUzkiJm+QrtrZXfZtfkQN+8FVoJ3mP850HDx820iXFt7t9BDaw0Z75F/hEOBmPCIVYGOfdbcuBKPNaYwpv/led3Z00mEJYVyt4HIJYIwOEW7zqObXnpmA60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343731; c=relaxed/simple;
	bh=zq3JUiDVtvan0UsnTe+CsDoDqLTTiNVZZE26o5L5//k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKCYb5UxNanrATrixZdEJrtWa7oJNEESmBjJyAaEiuJKJiBncqNue524RcL2Rg3f7AAiDF6yqCucbbFd3vnuoM4XS8eEGriOkMCqUnO7ZLqPPLq6ZAX/slK8y6wCEX9W1fiJROlbNAlmDzSwE2KOcOB+14xl5Z9GXw+wyLMc7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vxXMfrUv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6daf694b439so983249b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 14:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707343728; x=1707948528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VP1GaO8yBte8x8UqhhgufPbWp8S+qR3qt5sB/Le/8GU=;
        b=vxXMfrUviXdIrGIPx7XhDEZGEAbM3QbdfGyj+kHsh7P+6Lf5BGLz57p/OS3Nfedp5s
         YFJ2M3rhKLhHb0y2Kz7JqcwzhRp8OhgNOIPSsTPuUAOfCN8orYaUqSCCjuE89Q6fmcLw
         lWb1DyMPv1lLf6MmXdkz5c/+TjXFbKG/UcX2PSsgeRZvp10UMa49Dr174NjDbxWsmF3J
         +YYrIdfX1RwaNyuGHsom7nKMip0NiBJu4cSki7sQDig029s59bdrhoiHAMZ8XIynMddO
         ct5ZRDJh7lPN6fv7t+JhqzuqS3Umcq00ouGqhB5iHuFtpaFWAyF4rs/2pqAdgTosdt8f
         e7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707343728; x=1707948528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VP1GaO8yBte8x8UqhhgufPbWp8S+qR3qt5sB/Le/8GU=;
        b=gCMXs2VY2zEwV7bqN5esHukySRRmeuWicTcCGx8nLddQJyaEw/F5Pc9GMRrCiML0JC
         3kUkHGbBz+ogjyU4OwthzZTr4Oxo8RF616bMDx0NoZ+odC0pnxdbQvBkQUyG+XzWJ9Vl
         DdTAQqUckxGcyJwP8jcNvnmWgoQ1mICi/uUbStq3eE7NvsGQz29ao9K6T/pFZLqkdS+Y
         Q9q3ERVqRGoNQg6vOWiRw3Lj8lTdq0hkXQ7T+2jIYIWk9sMmRLC78dnvGQWhFZyDUVFb
         fdmnwwpjf0QavuJDX3PpaYentwS4iT44IjqegRxXPBWvQ7Yj/bV7i/z6mFIovpGRABn+
         hHXQ==
X-Gm-Message-State: AOJu0YxcCQZa5t+C95c/SMkLNYR1Rtiq1mbh17LOUphTa3uZvoFg9tVG
	zDiuZCaWyMC3fPs2sWurXeiqt1CLOHl5bJBEOr7qqmalw3mxBOv5hYvoSt497PM=
X-Google-Smtp-Source: AGHT+IG02I2awJn4mfQEvfbb6d/ZMppfjlJs6l570ZImP3dYCiEQOfqygzvj7rQ8G7iEFIHFRPcgug==
X-Received: by 2002:a62:e808:0:b0:6e0:4759:88f2 with SMTP id c8-20020a62e808000000b006e0475988f2mr3921268pfi.4.1707343728380;
        Wed, 07 Feb 2024 14:08:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDXNgnEDcri4FjIzqDqj+oozPGRTkmr8lbhyQy2no6rdUcHZvi6WwsQ81v33uB64uKQ7k9AziT0MUaE0EP92kql2RiNMRzyigmvLesaxViHMmIry0JECvXV5Vg33iV68auJeKNsNgfM75UEhhNVjUL3ZDqhyqsb8E4b4H7uxR1j+BuPXm0VjyJ2OV7fOudwEZKt83O9NdMoNglxyr9Uwszwqli0JWR9oLczk8orVLT/pZ6SvWO1BRUhby1T86qun4TbIVEuG8YAnFe9v0=
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id r14-20020a62e40e000000b006e051ec4f90sm2166465pfh.84.2024.02.07.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 14:08:47 -0800 (PST)
Date: Wed, 7 Feb 2024 14:08:45 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2] riscv: misaligned: remove CONFIG_RISCV_M_MODE
 specific code
Message-ID: <ZcP/bQizfVcwrf3R@ghost>
References: <20240206154104.896809-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206154104.896809-1-cleger@rivosinc.com>

On Tue, Feb 06, 2024 at 04:40:59PM +0100, Clément Léger wrote:
> While reworking code to fix sparse errors, it appears that the
> RISCV_M_MODE specific could actually be removed and use the one for
> normal mode. Even though RISCV_M_MODE can do direct user memory access,
> using the user uaccess helpers is also going to work. Since there is no
> need anymore for specific accessors (load_u8()/store_u8()), we can
> directly use memcpy()/copy_{to/from}_user() and get rid of the copy
> loop entirely. __read_insn() is also fixed to use an unsigned long
> instead of a pointer which was cast in __user address space. The
> insn_addr parameter is now cast from unsigned lnog to the correct
> address space directly.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
> 
> The test used to validate these changes is the one used originally for
> S-mode misaligned support:
> 
> https://github.com/clementleger/unaligned_test
> 
> This test exercise (almost) all the supported instructions, all the
> registers for FPU instructions and is compiled with and without
> compressed instructions.
> 
> For S-mode, you simply need a classic toolchain and export CROSS_COMPILE
> to match it.
> 
> For M-mode validation, the following steps can be used:
> 
> Build a nommu toolchain with buildroot toolchain:
> $ git clone https://github.com/buildroot/buildroot.git
> $ cd buildroot
> $ make O=build_nommu qemu_riscv64_nommu_virt_defconfig
> 
> Test:
> $ git clone https://github.com/clementleger/unaligned_test.git
> $ cd unaligned_test
> $ make CFLAGS="-fPIC -Wl,-elf2flt=-r"
> CROSS_COMPILE=<buildroot>/build_nommu/host/bin/riscv64-buildroot-linux-uclibc-
> 
> Copy the resulting elf files (unaligned & unaligned_c) to buildroot rootfs and rebuild it.
> $ cp unaligned unaligned_c <buildroot>/build_nommu/target/root
> $ cd <buildroot>/build_nommu/
> $ make
> 
> Kernel:
> $ make O=build_nommu nommu_virt_defconfig
> $ make O=build_nommu loader
> 
> Either set the kernel initramfs or provide one on spike command line
> using the one built with buildroot
> 
> Then to run it on spike (QEMU always emulate misaligned accesses and
> won't generate any misaligned exception):
> 
> $ spike <kernel>/build_nommu/loader
> 
> ---
> 
> V2:
>  - Rebased on master
>  - Align macro end "\"
> 
> Link to v1: https://lore.kernel.org/linux-riscv/20231128165206.589240-1-cleger@rivosinc.com/
> 
> Notes: This patch is a complete rework of a previous one [1] and thus is
> not a V3.
> 
> [1] https://lore.kernel.org/linux-riscv/d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com/
> ---
>  arch/riscv/kernel/traps_misaligned.c | 106 +++++----------------------
>  1 file changed, 17 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 8ded225e8c5b..fb202dd18fe5 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -264,86 +264,14 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
>  #define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
>  #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
>  
> -#ifdef CONFIG_RISCV_M_MODE
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> -{
> -	u8 val;
> -
> -	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
> -	*r_val = val;
> -
> -	return 0;
> -}
> -
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> -{
> -	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
> -
> -	return 0;
> -}
> -
> -static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
> -{
> -	register ulong __mepc asm ("a2") = mepc;
> -	ulong val, rvc_mask = 3, tmp;
> -
> -	asm ("and %[tmp], %[addr], 2\n"
> -		"bnez %[tmp], 1f\n"
> -#if defined(CONFIG_64BIT)
> -		__stringify(LWU) " %[insn], (%[addr])\n"
> -#else
> -		__stringify(LW) " %[insn], (%[addr])\n"
> -#endif
> -		"and %[tmp], %[insn], %[rvc_mask]\n"
> -		"beq %[tmp], %[rvc_mask], 2f\n"
> -		"sll %[insn], %[insn], %[xlen_minus_16]\n"
> -		"srl %[insn], %[insn], %[xlen_minus_16]\n"
> -		"j 2f\n"
> -		"1:\n"
> -		"lhu %[insn], (%[addr])\n"
> -		"and %[tmp], %[insn], %[rvc_mask]\n"
> -		"bne %[tmp], %[rvc_mask], 2f\n"
> -		"lhu %[tmp], 2(%[addr])\n"
> -		"sll %[tmp], %[tmp], 16\n"
> -		"add %[insn], %[insn], %[tmp]\n"
> -		"2:"
> -	: [insn] "=&r" (val), [tmp] "=&r" (tmp)
> -	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
> -	  [xlen_minus_16] "i" (XLEN_MINUS_16));
> -
> -	*r_insn = val;
> -
> -	return 0;
> -}
> -#else
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> -{
> -	if (user_mode(regs)) {
> -		return __get_user(*r_val, (u8 __user *)addr);
> -	} else {
> -		*r_val = *addr;
> -		return 0;
> -	}
> -}
> -
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> -{
> -	if (user_mode(regs)) {
> -		return __put_user(val, (u8 __user *)addr);
> -	} else {
> -		*addr = val;
> -		return 0;
> -	}
> -}
> -
> -#define __read_insn(regs, insn, insn_addr)		\
> +#define __read_insn(regs, insn, insn_addr, type)	\
>  ({							\
>  	int __ret;					\
>  							\
>  	if (user_mode(regs)) {				\
> -		__ret = __get_user(insn, insn_addr);	\
> +		__ret = __get_user(insn, (type __user *) insn_addr); \
>  	} else {					\
> -		insn = *(__force u16 *)insn_addr;	\
> +		insn = *(type *)insn_addr;		\
>  		__ret = 0;				\
>  	}						\
>  							\
> @@ -356,9 +284,8 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>  
>  	if (epc & 0x2) {
>  		ulong tmp = 0;
> -		u16 __user *insn_addr = (u16 __user *)epc;
>  
> -		if (__read_insn(regs, insn, insn_addr))
> +		if (__read_insn(regs, insn, epc, u16))
>  			return -EFAULT;
>  		/* __get_user() uses regular "lw" which sign extend the loaded
>  		 * value make sure to clear higher order bits in case we "or" it
> @@ -369,16 +296,14 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>  			*r_insn = insn;
>  			return 0;
>  		}
> -		insn_addr++;
> -		if (__read_insn(regs, tmp, insn_addr))
> +		epc += sizeof(u16);
> +		if (__read_insn(regs, tmp, epc, u16))
>  			return -EFAULT;
>  		*r_insn = (tmp << 16) | insn;
>  
>  		return 0;
>  	} else {
> -		u32 __user *insn_addr = (u32 __user *)epc;
> -
> -		if (__read_insn(regs, insn, insn_addr))
> +		if (__read_insn(regs, insn, epc, u32))
>  			return -EFAULT;
>  		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
>  			*r_insn = insn;
> @@ -390,7 +315,6 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>  		return 0;
>  	}
>  }
> -#endif
>  
>  union reg_data {
>  	u8 data_bytes[8];
> @@ -409,7 +333,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>  	unsigned long epc = regs->epc;
>  	unsigned long insn;
>  	unsigned long addr = regs->badaddr;
> -	int i, fp = 0, shift = 0, len = 0;
> +	int fp = 0, shift = 0, len = 0;
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> @@ -490,9 +414,11 @@ int handle_misaligned_load(struct pt_regs *regs)
>  		return -EOPNOTSUPP;
>  
>  	val.data_u64 = 0;
> -	for (i = 0; i < len; i++) {
> -		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
> +	if (user_mode(regs)) {
> +		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
>  			return -1;
> +	} else {
> +		memcpy(&val, (u8 *)addr, len);
>  	}
>  
>  	if (!fp)
> @@ -513,7 +439,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	unsigned long epc = regs->epc;
>  	unsigned long insn;
>  	unsigned long addr = regs->badaddr;
> -	int i, len = 0, fp = 0;
> +	int len = 0, fp = 0;
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> @@ -586,9 +512,11 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	if (!IS_ENABLED(CONFIG_FPU) && fp)
>  		return -EOPNOTSUPP;
>  
> -	for (i = 0; i < len; i++) {
> -		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
> +	if (user_mode(regs)) {
> +		if (raw_copy_to_user((u8 __user *)addr, &val, len))
>  			return -1;
> +	} else {
> +		memcpy((u8 *)addr, &val, len);
>  	}
>  
>  	regs->epc = epc + INSN_LEN(insn);
> -- 
> 2.43.0
> 

Thank you for posting the testing instructions! I tested it and it
worked as expected.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


