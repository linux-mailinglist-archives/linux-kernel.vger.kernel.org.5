Return-Path: <linux-kernel+bounces-111727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE288700A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0790285F44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75953E22;
	Fri, 22 Mar 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTNi/mVn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUFcZLKi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3C53E2E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122588; cv=none; b=KzGvTOOp5oKdLIQSNnaAOKInMnarFwPj9qYf5kG/QgYG9lQqhiNsSKaM4wNVZ9eOgPQWVsjo8BtJteL5kp60kEFTsXPPgFhTAf/K2Glx5jfL09erEZXyZ58rljOVGxEV9eQSUHXL0Crtp2ZLWfKVWuY5uKkRlOYhWyJX0c7u8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122588; c=relaxed/simple;
	bh=17thP1zMe5HSzVkJms2UMrY4egnGrIgVfUJ7edUHi7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDvFjfouQiH5vYPPX6w5RCTO9g8HfM++hJvIC5VzKi6id59QLPrKusbYPFf+eKw1efg+WRxjImuA1Ez+MULyGG2NSA4qX7HvfXaJssvxq91b/FAn2GWofZOjwYqomF2iRXpuQFGl+dQNgIzosdQ+1XFuA00A3NWNVwkYWY5X6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTNi/mVn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUFcZLKi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 16:49:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711122583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MA2tdrapxYa9p6qfcN0tF4aFYu41GBC1RZAw43t2c9Q=;
	b=MTNi/mVnGtNznYr8WCtSHFYeD6yinJRI2XX9adOuturf0mLGaYE0oMW8L9quWm3xXvUiOq
	p2xGTFav2rB3am1EzbDlVl+6apHsOfQuZ49lMCmU4DaCAhuXyLT7dk78um0xv+/M9vLaDv
	5fvI6Tjv/Zhip363jODzG+CLsCltf+9sNOiabGGB3vWPPzNXwSHnE+oQcmn8yzqT4tt0jZ
	SGXzOxLMOWRiVlz5DTS2aF/+AmzcZ6AmOYKNZy3EyyIIfUxEIMbAS71w0EjiUaekc9JfUM
	Iisnsb8q8rgBkaBlBoghqCOM1AUQ9A+HvGTNFxsbMBM3td4ub0iMcGv9wmaeKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711122583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MA2tdrapxYa9p6qfcN0tF4aFYu41GBC1RZAw43t2c9Q=;
	b=AUFcZLKiEs/ZBqpEE1U6buTzmEIdMrsDmdF3uQbXPM2PTGNhQVvY6EJXi8w6c10beuCSfp
	z8uNdBj9DBfuzeBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqflags: explicitly ignore lockdep_hrtimer_exit()
 argument
Message-ID: <20240322154942.XIaqXpjU@linutronix.de>
References: <20240322132048.906325-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322132048.906325-1-arnd@kernel.org>

On 2024-03-22 14:20:41 [+0100], Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with 'make W=1' but CONFIG_TRACE_IRQFLAGS=n, the
> unused argument to lockdep_hrtimer_exit() causes a warning:
> 
> kernel/time/hrtimer.c:1655:14: error: variable 'expires_in_hardirq' set but not used [-Werror=unused-but-set-variable]
> 
> This is intentional behavior, so add a cast to void to shut up the warning.
> 
> Fixes: 73d20564e0dc ("hrtimer: Don't dereference the hrtimer pointer after the callback")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmm. Seems I forgot about it
   https://lore.kernel.org/all/20231120153953.kGBSHe5j@linutronix.de/

Maybe we could the commit message from the referenced patch. Either way,
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

