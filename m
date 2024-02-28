Return-Path: <linux-kernel+bounces-85088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9086B045
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B581C235A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9C14D44A;
	Wed, 28 Feb 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DqPURRkb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2114AD29
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126856; cv=none; b=Vy7s16MFko+CQdBWzd7zhsq8Rgk7E47SaUJx/gWdtSu9oqFU3TdriYZ3YEZO+cqMAlEaf3NyN9p7x7s4y13Vot56icbucUwdqUCm/Q/6aoa2RtuFy4JbZKeSIm1ZW7F3qXS965DmW4JLx1Up2bZm5h0MUtC0OaJlsKGJ6uOZBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126856; c=relaxed/simple;
	bh=OhYQ1wbcM/5cvGzllyuLV9iLeLmBj6Hy+kF8PqKuACg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcPxLZgzw5nP5un6xnblSJD+CgUFK96SDOnHEmUtEwVoO5qv/E4U+vjJMz2pUUIZ1jhXtvAQ/QZPzemY2PcWPoFnC3ByRchmisD66Q6Ca9sf1XT034h/mJf63LrST8DfnN7eMwaqnonr+TCcwGadY/aDOVRz071SVzv9TXP3I1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DqPURRkb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so68120021fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709126852; x=1709731652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=085e3STycEqrCsNI0U1fWcxzFfs9YgyshKRlsnEMVpE=;
        b=DqPURRkb6hziyydRjm1NTpxoO99SRwdH4lYJyrGZKRIYpic99fqvujiFQH8ZW6uq+u
         DEk4CkpO6uZpiiQWp5mj1S0Vjz+XNtGBtaNq0gxfECjfzOpMU0OjqFT5MnUjNr0ktWyq
         gz2xnORAvq4krmjXOPDi8tgktMAghEPYbrVzvK/3xc3XH13aOKmh2+PYEywCosUn8QS+
         OM/uBWLYNI+w3e2yxYS8C0ZWae/hKZiOCWxc/tcj758z0GUCyZZ1isgUOELMeC89fVwm
         D5l1u28Paa2uiE/ytGuUADdRhKj07bIy9oj4IUYzf0Z4SbKdsFUj/5Zlm6Do9MkDTI1O
         gn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126852; x=1709731652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=085e3STycEqrCsNI0U1fWcxzFfs9YgyshKRlsnEMVpE=;
        b=al/Av8tMNCbTR8T44Ia5Mt4OU5WcYMCelcRhJ86FenAn9pf9TG12k3Os1QCTkfWccW
         Nkyq3Cs+YYAuEm4JbrocTDw8RoYtf4r/SvP/7yBzBl/JZfDTRZLF36juq2S1eNQukAgh
         RoDkQf9kSbLlJBtFEcTr1QDz30ay8enb8cAy5+2npR9l4m75B5qXlZ3Xv0juGmxKB+bB
         c6hHnj9wx3/CI1uR9JHqIdcOyA/lmfXrq3hsCkTXKJbYLuMexOi/sGyAoE6XW10BkG8/
         h6TsJQStSu3x/C8fXGUEG6v9w590C18xPlIoQjOoGcruu8eCJ7ZkeTAIgNWAixKX4RJG
         vNQA==
X-Forwarded-Encrypted: i=1; AJvYcCWhUQp9mOs20KxOb6E98cG1nd/HwebF8wlqEJKbmd4oCfNCreQeKZWUxBrl0xW7MvKJ3RSQBS+Mp4vt8QM+Hvj8xotMRPktpowWL7P5
X-Gm-Message-State: AOJu0YwpuG4W0AnndGrimH5cpT+K/wtm6Qpu/wUukpVUBFWkwsjxZQEl
	EqJ1EfKV/QljTuAtr51GoEqZCYOnI76SRQN8qQf0h7bDMmKXXz/JAE1aTlI3YiI=
X-Google-Smtp-Source: AGHT+IFC0XXC3H5qzKW/aZa5LVkLGjCH85nXFOY7PAeqSwrdiOpz48eXurJvLKthpHRi5VSbPhLa+g==
X-Received: by 2002:a2e:9614:0:b0:2d2:acef:6aca with SMTP id v20-20020a2e9614000000b002d2acef6acamr2443164ljh.41.1709126852478;
        Wed, 28 Feb 2024 05:27:32 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4211000000b0033d97bd5ddasm14525870wrq.85.2024.02.28.05.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:27:32 -0800 (PST)
Date: Wed, 28 Feb 2024 14:27:31 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v4 3/3] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240228-4bb96d297dcbe43ed85a9760@orel>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
 <20240228065559.3434837-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228065559.3434837-4-samuel.holland@sifive.com>

On Tue, Feb 27, 2024 at 10:55:35PM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
> 
> Cc: <stable@vger.kernel.org> # v6.7+
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v4:
>  - Check for Xlinuxenvcfg instead of Zicboz
> 
> Changes in v3:
>  - Check for Zicboz instead of the privileged ISA version
> 
> Changes in v2:
>  - Check for privileged ISA v1.12 instead of the specific CSR
>  - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s
> 
>  arch/riscv/include/asm/suspend.h | 1 +
>  arch/riscv/kernel/suspend.c      | 4 ++++
>  2 files changed, 5 insertions(+)
> 
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
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 239509367e42..299795341e8a 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -15,6 +15,8 @@
>  void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
> +	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> +		context->envcfg = csr_read(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> @@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
> +	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> +		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> -- 
> 2.43.1
>

Picking _likely vs. _unlikely sometimes feels like flipping a coin, but
we'll presumably be increasing the likelihood of xlinuxenvcfg being
present as we add more and more envcfg using extensions, so maybe we
should use _likely here now, lest we forget to change it someday. But,
either way,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew


