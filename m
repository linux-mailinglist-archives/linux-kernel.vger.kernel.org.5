Return-Path: <linux-kernel+bounces-59482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259484F7B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876031C227C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783937701;
	Fri,  9 Feb 2024 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E3H6Sd40"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC337145
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489586; cv=none; b=Idfo8m8Ns1KQV10yec4pz1pudKdBT2HEDkR0pvskS8zRku7MoQcwyyMo4NxusjuCEuv/7Dab7TQDXFK+MAE/BKQiq4PyiuI0cHg4I0yrQzMaVRrfK3mH6ZlGRymm+G6gq0H2kybDwoFNg4t25MutwikDDGzoyCNfebGx4M3WpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489586; c=relaxed/simple;
	bh=jrvpLeVcerZOxEfdQQVcyklq/coxfAeQqZWJ3AzUpEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cox+4nHmgjquUutD7Rq2zvsjUP/SvtPoNKsUiMzgSGEmR8FRre4bJkR/qhG4ELcaYk7bnXne6x5kXhs/Q4fcw/n11C5cJOH0sFdMvxn373nW1xE4r/ytVGrFL1aRpQWda7GnhlDtG51PLDAG1y9mwAH+HhZavZVrsv7r29UvVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E3H6Sd40; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso1410497a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707489582; x=1708094382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7H3+30Pg52kOjZuSYcpufSo3nDUsdGtuIlOUedGk/WE=;
        b=E3H6Sd40uO+FXUhmjKStZaHNQIB6lxNB4teGHhRe1C+bw3Sq28mRuOCisuu0Nf/opI
         qNz9Gjs3PqfsgnEkyocF0TwsJNB58wN/SpQiN6He1byH6o1BGNYt4cuUnqqo0DXfZLFt
         GAmLNbIvP0hBIfKsPYJrVd0eJO2mKUZgpwBWddgLNDtom6jzjnjjKMsMFqZbQYWi+n58
         bMzDne4e4/vXpjYPcix9pK9LC4BrD78KOtIIMnoDJXpefi3tE25YKfPZZqUXFOMuotM+
         IvxiwtQC80JhM/ApAxU4vQlk8Zi/M83Az3CzzZD5cc03JYR3YolrZi0rCiOZkMYnh708
         ppPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707489582; x=1708094382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H3+30Pg52kOjZuSYcpufSo3nDUsdGtuIlOUedGk/WE=;
        b=U7yubQzWd2J0ctzeyDbcTOSbEF0hLA8btkQrGILgjiy0O9UCRdKCfrw/TfWQubmg9B
         B2tfD/RRRwwjWI2yE5LS3iOtlh9EUnbzpupbylkakJWfMFVApZWvtAKDZFV3yHXdxpEj
         +0+vDkLqAo+LQcFDCHhsQo7bbDEOLh52DEORmevgczsAVoVlI3uMiSXsFx4Fp8ctD6Sv
         1owDcBzxTov/oL1eYlaTbXGeSuwHr8LQbXLX+dfrBQL4Yhglb6sv87tYOn2HwRAIbzMT
         wBG2MYUkbqw7OKC/9RYCHo87bvneTWg3XIs9Iv7XEmgFQZsO+kXxvWhQP+QXJwXBqusn
         bVGA==
X-Gm-Message-State: AOJu0YyJeZVh2vY59slVmHe3/XaEIgySTt9mxs08JWkCW2SVHUtkwn7L
	+QVXUQsLfQuYWBc0brfkEzP+9AQIH61P6GiQPJ1Tf/AAJVr02yLdpu3Z7Y/vS1E=
X-Google-Smtp-Source: AGHT+IFeFg8vSdhPIqvKSjZ2jv07x8ut2lZAr2ql375pLNmsG9n5NAIwqeWaM4n/Y1mtANkhP4HYuQ==
X-Received: by 2002:aa7:c917:0:b0:55f:faff:c72e with SMTP id b23-20020aa7c917000000b0055ffaffc72emr1605156edt.39.1707489582276;
        Fri, 09 Feb 2024 06:39:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXn2bvjjFoJxdmhgxdkyPlqzP0S2IheCqXQhrqnZy05d6DlTA6zuWS8oj4+pwbbVdn4KuF8/jQoC88Xb6lf60dM5Xjb97K4bA2jdmBgCWz9XIgGgheTOVnLdDb1dV5cUAYy9lloVz3EPTvgLaWJsks2hj/iz+ONp7OW1UvkSyZmViqsCHzR3bKOAwU/dw6OxbEB0MQc/LFK5w==
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ds15-20020a0564021ccf00b0055d19c9daf2sm836061edb.15.2024.02.09.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:39:42 -0800 (PST)
Date: Fri, 9 Feb 2024 15:39:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: dianders@chromium.org, akpm@linux-foundation.org, kernelfans@gmail.com,
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 2/2] watchdog/softlockup: report the most frequent
 interrupts
