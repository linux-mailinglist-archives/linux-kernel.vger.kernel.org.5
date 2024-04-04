Return-Path: <linux-kernel+bounces-131292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1C8985C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9AC1F26178
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0D8286B;
	Thu,  4 Apr 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ljr/OXND"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8280C09
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228897; cv=none; b=sCYFc/BBDIQz0zjSQfioX1bunqMAXa6pcZbD4OpXneVM4AwbzvVtNMlV1XOLhpsHVcQGlcZpD3eN9Fyh6dgTneIaFk6ZHzDOuGY7vDA74U1GaIQwekDY1RO1SpCA1kJGerhVV3XuEwzmXuLABWScUX8mOi9vAyq2HaIpIuIXlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228897; c=relaxed/simple;
	bh=b9wRAhDeshh10P0TwW9VE8z5e9tGLWnK8X6agCj/Bog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmpgmUQeWcULepfKb9YO5qK2zJgI23AnkND/6gDwM6WE+j/ZLRqBDKWgmnGZ9Glcr27slw89SircLOaMXZYqnR9QXQnREjzykta+6DBY3qR7Se1YC1xHFMeLXfebD9slEa+O61DxXmcs4bvaznFGx1tsB8jszpNKfZifKZ+7YGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ljr/OXND; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso1274904a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228893; x=1712833693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHYX+6wGVMHeamknM7Pg3k7ckv45aX0Tuc02oE5EGZo=;
        b=Ljr/OXNDGzjYOiaQxhA+bampXnP/a0zzgX8djTEcpnYD5MMa8TCllY0+SuaGIef6jC
         5Dh5qxge8IqQ1hA+WwGIZ9dhlzwLwM/AIPeuSEniF+HwnPCJWITHvN+Zz6Og6eWxa9k3
         opMoPwdF14N8oSJXDrztnyACRIWz9i/GLLbzn1kCY9SfV1qpFlqFFUI69z4fkApErNOy
         SlTNj57frpvFIF2ayzph9yNevGe/CUqaQVBYxVk+Yi++jbb3IZxLpXmPkatcOsYIVLa7
         Pi0vUHxCtVOtH7wegMrfckbOU9i9LkzCYmDAc3I6Of9bQAtvKamm5XOxpMXV5CBZmuGn
         cP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228893; x=1712833693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHYX+6wGVMHeamknM7Pg3k7ckv45aX0Tuc02oE5EGZo=;
        b=RaXCK23nzia0zym+W1TzUE5aoxurd0eR/mzpGYZPqBs9oxfXBj7qfrxO/HtKZjY3Ph
         Xki53AvzaoY8Z96HkA2RkBCTy8WGh9I4m5YtGG1YRE+VxbLrKMHYIjWatPIs7YeyOIoD
         c6uNoNolbBWCQWdumOLoUsxG/IUduJYfBJbaG4aoS8ScPgD16bbWDOoqmgVgnsvluuAd
         i7TR9tBSHsqrh4wcjFv0uGu/aRolXm9Swb2we9doUwxizsPhfftziOccFJfRKgJDo075
         WvLi+GE4R/DTi8kgbGgU0zYXEgiAlQOia0VWOFNfe3F/BFubiaggT6nGXvQsWjxbm+eU
         VBZA==
X-Gm-Message-State: AOJu0Ywjn5nEJpxwn1d5oc16/KHERdyNITDj1zqCNT9vXznHt8FUWMgt
	VeShnddktC3nM1HG6sdMHpRvozkcq9Qdl1y/MImo2gdvH2vtl5e2Z1pr2tlM9iA=
X-Google-Smtp-Source: AGHT+IEwWasdhwJaS9vUXUMAlSdyN0d8CLHZIu2tQiTvCmJ1aDUIwnQzoZygayQdRyXB/log4Zvjmw==
X-Received: by 2002:a17:906:a02:b0:a4e:2d69:e379 with SMTP id w2-20020a1709060a0200b00a4e2d69e379mr1481920ejf.4.1712228893383;
        Thu, 04 Apr 2024 04:08:13 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id xh12-20020a170906da8c00b00a4e579ce949sm6017903ejb.51.2024.04.04.04.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:08:12 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:08:11 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 04/22] drivers/perf: riscv: Use BIT macro for shifting
 operations
Message-ID: <20240404-9a84f2090d00f6b994e1de7c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-5-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-5-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:33AM -0700, Atish Patra wrote:
> It is a good practice to use BIT() instead of (1UL << x).

(1UL << x) isn't generally a problem. The problem is with (1 << x).

> Replace the current usages with BIT().
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
>  drivers/perf/riscv_pmu_sbi.c |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index ef8311dafb91..4afa2cd01bae 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
>  #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
>  
>  /* Flags defined for config matching function */
> -#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
> -#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
> -#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
> -#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
> -#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
> -#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
> -#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
> -#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
> +#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
> +#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
> +#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
>  
>  /* Flags defined for counter start function */
> -#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
>  
>  /* Flags defined for counter stop function */
> -#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_RESET BIT(0)
>  
>  enum sbi_ext_dbcn_fid {
>  	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index babf1b9a4dbe..a83ae82301e3 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  			cmask = 1;
>  		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
>  			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> -			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
> +			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
>  		}
>  	}
>  
> -- 
> 2.34.1
>

Other than the commit message,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

