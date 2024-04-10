Return-Path: <linux-kernel+bounces-137856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2494389E850
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DA21C22625
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76678F4E;
	Wed, 10 Apr 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JSvjB3fj"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3F5256
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712717879; cv=none; b=AemhWxQtIhvXij8VwNg+pPkVwKtvbTm/cHzTC17pSkxyzeUipzmqLxFAItthgAgQR0iOcvHFmTojlYM5vLT6fSR9oWf0du1T+fx0N3S2gR1m4UTSgxGoyV4oHcLfs0mN7BmZc7YoaO89wjp1zxiCnVFbbwYdTPmRJXtH1dzhruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712717879; c=relaxed/simple;
	bh=+wGoUEEHtQzNwtvqNGpXsZEhVw2yiSpyMixy10yJTYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWrKXJgHQwvlU4ABCEJVYbPw6e9he2nVSSXfe2zJhjE8tfQCYTWq9uhBjcR9uG07TC4xSoKNn3CGhLuuftUCiU5U3SuSFM1W88R1vo5Cb0uD9rS9h6W/A0rRBTXalmBXbMU45+UEeHiJ/49yIAPQ4IqQ7ZxXJEWN2nrDtq0lP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JSvjB3fj; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712717874; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kruiYUmOiTVIsUsIMaG0sjLlfOz8voFRkMrO00RNhG4=;
	b=JSvjB3fjn75ySW+OWg8t5eWcbQjpqS5IRmJEU8pqhGhHV5ZNsUzgFR3ameY8dobYu4lWL4tEA1DgDpZxk2uJyBgBC5B7MAbCJyBUDNvL+9ZEVdVBRsbCZKe3Wjo+WjVHo0zuCF91SWKvXpIirjzTqi2yX96pLMW6doL7BF2ZouY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W4G9vJr_1712717850;
Received: from 30.97.48.122(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0W4G9vJr_1712717850)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 10:57:52 +0800
Message-ID: <beee157c-6e7b-466e-93cd-81a9eb033fe7@linux.alibaba.com>
Date: Wed, 10 Apr 2024 10:57:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/31] x86/resctrl: Move monitor init work to a resctrl
 init call
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-11-james.morse@arm.com>
From: Shawn Wang <shawnwang@linux.alibaba.com>
In-Reply-To: <20240321165106.31602-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/22/24 12:50 AM, James Morse wrote:
> rdt_get_mon_l3_config() is called from the architecture's
> resctrl_arch_late_init(), and initialises both architecture specific
> fields, such as hw_res->mon_scale and resctrl filesystem fields
> by calling dom_data_init().
> 
> To separate the filesystem and architecture parts of resctrl, this
> function needs splitting up.
> 
> Add resctrl_mon_resource_init() to do the filesystem specific work,
> and call it from resctrl_init(). This runs later, but is still before
> the filesystem is mounted and the rmid_ptrs[] array can be used.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++++-------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++++
>   3 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 031948322eab..7a0c74779c53 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -540,6 +540,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>   void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>   		    int evtid, int first);
> +int resctrl_mon_resource_init(void);
>   void mbm_setup_overflow_handler(struct rdt_domain *dom,
>   				unsigned long delay_ms,
>   				int exclude_cpu);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 06565153ceb2..929ec1430b45 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1003,12 +1003,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>   		list_add_tail(&mbm_local_event.list, &r->evt_list);
>   }
>   
> +int resctrl_mon_resource_init(void)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	int ret;
> +
> +	if (!r->mon_capable)
> +		return 0;
> +
> +	ret = dom_data_init(r);
> +	if (ret)
> +		return ret;
> +
> +	l3_mon_evt_init(r);
> +
> +	return 0;
> +}
> +

Now x86 platform defaults to all monitoring features on the L3 cache, but some monitoring features may also be on the L2 cache or memory controller according to the MPAM spec. For example, the memory bandwidth monitors could be on the memory controller.

Will resctrl_mon_resource_init() consider this scenario?

Best Regards,
Shawn

