Return-Path: <linux-kernel+bounces-61260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10790850FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E13285F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6864217BB6;
	Mon, 12 Feb 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cjMWQUCb"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1AA179AD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731456; cv=none; b=qLWw2xK/kXfy0qczACbR2/2YLVL7aQMvUbiwR/EhfbkPhXLen34JYvtPXOCs+Rwv2hxGs3XIpuPuF0Ot8aAoQifqFF4fXS8nBiCwfoabJA/c4XPAkYBXNtEU08k78d3M+M/GH+vCTKfhzDOqUQTzzMGCi5Rqd4OYSkNXTWMO3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731456; c=relaxed/simple;
	bh=YfqIV2ueSzLWm4lSVc7hsQK9dO+DdIcmz4zatdmCV+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEnplUIDiTtEXLprODlX6TCzWTVSY2OhsvqmYvXgVfLC3h9Ef3XrVPyWas5pmRD8r9ddXO+0g+dCgHYRYQicOqS44kNbMyZRkqUQd4F++t26WkXRYiMBn8ZdCzWSbIIpCPwoHlZ7TSaRATSEWwVmZK6isVKpdeVJDJo6nLJUedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cjMWQUCb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so3286549a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707731453; x=1708336253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMNSfL2Ym6c7Zezy/ui/ZcWVA+HK7KYShyTz/+IryeE=;
        b=cjMWQUCb5cSPOO/PJTS+ieHTzQ8OS7eYf+Cg2292fm8g8JCIXIzKCgBhDLl5K+Kb35
         hHBa5Q1v40oQ0iwIR7FKk0yAQEsFtFu+UY8/48BxZ3ZWZsWqRryZdMrgm2ITsBBDdfgo
         8SPitKIhw7f7Pgo62dqWHhzrXRKUwbBU0MrQ/eZK2eySDed+ZHqKfR47Ujhf0Yw5U+HR
         JeSr4CG+zkNbDES+e/MO958EYa/QVxKQOTNyqkFud5B/7hZYqli3dWobKfQwrxgrXV64
         t++z2xesmSTmh2oP3AUBTfrQd9xm4GxMwkZo+3g/0RyeqpttKB1ad7nC7Fqq1EGLw594
         0ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731453; x=1708336253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMNSfL2Ym6c7Zezy/ui/ZcWVA+HK7KYShyTz/+IryeE=;
        b=to8zMcuflvEQXRO0+FJ/cewpKdvx6FrHSWBXkKXYuUhuO6wgRieS6a9AWMQM8Ot7E7
         DQRw1jBptATIq10MUXuPAlMCNW9dOf/ylG9QVQQY2qBFwBj0qMWk85SoknsgorS9p3D+
         aPmEr9SQeqDy9LwMSZNEMbntYDh0XD53X2mKDJeFUHo1pM4ihynwBecMEwRDm9nY0S0l
         cSwlaBH/H2lTA3rQpXv1eN+6Txqr8ehXeGk/x7xKToeYlLttWalw8OIju7VBsnRxeldf
         7awVXcXHXuum9IFLUiQxY+b1QieT0BiTux36mA4a+1y66wnVMtx2fNlpokgp514y8ner
         mv0A==
X-Gm-Message-State: AOJu0Yz/DkfFYfw1+QpvT82qHSD+obgftzgqhlsbRs24opgZ0/wuQqwY
	jf3k+GF2pyAzzPRYJj986PeatnkSImnTLXi8quzKger55I3Lno36ozvRoNN5jdo=
X-Google-Smtp-Source: AGHT+IEHefmFK6RXs1piHINjPr7eU8fn6FRyby0+Gy/AFZ59WWztdnDQmxT+9zsovkLT+qfD48oHDw==
X-Received: by 2002:a17:906:d96a:b0:a3c:89b0:e668 with SMTP id rp10-20020a170906d96a00b00a3c89b0e668mr2065479ejb.36.1707731453006;
        Mon, 12 Feb 2024 01:50:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/aUg8qs/APJHqvwjc9NwN6a0aFyGrqC2ylHNgM5CI/v8vXV8t8UX2WQWPrM0ITfPUHr+nLSn4RXeSNScuhY50CcgdM6xIzesOPG12JxVjNtQs14tOLowHkSS2pg/wL6NWvZto8iuT3MOSt7h4I52HNqKRBZw0/1eR9fHg6dtENg==
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id kj7-20020a170907764700b00a3c2003ac07sm26707ejc.146.2024.02.12.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:50:52 -0800 (PST)
Date: Mon, 12 Feb 2024 10:50:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH -fixes 1/2] riscv: Fix enabling cbo.zero when running in
 M-mode
Message-ID: <20240212-7e10c9a05a0035d3542df1bf@orel>
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212022642.1968739-1-samuel.holland@sifive.com>

On Sun, Feb 11, 2024 at 06:26:14PM -0800, Samuel Holland wrote:
> When the kernel is running in M-mode, the CBZE bit must be set in the
> menvcfg CSR, not in senvcfg.
> 
> Cc: stable@kernel.org
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/include/asm/csr.h   | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 510014051f5d..2468c55933cd 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -424,6 +424,7 @@
>  # define CSR_STATUS	CSR_MSTATUS
>  # define CSR_IE		CSR_MIE
>  # define CSR_TVEC	CSR_MTVEC
> +# define CSR_ENVCFG	CSR_MENVCFG
>  # define CSR_SCRATCH	CSR_MSCRATCH
>  # define CSR_EPC	CSR_MEPC
>  # define CSR_CAUSE	CSR_MCAUSE
> @@ -448,6 +449,7 @@
>  # define CSR_STATUS	CSR_SSTATUS
>  # define CSR_IE		CSR_SIE
>  # define CSR_TVEC	CSR_STVEC
> +# define CSR_ENVCFG	CSR_SENVCFG
>  # define CSR_SCRATCH	CSR_SSCRATCH
>  # define CSR_EPC	CSR_SEPC
>  # define CSR_CAUSE	CSR_SCAUSE
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 89920f84d0a3..c5b13f7dd482 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -950,7 +950,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>  void riscv_user_isa_enable(void)
>  {
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> -		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
> +		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> -- 
> 2.43.0
>

Deepak has also posted this change[1], but his is missing the Fixes tag.

[1] https://lore.kernel.org/all/20240125024611.1321941-1-debug@rivosinc.com/

Thanks,
drew

