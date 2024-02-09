Return-Path: <linux-kernel+bounces-59147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CA84F204
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B7D1F22DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107566B5B;
	Fri,  9 Feb 2024 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2LuSMWC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eo7fJWGN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91D664DC;
	Fri,  9 Feb 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469925; cv=none; b=SLGLm3q6e4iQshz9oP774zqQ1kU53B9YWvTR4tiCKs1OraQS70xqW4tM6rQ+SyXMRuWKQC7mnnL/8Hk2ubgHFDmWc7AFrDNYoNJVCSlIHwzESyqCumHLmj9C0HUAZwo3VzhpqxinjyGRCzcVGHoQbvQ2NlVjn9wZCIdP+LUy/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469925; c=relaxed/simple;
	bh=theZ6OspXm/0i2No8y+xI4YUDPJBFyxgE/uTf9ebaKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcaFsXpl3w4VF54aJBfzW+XPFMwSI1Jtf8jomPpD2kG+/uPIhuVRsERVJD9D1Yns2PXkbByKOzBLhTVQHBkf/vv6by9EXef6h23RuRGfQmdNee8TAPmA4h5T7VVjNJR0Hle7xxg1dFTS8a+Q3gQmw3qAyyfMGjDGVxro1mmdgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2LuSMWC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eo7fJWGN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707469920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zsx4SlJA6ViAZgBmFf5oMXtVVZcOurzD7dailCPOcmg=;
	b=U2LuSMWCG4aTaxIS9EQYvjlfYf14ZGG3yAMpC/LSEdZPbr8hVLGYAilg8kGMb8WRZDgZLW
	xWQD7ZScqQqJwX18sMtobZaOz9e31KI74X01msggG0VaoAGIaUp89kQe7DaHW2vaGG9pqJ
	TtRJ7nKl5HeqT4pbOdw52NulBGFw/SFDFBU5qxb5JUy6To4FdrWYuX/Vz93fwuGnMU/Bsj
	5llch7OaHv9c/+w6xkhe3Kh5lgfQazBJoG1ywmBPy9+TZ6iT2t3yHxJpmFe4txXIn/S39E
	8XBhoEz1clbH75ZHF7NFLejLK/Hb8qDIORb3ff2k/8QfA4ZDeBaMvctc4uRffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707469920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zsx4SlJA6ViAZgBmFf5oMXtVVZcOurzD7dailCPOcmg=;
	b=eo7fJWGNe451HcaD4JeMH+h14mreK0oBdwPxhWnIFTUYXZaC7WARkMC9JqNm7FBaok4/1c
	OOolCXi6PyPZsqDQ==
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
 jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
In-Reply-To: <ZcQjxa4UA6hzXHnU@thinkpad2021>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
Date: Fri, 09 Feb 2024 10:17:48 +0106
Message-ID: <87v86yc88b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi John,

On 2024-02-07, "John B. Wyatt IV" <jwyatt@redhat.com> wrote:
> You asked me to test the upstream kernel with a printk torture
> (console_blash.sh) with the different scheduler settings on a very
> large core system. Wanted to post to the mailing list to show what I
> tested with.

Thanks for your efforts here!

> As far as I can tell; all the scheduler settings correctly get to and
> trip the sysrq trigger to make it crash at the end of the script.
>
> But, with every state, except for fully pre-emeptive, I got an NMI
> call trace before the sysrq trigger that expectedly crashes the
> system.
>
> This is on a Fedora 39 Server installed on a 2x56 core, 224 thread
> machine in Red Hat's lab with the lscpu below with 6.7.0-rt6. I have
> only decoded and attached NoForcedPreemption below. Please ask if you
> want additional ones but they all look similar when I checked.
>
> NMI Call Trace for NoForcedPreemption
> ---
> task:cpuhp/222       state:S stack:0     pid:1349  tgid:1349  ppid:2      flags:0x00004000
> Call Trace:
> <TASK>
> __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
> ? try_to_wake_up (./arch/x86/include/asm/preempt.h:104 ./include/linux/preempt.h:484 ./include/linux/preempt.h:484 kernel/sched/core.c:4217) 
> ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
> schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
> smpboot_thread_fn (kernel/smpboot.c:160) 
> kthread (kernel/kthread.c:388) 
> ? __pfx_kthread (kernel/kthread.c:341) 
> ret_from_fork (arch/x86/kernel/process.c:147) 
> ? __pfx_kthread (kernel/kthread.c:341) 
> ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
> </TASK>
> sysrq: Trigger a crash
> Kernel panic - not syncing: sysrq triggered crash
> NMI backtrace for cpu 56
> Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
> RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100)

I am curious why early_printk is here. Are you using KDB or KGDB?

Could you provide me your kernel config and boot args?

On a side note, it is helpful to use a kernel that prints timing and
caller information:

CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y

Timing information can also be turned on dynamically with the boot arg
"printk.time=1" but the caller information (which is more interesting)
can only be enabled in the kernel build.

John Ogness

