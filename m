Return-Path: <linux-kernel+bounces-136295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A26889D254
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798AB1C212E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618E674BE8;
	Tue,  9 Apr 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYOorJOn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbYpmR4x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CF6E5EC;
	Tue,  9 Apr 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643906; cv=none; b=juLFPHUW+mR2rIgBAkeAS2QE5woNgaSoMIaV778KcSXZ/Br17WPnF11YNvT5lnqWjxB7QR3akOMsfAzy4ygmzadbXnEpBiNZNRI/C2YPf4byMVJH8xHlZCuQefg1B2e4DFS342KO1n5FdW2HIf0s4Br5ltxPLTkTZxNcmZdvt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643906; c=relaxed/simple;
	bh=HlmSSCVZdQmCWnjeClGFLPha+Xz2PdZIktjA8U3QIS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO8KsOuMJlOumXKlcmnxwkEbunztd15RN+w4JJtZv4q8iieA4tRHDKG3Ug0FwtvZxbBEXhkSrQiHOATg7157VS8y6IE39eAVmLfV8tXUltjXc3DCsZthGu2vkUE+/Sx917QHzJEHVCGlO5qKFSoEZ2aiKC5nZbLrQhb4DDLF9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYOorJOn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbYpmR4x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Apr 2024 08:25:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712643902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vPx4RdY+3a57wBnjkTS4Zn0DTC9QaePnrkvMC+kGwQ=;
	b=qYOorJOnB6B0bVb3Ncl/WSOlP5fDi9cbsddTaUdhR6LE0B+oqKhA5wx+76CTDTIy+/Wu0v
	kKvTQCecM840l/Xex49+GOn7Y/NM5N283Jz0RTO9dn75e8DFSvwinKvlBifp0CrfhQBZS1
	VOOsQoRcV2IojYT/2RcBWKSdWD9c2+aWQdvFrU/UXxM4m4YAO7WAJmU+qE4XQ+ySAr6GuO
	ybF4oapR/TpqmyDkes9ZWhidUqgDU0RY3XyOVi44tAd5l1jaVTGZqjkWRNq3lMZj18qZpZ
	tqiW0v/EsK5/7vM/ydcrOYhUzVts5SxfF52QxJWK3J1Z44NStzKs56a9mtpDNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712643902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vPx4RdY+3a57wBnjkTS4Zn0DTC9QaePnrkvMC+kGwQ=;
	b=DbYpmR4xR4ny0R77fJNWxpn/2r3X7mrHHHewwpmFJeg+zSyUnP/JV0WDaewVisFTHROSCe
	YxW8SgW+lYxhLEDg==
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
Message-ID: <20240409062501.h4rA_ck4@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhRqSEbyd1rqVwfN@pavilion.home>

On 2024-04-09 00:06:00 [+0200], Frederic Weisbecker wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index e0b2da8de485f..5400f7ed2f98b 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6785,14 +6785,6 @@ static void perf_pending_irq(struct irq_work *entry)
> >  static void perf_pending_task(struct callback_head *head)
> >  {
> >  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
> > -	int rctx;
> > -
> > -	/*
> > -	 * If we 'fail' here, that's OK, it means recursion is already disabled
> > -	 * and we won't recurse 'further'.
> > -	 */
> > -	preempt_disable_notrace();
> > -	rctx = perf_swevent_get_recursion_context();
> >  
> >  	if (event->pending_work) {
> >  		event->pending_work = 0;
> > @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *head)
> >  		local_dec(&event->ctx->nr_pending);
> >  	}
> >  
> > -	if (rctx >= 0)
> > -		perf_swevent_put_recursion_context(rctx);
> > -	preempt_enable_notrace();
> 
> Well, if a software event happens during perf_sigtrap(), the task work
> may be requeued endlessly and the task may get stuck in task_work_run()...

The last time I checked it had no users in the task context. How would
that happen?

Sebastian

