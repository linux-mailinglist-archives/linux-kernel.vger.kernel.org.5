Return-Path: <linux-kernel+bounces-102611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A383C87B48B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C745C1C21975
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8B5EE7E;
	Wed, 13 Mar 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ddLi0Czn"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFAB5EE69
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370027; cv=none; b=m5fE1CyHbA7t9+LQVwR6+vldzcG+rX3B5hdNVp9cjk/GunqfQWSNP7DoJHa5hapt/npu3oHWxtxYwM+GbGqSiScgpJjC9/13SmDBbLi3yKNIe79ZHeW4By35x+t/as4xxnowg0TrMAMheVNZziVrREkwgKrqQTRE9quBrqewX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370027; c=relaxed/simple;
	bh=ItEkYAaLsEJUvMmVyOTJrrbpWXNKn01qFYSTlebULiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwt4GNjOz3zxKArdLryvL6OOmBUgfgVVzYYxC9n3WemPY7zFA6lCDW3X+X2cvuLYYxuUlTDHEvGTEKQFuYtpWwlTzxUK+htMEzDfOnx3n1JcxuYAlHI1lj1eEYE9htX98SqiRwCpz2koo6fwUUO3npnoRdeHO2lgHkgIydPE/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ddLi0Czn; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a1b6800ba8so164717eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710370024; x=1710974824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBuPQdMcUilIYWe3D1Oed5mjHWDS9ocASBUxxLJFVm8=;
        b=ddLi0CznDjyhQPCgSFMHeAsHByzwJtfLMrM5NCrxld5H5KTqSDn80QMwm6nANijVgF
         pnOkJ+Y5/WiUWymT6hNOXDwAF5slUZWyv/OB1nC32jsegiLu7tziVzONVw5ijxbaxi62
         Pf6snKK/sDMIagH3uIznwh/i8WJ4BTrro6LUPACwGj8Lm/S6s4yuOV1czczEYjCCIWK6
         jkTnoQLZ/52+4ArPVBMUVuW1KPsyWrx/FOMOovs5Qlqojz++e7D1I3VQnSChSx6yjMuF
         V/agfZ65w/XF9S8f1dxOUm+zxVFeqgTfOp/TyVckOdGgiXuduS29F7nm5R6f7BZNjDvG
         S4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370024; x=1710974824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBuPQdMcUilIYWe3D1Oed5mjHWDS9ocASBUxxLJFVm8=;
        b=EtU+FtpAyWIR9xn8tOqfyLORDAMXwqn0kHokoCQlw/vwU7wKVVV1U8FO55hsQKUkak
         QDufb8aRgqqHzfi1+3BzYQDPwDKA5XPZy+X9Xa2d2dOL6MUlFkKm4hUbLRHPMELX3G5g
         60OfIVXx4EcSp598Fzr3yFrcAfLoSxMD0MiuiAcTHCygA7Melhi0cCtxz2QfSkNj8Twe
         i2KkeD1EfaJYXm2X/lhzM6YPWAEm6GSN6pWuq9ZpRd4oFH4rhIJynmpr90yObjbW4hEJ
         XSrF1ppz9xFHF/S7POdpG1qGPZG6/lHNKPh2LH9CI3LpriZWeByoYB6kDoJRkUmJ2MU3
         mVUg==
X-Forwarded-Encrypted: i=1; AJvYcCUuY5Bxi5Mdb0pYXGeDTwxCSZZreavmHe6Hu+ygaVMf5UO4Suxf/UCuc6wdwRTl0lliaxbqrssKCqS/Ii/4JDL/A5KwgLws7hPKK/WL
X-Gm-Message-State: AOJu0YzE7U0svDQkLt2twCSs+TsufZpXFX83uPLrPt7Cwtrl2HdUJgcB
	iKTUXw6SbVzFxSgMeDizKnuTFNkYzCdotkzyBoahxE08jd5Wr9BD5Hlzu/08TIM=
X-Google-Smtp-Source: AGHT+IEOaaTBUBd1p64Jrq94oLJa/ChBe55PfXcKKAPOo80eHydbeatqeCSG9lpiK9lIk5pVSvvavg==
X-Received: by 2002:a05:6359:4117:b0:17b:ee29:40c with SMTP id kh23-20020a056359411700b0017bee29040cmr364149rwc.19.1710370023641;
        Wed, 13 Mar 2024 15:47:03 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:c3a2:fcab:1ebb:b50c])
        by smtp.gmail.com with ESMTPSA id f4-20020a635104000000b005dc507e8d13sm144949pgb.91.2024.03.13.15.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:47:02 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:47:00 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	heiko@sntech.de, david.laight@aculab.com, haicheng.li@intel.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Optimize crc32 with Zbc extension
