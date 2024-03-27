Return-Path: <linux-kernel+bounces-120617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C788DA55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD8A1F22AED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94694503B;
	Wed, 27 Mar 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ge1+4gYn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8Yr/MFk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C383383AB;
	Wed, 27 Mar 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532002; cv=none; b=DiyMNx0tRcq8/0WasSlWeWH76aEoqxuvii7xINaUcVRdWLMt49ty+8isVpLogv8qidaOkzjCm8P1KrN9tGzg6CnMc3BXs798Ww2dQ5LBkZvQ8zfF1e34scEpowz7yYBJfyHfZFzs+2eQo3jrDxTpyTwyqzU/ZuYikIFUREO+iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532002; c=relaxed/simple;
	bh=pET2BBVg0xnzMN0YLHuDfWiXk7vgjrlQsg1h1vEKJeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AmXCPKbFaHk7HkM8INozW/QEmqvlkIOUr/DFo3UOhkDbfvlZzWz+/jcxqWrmu3NAka30WQc12zvuxuyu6ZyyLN+hWxmrbcMJtKW9aQm41YQOe4Wsb2sy7Yw+TaKNZGf2nKjopqaQyM+uCQ54YaYf439X83fDVVGdP4OObFjVmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ge1+4gYn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8Yr/MFk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711531992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHVXfzfNDmRZjH7QwfXLPjb1528cJfMeGmgmP9uOtP0=;
	b=Ge1+4gYnoLjHn7A9EvbZN5FF+9/aXdVzjo2nHP0HMtL6RYdILdsu+L4e1bGWWQH0qqInFF
	NtbTK6FCsA4NDDVIazHpMEdey5DfeafkptG5meKeRCTNnLfLvnrhfNDtAz/dvRlrH6U513
	lSz+ZssOxIQem0qlXEZ1Sh0Gr3OuuVIJ/mNLynW6g9Ykwyd0iEZ2u/Bf7ADO0ynyerjLO0
	oHBtltCHHjKHlFjJZ1Ya3xXSTIYIp13QJyRl0tj9RuWOLdEutx2kds7P8jN2ETvsqtXhEi
	m7CEe30rY0ypceCd7uFF7J/40KjrC8SLAufDGeZfG1FzA+ue/gk9z2OoZtzvFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711531992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHVXfzfNDmRZjH7QwfXLPjb1528cJfMeGmgmP9uOtP0=;
	b=h8Yr/MFkV8yQpexcQmq9sLq5Gkh+M3rNjW8p6r8bUlAxaYugFlEtXKBVOJ+3eEIsPj/TEp
	yyg7QfcCdPPoO2Cw==
To: Tony Lindgren <tony@atomide.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Justin Chen <justin.chen@broadcom.com>, Jiaqing
 Zhao <jiaqing.zhao@linux.intel.com>, linux-serial@vger.kernel.org, Peter
 Collingbourne <pcc@google.com>
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <20240322062305.GB5132@atomide.com>
References: <87le6oy9vg.fsf@jogness.linutronix.de>
 <87plvy31hg.fsf@jogness.linutronix.de> <20240322062305.GB5132@atomide.com>
Date: Wed, 27 Mar 2024 10:38:15 +0106
Message-ID: <87r0fwt3z4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-03-22, Tony Lindgren <tony@atomide.com> wrote:
> * John Ogness <john.ogness@linutronix.de> [240313 09:50]:
>> One nice thing that has risen from this is we are starting to see
>> exactly what the console lock is needed for. At this point I would say
>> its main function is synchronizing boot consoles with real
>> drivers. Which means we will not be able to remove the console lock
>> until we find a real solution to match boot consoles (which circumvent
>> the Linux driver model) with the real drivers.
>
> Would it help if earlycon handles all the boot consoles?
> Then just have the serial driver take over when it probes?

I think this would be very helpful. And it would also cleanup the boot
arguments. For example, we would no longer need the
architecture-specific arguments/options (such as "early_printk" and
"keep"). These architecture-specific arguments can be really
confusing. There have been so many times I see a developer cursing that
they can't get early debugging working, when I notice they are trying to
use "early_printk" on an arm64 system.

Browsing through

arch/x86/kernel/early_printk.c
arch/x86/boot/early_serial_console.c

you can see lots of examples of various early consoles and their special
tricks/hacks (such as pretending not to be a boot console when it really
is).

And pretty much every architecture has these. (git grep CON_BOOT)

Ideally it would be great if a console could register and say "taking
over for console X". Maybe with a new field:

struct console {
  ...
  struct console *console_to_replace;
  ...
};

John Ogness

