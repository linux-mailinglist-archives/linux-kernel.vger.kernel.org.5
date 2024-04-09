Return-Path: <linux-kernel+bounces-137022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B989DB38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0759E1F21CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D583C130E2E;
	Tue,  9 Apr 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwdKegbH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qis6pBGv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44D12C531;
	Tue,  9 Apr 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670454; cv=none; b=duGQbnoVcI1T18HVBQMdPgjlfNL5+A1n6xRXAUzmYLxYCTA2x27ZRETdGaY6/fwpXvxZCY0TNNEXFFAhY9Cd4WWuzOCmYLtUSw8V8k+aJzB049tU0UJuKkDtt/NJYCcZZO0Az+IqKQgTwZgoQtv3HAj5ho32/lHZ5vkXqaOExOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670454; c=relaxed/simple;
	bh=I8SXAbXUDHLLy/rIZkXEofnDWT+iXwoU5TWom6REpi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUNQEadzfFF0OlNoiTgZ0rXVGtrA7hKfn+u1+2pYSZsGH2jvJBMoS4qsnJZhuijBHXM4FulNPauTNPBI1TBBT1p6JT54npOZzeYpJTtwgr/WFAsIQdy1Fgg2TJihgNuC+TIb5OAE7doewv2Ot20k26L3Je8lGSoKNSiHTlV/sIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwdKegbH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qis6pBGv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Apr 2024 15:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712670451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lwihX0lE1ReWSXgdrfNpqgYNmD/FYsuPD3bWkvP0exI=;
	b=gwdKegbHi5653ZJtvhlFEc1q7AWHlvvUVPWFKsukgpMjeCJzWfXT7QRQsj7JeEVEenpMPl
	iJZKreZtD/uFRjawQ4IJ8YaCskfKYvJYvqRlWJxn0+FXD0m9XdhqvdL06pWZKqaUuRlBJj
	AUbDjp/xa1TrvxNrRUxf9CTX5Q5zCV2SfKEBqY+w9t2ZFThD3bkJiW/Ob0xWzXwATEvT71
	DPU1L9KGch4oWRDUNW7Ex7n+w/od3mJ1lkZzaKZpVvPZgfnge+FaogTwNRaB/mtTtb6Gd0
	3TqUnZcyzY15MesRKbZ7qzgOJfs9C+K/JMIBQkHzfToi89u4z03jUEQjsvNsdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712670451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lwihX0lE1ReWSXgdrfNpqgYNmD/FYsuPD3bWkvP0exI=;
	b=qis6pBGvUCGNhXD5K4LNKpfr8focouCEBdv3+vBqKg0+2ZChezXkAm0caqZBYlDgvdjg3O
	HTAu1GXBZAnZjLAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20240409134729.JpcBYOsK@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhU2YwettB6i6AMp@localhost.localdomain>

On 2024-04-09 14:36:51 [+0200], Frederic Weisbecker wrote:
> > That wake_up() within preempt_disable() section breaks on RT.
> 
> Ah, but the wake-up still wants to go inside recursion protection somehow or
> it could generate task_work loop again due to tracepoint events...

okay.

> Although... the wake up occurs only when the event is dead after all...

corner case or not, it has to work, right?

> > How do we go on from here?
> 
> I'd tend to think you need my patchset first because the problems it
> fixes were not easily visible as long as there was an irq work to take
> care of things most of the time. But once you rely on task_work only then
> these become a real problem. Especially the sync against perf_release().

I don't mind rebasing on top of your series. But defaulting to task_work
is not an option then?

RT wise the irq_work is not handled in hardirq because of locks it
acquires and is handled instead in a thread. Depending on the priority
the task (receiving the event) it may run before the irq_work-thread.
Therefore the task_work looked neat because the event would be handled
_before_ the task returned to userland.

Couldn't we either flush _or_ remove the task_work in perf_release()?

> Thanks.
Sebastian

