Return-Path: <linux-kernel+bounces-49958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4984720C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DA11F2C103
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC814533A;
	Fri,  2 Feb 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UjO9/ecV"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F072B9BB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884532; cv=none; b=RV9yfkVkeaY3S1oGU4CRvUwWV6DcAUjioW8racca2MuCr16yyIAlb8blsn5zchVtSjmKji+EIhGyfBE3U+NqHms4cyo+pDK7VCyJePUIsgVrGodajMuT+V0TIO0KCLdTJUOiiw/Dyn6qx3RZgEmn0oxFNE2FswGbgzkmNHkV1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884532; c=relaxed/simple;
	bh=4HTPW99u3wqlNp6Rv9yUxE8nx6RD09MRp/DTp8XNPyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNeDvy9tV7GL/2oze+pYityGWFrot5DNhEJEzuilEn1aQKWd5a7R9sSG3hmC5FHkHf1YClMkr0cy7Zi7UlEmtnUPcRkTkj28lQoUku+LlZYwuW8rBSnamMg1u6T5m4we2FLdfFTHOjA/JoPI7IZb8TewVu2cBtMtYel3Pg52umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UjO9/ecV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a370e63835cso80723466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706884528; x=1707489328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTXW/IgMSjYbmMUv1HG2gfGoIaBkbzHe0l/jl6UZwLo=;
        b=UjO9/ecVNR/RUm04u4QZKxgCHIA9a2v2SWleCJevZdtdE9voJWl1BHAMxwx+An0qaT
         dQWWgU6dIJ8MQt2CgoWMJL+YRq0/jxRyTM+qgZ1Onf4wVLe31m6zvFFRUgYmQxwCv0YN
         bPchINApGtEpAVoSEysAI6ZVB74NNKH1BqgU4tJsNRJugbBAVVfPIyqB0b/7h9w/FpPj
         QZvn6rGBnWIkv9Bsvdpypz7F8S3La5f5SnYrUS4pflsRaNPApQB5uduf1YhgC69WtgCn
         WQ2m4ngqgL1iakKye3WKhaBsopHA9vm+ZuA2GtlveOrDy1Wk5SMIvy1Dh9JiFAUVDeMz
         7mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884528; x=1707489328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTXW/IgMSjYbmMUv1HG2gfGoIaBkbzHe0l/jl6UZwLo=;
        b=ZdKhFPB2CFUzt+BYdD2r1MrqeQ4+gzIIPRAXuTwmv6uHjWOBWrEcoOnzamixUc/229
         XSQTXazaUe/crj2lYYdGubZabkCSMFpYDzBqVKfoIy7Wr9MWol59xvd0tiaFCQg+P3sC
         m429dzbFz79z/7wAckJjqQlXEs5n29tQOPlvDrb/2nAqUCp0jOjOhx6ES1mKKuyO4jG5
         NPvLkw8u/cVKLmkct9fvoixQI0eGPd6bN5+JyJ+jKWeQ/wbvaXY8XyTOPXLa3Ik0sEF/
         ra3CWWge9TuB2hwN4j06lzel0wrORkR8yzcbh0ohNhTT6Hvg6ep9ImepJYOzg6KRr/F9
         O+gQ==
X-Gm-Message-State: AOJu0YxyyvOpICugCrHgxP/EhsQpbwfGcEVsYpNrrbvrqFw1s5lXlHF2
	2qpF+woukqgcmXSY619FX5tIuAtwBXniW1kDt2fpOOIiU9uZ1bPP52iX4P/eOrI=
X-Google-Smtp-Source: AGHT+IFnvcF1Cgbp3auZh5Hvq7VVtHB9gdIUhyH3RjHaICfoQfPm9TKvtiW1TdbmnhPTjjxEN/xzcw==
X-Received: by 2002:a17:906:5399:b0:a36:fc06:6f7b with SMTP id g25-20020a170906539900b00a36fc066f7bmr1294273ejo.44.1706884528064;
        Fri, 02 Feb 2024 06:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3+2fQtHpjtsymH97+zaX2cVRDP0JvZtZ3prHAs/d0++TLMhL5qi+ITYLMFuhkLHeZ2QxJsvPpVrxMXdyNXt1U1yuU59BZkcijCPKsj1xAeB4j0NfUej06nU+S3NEO8ptT2KRNdG9s5v6/dkuRBKjLgjtZE0YGY5wC8eTwCeI77tedMJ7ndPZhX1sAnk/ro28jxc0KYcFbLI0NFy8wg2PlyhbDazwT+2j1+WJsctddRoip0+cNvcA5tnCgcdzZHNjTM9UkFNe2BUkfZfhzFveoD2kLh+CqjLbW
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090624ce00b00a3683b565fbsm924750ejb.187.2024.02.02.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:35:27 -0800 (PST)
Date: Fri, 2 Feb 2024 15:35:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <Zbz9rlGPbwBJMFLG@alley>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>

