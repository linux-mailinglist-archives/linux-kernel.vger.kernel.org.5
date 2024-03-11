Return-Path: <linux-kernel+bounces-99189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41368784A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE41F21AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25B4EB47;
	Mon, 11 Mar 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aH/jcMKr"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064E4E1C4;
	Mon, 11 Mar 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173352; cv=none; b=ps20j/DN+3yHXdQrh1ZHODSRB5iTampoqm35MF/9VuzF8+KI25SHwospOjjWLh/5Ip2areWSVePKftvBfHkjwVWN5IhcoEQWaFg0/HaUJ85ykpILSUh+E5PgJsXUToQ/HbWvPSbexIkO0scQpzaaDMRjVUw4OP9WXfbVrhfADcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173352; c=relaxed/simple;
	bh=kTp7lbSnNsLXpKG9Si9MQlEjAV3o+Nw/JNd9X+rl1zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht2eFDibDDlCwkVuBE9RsjyWh9qZopN7OmRyoipJNmWXn9Ue9Hh5LWVPRZYk1vOBsbX3gbxN44W7Pwas5ZGDDCgaJUTokWu9M77jUtjpuKqezoXzU1bIrxDQlA7xW1nKlNC4SJW9sfZfx570/jfvtG57obVp9YQ+ix5necckEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aH/jcMKr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WxV7yBtzK9mHqXYf7INRFe7VyuknYzJqDnF8rARYuuw=; b=aH/jcMKr2anfzzBa3l1TDS7A17
	sb/8qSMaWZSrxaZnGuefRe67F3Nbf1yynHQ7WZRjOmr+WiGYSSIu3CGqVuO/CG5EF4647VGuqhXJr
	DuOei5PL7SLgcHhTZJcEPKOYx1UE6bESD/4bq2iIMOdpq2TajGQIcHdEKaJCb0Y5IouE1kq5uoFfI
	dROfwL8BGaAp91Vt9L85/gIUtRDGignUMVkz0pmY5LGiaiLH7IgQQJoH9mGs1R9jMKAzDRUtCIODt
	61vc+HIx/q1B9uYBMqJUWhhVLNkvfYHK4SU8/yaKuH83g484P3dfyAQjyYy8lgGciToNJyIxSwoi4
	QnkKNCtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rjiCw-0005QN-0o;
	Mon, 11 Mar 2024 16:08:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rjiCt-0002iw-Ay; Mon, 11 Mar 2024 16:08:55 +0000
Date: Mon, 11 Mar 2024 16:08:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <Ze8sl01dgGTLcREs@shell.armlinux.org.uk>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 07, 2024 at 05:09:51PM +0100, Stefan Wiehler wrote:
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> one can trigger the following Lockdep-RCU splat on ARM:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.8.0-rc7-00001-g0db1d0ed8958 #10 Not tainted
>   -----------------------------
>   kernel/locking/lockdep.c:3762 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   RCU used illegally from offline CPU!
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by swapper/1/0.
> 
>   stack backtrace:
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-00001-g0db1d0ed8958 #10
>   Hardware name: Allwinner sun8i Family
>    unwind_backtrace from show_stack+0x10/0x14
>    show_stack from dump_stack_lvl+0x60/0x90
>    dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1a0
>    lockdep_rcu_suspicious from __lock_acquire+0x11fc/0x29f8
>    __lock_acquire from lock_acquire+0x10c/0x348
>    lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>    _raw_spin_lock_irqsave from check_and_switch_context+0x7c/0x4a8
>    check_and_switch_context from arch_cpu_idle_dead+0x10/0x7c
>    arch_cpu_idle_dead from do_idle+0xbc/0x138
>    do_idle from cpu_startup_entry+0x28/0x2c
>    cpu_startup_entry from secondary_start_kernel+0x11c/0x124
>    secondary_start_kernel from 0x401018a0
> 
> The CPU is already reported as offline from RCU perspective in
> cpuhp_report_idle_dead() before arch_cpu_idle_dead() is invoked. Above
> RCU-Lockdep splat is then triggered by check_and_switch_context() acquiring the
> ASID spinlock.
> 
> Avoid the false-positive Lockdep-RCU splat by briefly reporting the CPU as
> online again while the spinlock is held.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

So what do I do about this? I see you submitted this to the patch system
on the 8th March, but proposed a different approach on the 9th March. I
don't see evidence that Paul is happy with the original approach either
and there's no ack/r-b's on anything here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

