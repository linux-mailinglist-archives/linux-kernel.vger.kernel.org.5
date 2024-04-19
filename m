Return-Path: <linux-kernel+bounces-151339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8E8AAD32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE495B21E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB78003B;
	Fri, 19 Apr 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L41Buqb+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7514200D3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524518; cv=none; b=WREKwslzlcr2RDnbUuCaoZzvfC8UzPQwOjN8RH8v9qoPz++XkuN0fmJaiwJ/iXTr93LpaI3Hb2YgZY2us4SO1ocKbLzK/5kb/tJFjAA1Mi43aSouBlBQikcRuJhHASSjqDZcvzN0rrdGKWcZ2RszlKQKZeWZrKSeYSC00ImBVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524518; c=relaxed/simple;
	bh=F+W5saRDghEOa41U9BAigfeFAuicLwkOtZt1ReNtfvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT1JqhV1RMHcuoj+pve/bnC8IUZv8JihsQ/ARB5OPyPi+7t+ZIVPneTEIcblInsHZ3oNx6y2qNGv5gfkMvg5Ui5QulXXoP2bVaJfNYW7vKkpeXXjGMhW2EK25MxCE0Y0EuJuCghZU6qT34CmVxtzWf/z6PKq8JvAncoGdRZVKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L41Buqb+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a526d0b2349so220555666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713524514; x=1714129314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VTTzqipQA62LbzqZVTLpZ7KIqqGEoS+t4l2KKK32uo=;
        b=L41Buqb+GW+s9WdGsrq4vmUFF3d8NSWxSV7cuCPDd67WbgkCrVoMBT3J/KDktnJPLN
         cTRwasTRR83rotPgN7dl9SbAPFbll5rdRVAxgSMfudpjz04wWl67HLA6VOMUkwDBhKSW
         bQpHm17Hrvfn5e7/DOtpLLEJdU5pAaY3izWdAZqJ9sxA83xU+zl5QNXA3fpJ/hhrz8Uf
         bGyFVLzQnHpGE6b8G//PfCsgU/Fydw5y6z8FmfkuW45QkVilUHK48VtHWuPJs/WVXckZ
         etyuIlLqSt1tSROkiZHf9UFqc8z3af/aIjf6C/iH8t7coQAfbPO2xVERR9kuTBueWkdM
         0c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713524514; x=1714129314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VTTzqipQA62LbzqZVTLpZ7KIqqGEoS+t4l2KKK32uo=;
        b=Mcisx1VPEAjhAKMcsw71jwKbgobMkD1QjbWOEBrNGVXLcF5mHqzo/OSsnAT0SwrSpV
         pnKzgK4ZOuSoF25EADPi/wN3XfWhkRGowV672UN2Us/SYJFlyp2vCQrbXt4Xjk/nb60n
         xIrP8J4fnXp6q5h3rJ9BA6ObRTR6GvNUVmnYmofI9si4ov63rG2XP4Am9hq+QnzDbJXN
         EqvY9HH6I/IijVC0mt2LzKdiqUSqymrZe5ZK6nG1fR9Su5C5D7k9GIVJ5ArgYVDytBKg
         XrqZfFgN4TmceQf0ItWeeijKKHWFq6Xkb+TWoajnT9kf+wDitGr0uDyMRxdWTk2fER4E
         Gp3w==
X-Forwarded-Encrypted: i=1; AJvYcCWdVn46Dj96v07ZrsDClVIaXKLSEfL8zb0TYJl4et1TygJVT0i2maJRSMnXZlnwPr44rGADYVByPkqaznlxfoOOHXu/cVRsTH6yzra3
X-Gm-Message-State: AOJu0YydfAMz/v02D00tT3H3XY5Y+D0OduNO8oU1h0znx5HRvk3hCcgS
	r9UOzeUOSLrdXgTFJLLLG6L/0/odg2OAsb64n+cNIyBm/YOsBDJ12ZRK7A5O9mg=
X-Google-Smtp-Source: AGHT+IFPLWd/fepjGkb60/ZFbc7sxCgg692Z+BCDRyWFZUyjJCwWhlOXF6oUhAX4lRUmpKzcAhVS9g==
X-Received: by 2002:a17:906:488f:b0:a52:700d:818e with SMTP id v15-20020a170906488f00b00a52700d818emr1132855ejq.13.1713524513758;
        Fri, 19 Apr 2024 04:01:53 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id hx20-20020a170906847400b00a529aeb4eccsm2091354ejc.140.2024.04.19.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:01:53 -0700 (PDT)