Message-ID: <ZfIs5ND0S08N2zLd@ghost>
References: <20240313032139.3763427-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313032139.3763427-1-xiao.w.wang@intel.com>

On Wed, Mar 13, 2024 at 11:21:39AM +0800, Xiao Wang wrote:
> As suggested by the B-ext spec, the Zbc (carry-less multiplication)
> instructions can be used to accelerate CRC calculations. Currently, the
> crc32 is the most widely used crc function inside kernel, so this patch
> focuses on the optimization of just the crc32 APIs.
> 
> Compared with the current table-lookup based optimization, Zbc based
> optimization can also achieve large stride during CRC calculation loop,
> meantime, it avoids the memory access latency of the table-lookup based
> implementation and it reduces memory footprint.
> 
> If Zbc feature is not supported in a runtime environment, then the
> table-lookup based implementation would serve as fallback via alternative
> mechanism.
> 
> By inspecting the vmlinux built by gcc v12.2.0 with default optimization
> level (-O2), we can see below instruction count change for each 8-byte
> stride in the CRC32 loop:
> 
> rv64: crc32_be (54->31), crc32_le (54->13), __crc32c_le (54->13)
> rv32: crc32_be (50->32), crc32_le (50->16), __crc32c_le (50->16)

Even though this loop is optimized, there are a lot of other
instructions being executed else where for these tests. When running the
test-case in QEMU with ZBC enabled, I get these results:

[    0.353444] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    0.353470] crc32: self tests passed, processed 225944 bytes in 2044700 nsec
[    0.354098] crc32c: CRC_LE_BITS = 64
[    0.354114] crc32c: self tests passed, processed 112972 bytes in 289000 nsec
[    0.387204] crc32_combine: 8373 self tests passed
[    0.419881] crc32c_combine: 8373 self tests passed

Then when running with ZBC disabled I get:

[    0.351331] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    0.351359] crc32: self tests passed, processed 225944 bytes in 567500 nsec
[    0.352071] crc32c: CRC_LE_BITS = 64
[    0.352090] crc32c: self tests passed, processed 112972 bytes in 289900 nsec
[    0.385395] crc32_combine: 8373 self tests passed
[    0.418180] crc32c_combine: 8373 self tests passed

This is QEMU so it's not a perfect representation of hardware, but being
4 times slower with ZBC seems suspicious. I ran these tests numerous
times and got similar results. Do you know why these tests would perform
4 times better without ZBC?