On Fri 2024-02-02 05:04:45, Paul E. McKenney wrote:
> Hello!
> 
> Starting with next-20240130 (and perhaps a bit earlier), rcutorture gets
> what initially looked like early-boot hangs, but only when running on
> dual-socket x86 systems [1], as it it works just fine on my x86 laptop [2].
> But when running on dual-socket systems, this happens all the time,
> perhaps because rcutorture works hard to split each guest OS across a
> socket boundary.
> 
> This is the reproducer:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "10*TREE01" --trust-make
> 
> By "looked like early-boot hangs" I mean that qemu was quite happy,
> but there was absolutely no console output.
> 
> Bisection identified this commit:
> 
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> 
> Reverting this commit made the problem go away.  Except that it is really
> hard to imagine this commit having any effect whatsoever on early boot
> execution.  Of course, this might be a failure of imagination on my part,
> so I enlisted the aid of gdb:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "TREE01" --trust-make --gdb
> 
> After following the resulting gdb startup instructions and waiting for
> about ten seconds, I hit control-C on the gdb window and then:
> 
> 	(gdb) bt
> 	#0  default_idle () at arch/x86/kernel/process.c:743
> 	#1  0xffffffff81e94d34 in default_idle_call () at kernel/sched/idle.c:97
> 	#2  0xffffffff810d746d in cpuidle_idle_call () at kernel/sched/idle.c:170
> 	#3  do_idle () at kernel/sched/idle.c:312
> 	#4  0xffffffff810d76a4 in cpu_startup_entry (state=state@entry=CPUHP_ONLINE)
> 	    at kernel/sched/idle.c:410
> 	#5  0xffffffff81e95417 in rest_init () at init/main.c:730
> 	#6  0xffffffff8329adf2 in start_kernel () at init/main.c:1067
> 	#7  0xffffffff832a5038 in x86_64_start_reservations (
> 	    real_mode_data=real_mode_data@entry=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:555
> 	#8  0xffffffff832a513c in x86_64_start_kernel (
> 	    real_mode_data=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:536
> 	#9  0xffffffff810001d2 in secondary_startup_64 ()
> 	    at arch/x86/kernel/head_64.S:461
> 	#10 0x0000000000000000 in ?? ()
> 	(gdb) print jiffies
> 	$1 = 4294676330
> 	(gdb) print system_state
> 	$2 = SYSTEM_RUNNING
> 
> In other words, the system really has booted, and at least one CPU is
> happily idling in the idle loop.  And another CPU is (maybe not quite
> so happily) running rcutorture:
> 
> 	(gdb) thread 6
> 	[Switching to thread 6 (Thread 1.6)]
> 	#0  0xffffffff8111160b in rcu_torture_one_read (
> 	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
> 	    at kernel/rcu/rcutorture.c:2003
> 	2003            completed = cur_ops->get_gp_seq();
> 	(gdb) bt
> 	#0  0xffffffff8111160b in rcu_torture_one_read (
> 	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
> 	    at kernel/rcu/rcutorture.c:2003
> 	#1  0xffffffff81111bef in rcu_torture_reader (arg=0x4 <fixed_percpu_data+4>)
> 	    at kernel/rcu/rcutorture.c:2097
> 	#2  0xffffffff810af3e0 in kthread (_create=0xffff8880047aa480)
> 	    at kernel/kthread.c:388
> 	#3  0xffffffff8103af1f in ret_from_fork (prev=<optimized out>,
> 	    regs=0xffffc900004abf58, fn=0xffffffff810af300 <kthread>,
> 	    fn_arg=0xffff8880047aa480) at arch/x86/kernel/process.c:147
> 	#4  0xffffffff8100247a in ret_from_fork_asm () at arch/x86/entry/entry_64.S:242
> 	#5  0x0000000000000000 in ?? ()
> 
> So the system really did boot and is running just fine.  It is just that
> there is no console output.  Details, details!
> 
> Is there anything I can do to some combination of workqueues and printk
> to help debug this?  Or that I can do to anything else, as I am not
> feeling all that picky.  ;-)

It really sounds strange. Console drivers should not use workqueues
at least for console->write() callbacks. The main reason is that
workqueues do not work in panic(). But it might bring many problems
even when the system is running "normally"

You wrote above that there was absolutely no console output so the problem
was from the very beginning.

I looks like that the consoles get blocked either during registration
of the first console or when trying to flush the first message.

Consoles, except for early consoles, are registered by
console_initcall(). And init calls are proceed when the workqueues
subsystem is already initialized. So, workqueues might
somehow affect console driver initialization and registration.

My first though was that the workqueues change might somehow
block synchronize_srcu() which is used when updating console_list.
But it not called during console registration. It is called only
during suspend, resume, and console unregistration. So, it should
not block the first boot messages.

My current theory is that the change in workqueues might somehow
block a console driver initialization. I think that some console
drivers might use workqueues for some tasks even though they
could not use them in the write() callback.

Could you please provide console log when the problematic patch
is disabled? I wonder what consoles drivers are registered and when.

Just to be sure. Does the rcu torture configuration modify the
behavior of srcu_read_lock_nmisafe() which is used by
console_srcu_read_lock()?

Best Regards,
Petr

