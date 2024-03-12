Return-Path: <linux-kernel+bounces-100901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7C879EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545D7B20E82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387D2B2D7;
	Tue, 12 Mar 2024 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c2HsHfC6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08516BE7D;
	Tue, 12 Mar 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283191; cv=none; b=JyAUotztMXdF3i9nNJCj+nyHfTEepI7gmtxJa57kFNzlmQoXChjZAL6MqHxdDkZ9/lQNeQLYY9MxRbLsV1phom2Rn7SuN6mHi9UxSxe5S2UnCfa7vDintKLysTdOmGYAYYT7mYkMcAoU1WQRHteUpVL4D3Fp04N56FDr5JUh5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283191; c=relaxed/simple;
	bh=lekLyCnOdnNs3oBm+2/covKa4A8rDcA1+veWI/xEDwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzr2v7ldyyub2aOODz7f6UmurXO33xStngVirIOrn4Lv8KKktF/8+FtgFOKWPomQjMf9bh337aqMCA6rS8aL0p7k5adpRicki1xKWvRn3eGVNg8QxSW5eSzMDWCD56gZ/0TnQqDfYHD84rARNz0dquzR+WkssLMp5ycxqoeZl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c2HsHfC6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IW00bxPf22nPInwkJFq4lSI3c2JyJKalEpfx3FB1zio=; b=c2HsHfC6XSjDkTcQwXA2jzOKXe
	LzloQp8SVaLEZtyEuGkEJapALmFdG04UCmtczVakGuFATt2K1heprGge0+y2Z+kBJMgmc8EgeEKp2
	M4WKy/XAXnXwnibshvD+64inMS/ccfRe1uZ4gpIf543TGcFObvQY7BIFFyGXNqX2No0jk7eY1uqNM
	y/zTSzWKlE6BONMolApzpEtxgoc6oLbC+nkWL1gmFHy6mEa6CmJSVsKhNpP0H1ZN6V678KOHA2Je7
	/6FtbSlP5M8L2IbJq0rNP0GjkVfvneoxMOo6O3sRB+rxDidLXT/FpadKFLtj9tmHW4iNSoYh2E9bL
	OqAOpAoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkAmV-00072y-1h;
	Tue, 12 Mar 2024 22:39:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkAmQ-0003uo-NL; Tue, 12 Mar 2024 22:39:30 +0000
Date: Tue, 12 Mar 2024 22:39:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Will Deacon <will@kernel.org>
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
 <20240312221440.GA29419@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312221440.GA29419@willie-the-truck>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 12, 2024 at 10:14:40PM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Sat, Mar 09, 2024 at 09:57:04AM +0000, Russell King (Oracle) wrote:
> > On Sat, Mar 09, 2024 at 08:45:35AM +0100, Stefan Wiehler wrote:
> > > diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> > > index 4204ffa2d104..4fc2c559f1b6 100644
> > > --- a/arch/arm/mm/context.c
> > > +++ b/arch/arm/mm/context.c
> > > @@ -254,7 +254,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > >             && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
> > >                 goto switch_mm_fastpath;
> > > 
> > > -       raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> > > +       local_irq_save(flags);
> > > +       arch_spin_lock(&cpu_asid_lock.raw_lock);
> > >         /* Check that our ASID belongs to the current generation. */
> > >         asid = atomic64_read(&mm->context.id);
> > >         if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
> > > @@ -269,7 +270,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > > 
> > >         atomic64_set(&per_cpu(active_asids, cpu), asid);
> > >         cpumask_set_cpu(cpu, mm_cpumask(mm));
> > > -       raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> > > +       arch_spin_unlock(&cpu_asid_lock.raw_lock);
> > > +       local_irq_restore(flags);
> > > 
> > >  switch_mm_fastpath:
> > >         cpu_switch_mm(mm->pgd, mm);
> > > 
> > > @Russell, what do you think?
> > 
> > I think this is Will Deacon's code, so we ought to hear from Will...
> 
> Thanks for adding me in.
> 
> Using arch_spin_lock() really feels like a bodge to me. This code isn't
> run only on the hot-unplug path, but rather this is part of switch_mm()
> and we really should be able to have lockdep work properly there for
> the usual case.
> 
> Now, do we actually need to worry about the ASID when switching to the
> init_mm? I'd have thought that would be confined to global (kernel)
> mappings, so I wonder whether we could avoid this slow path code
> altogether like we do on arm64 in __switch_mm(). But I must confess that
> I don't recall the details of the pre-LPAE MMU configuration...

As the init_mm shouldn't have any userspace mappings, isn't the ASID
entirely redundant? Couldn't check_and_switch_context() just simply
do the vmalloc seq check, set the reserved ASID, and then head to
switch_mm_fastpath to call the mm switch code?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

