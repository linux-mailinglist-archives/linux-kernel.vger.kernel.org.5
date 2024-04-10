Return-Path: <linux-kernel+bounces-138673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A755889F99F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15878B31D33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C615EFD6;
	Wed, 10 Apr 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Riu6LYCO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09FWCbA5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1391854;
	Wed, 10 Apr 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756827; cv=none; b=BuXz9uJqk49qZMhfR/DeDlZYNapPJ9DmUHopOlBJv9MbqcSNuHeVq3xLvPuGG0OFNiznqkOhEel7HNogEGgSn3MMaQYhX5RfaRuW+Ix1V4zX3EvyjBtcIKekFCbx4ULIF3gW29P4yOJ58OKSMxg5vhSpMCLe/nJPzismxHi/j8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756827; c=relaxed/simple;
	bh=9ai/S2RKppG6/QBUvnM1yQb2xUplPv+uZ4oIw+16Bus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzKPn/emKf6uUMprV1LkvnR9jZItlNGeO16N65hy8LHrx8xRg1JbIpp3+lFk19zLO87DaXLQLIO27mLPHIYsZcCcLAakPt7oP5lRwZlmlcNPaljHk5X82GENaPxxXiJYpwLNEyYOrAS9cbqEUo/qOTln8elIQ1iWR6wZ7BablnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Riu6LYCO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09FWCbA5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 15:47:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhPMkf0CnmtshBlL7f3oui1BPAffLvF7f43OGucaSdU=;
	b=Riu6LYCOxJAkNl00u5Bj3HXspqVWVG8Ca0CkgDTEEZdAXPg+FqRORQt7OVj/m2G/OHAx1L
	i7P/0rTdHxhgdlPN/SIs1X+Xi42IVCNdem15ynQyHGWdywtcCJNTtl9nNKLOzHnFM+QK6w
	vQe/d9++1fx1E7jXFHgKOpQ4Mz+6FJyw64nLx4Cd8CsRJfasMJx++Tj0OPOe3g7/ixH6x7
	OZcbWQtmHgPds9NhAr+SodvnCBdXpXbsdN9xLtXKquna6/Ok8h5azRkL7q0IvG5v8Mk+ge
	8YJpyOEnnOYVd+VdrawJvzDV+F/HWIrqdWqIllcYMp1lIwSrOy7a+w6Fd342dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhPMkf0CnmtshBlL7f3oui1BPAffLvF7f43OGucaSdU=;
	b=09FWCbA5NEKVjftJWaJb8Fqv88LdWfqW+AD4/9Dpfxi4KOIBw6/ksIx75cNeLY5EdYE5Ca
	GAil9/8NDHFboaDw==
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
Message-ID: <20240410134702.dcWYciZB@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
 <ZhZ54XAcBt50WEnE@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhZ54XAcBt50WEnE@localhost.localdomain>

On 2024-04-10 13:37:05 [+0200], Frederic Weisbecker wrote:
> > Couldn't we either flush _or_ remove the task_work in perf_release()?
> 
> Right so the problem in perf_release() is that we may be dealing with task works
> of other tasks than current. In that case, task_work_cancel() is fine if it
> successes. But if it fails, you don't have the guarantee that the task work
> isn't concurrently running or about to run. And you have no way to know about
> that. So then you need some sort of flushing indeed.

Since perf_release() preemptible, a wait/sleep for completion would be
best (instead of flushing).

> Thanks.
> 
> > > Thanks.

Sebastian

