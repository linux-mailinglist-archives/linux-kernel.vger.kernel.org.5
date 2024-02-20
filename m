Return-Path: <linux-kernel+bounces-73493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A785C37A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FB3284F07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3519A77F35;
	Tue, 20 Feb 2024 18:14:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157A762EC;
	Tue, 20 Feb 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452891; cv=none; b=q3H/pQDkC5UkczWeV2PRCXU9Hvy0NuWTlpFZ515r6BjJiUHUTvgZRQf1oSArPIZLDx6vJVMqXHsWYnqJGgB1+DaNWfqh8e6NZcELRuitsu4JIFombZ4HH7NujBSIRLmyKZiHgym8SfezL+7IPe79pomS3UuNJ0CnKuSTALwbWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452891; c=relaxed/simple;
	bh=OEt8B9xfdY+l+e2STF/QjTUr6oMjKAKUVGw4y91xUL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0TpMPE/ZdSfiprRKCUbABvc8nXPmlW2EC0ZNPXdxgkwVk+TJqMe1lRUtEkiEuaVlusqUG3H1+qmZsTrOUIfZOvmlRHnDfyMu9DH2oElQCa9DyCFvp5qz2+dJ739mcdYubGNg+KGlrGPyQ6SEkS+JCVixfjMj0fjHNVO7VAHiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC56FEC;
	Tue, 20 Feb 2024 10:15:27 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408FB3F762;
	Tue, 20 Feb 2024 10:14:42 -0800 (PST)
Message-ID: <5ad6f627-45c6-4c2b-b761-c74f0fe85f6c@arm.com>
Date: Tue, 20 Feb 2024 18:14:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] x86/resctrl: Introduce interface to display
 number of ABMC counters
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <c16cac16c813a203390229d77d5ab37ebc923d95.1705688539.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <c16cac16c813a203390229d77d5ab37ebc923d95.1705688539.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 19/01/2024 18:22, Babu Moger wrote:
> The ABMC feature provides an option to the user to pin (or assign) the
> RMID to the hardware counter and monitor the bandwidth for a longer
> duration. There are only a limited number of hardware counters.
> 
> Provide the interface to display the number of ABMC counters supported.


> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index a6c336b6de61..fa492ea820f0 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -823,6 +823,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			resctrl_file_fflags_init("mbm_local_bytes_config",
>  						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  		}
> +

> +		if (rdt_cpu_has(X86_FEATURE_ABMC))

Please put this in a header and calling it something like
resctrl_arch_has_assignable_counters(). These X86 feature definition macros aren't
available on other architectures!


> +			resctrl_file_fflags_init("mbm_assignable_counters",
> +						 RFTYPE_MON_INFO);
>  	}
>  
>  	l3_mon_evt_init(r);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3e233251e7ed..53be5cd1c28e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -811,6 +811,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int rdtgroup_mbm_assignable_counters_show(struct kernfs_open_file *of,
> +						 struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;

> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);

(After the move out to /fs/ the resctrl_to_arch_res() macro is private to the arch code.
 Needing to do this when providing a value to user-space is the indication that the value
 should be in struct rdt_resource instead!)


> +	seq_printf(s, "%d\n", hw_res->mbm_assignable_counters);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*


Thanks,

James

