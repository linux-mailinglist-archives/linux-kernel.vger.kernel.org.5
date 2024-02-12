Return-Path: <linux-kernel+bounces-61294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D877851094
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E702830AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D31BDC2;
	Mon, 12 Feb 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f5YTc/ei"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC818AE4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733194; cv=none; b=rQwzNNI1I0E57uNyQ9R/eQRtkyVXymI0T6/qpTD3X/mxak/KeJt7TKdPqfjyfcyqrWaRNbkIO0tSyHC4Srx7OtznrvFM4ZrHUhuyAFZwQgXUXn8/WHVy2gMekeLMgtPJd9g3MuZ+58citFGrLgLfzrSwg3mLa0b0w4SaewwDlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733194; c=relaxed/simple;
	bh=stApHXKmMjdDKydFOXfpYUixv8EzMnvP5eqF04fkd3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7oAj8gQbctLNkr5Mn2IyamRAJKSgUKWs3Kc2AsfavrXAejy+BqavhEoHPCtoD8G5ISWz9z8RA7qPopsZAewiEZOxQwYjxmLvkdnJsegWJZ5LIVTWKMjNMN4sJW8ugAKoJBEqIiQZ+LPoWddnxX0fFxgJgOibBVUCKR6J0eYT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f5YTc/ei; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so398907866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707733191; x=1708337991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvQWREAbmI4M99JLIGIgWuWSahreIBj4RerUN8XO8hU=;
        b=f5YTc/ei1FsGsun6hzZcR1VneUNmQ+arSEGoFv/3rXI5pwZA5yajqp/QyKq2G0gpAi
         YTfeRWidSGHzm3KACcxvttjSCZveQ4ZZAvKbCbTh7SDVoFZNGlYwf1Oc/viJ0okDwDdb
         RiMBADSAjtsA0a9nNh9h8yR5Ienuv3ZXjtNDwKbhA9aPRH9tbwsjLrYwh2vxSlAuVYNJ
         Y4DaS8a9u4I/GUuGCzdqYh+O0H9Cy/Y6ZuklbER1+QS9kN/JtCqnhQy5FQwASX1N4hCx
         /zlvcJY1MaBVX6kBjRUyVL6DfpYnyncLh96hbJH8s9w20OIzFgpb/P/XckWOlBnT6GPQ
         kJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733191; x=1708337991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvQWREAbmI4M99JLIGIgWuWSahreIBj4RerUN8XO8hU=;
        b=Uc1ZaUUcSPHf+RD+ABuEdxLGAmI2f3QdpTBb9eGL8PDRzuWipospF2ECnWJeyfz1Ke
         G8KtpxvWmL9yrchil7iMdacp01d1tZLxmdAOc325lUNWrfh0owbtJD6mWccJs87969zR
         I4f6Op2cF/gmcPdNpIhNuh9bWre3bBxOdlbzANVx5YVcVF/jCdUpHbJ+WLetRdYGnx+7
         wyqH0U+4QTfN2nNtJAsQQ9/fUSSrH1r/udH1qYAB3dGgfSOYtht2z34k1y5uOe2wwkYL
         HjaiqttDhqxrpVacKQd6AlREWTV3JKwwqR+lVe2DtFOGThwcsAOH55UugEAFT0XHaJk2
         /g3g==
X-Forwarded-Encrypted: i=1; AJvYcCXe5W1QEnUtWzBs2m6K71TUSTuE+rKtlzCq7jKKOvC5cEHwlgesAVMxrqS5f9JoPrFw8Fnrl46sCuaoAgMLPwKqrlT7L2/R5vx6G4/q
X-Gm-Message-State: AOJu0YyBXSAqIeVMBlz0qtXRCl9p2LTxFABvyMGZwDnCgRu51eYYPKZf
	4NZ5PuECe9VF/9hRJFJ9WTdUe4cb1YlqV9rGoUgjpm6+9X71zWFpapFZQh9InsQ0rFfM0narImV
	z
