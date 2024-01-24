Return-Path: <linux-kernel+bounces-36742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA5383A5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC46E1F2CDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39B818046;
	Wed, 24 Jan 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0CscK2a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJb798b+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0021802E;
	Wed, 24 Jan 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089729; cv=none; b=KFsIaOz97fiJEiqnvhGhl7cm3NqATvHgNM8f7jlvogwkOHxDnBUfI0bQUV7fIdw5TvZhiz0y1MWwtLCIIPQmbM2foxKc+vWdBd8+bhSYP4Fmbe5RXXn/uyOs7TWiveHABl5qVxF/lhVM1YzyWs9MIHk1/xym9lIQhUuczyNaZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089729; c=relaxed/simple;
	bh=Sjiggc9hkp7vO14FeTQLrBBVejAbxEkPLML7a37rMKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPyeNriFR7ntC3z+HHpXnbgSaOhLYNc6SC+1OXvL74DXYG4zydaJ11BMoxI4qnB8AYfPwqep7uh/2KdssxSgCqk5Hy6Ddhu1rH/DmWkljeqq+Pr0tp7cgxW0dubePGs36B089LSY8v92ffVCFkrT2l4Jdm0/yevh53PeS8IqTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0CscK2a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJb798b+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 10:48:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706089725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHoOnI11BiHLHgLsYhCo+j3C2xme3YS/1KU+DJN93tw=;
	b=u0CscK2avvuVXP+urhisBRY0urTPjA1KhHiU44hlXScwk41TZ52d0608i43pSk6heLAvap
	Nnw6oubLiMWI/idXk/hxlEEEYnjalpTg67E/C3zYqXTT+Jqm6yA9hej2qOj5U+Han24J4M
	jT3QrQQ9ytUL9o9AwFyrXZ7ibvBmDr6CXKaOcWJZCL0KOTtucjMUrvMGAETSsr9WzZirXP
	wzxSSuDEVJ8eISkkd3GXh20e+WevMwWCjy4Qn31xV5pPsmhxltdN4tKLIpWV/tcqNptqo+
	IaqWtfSaxC++R22+zJB3ixKAZbwIW6YCiKPyAz6DkC9iorjrY+T/f40ova5IRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706089725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHoOnI11BiHLHgLsYhCo+j3C2xme3YS/1KU+DJN93tw=;
	b=rJb798b+AKo8nedTM0XuZsJt3WO/06RZxc9BC4JLI+ntoERMUx3rW3RuBStRKcBZiwOxyi
	q8qalIIGYrPbMeBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <williams@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [ANNOUNCE] 6.6.12-rt20
Message-ID: <20240124094843.K-b1_mn7@linutronix.de>
References: <170561158585.591793.15929255265114320850@demetrius>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170561158585.591793.15929255265114320850@demetrius>

On 2024-01-18 20:59:45 [-0000], Clark Williams wrote:
> Hello RT-list!
Hi Clark,

> I'm pleased to announce the 6.6.12-rt20 stable release.

I've been looking over it and it looks okay. Then I compared how it
would do it vs your outcome and noticed this:

--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -575,12 +575,6 @@ static int check_unaligned_access(void *param)
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
 		return;
 
-	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
-	if (!page) {
-		pr_warn("Can't alloc pages to measure memcpy performance");
-		return;
-	}
-
 	/* Make an unaligned destination buffer. */
 	dst = (void *)((unsigned long)page_address(page) | 0x1);
 	/* Unalign src as well, but differently (off by 1 + 2 = 3). */

You shouldn't allocate that page. Nobody will free it, that page is
passed via an argument now. Please drop hunk.

While at it, do you think you can drop patch
   preempt-Put-preempt_enable-within-an-instrumentation.patch

or revert commit
   c15abad8f7159 ("preempt: Put preempt_enable() within an instrumentation*() section.")

I've been looking over it and it is fixed as of v6.6 so this patch is no
longer needed.

> Enjoy!
> Clark

Sebastian

