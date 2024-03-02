Return-Path: <linux-kernel+bounces-89343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA286EF2A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DCAB23EEF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E12125AC;
	Sat,  2 Mar 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dQF1fnFC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDA8479
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364915; cv=none; b=bgaZkSqB/WI+GUNBIADbzulFpvSUaEmZTZlN++9VKMpG38g7ep7/kqCfRNvYFI75M+tpfsHvtDNCIv9ZzGC8/AQd+INKhjZJCeHIbHzwbWV2hbhmRSnmxkzp08iCk7VXumxiyVWgTb4SrINf459h3oQCjmTy1JgXefJm0ztb8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364915; c=relaxed/simple;
	bh=9RsFIsdj7Go63hLLcVGb1lWnHU7y1xrBgOTr1PK/ZMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fkh5eLeRdkpvzyRuY0Z/hgzmsWGD+REeT2r4rE3UMCKUfITEfAx/Kn+tgRNvbA/mONbRvgR9/8XwQwv7e/ZDdlTZau19tx9GVHu+PZqSA6FaygbyHzUxsLztAlwUjHPqgrUCiS7k2khFAJpO/5grMjl1RfZXfBYDEpi2hQ/3uYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dQF1fnFC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412cc617b68so6412545e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 23:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709364912; x=1709969712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVIp+bkmfXEEH5Z3CqG36argyLkv9jlPldmOAvVHXfk=;
        b=dQF1fnFCHjKIWAm4Jvg5DN+77ZJciqfa8E/cDq2XX0qXue9OEFmDK7rPNdV5XvKJjC
         7KRZ3DFaQ9Xq8jooWk+GR+B5Y6CZAqUivknPSpx2KzDsi39gcrx/Xx0PQJ2mor/to4xH
         cC6kxJMiYJNiGjXHFllPHXpFSQpz6VGJ7IiL+bfWxVmlq43jUyHcuORypu7/Hm8p/q5B
         Y+V7eLKjAlEPRT/8NanO4zOTZCIkuAN01sGELDhKca5cC7kYfcZbt2oHfkIevV+giVTw
         jPtzJWswLakPPvU/4b/Xc2JjH6NTQ49CV6WvHD2Is54EWlfBwLydC2NjRcE3xfjr6NVy
         cAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709364912; x=1709969712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVIp+bkmfXEEH5Z3CqG36argyLkv9jlPldmOAvVHXfk=;
        b=l9ye73lxm7ahaf91X2gQTNqXhHVGjv1ypwEzOHwzEhQDE6u2DFW5PzlCwKQt0so603
         DoBeElTBQW/UK2fpVVYz8z430lEnXokaD7yXr7Q02tzRwVidShx+vmkkaVMQdI87UhRu
         xjWKmxRRQ2AOw0S4UnpVwuIEBP6XSHl2gDBqLirxfafWWcJCPzgGL4eC5ENjcoIC1YAX
         CWD6eBO5gUfLcgJYSwcLWgNeLbVm5AIPiHvsqTKUgzAfWEo4x6P3V6fpUivCdD7HeiCy
         DkNnpSNwk2AQAGCniEwAIwBMSB4O4nsNLgrkicinALa8yxu5IL3zInVsiXv3a3oKR2VM
         Zvpg==
X-Forwarded-Encrypted: i=1; AJvYcCX6dNnYQJAGFrB5YyRj3LL5SFDJaSq1IVc+W5UzbvNirUAXMJMjOe1suVf5lpWzO79DSaSUEeGuFvOeqo8qjs7wcYwKMOuwWZi3mSQl
X-Gm-Message-State: AOJu0YzFeMlOuDCFyEE6VrRX0m1/jBwB1ffXOkgrsqFjy4G7I7mNR7Y0
	4ye8/IqSOK3jbjhDI95F5CJcWMlaaNdltwanTVO8E2+sbpHox7Wz7gO+O69Gtoc=
X-Google-Smtp-Source: AGHT+IE5p/dElV8MPvX5Z+KxId+N7DYaOhQnGAen5y2yV1ICqZ5gVRXXzuefdWRfCisV+ymJmgjFfw==
X-Received: by 2002:a05:600c:35cd:b0:412:989a:f6f5 with SMTP id r13-20020a05600c35cd00b00412989af6f5mr3420946wmq.38.1709364912110;
        Fri, 01 Mar 2024 23:35:12 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b0040fdf5e6d40sm7942900wmf.20.2024.03.01.23.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:35:11 -0800 (PST)
Date: Sat, 2 Mar 2024 08:35:10 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Dylan Jhong <dylan@andestech.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Sergey Matyukevich <sergey.matyukevich@syntacore.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: Fix prototype to avoid discarding const
Message-ID: <20240302-84b126d91dac9f73f5efebaa@orel>
References: <20240301201837.2826172-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301201837.2826172-1-samuel.holland@sifive.com>

On Fri, Mar 01, 2024 at 12:18:32PM -0800, Samuel Holland wrote:
> __flush_tlb_range() does not modify the provided cpumask, so its cmask
> parameter can be pointer-to-const. This avoids the unsafe cast of
> cpu_online_mask.
> 
> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/mm/tlbflush.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 893566e004b7..07d743f87b3f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -99,7 +99,7 @@ static void __ipi_flush_tlb_range_asid(void *info)
>  	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
>  }
>  
> -static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
> +static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
>  			      unsigned long start, unsigned long size,
>  			      unsigned long stride)
>  {
> @@ -200,7 +200,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
> +	__flush_tlb_range(cpu_online_mask, FLUSH_TLB_NO_ASID,
>  			  start, end - start, PAGE_SIZE);
>  }
>  
> -- 
> 2.43.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

