Return-Path: <linux-kernel+bounces-146573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19248A6776
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B31C2153A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B678624F;
	Tue, 16 Apr 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHaod8eq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA62907
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261108; cv=none; b=cHPt/xmFcNMwj9GTNpRDzsU9hv1JxWjL6cB1oOQU/mk3AXQHYRd3/E574eeZlCjvjzE5j6Uxwjsx4nJ2kIgXb++14cVcLFEZQoE75AWOx+zGV4pRwlcDHnkLGMyag76sq6OJjW32umF+aBOfEcKNWdUgEhXKLJsVxX7SHTbx2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261108; c=relaxed/simple;
	bh=gteI/DmouFD5OQxhjdH5ZZaky62/tQjR8yeIjjDgkws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pad5NSxBt3/r5i221jCtOcAiSaIvAdj48XzA/HfF2A6h2VXSXKLHMD8/HxRnnmeI44J6Kx42Sj75BPsSZXAhgwIb8vnUgbrE4DbKi/ZWYZv5/QeP+i5tAPZ/ApytY7NEJ4iLeKfhBtVHuhePM6iBGZdv1qq2T8jlFCgSSNm/fpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HHaod8eq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d3a470d5so4806870e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713261103; x=1713865903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fL9oRAEQBQvGhmNGMCM7exxQhRHWrknxFSUiFj28JAw=;
        b=HHaod8eqI9lgNVzWHm+2CcHLqPivJNCB2FsAew0xTKzlCED4iOPhL9oKq3PWXMqHVa
         S9rDLjL+R0+nEPHSqqS2KBRy4CNP9IUcD4BEfMetN7huSDhdsTXQWOT8kFAqcAVbGstP
         LluuuF9rv2bmmoCBdeoT85dM3BNy8ll0fls0cd6iOdEYnRytet9omRbUCJZ//tBKlU3o
         7ytiVi33QUENi6x/4xGoTDyXVO+Dyu/8IHhBT9bWEjwBt9qXmsTrIk3g7dJSLjpypjd+
         Q/i6T012dsRNpyICsM74KqT7gixnbfQqR2EB1nasZxFUMa7rCb/myD3EDIQKk41j1R60
         TowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261103; x=1713865903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL9oRAEQBQvGhmNGMCM7exxQhRHWrknxFSUiFj28JAw=;
        b=udZoQLn8kveqhMZc+PHueKlHBininy4T0Tzoj9FHhBMHbwiuTqeWEQqgLHgsaQMZnq
         xh1kKn7kNYv0rxqxA58SH+ZmQ35uWr/gIr3A6rYofu9Ndp2Ld0JuyhxxhrOHPSU5prRt
         G7U/HJPMKKgW6JmkK7aQCF5K4BEZMVm6DbNQAsZZd1zTb86wweIo2FGsY2MpxcxCEijZ
         p7w62SuPuNlXnQZqIHfS1ja4xgIqpfko2OepV3G7g68zGHSydf+2KqOniNG7ML3/KzIv
         1DrP4g7LrVgjctgy3GEGVU1FixVJkrzsJwhOa+vkL34jXI2GLw6+7idCI3PJIOeYnogh
         2I+w==
X-Forwarded-Encrypted: i=1; AJvYcCVTrBeOrxpZ0QiOBJ8MhKlY9WW3rmZfxtafefY87jbfSVHnZEyq4gHvKLZEE0ZEvu+C8B1UGv8bMM1s8+l1wYEkNuaE2xc2sAziWmY7
X-Gm-Message-State: AOJu0Yzh+qhiHxQ8CSpk2Z3IR+tFrbMCApMkMpZAHWmtLiCBMqFEOwrl
	nH6UWgUGhhYv4vhWFBMjYuaI6kA5qtUQs8+2PQogBuBe/c2yU//qDt4T6vh1EDw=
X-Google-Smtp-Source: AGHT+IFCJCSoio9mvk85DFr+4ST9x0ZdKGh3XfMdYankytdOA3BpIqnIkrMLkefDVVqGPXz5En4DFQ==
X-Received: by 2002:a05:6512:4021:b0:518:b886:5e16 with SMTP id br33-20020a056512402100b00518b8865e16mr7665164lfb.59.1713261103494;
        Tue, 16 Apr 2024 02:51:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d4534000000b003434f526cb5sm14323688wra.95.2024.04.16.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:51:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:51:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v4 27/27] lockdep: Mark emergency sections in
 lockdep splats
Message-ID: <Zh5J_dxNi0rHG9-I@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-28-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-28-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:29, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> lock debugging output are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/locking/lockdep.c | 91 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..80cfbe7b340e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5150,6 +5211,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  #endif
>  	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
>  		debug_locks_off();
> +		nbcon_cpu_emergency_enter();
>  		print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");
>  		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
>  		       curr->lockdep_depth, MAX_LOCK_DEPTH);
> @@ -5157,6 +5219,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  		lockdep_print_held_locks(current);
>  		debug_show_all_locks();

My concern is that the dump of all locks would not fit into the
buffer. And it might even trigger softlockup. See below.


>  		dump_stack();
> +		nbcon_cpu_emergency_exit();
>  
>  		return 0;
>  	}
> @@ -6609,6 +6688,7 @@ void debug_show_all_locks(void)
>  		pr_warn("INFO: lockdep is turned off.\n");
>  		return;
>  	}
> +	nbcon_cpu_emergency_enter();
>  	pr_warn("\nShowing all locks held in the system:\n");
>  
>  	rcu_read_lock();

The code dumping the locks looks like:

	for_each_process_thread(g, p) {
		if (!p->lockdep_depth)
			continue;
		lockdep_print_held_locks(p);
		touch_nmi_watchdog();
		touch_all_softlockup_watchdogs();
	}

I see two problems here:

1. I belive that the watchdogs are touched for a reason. And they will
   be useless when we print everything in a single emergency context
   and emit all messages at the end.

2. The default config LOG_BUF_SHIFT is 17. So the default kernel
   buffer size is 128kB. The number of messages is bound by
   the number of processes. I am afraid that all messages might
   not fit into the buffer.


I see two solutions:

1. Take the emergency context only around single dump:

		nbcon_cpu_emergency_enter();
		lockdep_print_held_locks(p);
		nbcon_cpu_emergency_exit();


2. Explicitely flush the printk buffer here. Something like:

		lockdep_print_held_locks(p);
		nbcon_cpu_emergency_flush();
		touch_nmi_watchdog();
		touch_all_softlockup_watchdogs();


, where nbcon_cpu_emergency_flush() would do something like:

/**
 * nbcon_cpu_emergency_flush - Explicitly flush consoles in
 *	the middle of emergency context.
 *
 * Both nbcon and legacy consoles are flushed.
 *
 * It should be used only when there are too many messages printed
 * in emergency context, for example, printing backtraces of all
 * CPUs or processes. It is typically needed when the watchdogs
 * have to be touched as well.
 *
void nbcon_cpu_emergency_flush()
{
	/* The explicit flush is needed only in the emergency context. */
	if (!nbcon_get_cpu_emergency_nesting())
		return;

	nbcon_atomic_flush_pending();

	if (printing_via_unlock && !in_nmi()) {
		if (console_trylock())
			console_unlock();
	}
}


I like the 2nd solution. The rule is more or less clear. The
explicit flush is needed when the the code needed to touch watchdogs.

Maybe, we should go even further and call the flush directly
from the touch_*_*watchdog() API. It has effect only in emergency
context.

Best Regards,
Petr

