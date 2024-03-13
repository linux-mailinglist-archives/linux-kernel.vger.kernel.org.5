Return-Path: <linux-kernel+bounces-101221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFA87A430
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F0CB2199C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF51B277;
	Wed, 13 Mar 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EyI9Chw2"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C5AD5C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319462; cv=none; b=jgjj+jZYtamZss6old0h3dkN2OGlU9jJaKBOpnHxpm6S0IAC91IX5J26iJH1qV9sJhTYtOmXeXKO90wTp1DJEX7ZNqBFTI/Wzvd9hwoGn7KeYDEJxL6lfyjx1FyQPUpQ27PvoBGLj7IF3qm1SCdTXCqy9jKS+zK56hR8IhXAxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319462; c=relaxed/simple;
	bh=eIy4mFlgIwk3BsE7FfLoI0BF5bJWDglZzJAbRpqNT4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qABgXqoAQjUSe6SQCl04J5s+P5sKS/SbzvBgdu0canyGYs5WY3CDhTEWOAusCoFZ2eidpcqPjvlCIN0GUp5aAAa86VfZbMe/7yPspfAevGvmMMQKNoiccPV6Ajle5A1SefyPJ7FyQ9XI+IKMGqx6I34976h2EeIwR6rql8mdfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EyI9Chw2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e9990da78so2520723f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710319459; x=1710924259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVnlgrSA1iDIweojaV3vTulnCmsG1cIXseUx2d2oWFw=;
        b=EyI9Chw2sez9sDIvSmfSFd3+xAF+apnpC0iTbgZOBzGU7D/cSbbI3v9fYlYRU27ti7
         Jn2+ydNqMNLrQP1KakycGS5QNcunobqjnrwCavynMAg/meBwwnL5hF36tSetC5QuG/Yf
         F1v1P5TtwBfmLJDqgNMnd25aKnhU0QLy3YQ3zrbBQuzCO0NINEfryzEOp60fdqKXLu2P
         f3HmMYajBt3FS3okcGflpEGHNs9pehAmcfBMjI2P9vAFmHtGYhzAeC6egpa2nWF3tI9s
         NYsD8WCM84y8E0ScpyivW4I3B1gL2+oqh6K33Zi+6hSAat1Q8hPamuFbxjvnmbwW9Ff3
         dtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710319459; x=1710924259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVnlgrSA1iDIweojaV3vTulnCmsG1cIXseUx2d2oWFw=;
        b=Da+EmsvEUb8tbuJ81aaJmSgjAXockr86De3KrRc/V+TNm7GJeEknnU70KFJ9l40Hwq
         zpHOKBTgQK8uEN+Wn2uQ6dX+DEnjx0yeuKeS1O+UQMkD2BfVCN210QJ8UPGGODXEHgjo
         IzzMn4nv/JHJv3B6h4PvW1RFFhfVJHL82FeZ5rCoTWNl+GhVMRE/cVYj7NcZLaAiEBDw
         WtlrfW/wCZAllTD726LqPGStaHBk5pKAfyWFtkfpCxE3fngPOuwG2urP4yCtGnqZ9HMV
         l94qHJj5F+5zF5e0ckGeO0hKehDl1i/n1L+wJFENcpaSQgUB7mSE2YBuGH3FL9ZnLjdI
         l2pA==
X-Forwarded-Encrypted: i=1; AJvYcCX9NvZqEn+fKwo1NZwWhNT4EJAbCQglrMeIKetVz8CAHojsbX46NNlPmGEFwT8jYXABPkHPHHCnMqxxACWz/I8YlRJNvTosce+Mo3JH
X-Gm-Message-State: AOJu0YwhulUDK5OjNOGSBuneR/2WPHaUDOg1WiNUI4K3iEyBMs5uQ6i4
	w4o4VthuO5TGlVxmwWhrU4O6/rhB4rCi09m29V86/zznx7EXQMFpNCG7DYMAjtU=
X-Google-Smtp-Source: AGHT+IF6PXsG6ZxE+60qwQnTwNT8NyXVLUagjQgwFnk02BeNPnrpuv1g9j6Sj2PCDpibbr6u0xH1bA==
X-Received: by 2002:adf:ab12:0:b0:33e:b6a9:a7f7 with SMTP id q18-20020adfab12000000b0033eb6a9a7f7mr792595wrc.43.1710319459333;
        Wed, 13 Mar 2024 01:44:19 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id bq7-20020a5d5a07000000b0033e95794186sm7787748wrb.83.2024.03.13.01.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:44:18 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:44:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] riscv: Do not save the scratch CSR during suspend
Message-ID: <20240313-a1837dd45cb20198ef5ceae6@orel>
References: <20240312195641.1830521-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312195641.1830521-1-samuel.holland@sifive.com>

On Tue, Mar 12, 2024 at 12:56:38PM -0700, Samuel Holland wrote:
> While the processor is executing kernel code, the value of the scratch
> CSR is always zero, so there is no need to save the value. Continue to
> write the CSR during the resume flow, so we do not rely on firmware to
> initialize it.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/include/asm/suspend.h | 1 -
>  arch/riscv/kernel/suspend.c      | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 491296a335d0..6569eefacf38 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -13,7 +13,6 @@ struct suspend_context {
>  	/* Saved and restored by low-level functions */
>  	struct pt_regs regs;
>  	/* Saved and restored by high-level functions */
> -	unsigned long scratch;
>  	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 299795341e8a..3d306d8a253d 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -14,7 +14,6 @@
>  
>  void suspend_save_csrs(struct suspend_context *context)
>  {
> -	context->scratch = csr_read(CSR_SCRATCH);
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>  		context->envcfg = csr_read(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
> @@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
>  
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
> -	csr_write(CSR_SCRATCH, context->scratch);
> +	csr_write(CSR_SCRATCH, 0);
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>  		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
> -- 
> 2.43.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

