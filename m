Return-Path: <linux-kernel+bounces-64962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D85854533
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9940B1F2B175
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C101643A;
	Wed, 14 Feb 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lc8wzgnT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725C1642A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902928; cv=none; b=GLXl0pr3Huf2HN0XSFbHg4tL7kIhD3iyVtjNuoCpsWMT4wVPCvIDetSE4LcsNtLA6s6dvJ2Oj3hC1dxAzF5P5ZHxv4sB072i//nfSHqYtmxizCAG3iJ8f1hX4szFa8aIHa2yoZt5n32TsoBQohP/WwLTxFe3iOFcQd4HhWJY5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902928; c=relaxed/simple;
	bh=ogRF0dkw4pMmIjXIW5SEIC1uVh782JEQkuK924LREv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+YYZ/4MU8PxKX1FFIqhpHPrRFMs8o3mXuEdS0sen3cziEY4MrRRkGp5pqn8VpgTtCi93gxTbFyHaU5dn5hVGJhKOZgTm1kBr+q1X3udAFqKBGMd95Ne0p+fhz/iW+04JoNq1JgsAp2EReo9793e4WN472X6QPTVQTAXUdQ28eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lc8wzgnT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-411f01e496cso1686335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707902925; x=1708507725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RPD3F6e/n6JwP4T7PPxVZL5Vj2U+mnXgv62nlhdBHI=;
        b=lc8wzgnT2kQWP6tSm2rp40hS7hz6+0LcPQJzUkKPaqnaUcn2wV+X4Ugs0EKdLNyYxM
         z8yVof0Piv0SxdS8WPgkpLRbIVLsQ+zXJ0YL19LnlP9AnZFh47M3ZpwTybD/g5tUWfex
         lcQsRICpCyOKvZkedDrXttZRiiXdZedVF9JQbcChY/2D5zsY/Cx4FchIlmFjazxvy/hc
         Rb/VGagdvmqNDZfEc93vrTzM94xqELDOXVxv4MwXwdxNR0DZPXQ4aMv42Kt2+XLp5vNJ
         uKZx6Hrb4v70UTtUhhe26UvZVtRLDWXy695o9n3AxzQVWpWLDZ6ntbOkzwVVYqa4BvXs
         qW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902925; x=1708507725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RPD3F6e/n6JwP4T7PPxVZL5Vj2U+mnXgv62nlhdBHI=;
        b=mXThlAZdCftRxFHuYoe3He925jrodj7qhYbbOI8wn64XDmOwe435tnfcm7NwJXaa24
         S9KXdBJ0ORlElwbbNiHHN4nuyKax2z9dC59/YF/Cy6k4ctBiQvGGmCq2zE21A7GZqkEv
         wIhmmb3iZnnPHe7InZprH6JtE5L5cLPCU4nDGPpRW8GD76HMUYBdpfjiiGTsEnRdfKwz
         DihwbxAqnnvsPh2x5PpS7SsF7OkdmWyslF7qlz//2D0Sql5DqJtVGFNtreBpg7Cilinm
         g77r32ea0FKDmYAyl3pS53Z0TjPum2k8roqRlu88akc1kIHUB90e6jlNiDc0Mvf7FBqU
         /22w==
X-Forwarded-Encrypted: i=1; AJvYcCV0GVQv3/32UDKblH2yXGH/fYz+hWN+ofdbt1+E1mMa7pyRfoMBwa/TdJxSoSauG6NdQPJoaZFJKRGNgcJ2z91F7AWJ0vvYwx0hAvBN
X-Gm-Message-State: AOJu0Yyk3Z+44gxXXKsjc8HNgPhX9eUSHiC3iEreYCE0n1gv9Az+eCIm
	X0TPJXzoVpkGmRuzZMHWqM6+pOwO2Nwo6RoqhxOKq2w7PXAerA5rXdph9zt0S7uRWmARXCeOV6N
	3
X-Google-Smtp-Source: AGHT+IH/jZlTd5dXwhLTv3vk6Fm0dC5RasOYCQzao7gRpjTcKUsjGiy+bgOehvxuk2rYphfCL5nqtw==
X-Received: by 2002:adf:f7c6:0:b0:33b:1bf4:5c1d with SMTP id a6-20020adff7c6000000b0033b1bf45c1dmr1179404wrq.26.1707902925220;
        Wed, 14 Feb 2024 01:28:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnrYzeBGnb+//sTFc6PlgGFuTgi8l3H8Jtte+dwqftxG5uCc9kGdXRlafzoB26IjcuXjoYtskir6rdxYVuHyMltRCLWexjRH/2I6HGhsy9rshixT8srkPUHNUebVXYKAXDvaVB3ORfBQK78Ja9NvQ3L8rRpONreDnz9ySxoPX7yI9g5Uvp3soLkeJ462kmSvKCFRdRnUVJ2J0ItvsJXtcowR1y5ellUc2ILrSE
Received: from localhost (cst-prg-65-8.cust.vodafone.cz. [46.135.65.8])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b0033905a60689sm11772751wrx.45.2024.02.14.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:28:44 -0800 (PST)
Date: Wed, 14 Feb 2024 10:28:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v3 1/2] riscv: Fix enabling cbo.zero when running
 in M-mode
Message-ID: <20240214-661604d82db4ef137540b762@orel>
References: <20240214090206.195754-1-samuel.holland@sifive.com>
 <20240214090206.195754-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214090206.195754-2-samuel.holland@sifive.com>

On Wed, Feb 14, 2024 at 01:01:56AM -0800, Samuel Holland wrote:
> When the kernel is running in M-mode, the CBZE bit must be set in the
> menvcfg CSR, not in senvcfg.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> (no changes since v1)
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

After our back and forth on how we determine the existence of the *envcfg
CSRs, I wonder if we shouldn't put a comment above this
riscv_user_isa_enable() function capturing the [current] decision.

Something like

 /*
  * While the [ms]envcfg CSRs weren't defined until priv spec 1.12,
  * they're assumed to be present when an extension is present which
  * specifies [ms]envcfg bit(s). Hence, we don't do any additional
  * priv spec version checks or CSR probes here.
  */

Thanks,
drew

