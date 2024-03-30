Return-Path: <linux-kernel+bounces-125682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701E892AA2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE261C211D4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D42BB16;
	Sat, 30 Mar 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+qg8RfF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E12C683;
	Sat, 30 Mar 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711796828; cv=none; b=hJD3XoBv6nHma0OL1R2Swj3z0zWuOoWYcLDLwsDzhweB/VWWyQEipVWGcyQdxsUwzH9C/BYy5FLmDUfS6s9UPF0Dk/NZn8GPmLKnxa9fcHBbePlueftWjUL218A2DW8sTPKeOF+STcz7bh2Q9BbZVTPonhnzdvBZ6BL5eqYxSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711796828; c=relaxed/simple;
	bh=Cs00lq398clB8JBkUCk7ti8zACJbjeX3loZReGfDojs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJDBUdOBb0WlBZpF5hd2wbkZqmkYV/FPcAmyklmkLwxip453KwEFG0vAi/0Rl/nAsropsVoy9KyXTlX7EzyZwcqfldArFHvLE2gFdq8PFyzA1omDBCsztqBXvjkPVM24vrEVkqkNm/l8YbD1ipKhDN7OvAmd8HsNaGDqOlxJ8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+qg8RfF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a467d8efe78so331930066b.3;
        Sat, 30 Mar 2024 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711796825; x=1712401625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cjdpLyY8oQ9khbm5/h/9knNTs4Z1bU+zc8wrTRrEtw=;
        b=b+qg8RfFFM3mIGi4KXf0Srgqjt2DNjeY8YemmHJ0lo0t6nOTHW97rBcKQERp89teOP
         7RWwdsSoaHpVK8V9Iqkn8EkYZ3NsnxJCtx65wV0I/gBR0SF8Ahp0ohuNn86ZXDl3w54g
         XKBenkO0T5V3BWEuKvA/bFvHZS93pGdJHaMGcnk3h+i5+lK6P8KAUqNW2lOcdNZ0tQo4
         fkeb/R2BrbzdGukcQrLSoGkSrY/FJyDbih+bB737WQVy/E5EntqbtnXEXBdkuKuUUY0C
         S8FJTCiKuntZr9lIC3Hx46LXEdaHfg+hIhDbsf2ZFJooYHJ8S5IbzwOdLJxSCNl2+4Dc
         yzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711796825; x=1712401625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cjdpLyY8oQ9khbm5/h/9knNTs4Z1bU+zc8wrTRrEtw=;
        b=cA1bgp2qlKj3M1/L/qErKDKw00ZDBkOoMkyV3bsLNsfjdkFkHba3XLqXUcGSDgjwuy
         0bhb6YM+i9qJ+kOf3aUHSqnp+WzjZJ6qLwQtYe+bWt+TP5V/T5WYEJnT8FSKItSP0S+U
         9ce7fvTF0bb4nQ//KgPZV7NNNkVaxgYzcM4eLhI/Gz/U/nUHwzUMgtxoZfoEVS0Rlv7P
         nLHwP5qLkfHPNF9CrfrL1QNwvHG5Y4egp/gj9/yYybqQ30Cn728xJKtp3RLYB51cqTBx
         t5mw+YfuNq3JowW0c+3C7uBbhQ+sjp8kvCXtJWTdWv8A5AYvVBjkQ3XzdE/1MOkqtuLH
         axeg==
X-Forwarded-Encrypted: i=1; AJvYcCWxBz/UoXvBJJU4AZn52oMVaDOm3dYUiWcrFQetV9VJitBQxDilIlbZKxnS4UWKaXnrjD/SoopQ8SWwF6NNeipa14awogvjdH81bg62zxxUfUKjpw1JXJ8JSVJtOWoVwjIo
X-Gm-Message-State: AOJu0Yz8KhvjeLT9uYGbggy+JWkMGAfoOq+nwTtLMSKIEYwdB0joeJR1
	nQ2uoIrAK2nXKQcyZTebTuCXqeBTSK0iYJmhR5zZYk0LceYmgYwa
X-Google-Smtp-Source: AGHT+IHNGfpqg0LuCLgFzJZkOVfaatEDeSCWwqId1HmjcbrqIEIcEVB9jaZvYRSUva0s5wMeuCRh9A==
X-Received: by 2002:a17:906:a88a:b0:a4e:2da9:f710 with SMTP id ha10-20020a170906a88a00b00a4e2da9f710mr3760623ejb.6.1711796824815;
        Sat, 30 Mar 2024 04:07:04 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906235500b00a4e46da50e0sm842462eja.45.2024.03.30.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:07:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Mar 2024 12:07:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org,
	kernel-team@meta.com, Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v3 1/2] perf/x86/amd: support capturing LBR from software
 events
