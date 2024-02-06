Return-Path: <linux-kernel+bounces-54166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD984ABC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A494A1F22A73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FAC1391;
	Tue,  6 Feb 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TiiwNiK1"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935E1392
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183968; cv=none; b=Kb5ldO/ZWXZxhy3N4XOWymiKpt5bvFVUuSphmTmc8MMjnboQ/vqoFmJVF5KoaAvn2Utm8yuaiynpjbj55A72vSkUUtFUPtcQJj2LQ0ZYWW2OJ0vwYUQGs4n5fJcrMI4DVHyvbX2bWCpa6PKt9Pn9ijXQx8j00V+IJeQ8BqDSrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183968; c=relaxed/simple;
	bh=M6Q4ekOcgLRv/320z3+Pe+YSGwV3y1xLROkJoNnW/Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug0oT70mGqvL05pgb+697JrEaa90ZdhOa81uOIRLI+OelehfGSa1uWBPgIC5l59crAsLcI32hCnvQPbAt1BG124vuGWOhhtnax5TP6evg5+05sH4JbIJl3jEz0UGSexyh4EvgR4SWcKfoFYQ6esGbWwubFqNjYcHQNysH9Rf7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TiiwNiK1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-296717ccc2aso71189a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 17:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707183965; x=1707788765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sDcb8i0bIvKHIHQ3dC9FxopkFric8IR4ltWwgV9c7o=;
        b=TiiwNiK1HanK9poauralbUO6LHYYCB3QAgj2nvRFciHfiuzAB3TMuxiBCnsye4zDR2
         dEPvtxCNpk1RguvF4PrBvwvdCrubooNCvHg+dkoeXWiT97E4d85QloOPPcWNJBAZq5u9
         ZPS6KksB/huXNhv0zMsE/6oix05GSzbFp2B98i9o0WLOK07KTMAW/PM3WZbc+lBOeotu
         s+he/frZB1fh1B5YzMTGHyeDn/03BsMdnm7kDSVwW0DAGaJ0jZzoNvmUSx5VyuHZmXhC
         o9Ps28AEHBbFPinlBDSXPT/9nNnmFsADjo61TceaCdXoXsoZVjp9/9TIBQroZtVn8frF
         Pw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183965; x=1707788765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sDcb8i0bIvKHIHQ3dC9FxopkFric8IR4ltWwgV9c7o=;
        b=mjgjZulfI8YyU0babK3JkAgNYN1MW1wIkJGrAwFhAoKTzM9Dk5I02MdeI8qcOiFkQX
         Ns6q88UwNWIRGmAP11N32vaRkxyd1z3usKt/nDNGiS0xlK7UdmsrIw8yvp2bYlSjO6Ii
         VYOwnd2hL1PAPwI5RX4hn+rcXfrhseiShJw0H9eD9/FaNSifISa46C8NWW5M+VAa7DGA
         zkxhqmgALrz3rISXTYFSJN6YTImk6BARYcdCaM9xApsUpc5MgSAjjj7LF9tkC20ir1yo
         4BTKb/nicDtmMexfAZjRZHRYZRZJEsiN1IKw0yxjwFqECWasfZUWQIJ/52iFg+uCJ8aS
         D+2Q==
X-Gm-Message-State: AOJu0YxiMV7vcbVnH8VLg/GKnk1qLhkdOekI0z9xF1WD7dEUQKToyQtb
	gL2mCkFkWCQKBW5TzY69CZs7jEemnIOig/cVx04r0ZMj2i4hhDyRAt+2zvENS4k=
X-Google-Smtp-Source: AGHT+IHN8f4hiD/vd9K7ytjwEPOBqGk3wlnNNl/5pSoXEuVbxZ50nQ/XvZY2EiIibH6snwRgOjrk/w==
X-Received: by 2002:a17:90a:55c8:b0:295:aaaa:74fe with SMTP id o8-20020a17090a55c800b00295aaaa74femr1951102pjm.14.1707183965199;
        Mon, 05 Feb 2024 17:46:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpF1nA3lpEkGTYXCiSU62i0HHPtXpGoYqFRGPLj0W+LAOiq4VNrrvb+6szqjtfIwfSLsiShqwUVOTNjzwfB716a4XiW2ZR81ZRGjjDmW3UPKADH0JpITj1e4WY/UdPSDDzz2D0oc+Mr+3/pXsTP8YgZGpYojKJhFwYvS6cxgPo+WKUrq/bqnytt6ayaf0+bkp2H2iXBcNIgbF42PKLFRFosLuIBOoP8TFNNVGcWBjvDUVvPb0RNNVKuM35LVrw6hh4HrT2+Bd5y5WrTIWu3BBwRLghtg2uuWN+p7pVQnxn
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902c75100b001d8a81e22cbsm556736plq.14.2024.02.05.17.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 17:46:04 -0800 (PST)
Date: Mon, 5 Feb 2024 17:46:02 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] riscv: misaligned: remove CONFIG_RISCV_M_MODE specific
 code
Message-ID: <ZcGPWrGRi92Chtj8@ghost>
References: <20231128165206.589240-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128165206.589240-1-cleger@rivosinc.com>

On Tue, Nov 28, 2023 at 05:52:06PM +0100, Clément Léger wrote:
> While reworking code to fix sparse errors, it appears that the
> RISCV_M_MODE specific could actually be removed and use the one for
> normal mode. Even though RISCV_M_MODE can do direct user memory access,
> using the user uaccess helpers is also going to work. Since there is no
> need anymore for specific accessors (load_u8()/store_u8()), we can
> directly use memcpy()/copy_{to/from}_user() and get rid of the copy
> loop entirely. __read_insn() is also fixed to use an unsigned long
> instead of a pointer which was cast in __user address space. The
> insn_addr parameter is now cast from unsigned long to the correct
> address space directly.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
> 
> Notes: This patch is a complete rework of a previous one [1] and thus is
> not a V3.
> 
> [1] https://lore.kernel.org/linux-riscv/d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com/
> ---
>  arch/riscv/kernel/traps_misaligned.c | 108 +++++----------------------
>  1 file changed, 18 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 5eba37147caa..38af97f4819c 100644
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
> -		return __get_user(*r_val, addr);
> -	} else {
> -		*r_val = *addr;
> -		return 0;
> -	}
> -}
> -
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> -{
> -	if (user_mode(regs)) {
> -		return __put_user(val, addr);
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
> -	if (user_mode(regs)) {				\
> -		__ret = __get_user(insn, insn_addr);	\
> +	if (user_mode(regs)) { \
Nit: formatting was changed here (previous indentation seems better)

> +		__ret = __get_user(insn, (type __user *) insn_addr); \
>  	} else {					\
> -		insn = *insn_addr;			\
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
> @@ -588,9 +514,11 @@ int handle_misaligned_store(struct pt_regs *regs)
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
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

The changes here logically make sense but I don't know how to test this
misaligned access code on M-mode or in S-mode. Can you provide how this
was tested?

There are also some merge conflicts that were introduced in 6.8-rc1.

- Charlie


