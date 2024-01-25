Return-Path: <linux-kernel+bounces-38962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41EF83C90A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226C41C25F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD80F1350CA;
	Thu, 25 Jan 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEnJZ3nG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSIsaHVg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A816EB41;
	Thu, 25 Jan 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201565; cv=none; b=c5wJ1486VXoG7znYAtStW3CzuQPFc/gVsHCWCGohMMnGmirczP2FpGlaYdziYvsMxXtu77lW1w/Lo6V+uOFke3UXZr3dKbZEiqt1gKSnf3jLVqWcpP1I0slzZ/hc7EL7qbvvV6rKlsZXrqK1OhhI8I9MHKp3lR5CZXJs9vKdq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201565; c=relaxed/simple;
	bh=Xgc0oUgZ6ptGGhO360/P/WWmMDnomOOfgA9lQQeY2kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/d3atAxk6eJta6ISJ/WIraM5FEDaWJnyl/8cfOAIU7tizMsoHj0wsJLOq/hrhiMKmO7kJvuRN0PzmsNv83msJRKnC1vqN0kDYOInssthYKvNjWM+MZlb0KNJLs6pAc6oBSLH3M+KUE6LTzEcu3Yn/Qp7buGNlNBntvcd+xnNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEnJZ3nG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSIsaHVg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706201559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7knfvBi/gwwDFeqDX0dY9GKfMvBBcRERPkQPAPOzAjY=;
	b=FEnJZ3nG1f8OEVAIdunzN10a/aLQ4Vqfc/FbKgG+Nz1ifVNcGoMOzMz3WOjJdCiSpyy2Wj
	jD4HWWeU81j+w9AKxtVxHn9bqFFq4FUUBYUIgKXfxFQdiNhL+EDJk2UkhClft/FLrGTgK0
	4z8RuAAMQ7qCMJfO5hO7PzQMgVo2R6F7RUVSEnvkfxQKwCLLQxVMgCDXKaVydDr9+65R4a
	RXiPR4GsO3O+ntUmk6d+AU1KF/HrYqkPGdtIA3HJbCLnmWCyYi48Rlfg8r5Hz8QP1jA8Q1
	kTL+jAVOKyqfcyU34l9A52ZEZYUlqlra09k9T1qDxm7vh+FCBBjaqUISWslPcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706201559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7knfvBi/gwwDFeqDX0dY9GKfMvBBcRERPkQPAPOzAjY=;
	b=YSIsaHVgIiPtxtx4Yiwy0GVM7Vb1IV9cSm8Mn2qEu7RdaTAKPSOW/C002coUiiBR5Y1PWB
	UdUGHOSHrufhoHBQ==
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <87plxpbgpz.fsf@meer.lwn.net>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
 <87o7d9d7dd.fsf@somnus> <87plxpbgpz.fsf@meer.lwn.net>
Date: Thu, 25 Jan 2024 17:52:38 +0100
Message-ID: <87zfwtbbjd.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
>> 4. Add a warning banner at the existing documentation and prepare
>>    everything to get the timer documentation to the proper place and
>>    create a place for timer documentation below the current structure.
>>
>> The benefit of 4. for me is, that there is this warning banner at the
>> top. So this suggests the reader, that this has to be revisited before
>> relying on it for 100%. This banner might also remind the original
>> author/technically deep involved developer that this should be
>> updated.
>
> The best thing, of course, is to just fix all of the documentation and
> make it perfect now :)
>
> Failing that, the banners are fine IMO.  They mark possibly obsolete
> docs, warning readers, and also just might, in an optimal world, inspire
> somebody else to work to improve the situation.

I hope the world is optimal at least sometimes :)

> I've thought for a while that we should have a standard warning or two
> along these lines, like Wikipedia does, but of course haven't done
> anything about it.
>

Sure, if we could standardize it, I would definitely prefere it! For me
as a not sphinx/rst/... expert, it would be great if only something like

. might_be_outdated:: <optional additional text>

needs to be added to the code. And then the default lines would appear
together with the optional additional text.

Is this what you have been thinking about?

Thanks,

	Anna-Maria


