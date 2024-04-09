Return-Path: <linux-kernel+bounces-136707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E689D74A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332A51C226EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6D83A09;
	Tue,  9 Apr 2024 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAEJsKG7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="42LboFMA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9541C60;
	Tue,  9 Apr 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660050; cv=none; b=sSAyGF6rvTDxfDzclAlFwgPH1hFiX1Xmg+MU1Nn0y5PhlOVRjeg8WcSWbUp5gizKhsgkLQPa/u6eYStpVXmK4j0aYBn8neDRkt2yFSay4Nw6NC1Acx1f/IozRLLuGT032IrHeJvt7FOVdH4z6EhEKR5UesU8dmGEcnMovppxXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660050; c=relaxed/simple;
	bh=AmtCJGio7+/c/U3LCQSr/M+tiho4jMrfzm0pFOKmd3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEf70V/GVPj7XN/GTQxR5ERYUMmAyMSPKIWxED1+nZAg8gmGf1FwnXa8f1FwVKmeWjIPtgggIKnX1guVP/6ZhEBU9hEAxVa/9dRTkKBEvOPKjv2ezoBKMHFQFZVcQ3lwU70rXnRuzn7oUtxbIkLI7YIjGZmLNU62ZdM/gtQpl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAEJsKG7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=42LboFMA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Apr 2024 12:54:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712660047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQhaAeu4zgh+swBjyQ1jvBjfUntN8xbRTvW1O/c0dxA=;
	b=QAEJsKG7EVYQa2Z4t2aXt3o1PU1qIL4S8OiHBMEeHgMJBGjMs0m+FsoNlhMhZP9xyutEys
	yq3sETvUtGyANdyJhJXv/LAIhqy6tUyBx1Vx6iqQzUXk8Fljn2qhlJFI+wE+LR8GT2E5ty
	0xOU8NysRauK/kiK8G2QEX1wB9RmDsCL7JerVkMc3iGXzwLsOcJopaU47zLj2MX6TUDVqx
	mfYQESpoMk3zgpKx6wy2Mrzc5NrdMaCpnEjLDUj9c7qTxpupQs6mqQjD0igZiqDyG9QdeC
	XWRIYuY1gBhxABJy4TZVXLECivGxVN0Apj8+ys8I4Hmu7AbAbA8KV5lkXIHRXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712660047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQhaAeu4zgh+swBjyQ1jvBjfUntN8xbRTvW1O/c0dxA=;
	b=42LboFMA3NIVV3c+yMBb0UPahS9AascTDZk/gUmQrgZT1T0ItSX8WBB1bQAgnriJzTKKNl
	p/TScuwMfOA3fQAQ==
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
Subject: Re: [PATCH v3 3/4] perf: Remove perf_swevent_get_recursion_context()
 from perf_pending_task().
Message-ID: <20240409105405.TXUU--_W@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
 <ZhUaAjhQXN6ahtpS@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhUaAjhQXN6ahtpS@localhost.localdomain>

On 2024-04-09 12:35:46 [+0200], Frederic Weisbecker wrote:
> > > > @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *head)
> > > >  		local_dec(&event->ctx->nr_pending);
> > > >  	}
> > > >  
> > > > -	if (rctx >= 0)
> > > > -		perf_swevent_put_recursion_context(rctx);
> > > > -	preempt_enable_notrace();
> > > 
> > > Well, if a software event happens during perf_sigtrap(), the task work
> > > may be requeued endlessly and the task may get stuck in task_work_run()...
> > 
> > The last time I checked it had no users in the task context. How would
> > that happen?
> 
> I guess many tracepoint events would do the trick. Such as trace_lock_acquire()
> for example.

So the perf_trace_buf_alloc() is invoked from that trace point and
avoids the recursion. And any trace event from within perf_sigtrap()
would trigger the endless loop?

> Thanks.

Sebastian

