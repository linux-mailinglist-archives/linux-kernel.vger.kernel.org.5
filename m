Return-Path: <linux-kernel+bounces-138810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3989FAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53851C20FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013C179219;
	Wed, 10 Apr 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cq7VH3UU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rD1D0Im1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AF179207;
	Wed, 10 Apr 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760505; cv=none; b=ipo/SSfd7VmCp29qRBW+eujpggpSiYLaMM2WcwnYnejdPBxPC6pidArTD2p/3aQPerO3g+NyE5wLh26tnjSIocQwYWrhexg7CiJ3HHgPckOukdPB1deMPIK92UZehTbsZ092f8u/kpX4VPKW/MUtoLsiVEZxrwbfFPcdMPGi64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760505; c=relaxed/simple;
	bh=tDuuEQyJDMcj9XwP0qQQysyngBeUz2Vpvg0kCnx+8xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQqk0U5Bz0Ot4NTe/ezAXQ1vBprPQjSNNCn1bPvW7mAzRC9HEnAyFeyjYfAt1OQzrVWX4Nvh2zPmmzg9Wo0tvzzgXVTN6krUo4EDGXk1AamdaV7bys2psMRYD8OFf+N97vzB21cUn5aIgOWNIf7k3wX/+FVyGUGa2N2gf63RNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cq7VH3UU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rD1D0Im1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 16:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712760503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhDVG2F9WXHf/tQLyq5MH5q7SbNdjT+z4V3IMNo6lx4=;
	b=Cq7VH3UU9v17nIymWd7BnnRkuiUkRvP3jDCmzgN0BIkQpdaZbH6K8uS/+x6MhSIMheCscK
	UTTCh/C0tkPqOKpmsUSUOAWKZ+45uMw4SIQ4VwgR2UHAoqcSWJ/1/bXg20w4kvKJm2Xc0i
	v+2rsXopIP4efDjij6v/Hy800ZUmbTo1zYNV++tTKVWEZqmpT8Uo4gSaspFgBEGEevt37W
	80LkdxqFWBglf0VlRyePtLrGSWoAR5G2HVQfT4+ZHP+54yl2M+CMA05phYwB2WrkGgrdlZ
	b0tzHWuWwt1Rbm3bZu2xmJUjlmSiA1UHuE1ZIXzv+MKwW0XDBgN8uA8RbQiNXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712760503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhDVG2F9WXHf/tQLyq5MH5q7SbNdjT+z4V3IMNo6lx4=;
	b=rD1D0Im1EO5uMEliAwyEZ+ROwmRF7ctoAFXiBTycXQfc5VrdGW1yVkDhV61fhjb40kTQqx
	c2Gs/Rg41ogRZBBg==
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
Message-ID: <20240410144821.bVdBdVOR@linutronix.de>
References: <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
 <ZhZ54XAcBt50WEnE@localhost.localdomain>
 <20240410134702.dcWYciZB@linutronix.de>
 <ZhabcanCbQej1azv@localhost.localdomain>
 <20240410140633.0MHBLpMI@linutronix.de>
 <ZhalcBcd3w0w2HD_@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhalcBcd3w0w2HD_@localhost.localdomain>

On 2024-04-10 16:42:56 [+0200], Frederic Weisbecker wrote:
> > > Like this then?
> > > 
> > > https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28147d8ac06b21c64d7784d49f892e06c0e50
> > 
> > Kind of, yes. Do we have more than one waiter? If not, maybe that
> > rcuwait would work then.
> 
> Indeed there is only one waiter so that should work. Would
> that be something you can call while preemption is disabled?

rcuwait_wake_up() does only wake_up_process() which is fine.
wake_up() does spin_lock_irqsave() which is a no.

On the other hand that preempt-disable needs to go anyway due to
perf_sigtrap(). But a slim wake is a slim wake ;)

> Thanks.

Sebastian

