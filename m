Return-Path: <linux-kernel+bounces-118259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7A88B6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF3B2A5AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBE2137E;
	Tue, 26 Mar 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnFneb4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2411C6BE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417100; cv=none; b=BtvcgiUVajOg29qS0cYlPUk2Xav3M5ejfZudkDMj7PzOX5i+F0wC2D/CWjGdQnNv02averJ0evO7b6KSuyRjewYccIqv7wRD3MIs96Tq8gsmHJ91mxx8ljYs+9hrR9zY5NuX4liPvpjAMkq6+zSixxtv3i0Vl66ZQ76Fo4Q7mjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417100; c=relaxed/simple;
	bh=2QmSDgizxHwgM0JsXY7MomEdeWiJFYIJPQyEwfyZHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMkufOHkbSt1OMHahuNW+C7jZdoshuhWK/kUcjdjwn/9sl4vrd34g7IyMCnzNKlhVnUJfsOqhyjTiouOD9K5Au8sgZPYC57/pwaS8Lk2TQpjfgtJfSUyrELPYLzHMsVLzFyeIhteKzIf/9xgNhTV/oga5wsDMEsjUr6gCuxYVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnFneb4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C26BC433C7;
	Tue, 26 Mar 2024 01:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711417100;
	bh=2QmSDgizxHwgM0JsXY7MomEdeWiJFYIJPQyEwfyZHMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnFneb4zrbWGl6dWZjfuzujftcLqyYgdagHWflTF9W5RnERRc9X27JwdIMjGurzfR
	 sB2MEeNGztEwXwlTJlkTF+GsUz2SuOhBJly06KrcghliwNstJoNGJ2lB6DWpwCyrFs
	 q4goIGmiuYW62nunftRrNlRNHmo21Ib7q4Swl/3qoa5D2ZTc95r63VL0ALGkeBqrhB
	 Dp/3E6aL+PkW3dB1AddGbEW/Xye5txlSiXtT/6q7TTqB1hVEDYiDMapV4rUAAOWWnX
	 B3EppRNoleZS92qgSz7oEN/KLKsGWb6AaghgOwoTv/yF/ilBT71pgLsJeSnWEohQ+m
	 P6lBGF26u0xmA==
Date: Tue, 26 Mar 2024 09:25:05 +0800
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
Message-ID: <ZgIj8QQ7zO_eSZcA@xhacker>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-6-jszhang@kernel.org>
 <72eac56e-61d4-e42f-cfbd-8bcc35ed7bb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72eac56e-61d4-e42f-cfbd-8bcc35ed7bb6@gmail.com>

On Mon, Mar 25, 2024 at 03:22:11PM -0700, Bo Gan wrote:
> On 3/25/24 9:40 AM, Jisheng Zhang wrote:
> > The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> > implement such support.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   drivers/clocksource/timer-clint.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> > index 4537c77e623c..71188732e8a3 100644
> > --- a/drivers/clocksource/timer-clint.c
> > +++ b/drivers/clocksource/timer-clint.c
> > @@ -34,6 +34,7 @@ static unsigned int clint_ipi_irq;
> >   static u64 __iomem *clint_timer_cmp;
> >   static unsigned long clint_timer_freq;
> >   static unsigned int clint_timer_irq;
> > +static bool is_c900_clint;
> >   #ifdef CONFIG_SMP
> >   static void clint_send_ipi(unsigned int cpu)
> > @@ -88,6 +89,19 @@ static int clint_clock_next_event(unsigned long delta,
> >   	return 0;
> >   }
> > +static int c900_clint_clock_next_event(unsigned long delta,
> > +				       struct clock_event_device *ce)
> > +{
> > +	void __iomem *r = clint_timer_cmp +
> > +			  cpuid_to_hartid_map(smp_processor_id());
> > +	u64 val = clint_get_cycles64() + delta;
> > +
> > +	csr_set(CSR_IE, IE_TIE);
> Perhaps you should do a writel_relaxed(-1, r) here. just like openSBI, because the update
> to mtimecmp is now split into 2 parts.
> https://github.com/riscv-software-src/opensbi/blob/v1.4/lib/utils/timer/aclint_mtimer.c#L54

Thanks, I also noticed the mtimecmp update on 32bit platforms doesn't
strictly follow the riscv spec:

# New comparand is in a1:a0.
li t0, -1
la t1, mtimecmp
sw t0, 0(t1) # No smaller than old value.
sw a1, 4(t1) # No smaller than new value.
sw a0, 0(t1) # New value.

So A new bug fix patch will be added in v2.


> 
> > +	writel_relaxed(val, r);
> > +	writel_relaxed(val >> 32, r + 4);
> > +	return 0;
> > +}
> > +>   static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
> >   	.name		= "clint_clockevent",
> >   	.features	= CLOCK_EVT_FEAT_ONESHOT,
> > @@ -99,6 +113,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
> >   {
> >   	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> > +	if (is_c900_clint)
> > +		ce->set_next_event = c900_clint_clock_next_event;
> > +
> >   	ce->cpumask = cpumask_of(cpu);
> >   	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
> > @@ -233,5 +250,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
> >   	return rc;
> >   }
> > +static int __init c900_clint_timer_init_dt(struct device_node *np)
> > +{
> > +	is_c900_clint = true;
> > +	return clint_timer_init_dt(np);
> > +}
> > +
> >   TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
> >   TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> > +TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", clint_timer_init_dt);
> > 
> Better use a more generic term to describe the fact that mtimecmp doesn't support
> 64-bit mmio, just like what openSBI is currently doing, instead of making it c900 specific:

This has been mentioned in commit msg, but adding a code comment seems fine.
> 
> https://github.com/riscv-software-src/opensbi/blob/v1.4/lib/utils/timer/fdt_timer_mtimer.c#L152
> 
> Then your `is_c900_clint` becomes something like `timecmp_64bit_mmio`.
> 
> Bo

