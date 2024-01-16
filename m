Return-Path: <linux-kernel+bounces-27489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E015082F0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4451D1F24216
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A21BF3B;
	Tue, 16 Jan 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TkZYGHlA"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F371BC5D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd880ceaf2so59076511fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705417450; x=1706022250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZObLbH50jWGDNCNNEMPuR9WvYua1JEOsUGWqN7w/1c=;
        b=TkZYGHlAI9FR/bKw3/asNRcsXrhMxk0RWmjUIxCTIOy1HigH0lW1QDITatR+jtiv1Y
         ITpDoqsGDmeRgyf6Z166hUqIH3Nz/zcs8pGLhK33pXeeLVHUQ05MydNsFnwBeZ/jjVy7
         x81LK/Ppnies/9tcJBF8YJ8XHt0V7KrpVTspfybL5R/lhAPeMZY9ZVQ0P/B8pS0KHrYf
         gPVy8G8MC+pfg8VdDkqH63MS8MX1NC21LZDgReVeH/nSIAqYWtXu/Ca/7tGFFW+gbPDj
         Eudn47y6ehg8p9Scw7tiyC4pqsLhfIuMV1ETQ2Yx2dcZEF5Lb2ov1SdpmJW/ApPhhPF7
         iFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705417450; x=1706022250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZObLbH50jWGDNCNNEMPuR9WvYua1JEOsUGWqN7w/1c=;
        b=bwDRPWhVF8koChPMsdVuXP1ZyGr+YYtBOKibvUHg7oMMXyVo3TLlDMpBUVJaiXjHOt
         u/xJ3FMbfAiiyyWZw4MRs1qO4UdeW7mbUPqj1tZO5KuZmUUpJb3B2uOz7hx5JBHFs1Yc
         bZeoXuGjUClEDrNPmRyuMWWQ4ZVA/twOJ9AFhdqZIdHdwvzNCOdDzmO/AGA39xw6E5qf
         IWevMHs3UDCoBPuL4AOD+PkDDBWDnxL48B1e4d8QhSLq/aR1Is3SgJ7Fab3vNCUayGkP
         b/JJOuJihhEc+lNA8uPJyWpaaErBVty/Km9OuaUzTt2sKU4o3wo8ubRwwtccdqm2QpLm
         yi+g==
X-Gm-Message-State: AOJu0YyY8EwtD3HxWTgkO6N0WXIOMkaKiKKuNT+zYWmcMBZ3v6v7SoPB
	yQTDIy6QSZ7C9Ly8+EzlRhKN91mkDfGT6w==
X-Google-Smtp-Source: AGHT+IFze1yvXUIStG9IAEYe4ZfyGuJQ3Hn+kkqjQ4DOfInluQBD4+vrj7DhqXAwXsSlpR4SCc6kyw==
X-Received: by 2002:a2e:b454:0:b0:2cd:52a5:88ec with SMTP id o20-20020a2eb454000000b002cd52a588ecmr3463178ljm.9.1705417450385;
        Tue, 16 Jan 2024 07:04:10 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ew3-20020a056402538300b00558a1937dddsm6688768edb.63.2024.01.16.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:04:09 -0800 (PST)
Date: Tue, 16 Jan 2024 16:04:09 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	conor.dooley@microchip.com, heiko@sntech.de, haicheng.li@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Optimize crc32 with Zbc extension
Message-ID: <20240116-9f09b002afc2337ab5e41e3f@orel>
References: <20240105080830.3738117-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105080830.3738117-1-xiao.w.wang@intel.com>

On Fri, Jan 05, 2024 at 04:08:30PM +0800, Xiao Wang wrote:
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
> mechanism. To avoid the performance concern of unalignment access, we also
> use the fallback implementation to handle the head and tail bytes if any,
> the main body is accelerated by Zbc extension.
> 
> This patch is tested on QEMU VM with the kernel CRC32 selftest.

