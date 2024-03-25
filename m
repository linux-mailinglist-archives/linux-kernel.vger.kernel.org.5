Return-Path: <linux-kernel+bounces-117534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E888AC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9041C3FDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCF4B5A6;
	Mon, 25 Mar 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibllFgBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44D3DBBC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386221; cv=none; b=hOguBi/QSenRf+oP1lFsj4QWWErslRwSBzJVIT9Jfzyzpbk6FiGPMoSj5pFLDelTeCOG2PmOZ5ATnzge9NMHIv6uLRTwyIgWGkNRStEwcI3Q1rogXIni95bMBqOF6x7wu4YTH1ofoZjhc02yiiG2sxM1aFPyd98a2kQ2r3Jk0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386221; c=relaxed/simple;
	bh=z/jh+93zuvKqVIQ98MxaG5F4d3axg0Y13zwiWvCIOg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL/xLY/4HXQeodmW8H3Bng+vM3wcmZIbIyVnhnaPfxSBPkZ7kxyG02OX5OGc0jYhOWnN4lXneBpcdUqTRL3T9fkT49azC2mGZx99odYahj7aYX4oSgU7utJIPJBuAWQ6WqERGhJIjHwzd5XWWkbXqm5XZkyWbNhnjL6hM2fhh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibllFgBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9590AC433F1;
	Mon, 25 Mar 2024 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711386221;
	bh=z/jh+93zuvKqVIQ98MxaG5F4d3axg0Y13zwiWvCIOg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibllFgBos5TkeQY0PYTM1ISTnrSacPHTnQzJ956kmpo5PD14ze3eBNhs4ozn9Rx5D
	 rvzt+0JS0lzQyPPLsL0k/BpjypqND0jxIEr2P/fDBujybNLLGZ4H9yrstHvLwm3tfE
	 oJaHw47t+yvIzTlg3EPJZ2Q0j2Q8Bx9Hudgm8mcRHIkT3kKn1vWP4zdIRHvnyl9PV7
	 OMwt7BEl44CdyBkmfs7apSOHJ8WDgNIHPq+QoezOzmO1XsXaAC8LGPkCcLJvSgdK+8
	 FxFJI+7f2GhK/KW+M+gQAw0Kr9j4a+mfHH0sB/S7A39SoCnypVlaeoAwL6dJ/YDVwd
	 t7TZay50Xoxog==
Date: Tue, 26 Mar 2024 00:50:14 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] clocksource/drivers/timer-clint: Add T-Head C9xx
 clint support
Message-ID: <ZgGrRrH0mxoKl90n@xhacker>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-6-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325164021.3229-6-jszhang@kernel.org>

On Tue, Mar 26, 2024 at 12:40:21AM +0800, Jisheng Zhang wrote:
> The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/clocksource/timer-clint.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 4537c77e623c..71188732e8a3 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -34,6 +34,7 @@ static unsigned int clint_ipi_irq;
>  static u64 __iomem *clint_timer_cmp;
>  static unsigned long clint_timer_freq;
>  static unsigned int clint_timer_irq;
> +static bool is_c900_clint;
>  
>  #ifdef CONFIG_SMP
>  static void clint_send_ipi(unsigned int cpu)
> @@ -88,6 +89,19 @@ static int clint_clock_next_event(unsigned long delta,
>  	return 0;
>  }
>  
> +static int c900_clint_clock_next_event(unsigned long delta,
> +				       struct clock_event_device *ce)
> +{
> +	void __iomem *r = clint_timer_cmp +
> +			  cpuid_to_hartid_map(smp_processor_id());
> +	u64 val = clint_get_cycles64() + delta;
> +
> +	csr_set(CSR_IE, IE_TIE);
> +	writel_relaxed(val, r);
> +	writel_relaxed(val >> 32, r + 4);
> +	return 0;
> +}
> +
>  static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
>  	.name		= "clint_clockevent",
>  	.features	= CLOCK_EVT_FEAT_ONESHOT,
> @@ -99,6 +113,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
>  {
>  	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
>  
> +	if (is_c900_clint)
> +		ce->set_next_event = c900_clint_clock_next_event;
> +
>  	ce->cpumask = cpumask_of(cpu);
>  	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
>  
> @@ -233,5 +250,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
>  	return rc;
>  }
>  
> +static int __init c900_clint_timer_init_dt(struct device_node *np)
> +{
> +	is_c900_clint = true;
> +	return clint_timer_init_dt(np);
> +}
> +
>  TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
>  TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> +TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", clint_timer_init_dt);

oops, this should be "c900_clint_timer_init_dt", will update in v2.

> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

