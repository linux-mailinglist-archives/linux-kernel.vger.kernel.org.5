Return-Path: <linux-kernel+bounces-167492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57588BAA5D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D14D1F231F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96A14F9D4;
	Fri,  3 May 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHWHfSui"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37A150989;
	Fri,  3 May 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730073; cv=none; b=o6RohJEky6oGAtfIhIT6rEWMFhGrf+PQi/5srtnuDYA7J1T8eABcAnkBEyJpswqd9KUNk6CGClZlKpnG8fHH/zvUqvEim6JtHV0K/m3efvhno4FjJfzIeKnFUXz3Xrzgd1TRB0pbLG6XyhI//kBUxT+dT7EELbvzrsqyt2zm35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730073; c=relaxed/simple;
	bh=v/TQaWbOwMfphmJ/Zi0Tbv/dv/6f1wvOj2uU3AX1OVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4plD6Zg1Vs93Hu519B4S5PyA10lVcHjSOJcYGbBf36It5zSPqoMQWEWlg0NV6dG6WR6CB/p1MfvmPSaATIHQeU0sCE8RY90L+L4cDmkQ4rGY3kTL4Ux6sRa1bD46BTEwmHRWZX2xcr71nT8xBvbp+ZDwJzTq+UN1Tff5822/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHWHfSui; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599332afcbso76155766b.2;
        Fri, 03 May 2024 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714730070; x=1715334870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nB8ezzHpTc44+65boWeG1jYxDuQrI33mmzE4JzfUA9U=;
        b=kHWHfSuiT4mj4IYY0pK5+Ec2nVWl3dMyGgN9yviWUCA3Ic5gU8I1UvBrlVTHd6Rakm
         fzaPtiw7eaHzJOL9T+XKCXbn4WOsxnzouEo33QZ61BRAh0/qaQdJZEWcUT0H8guw3ufZ
         eNDlcFLaElXWXfs0kZNjkmnnHxyobrNzqc6o5bi7vzhqdLstnp1gHOKw8bZdbiNTjHZ+
         VYVtzRsLMlhnQ2gaFtQclPaBPHlT/HpD4xjqP/Orsz58sNtOolPhBt0MNCulV0iXYaEN
         LE0IvrXF420wioqbuN3sHwPHYwpyF9RF6DsEIstyHj2S8OtQHYG9e9uuEfHG9QRdq+WG
         K38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730070; x=1715334870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB8ezzHpTc44+65boWeG1jYxDuQrI33mmzE4JzfUA9U=;
        b=gHNdnffj0d4RvAIVgVZ3vQQMQYOVVm2pJxNG7FduMhi3QGYRD1dW11QLs4dTiJELdh
         Ams0e6+xcTDQy7+gbBLythV7o+GZt5ag6KiwcneOe+QmChL9dYtCM5c7UWSCWAE30MRi
         TgH/RuRFcRa1tXGUih1C4+fl2XGmZC3dXAesZR2M/DnTcog/zJISbaTJUn7BkZInhbvS
         Fwrf99c2HGmbCCXPToGUJ0Bjb1Y6FZUOCow9JkZoiXrW6Zx+Kie4UYMACNEBIdq47XhA
         VMkO/Xh007EL1cN/XgOxxA7+7V/e7R88KPf0boB5LSgC6p9uAA5i1fQs72cMfiuSTXOw
         tTng==
X-Forwarded-Encrypted: i=1; AJvYcCXttAnCVdHVW6Gs3iQIDmu003pdnopFu4gUZSLtUsQYofgHqVIyZkAhPPKIF3eI90/HhdnMnN5F8dKPEvpZKT3xIuVIyuWzI28eA5ESZTD6MBzKBOcunOQ6CqgUXFed1Vt+YBslSANcyHj4fSPB8B6XkcBTkM8vECn1wEBpVGTohV4i71+ukFNlV9EXwGp5fg==
X-Gm-Message-State: AOJu0Yy6YJMqjZVBbx/leMA7sZ633JagAiaIlpyMXQ4YKniCbflxBYMC
	lpz99ZzvNTOEesJKuXzYZSl8bcSCovTuPhFlJkY4URifaA99qo3f
X-Google-Smtp-Source: AGHT+IHYWz90YQrkaQdhsPY8v5NgsF1SkGxapc7VqJIHcdobxsXRE5wS2oRdfK0BUZ21ksyFVsioDQ==
X-Received: by 2002:a17:906:288a:b0:a54:4f06:4d00 with SMTP id o10-20020a170906288a00b00a544f064d00mr1035341ejd.65.1714730069702;
        Fri, 03 May 2024 02:54:29 -0700 (PDT)
Received: from gmail.com (1F2EF54C.unconfigured.pool.telekom.hu. [31.46.245.76])
        by smtp.gmail.com with ESMTPSA id x26-20020a170906b09a00b00a588729de82sm1530119ejy.142.2024.05.03.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:54:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 3 May 2024 11:54:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	ananth.narayan@amd.com, gautham.shenoy@amd.com,
	linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, sandipan.das@amd.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	gustavoars@kernel.org, kprateek.nayak@amd.com,
	ravi.bangoria@amd.com
Subject: Re: [PATCH 2/2] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Message-ID: <ZjS0Uio+nvZLLmyb@gmail.com>
References: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
 <20240502095115.177713-3-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502095115.177713-3-Dhananjay.Ugwekar@amd.com>


* Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> wrote:

> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer 
> return the package cpumask and package id, instead they return the CCD 
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg 
> event scope to be modified to CCD instead of package.
> 
> Replacing these macros with their package counterparts fixes the
> energy-pkg event for AMD CPUs.
> 
> However due to the difference between the scope of energy-pkg event for 
> Intel and AMD CPUs, we have to replace these macros conditionally only for
> AMD CPUs.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package 
> scope event, only one CPU will be collecting the event for all the CPUs in 
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
> ---
>  arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 46e673585560..d77bf7959a43 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -102,6 +102,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>  	.event_str	= str,							\
>  };
>  
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
>  struct rapl_pmu {
>  	raw_spinlock_t		lock;
>  	int			n_active;
> @@ -139,9 +143,21 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
> +static inline cpumask_t *get_rapl_pmu_cpumask(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> +					 topology_die_cpumask(cpu);
> +}

Note that this breaks the build with this config:

  https://download.01.org/0day-ci/archive/20240503/202405030828.RgFuznL9-lkp@intel.com/config

I've removed the commit from perf/core for now.

Thanks,

	Ingo

