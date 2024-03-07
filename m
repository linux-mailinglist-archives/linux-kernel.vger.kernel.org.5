Return-Path: <linux-kernel+bounces-96036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C287565F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56589B228A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA81353EC;
	Thu,  7 Mar 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFm3B1NS"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608112B143;
	Thu,  7 Mar 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837452; cv=none; b=aDl0DK2LjtzIw1smhssDpJPP0IbKd0TLlZX0O0voCy+LuesHAkECDjN/nRml+vPHiPa36vi+wzZOothh7B+u++Xw83ZqrHfsYKrTrUc2+C3HABd4EDVl9Qzz3SU6+o5DBfyuaok5sLm8dC6K4GvbEjpcng+lkTzWX0QCLCAglEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837452; c=relaxed/simple;
	bh=C4ALz/gmT5Hu/bUcKMkjaNwL0v5hOa6tSVJrGi+aSIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhQ2x+RzmoNHYNwZAERNbL7whoWE8gxEw6mmcgvF++hZlhye3eM9Htj7c9DRnOJFxRT7+TKjAZdccC6QIshq9ZzpieZIgUOmd2Fk1Uj+QVEQGTyVWGHcEVFc8bmcAg6OKYcKHxTioQ3PrpJdv7s7lvibHX2wxXs1jS3YceY+se0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFm3B1NS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78831914027so5950785a.1;
        Thu, 07 Mar 2024 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837450; x=1710442250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf/Mj3BzGZKpoiOTKx5KymXugzcLyy+NNEJ46ZQm6pc=;
        b=RFm3B1NSopqkUEJIpMlgCqE1U6ymqq10CzbqSpTmBCBfwHu+xqAN8Y+psJOmrWJBCt
         SAZ/FmXnt76yjSnojkjWplo36KPhO4avt90MWO96f4tfyO265ILc6t3z+T5DDF0cbUpc
         zRi0Qov4z+gpP4Vrp+iGw/5eP4famtf4LyT/ll4gmnOTM1bbgls93n5k5ffxP111eSOd
         GUlT3hxiNOag5DBBk7O0UKZKre+BV1TS75IVIMOrLLLbsYSAhrv09MbTqjOJZSsqx/i1
         8cTb7AnercLLiZsIDDd8mraiRK3e9v1PdVom8p1VXYUswhG8rISEDeZpPTyUlcyICXjH
         VAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837450; x=1710442250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sf/Mj3BzGZKpoiOTKx5KymXugzcLyy+NNEJ46ZQm6pc=;
        b=NuIow1kJjrXgY6lbwgx0bqNPxq11A9FwJmfxV8kTq6jPJ5Ftioc5F/iMnBt8IE9fa6
         CBXlWbHkH+GUbGh1+Y5UjnEwTj7ENgVkQOnRt4FIvPIoz8zqX6Cj2NHukU6ZM433fvOe
         jvG1fQCT5vZ7KOsKIQNvWYMB6ppwftdLDt1dC/d2cansE6ZdyEjz1ubWq6v7T62LNDHZ
         uEzJfHL8Y0NT8Mdxj5IEAzKq+IZbuSK/4POpInjN2GqE6p4kYx2YCGBGX/patQGB3Et3
         9IzeMcFQXkA4GANBObOn3HeSsYtZOW23pHcajqqCOdX5fKdRth3qaXB3MC5H+LP31xhF
         zEbg==
X-Forwarded-Encrypted: i=1; AJvYcCU8QzZjo9qchFT3a+VOvW4N23bpgih7i0e112IDPNxcNnDxIQkdvfqlJBWvf5hPDfxZcZ3Gn8x3h6x1Y4OM35UbfBUYGxa2EdCel7xDAqfAzFLO6Bf03p6bMZ4PAM8i0ges
X-Gm-Message-State: AOJu0YzWsSUycYeS/5Eug3RZp66foinzDDBH/G0sTV6VkERBbWNQDQYk
	RsAia1xihugSMeJZ6HVpxt1x+r1xLnEDgh5mk/Is4Z9p52JbX8eC
X-Google-Smtp-Source: AGHT+IHJBaBGvoYxoVdhzF2YkImFqTt7kAT0cThOn47PelqcKokrA2FtS4u2q5ojr96oJ6JLK5cX1g==
X-Received: by 2002:a05:620a:918:b0:788:1c6e:35c with SMTP id v24-20020a05620a091800b007881c6e035cmr8545244qkv.72.1709837449887;
        Thu, 07 Mar 2024 10:50:49 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a04d300b0078838c7acbfsm2810654qks.42.2024.03.07.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:50:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9FB3B1200043;
	Thu,  7 Mar 2024 13:50:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 13:50:48 -0500
X-ME-Sender: <xms:hwzqZXN4gUAn0pFrX-5JfRD2PrrSt7GACpowfAxkFxrbsMSxYTtd0g>
    <xme:hwzqZR-3UdWEb0k4oa1lluTjweLs1bCUtiSQwlR0r9kFkhxSmQ1Ip7bizAgc8CRZP
    xAEj3zwht2e7BROOw>
X-ME-Received: <xmr:hwzqZWQqReg82vc6OsQNXlX0BxzdqFlNY79OKV3eALOYtRw_udRFnmmaFIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:iAzqZbtQnBpQbMIWyur65D1hbRHSuVR23X2SP20RUNcM96ZKvKYQqA>
    <xmx:iAzqZfclvpd3mHb5lMDLsLuWNvJPE-DC-rk7qbD40nKlkcw2QnVxDw>
    <xmx:iAzqZX2wrCRzbXhsRwGUzzvmE9d9QWmktdrsE3g_BYJ5lXWebN6JoA>
    <xmx:iAzqZa8xExed_fgXLs2mkJw6LH2MM8ed9I8YrQ4gwl4rQDjnaaw6UQj-tVc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 13:50:47 -0500 (EST)
Date: Thu, 7 Mar 2024 10:49:41 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <ZeoMRfy9ISBOVMsV@boqun-archlinux>
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

[Cc Frederic]

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

I'm not sure this is a false-positive: if you traverse an RCU-list
without RCU watching the CPU, then a grace period may pass, the next
list can be garbage and you can go anywhere from the list. Or am I
missing something that a CPU hotplug can block a grace period?

But codewise, it looks good to me. Although I hope we can avoid calling
rcutree_report_cpu_{starting,dead}() here and use something simple,
however after a few attempts, I don't find a better way.

Regards,
Boqun

> online again while the spinlock is held.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  arch/arm/kernel/smp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 3431c0553f45..6875e2c5dd50 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> +	/*
> +	 * Briefly report CPU as online again to avoid false positive
> +	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
> +	 * spinlock.
> +	 */
> +	rcutree_report_cpu_starting(cpu);
>  	idle_task_exit();
> +	rcutree_report_cpu_dead();
>  
>  	local_irq_disable();
>  
> -- 
> 2.42.0
> 

