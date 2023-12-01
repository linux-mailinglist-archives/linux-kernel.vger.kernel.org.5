Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9E8003D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377632AbjLAG0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjLAG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:26:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F0173F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:26:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d05199f34dso1815135ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701411972; x=1702016772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w52QZSruv1anio9btke3NBc3IgsdiLnww0k+vFI0c5I=;
        b=KeFJIpxXeFjOsvHSet9/lXiU4UF9ZK5FQJB0mPhR4lcajcKkZsw0WdiwzNfs9B2r35
         PE4ffdBxd3w73Pm5Fmu8wd/ypaw2u8zXxl8nvt85B563aKmC+pQMvun4zgiXu4cjJws2
         9AVH1M5KpUdKhq3wRadZGtlAf22n1iyspX5EkEwiivsV5ujAkuNTLUdTVJ7ljqVGJqjU
         xa4598fCwYzabPgBbnXBvuAN714/Lh95HKrSZR4uL6Usq1Rh+45lN6aK9fixalS+b41F
         +/v/IpmR99YqjvJ27ZDZAGMJm7IBeN4mWu+Fd6d79PatC1OYdxP9V1nlH8ACwy5L17JM
         ieSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701411972; x=1702016772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w52QZSruv1anio9btke3NBc3IgsdiLnww0k+vFI0c5I=;
        b=Dn3lIodL9ySGcuniGRVz8AfDNt4nqEvqSF5R3CxIz2FEPlx6vBInqlVcuKqZwgvyx6
         2wfk5VqSSXyj6bNH9EzkgaUjIwZSX8y/fYVqziRZIEuuDyAjBGCQsLkqegwUWBXLkxGJ
         xRt+6tcUJld6eDuAQ/rVFQ3QSdjWSLjpNoKlQLFraMJPJrUju1bMRa9CD933EJt6dhJe
         PM9sWVLVtNb9m/Zs2i+tE12Q+lPT+X4rJbAZXwkBTrZXOanFLtlN0T0FyjmApLbz0hX9
         dulCKfdaF4hvzaKuOKVWTHMo3O/WPWuY1wTiXg1C/A9KRMF7M7UchpwLVRWr1eOKvwgX
         A1rg==
X-Gm-Message-State: AOJu0Yw7G0kPEriyyH9f7R1NBlz0iLTpRz8M/PE+tUabqhaXa7++IebP
        QVpY0pgzMphth/UgIImFmvTJWVs4QnzBEfJ2gD8qLg==
X-Google-Smtp-Source: AGHT+IGcVvkXgYNL0bZwgQdzmwA5Q8xpnG63OxSZgijKo1J0YJ/VJq0AR+l3fm81tC0qWzJ8LdaoSA==
X-Received: by 2002:a17:90b:38cf:b0:286:457b:1970 with SMTP id nn15-20020a17090b38cf00b00286457b1970mr3533030pjb.31.1701411972456;
        Thu, 30 Nov 2023 22:26:12 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:9075:c975:12d3:f5fb])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090ad80b00b0028649b84907sm1520303pjv.16.2023.11.30.22.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:26:11 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:26:08 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, haicheng.li@intel.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Optimize hweight API with Zbb extension
Message-ID: <ZWl8gA1hptdjorgE@ghost>
References: <20231112095244.4015351-1-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112095244.4015351-1-xiao.w.wang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 05:52:44PM +0800, Xiao Wang wrote:
> The Hamming Weight of a number is the total number of bits set in it, so
> the cpop/cpopw instruction from Zbb extension can be used to accelerate
> hweight() API.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/arch_hweight.h | 78 +++++++++++++++++++++++++++
>  arch/riscv/include/asm/bitops.h       |  4 +-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/arch_hweight.h
> 
> diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
> new file mode 100644
> index 000000000000..c20236a0725b
> --- /dev/null
> +++ b/arch/riscv/include/asm/arch_hweight.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Based on arch/x86/include/asm/arch_hweight.h
> + */
> +
> +#ifndef _ASM_RISCV_HWEIGHT_H
> +#define _ASM_RISCV_HWEIGHT_H
> +
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
> +
> +#if (BITS_PER_LONG == 64)
> +#define CPOPW	"cpopw "
> +#elif (BITS_PER_LONG == 32)
> +#define CPOPW	"cpop "
> +#else
> +#error "Unexpected BITS_PER_LONG"
> +#endif
> +
> +static __always_inline unsigned int __arch_hweight32(unsigned int w)
> +{
> +#ifdef CONFIG_RISCV_ISA_ZBB
> +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +				      RISCV_ISA_EXT_ZBB, 1)
> +			  : : : : legacy);
> +
> +	asm (".option push\n"
> +	     ".option arch,+zbb\n"
> +	     CPOPW "%0, %0\n"
> +	     ".option pop\n"
> +	     : "+r" (w) : :);
> +
> +	return w;
> +
> +legacy:
> +#endif
> +	return __sw_hweight32(w);
> +}
> +
> +static inline unsigned int __arch_hweight16(unsigned int w)
> +{
> +	return __arch_hweight32(w & 0xffff);
> +}
> +
> +static inline unsigned int __arch_hweight8(unsigned int w)
> +{
> +	return __arch_hweight32(w & 0xff);
> +}
> +
> +#if BITS_PER_LONG == 64
> +static __always_inline unsigned long __arch_hweight64(__u64 w)
> +{
> +# ifdef CONFIG_RISCV_ISA_ZBB
> +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +				      RISCV_ISA_EXT_ZBB, 1)
> +			  : : : : legacy);
> +
> +	asm (".option push\n"
> +	     ".option arch,+zbb\n"
> +	     "cpop %0, %0\n"
> +	     ".option pop\n"
> +	     : "+r" (w) : :);
> +
> +	return w;
> +
> +legacy:
> +# endif
> +	return __sw_hweight64(w);
> +}
> +#else /* BITS_PER_LONG == 64 */
> +static inline unsigned long __arch_hweight64(__u64 w)
> +{
> +	return  __arch_hweight32((u32)w) +
> +		__arch_hweight32((u32)(w >> 32));
> +}
> +#endif /* !(BITS_PER_LONG == 64) */
> +
> +#endif /* _ASM_RISCV_HWEIGHT_H */
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index b212c2708cda..f7c167646460 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -271,7 +271,9 @@ static __always_inline int variable_fls(unsigned int x)
>  #include <asm-generic/bitops/fls64.h>
>  #include <asm-generic/bitops/sched.h>
>  
> -#include <asm-generic/bitops/hweight.h>
> +#include <asm/arch_hweight.h>
> +
> +#include <asm-generic/bitops/const_hweight.h>
>  
>  #if (BITS_PER_LONG == 64)
>  #define __AMO(op)	"amo" #op ".d"
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

