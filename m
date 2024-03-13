Return-Path: <linux-kernel+bounces-101307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB8487A559
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB3C1F22078
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840D38DCC;
	Wed, 13 Mar 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IJcz0Z64"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443522E648;
	Wed, 13 Mar 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323916; cv=none; b=EdKFTmBoZH1GKP1c6gen2yAb7cdBBnkfaTBXloRdvEI9QmxI2Mj+dU4Bd8yqsuRXRN5j9oBF/QtTNC2CtkoJWr3Tuy0U2nc/YiZfnPfKcx1IOL44iYp/rqq+kE+wmSkM7o4D1HEIG/M4WqQXZvYA8/3HZ9uaC8DPFS3AHdsr2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323916; c=relaxed/simple;
	bh=Pyr6sbLta6XA/WwgDcBt1QEtNKQ7PBqMIdcmu+Jw+vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP/k20CgqymVMvc1DxtDZyfQ+dxp7MPxySTZpfEd7xgVx1oVqkaNmSXRlSpN+xfLW7lYUsnYMft5HDbIEYs8odFeXXjHWllN0ULyoKe+nhKzi6pW9ZttJx9+wLCeIYA1WbQCujSceREO/vPLKA/ucHE0ptI4YhWMQK00ktVZ+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IJcz0Z64; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mdJE7f/PnZ2smKA3WG77nKatpIAuwm7s48XuayRiTKA=; b=IJcz0Z64AzrH70rSuvSDklejym
	Cw8MHGmobcoQvs0jo+e5bwJIV5ZZwfwiKPzwVpl25xkKBAzMyxuh7dGiL6iL4DCxbqDvpPV45S+9a
	+QSFBbAW2r6WhcUGy+yGBXCaK1vtASWT7BUiQS9UtG2XMHL6t1TvlrrEP+YsCKSVWluhZh4mascDE
	vo23qcJv19DBe0Ya5kIcLxeb6MESUPJIHQTjB4nui9GAx3inlYNSp8m/UMw9SAEBjlDBNwZjJH32Z
	sjtwkoc5RCboV0zb/x6J5l/yvbrjYKqvO88fG5Ya9Y0o5fN8TKOOMNDGuK+tNwjdwdhi2g3g88CJY
	XFEja1cw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkLNL-0007WT-2D;
	Wed, 13 Mar 2024 09:58:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkLNH-0004PW-P0; Wed, 13 Mar 2024 09:58:15 +0000
Date: Wed, 13 Mar 2024 09:58:15 +0000
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
Message-ID: <ZfF4t74OD4CgVaGV@shell.armlinux.org.uk>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
 <20240312221440.GA29419@willie-the-truck>
 <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
 <20240313003244.GA29568@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313003244.GA29568@willie-the-truck>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 13, 2024 at 12:32:44AM +0000, Will Deacon wrote:
> On Tue, Mar 12, 2024 at 10:39:30PM +0000, Russell King (Oracle) wrote:
> > On Tue, Mar 12, 2024 at 10:14:40PM +0000, Will Deacon wrote:
> > > On Sat, Mar 09, 2024 at 09:57:04AM +0000, Russell King (Oracle) wrote:
> > > > On Sat, Mar 09, 2024 at 08:45:35AM +0100, Stefan Wiehler wrote:
> > > > > diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> > > > > index 4204ffa2d104..4fc2c559f1b6 100644
> > > > > --- a/arch/arm/mm/context.c
> > > > > +++ b/arch/arm/mm/context.c
> > > > > @@ -254,7 +254,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > > > >             && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
> > > > >                 goto switch_mm_fastpath;
> > > > > 
> > > > > -       raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> > > > > +       local_irq_save(flags);
> > > > > +       arch_spin_lock(&cpu_asid_lock.raw_lock);
> > > > >         /* Check that our ASID belongs to the current generation. */
> > > > >         asid = atomic64_read(&mm->context.id);
> > > > >         if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
> > > > > @@ -269,7 +270,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > > > > 
> > > > >         atomic64_set(&per_cpu(active_asids, cpu), asid);
> > > > >         cpumask_set_cpu(cpu, mm_cpumask(mm));
> > > > > -       raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> > > > > +       arch_spin_unlock(&cpu_asid_lock.raw_lock);
> > > > > +       local_irq_restore(flags);
> > > > > 
> > > > >  switch_mm_fastpath:
> > > > >         cpu_switch_mm(mm->pgd, mm);
> > > > > 
> > > > > @Russell, what do you think?
> > > > 
> > > > I think this is Will Deacon's code, so we ought to hear from Will...
> > > 
> > > Thanks for adding me in.
> > > 
> > > Using arch_spin_lock() really feels like a bodge to me. This code isn't
> > > run only on the hot-unplug path, but rather this is part of switch_mm()
> > > and we really should be able to have lockdep work properly there for
> > > the usual case.
> > > 
> > > Now, do we actually need to worry about the ASID when switching to the
> > > init_mm? I'd have thought that would be confined to global (kernel)
> > > mappings, so I wonder whether we could avoid this slow path code
> > > altogether like we do on arm64 in __switch_mm(). But I must confess that
> > > I don't recall the details of the pre-LPAE MMU configuration...
> > 
> > As the init_mm shouldn't have any userspace mappings, isn't the ASID
> > entirely redundant? Couldn't check_and_switch_context() just simply
> > do the vmalloc seq check, set the reserved ASID, and then head to
> > switch_mm_fastpath to call the mm switch code?
> 
> Right, that's what I was thinking too, but I have some distant memories
> of the module space causing potential issues in some configurations. Does
> that ring a bell with you?

For 32-bit non-LPAE, I can't recall any issues, nor can I think of any
because module space is just another few entries in the L1 page tables
below the direct mapping (which isn't a problem because we don't use
anything in hardware to separate the kernel space from user space in
the page tables.) TTBCR is set to 0.

For LPAE, there may be issues there because TTBR0 and TTBR1 are both
used, and TTBCR.T1SZ is set non-zero to:

arch/arm/include/asm/pgtable-3level-hwdef.h:#define TTBR1_SIZE (((PAGE_OFFSET >> 30) - 1) << 16)

so I suspect that's where the problems may lie - but then module
mappings should also exist in init_mm (swapper_pg_dir) and should
be global.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

