Return-Path: <linux-kernel+bounces-71710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181885A957
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76BB1F2531D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C04439F;
	Mon, 19 Feb 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHEoDThq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1HxflZOM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9041C80;
	Mon, 19 Feb 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361586; cv=none; b=erK6LXC+rPMDydEqxzo26pdG+ktWdqg3PdM+v1TTrDW0aaUx7/oBAz5TJPbKI2JtvNI263hHBc9O6Tylz+IVZnPZNdgry5PD1Md4MJ9DSjn6IdwZ+R1d8qN+Ru7YWmXUEkkZYyY1skuBMR7Hav4sWK66rJii88r/1LPC7tLrudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361586; c=relaxed/simple;
	bh=Lb/0pHwD8Q/riJmHuwL4W03xRKJocFOd+7ePltlp0FM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jP0tWK5X+1Jn8p0dPF2MIU9D7AjCWZqPi89c0MOm7oDZcpT34cr480aeSqmeGDhFlUBQV0jG97QvZTZdywNiPf0lQibB+6+dFvRszKxGtMEELKZd7scIhvgl+QvLtYeixRBYJu11HRCd4bkqkHzFY//ZeppU4e3TVOMgopwNKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHEoDThq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1HxflZOM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708361583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HiD1LZzj9pImOo0+xGv7g//UL4JkWsKqbaKbyxu1xpk=;
	b=cHEoDThqVnE3OYnh19npUaWvQy88iRAQyghKlxN1RcZ33HXo7e2vMYkr1mxt6GFcP6DG4x
	XnGJjhVrybAyaOwhoqJO5pmUoUOfi1kHRdYbTsDAzjNE9cn32tK8LktaY3LtfHiImMC0lD
	Q28SZpZCvkX3b/hgj18vxDBBbdFGr55DNXXaqe33T7cIdYpA9yD2PBVynoNh9bvXRCi3qN
	1HTB11MogtIns0O3EJ/41xdO4bH3TILPxqKaZ1sqzRFaHXd8w4310hR9czVdG8c+tQSJ+F
	WDj2LrMwoXYeL9sCaIz7e6p/nEZV3wQZyex+RhkRMoN+g9sq79yIN23e5MozBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708361583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HiD1LZzj9pImOo0+xGv7g//UL4JkWsKqbaKbyxu1xpk=;
	b=1HxflZOMf1mVOuTRWTWbuE3edHmeGDDDhIiNzM1YgBQe+smYGHtB2T7TVvsUJYV5QvO9AG
	6ZaI3FLjZzh109Cg==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Tony Lindgren <tony@atomide.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Justin Chen <justin.chen@broadcom.com>, Jiaqing
 Zhao <jiaqing.zhao@linux.intel.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <ZdNnKylfoj4Vt3Nu@smile.fi.intel.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-9-john.ogness@linutronix.de>
 <ZdNGlzwqwdsfwwab@smile.fi.intel.com>
 <87jzn0bkqg.fsf@jogness.linutronix.de>
 <ZdNnKylfoj4Vt3Nu@smile.fi.intel.com>
Date: Mon, 19 Feb 2024 17:58:41 +0106
Message-ID: <87il2k2y7a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-19, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>> The headers in this file is a mess. But here you can at least keep the
>>> piece ordered, can you?
>> 
>> Just to clarify, you would like to see this ordering and inclusion?
>
> Roughly, yes. Ideally it is quite likely that kernel.h is being used as
> a 'proxy' header. Nowadays, it's rare the code needs kernel.h.

So I took the time to painfully discover every header that is required
for nbcon.c without any proxy usage. It came down to this:

#include <linux/atomic.h>
#include <linux/bug.h>
#include <linux/compiler.h>
#include <linux/console.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/export.h>
#include <linux/init.h>
#include <linux/irqflags.h>
#include <linux/minmax.h>
#include <linux/percpu-defs.h>
#include <linux/preempt.h>
#include <linux/serial_core.h>
#include <linux/slab.h>
#include <linux/smp.h>
#include <linux/stddef.h>
#include <linux/string.h>
#include <linux/types.h>
#include "internal.h"

For the next version of this series I will only add the includes you
suggested, but will follow-up with a patch that fixes all proxy headers
for nbcon.c. As a separate patch it will help with bisecting in case the
ordering causes an explosion on some config/architecture.

John

