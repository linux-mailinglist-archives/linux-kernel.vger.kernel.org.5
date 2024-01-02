Return-Path: <linux-kernel+bounces-14280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC04821ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890651C21DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F2DF61;
	Tue,  2 Jan 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nf1h6vwx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DEDF53
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a27cc46d40bso204371966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704194335; x=1704799135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDW+u+a15ExUx3Vc0dt3K0IdM4f8o7iazZ5ZQ68mxqM=;
        b=nf1h6vwxtTSwIuMRidf/4hwD6q6/thNcYHQUjYpMfeAQeOm/kdGRY7dm6WW/TEga5S
         iaSnhDPljrLe97Bu/EEWPEZe0Rw/D9pMYKnsyHYQXJQOY0hsZjbpMOoEM3+j3TM7jizI
         96o3/tE8VXDN4ZjH4k0assIS5S4seGHmPdXt2jSaSUkCylSlXgfdwZe8XfYkid5ADaNH
         oQ4QqAX64eypsl9bgSEkDXEl8YFlyu4ISGFnmUVCNfnEiw56jdoy1e5NA1dPZaKbkzRG
         j5sXg+JKuU45ZiaVWAoFv/eNoTx+P0z4RouOMz5buebMQyugCUSViGkJ9UybkUu145bd
         qjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194335; x=1704799135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDW+u+a15ExUx3Vc0dt3K0IdM4f8o7iazZ5ZQ68mxqM=;
        b=VUTCj4tOHw6343zgnA+Ar0coA6PjFT8COhMailWfm7uyGvFUJwJbP62yK4admWuTfF
         Ve4zlv3E09xe1LmabfwAeJGNSncFjU++TKZ2gx2dMyjE4ccSyjqGmAlsEDg/FxdtgmsK
         pIJ1DB/LC6vjXWreeVZaTR7hZuthctkbhZ4KrCn0kKk0Dw6q7ee3aiuJtZ7sPiZO0gQ2
         nIqOPxx4d1a8F/YprI60JQB7hEW/9BKwMnnu1ETM/vv5cRH0ONiBY7JtKwWv/EyKPl7Y
         bedCT00syHbxNNNBSUKS3zlQFOjOPtS4SabQgnrM7up65pWSWiV+IROCvzZTBy90y3fx
         NtpA==
X-Gm-Message-State: AOJu0YzSSxgGpdZV8y5edi9Oj+a3Argkh+Uc+j3++HGhYmA2tmB9GbYQ
	l5TH7WYDA2xO5Tiqf/svnMMWOOw06zssng==
X-Google-Smtp-Source: AGHT+IFBhJg0nvf63SW4dKofH6YheDdq61fVDoG8wzwL4ptYI5pLENo1amuLwxoT29fRt30e4xkXCg==
X-Received: by 2002:a17:906:3602:b0:a28:71c4:e246 with SMTP id q2-20020a170906360200b00a2871c4e246mr19162ejb.96.1704194335418;
        Tue, 02 Jan 2024 03:18:55 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709060f4f00b00a26e1122762sm8754870ejj.192.2024.01.02.03.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:18:54 -0800 (PST)
Date: Tue, 2 Jan 2024 12:18:53 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 3/3] riscv: xchg: Prefetch the destination word for
 sc.w
Message-ID: <20240102-81391283df04c430d76c0eb0@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-4-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231082955.16516-4-guoren@kernel.org>

On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The cost of changing a cacheline from shared to exclusive state can be
> significant, especially when this is triggered by an exclusive store,
> since it may result in having to retry the transaction.
> 
> This patch makes use of prefetch.w to prefetch cachelines for write
> prior to lr/sc loops when using the xchg_small atomic routine.
> 
> This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics:
> prefetch the destination word for write prior to stxr").
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 26cea2395aae..d7b9d7951f08 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -10,6 +10,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/fence.h>
> +#include <asm/processor.h>
>  
>  #define __arch_xchg_masked(prepend, append, r, p, n)			\

Are you sure this is based on v6.7-rc7? Because I don't see this macro.

>  ({									\
> @@ -23,6 +24,7 @@
>  									\
>  	__asm__ __volatile__ (						\
>  	       prepend							\
> +	       PREFETCHW_ASM(%5)					\
>  	       "0:	lr.w %0, %2\n"					\
>  	       "	and  %1, %0, %z4\n"				\
>  	       "	or   %1, %1, %z3\n"				\
> @@ -30,7 +32,7 @@
>  	       "	bnez %1, 0b\n"					\
>  	       append							\
>  	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
> -	       : "rJ" (__newx), "rJ" (~__mask)				\
> +	       : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)		\

I'm pretty sure we don't want to allow the J constraint for __ptr32b.

>  	       : "memory");						\
>  									\
>  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> -- 
> 2.40.1
> 

Thanks,
drew

