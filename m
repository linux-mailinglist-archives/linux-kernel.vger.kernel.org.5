Return-Path: <linux-kernel+bounces-131403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE83C89872C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D523B22FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20F86ADC;
	Thu,  4 Apr 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cDY2IIR0"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D286277
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233175; cv=none; b=HpNzT2g5HWYno0Etldu1Q5LFj9j0LDDGVsd/A32Tckm39AkDKaDT1KKVypr3LK1+bVuSr/kLRhEKm/J4wWp1k8u72CAHAthESuVIgL1aTza3IYcVo9EFq4Y1XqV1GB8TVby4Zaq7bA/p4avX0dK3s6Tc73GTMFPU4AMxMgQcCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233175; c=relaxed/simple;
	bh=yFPwBTep8blPVjgy5nMdu/6Amok2vV20/Fu3FyIKsHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDye36KvkCEkpFC0J7dLz0V87aiHWSwU5aPp7DxURZtidXZkhx0UoANxtr3KVkiGD6SeTfiH+AFIsxd0zhJ4E8saW70LSn1HCIlkoaXqoN9pO18To0YRNJgKQOiDXcUNzgnxmthQ94nQLQJ3MMSQhJlYlrofXFI9DxLubk9zkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cDY2IIR0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516c11b6af9so1274548e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712233172; x=1712837972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lu9C520pl/QToPEuDedj4tCxIjbZApgXqw10FbpssTk=;
        b=cDY2IIR0sXwPlKvhisoxoDA8cvnMXuhFha8dpOl4MOkFXDE6WRyyRRcoekb0v0ZVJa
         g7eWIZhHLiJfTbqQ8fPCNWrQyR3dgctIcGURkfNMTlbhMm8GuOhTKaRSW857whd5487Y
         tMANTtkLx73Tu5oLXl2t+Aa/rU0276xlLLnwVY/S+tQk0Zkgtk1ZOT4VeBjdurYi8wEo
         DuuPSZtvkcVQn7KSZw+qDKHPMxBLpudmeouMkdkUPKEOTZe37iCtSNS0U7dF4+RVXWpT
         E9+17LTL5q1YDJ9Svg5pnnsErm1pgTkJKOzueXhr5G5ITIgS1Ix/lVMsUgJ/aUD1MU3Q
         A/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233172; x=1712837972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu9C520pl/QToPEuDedj4tCxIjbZApgXqw10FbpssTk=;
        b=U/x9rbg8iOqOGMc0MFxEwMifegb1XQUTomFczuXFzQ5c/S7rHA/rJs5ks85nYJINPR
         WyatxMio55L1lNuHgiwFvGYYSSd6VbQAuL+TReryz2ULB8dSk0pbTCtGzgiTCSGjdtTZ
         AkO2qWD8DjRhwi48Za/oBFWFvqZMYUBYuOxu2ENnozaUlnEtmHq1G7+mx61SNjxgyzgh
         ZwrzUHlq2vE0tA1RWrFsCagCEhUpa0H+QvwPX7UWAjvwt84qz+ntgM0HaZ1P/Mmd+8Qs
         SLiCvk/1Zbcea7CLrAJTFCWQjj3MP1MVMk6OClFNsZla9N7aNuzaKdl3FDmWJW80iIwk
         zqLg==
X-Gm-Message-State: AOJu0YzA2H43RUxLKXlkP4bD0yUge7qLbq6XF2SnXoKAH7Fa5yRLDvds
	UUG/7+kCicNMmxYfZ33apYkV3o4bhQ/C6vYDa6KPOH7e+ma9+iK9mlpdLhnoDmQ=
X-Google-Smtp-Source: AGHT+IGEr4LvYqRVP8TkgXhtJPu1ySWcSB/CsLOqLwHtKBXo1yVAMV8rZBtRTlCE8fvE3nx9A3syYg==
X-Received: by 2002:ac2:555b:0:b0:515:d3dc:43e with SMTP id l27-20020ac2555b000000b00515d3dc043emr1852415lfk.51.1712233171751;
        Thu, 04 Apr 2024 05:19:31 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906670c00b00a46d6e51a6fsm9012975ejp.63.2024.04.04.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:19:31 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:19:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 11/22] RISC-V: KVM: No need to exit to the user space
 if perf event failed
Message-ID: <20240404-de7d09060b134d467e437fcf@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-12-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-12-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:40AM -0700, Atish Patra wrote:
> Currently, we return a linux error code if creating a perf event failed
> in kvm. That shouldn't be necessary as guest can continue to operate
> without perf profiling or profiling with firmware counters.
> 
> Return appropriate SBI error code to indicate that PMU configuration
> failed. An error message in kvm already describes the reason for failure.
> 
> Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
>  arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index b5159ce4592d..2d9929bbc2c8 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
>  	return 0;
>  }
>  
> -static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
> -				     unsigned long flags, unsigned long eidx, unsigned long evtdata)
> +static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
> +				      unsigned long flags, unsigned long eidx,
> +				      unsigned long evtdata)
>  {
>  	struct perf_event *event;
>  
> @@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  				     unsigned long eidx, u64 evtdata,
>  				     struct kvm_vcpu_sbi_return *retdata)
>  {
> -	int ctr_idx, ret, sbiret = 0;
> +	int ctr_idx, sbiret = 0;
> +	long ret;
>  	bool is_fevent;
>  	unsigned long event_code;
>  	u32 etype = kvm_pmu_get_perf_event_type(eidx);
> @@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  			kvpmu->fw_event[event_code].started = true;
>  	} else {
>  		ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			sbiret = SBI_ERR_NOT_SUPPORTED;

I'm still not sure about this. I replied in the v4 thread about it.

Thanks,
drew

> +			goto out;
> +		}
>  	}
>  
>  	set_bit(ctr_idx, kvpmu->pmc_in_use);
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
> index 7eca72df2cbd..e1633606c98b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  #endif
>  		/*
>  		 * This can fail if perf core framework fails to create an event.
> -		 * Forward the error to userspace because it's an error which
> -		 * happened within the host kernel. The other option would be
> -		 * to convert to an SBI error and forward to the guest.
> +		 * No need to forward the error to userspace and exit the guest.
> +		 * The operation can continue without profiling. Forward the
> +		 * appropriate SBI error to the guest.
>  		 */
>  		ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
>  						       cp->a2, cp->a3, temp, retdata);
> -- 
> 2.34.1
> 