Ideally we'd also have the results of some benchmarks, or at least a
dynamic instruction count or something, but I don't suspect that the
table-lookup would "win" over Zbc. The bigger question is whether we
want three implementations, because I assume we want Zvbc, particularly
since [1] says

"""
Zvbc is listed as a development option for use in other algorithms,
and will become mandatory. Scalar Zbc is now listed as an expansion
option, i.e., it will probably not become mandatory.
"""

[1] https://github.com/riscv/riscv-profiles/blob/main/rva23-profile.adoc


A few nits below.

> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/Kconfig      |  23 +++++
>  arch/riscv/lib/Makefile |   1 +
>  arch/riscv/lib/crc32.c  | 216 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/crc32.h   |   3 +
>  4 files changed, 243 insertions(+)
>  create mode 100644 arch/riscv/lib/crc32.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 95a2a06acc6a..d8b4fb697df2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -549,6 +549,29 @@ config RISCV_ISA_ZBB
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
> index 26cb2502ecf8..183bf2097d57 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -9,5 +9,6 @@ lib-y			+= strncmp.o
>  lib-$(CONFIG_MMU)	+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o
>  lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
> +lib-$(CONFIG_RISCV_ISA_ZBC)	+= crc32.o
>  
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> diff --git a/arch/riscv/lib/crc32.c b/arch/riscv/lib/crc32.c
> new file mode 100644
> index 000000000000..1a24994df826
> --- /dev/null
> +++ b/arch/riscv/lib/crc32.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Accelerated CRC32 implementation with Zbc extension.
> + *
> + * Copyright (C) 2024 Intel Corporation
> + *
> + * Authors:
> + *     Xiao Wang <xiao.w.wang@intel.com>
> + */
> +
> +#include <asm/hwcap.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/byteorder.h>
> +
> +#include <linux/types.h>
> +#include <linux/crc32poly.h>
> +#include <linux/crc32.h>
> +#include <linux/byteorder/generic.h>
> +
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))

min() from linux/minmax.h?

> +
> +#if (BITS_PER_LONG == 64)

I think riscv prefers

 #if __riscv_xlen == 64

In any case, the () are unnecessary.

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
> +#elif (BITS_PER_LONG == 32)
> +# define STEP_ORDER 2
> +/* Each quotient should match the upper half of its analog in RV64 */
> +# define CRC32_POLY_QT_LE	0xfb808b20
> +# define CRC32C_POLY_QT_LE	0x6f5389f8
> +# define CRC32_POLY_QT_BE	0x04d101df
> +#else
> +# error "Unexpected BITS_PER_LONG"
> +#endif
> +
> +#define STEP (1 << STEP_ORDER)
> +#define OFFSET_MASK (STEP - 1)

Should tab out the values of these defines so they line up.

