Return-Path: <linux-kernel+bounces-74778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65D85D9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339C51F23744
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8E576C85;
	Wed, 21 Feb 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWQ/JHW8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLywdLa+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B753816
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521827; cv=none; b=gPvDXyMZ+6o1dCtAOhJtvzYpgAlwziKgGpiYkeWeCbbbUUr8ydpv5rOLLKlfFb//KJG/tu93/cmbPKtps697pl0t0RcYzf+V6y+5KwmBOMs8qq2Ra7raFJPdaHg5Qo9sovxDvGrEv8OtfCn9hC88kX7C+GfHQbcrQwIrB/HTy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521827; c=relaxed/simple;
	bh=5KmM4cApKT+Wn/rqHgxHtrIgsJmps/ltqPSMAVaD6KM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ityOJWXUmG3cKD5qSqBqv78e//HVnPHgA5o0sp2s6mAVpQiSx6yya4xAEjMtzBMrHxOLdXPopVcHMEFHeJLX8cADUg3RB41L0ibbbKDa2TpSm2fEOjyD35GAfz1pUJERkK0l7yrCErpF4l5ZJPkpB/hPu0LUdOn6XulJuCjutJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWQ/JHW8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lLywdLa+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708521823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY+6Vxdrl4PxgSm0iSdYSZ8zobawYBbcsmI10GQ6mgw=;
	b=lWQ/JHW81L40rdKS1XZ8EcH9geI3oPZfwazHFiSHP/XBmdacfnj3Bpo7n37NXkbtIQBdXr
	aNO+pBVU3ZqeLcSHffYx/5F5Axog8bOf0YSlnckYxMS7irIcJtInGazlrpXc1OhdzWOsj/
	ZO87EAn2q+Ig5QvfDyy4lNjkDHn8o1MIq10E9+6YSj7NX4oftCZrFrpUJI9jQgamOpj2ll
	Xm2Z3WL081VW+AN3EOPH90y57YV1PQO3PpdyhHqzJGbDIl8Myfowz2N2q8DG0ppoq+gXZV
	tjGqPPGQtYZZCCFeBnv4EzhMW+5lNrVvQ4GuaQsVh5hMzAtgDHK0em7+TL/8/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708521823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY+6Vxdrl4PxgSm0iSdYSZ8zobawYBbcsmI10GQ6mgw=;
	b=lLywdLa++k4J2k9xnmr9lS2kNcthrShtVl5UEJYRJLQvNMjWq8unDcQLObmiKo0Ar/3xfP
	0+zy7u0Nf+mP7TBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/26] printk: nbcon: Ensure ownership release
 on failed emit
In-Reply-To: <87o7cbgkvf.fsf@jogness.linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-7-john.ogness@linutronix.de>
 <ZdTCZqhZww8_WgSU@alley> <87o7cbgkvf.fsf@jogness.linutronix.de>
Date: Wed, 21 Feb 2024 14:29:20 +0106
Message-ID: <87r0h6vtmf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-20, John Ogness <john.ogness@linutronix.de> wrote:
>> Is there a valid reason when con->write_atomic() would return false
>> and still own the context?
>
> This is driver code, so you must use your imagination. But I thought
> maybe there might be some reason why the driver cannot print the
> message (due to other driver-internal reasons). In this case, it would
> return false even though it never lost ownership.

I have been thinking about this. I think there is nothing useful that
write_atomic() can return. I suggest making it a void return. Then the
driver must print the message if ownership was not lost. This is already
how write() works and I think it is fine.

This simplifies nbcon_emit_next_record() because it can assume
write_atomic() was successful and try to enter the unsafe section for
the @seq update. If ownership was lost, it will be detected here. If
not, the message will be considered handled and @seq is updated.

>> 	  if (WARN_ON_ONCE(!con->write_atomic)) {
>> 		/*
>> 		 * This function should never be called for legacy consoles.
>> 		 * Handle it as if write_atomic() have lost the ownership
>> 		 * and try to continue.
>> 		 */
>> 		nbcon_context_release(ctxt);
>> 		return false;
>> 	}

I will keep the WARN with a comment similar to your suggestion.

John

