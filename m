Return-Path: <linux-kernel+bounces-131354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A78986A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4F728D832
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760E83CDE;
	Thu,  4 Apr 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Z8Ey8s87"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E78529B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231972; cv=none; b=Vg5uvkIIIF8bVJg/ouJkXdZbiuXb9cSXF6mkN4VZz+dnwplIT9gjfm32JSkGE49zMYm2gE/s7DGAWoYSFFYz1d+eEIjugQ3VU+GvqwmPZcTkNJ4++0KhbJgS/wNxn/RcZsyis7Tas9l4pYFoRzRcdPvxT4wBuu7ub139Q41NsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231972; c=relaxed/simple;
	bh=nxSW99ILJeTAAzWnvq8Qa6qdd6PqAN0DvVfIObg7x60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMAG+LVZKJkx71cd+32vXNQyNRyZ8zQIfLgPaYUiGZmBkUkiQULOmfizjrT1YcaynBgPLdpYxjhb7FUMWCYLjyokUjpFp8270PR8PVowZdy8VBbQp2pCftJb7auqHv+UeHXB79gYnrCokURz6M7G0oiQ36G9jHKDsmUpULHmO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Z8Ey8s87; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516cdb21b34so701585e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231969; x=1712836769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ild2SXG8B1Be23SyJ9WWYL0M6Mm74nvXGbMkUe/DfRU=;
        b=Z8Ey8s87q+StSib2c0/12/8n+FKvidkrRiOKRjqVGKfWyhoWewPJY5kt1w9arT/rvN
         F4QAA92g9wJlhADctZRn2++NqOIAzgf9fZ+/ZJN8XmSfJCpxGBnALZlXjtAFI5hSy81P
         uhYqB/jMGOA+53XJUa+aYt6YvyBzx8/4Q1N4gsbq95RfOVuRtmyvPeT7+Kou0GFRI6C4
         s/xguxJi8gxKkK1KX/NqgjPRpY7IhJK9osLdopjP4OWWFvpq0CpBFQo6TS91lIWPtekT
         6SPc2q3l6gq8IK/G+XD1VUYaLXFfiu+OWqdquidvL4DRfgLd6QQ9My6UNQEzLE+IHOki
         MX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231969; x=1712836769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ild2SXG8B1Be23SyJ9WWYL0M6Mm74nvXGbMkUe/DfRU=;
        b=e5mUgbelyGI9ZB6QEABWt/QFKS+V9SyfI+ey1RQiGdReKFI4mLVZxq20KLTWvNbVcJ
         Ym2g8hsufGYGc6emJwWrhWX56oYGr/bTOPQ6TOHRRbOmOy1/Ggs/4boMFY+iynLDiwVd
         CyFBuG+wgrvr64kuQ5YkZeY+cb5axT3ctuvbdvm6Gx/OTaVulaKOahmxIdWj4vfRNkVF
         ANFzaj56m0wt1EOAGau8RXXqcr6V/bIjcI0PCz49EB1Iyi0TsTwdK3vuLvFcnGIQKzJc
         oJ20ua52+FRoNDbt020qJ4HrZ4aXXAORMGkwSNr4yb66Du01m5alAJMOZXZqckn2pLrz
         KSaQ==
X-Gm-Message-State: AOJu0YwDMGP9wR+J3DGvaUhG4jrKqB9PehVuGzKw+n2Un1kZRs9hqfQY
	gfsfjIoKVeK+qdP45gRsY3xh5iACGJnXU5oY19h6ZZzOHCEOnJth8LulWyePKlY=
X-Google-Smtp-Source: AGHT+IFAGisyWQneq8iAvWepxbsWTi3AIzFjCJKFoh+xvPmwn6+pBzt61Jt4NVViUJX93Fiad7cCWw==
X-Received: by 2002:a19:2d07:0:b0:515:b039:373e with SMTP id k7-20020a192d07000000b00515b039373emr1610209lfj.10.1712231968762;
        Thu, 04 Apr 2024 04:59:28 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id d23-20020a056402401700b0056c3964d078sm829519eda.68.2024.04.04.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:59:28 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:59:27 +0200
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
Subject: Re: [PATCH v5 09/22] RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE
 to a generic name
Message-ID: <20240404-8c20e3269c4648b6ef4c5e2f@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-10-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-10-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:38AM -0700, Atish Patra wrote:
> SBI_STA_SHMEM_DISABLE is a macro to invoke disable shared memory
> commands. As this can be invoked from other SBI extension context
> as well, rename it to more generic name as SBI_SHMEM_DISABLE.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h  | 2 +-
>  arch/riscv/kernel/paravirt.c  | 6 +++---
>  arch/riscv/kvm/vcpu_sbi_sta.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 9aada4b9f7b5..f31650b10899 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -277,7 +277,7 @@ struct sbi_sta_struct {
>  	u8 pad[47];
>  } __packed;
>  
> -#define SBI_STA_SHMEM_DISABLE		-1
> +#define SBI_SHMEM_DISABLE		-1
>  
>  /* SBI spec version fields */
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> index 0d6225fd3194..fa6b0339a65d 100644
> --- a/arch/riscv/kernel/paravirt.c
> +++ b/arch/riscv/kernel/paravirt.c
> @@ -62,7 +62,7 @@ static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
>  	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
>  			lo, hi, flags, 0, 0, 0);
>  	if (ret.error) {
> -		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
> +		if (lo == SBI_SHMEM_DISABLE && hi == SBI_SHMEM_DISABLE)
>  			pr_warn("Failed to disable steal-time shmem");
>  		else
>  			pr_warn("Failed to set steal-time shmem");
> @@ -84,8 +84,8 @@ static int pv_time_cpu_online(unsigned int cpu)
>  
>  static int pv_time_cpu_down_prepare(unsigned int cpu)
>  {
> -	return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
> -					    SBI_STA_SHMEM_DISABLE, 0);
> +	return sbi_sta_steal_time_set_shmem(SBI_SHMEM_DISABLE,
> +					    SBI_SHMEM_DISABLE, 0);
>  }
>  
>  static u64 pv_time_steal_clock(int cpu)
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> index d8cf9ca28c61..5f35427114c1 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -93,8 +93,8 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
>  	if (flags != 0)
>  		return SBI_ERR_INVALID_PARAM;
>  
> -	if (shmem_phys_lo == SBI_STA_SHMEM_DISABLE &&
> -	    shmem_phys_hi == SBI_STA_SHMEM_DISABLE) {
> +	if (shmem_phys_lo == SBI_SHMEM_DISABLE &&
> +	    shmem_phys_hi == SBI_SHMEM_DISABLE) {
>  		vcpu->arch.sta.shmem = INVALID_GPA;
>  		return 0;
>  	}
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

