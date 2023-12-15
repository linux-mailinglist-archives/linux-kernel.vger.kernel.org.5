Return-Path: <linux-kernel+bounces-1767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E052A8153B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E82286BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C645C0E;
	Fri, 15 Dec 2023 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eGskcSB/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6C3FE58
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35d3846fac9so4441835ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702679664; x=1703284464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSrXYwHfJZ+IcxeBuu1Bbb4/ovX7+ju+MTg9H3SUSYc=;
        b=eGskcSB/6y1Iu7p6jkIzZo3iKE4pZ9Z98JxuIi51UJ+A1p5k3cv6fvc0Y17rTiHTZF
         3XzMrFeVpX5ZFhF6d5sG0HyxlzPXihopcXn6IFcxGH2NjA5GmtHtMFfEKogRhxLJIgoD
         2+/iL4oQ6QoeomJIeRzp9W/cg2xFSkXa3ihHOU33lxMBuTQJrEHd7BkSCWgRtfoI1B0R
         Hqj9rjPoMMVe+A2eMWLbimiyKfPFR8rBgi81DAwEHLDRImpvYy7yGNezncJUlrqwhdQU
         0yCaKUT3VXsyzRevpNEXWMuQhFH8hRqcxyCvlDC8Rv9c0QVK8qzCJ+ysAj74RpB08DRQ
         MPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702679664; x=1703284464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSrXYwHfJZ+IcxeBuu1Bbb4/ovX7+ju+MTg9H3SUSYc=;
        b=bF3Y91YRW5aIlN6sMLdKxNdCHW6rXOELlx9Ws848gaNPiefFjgelyyYHKPMPlzgdht
         TCSUDdVqkffe3v8G+9RKbhqd+4tiFkWCaFraJTbDUsFylP4NhnWa8GaDCEa08KU+HQmn
         8UT5ZC93NEOpog4yuzErIqvrc9hxlNHEbjpGCLxVKxuJ0LQaVbq63IfXNVmJ2XT/Cqs6
         PBvqOOcj+pHgK7tyb0mw0H1gv3aodsn5hP838H1cVzpXJaSU2yk1iIPQc09xKu8S56kW
         kiGB1GjgeA2fXLXcrWy18AOpBdL4FMAdidpWm4AJqno/91M+jonFwpTi0NjObWHo1GpP
         a1PQ==
X-Gm-Message-State: AOJu0YzBe9YHRjfJKp9l+/GwJkcSkSehMKSqsQvhS0otMKmiO7CQC7Yi
	oNF5r5QaphZYwzZkS/YPMyB+Pw==
X-Google-Smtp-Source: AGHT+IFtx84X6gNszU4kSOLh8mxXgB8OVmieQxRy1pgvQE4NY6CM1WiqREAIvEllICpeAQSqQtttGQ==
X-Received: by 2002:a05:6e02:180c:b0:35f:7585:e322 with SMTP id a12-20020a056e02180c00b0035f7585e322mr7344225ilv.56.1702679664016;
        Fri, 15 Dec 2023 14:34:24 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id l2-20020a6542c2000000b005c621e0de25sm11916724pgp.71.2023.12.15.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 14:34:23 -0800 (PST)
Date: Fri, 15 Dec 2023 14:34:21 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zong.li@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2] riscv: Check if the code to patch lies in the
 exit section
Message-ID: <ZXzUbRSQYUmHHh1V@ghost>
References: <20231214091926.203439-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214091926.203439-1-alexghiti@rivosinc.com>

On Thu, Dec 14, 2023 at 10:19:26AM +0100, Alexandre Ghiti wrote:
> Otherwise we fall through to vmalloc_to_page() which panics since the
> address does not lie in the vmalloc region.
> 
> Fixes: 043cb41a85de ("riscv: introduce interfaces to patch kernel code")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> Changes in v2:
> - Fix XIP rv32 build failure
> 
>  arch/riscv/include/asm/sections.h   |  1 +
>  arch/riscv/kernel/patch.c           | 11 ++++++++++-
>  arch/riscv/kernel/vmlinux-xip.lds.S |  2 ++
>  arch/riscv/kernel/vmlinux.lds.S     |  2 ++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> index 32336e8a17cb..a393d5035c54 100644
> --- a/arch/riscv/include/asm/sections.h
> +++ b/arch/riscv/include/asm/sections.h
> @@ -13,6 +13,7 @@ extern char _start_kernel[];
>  extern char __init_data_begin[], __init_data_end[];
>  extern char __init_text_begin[], __init_text_end[];
>  extern char __alt_start[], __alt_end[];
> +extern char __exittext_begin[], __exittext_end[];
>  
>  static inline bool is_va_kernel_text(uintptr_t va)
>  {
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 13ee7bf589a1..37e87fdcf6a0 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -14,6 +14,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/ftrace.h>
>  #include <asm/patch.h>
> +#include <asm/sections.h>
>  
>  struct patch_insn {
>  	void *addr;
> @@ -25,6 +26,14 @@ struct patch_insn {
>  int riscv_patch_in_stop_machine = false;
>  
>  #ifdef CONFIG_MMU
> +
> +static inline bool is_kernel_exittext(uintptr_t addr)
> +{
> +	return system_state < SYSTEM_RUNNING &&
> +		addr >= (uintptr_t)__exittext_begin &&
> +		addr < (uintptr_t)__exittext_end;
> +}
> +
>  /*
>   * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
>   * reg-a0) or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
> @@ -35,7 +44,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
>  	uintptr_t uintaddr = (uintptr_t) addr;
>  	struct page *page;
>  
> -	if (core_kernel_text(uintaddr))
> +	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr))
>  		page = phys_to_page(__pa_symbol(addr));
>  	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
>  		page = vmalloc_to_page(addr);
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> index 50767647fbc6..8c3daa1b0531 100644
> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -29,10 +29,12 @@ SECTIONS
>  	HEAD_TEXT_SECTION
>  	INIT_TEXT_SECTION(PAGE_SIZE)
>  	/* we have to discard exit text and such at runtime, not link time */
> +	__exittext_begin = .;
>  	.exit.text :
>  	{
>  		EXIT_TEXT
>  	}
> +	__exittext_end = .;
>  
>  	.text : {
>  		_text = .;
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 492dd4b8f3d6..002ca58dd998 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -69,10 +69,12 @@ SECTIONS
>  		__soc_builtin_dtb_table_end = .;
>  	}
>  	/* we have to discard exit text and such at runtime, not link time */
> +	__exittext_begin = .;
>  	.exit.text :
>  	{
>  		EXIT_TEXT
>  	}
> +	__exittext_end = .;
>  
>  	__init_text_end = .;
>  	. = ALIGN(SECTION_ALIGN);
> -- 
> 2.39.2

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

