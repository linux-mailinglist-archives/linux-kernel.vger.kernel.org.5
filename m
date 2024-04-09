Return-Path: <linux-kernel+bounces-136968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D23689DA6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF4AB2554E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AF131735;
	Tue,  9 Apr 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nIC9LRyw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plxGPPUi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870D13118C;
	Tue,  9 Apr 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669621; cv=none; b=SWkLUybGChpiWPIaRlKUr9yft2A7QiJrlRzCBF8gqe+s1BHu0uUeeXhrIVLQVNGC38GMU9DcImf4z1DN5cJf4zURrjcU2+d6NA70R7GF1faqMDDOeAsP5pdHc9v3MaF1gc46twsRwFzvQDnXA+N0+RRX2Fl7AU+I264Y6ZLmbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669621; c=relaxed/simple;
	bh=pWQnQ9LXN4+KTgXHpwSd2PzBppm7znjsfC8WNvHWtjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/NepFyaJjMBGWh9yd5W9hatsdWdhIFBvo95Y+ydWeuZGyFBQg5LuHB+CfyK0OSWraQfJFsTsfYLdqiJ/ytRch2m/wvuFOvZuNGmKt87K0yMXK3GR2OuIUmbBnF8dDX1xJ70WkZsPooXrnDHnIrjGQxRB0+j1kw/DqEATgRRQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nIC9LRyw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plxGPPUi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Apr 2024 15:33:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712669618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SMVgpEWOLLh7oySvccsorrgvMSBwV0srF8b/SH3+RY=;
	b=nIC9LRywVeMI/z6XQ+u9lIdyMZ/5bXgDOvx6IbXX81fygT6yE6vTF6krHnYgNVr6CIv80g
	tHZ6pZuIiX1PHZK39sZF/t9OIPzaIBTSYeYSVZzVXP75+dK1QaRRqKb58KLjHWDc5pg9T0
	4nLTBBtBt+7mKJxDdPYwtBEjmE/GydCh9BUQx6EqOJq/AAfhmUiwBqxuxs4SL9J2Cc2Wg5
	L+xkxPoO1Nmq81wazQOoOMd4RBIBZk3CcmEo2JLi4AeqFZAHixoAa7RQ5joF2bOEBdUWBC
	WXmLVS6bJPMC58hShMKlbj3gjgCoe3JZ8v46yaYB4Kn562gzBsKqKB7XD8U4Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712669618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SMVgpEWOLLh7oySvccsorrgvMSBwV0srF8b/SH3+RY=;
	b=plxGPPUitPqhGo4DexbruoCSFELJK1rx3Z2L0afSobUiuIyjZelu3pAQ9uxPnyJmPRgd5z
	W71JKLViKvlKn7BQ==
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
Message-ID: <20240409133336.Y4Io-16-@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
 <ZhUaAjhQXN6ahtpS@localhost.localdomain>
 <20240409105405.TXUU--_W@linutronix.de>
 <ZhUt8XMndGSwNuwx@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZhUt8XMndGSwNuwx@localhost.localdomain>

On 2024-04-09 14:00:49 [+0200], Frederic Weisbecker wrote:
> Le Tue, Apr 09, 2024 at 12:54:05PM +0200, Sebastian Andrzej Siewior a =C3=
=A9crit :
> > On 2024-04-09 12:35:46 [+0200], Frederic Weisbecker wrote:
> > > > > > @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct cal=
lback_head *head)
> > > > > >  		local_dec(&event->ctx->nr_pending);
> > > > > >  	}
> > > > > > =20
> > > > > > -	if (rctx >=3D 0)
> > > > > > -		perf_swevent_put_recursion_context(rctx);
> > > > > > -	preempt_enable_notrace();
> > > > >=20
> > > > > Well, if a software event happens during perf_sigtrap(), the task=
 work
> > > > > may be requeued endlessly and the task may get stuck in task_work=
_run()...
> > > >=20
> > > > The last time I checked it had no users in the task context. How wo=
uld
> > > > that happen?
> > >=20
> > > I guess many tracepoint events would do the trick. Such as trace_lock=
_acquire()
> > > for example.
> >=20
> > So the perf_trace_buf_alloc() is invoked from that trace point and
> > avoids the recursion. And any trace event from within perf_sigtrap()
> > would trigger the endless loop?
>=20
> No sure I'm following:
>=20
> 1) event->perf_event_overflow() -> task_work_add()
> //return to userspace
> 2) task_work_run() -> perf_pending_task() -> perf_sigtrap() -> tracepoint=
 event
>    -> perf_event_overflow() -> task_work_add()
> 3) task_work_run() -> perf_pending_task() -> etc...
>
> What am I missing?

Yes, that is what I tried to say. Anyway, I misunderstood the concept
before. That means we need to keep that counter here and a
migrate_disable() is needed to avoid CPU migration which is sad.

> Thanks.

Sebastian

