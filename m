Return-Path: <linux-kernel+bounces-61295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE798510A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FA71F224CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263D18026;
	Mon, 12 Feb 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EfPk0P43"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997512B70
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733343; cv=none; b=c4ZMK5y3ufa7bgi0oDl23FYq9qSczDM2WXw0tLTzgZK2wtsPHoMp/sGNQmDp56HaPSTuHOX+Z4DNJ2rNcFnPjb7rH5Qxta5aGHrm8UsVHXRlqpTwK/C5+2vKlyrkOPJEfnbuncUPxgDHoL/oh60rCvaNY0venhQAxA0K55vwPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733343; c=relaxed/simple;
	bh=p2AuQvUBimzZT49rpUVISG7UGfVB1BHw9Gqh/gjFlS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogMvzBbfgSagljogYWtV/YEnH12sJ62OG95Beo4ENY4orjgF/vZdPRPXLYpR5nAJ4RD9DTTISnrJeD/J6k9LQLCJx3TNMH5M5nzY/M4cDjkjDeMJ4H/WmSfafoYojDuTEMz5s+rYCg1eV0ozYmHUwUj4B4vO8UsJcAA8IYMJdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EfPk0P43; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso6969918a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707733340; x=1708338140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QF+Yu8kjYSyF8+VL530MkO85lQO3uEFBWUk3k+lqh0=;
        b=EfPk0P43tQDXTRArVPSdLMn/rBb9HNo4V5tGdMlQXL7Sbojec+EuwOfIODS4tJWELL
         ftMR4Zf9Pra6UfBRZn0k8N5myKvX2bENV3FuVFAgc4V9G2Dwkuk4iCe4UhHAabNHI3t3
         z30HUiNjjkhzpQ1sChQz+xGOHXZiWZhzBpO/V3gDTWMGhuPGeF884/2kFF8qEmpzw4yx
         X6e6ebPq9msAZeBkQogdrvL5UmXi9YqUTyosp3B2I1twgHzi+NgfZSp7IvoWjQOLysI2
         1F+xnKUWXMwtamzLUyB6Kto/+DrtocJx7dtqTYFk2VMRgOjiSFy3kPbciId7Nmjfnxnf
         +qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733340; x=1708338140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QF+Yu8kjYSyF8+VL530MkO85lQO3uEFBWUk3k+lqh0=;
        b=IJmQV/8322/7ER1C/1Ma8o2cigOwU7RGG2C1pLIcTqF1/4NfALBM4KHUoM+PnIEqxE
         MOSlHMcJir1LLc7+H0CXy5YxFdr6rcavTxkYr57XzcQL56/OfukDd55DMZrmcDr3TX1K
         fsCI8SxN5aW0PSKZo0YI1Yi2+Xgb4Kpc2noPB6usYbz3LUNoowl88jm8DGyYzK5hi0/7
         3Y77jL7KiNO5/U6aqJ+tMO8BMSch3XH8GeBq+hMwojXKrkSL1C76jPurmmpmXyen9B7R
         whyDbzsP53BIWXU3nYVKv1XpvdI6qvcyLI/tkqB+6bHp5lK6bySoykH8IdF+LoN1RJRj
         DH2g==
X-Forwarded-Encrypted: i=1; AJvYcCVSQz8SOlLGnnisnxNdg4XPMBp3w7QlAoVW8FemaGJ9Pe2SfkvJrFPPin4VPfswiErXxGF7zVKE5ju4c5wJMA//faPTTnBdIm51EBU9
X-Gm-Message-State: AOJu0YwrNN0u/si/GuXAhU6mX3QcvajxSYwLw11Mx//TZpVovtLp4p9Z
	Szlq1yZ9MroQGk/y+4fthEiI9l73A1tk8XwRJisJkoKhYCRdaqC/1CqnslsIfNB+uHD2xRd454d
	o
X-Google-Smtp-Source: AGHT+IHgUHkjSSxyD5JyI93vFfkdcw5EGtM7m8bh3vmXMr4i2NCtNpMHzRsFd/OLox5RGNqzrYftIQ==
X-Received: by 2002:a05:6402:1618:b0:561:58d0:b222 with SMTP id f24-20020a056402161800b0056158d0b222mr5716785edv.21.1707733340173;
        Mon, 12 Feb 2024 02:22:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW7EbTEIN+YaUjxiU/Tj3RdOcwHhKUFZQ4Bz2hfwpZVYBJppu+/QLsicS+T0WbgEwskbejchHVLkIAH8m4bFRZMdZdoCxkGoLHqmPYWhacRR53/sUPT8wDrS7CjSlPrlRfwcAJEcuUTxpHipxnmqWEEkPLkWsDiyLNauMrFVqkCQ==
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b20-20020a05640202d400b0055ef56f4575sm2600068edx.39.2024.02.12.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:22:19 -0800 (PST)
Date: Mon, 12 Feb 2024 11:22:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH -fixes 1/2] riscv: Fix enabling cbo.zero when running in
 M-mode
Message-ID: <20240212-6ac32b7c5fd35daddd2cace4@orel>
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

In case we take this one instead of Deepak's

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

