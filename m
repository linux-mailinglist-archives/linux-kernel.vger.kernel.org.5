Return-Path: <linux-kernel+bounces-95668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ADB875105
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88F91F25615
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE112DDB2;
	Thu,  7 Mar 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owp2Ldkq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tADLiGKd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7712AAFD;
	Thu,  7 Mar 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819657; cv=none; b=Llq56DuW0y8p9DakeTKHNt2vsj86AKMsI2fLw4cgw39qqyphbsJdBR97FMEEIbrH5msBEPYlLdhDrCVnyRol3CP71RPlrT3VzqoIByc284yypOD2AJWxay2oag0L3IH6Q2pTr3G/5jfrvEBwK/W0XHLf7dGNmAHoDyeQ0BHn5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819657; c=relaxed/simple;
	bh=xTRxNjkQRztADLsXXcIwVC4pHrH+fmTNdy7G1M7KPEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ulBs3P6RnAz38Iu4ElXDPrhqa1cNfBoo8sOsHYW+nTCv5mBZKskumpStYKc96IJjC4iRGdmozZERZ/Ii0KjmNP3SXuoN1luXfXB1/yNO4wSNarmL7gax3NALeK+BNew9/ywm/bIJpL7YMkJF6D3OnIMPeBgC6iAfMVFm91DA5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owp2Ldkq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tADLiGKd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709819654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTRxNjkQRztADLsXXcIwVC4pHrH+fmTNdy7G1M7KPEQ=;
	b=owp2Ldkq0Z9UJxgzqc1e8z3tI65iH4KAVOKUSgpEhqAyOG+i4aHHmZV2WqcvfsYRkEjH8F
	mSrhbYKZ7canQZW/2m77nG+ElcRlO+byFwudHK41q7uPJte8D47wZgw0TyqTy6Uywb9eck
	l8BGxuY4iqnB3vRX4MV9LBvmHvo6fD19mLJX2f38TE+vsMMjxSHwKTybMcNWPH/IN4uATy
	LugVNMkjwNIcPF3N8wqU3wxNHN8EL7z+0NjogJbvBkwT00QlBOHtMq/22HfE4ZBLWlj2bh
	/bkyumfvyWkaqTnf7JxMeGY5BDA7ENVcbFcRqHWcY51iK+fECV4tmJsy3frOEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709819654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTRxNjkQRztADLsXXcIwVC4pHrH+fmTNdy7G1M7KPEQ=;
	b=tADLiGKde9lgXfh3bTCJtRetuFwUxQT+/+zpkh2HPvB9wc6knbWZThtSgZePiqQEqTr5X9
	BL+qBU91ZrPtKMBg==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, pmladek@suse.com,
 corbet@lwn.net, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v5 1/2] printk: Add function to replay kernel log on
 consoles
In-Reply-To: <7ca188a59ef016c7730031c10f072d478434c04a.1709277332.git.sreenath.vijayan@sony.com>
References: <cover.1709277332.git.sreenath.vijayan@sony.com>
 <7ca188a59ef016c7730031c10f072d478434c04a.1709277332.git.sreenath.vijayan@sony.com>
Date: Thu, 07 Mar 2024 14:59:36 +0106
Message-ID: <87zfva87xb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-03-07, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> Add a generic function console_replay_all() for replaying
> the kernel log on consoles, in any context. It would allow
> viewing the logs on an unresponsive terminal via sysrq.
>
> Reuse the existing code from console_flush_on_panic() for
> resetting the sequence numbers, by introducing a new helper
> function __console_rewind_all(). It is safe to be called
> under console_lock().
>
> Try to acquire lock on the console subsystem without waiting.
> If successful, reset the sequence number to oldest available
> record on all consoles and call console_unlock() which will
> automatically flush the messages to the consoles.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

