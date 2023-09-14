Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A577A0C15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbjINR6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjINR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:58:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B21FF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:58:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c337aeefbdso11313395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694714324; x=1695319124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFsmyS+K09iiFSJvxqc49LzsJ6t7yJD96oHLDDlnADM=;
        b=x7kvdH2hsQPrJYkro3R2iENXeZrkDu8WkA3eU+3ZdN/sC0WOpErpIuiQs0YqePaf00
         hV1OUAYy0r8tb8GdG0dahlSfCmzZkErygZ2GSY1P0E/Ra3SVs41NwcWfHnx5rrBAb2EQ
         cHSMNQgsmL8ZCAVIn1Sfj8k0j7zKmCmwRFoePPVPUrQNtqq/g91Wv2K+8SnV6N3sO2ga
         K9YLGkGdagshFNVF4JGV1VmGFJA83OesBAD6VlwS/tOzTg+JV7ed42XmzuP+d+2SJ6UM
         hmIcTQYS7Ax70gqS0E+Xwo2GoTFxk5q/iUXGB0/xJ5hBpuYQ8drSM6Ep3sfQvvQgAtXp
         ORpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714324; x=1695319124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFsmyS+K09iiFSJvxqc49LzsJ6t7yJD96oHLDDlnADM=;
        b=G/KDxXFppgUMH4dtoMorQx5rpk+r2uozFhM26QjBq/LSMzcql5+JIS81e2y8ZdP53/
         Rq9yTD5CIyTvdCFXTogQawOt9l6ynFSVCLj4WbNx/iUZvJnWVmf1DEP2zJ4goF/euizo
         wTJmU3BDUhtXwX4Bu8pWM/G4O0cZaeyqPNCH8QKSftH8s5EcMzJhBg/k49/DdkvDfBrv
         55/py5W2l0t7F1g6y8eYsdhTXVHSRZNw+GJrXkvzZKUT+1ZmSWVVcDDIAmrRm2RdUwe6
         ezBYFrqHCC6HSc7jokGo22kRrL+MQs6KAniuTg6zVaWzIOdIxo6TWhtlXKA65Q2U7rW0
         pc7A==
X-Gm-Message-State: AOJu0YxFc+Wpfr9HKOEGp/kRgd87gWBUypF5+2GiW6jW7YNeouGsjiTh
        wvbiZ5OcYTj+EncMNpv7xJ6q6w==
X-Google-Smtp-Source: AGHT+IFLLcNJ4RkUCWudbnFvaVhj4LHDQoNdbqKUsqeh+Tv088pDBCurogl3v9yGI/QiTbD9DdPxAw==
X-Received: by 2002:a17:902:c10d:b0:1c3:7762:2adc with SMTP id 13-20020a170902c10d00b001c377622adcmr6172599pli.7.1694714324429;
        Thu, 14 Sep 2023 10:58:44 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001bf2dcfe352sm1871487plb.234.2023.09.14.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 10:58:43 -0700 (PDT)
Date:   Thu, 14 Sep 2023 13:58:40 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 2/5] riscv: Add checksum library
Message-ID: <ZQNJ0LQhZyJWlcSy@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
 <20230914-mural-deskbound-0e37d0767f6f@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-mural-deskbound-0e37d0767f6f@wendy>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:25:23PM +0100, Conor Dooley wrote:
