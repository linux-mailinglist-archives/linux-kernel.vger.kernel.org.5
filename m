Return-Path: <linux-kernel+bounces-103183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0EC87BC07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B94C1C2246A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF46EB6D;
	Thu, 14 Mar 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RGzdHmjQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JePSg32f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED06E616;
	Thu, 14 Mar 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416274; cv=none; b=Q5UMlbgBI6j8Sne1XA4gdI7UwwKxhdoqysnWxu2j36PcPOsHslQAQJUx7GXitciK1Yiyoriz5rW7b6lv8U9T273WzJR/gbMftS+MqleA1Mho7ae/MFwKRbHkG31ba1Cbcahs5a2MdfsnbMkpWbvn9xZ3m4UpETknxi2FIjfiJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416274; c=relaxed/simple;
	bh=49HK3jmXBhAvpfLxYxAAHhwX8AvYNeMI2CAUOSp4u6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dz/Pl+T+FQmVgYlrMugPbPN5J8CT8GM00dyvDkOtOZuPm66Ug5f2E29ZTK97qFtoutywR5aaV5EIPYCZjvggpnSGVTP2JlW/VXbW8IjkO2+lN9sof79B8AbNFg6Omeg0veV7klxxfYN312HMekrtpdMLN3IfYz9/xcBjnzXYX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RGzdHmjQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JePSg32f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710416270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ilylSZ4fB6JbX0i94fDbr4TmqyjCjG1jilSqcfHbcc=;
	b=RGzdHmjQRGnzAWmaXfQfjVaozUvcqZ8rs6iSNVxuMBLOqYa4VfSCtNc7hVshbOaIhDlqmm
	cpTtji10VTokmafOD1LWNJ1efu+Acf9mdvlepRaezomP8elp5zsv3Aam+cyYHnP9Opzqi6
	sGNoz6qJKe51m/dMCSiBgdT5SPGO0d99jnqG5DwDF0CUMSy0ZHfQ2CIh3h27M0ZhZ6TXl5
	pKYwyRW3c2Jxg/5Qbw3LwRNPSW0esRHsJWn10iIUhc5fEN9BaXYvB5lR+l1DbtYVNLvrCm
	Wfdziw8NeYwvFcy6LIL39yb6AO6+BpoP/JvdzXWssVEE7tSQ1PCHtclkGqNjPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710416270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ilylSZ4fB6JbX0i94fDbr4TmqyjCjG1jilSqcfHbcc=;
	b=JePSg32fc3LNu7eI5M8ldwg78TRdVRezHPo24DcdksAkkrqWQFtBr8sQMCrXPrL9TWhumP
	T3mMALUz6SZkU6CQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Justin Chen
 <justin.chen@broadcom.com>, Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <87le6oy9vg.fsf@jogness.linutronix.de>
References: <87le6oy9vg.fsf@jogness.linutronix.de>
Date: Thu, 14 Mar 2024 12:43:06 +0106
Message-ID: <87zfv1kpst.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-03-11, John Ogness <john.ogness@linutronix.de> wrote:
>>> +	if (!uart_is_nbcon(up))
>>> +		return;
>>> +
>>> +	WARN_ON_ONCE(up->nbcon_locked_port);
>>> +
>>> +	do {
>>> +		do {
>>> +			memset(&ctxt, 0, sizeof(ctxt));
>>> +			ctxt.console	= con;
>>> +			ctxt.prio	= NBCON_PRIO_NORMAL;
>>> +		} while (!nbcon_context_try_acquire(&ctxt));
>>> +
>>> +	} while (!nbcon_context_enter_unsafe(&ctxt));
>>> +
>>> +	up->nbcon_locked_port = true;
>>> +}
>>> +EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
>>
>> I would prefer to split the uart and nbcon specific code, for
>> example:
>
> Can you explain why? This code will not be used anywhere else.

No need to respond to this point. The v3 will be quite different here,
but will follow your suggestion. I am splitting the uart-specific code
into serial_core.h and calling a generic nbcon function for the nbcon
locking.

John

