Return-Path: <linux-kernel+bounces-146825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEC8A6B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB560B22B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF812C54D;
	Tue, 16 Apr 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvSaZ708";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZDbJCOY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31812BF04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271989; cv=none; b=QMXsiZX6izkqKUKHisE3LHUtqedS8GgcNgGWkNChm7s89fe8TmLl6LGJ0KqyNE8sCCwPVcxXkf+2ABweT/DK69uez7PfiJV9zsg8A3FSYim388s6IH+3LuVY0dh6x1RfdICdZTwDExJKnlkpv9FLmdASXg0YZ3vk/emqAJCzLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271989; c=relaxed/simple;
	bh=CMFCl/rnVJq1sqUQE5VnVFZQ0yXU/chs4WFIUDzsXzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTT4Vylmqf1ziXkLed2oGKZR8eqHQFFXEsuT+wEWCMSfeTRbPj5G1CK9ahWFHzPvz57egwujRazGGW0JidfYpsjg47qVxj9le5kUR5/FSj2cVhYV/lxCk7yDnVcnmo3AS/sbwcwA03ozNK2AfuMmX+DjnbEXaoFZtosgVvUBfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvSaZ708; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZDbJCOY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713271986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMFCl/rnVJq1sqUQE5VnVFZQ0yXU/chs4WFIUDzsXzU=;
	b=zvSaZ708a/uUuxgccLv0dcyZ39dA2y9RaGJIuhBIQgynggywwHunG9csBrkiyCZa6lH4qo
	Uc69uKbG7f31/EJGihd2whdVrEjvdqD2/ctumVZynxc/kjxIuCUIJHFFmXbL/mLgpXfPgY
	eWTEsriwC/prOythazvoe83npAa8esuqf8R0XlRBwSsZ1V+KMh+4k8DYsdyKk559JtKkDN
	rbvvRb9Lwm5FTlbXsDBEwYNpcHLrWm4reggtVd9nF9gjUSJJ0VSyq6E54VjKlCQjvhplnH
	SaQeqq1kvbUy2VmjJPGq5ov0wySM/Eq6+p+UsoEKtIHruhsJETquCSDfBVceMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713271986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMFCl/rnVJq1sqUQE5VnVFZQ0yXU/chs4WFIUDzsXzU=;
	b=zZDbJCOYYgyDicfNnyvP7drR2+ppPAui4jiIH1+K4rG7aM25u6EHr5HrggIG2K2/UL72qP
	WIQFTZsys8MOULDQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v4 27/27] lockdep: Mark emergency sections in
 lockdep splats
In-Reply-To: <20240416111749.GM40213@noisy.programming.kicks-ass.net>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-28-john.ogness@linutronix.de>
 <20240416111749.GM40213@noisy.programming.kicks-ass.net>
Date: Tue, 16 Apr 2024 14:59:04 +0206
Message-ID: <874jc1lb9r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-16, Peter Zijlstra <peterz@infradead.org> wrote:
>> Mark emergency sections wherever multiple lines of
>> lock debugging output are generated. In an emergency
>> section the CPU will not perform console output for the
>> printk() calls. Instead, a flushing of the console
>> output is triggered when exiting the emergency section.
>> This allows the full message block to be stored as
>> quickly as possible in the ringbuffer.
>
> I am confused, when in emergency I want the thing to dump everything to
> the atomic thing asap.

At LPC 2022 we discussed this and agreed that it is more appropriate to
get the full set of emergency printk messages into the ringbuffer
first. This is fast and lockless. Then we can begin the slow process of
printing.

Perhaps I am making these emergency sections too large. Maybe only
certain backtraces should use them. We will need to gain some experience
here.

> Storing it all up runs the risk of never getting to the 'complete' point
> because we're dead.

If no other debugging mechanisms are available to read the ringbuffer
and no other CPUs are alive to handle the printing: yes, we are
dead. But if the machine is dying so quickly, it would probably die
before getting the first line out anyway.

Note that by "dead" we mean an irresponsive system that does not panic.

John

