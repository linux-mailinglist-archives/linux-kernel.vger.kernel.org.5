Return-Path: <linux-kernel+bounces-89354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4B86EF4A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64332B21982
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478D125D7;
	Sat,  2 Mar 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="n/wzdBv/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931911717
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365663; cv=none; b=hosLpFb2jnjmc3YW1HE6WnBmFkQFo6VZeozXvsBp7gUalpcuxvP2do/6Lf/3uwf73cSufk6FfLCwHwXez8Ubq4IM6shE6SfvmlL8IyDRwUb45JkmAFQ4joPIz49msl8HPpxYJhfV0QhhaDX0wuF+iFS+16KXnGz1vwhEIEQhoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365663; c=relaxed/simple;
	bh=HdbsxiJhiXPHCyAoIFfaT7i4095x8iDZOuT2JzlDoBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geczd8F9HBNSfeoXVVo9fNDd51/EL1+d49hYMqzqCT17qTd6i8A/veJFzdzwh/VNBrfA1bCR2SJ2BWCJgmA6RWcx4cPrn4OJMiMZl4kgc818Ec6Dedm5ltkdPgzrQGEM/4ap07Yx0VctTAkJGe4r9bRjfkA+h9WRQxOui/3O1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=n/wzdBv/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412da818207so159505e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709365660; x=1709970460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Ib+i/7ul2383kueBaIr1KAZdgCE/S8URkt4mrWqYE=;
        b=n/wzdBv/vRTE+VfO+6JIyiITqK2ST0LxYXZ0bW2qwxU6VJXlYTMk8TpY+uYuaE1sA/
         WFmkmW5SH8JAWMHkslnUXx4inPxPHkHtSo61pJF4NC5d9jVXGSl4V1wrJLO0nGXlIyPr
         svWFbcQw7+p30ettygHQlCUeEDqk4UOISLfWAfHTKdmtuVkWKmKvESypsWTS32NMNNXn
         vVfmLdZrOiUpXFL0zBn+Fjpxtyl/Lvqmd0VFbAwFDwW1LE/zjKM8cAzxnIj7SuNTXcW6
         nqK+2pcB5jgfEZ15HLZmpzuC46GxgqAaR4K5Ng0v3Fqwugse4ysDWir9ZsxhxyYRTYF5
         Kutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365660; x=1709970460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Ib+i/7ul2383kueBaIr1KAZdgCE/S8URkt4mrWqYE=;
        b=iRmr+2IFoMrE/RfXvH/PAZxHVxce3YL5SYbZCwkBJuQttbbvcOXNqm1MQSvB7fIkUN
         VqZOqQKDCJFPh5YeYAPN6GYEuvszkbGKP8IMfJ6Oo8bt0yRuLBwgVTSlFY4OjYp+x1Y5
         k5IVHaaC8H5qp2bJ416SMARCE1pvEnbVKKwwnj1DnSrgZHs5BXxzZBPN11aPBWZhPMbb
         8vAzCn1PPvla0rK/gklFJBj956QSxQmxlFw9ObAOzdUgb45znCe9THJ1rf3HZ2KDQu7o
         /vgX2tn8hfLsCG0XQK+y5Kc6h9fCLGvS5AevJ83uzJu0NLraUs7LivcvHX29IHJZCeoP
         d9BQ==
X-Gm-Message-State: AOJu0YxT5712aNsCK3Zn+X2LQvjY0ruUH8NTtVZ/JAm8bFz5ynXTZhdm
	nE1iarutEsH0eKlhmbJQnbok0MQDeKlkZnx2H/HR3QmAn0t3LCJuXo+bl8xZQpwXFharSe1x2Tx
	K
X-Google-Smtp-Source: AGHT+IEVoW7uokoz89spH9xj6f+lmKJjEsvkGZk/n4AsgiYDjM2F+XJU0nnyceOxTlFgpo153Zwm1Q==
X-Received: by 2002:a05:600c:3107:b0:412:b8cf:150b with SMTP id g7-20020a05600c310700b00412b8cf150bmr3321506wmo.10.1709365660476;
        Fri, 01 Mar 2024 23:47:40 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l33-20020a05600c1d2100b00412ca88537dsm3348026wms.0.2024.03.01.23.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:47:39 -0800 (PST)
Date: Sat, 2 Mar 2024 08:47:33 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 06/15] RISC-V: KVM: No need to update the counter
 value during reset
Message-ID: <20240302-a82f4ba5d90bc3d85f3ed83b@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-7-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-7-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:21PM -0800, Atish Patra wrote:
> The virtual counter value is updated during pmu_ctr_read. There is no need
> to update it in reset case. Otherwise, it will be counted twice which is
> incorrect.
> 
> Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..b1574c043f77 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -397,7 +397,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>  {
>  	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
>  	int i, pmc_index, sbiret = 0;
> -	u64 enabled, running;
>  	struct kvm_pmc *pmc;
>  	int fevent_code;
>  
> @@ -432,12 +431,9 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>  				sbiret = SBI_ERR_ALREADY_STOPPED;
>  			}
>  
> -			if (flags & SBI_PMU_STOP_FLAG_RESET) {
> -				/* Relase the counter if this is a reset request */
> -				pmc->counter_val += perf_event_read_value(pmc->perf_event,
> -									  &enabled, &running);
> +			if (flags & SBI_PMU_STOP_FLAG_RESET)
> +				/* Release the counter if this is a reset request */
>  				kvm_pmu_release_perf_event(pmc);
> -			}
>  		} else {
>  			sbiret = SBI_ERR_INVALID_PARAM;
>  		}
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