Message-ID: <ZcY5LLfQcHIkpll7@alley>
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-3-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208125426.70511-3-yaoma@linux.alibaba.com>

On Thu 2024-02-08 20:54:26, Bitao Hu wrote:
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> most frequent interrupts could be good enough for further
> troubleshooting.
> 
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by comparing the counts of interrupts.
> 
> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker/9:1:214]
> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
> [ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
> [ 2987.491493]  #1: 330985      irq#7(IPI)
> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)

Nit: It might looks slightly better if it prints the last 5 HardIRQs ;-)
     Maybe this version already does.

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -412,13 +415,142 @@ static void print_cpustat(void)
>  	}
>  }
>  
> +#define HARDIRQ_PERCENT_THRESH		50
> +#define NUM_HARDIRQ_REPORT		5

It actually creates array for 5 IRQ entries.

> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
> +static DEFINE_PER_CPU(int, actual_nr_irqs);
> +struct irq_counts {
> +	int irq;
> +	u32 counts;
> +};
> +
> +static void print_irq_counts(void)
> +{
> +	int i;
> +	struct irq_desc *desc;
> +	u32 counts_diff;
> +	int local_nr_irqs = __this_cpu_read(actual_nr_irqs);
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
> +		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
> +	};
> +
> +	if (counts) {
> +		for_each_irq_desc(i, desc) {

I would use:

		for (i = 0; i < local_nr_irqs; i++) {

It does not make sense to process IRQs where "counts_diff = 0;"

> +

> +			/*
> +			 * We need to bounds-check in case someone on a different CPU
> +			 * expanded nr_irqs.
> +			 */
> +			if (desc->kstat_irqs) {
> +				counts_diff = *this_cpu_ptr(desc->kstat_irqs);
> +				if (i < local_nr_irqs)
> +					counts_diff -= counts[i];
> +			} else {
> +				counts_diff = 0;

And it would allow to remove this branch.

> +			}
> +			tabulate_irq_count(irq_counts_sorted, i, counts_diff,
> +					   NUM_HARDIRQ_REPORT);
> +		}

Please, add an empty line here.

Empty lines helps to read the code. For example, they help to make
clear that a top-level comment describes a particular block of code.
Or they helps to see where { } blocks end.

Long blobs of core are hard to read for me. Maybe, I suffer with some
level of dislexia but I know many more people who prefer this.

Heh, I would personally add empty lines on several other locations.

> +		/*
> +		 * We do not want the "watchdog: " prefix on every line,
> +		 * hence we use "printk" instead of "pr_crit".
> +		 */
> +		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
> +		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);

for example here

> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
> +			if (irq_counts_sorted[i].irq == -1)
> +				break;

here

> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
> +			if (desc && desc->action)
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
> +				       i + 1, irq_counts_sorted[i].counts,
> +				       irq_counts_sorted[i].irq, desc->action->name);
> +			else
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
> +				       i + 1, irq_counts_sorted[i].counts,
> +				       irq_counts_sorted[i].irq);
> +		}

end here ;-)

> +		/*
> +		 * If the hardirq time is less than HARDIRQ_PERCENT_THRESH% in the last
> +		 * sample_period, then we suspect the interrupt storm might be subsiding.
> +		 */
> +		if (!need_counting_irqs())
> +			stop_counting_irqs();
> +	}
> +}
> +
> @@ -522,6 +654,18 @@ static int is_softlockup(unsigned long touch_ts,
>  			 unsigned long now)
>  {
>  	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
> +		/*
> +		 * If period_ts has not been updated during a sample_period, then
> +		 * in the subsequent few sample_periods, period_ts might also not
> +		 * be updated, which could indicate a potential softlockup. In
> +		 * this case, if we suspect the cause of the potential softlockup
> +		 * might be interrupt storm, then we need to count the interrupts
> +		 * to find which interrupt is storming.
> +		 */
> +		if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5) &&

(get_softlockup_thresh() / 5) might be replaced by sample_period.

Also it looks to strict. I would allow some small delay, e.g. 1 ms.

> +		    need_counting_irqs())
> +			start_counting_irqs();
> +
>  		/* Warn about unreasonable delays. */
>  		if (time_after(now, period_ts + get_softlockup_thresh()))
>  			return now - touch_ts;

Great work!

Best Regards,
Petr

