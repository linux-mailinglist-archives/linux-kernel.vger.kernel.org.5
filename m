Return-Path: <linux-kernel+bounces-103063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB387BA89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2CD1F231DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D493B6CDD3;
	Thu, 14 Mar 2024 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okLkm7DI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtUhg6uv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97D6BFAC;
	Thu, 14 Mar 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408953; cv=none; b=FJSppmJDzO6CXtmg0maAYGF3e/hyFlWf/NeSg5c6/NJwvVumQfgFyQ1JZe0nI69IWzgyv4pG2caUDZi7zD25jWVHoxwjtlW3nCmPH8l/H6z/WLOR3n5lneZI2IO7O3nFsCSImtly72Ow6m+P2/PkccJYroLuD1rqfig/mC3Da84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408953; c=relaxed/simple;
	bh=QBRFnshAWRpfqZwjRMRRzAQGvNYMEcWoioZjdVTx8Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8Vv7s8M6rnVXpp0ZOhQXa8dIA9fU2z9Wnm6+NKwTSvz/PvmxpWrx31kM2ANWreyj248jtFnzjwncNGhH4Gzm2p3YbOR1FvtHEcaNq7JONyIc+dFwcJj4eGaBmi/JvzF7gTTF0AivpeAGzE9443TkopU9h9Vm5IFDKdFzRNWCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okLkm7DI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtUhg6uv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Mar 2024 10:35:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710408949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wASLV8yYd2a3kgb3Xdjj61PCbQ4m+ePsepX+ftyYcfM=;
	b=okLkm7DISwWuq6CYgUsuPUcBQ1qhijHwpQ4QxK8ZP/LtjI7BH5UNbckx2niGt8NWaC4k4F
	cSagUr9zNkAqHVbKVFVXdOjxCgPR8Fd1OHd215OvZcUab05qsKVoa0yxPYoVpfzyzLt99Q
	fbqv52atGQI/y6oOHzbHtqjdN2AFNZGoOhgkQOXkEalPkzmRaMgEJc21AnYTpnn+V6aJym
	W3KuG96Rrl2tbCsPh3JQIf6LXUbdEBa/2kXUiLj6vpf5lRBzJvepeTXLZYxL55f4T9xEss
	IU0ctxQsKeZC5DMLBA+ZxSPmFjMRet9dKoNkD1j7AkCpiciyaQHEIeZZz8wwdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710408949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wASLV8yYd2a3kgb3Xdjj61PCbQ4m+ePsepX+ftyYcfM=;
	b=wtUhg6uviL4gNhG65TvaChxmRYcuOIUhatvlARTbB/HTSwwS+jd/XwCISj+I19G3ZOy6MJ
	SvT8ON8QG95JhrDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marco Elver <elver@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20240314093548.sVPg_3b9@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <20240312180814.3373778-3-bigeasy@linutronix.de>
 <CANpmjNNYNxMMSdWFiPiT3i888fi8--k_H0xMX7i17VCT97vARg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNNYNxMMSdWFiPiT3i888fi8--k_H0xMX7i17VCT97vARg@mail.gmail.com>

On 2024-03-13 15:41:18 [+0100], Marco Elver wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index c7a0274c662c8..e9926baaa1587 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9592,14 +9572,17 @@ static int __perf_event_overflow(struct perf_event *event,
> >
> >                 if (regs)
> >                         pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> > -               if (!event->pending_sigtrap) {
> > -                       event->pending_sigtrap = pending_id;
> > +               if (!event->pending_work) {
> > +                       event->pending_work = pending_id;
> >                         local_inc(&event->ctx->nr_pending);
> > -                       irq_work_queue(&event->pending_irq);
> > +                       WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> > +                       task_work_add(current, &event->pending_task, TWA_RESUME);
> > +                       if (in_nmi())
> > +                               irq_work_queue(&event->pending_irq);
> 
> Some brief code comments here would help having to dig through git
> history to understand this.

Sure.

> >                 } else if (event->attr.exclude_kernel && valid_sample) {
> >                         /*
> >                          * Should not be able to return to user space without
> > -                        * consuming pending_sigtrap; with exceptions:
> > +                        * consuming pending_work; with exceptions:
> >                          *
> >                          *  1. Where !exclude_kernel, events can overflow again
> >                          *     in the kernel without returning to user space.
> > @@ -13049,6 +13032,13 @@ static void sync_child_event(struct perf_event *child_event)
> >                      &parent_event->child_total_time_running);
> >  }
> >
> > +static bool task_work_cb_match(struct callback_head *cb, void *data)
> > +{
> > +       struct perf_event *event = container_of(cb, struct perf_event, pending_task);
> > +
> > +       return event == data;
> > +}
> > +
> >  static void
> >  perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> >  {
> > @@ -13088,6 +13078,11 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> >                  * Kick perf_poll() for is_event_hup();
> >                  */
> >                 perf_event_wakeup(parent_event);
> > +               if (event->pending_work &&
> > +                   task_work_cancel_match(current, task_work_cb_match, event)) {
> 
> Brief comment which case this covers would be good.

Okay.

> > +                       put_event(event);
> > +                       local_dec(&event->ctx->nr_pending);
> > +               }
> >                 free_event(event);
> >                 put_event(parent_event);
> >                 return;

Sebastian

