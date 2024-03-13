Return-Path: <linux-kernel+bounces-101301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69887A540
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741981F229B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36E24B26;
	Wed, 13 Mar 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/GnoVRe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PzwpJQge"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FC2261A;
	Wed, 13 Mar 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323434; cv=none; b=dUWxJ1JAyxU7ZFd0rd32nD5xs/IhJtZCjPWDQuJ6v8St5PwUstErmyfkQK1DabcB8xMBM0lhMZcAMFByTjuaBQW1oVh0W+qjz0vV6xKTSNcP/+SK1n90MKl761pmHWaflhyZkvZXNk7lMPhHZnb7QwJJlnZGKNek4kORvyGtSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323434; c=relaxed/simple;
	bh=/VOvO1ICOgorvWfeUJ/OeEtLerixex0X5TqRBe0HFYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3eSJawflgd8rkW2aHq0uc/xs0ZNNnSfCTFYXjS84akowW3POEt8snwVez5kg4gtjFJ30r8iwmmDHe//hc/57VMRuYNdLUuyk4VvCfgvML0vfnQ0M5zPFZCN4ec/LM+qdQEDIKwvKZQU1HBaL0CwoRWsZ5FcpkjrkG8weU9Q2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/GnoVRe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PzwpJQge; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710323431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VOvO1ICOgorvWfeUJ/OeEtLerixex0X5TqRBe0HFYM=;
	b=N/GnoVRemB0lnPrN0ZZ/cffTMben7HeYgNGpj6tZwVvZNGJ7ytDvwvAZmd/b/fPEWpl+VF
	m4y4wW6N8r2Dn7N7MENLLd9cLHrHt2582jcRuGZ/OX7Ti5VpDSs6QkJgQUhiOyDUL6Jq7D
	d7+teHLala/Nk2yTVCyZmyR+tP/SojcHfKrYMx1wIyZJxDJY0yCV+NWTueuM46HqIOh2Jd
	KYYsVBtzIGBhg4SkS/0oOs4c8QhD0busx5BiWRPRx9VYau1egn440tLquyUlLsMKJyJZ/I
	2O/aqU6RkxTMphWgHk5XU27eDSy84iB3qIV4Te9HyPArEObhZVqMgn1jpt5hBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710323431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VOvO1ICOgorvWfeUJ/OeEtLerixex0X5TqRBe0HFYM=;
	b=PzwpJQgeL8JVSshwRkScr4aIdkl4e6hpxxmme7LIIVs/jrPQZQYkCDTDdB5x9VrJczjwfh
	9LAg9uJfoTGHo/Bw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Justin Chen
 <justin.chen@broadcom.com>, Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
 linux-serial@vger.kernel.org, Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <87le6oy9vg.fsf@jogness.linutronix.de>
References: <87le6oy9vg.fsf@jogness.linutronix.de>
Date: Wed, 13 Mar 2024 10:55:47 +0106
Message-ID: <87plvy31hg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-03-11, John Ogness <john.ogness@linutronix.de> wrote:
> And I think you identified a bug relating to the setup() callback.

Actually this bug was recently fixed by Peter Collingbourne:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/printk/printk.c?h=next-20240313&id=801410b26a0e8b8a16f7915b2b55c9528b69ca87

One nice thing that has risen from this is we are starting to see
exactly what the console lock is needed for. At this point I would say
its main function is synchronizing boot consoles with real
drivers. Which means we will not be able to remove the console lock
until we find a real solution to match boot consoles (which circumvent
the Linux driver model) with the real drivers.

John

