Return-Path: <linux-kernel+bounces-97833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A80877022
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C551C20BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143B381C8;
	Sat,  9 Mar 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cqpEppfx"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE6376F4;
	Sat,  9 Mar 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709978251; cv=none; b=jVvW5ZMFfMkmS/vjpfSZbQIR3WzV61wOcvizrcjZTbtjlHXyG3R6987HElRqxvua3wi0/bfH/XKni9RWVFcVz34YXKC+90B5U9KLPFY0kAndBwxVOl6G44aVlAVNlTje2wD3paDjZ4lBupyvPb4xyiJztPw8fzc02HR0CXRnNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709978251; c=relaxed/simple;
	bh=Yq9LyfrM+ZjOvLE3P+ftgi/HA04Rc4K991bsHVDHfKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrJVoplDqDH1C6Km4z6hkK/fB//dAledmjn4Bz8Kwqktz/9x58wEG+acX+U2z+iAimdSPwQmKcwjK3gfvfcC9053NqXEgFj5ej+tptBtWsVrHYboNFole4WRkNDTa+xarEXWoJP4C4uEswM17HjXURsgIx53nELeAqkqnt+jzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cqpEppfx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ssepVLzl5NKMIkC/PseMyPpZmZ3pHbZYAJxnB3I/oWA=; b=cqpEppfxsrFkAyaR43ERaanrhE
	i2+Q8haXzU+0LKmPKF6ZLU/G8InKTOlGgDmamP9KKJ3q8c56Zw3iMLahKznCii6yCRKX2C8/C2oK/
	VQzyUDZ0se9zgG1YHqPZJlj0qFVTWkwwma26tK8b64tyjVoL5WfkeGwneg4zfpehcqbmMt7c/u29f
	AhQCbYFLypCEvQa2zdmM/KHL4iLTYrQiXK0VqVCcuEIZH0/SaXnY6VQnXvGH4VmDoJOYGDNN0t6l+
	/NnE7Juk7NgP4tzwArfKwhVCgD0wOTzIw9k6WG02F7MuN2FX+CAZSTxIhlQ/wAR8xFTSBvjAC43OL
	MRFBau2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51170)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ritS0-0003cn-2j;
	Sat, 09 Mar 2024 09:57:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ritRw-0000fu-Mi; Sat, 09 Mar 2024 09:57:04 +0000
Date: Sat, 9 Mar 2024 09:57:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Will Deacon <will@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <ZewycILled+mZhwe@shell.armlinux.org.uk>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 09, 2024 at 08:45:35AM +0100, Stefan Wiehler wrote:
> > I agree with the problem but disagree with the patch because it feels like a
> > terrible workaround.
> > 
> > Can we just use arch_spin_lock() for the cpu_asid_lock? This might require
> > acquiring the raw_lock within the raw_spinlock_t, but there is precedent:
> > 
> > arch/powerpc/kvm/book3s_hv_rm_mmu.c:245:
> > arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
> > 
> > IMO, lockdep tracking of this lock is not necessary or possible considering the
> > hotplug situation.
> > 
> > Or is there a reason you need lockdep working for the cpu_asid_lock?
> 
> I was not aware of this possibility to bypass lockdep tracing, but this seems
> to work and indeed looks like less of a workaround:
> 
> diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> index 4204ffa2d104..4fc2c559f1b6 100644
> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -254,7 +254,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
>             && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
>                 goto switch_mm_fastpath;
> 
> -       raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +       local_irq_save(flags);
> +       arch_spin_lock(&cpu_asid_lock.raw_lock);
>         /* Check that our ASID belongs to the current generation. */
>         asid = atomic64_read(&mm->context.id);
>         if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
> @@ -269,7 +270,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> 
>         atomic64_set(&per_cpu(active_asids, cpu), asid);
>         cpumask_set_cpu(cpu, mm_cpumask(mm));
> -       raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> +       arch_spin_unlock(&cpu_asid_lock.raw_lock);
> +       local_irq_restore(flags);
> 
>  switch_mm_fastpath:
>         cpu_switch_mm(mm->pgd, mm);
> 
> @Russell, what do you think?

I think this is Will Deacon's code, so we ought to hear from Will...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

