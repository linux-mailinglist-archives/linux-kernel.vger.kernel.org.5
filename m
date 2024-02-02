Return-Path: <linux-kernel+bounces-50189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68343847584
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00056B21912
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208A149005;
	Fri,  2 Feb 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cMJIXxyu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHqg+SZw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC61487D0;
	Fri,  2 Feb 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893354; cv=none; b=jUVbQmEggjkjPGVRRiPjM7wSmaOCNUy7wesV9RxYxWxcyJ96z3QMTclLya/eJJ1gg4vZLZaJFW9hpC88SZFCnKXSb1Jf5uRB8brSY1jCtoj8CCyxM/7ZXWPgjPRVnKz09J2V3zY1aaYXDxZh34uNgsAQcgEnr3yFFwGYWgY0oHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893354; c=relaxed/simple;
	bh=KoX8uvs6sRAFq3Wu/LCxCrn4njxS++aM7O+B0NSHNog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PtjAzI7wxKq/Cq1dpX8t0snWqnZR+RKRXosba2IV69XlIn+RvfQ+RZtGpNDiYVlLzT3KKodvtD3E25DWh+xQJZa1WV3o91C++00CeZfHL/fNXWGptIkMMOtf1yiyDXgufcjno4xpJ0QqqHdPU8OSPQ8iqmuVdfpjRVir3o24a+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cMJIXxyu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHqg+SZw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706893351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UyVSWbQkjqdlMyzs2zo2iOAjvlC5wSsBEpWz41rzt8=;
	b=cMJIXxyu3FpXaPwttxUh05Hh+nhzyRTB4D0oE+vmhuAvAMuykBxvo35/XrIf9s6KL4mMrk
	f5JicRFyVO3XhZL5bBDyzuogKloWdsq0IdGjf/IG5lyCXYl3WvGwq5+zzrJwdk/1dapvHK
	RkRv4q8JQKXwx6o+NWyap6baBaMiuccpor1la4mlJ6RaQUlW0z9EOk7A06JCOfrEhzUB1v
	Reca1LorwafHL6429hzmM3tq428ytBATxPjP3pz7mni/msnuGEBstyzTbvlJOzDRlq2xsX
	mbPRf/dOCWeUcbQW59cY2IDeEDNubFUWYx3qj/4qogskj77NmroAaBi1c09mvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706893351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UyVSWbQkjqdlMyzs2zo2iOAjvlC5wSsBEpWz41rzt8=;
	b=dHqg+SZwoxX+61PGRb+zoPhE99YYjNw6ZFYkAvMVeH12Ie5tb8vONXsRhnl2ODZwTes7lG
	NBKClq6VpuD9LEDg==
To: paulmck@kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
In-Reply-To: <7b5a386e-2dcf-49f1-a8e9-c46d2a9f8800@paulmck-laptop>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <87le83ara7.fsf@jogness.linutronix.de>
 <7b5a386e-2dcf-49f1-a8e9-c46d2a9f8800@paulmck-laptop>
Date: Fri, 02 Feb 2024 18:08:25 +0106
Message-ID: <87zfwibxzy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-02, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> The printk ringbuffer contents would certainly be interesting.
>> 
>> If you build the GDB scripts (CONFIG_GDB_SCRIPTS) then you will have:
>> 
>> (gdb) lx-dmesg
>
> This says no such command even though I do have CONFIG_GDB_SCRIPTS=y
> in my .config.

You actually need to build them as well. The target is "scripts_gdb"

And you probably need to add:

add-auto-load-safe-path /path/to/your/kernel/build/directory

to your .gdbinit

(This is documented in Documentation/dev-tools/gdb-kernel-debugging.rst)

>> As an alternative, you could copy the contents of
>> Documentation/admin-guide/kdump/gdbmacros.txt into your .gdbinit and
>> then will have:
>> 
>> (gdb) dmesg
>
> This one hangs.

:-/ I will look into this.

> On the other hand, next-20240202 doesn't show the problem.  No idea
> what might have changed.  :-/

Did you check the backtrace on all the "threads"? I would expect one of
them has tty in it and is probably deadlocked. There are known problems
that if a WARN or lockdep triggers while holding the port lock, that CPU
will deadlock itself. That has the effect that no output is generated,
but all the other CPUs will run fine. And even printk() calls will
happily store into the ringbuffer because they use trylock for printing
and the deadlocked CPU will be holding the lock.

John