Message-ID: <ZgfyVjoI+khgGQjy@gmail.com>
References: <20240329163722.2776730-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329163722.2776730-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> from inside BPF program at pretty much any arbitrary point.

Upstream commit ID:

   c22ac2a3d4bd ("perf: Enable branch record for software events")

> [...] This is extremely useful capability that allows to figure out 
> otherwise hard-to-debug problems, because LBR is now available based 
> on some application-defined conditions, not just hardware-supported 
> events.
> 
> retsnoop ([1]) is one such tool that takes a huge advantage of this
> functionality and has proved to be an extremely useful tool in
> practice.
> 
> Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> necessary wiring inside the kernel is not yet setup. This patch seeks to
> rectify this and follows a similar approach to the original patch [0]
> for Intel CPUs.
> 
> Given LBR can be set up to capture any indirect jumps, it's critical to
> minimize indirect jumps on the way to requesting LBR from BPF program,
> so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> from BPF subsystem (through perf_snapshot_branch_stack static call).
> 
> This was tested on AMD Bergamo CPU and worked well when utilized from
> the aforementioned retsnoop tool.
> 
>   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving@fb.com/
>   [1] https://github.com/anakryiko/retsnoop
> 
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
>  arch/x86/events/amd/lbr.c    |  7 +------
>  arch/x86/events/perf_event.h | 11 +++++++++++
>  3 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index aec16e581f5b..88f6d0701342 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -618,7 +618,7 @@ static void amd_pmu_cpu_dead(int cpu)
>  	}
>  }
>  
> -static inline void amd_pmu_set_global_ctl(u64 ctl)
> +static __always_inline void amd_pmu_set_global_ctl(u64 ctl)

What is this inlining change about? My first guess was that it's to 
generate better code, but my guess was wrong: it's to avoid branches. 
To not force people to guess, please put it into a separate patch & add 
an explanation.

>  {
>  	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
>  }
> @@ -878,6 +878,29 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
>  	return amd_pmu_adjust_nmi_window(handled);
>  }
>  
> +static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	struct cpu_hw_events *cpuc;
> +	unsigned long flags;
> +
> +	/* must not have branches... */
> +	local_irq_save(flags);
> +	amd_pmu_core_disable_all();
> +	__amd_pmu_lbr_disable();
> +	/*            ... until here */

Oh ... so it's not about performance or code layout, but to avoid new 
branches to contaminate the snapshot, right? Even stronger reason to 
put that change into a separate patch.

> +
> +	cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	amd_pmu_lbr_read();
> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);

Why is min_t() used here? AFAICT all types here are 'unsigned int'.

> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);

The function could use a description comment explaining the arguments, 
and that the caller must make sure there's enough space in the 
'entries' array.

> +
> +	amd_pmu_v2_enable_all(0);
> +	local_irq_restore(flags);
> +
> +	return cnt;
> +}
> +
>  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -1414,6 +1437,10 @@ static int __init amd_core_pmu_init(void)
>  		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
>  		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
>  		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
> +
> +		/* only support branch_stack snapshot on perfmon v2 */
> +		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
> +			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);

>  	} else if (!amd_brs_init()) {
>  		/*
>  		 * BRS requires special event constraints and flushing on ctxsw.

Please use consistent capitalization in all new comments you add:

	/* Properly capitalized comment */


> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 4a1e600314d5..0e4de028590d 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -412,16 +412,11 @@ void amd_pmu_lbr_enable_all(void)
>  void amd_pmu_lbr_disable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	u64 dbg_ctl, dbg_extn_cfg;
>  
>  	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>  		return;
>  
> -	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> -	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -
> -	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
> -	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +	__amd_pmu_lbr_disable();
>  }
>  
>  __init int amd_pmu_lbr_init(void)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fb56518356ec..4dddf0a7e81e 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1329,6 +1329,17 @@ void amd_pmu_lbr_enable_all(void);
>  void amd_pmu_lbr_disable_all(void);
>  int amd_pmu_lbr_hw_config(struct perf_event *event);
>  
> +static __always_inline void __amd_pmu_lbr_disable(void)
> +{
> +	u64 dbg_ctl, dbg_extn_cfg;
> +
> +	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> +	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> +
> +	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
> +	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +}
> +

This factoring out of __amd_pmu_lbr_disable() should be in a separate 
preparatory patch too.

Thanks,

	Ingo

