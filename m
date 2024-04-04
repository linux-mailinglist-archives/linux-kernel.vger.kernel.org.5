Return-Path: <linux-kernel+bounces-131346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497989868C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396C7B24161
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC484FDD;
	Thu,  4 Apr 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oBqxLggq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133C84D05
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231744; cv=none; b=ltrIjH7h/GM06AuZFsfq8BVE1MTdy59aDEO4fTRM9gZiUGrBoDJNWl+UIBHwPtqPr2JuZXxQmfuTc7JCNCwMBeIflT/1GtPuYn8O6DhCNhHpjAV7Ma3nU5dJWwZbM4qQLG2yGPsoWFSLtCUsHlokBvFyeWrf0pCMyDK6yKQJfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231744; c=relaxed/simple;
	bh=cte0IjkEbEgza+ss/nMD9HI6t7MmFsQCgkQHAAdfVDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD6kDKQpaUB9bPMcAdlcfWvOiiB6u3zGymIR+6BsVuZQHh0WYuPTSuBSrIBm9Epi1SVH5/RA3sjqDZ5dRJx5uJg/SZlA8KlhMxQON6u5qr9j5xkHrIDoyk4WQEM3Q/5GO0WQTKeViyijBOt/p26sZhZ/jXaL2YZgLw8JapfMHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oBqxLggq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e0e1d162bso830816a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231740; x=1712836540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MggdLhtScC0WHbexLHVciQeNa0pa9gvC6PekQ9uXyqA=;
        b=oBqxLggqgMDZSS2fvdRdMwp3lzRR+d5XtfjDiZ5oXytLTFJFHQohnFdRs5hB6+TWdJ
         2wiU2B4qDk8guaxZjJY3cTns4BFBRjbgveHBjSE34hv19CyKrMRbQUkgNZQgDYcjV6FI
         e9RPahmkf2fFvtENAESNDjh71DyWybFPJhzuUZvcQ794xKb/rESwm7UTfElpvLkAfMQr
         vUvWO8dMS/wYK7nX5pnjmw6XJPu7G21WSd78zIMNYz2AqyvNSZFZof2fyG8aNTakJBxj
         jcaSaltHywbEGmiqy5vdjBEgNQTJ8pO/kH+71P1diWWSj9DEfigNoo1yZNHAYEAfJ2aw
         atNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231740; x=1712836540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MggdLhtScC0WHbexLHVciQeNa0pa9gvC6PekQ9uXyqA=;
        b=wHe3oLurQwO5TTJay5jWnUze1D/hEhDu+cIBTXuMggWV+g3pt6cElWx38J5sVj0xFy
         YKnZUkbuXyIYMq9kRRdmPJAihJP+BfUkfhXCxnyhA4TwVll4sH1kVxgJkEZaZRw1uIIN
         TPYpEDMg1xcgwhKyIRUvPkFQtS4pwd2prJZna6OHAQ9dm06e6bKrTXJAkPLLJ8TgQrb9
         EM5LKzQMFN3ogfiAz4cSNX6+V8FOhpb+orBWZOkFL9Ch8PeL4bWAvT8jR3uWbi94418k
         Gq2CAH/S16ysqeqvgGqMDqgXXLJFqPJyHnczhNhoRoJccmA35OAckpS3ZfQsxlGwb5lZ
         X7XQ==
X-Gm-Message-State: AOJu0YyChQGpPJIZVtYM7x0aOMRzOaHpSkpqTFA7IjVR5EgBuXqVfKCT
	l6dPnfMTVlhVe2H5NLpgIhtbzMBH1NN1M70fa6TEaczyp/nN7p4SHAJ5QzsijK4=
X-Google-Smtp-Source: AGHT+IHbQVR5kRtT5eSzAIoLj4j7ezmt7zb8/dHcxiB8NsIJPag3OPp4cCgWeUncPmPWCdmuF6F7iw==
X-Received: by 2002:a50:d71e:0:b0:56e:2393:cee4 with SMTP id t30-20020a50d71e000000b0056e2393cee4mr346003edi.9.1712231739832;
        Thu, 04 Apr 2024 04:55:39 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a88-20020a509ee1000000b0056dc0e21a7dsm6860407edf.4.2024.04.04.04.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:55:39 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:55:38 +0200
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
Subject: Re: [PATCH v5 07/22] drivers/perf: riscv: Fix counter mask iteration
 for RV32
Message-ID: <20240404-f10f72395cc0b25971541ece@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-8-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-8-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:36AM -0700, Atish Patra wrote:
> For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
> to interleave firmware/hardware counters indicies. Even though it's a
> unlikely scenario, handle that case by iterating over all the words
> instead of just using the first word.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 8c3475d55433..82336fec82b8 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -771,13 +771,15 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	unsigned long flag = 0;
> +	int i;
>  
>  	if (sbi_pmu_snapshot_available())
>  		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>  
> -	/* No need to check the error here as we can't do anything about the error */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> -		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> +		/* No need to check the error here as we can't do anything about the error */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
> +			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
>  }
>  
>  /*
> @@ -789,7 +791,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
>  						unsigned long ctr_ovf_mask)
>  {
> -	int idx = 0;
> +	int idx = 0, i;
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  	unsigned long ctr_start_mask = 0;
> @@ -797,11 +799,12 @@ static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt
>  	struct hw_perf_event *hwc;
>  	u64 init_val = 0;
>  
> -	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> -
> -	/* Start all the counters that did not overflow in a single shot */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
> -		  0, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> +		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
> +		/* Start all the counters that did not overflow in a single shot */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
> +			0, 0, 0, 0);
> +	}
>  
>  	/* Reinitialize and start all the counter that overflowed */
>  	while (ctr_ovf_mask) {
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

