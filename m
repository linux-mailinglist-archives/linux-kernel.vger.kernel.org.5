Return-Path: <linux-kernel+bounces-141229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6FF8A1B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE631C211B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452B4D13F;
	Thu, 11 Apr 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgdDwnoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbKtuB0M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81D4653A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850519; cv=none; b=O+g1KMmcCnJbX+15o27d9dLtFaVmwKpjykDO/urNb9f2+W6dVwQd+Jt0mDOUhL6NiJfqXZweYudGDN7dsnytrT+RRmNg+Pd2ckwc67uieBcf2SStS68OXdmpb2qVwPomCJGKkfNta+iCwJ3Z43AK+/8a8NlhbmxMJjp07Xlscqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850519; c=relaxed/simple;
	bh=Ogd+n1TSvoGdYjxz+AtJXVanOPO6rMM9UVyR85TrB3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PmOEo+U4WSU3ZLWbV7VCSwsO3n9Q9TU9WBrmn3nyDykoIQLIERxP4/ihUSuVqVlw7Qttdf9J7NVgVQkcuK1+wJGQyiDFcH/p9UNGs46MI6MPZzOSf6Xorc6AiLsTy+YL4U+uPTXTTBHTbktfnIv/XO9QVHP4AaPAoH+SpZ+jRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgdDwnoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbKtuB0M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712850515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D7Bnqt3akU03Fp6RWSfJD3k2hdWIgCQAZkMA627hXE=;
	b=xgdDwnoSV8FRL0otFUi4A2h1bGADDNUW/qqBjNb83ggjEybUTc6B5iqdyth6pN421UKprj
	z0J06AD3+0egfRF/V87XhxCg8CX8DTklRd2B0LMzXuKK9WjjQ8eTX/hUk96SMG13iYxypq
	72/1tMElG2anOALaOha2GZerWAuPbBW+gI5N5semdk/kDmBST5YcV10eeCd2UWwddHUAns
	JRd7AyaFSvwXFILhk8NXuhD1i/aUmDYkA6X4pzmwJAODyyjEZJpmXCUDbKcOFwixEoeLrY
	FKOqozevLFu6bZjYOHkGdG4/u8MiKhZG6JGUf9XeecqFuyUzvF7228iEssJXNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712850515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D7Bnqt3akU03Fp6RWSfJD3k2hdWIgCQAZkMA627hXE=;
	b=TbKtuB0MyH/+BfNcUm7MmIh2rcrK69giR1XlsrCTPFpmjEhd9YQxiYWF8MDgWFQj5HyfNn
	bw96yFWWl949xnBQ==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 11/50] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
In-Reply-To: <20240410165551.635345704@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.635345704@linutronix.de>
Date: Thu, 11 Apr 2024 17:48:34 +0200
Message-ID: <8734rrvr1p.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
> timer_get(), but the posix CPU timer implementation returns 1 nsec.

copy paste error (get/set) ?

> Add the missing conditional.
>
> This will be cleaned up in a follow up patch.

I'm confused. Why do you want to cleanup the conditional in a follow up
patch?

Thanks,

	Anna-Maria


