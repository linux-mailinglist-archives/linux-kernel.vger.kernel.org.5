Return-Path: <linux-kernel+bounces-147082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29ED8A6F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118D41C20F09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90016130A6E;
	Tue, 16 Apr 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rteGUkYQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7aQ0kI1r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1312F392
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279705; cv=none; b=gE88gXrkGhzvVQ3laSH2VaDamNrTIXqteyXCEAXjJSoNoRNnkV6u6omk8QOP/PF5kOXb4KLTtd9RdZXiNFiJbf9zdbHkOP0AKalIWR9no1l3vSPQxD0Xx5CI2KeKBSeIwz2crYxG+GHZJSd/n76tSV9VM00JRUwjjAW2z/Jj6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279705; c=relaxed/simple;
	bh=U30r8qeWbLSvVDks9kSWg/aAF9CIJ6iWpVCMPbFMYyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RIXNiSbXUfUrM033Oo5NGssFBYsDElELb4DcXmzHPg/1iiGTaQlD1/EmIu1ZGsQ7OBja5rpyvcWVcfiym2lGFaQEZ8wocfXBydaZh+1Sji0SO1jRGwMD3dcZKVzfagFV/DDCkTp9lc8RlhoMiq9TtRZVXSPmzLoiy1uumacPmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rteGUkYQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7aQ0kI1r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713279701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXY55BRjBjcreZcwsGvhujVf1OOhXpzdQIFJ/yi4pGU=;
	b=rteGUkYQ7CPJX+kyGpR1JtxvKKemUitJKiqRQMzP/COq3A3xf+a2grrtF+Z6ppGQg7WlAf
	3K3Nk0w87a3oxsDGE5lslx/jkqDxSAYxWxn/WGfSO8oj9fPUiehGNXrsVFAg3zgYV0tHlY
	g3ov82u5JIOlRc6PKAo5STdHZ+GMSg+IrrzoaU9jw6QWHRuLUYm2sADLawJ/TyL8e0rHDi
	m1iuwlUgFuMTW+/4zjACeQJaLmMTzawY69L08h19/q3LztTiHyrb6FTMoNLWI1Paq8GPKI
	UXfdpYdW6dsmmqv3INePZnkMinbkNuTPkaKiH4jbgGWi4aUreEaF+foh06AXrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713279701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXY55BRjBjcreZcwsGvhujVf1OOhXpzdQIFJ/yi4pGU=;
	b=7aQ0kI1rtCdPcG1Zneozvmb2p9x+ttLnaU/d09cqk+QocyRYjqMSwS67fItbyLth2ydPWp
	uHTJ9QX6ihYrh0Cw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
In-Reply-To: <ZhUIatzxietD4F-m@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
 <ZhUIatzxietD4F-m@localhost.localdomain>
Date: Tue, 16 Apr 2024 17:07:39 +0206
Message-ID: <87y19djqr0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-09, Petr Mladek <pmladek@suse.com> wrote:
>> Console drivers typically must deal with access to the hardware
>> via user input/output (such as an interactive login shell) and
>> output of kernel messages via printk() calls.
>> 
>> Follow-up commits require that the printk subsystem is able to
>> synchronize with the driver. Require nbcon consoles to implement
>> two new callbacks (device_lock(), device_unlock()) that will
>> use whatever synchronization mechanism the driver is using for
>> itself (for example, the port lock for uart serial consoles).
>
> We should explain here the bigger picture, see my comment
> of the word "whenever" below.
>
> <proposal>
> Console drivers typically have to deal with access to the hardware
> via user input/output (such as an interactive login shell) and
> output of kernel messages via printk() calls.
>
> They use some classic locking mechanism in most situations. But
> console->write_atomic() callbacks, used by nbcon consoles,
> must be synchronized only by acquiring the console context.
>
> The synchronization via the console context ownership is possible
> only when the console driver is registered. It is when a particular
> device driver is connected with a particular console driver.
>
> The two synchronization mechanisms must be synchronized between
> each other. It is tricky because the console context ownership
> is quite special. It might be taken over by a higher priority
> context. Also CPU migration has to be disabled.
>
> The most tricky part is to (dis)connect these two mechanism during
> the console (un)registration. Let's make it easier by adding two new
> callbacks: device_lock(), device_unlock(). They would allow
> to take the device-specific lock while the device is being
> (un)registered by the related console driver.
>
> For example, these callbacks would lock/unlock the port lock
> for serial port drivers.
> </proposal>

I do not like this proposal. IMHO it is focussing only on nbcon
registration details (a corner case) rather than presenting the big
picture.

Yes, we will use these callbacks during registration/unregistration to
avoid some races, but that is just one usage (and not the primary
one). The main reason these callbacks exist is to provide driver
synchronization when printing.

We want to avoid using nbcon console ownership contention whenever
possible. In fact, there should _never_ be nbcon console owership
contention except for in emergency or panic situations.

In the normal case, printk will use the driver-specific locking for
synchronization. Previously this was achieved by implementing the
lock/unlock within the write() callback. But with nbcon consoles that is
not possible because the nbcon ownership must be taken outside of the
write callback:

con->device_lock()
nbcon_acquire()
con->write_atomic() or con->write_thread()
nbcon_release()
con->device_unlock()

How about this for the commit message:

printk: nbcon: Add callbacks to synchronize with driver

Console drivers typically must deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls. To provide the
necessary synchronization, usually some driver-specific locking
mechanism is used (for example, the port spinlock for uart
serial consoles).

Until now, usage of this driver-specific locking has been hidden
from the printk-subsystem and implemented within the various
console callbacks. However, for nbcon consoles, it is necessary
that the printk-subsystem uses the driver-specific locking so
that nbcon console ownership can be acquired _after_ the
driver-specific locking has succeeded. This allows for lock
contention to exist on the more context-friendly driver-specific
locking rather than nbcon console ownership (for non-emergency
and non-panic cases).

Require nbcon consoles to implement two new callbacks
(device_lock(), device_unlock()) that will use whatever
synchronization mechanism the driver is using for itself.

John

P.S. I think it makes more sense to use your proposal for the commit
message of the follow-up patch "printk: nbcon: Use driver
synchronization while registering".

