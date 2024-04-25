Return-Path: <linux-kernel+bounces-158182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DA18B1CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14BE282406
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D266F076;
	Thu, 25 Apr 2024 08:12:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED463B78B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032724; cv=none; b=r+qUa9cxXjGhVEclj98C5/sYk6DzfturPV76dkNUOcpdIZZCjK2lmhSXxipHAjdZCDrnslZevKlSRj7fLXEu7wu81rs9SFTNZdEGR27ElezLiKTcaDuJgVTzi+cK8BBh/hX2qFe6puO5Qav/xzD21nE4kqnL61zCbLa5Dv2o8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032724; c=relaxed/simple;
	bh=z/3dDKpe/qkjJq5qQJ/XtxPtsk1PzmXNRabbZFG5Qfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=liHnD+G0HJcVyteKT0gPBJWmru6Y0JsrNSWKiqv/KcfDORwIrIHqBhzaFbaDker1QF6MALOKczz6qmHR1NXkxuH2sQ5/rnVk8NaVgjT2rKkDbOteNqo3+TctUplyZNcsOR3QpdK+/J7eS5IFMLbqaGkgbS+dyH29FVHEgWaVoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20411007;
	Thu, 25 Apr 2024 01:12:28 -0700 (PDT)
Received: from [10.57.74.218] (unknown [10.57.74.218])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4006F3F64C;
	Thu, 25 Apr 2024 01:11:59 -0700 (PDT)
Message-ID: <730b8b60-8101-4c93-8e71-74804ef0d314@arm.com>
Date: Thu, 25 Apr 2024 09:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/topology: Fix variable naming
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20240425073709.379016-1-vincent.guittot@linaro.org>
Content-Language: en-US
Cc: lkp@intel.com, sudeep.holla@arm.com, qyousef@layalina.io,
 rafael@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, gregkh@linuxfoundation.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240425073709.379016-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 08:37, Vincent Guittot wrote:
> Using hw_pressure for local variable is confusing in regard to the
> per_cpu hw_pressure variable. Rename it to avoid confusion.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
>   drivers/base/arch_topology.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 0248912ff687..c66d070207a0 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -179,7 +179,7 @@ DEFINE_PER_CPU(unsigned long, hw_pressure);
>   void topology_update_hw_pressure(const struct cpumask *cpus,
>   				      unsigned long capped_freq)
>   {
> -	unsigned long max_capacity, capacity, hw_pressure;
> +	unsigned long max_capacity, capacity, pressure;
>   	u32 max_freq;
>   	int cpu;
>   
> @@ -196,12 +196,12 @@ void topology_update_hw_pressure(const struct cpumask *cpus,
>   	else
>   		capacity = mult_frac(max_capacity, capped_freq, max_freq);
>   
> -	hw_pressure = max_capacity - capacity;
> +	pressure = max_capacity - capacity;
>   
> -	trace_hw_pressure_update(cpu, hw_pressure);
> +	trace_hw_pressure_update(cpu, pressure);
>   
>   	for_each_cpu(cpu, cpus)
> -		WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
> +		WRITE_ONCE(per_cpu(hw_pressure, cpu), pressure);
>   }
>   EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
>   

Make sense

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

