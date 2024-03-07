Return-Path: <linux-kernel+bounces-96041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B038C875674
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63444282752
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A1135A45;
	Thu,  7 Mar 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cESIAX3T"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353612B143;
	Thu,  7 Mar 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837699; cv=none; b=WQOsGrD4jpQeC81r54n6JLg/jU43oXSPcCdOx/rUiEM4rSJKuhIDwQ3Cg3qo3PppuuERCuYqfC1PSCnfWOykEHN+kZ2941EHPXYPz7x502raQTuR79jDhITk++V5JHv2jl9UkQ2HiLxAOGcRA+tDPECokTTkFz5jJj4gC7XqwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837699; c=relaxed/simple;
	bh=IPI/16l0HW9qoe0SSsZfA8FdJBqoNMLGPnMIi/2JIMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHHAvSe97B/MsN4w1XtFds6s49wjI1lBZKfNhsdUyDnqhOUgrZWiegebVplPF4vmlDVu2Opw7AjFUv6Q8pJufhrUFAeCOig4TqdQg6E/g4bUj0Zwo836EqEgIPDWBR/kLnPHCltgeLeLMFsSzvKfj8MDK46wueAz6n+NYMxaLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cESIAX3T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NR0+Ie0LOl2eewPVHgTlvTXz4AW9q3B2J0v5cGLbxHY=; b=cESIAX3TafAWzXQgvkAgIo8lVm
	ggFPD0RsJ0CkCIvZY2t6emcF/qxlOiKgwtIJdGKDK5LugTyeTR3AMMwHNuseATbCjJBvgMHFUrcQ/
	+ol7BBfdRyWO+vFREBHq38pLTcxosZYvtGKxUrIEsrnRevpTezae1P4Y3cQ6TOpA9hBXruy2k1dpQ
	xkO5e3U5HJwm0GDlWQ1i2kj4sIvVPzPUI6fVrztiPxORFN5JeHtBaivSczwMtSKOYfWDn26KD22rv
	9PXxU7mmEzWhCG9jowBSw3gFeyZRIjZ3bx2a62RoBhfT9YdPkginRF95MOCF8M92o265gt+FmQX0A
	JFDAcvVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37862)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1riIt9-0001cn-0x;
	Thu, 07 Mar 2024 18:54:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1riIt4-0007SD-PX; Thu, 07 Mar 2024 18:54:38 +0000
Date: Thu, 7 Mar 2024 18:54:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <ZeoNbjTCAWYHgi4u@shell.armlinux.org.uk>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <49792f54-fa11-4984-8611-84ba640a2b86@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49792f54-fa11-4984-8611-84ba640a2b86@paulmck-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 07, 2024 at 09:45:36AM -0800, Paul E. McKenney wrote:
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 3431c0553f45..6875e2c5dd50 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
> >  {
> >  	unsigned int cpu = smp_processor_id();
> >  
> > +	/*
> > +	 * Briefly report CPU as online again to avoid false positive
> > +	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
> > +	 * spinlock.
> > +	 */
> > +	rcutree_report_cpu_starting(cpu);
> >  	idle_task_exit();
> > +	rcutree_report_cpu_dead();
> >  
> >  	local_irq_disable();
> 
> Both rcutree_report_cpu_starting() and rcutree_report_cpu_dead() complain
> bitterly via lockdep if interrupts are enabled.  And the call sites have
> interrupts disabled.  So I don't understand what this local_irq_disable()
> is needed for.

I think that's a question for this commit:

commit e78a7614f3876ac649b3df608789cb6ef74d0480
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jun 5 07:46:43 2019 -0700

Before this commit, arch_cpu_idle_dead() was called with IRQs enabled.
This commit moved the local_irq_disable() before calling
arch_cpu_idle_dead() but it seems no one looked at the various arch
implementations to clean those up. Quite how arch people are supposed
to spot this and clean up after such a commit, I'm not sure.

The local_irq_disable() that you're asking about has been there ever
since the inception of SMP on 32-bit ARM in this commit:

commit a054a811597a17ffbe92bc4db04a4dc2f1b1ea55
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Wed Nov 2 22:24:33 2005 +0000

Where cpu_die() was later renamed to arch_cpu_idle_dead(). So it's
purely a case of a change being made to core code and arch code not
receiving any fixups for it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