> 
> The compile target CPU is little endian, extra effort is needed for byte
> swapping for the crc32_be API, thus, the instruction count change is not
> as significant as that in the *_le cases.
> 
> This patch is tested on QEMU VM with the kernel CRC32 selftest for both
> rv64 and rv32.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
> v3:
> - Use Zbc to handle also the data head and tail bytes, instead of calling
>   fallback function.
> - Misc changes due to the new design.
> 
> v2:
> - Fix sparse warnings about type casting. (lkp)
> - Add info about instruction count change in commit log. (Andrew)
> - Use the min() helper from linux/minmax.h. (Andrew)
> - Use "#if __riscv_xlen == 64" macro check to differentiate rv64 and rv32. (Andrew)
> - Line up several macro values by tab. (Andrew)
> - Make poly_qt as "unsigned long" to unify the code for rv64 and rv32. (David)
> - Fix the style of comment wing. (Andrew)
> - Add function wrappers for the asm code for the *_le cases. (Andrew)
> ---
>  arch/riscv/Kconfig      |  23 ++++
>  arch/riscv/lib/Makefile |   1 +
>  arch/riscv/lib/crc32.c  | 294 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/crc32.h   |   3 +
>  4 files changed, 321 insertions(+)
>  create mode 100644 arch/riscv/lib/crc32.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bfcfec67ed5..68e1248bbee4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -610,6 +610,29 @@ config RISCV_ISA_ZBB
>  
>  	   If you don't know what to do here, say Y.
>  
> +config TOOLCHAIN_HAS_ZBC
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbc)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbc)
> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZBC
> +	bool "Zbc extension support for carry-less multiplication instructions"
> +	depends on TOOLCHAIN_HAS_ZBC
> +	depends on MMU
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the Zbc
> +	   extension (carry-less multiplication) and enable its usage.
> +
> +	   The Zbc extension could accelerate CRC (cyclic redundancy check)
> +	   calculations.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config RISCV_ISA_ZICBOM
>  	bool "Zicbom extension support for non-coherent DMA operation"
>  	depends on MMU
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index bd6e6c1b0497..2b369f51b0a5 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -13,6 +13,7 @@ endif
>  lib-$(CONFIG_MMU)	+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o
>  lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
> +lib-$(CONFIG_RISCV_ISA_ZBC)	+= crc32.o
>  
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
> diff --git a/arch/riscv/lib/crc32.c b/arch/riscv/lib/crc32.c
> new file mode 100644
> index 000000000000..7f28c4a85a45
> --- /dev/null
> +++ b/arch/riscv/lib/crc32.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Accelerated CRC32 implementation with Zbc extension.
> + *
> + * Copyright (C) 2024 Intel Corporation
> + */
> +
> +#include <asm/hwcap.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/byteorder.h>
> +
> +#include <linux/types.h>
> +#include <linux/minmax.h>
> +#include <linux/crc32poly.h>
> +#include <linux/crc32.h>
> +#include <linux/byteorder/generic.h>
> +
> +/*
> + * Refer to https://www.corsix.org/content/barrett-reduction-polynomials for
> + * better understanding of how this math works.
> + *
> + * let "+" denotes polynomial add (XOR)
> + * let "-" denotes polynomial sub (XOR)
> + * let "*" denotes polynomial multiplication
> + * let "/" denotes polynomial floor division
> + * let "S" denotes source data, XLEN bit wide
> + * let "P" denotes CRC32 polynomial
> + * let "T" denotes 2^(XLEN+32)
> + * let "QT" denotes quotient of T/P, with the bit for 2^XLEN being implicit
> + *
> + * crc32(S, P)
> + * => S * (2^32) - S * (2^32) / P * P
> + * => lowest 32 bits of: S * (2^32) / P * P
> + * => lowest 32 bits of: S * (2^32) * (T / P) / T * P
> + * => lowest 32 bits of: S * (2^32) * quotient / T * P
> + * => lowest 32 bits of: S * quotient / 2^XLEN * P
> + * => lowest 32 bits of: (clmul_high_part(S, QT) + S) * P
> + * => clmul_low_part(clmul_high_part(S, QT) + S, P)
> + *
> + * In terms of below implementations, the BE case is more intuitive, since the
> + * higher order bit sits at more significant position.
> + */
> +
> +#if __riscv_xlen == 64
> +/* Slide by XLEN bits per iteration */
> +# define STEP_ORDER 3
> +
> +/* Each below polynomial quotient has an implicit bit for 2^XLEN */
> +
> +/* Polynomial quotient of (2^(XLEN+32))/CRC32_POLY, in LE format */
> +# define CRC32_POLY_QT_LE	0x5a72d812fb808b20
> +
> +/* Polynomial quotient of (2^(XLEN+32))/CRC32C_POLY, in LE format */
> +# define CRC32C_POLY_QT_LE	0xa434f61c6f5389f8
> +
> +/* Polynomial quotient of (2^(XLEN+32))/CRC32_POLY, in BE format, it should be
> + * the same as the bit-reversed version of CRC32_POLY_QT_LE
> + */
> +# define CRC32_POLY_QT_BE	0x04d101df481b4e5a
> +
> +static inline u64 crc32_le_prep(u32 crc, unsigned long const *ptr)
> +{
> +	return (u64)crc ^ (__force u64)__cpu_to_le64(*ptr);
> +}
> +
> +static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
> +{
> +	u32 crc;
> +
> +	/* We don't have a "clmulrh" insn, so use clmul + slli instead. */
> +	asm volatile (".option push\n"
> +		      ".option arch,+zbc\n"
> +		      "clmul	%0, %1, %2\n"
> +		      "slli	%0, %0, 1\n"
> +		      "xor	%0, %0, %1\n"
> +		      "clmulr	%0, %0, %3\n"
> +		      "srli	%0, %0, 32\n"
> +		      ".option pop\n"
> +		      : "=&r" (crc)
> +		      : "r" (s),
> +			"r" (poly_qt),
> +			"r" ((u64)poly << 32)
> +		      :);
> +	return crc;
> +}
> +
> +static inline u64 crc32_be_prep(u32 crc, unsigned long const *ptr)
> +{
> +	return ((u64)crc << 32) ^ (__force u64)__cpu_to_be64(*ptr);
> +}
> +
> +#elif __riscv_xlen == 32
> +# define STEP_ORDER 2
> +/* Each quotient should match the upper half of its analog in RV64 */
> +# define CRC32_POLY_QT_LE	0xfb808b20
> +# define CRC32C_POLY_QT_LE	0x6f5389f8
> +# define CRC32_POLY_QT_BE	0x04d101df
> +
> +static inline u32 crc32_le_prep(u32 crc, unsigned long const *ptr)
> +{
> +	return crc ^ (__force u32)__cpu_to_le32(*ptr);
> +}
> +
> +static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
> +{
> +	u32 crc;
> +
> +	/* We don't have a "clmulrh" insn, so use clmul + slli instead. */
> +	asm volatile (".option push\n"
> +		      ".option arch,+zbc\n"
> +		      "clmul	%0, %1, %2\n"
> +		      "slli	%0, %0, 1\n"
> +		      "xor	%0, %0, %1\n"
> +		      "clmulr	%0, %0, %3\n"
> +		      ".option pop\n"
> +		      : "=&r" (crc)
> +		      : "r" (s),
> +			"r" (poly_qt),
> +			"r" (poly)
> +		      :);
> +	return crc;
> +}
> +
> +static inline u32 crc32_be_prep(u32 crc, unsigned long const *ptr)
> +{
> +	return crc ^ (__force u32)__cpu_to_be32(*ptr);
> +}
> +
> +#else
> +# error "Unexpected __riscv_xlen"
> +#endif
> +
> +static inline u32 crc32_be_zbc(unsigned long s)
> +{
> +	u32 crc;
> +
> +	asm volatile (".option push\n"
> +		      ".option arch,+zbc\n"
> +		      "clmulh	%0, %1, %2\n"
> +		      "xor	%0, %0, %1\n"
> +		      "clmul	%0, %0, %3\n"
> +		      ".option pop\n"
> +		      : "=&r" (crc)
> +		      : "r" (s),
> +			"r" (CRC32_POLY_QT_BE),
> +			"r" (CRC32_POLY_BE)
> +		      :);
> +	return crc;
> +}
> +
> +#define STEP		(1 << STEP_ORDER)
> +#define OFFSET_MASK	(STEP - 1)
> +
> +typedef u32 (*fallback)(u32 crc, unsigned char const *p, size_t len);
> +
> +static inline u32 crc32_le_unaligned(u32 crc, unsigned char const *p,
> +				     size_t len, u32 poly,
> +				     unsigned long poly_qt)
> +{
> +	size_t bits = len * 8;
> +	unsigned long s = 0;
> +	u32 crc_low = 0;
> +
> +	for (int i = 0; i < len; i++)
> +		s = ((unsigned long)*p++ << (__riscv_xlen - 8)) | (s >> 8);
> +
> +	s ^= (unsigned long)crc << (__riscv_xlen - bits);
> +	if (__riscv_xlen == 32 || len < sizeof(u32))
> +		crc_low = crc >> bits;
> +
> +	crc = crc32_le_zbc(s, poly, poly_qt);
> +	crc ^= crc_low;
> +
> +	return crc;
> +}
> +
> +static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
> +					  size_t len, u32 poly,
> +					  unsigned long poly_qt,
> +					  fallback crc_fb)
> +{
> +	size_t offset, head_len, tail_len;
> +	unsigned long const *p_ul;
> +	unsigned long s;
> +
> +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,

This needs to be changed to be asm goto:

4356e9f841f7f ("work around gcc bugs with 'asm goto' with outputs")

> +				      RISCV_ISA_EXT_ZBC, 1)
> +			  : : : : legacy);
> +
> +	/* Handle the unaligned head. */
> +	offset = (unsigned long)p & OFFSET_MASK;
> +	if (offset && len) {

If len is 0 nothing in the function seems like it will modify crc. Is there
a reason to not break out immediately if len is 0?

> +		head_len = min(STEP - offset, len);
> +		crc = crc32_le_unaligned(crc, p, head_len, poly, poly_qt);
> +		p += head_len;
> +		len -= head_len;
> +	}
> +
> +	tail_len = len & OFFSET_MASK;
> +	len = len >> STEP_ORDER;
> +	p_ul = (unsigned long const *)p;
> +
> +	for (int i = 0; i < len; i++) {
> +		s = crc32_le_prep(crc, p_ul);
> +		crc = crc32_le_zbc(s, poly, poly_qt);
> +		p_ul++;
> +	}
> +
> +	/* Handle the tail bytes. */
> +	p = (unsigned char const *)p_ul;
> +	if (tail_len)
> +		crc = crc32_le_unaligned(crc, p, tail_len, poly, poly_qt);
> +
> +	return crc;
> +
> +legacy:
> +	return crc_fb(crc, p, len);
> +}
> +
> +u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
> +{
> +	return crc32_le_generic(crc, p, len, CRC32_POLY_LE, CRC32_POLY_QT_LE,
> +				crc32_le_base);
> +}
> +
> +u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
> +{
> +	return crc32_le_generic(crc, p, len, CRC32C_POLY_LE,
> +				CRC32C_POLY_QT_LE, __crc32c_le_base);
> +}
> +
> +static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
> +				     size_t len)
> +{
> +	size_t bits = len * 8;
> +	unsigned long s = 0;
> +	u32 crc_low = 0;
> +
> +	s = 0;
> +	for (int i = 0; i < len; i++)
> +		s = *p++ | (s << 8);
> +
> +	if (__riscv_xlen == 32 || len < sizeof(u32)) {
> +		s ^= crc >> (32 - bits);
> +		crc_low = crc << bits;
> +	} else {
> +		s ^= (unsigned long)crc << (bits - 32);
> +	}
> +
> +	crc = crc32_be_zbc(s);
> +	crc ^= crc_low;
> +
> +	return crc;
> +}
> +
> +u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
> +{
> +	size_t offset, head_len, tail_len;
> +	unsigned long const *p_ul;
> +	unsigned long s;
> +
> +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,

Same here

> +				      RISCV_ISA_EXT_ZBC, 1)
> +			  : : : : legacy);
> +
> +	/* Handle the unaligned head. */
> +	offset = (unsigned long)p & OFFSET_MASK;
> +	if (offset && len) {
> +		head_len = min(STEP - offset, len);
> +		crc = crc32_be_unaligned(crc, p, head_len);
> +		p += head_len;
> +		len -= head_len;
> +	}
> +
> +	tail_len = len & OFFSET_MASK;
> +	len = len >> STEP_ORDER;
> +	p_ul = (unsigned long const *)p;
> +
> +	for (int i = 0; i < len; i++) {
> +		s = crc32_be_prep(crc, p_ul);
> +		crc = crc32_be_zbc(s);
> +		p_ul++;
> +	}
> +
> +	/* Handle the tail bytes. */
> +	p = (unsigned char const *)p_ul;
> +	if (tail_len)
> +		crc = crc32_be_unaligned(crc, p, tail_len);
> +
> +	return crc;
> +
> +legacy:
> +	return crc32_be_base(crc, p, len);
> +}
> diff --git a/include/linux/crc32.h b/include/linux/crc32.h
> index 9e8a032c1788..87f788c0d607 100644
> --- a/include/linux/crc32.h
> +++ b/include/linux/crc32.h
> @@ -9,7 +9,9 @@
>  #include <linux/bitrev.h>
>  
>  u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len);
> +u32 __pure crc32_le_base(u32 crc, unsigned char const *p, size_t len);
>  u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len);
> +u32 __pure crc32_be_base(u32 crc, unsigned char const *p, size_t len);
>  
>  /**
>   * crc32_le_combine - Combine two crc32 check values into one. For two
> @@ -37,6 +39,7 @@ static inline u32 crc32_le_combine(u32 crc1, u32 crc2, size_t len2)
>  }
>  
>  u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len);
> +u32 __pure __crc32c_le_base(u32 crc, unsigned char const *p, size_t len);
>  
>  /**
>   * __crc32c_le_combine - Combine two crc32c check values into one. For two
> -- 
> 2.25.1
> 