> On Mon, Sep 11, 2023 at 03:57:12PM -0700, Charlie Jenkins wrote:
> > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > will load from the buffer in groups of 32 bits, and when compiled for
> > 64-bit will load in groups of 64 bits. Benchmarking by proxy compiling
> > csum_ipv6_magic (64-bit version) for an x86 chip as well as running
> > the riscv generated code in QEMU, discovered that summing in a
> > tree-like structure is about 4% faster than doing 64-bit reads.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/checksum.h |  11 ++
> >  arch/riscv/lib/Makefile           |   1 +
> >  arch/riscv/lib/csum.c             | 210 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 222 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > index 0d7fc8275a5e..a09a4053fb87 100644
> > --- a/arch/riscv/include/asm/checksum.h
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -16,6 +16,14 @@ typedef unsigned int csum_t;
> >  typedef unsigned long csum_t;
> >  #endif
> >  
> > +/* Default version is sufficient for 32 bit */
> > +#ifdef CONFIG_64BIT
> > +#define _HAVE_ARCH_IPV6_CSUM
> > +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +			const struct in6_addr *daddr,
> > +			__u32 len, __u8 proto, __wsum sum);
> > +#endif
> > +
> >  /*
> >   *	Fold a partial checksum without adding pseudo headers
> >   */
> > @@ -90,6 +98,9 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> >  
> >  #define ip_fast_csum ip_fast_csum
> >  
> > +extern unsigned int do_csum(const unsigned char *buff, int len);
> > +#define do_csum do_csum
> > +
> >  #include <asm-generic/checksum.h>
> >  
> >  #endif // __ASM_RISCV_CHECKSUM_H
> > diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> > index 26cb2502ecf8..2aa1a4ad361f 100644
> > --- a/arch/riscv/lib/Makefile
> > +++ b/arch/riscv/lib/Makefile
> > @@ -6,6 +6,7 @@ lib-y			+= memmove.o
> >  lib-y			+= strcmp.o
> >  lib-y			+= strlen.o
> >  lib-y			+= strncmp.o
> > +lib-y			+= csum.o
> >  lib-$(CONFIG_MMU)	+= uaccess.o
> >  lib-$(CONFIG_64BIT)	+= tishift.o
> >  lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
> > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > new file mode 100644
> > index 000000000000..47d98c51bab2
> > --- /dev/null
> > +++ b/arch/riscv/lib/csum.c
> > @@ -0,0 +1,210 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * IP checksum library
> > + *
> > + * Influenced by arch/arm64/lib/csum.c
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/compiler.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kernel.h>
> > +
> > +#include <net/checksum.h>
> > +
> > +/* Default version is sufficient for 32 bit */
> > +#ifndef CONFIG_32BIT
> > +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +			const struct in6_addr *daddr,
> > +			__u32 len, __u8 proto, __wsum csum)
> > +{
> > +	/*
> > +	 * Inform the compiler/processor that the operation we are performing is
> > +	 * "Commutative and Associative" by summing parts of the checksum in a
> > +	 * tree-like structure (Section 2(A) of "Computing the Internet
> > +	 * Checksum"). Furthermore, defer the overflow until the end of the
> > +	 * computation which is shown to be valid in Section 2(C)(1) of the
> > +	 * same handbook.
> > +	 */
> > +	unsigned long sum, sum1, sum2, sum3, sum4, ulen, uproto;
> > +
> > +	uproto = htonl(proto);
> > +	ulen = htonl(len);
> > +
> > +	sum   = saddr->s6_addr32[0];
> > +	sum  += saddr->s6_addr32[1];
> > +	sum1  = saddr->s6_addr32[2];
> > +	sum1 += saddr->s6_addr32[3];
> > +
> > +	sum2  = daddr->s6_addr32[0];
> > +	sum2 += daddr->s6_addr32[1];
> > +	sum3  = daddr->s6_addr32[2];
> > +	sum3 += daddr->s6_addr32[3];
> > +
> > +	sum4  = csum;
> > +	sum4 += ulen;
> > +	sum4 += uproto;
> > +
> > +	sum  += sum1;
> > +	sum2 += sum3;
> > +
> > +	sum += sum2;
> > +	sum += sum4;
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		csum_t fold_temp;
> > +
> > +		/*
> > +		 * Zbb is likely available when the kernel is compiled with Zbb
> > +		 * support, so nop when Zbb is available and jump when Zbb is
> > +		 * not available.
> > +		 */
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +				  :
> > +				  :
> > +				  :
> > +				  : no_zbb);
> > +		asm(".option push					\n\
> > +		.option arch,+zbb					\n\
> > +			rori	%[fold_temp], %[sum], 32		\n\
> > +			add	%[sum], %[fold_temp], %[sum]		\n\
> > +			srli	%[sum], %[sum], 32			\n\
> > +			not	%[fold_temp], %[sum]			\n\
> > +			roriw	%[sum], %[sum], 16			\n\
> > +			subw	%[sum], %[fold_temp], %[sum]		\n\
> > +		.option pop"
> > +		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
> > +		return (__force __sum16)(sum >> 16);
> > +	}
> > +no_zbb:
> > +	sum += (sum >> 32) | (sum << 32);
> > +	sum >>= 32;
> > +	return csum_fold((__force __wsum)sum);
> > +}
> > +EXPORT_SYMBOL(csum_ipv6_magic);
> > +#endif // !CONFIG_32BIT
> > +
> > +#ifdef CONFIG_32BIT
> > +#define OFFSET_MASK 3
> > +#elif CONFIG_64BIT
> > +#define OFFSET_MASK 7
> > +#endif
> > +
> > +/*
> > + * Perform a checksum on an arbitrary memory address.
> > + * Algorithm accounts for buff being misaligned.
> > + * If buff is not aligned, will over-read bytes but not use the bytes that it
> > + * shouldn't. The same thing will occur on the tail-end of the read.
> > + */
> > +unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
> > +{
> > +	unsigned int offset, shift;
> > +	csum_t csum, data;
> > +	const csum_t *ptr;
> > +
> > +	if (unlikely(len <= 0))
> > +		return 0;
> > +	/*
> > +	 * To align the address, grab the whole first byte in buff.
> > +	 * Since it is inside of a same byte, it will never cross pages or cache
> > +	 * lines.
> > +	 * Directly call KASAN with the alignment we will be using.
> > +	 */
> > +	offset = (csum_t)buff & OFFSET_MASK;
> > +	kasan_check_read(buff, len);
> > +	ptr = (const csum_t *)(buff - offset);
> > +	len = len + offset - sizeof(csum_t);
> > +
> > +	/*
> > +	 * Clear the most signifant bits that were over-read if buff was not
> > +	 * aligned.
> > +	 */
> > +	shift = offset * 8;
> > +	data = *ptr;
> > +#ifdef __LITTLE_ENDIAN
> > +	data = (data >> shift) << shift;
> > +#else
> > +	data = (data << shift) >> shift;
> > +#endif
> > +	/*
> > +	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
> > +	 * faster than doing 32-bit reads on architectures that support larger
> > +	 * reads.
> > +	 */
> > +	while (len > 0) {
> > +		csum += data;
> 
> arch/riscv/lib/csum.c:137:3: warning: variable 'csum' is uninitialized when used here [-Wuninitialized]
>                 csum += data;
>                 ^~~~
> arch/riscv/lib/csum.c:104:13: note: initialize the variable 'csum' to silence this warning
>         csum_t csum, data;
>                    ^
>                     = 0
> > +		csum += csum < data;
> > +		len -= sizeof(csum_t);
> > +		ptr += 1;
> > +		data = *ptr;
> > +	}
> > +
> > +	/*
> > +	 * Perform alignment (and over-read) bytes on the tail if any bytes
> > +	 * leftover.
> > +	 */
> > +	shift = len * -8;
> > +#ifdef __LITTLE_ENDIAN
> > +	data = (data << shift) >> shift;
> > +#else
> > +	data = (data >> shift) << shift;
> > +#endif
> > +	csum += data;
> > +	csum += csum < data;
> > +
> > +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBB))
> > +		goto no_zbb;
> 
> I think this is missing a change for IS_ENABLED(CONFIG_RISCV_ISA_ZBB)?
> arch/riscv/lib/csum.c:180:1: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
>                 .option arch,+zbb                               \n\
> ^
> <inline asm>:2:11: note: instantiated into assembly here
>                 .option arch,+zbb                               
>                         ^
> arch/riscv/lib/csum.c:181:1: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
>                         rori    %[fold_temp], %[csum], 32       \n\
> ^
> <inline asm>:3:4: note: instantiated into assembly here
>                         rori    a2, a0, 32      
>                         ^
> arch/riscv/lib/csum.c:184:1: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
>                         roriw   %[fold_temp], %[csum], 16       \n\
> ^
> <inline asm>:6:4: note: instantiated into assembly here
>                         roriw   a2, a0, 16      
>                         ^
> arch/riscv/lib/csum.c:188:1: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
>                         rev8    %[csum], %[csum]                \n\
> ^
> <inline asm>:10:4: note: instantiated into assembly here
>                         rev8    a0, a0          
>                         ^
> 2 warnings and 3 errors generated.
> 
> clang before 17 doesn't support `.option arch`, so the guard is required
> around any code using it. You've got the guard on the other `.option
> arch` user above, so that one seems to have escaped notice ;)
> 
> Going forward, it'd be good to test this stuff with non-latest clang to
> make sure you appropriately consider the !Zbb cases.
> 
Yes this was an oversight to drop the guard.
> 
> > +
> > +	unsigned int fold_temp;
> > +
> > +	if (IS_ENABLED(CONFIG_32BIT)) {
> > +		asm_volatile_goto(".option push			\n\
> > +		.option arch,+zbb				\n\
> > +			rori	%[fold_temp], %[csum], 16	\n\
> > +			andi	%[offset], %[offset], 1		\n\
> > +			add	%[csum], %[fold_temp], %[csum]	\n\
> > +			beq	%[offset], zero, %l[end]	\n\
> > +			rev8	%[csum], %[csum]		\n\
> > +			zext.h	%[csum], %[csum]		\n\
> > +		.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > +			: [offset] "r" (offset)
> > +			:
> > +			: end);
> > +
> > +		return csum;
> > +	} else {
> > +		asm_volatile_goto(".option push			\n\
> > +		.option arch,+zbb				\n\
> > +			rori	%[fold_temp], %[csum], 32	\n\
> > +			add	%[csum], %[fold_temp], %[csum]	\n\
> > +			srli	%[csum], %[csum], 32		\n\
> > +			roriw	%[fold_temp], %[csum], 16	\n\
> > +			addw	%[csum], %[fold_temp], %[csum]	\n\
> > +			andi	%[offset], %[offset], 1		\n\
> > +			beq	%[offset], zero, %l[end]	\n\
> > +			rev8	%[csum], %[csum]		\n\
> > +			srli	%[csum], %[csum], 32		\n\
> > +			zext.h	%[csum], %[csum]		\n\
> > +		.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > +			: [offset] "r" (offset)
> > +			:
> > +			: end);
> > +
> > +		return csum;
> > +	}
> > +end:
> > +		return csum >> 16;
> > +no_zbb:
> > +#ifndef CONFIG_32BIT
> 
> These can also be moved to IS_ENABLED() FYI, since there's no 32-bit
> stuff here that'd break the build for 64-bit. Ditto elsewhere where
> you've got similar stuff.
> 
> Cheers,
> Conor.
This is an ifndef, so 32-bit compilation would throw a warning about
shifting by 32 bits if IS_ENABLED was used instead.

- Charlie
> 
> > +		csum += (csum >> 32) | (csum << 32);
> > +		csum >>= 32;
> > +#endif
> > +	csum = (unsigned int)csum + (((unsigned int)csum >> 16) | ((unsigned int)csum << 16));
> > +	if (offset & 1)
> > +		return (unsigned short)swab32(csum);
> > +	return csum >> 16;
> > +}
> > 
> > -- 
> > 2.42.0
> > 