Date: Fri, 19 Apr 2024 13:01:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Pu Lehui <pulehui@huaweicloud.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: clarify what some RISCV_ISA* config options do
Message-ID: <20240419-ea2b867f6bde90e711464c95@orel>
References: <20240418-stable-railway-7cce07e1e440@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418-stable-railway-7cce07e1e440@spud>

On Thu, Apr 18, 2024 at 03:21:01PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> During some discussion on IRC yesterday and on Pu's bpf patch [1]
> I noticed that these RISCV_ISA* Kconfig options are not really clear
> about their implications. Many of these options have no impact on what
> userspace is allowed to do, for example an application can use Zbb
> regardless of whether or not the kernel does. Change the help text to
> try and clarify whether or not an option affects just the kernel, or
> also userspace. None of these options actually control whether or not an
> extension is detected dynamically as that's done regardless of Kconfig
> options, so drop any text that implies the option is required for
> dynamic detection, rewording them as "do x when y is detected".
> 
> Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Vector copy-paste-o fixed, correct spelling of optimisations kept.
> 
> CC: Samuel Holland <samuel.holland@sifive.com>
> CC: Pu Lehui <pulehui@huaweicloud.com>
> CC: Björn Töpel <bjorn@kernel.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6d64888134ba..c3a7793b0a7c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -503,8 +503,8 @@ config RISCV_ISA_SVNAPOT
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> -	  time and enable its usage.
> +	  Add support for the Svnapot ISA-extension when it is detected by
> +	  the kernel at boot.

I'm not sure we need the 'by the kernel', since I guess that's implied by
being in a Kconfig help text, but either way is fine by me.

>  
>  	  The Svnapot extension is used to mark contiguous PTEs as a range
>  	  of contiguous virtual-to-physical translations for a naturally
> @@ -522,9 +522,9 @@ config RISCV_ISA_SVPBMT
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	   Adds support to dynamically detect the presence of the Svpbmt
> -	   ISA-extension (Supervisor-mode: page-based memory types) and
> -	   enable its usage.
> +	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> +	   page-based memory types) when it is detected by the kernel at
> +	   boot.

Same 'by the kernel' drop suggestion.

>  
>  	   The memory type for a page contains a combination of attributes
>  	   that indicate the cacheability, idempotency, and ordering
> @@ -543,14 +543,15 @@ config TOOLCHAIN_HAS_V
>  	depends on AS_HAS_OPTION_ARCH
>  
>  config RISCV_ISA_V
> -	bool "VECTOR extension support"
> +	bool "Vector extension support"
>  	depends on TOOLCHAIN_HAS_V
>  	depends on FPU
>  	select DYNAMIC_SIGFRAME
>  	default y
>  	help
>  	  Say N here if you want to disable all vector related procedure
> -	  in the kernel.
> +	  in the kernel. Without this option enabled, neither the kernel nor
> +	  userspace may use vector.
>  
>  	  If you don't know what to do here, say Y.
>  
> @@ -608,8 +609,8 @@ config RISCV_ISA_ZBB
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	   Adds support to dynamically detect the presence of the ZBB
> -	   extension (basic bit manipulation) and enable its usage.
> +	   Add support for enabling optimisations in the kernel when the
> +	   Zbb extension is detected at boot.
>  
>  	   The Zbb extension provides instructions to accelerate a number
>  	   of bit-specific operations (count bit population, sign extending,
> @@ -625,9 +626,9 @@ config RISCV_ISA_ZICBOM
>  	select RISCV_DMA_NONCOHERENT
>  	select DMA_DIRECT_REMAP
>  	help
> -	   Adds support to dynamically detect the presence of the ZICBOM
> -	   extension (Cache Block Management Operations) and enable its
> -	   usage.
> +	   Add support for the Zicbom extension (Cache Block Management
> +	   Operations) and enable its use in the kernel when it is detected
> +	   at boot.
>  
>  	   The Zicbom extension can be used to handle for example
>  	   non-coherent DMA support on devices that need it.
> @@ -686,7 +687,8 @@ config FPU
>  	default y
>  	help
>  	  Say N here if you want to disable all floating-point related procedure
> -	  in the kernel.
> +	  in the kernel. Without this option enabled, neither the kernel nor
> +	  userspace may use floating-point procedures.
>  
>  	  If you don't know what to do here, say Y.
>

Zicboz could also use some clarification, right? Or is the fact that
RISCV_ISA_ZICBOZ enables the use in both the kernel and userspace the
reason "Enable the use of the Zicboz extension (cbo.zero instruction)
when available." looks sufficient? Maybe Zicboz should follow the
"Say N here if..." pattern of V and FPU?

Thanks,
drew

