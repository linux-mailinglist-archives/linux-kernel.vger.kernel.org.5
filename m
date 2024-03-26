Return-Path: <linux-kernel+bounces-119496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FD88C9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B5EB243B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E017BA0;
	Tue, 26 Mar 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0L+gOje"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04E14A82
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471611; cv=none; b=RPUjThH94eqCXwjzV9A1gIF8O5i5TM/UV0Faw+q98qh447QeMpvdukHLEA4DCE9Mrs+Nk7FG1iIJzPXVIFtqcqE1RQyJQbyGdZw1KibN1uK8btQnm016ncg9OELy6X0Lg+WROqrky92I6rLaKTBm/wnbeEGfWdsWm0KFicUpVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471611; c=relaxed/simple;
	bh=TjizBl5fTdirAVYLMBFY14ay2KbScOAk50MLwJ9ycJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIn/uakxrsS7AhhI5qQRVtHQn/ZVnb0CvArIzmBMhOwvGF8HaMMXaVcSXZq1O43i6rgiOygapAnyvpSBgjGv2tDIlEYkWMxdbh6y+0bZfpqPlFupQ5Vp5rv0ESQV4YpqIVSq7nKq1TdEk65/NiazYmn8hSMSMOO4aqBFcwmZGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0L+gOje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475FC433F1;
	Tue, 26 Mar 2024 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471611;
	bh=TjizBl5fTdirAVYLMBFY14ay2KbScOAk50MLwJ9ycJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0L+gOjexMKnKGWpTZ9nDGrG2131IeHyn1P8YvU1Qv24kATa0FT2OhDfOQSy4FDMW
	 AnDWr/eqJtkK9dQPb04Ip69yQk3XQSKjr+/3hlf4Pu9k9+VNUINTPkDa1IBqK1UI+/
	 P65trwCu1qY33WpWchVMNRDQxj2PzlYLcXUkyDLX2bEgmd2rDpMMdqEPXa/qXsGp9M
	 tXwOAKpxqLdGaOlhOefEaNoI4SaDu9xZ+vHQI3nfWyplcP1uQgO8poHS+CDfTX2+HZ
	 bPIAj/N2hFo6FQ1NVcJjurI0BIP70yUo9nOPXBLIJjJNNIW0HXy61c2d8mrIDXklp6
	 30fihUl/no1AQ==
Date: Wed, 27 Mar 2024 00:33:35 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] clocksource/drivers/timer-clint: Add T-Head C9xx
 clint support
Message-ID: <ZgL434xHzYqpcdwD@xhacker>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-6-jszhang@kernel.org>
 <72eac56e-61d4-e42f-cfbd-8bcc35ed7bb6@gmail.com>
 <ZgIj8QQ7zO_eSZcA@xhacker>
 <ZgIlXWLymVd8XwFc@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgIlXWLymVd8XwFc@xhacker>

On Tue, Mar 26, 2024 at 09:31:14AM +0800, Jisheng Zhang wrote:
> On Tue, Mar 26, 2024 at 09:25:09AM +0800, Jisheng Zhang wrote:
> > On Mon, Mar 25, 2024 at 03:22:11PM -0700, Bo Gan wrote:
> > > On 3/25/24 9:40 AM, Jisheng Zhang wrote:
> > > > The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> > > > implement such support.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >   drivers/clocksource/timer-clint.c | 24 ++++++++++++++++++++++++
> > > >   1 file changed, 24 insertions(+)
> > > > 
> > > > diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> > > > index 4537c77e623c..71188732e8a3 100644
> > > > --- a/drivers/clocksource/timer-clint.c
> > > > +++ b/drivers/clocksource/timer-clint.c
> > > > @@ -34,6 +34,7 @@ static unsigned int clint_ipi_irq;
> > > >   static u64 __iomem *clint_timer_cmp;
> > > >   static unsigned long clint_timer_freq;
> > > >   static unsigned int clint_timer_irq;
> > > > +static bool is_c900_clint;
> > > >   #ifdef CONFIG_SMP
> > > >   static void clint_send_ipi(unsigned int cpu)
> > > > @@ -88,6 +89,19 @@ static int clint_clock_next_event(unsigned long delta,
> > > >   	return 0;
> > > >   }
> > > > +static int c900_clint_clock_next_event(unsigned long delta,
> > > > +				       struct clock_event_device *ce)
> > > > +{
> > > > +	void __iomem *r = clint_timer_cmp +
> > > > +			  cpuid_to_hartid_map(smp_processor_id());
> > > > +	u64 val = clint_get_cycles64() + delta;
> > > > +
> > > > +	csr_set(CSR_IE, IE_TIE);
> > > Perhaps you should do a writel_relaxed(-1, r) here. just like openSBI, because the update
> > > to mtimecmp is now split into 2 parts.
> > > https://github.com/riscv-software-src/opensbi/blob/v1.4/lib/utils/timer/aclint_mtimer.c#L54

Hi,

The reason of "writel_relaxed(-1, r)" is to avoid spurious irq, this is
well explained by riscv spec. 
After more thoughts, this is not needed here in linux kernel because
set_next_event() is only called in ISR, so the irq has been disabled,
we don't suffer from spurious irq problem.

Thanks
> > 
> > Thanks, I also noticed the mtimecmp update on 32bit platforms doesn't
> > strictly follow the riscv spec:
> > 
> > # New comparand is in a1:a0.
> > li t0, -1
> > la t1, mtimecmp
> > sw t0, 0(t1) # No smaller than old value.
> > sw a1, 4(t1) # No smaller than new value.
> > sw a0, 0(t1) # New value.
> > 
> > So A new bug fix patch will be added in v2.
> > 
> 
> wait, I found a similar bug in timer-riscv.c, and since these are fixes,
> I'd like to send fixes as a seperate series. I'm cooking the patches
> 
> > 
> > > 
> > > > +	writel_relaxed(val, r);
> > > > +	writel_relaxed(val >> 32, r + 4);
> > > > +	return 0;
> > > > +}
> > > > +>   static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
> > > >   	.name		= "clint_clockevent",
> > > >   	.features	= CLOCK_EVT_FEAT_ONESHOT,
> > > > @@ -99,6 +113,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
> > > >   {
> > > >   	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> > > > +	if (is_c900_clint)
> > > > +		ce->set_next_event = c900_clint_clock_next_event;
> > > > +
> > > >   	ce->cpumask = cpumask_of(cpu);
> > > >   	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
> > > > @@ -233,5 +250,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
> > > >   	return rc;
> > > >   }
> > > > +static int __init c900_clint_timer_init_dt(struct device_node *np)
> > > > +{
> > > > +	is_c900_clint = true;
> > > > +	return clint_timer_init_dt(np);
> > > > +}
> > > > +
> > > >   TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
> > > >   TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> > > > +TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", clint_timer_init_dt);
> > > > 
> > > Better use a more generic term to describe the fact that mtimecmp doesn't support
> > > 64-bit mmio, just like what openSBI is currently doing, instead of making it c900 specific:
> > 
> > This has been mentioned in commit msg, but adding a code comment seems fine.
> > > 
> > > https://github.com/riscv-software-src/opensbi/blob/v1.4/lib/utils/timer/fdt_timer_mtimer.c#L152
> > > 
> > > Then your `is_c900_clint` becomes something like `timecmp_64bit_mmio`.
> > > 
> > > Bo

