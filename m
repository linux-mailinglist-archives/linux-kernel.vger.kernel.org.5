Return-Path: <linux-kernel+bounces-101214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42387A416
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC09A28219F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15A1B819;
	Wed, 13 Mar 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hkHXR9nF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C31B7F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318376; cv=none; b=di/exep01b+5QLMs5nxa4fjMHDVRJMfN0Xfovz2hGzs9JlO4uZJSdCaejRIzVO6Uy5N2/mNOVloO4GP4WlrOxBJNBwNNCYeJSfLZHHsJvXOfpCTOcAek6lYuNF8UBejGXL4Xk9UK8law0uKvqlq9LdpYw+vKHBBxgDoIkEQOAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318376; c=relaxed/simple;
	bh=s6ezIv9XOh2FoSZX6uyY6j/aZ2J5gY30ndJwxx0zGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9ybvch0jgEPkFh49RHRBjtUP9fGjCbGnCqKw8oVBqb3aEFcXz934AKV23s3MnNw2M8VS/wYq4T6NBzqyhPV8F6PQM7JVRJWKaLe3kf/bozjb8CTiTya2fn0G6lRwrNTBpF71GPtk8wHX15lEfBa+h62lvgvoi9eK0BekW/rhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hkHXR9nF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a466381b411so9360866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710318373; x=1710923173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hri4+azNxswF/lCLy2l2dIDWQtsRG26PT3v1sxIitRA=;
        b=hkHXR9nFHulPAXxEjSH8n0TnAS+rZIG95/ZlKRfWIxErJvNKw0KEZCOOSIbFsJN8ys
         ro11hVYfaztHyELPTZ8qmZZmSo4bKpAsX8y1OEJOkkY+lyMDapEdM6v5+5LY/b4XkebO
         9Rem1AaeQ2gqfocz2BNf1xEKU1GNViP5hCIo2D02dQZIrsrePKV7wkivxKabey5uw9Pe
         7aoND3s1oN5HOCWZMLQTp3kGiDAYV1mlW6MIKci/WviTBnxl0BKTv6uNZx49DpRpTrRR
         pRUnXFXgG3FQGcuxspBXQ2+sKz621Y4huKbD6694Pw6UL/uVq6NzIJlCZu5/waFVjnVQ
         PuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710318373; x=1710923173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hri4+azNxswF/lCLy2l2dIDWQtsRG26PT3v1sxIitRA=;
        b=XvoKzQfOhREvP5w5CRONi5En01AD+mCtIxk+HzPmGCej5zPh8ScxVRu/P9ZMrKwsBG
         ppUb460SlzFi6TxXPvybab0G6TdTy2lIGetMzVz66zL3nn+U+Wiz4dn8yfpAg58jVtdH
         gTX3j96km/9ZoLgSMPhPLkL/TI5nMBxinPnvoF/uBFx4AKqvLscWGJYKJPac+j59E8Yc
         isl7bMC6nkfEYqpOqFRuzslybjf0uiwFH7vqtqnqtd8bgoxNXDkpkS9vU13lRAxEpnpa
         D3ST4v8DgysV4fdfGKIR6EAPRPEeQTKmwk5Gp8n/0fx8aV9/eEug4Gr9/ed4jmQ3TZIq
         Bp9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlj2aGxIiZ0G7YLxFlW4Qn5cpM3zhj9f6oNJd9XZ+ujF526L4qBSS5zUdEnSb+mxf/LbDEUDCYhDgVNwNLWjQKPquf2dM7F94kI+Gq
X-Gm-Message-State: AOJu0YxEsuh7CruxoChRqJc6FjLWN6vGRFkRmQBwTn9iM9LKcnZ6A7zf
	5AMGe0ftvBPObNj7OUlEUeU/+XQLYqUc0G3UruQayKTNcZ6R1xUKkok7qK/6Lbs=
X-Google-Smtp-Source: AGHT+IHtxiEmmNAi5sUeGu3QBF2Eg4/lY2B9EQqXkzMSK0yhddDBx1+t4mL7MGc44NoiNyNet13ZOw==
X-Received: by 2002:a17:906:bf4a:b0:a45:bf67:bab2 with SMTP id ps10-20020a170906bf4a00b00a45bf67bab2mr8170186ejb.59.1710318373006;
        Wed, 13 Mar 2024 01:26:13 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id gq14-20020a170906e24e00b00a3d2d81daafsm4686757ejb.172.2024.03.13.01.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:26:11 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:26:10 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Add tracepoints for SBI calls and returns
Message-ID: <20240313-d0cf274ace35c0f54c66f7fa@orel>
References: <20240312212441.2322765-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312212441.2322765-1-samuel.holland@sifive.com>

On Tue, Mar 12, 2024 at 02:23:34PM -0700, Samuel Holland wrote:
> These are useful for measuring the latency of SBI calls. The SBI HSM
> extension is excluded because those functions are called from contexts
> such as cpuidle where instrumentation is not allowed.

Thanks for this. These will be nice to have.

> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/include/asm/trace.h | 60 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/sbi.c        |  7 ++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 arch/riscv/include/asm/trace.h
> 
> diff --git a/arch/riscv/include/asm/trace.h b/arch/riscv/include/asm/trace.h
> new file mode 100644
> index 000000000000..f96091f83c25
> --- /dev/null
> +++ b/arch/riscv/include/asm/trace.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM riscv
> +
> +#if !defined(_TRACE_RISCV_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RISCV_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT_CONDITION(sbi_call,
> +
> +	TP_PROTO(int ext, int fid),
> +
> +	TP_ARGS(ext, fid),
> +
> +	TP_CONDITION(ext != SBI_EXT_HSM),

nit: Can we remove the three blank lines above?

TRACE_EVENT_CONDITION(sbi_call,
     TP_PROTO(int ext, int fid),
     TP_ARGS(ext, fid),
     TP_CONDITION(ext != SBI_EXT_HSM),

> +
> +	TP_STRUCT__entry(
> +		__field(int, ext)
> +		__field(int, fid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ext = ext;
> +		__entry->fid = fid;
> +	),
> +
> +	TP_printk("ext=0x%x fid=%d", __entry->ext, __entry->fid)
> +);
> +
> +TRACE_EVENT_CONDITION(sbi_return,
> +
> +	TP_PROTO(int ext, long error, long value),
> +
> +	TP_ARGS(ext, error, value),
> +
> +	TP_CONDITION(ext != SBI_EXT_HSM),

Same nit as above.

> +
> +	TP_STRUCT__entry(
> +		__field(long, error)
> +		__field(long, value)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->error = error;
> +		__entry->value = value;
> +	),
> +
> +	TP_printk("error=%ld value=0x%lx", __entry->error, __entry->value)
> +);
> +
> +#endif /* _TRACE_RISCV_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH asm
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index e66e0999a800..a1d21d8f5293 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -14,6 +14,9 @@
>  #include <asm/smp.h>
>  #include <asm/tlbflush.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <asm/trace.h>
> +
>  /* default SBI version is 0.1 */
>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
> @@ -31,6 +34,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  {
>  	struct sbiret ret;
>  
> +	trace_sbi_call(ext, fid);
> +
>  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
>  	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
>  	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> @@ -46,6 +51,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  	ret.error = a0;
>  	ret.value = a1;
>  
> +	trace_sbi_return(ext, ret.error, ret.value);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(sbi_ecall);
> -- 
> 2.43.1
>

Other than the blank line nits,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