> +
> +/*
> + * Refer to https://www.corsix.org/content/barrett-reduction-polynomials for
> + * better understanding of how this math works.

Thanks for this pointer. I read it, but I didn't digest it enough to
understand it, which means my review isn't confirming the math is
correct.

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
> +typedef u32 (*fallback)(u32 crc, unsigned char const *p, size_t len);
> +
> +static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
> +#if (BITS_PER_LONG == 64)
> +					  size_t len, u32 poly, u64 poly_qt,
> +#else
> +					  size_t len, u32 poly, u32 poly_qt,
> +#endif

How about creating a new type for poly_qt, defined as u64 for xlen=64
and u32 for xlen=32 to avoid the #ifdef?

> +					  fallback crc_fb)
> +{
> +	size_t offset, head_len, tail_len;
> +	const unsigned long *p_ul;
> +	unsigned long s;
> +
> +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +				      RISCV_ISA_EXT_ZBC, 1)
> +			  : : : : legacy);
> +
> +	/* Handle the unalignment head. */
> +	offset = (unsigned long)p & OFFSET_MASK;
> +	if (offset) {
> +		head_len = MIN(STEP - offset, len);
> +		crc = crc_fb(crc, p, head_len);
> +		len -= head_len;
> +		p += head_len;
> +	}
> +
> +	tail_len = len & OFFSET_MASK;
> +	len = len >> STEP_ORDER;
> +	p_ul = (unsigned long *)p;
> +
> +	for (int i = 0; i < len; i++) {
> +#if (BITS_PER_LONG == 64)
> +		s = (unsigned long)crc ^ __cpu_to_le64(*p_ul++);
> +		/* We don't have a "clmulrh" insn, so use clmul + slli instead.
> +		 */

need opening /* comment wing

> +		asm volatile (".option push\n"
> +			      ".option arch,+zbc\n"
> +			      "clmul	%0, %1, %2\n"
> +			      "slli	%0, %0, 1\n"
> +			      "xor	%0, %0, %1\n"
> +			      "clmulr	%0, %0, %3\n"
> +			      "srli	%0, %0, 32\n"
> +			      ".option pop\n"
> +			      : "=&r" (crc)
> +			      : "r" (s),
> +				"r" (poly_qt),
> +				"r" ((u64)poly << 32)
> +			      :);
> +#else
> +		s = crc ^ __cpu_to_le32(*p_ul++);
> +		/* We don't have a "clmulrh" insn, so use clmul + slli instead.

also here

> +		 */
> +		asm volatile (".option push\n"
> +			      ".option arch,+zbc\n"
> +			      "clmul	%0, %1, %2\n"
> +			      "slli	%0, %0, 1\n"
> +			      "xor	%0, %0, %1\n"
> +			      "clmulr	%0, %0, %3\n"
> +			      ".option pop\n"
> +			      : "=&r" (crc)
> +			      : "r" (s),
> +				"r" (poly_qt),
> +				"r" (poly)
> +			      :);
> +#endif

Instead of the #ifdef here, we could provide function wrappers for the asm
which would be defined above in the first #ifdef ladder.

> +	}
> +
> +	/* Handle the tail bytes. */
> +	if (tail_len)
> +		crc = crc_fb(crc, (unsigned char const *)p_ul, tail_len);
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
> +u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
> +{
> +	size_t offset, head_len, tail_len;
> +	const unsigned long *p_ul;
> +	unsigned long s;
> +
> +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +				      RISCV_ISA_EXT_ZBC, 1)
> +			  : : : : legacy);
> +
> +	/* Handle the unalignment head. */
> +	offset = (unsigned long)p & OFFSET_MASK;
> +	if (offset) {
> +		head_len = MIN(STEP - offset, len);
> +		crc = crc32_be_base(crc, p, head_len);
> +		len -= head_len;
> +		p += head_len;
> +	}
> +
> +	tail_len = len & OFFSET_MASK;
> +	len = len >> STEP_ORDER;
> +	p_ul = (unsigned long *)p;
> +
> +	for (int i = 0; i < len; i++) {
> +#if (BITS_PER_LONG == 64)
> +		s = (unsigned long)crc << 32;
> +		s ^= __cpu_to_be64(*p_ul++);
> +#else
> +		s = crc ^ __cpu_to_be32(*p_ul++);
> +#endif

Could write the above without #ifdef with

 if (IS_ENABLED(CONFIG_64BIT)) {
    ...
 } else {
    ...
 }

> +		asm volatile (".option push\n"
> +			      ".option arch,+zbc\n"
> +			      "clmulh	%0, %1, %2\n"
> +			      "xor	%0, %0, %1\n"
> +			      "clmul	%0, %0, %3\n"
> +			      ".option pop\n"
> +			      : "=&r" (crc)
> +			      : "r" (s),
> +				"r" (CRC32_POLY_QT_BE),
> +				"r" (CRC32_POLY_BE)
> +			      :);
> +	}
> +
> +	/* Handle the tail bytes. */
> +	if (tail_len)
> +		crc = crc32_be_base(crc, (unsigned char const *)p_ul, tail_len);
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

Thanks,
drew

