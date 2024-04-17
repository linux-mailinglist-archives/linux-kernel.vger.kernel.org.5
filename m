Return-Path: <linux-kernel+bounces-149271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D335C8A8E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE121F21B72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22512C819;
	Wed, 17 Apr 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEyX9j7x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0tJY04K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721547F7C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391176; cv=none; b=MtmvCK0bNCsvvazpPsTtVi6f+0JhHo2cPoeNg9ur69nqbQWSNroUeQLv1BJCcy+2Kb/6/BV3qrBQ6GfQNZlVteAL2I96xMh228Az+dKfDmIOeDGmSrWdOYZ8EmmfarevvjcD/40GefDOoT73Ml5VsxpZhkyepy7HOpUypS0JIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391176; c=relaxed/simple;
	bh=qn6C4wVA3cOLV4VVI1/w/7nAgPug70X0Whx5wVdf/EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JB+XhWGQCCyynhVY8VYpkcIKQLSoV9klXl1g2ewsM6uSAk4wG2xZxIYcVGsgsGtpVrlRhGNZewTu4y0pJIxMW96srT+sihKrGf61OTOKw1x6zhWNuVw0mWHPZI8/1kjlu1YG9wkMBgBzvkMpyc5p/p6itbQAEJFJ3uZ3npJ0nQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEyX9j7x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0tJY04K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713391172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyuJ8mRZERV0q9WMSxzJ1SqPvH/eh2GfSaBY2YWfdjg=;
	b=mEyX9j7xVIJ9vqCryCfwshRlv8O9ha/ZPkIvPj5rvQYqXQ9crX2j6tjEKEOpclvcLe7xIP
	6sEYsrEyiKV2ByazwZaMwKbNsmTeH9Wa2bv4crOqI/X3qUIF/lfQHA81ML+vTKq/pTRKSJ
	wmvSyRje9dTtQVOQ3O32gvGn/wNc+0jcYr4y/Wmm+Xc1Eu8/aF57F3f552TaOidcF3oChf
	yAIAjIVpN+UwEy87QpUyec0SrT3WVfjXIElWaWTWITaQduzI5Omr8WW7UcRYDWQYYBBAmR
	sLsUw5BGAe53YwVFGLybbha633K6FTBkROYiI1TfrOaTEIe04+qfogHkUdLwVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713391172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyuJ8mRZERV0q9WMSxzJ1SqPvH/eh2GfSaBY2YWfdjg=;
	b=g0tJY04KqAKNcNKkhm+6VF0cYnY0uNl8m+VJD3OjXThdAMnTe6x+J+QAq9UBJTD7lcO552
	/h5DPkCt13MEF4Cg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
In-Reply-To: <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
 <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
Date: Thu, 18 Apr 2024 00:05:29 +0206
Message-ID: <87sezjodku.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-11, Petr Mladek <pmladek@suse.com> wrote:
> console_flush_all() is called from console_unlock().
> It might be called in atomic context. But the current
> owner might be theoretically scheduled out.

Nice catch. This problem was introduced in this series after you pointed
out that return value of nbcon_legacy_emit_next_record() did not match
the semantics of console_emit_next_record().

> I see 3 possible solutions:
>
>   1. Enforce that nbcon context can be acquired only with preemtion
>      disabled.

Not acceptable.

>   2. Enforce that nbcon context can be acquired only with
>      interrupts. It would prevent deadlock when some future
>      code interrupt flush in NBCON_PRIO_EMERGENCY context.
>      And then a potential nested console_flush_all() won't be
>      able to takeover the interrupted NBCON_PRIO_CONTEXT
>      and there will be no progress.

Not acceptable.

>   3. console_flush_all() should ignore nbcon console when
>      it is not able to get the context, aka no progress.

This was the previous implementation, but as you point out, it is an
issue that console_flush_all() is no longer reliable.

I will continue this topic by responding to your follow-up message.

John