X-Google-Smtp-Source: AGHT+IHlsTal0b91kFfibooXXny8PGCQtBgjmj4hfoNc/+LJNCtv/jeHO2qaGel1Ug7B3Ev++yRt5w==
X-Received: by 2002:a17:906:d96a:b0:a3c:89b0:e668 with SMTP id rp10-20020a170906d96a00b00a3c89b0e668mr2112915ejb.36.1707733191304;
        Mon, 12 Feb 2024 02:19:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV67dp3FLi/peU2IOFWDLk7uCQ1YgdnzVTUYHUcexVvVv5h7WYXgpunkZbZe4aBX7CRRGTpMgSOfDuJfFrtvhSu6qCzhJ6tudZxsA5lxSGcZ2a/MdIsgweoDI4u5SB0FLL0mslqaVsCRoAcvxlc4SXf3F42zvjQ2ICJDxNM8hSI4A==
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906718d00b00a3c8dbdcf74sm59112ejk.29.2024.02.12.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:19:50 -0800 (PST)
Date: Mon, 12 Feb 2024 11:19:49 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH -fixes 2/2] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240212-9bb1aef7caf675693458455c@orel>
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
 <20240212022642.1968739-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212022642.1968739-2-samuel.holland@sifive.com>

On Sun, Feb 11, 2024 at 06:26:15PM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
> 
> Because the [ms]envcfg CSR is part of the base RISC-V privileged ISA
> specification, it cannot be detected from the ISA string. However, most
> existing hardware is too old to implement this CSR. As a result, it must
> be probed at runtime.
> 
> Extend the logic for the Zicsr ISA extension to probe for the presence
> of specific CSRs. Since the CSR number is encoded as an immediate value
> within the csrr instruction, a switch case is necessary for any CSR that
> must be probed this way. Use the exception table to handle the illegal
> instruction exception raised when the CSR is not implemented.
> 
> Cc: stable@kernel.org
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/include/asm/csr.h     | 23 +++++++++++++++++++++++
>  arch/riscv/include/asm/suspend.h |  1 +
>  arch/riscv/kernel/cpufeature.c   | 23 +++++++++++++++++++++++
>  arch/riscv/kernel/suspend.c      |  2 ++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 2468c55933cd..daff95feb817 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -542,6 +542,29 @@
>  			      : "memory");			\
>  })
>  
> +#define ALT_CSR_READ(csr)					\
> +({								\
> +	unsigned long __v;					\
> +	__asm__ __volatile__ (					\
> +		ALTERNATIVE("li %[v], 0", "csrr %[v], %[r]", 0,	\
> +			    csr << 16 | RISCV_ISA_EXT_ZICSR, 1)	\
> +		: [v] "=r" (__v)				\
> +		: [r] "i" (csr)					\
> +		: "memory");					\
> +	__v;							\
> +})
> +
> +#define ALT_CSR_WRITE(csr, val)					\
> +({								\
> +	unsigned long __v = (unsigned long)(val);		\
> +	__asm__ __volatile__ (					\
> +		ALTERNATIVE("nop", "csrw %[r], %[v]", 0,	\
> +			    csr << 16 | RISCV_ISA_EXT_ZICSR, 1)	\
> +		: : [r] "i" (csr), [v] "rK" (__v)		\
> +		: "memory");					\
> +	__v;							\
> +})
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_CSR_H */
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 02f87867389a..491296a335d0 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -14,6 +14,7 @@ struct suspend_context {
>  	struct pt_regs regs;
>  	/* Saved and restored by high-level functions */
>  	unsigned long scratch;
> +	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
>  #ifdef CONFIG_MMU
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c5b13f7dd482..934090270ae5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -954,6 +954,27 @@ void riscv_user_isa_enable(void)
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> +static bool riscv_cpufeature_probe_csr(u16 csr)
> +{
> +	bool ret = false;
> +
> +	switch (csr) {
> +#define PROBE_CSR_CASE(_csr)			\
> +	case _csr:				\
> +		asm("1:	csrr zero, %[csr]\n"	\
> +		    "	li %[r], 1\n"		\
> +		    "2:\n"			\
> +		    _ASM_EXTABLE(1b, 2b)	\
> +			: [r] "+r" (ret)	\
> +			: [csr] "i" (_csr));	\
> +		break
> +	PROBE_CSR_CASE(CSR_ENVCFG);
> +#undef PROBE_CSR_CASE
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Alternative patch sites consider 48 bits when determining when to patch
>   * the old instruction sequence with the new. These bits are broken into a
> @@ -974,6 +995,8 @@ static bool riscv_cpufeature_patch_check(u16 id, u16 value)
>  		return true;
>  
>  	switch (id) {
> +	case RISCV_ISA_EXT_ZICSR:
> +		return riscv_cpufeature_probe_csr(value);
>  	case RISCV_ISA_EXT_ZICBOZ:
>  		/*
>  		 * Zicboz alternative applications provide the maximum
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 239509367e42..fe544f12a5c5 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -15,6 +15,7 @@
>  void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
> +	context->envcfg = ALT_CSR_READ(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> @@ -36,6 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
> +	ALT_CSR_WRITE(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

