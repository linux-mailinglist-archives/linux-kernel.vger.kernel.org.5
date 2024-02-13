Return-Path: <linux-kernel+bounces-63713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A185338A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C21B216FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4058122;
	Tue, 13 Feb 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RV7VSI1j"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0858105
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835758; cv=none; b=A6ItQ97Zd5FQyf7NOJ2IqRNG/pi9kVKJMuiq2f24ERK0kJ+fwOUfF9LqzRSFvApQOmp4ZhP8NTJ6jE0LV5qwHVfJFZtoO7N5+Dl1u7lwiyMmETPXa+babBrt/u2P0LO7cG24XjgFtCkod+saLm6SIUaFvCBMdKQ/gRXUb4u936k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835758; c=relaxed/simple;
	bh=FHSmpYdfwyE3kP9dlHAFbDIzGEDZA8QZLlp/HuYFx1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSCOBiQA7tn7LE3euEHnPMc2iTQVUASasl71cN6o4kWZHPxwfqrVhntNx0kdwpD95DidVA9KURYa5gT6bmcpBJRLSk4pr0f5PhniCpb06E/wAzaWf6sJjWusfJddqZswylkVM4I9RUkNGHid7ky0LVvRkTF5P9cGrg/OXP2ZztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RV7VSI1j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411a6ada28dso7073465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707835755; x=1708440555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXJQUoDdwS+iTPfnGRrbEe+K9eyw1etfn33Hywo3Ilo=;
        b=RV7VSI1jcf4ooimpreD+4B/rv3r/wI6QJf1V8gq+2DZ7seNWPlbQ0a3yFg/JpIXxQ/
         krUUyvqt/SMA0+MZdPDLbUFNH+zM4dLDRseeDtr4m/PV6TFhC4S+1RMM4sdDGqq9p5A4
         J/nySjIofPJp1UyI533/wFPuBqq7lmBXEKGdXiOtXH50qWCgq1q3amKvrIGHfTYipsVz
         6hgYkPuibVElNS0XjpPgWJLSG8cYjtpCCxhB2yPf6La6lhysiFbYae+znUw2bJtg7nDF
         opY96WWGBBOnY7zkuaMeJxGxlzHoW9ygCbmv6BaaO4obcOzwpgwHZMyhAORPhHYcmtPo
         sSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835755; x=1708440555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXJQUoDdwS+iTPfnGRrbEe+K9eyw1etfn33Hywo3Ilo=;
        b=FN8bKRq55JtkJiZmPvbThg9YB04n63keQZbnSY8Nd1REiBMrT9m4kQkt5VtCoVUEos
         wGmP0amTvLu6MPwzY2io+Sz2LjhXxgmdCCONbklGCeBydw3KeN9vhNtle63hUJRhcBow
         JUAXZe/Mv6iMRmmrleMqS+1GkqeGXclP84syuZ9o5k+hVvhBcPTlhkev5LIuydvFpbp/
         9Dzgpl22Szbs8ZfNq8m6Q94cLUYUSXQeeSBPANQJAW7Nn4wxd8ak9Aa/J4L+2R8wvA1X
         4UzFaaAbp5gSDpXnurlWxUvb8BJV1AqcfER5atdnij0fYy2pQnY3xLzscoI6Y4BP+WnO
         hF8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJdg+2kWHe6Pf/J1CkUz1Gt4dPgmQISMgqZSxy3zDvzEvS7KldoMrSWgt1k7uKojZ/jqG+M2BTUmGF9DWs/MZLDdlrTdglbx1qPF0I
X-Gm-Message-State: AOJu0YyglcK/7x0h+WGWPnfWjdj00Ck5kl170xZVsOa20KoSa3G+dw0d
	n0jo2OzTqavG5hTQfLFb4fg6PXyh1CWs/CDpkWrs6HCmJLS4RPpxutDl3Swa/cQ=
X-Google-Smtp-Source: AGHT+IG9C7SAShtPGr5zsMTscSXEtgpO3XA5ia8oUuLsEgFn9vYz7E19Z3TxoVMOdiJ8hl68kJVMhw==
X-Received: by 2002:a5d:5750:0:b0:33c:e2d7:79d1 with SMTP id q16-20020a5d5750000000b0033ce2d779d1mr380838wrw.69.1707835754661;
        Tue, 13 Feb 2024 06:49:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVH748q7wAhr5L6ObVJfyI8Pj0jD0Qb1kE812vewtgBqH/Np1Ym/ZVQ03YOT45fC1GJU25rvnQodmlyht86tbJ9rYLpL2NVZz6PfZPX/bWXatoHnCeudMvTH3l+gIr05rjZ8Kmh4mvlp/hDHuKr8yrYKrbf6tqjIUN8ODuV82PBcqBgMXFP/fpd/a0UdAw9zpc/Sm5f2m8/IL2P
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b0033929310ae4sm9749747wrv.73.2024.02.13.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:49:14 -0800 (PST)
Date: Tue, 13 Feb 2024 15:49:13 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 4/4] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240213-86af3b49821630b5bdd76c0a@orel>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213033744.4069020-5-samuel.holland@sifive.com>

On Mon, Feb 12, 2024 at 07:37:35PM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
> 
> Cc: <stable@vger.kernel.org> # v6.7+
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
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
> index 239509367e42..be03615486ed 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -15,6 +15,8 @@
>  void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
> +		context->envcfg = csr_read(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> @@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
> +		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> -- 
> 2.43.0
>

We're still exposing Zicboz to userspace in hwprobe when only
RISCV_ISA_EXT_ZICBOZ is present, which will be the case for anything that
either doesn't implement 1.12, but does implement Zicboz, or maybe does
implement 1.12, but hasn't started putting Ss1p12 in its ISA string yet
(e.g. QEMU). We should either stop exposing Zicboz to userspace in those
cases (since it won't work) or rethink how we want to determine whether
or not we have envcfg CSRs.

Thanks,
drew

