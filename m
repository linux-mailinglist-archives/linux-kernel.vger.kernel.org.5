Return-Path: <linux-kernel+bounces-150043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0728A9983
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC411F213F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068FE15F3FD;
	Thu, 18 Apr 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/TOSPfP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEVcYqVS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F815B578
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442227; cv=none; b=FzqJcKqtSvLYCfYD9HhZKbhkUSihbuhItfBUyETT30YBl6RUzBq+8aj5H1QXZfR2/JxFW2wY5rI2ipGL++Q8ge4bueTfDpXQTrJAlJ0vDj/cjkRvu4fSO6vyCXmKq6AYf5vx52nz6MozpH0J7kGeCiiYIvnqrr7q4iSGiZfCbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442227; c=relaxed/simple;
	bh=mmHxbgkvcdq7I9XxDoEzaG1qsDjLvp2IM6Ipv6u6XmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=txdYxvtqL8xa+1n0nNi4dig+8uT1NwnUX6hfLERThgw/cVPSJFkRDzJ4zN7/79Cv7YcanTGGnGx1qHs9YCyMY4qxnA/PuFQpAG6ZooRtRI2oF+BYJlR25HCTJaiowZw14AHSG4JnAWa2igertkEyS/alIV5bUM0HYIGK/6zBkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/TOSPfP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEVcYqVS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713442217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhpP4JnpNsRxYyCsXa/uiaJlYp5pfcUesjCAkban9ps=;
	b=n/TOSPfPFWMaiK/uaHOYZHBbNHp0DmUpgkpuw2jj98/lvwnKjb6gd6njGvNPsInU8JwdQO
	0IzMQgktOZ4HuAgQq0iGiyba8HYjNVrga7ixJ07C3salftCNWT0owgejewhRF8BBB5MCHv
	K9kmjdQxhVngj1JtpDQMcsBCPmmysIgnEC9YNxHoCrp6iQr+R+6GvEILYC4TBpNe5h3CQ5
	TxMSxuTeGtNybdfUe4Jd1JZce+OSlQkz2c+PPSnJd5rxc3D4U9I8XFNfSUifFrDFLR96i8
	YyLb1UpAqJKlyoRCYYrMGeasZMOPHdGWEaVs5KfbRcCAATJbbbinBhCz5XmlVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713442217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhpP4JnpNsRxYyCsXa/uiaJlYp5pfcUesjCAkban9ps=;
	b=SEVcYqVSFdKHuWo4xMfn1fFuZOCfsET5EguPBnsKQJkRBoaU8f0PJe/9nIqOtJSM2vvcft
	9sxml5Ab6hwh/4Dw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
In-Reply-To: <ZiD3FNBZh_iMOVWY@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
 <ZhUIatzxietD4F-m@localhost.localdomain>
 <87y19djqr0.fsf@jogness.linutronix.de> <Zh_IrB4MyHwU8OJE@pathway.suse.cz>
 <87bk68niod.fsf@jogness.linutronix.de> <ZiD3FNBZh_iMOVWY@pathway.suse.cz>
Date: Thu, 18 Apr 2024 14:16:16 +0206
Message-ID: <87h6fyswgn.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-18, Petr Mladek <pmladek@suse.com> wrote:
> I am not sure how it is done in other parts of kernel code where
> RT needed to introduce some tricks. But I think that we should
> really start mentioning RT behavior in the commit messages and
> and comments where the RT mode makes huge changes.

Yes, our motivation is RT. But these semantics are not RT-specific. They
apply to the general kernel locking model. For example, even for a !RT
system, it is semantically incorrect to take a spin_lock while holding a
raw_spin_lock.

In the full PREEMPT_RT series I have tried to be careful about only
mentioning PREEMPT_RT when it is really PREEMPT_RT-specific. For example
[0][1][2].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.9.y-rt-rebase&id=1564af55a92c32fe215af35cf55cb9359c5fff30

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.9.y-rt-rebase&id=033b416ad25b17dc60d5f71c1a0b33a5fbc17639

[2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.9.y-rt-rebase&id=7929ba9e5c110148a1fcd8bd93d6a4eff37aa265

> The race could NOT happen in:
>
>    + NBCON_PRIO_PANIC context because it does not schedule

Yes.

>    + NBCON_PRIO_EMERGENCY context because we explicitly disable
>      preemption there

Yes.

>    + NBCON_NORMAL_PRIO context when we ALWAYS do nbcon_try_acquire()
>      under con->device() lock. Here the con->device_lock() serializes
>      nbcon_try_acquire() calls even between running tasks.

The nbcon_legacy_emit_next_record() printing as NBCON_NORMAL_PRIO is a
special situation where write_atomic() is used. It is safe because it
disables hard interrupts and is never called from NMI context.

nbcon_atomic_flush_pending() as NBCON_NORMAL_PRIO is safe in !NMI
because it also disables hard interrupts. However,
nbcon_atomic_flush_pending() could be called in NMI with
NBCON_NORMAL_PRIO. I need to think about this case.

John

