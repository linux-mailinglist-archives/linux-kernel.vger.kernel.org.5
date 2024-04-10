Return-Path: <linux-kernel+bounces-138545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E1489F332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F641C26982
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86F15EFCB;
	Wed, 10 Apr 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iw2pEUtO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7JASDXn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC115B995;
	Wed, 10 Apr 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753491; cv=none; b=WGgzaL13acGzADfvkoAWn0xauCPEURexuld0Ozm9+WuBNrzibWcp8McQuvR2ZOobf62P24r3o7SRdw2gYjKNy/gf5NTFFnUzMLX6cRI0ZJu81NA6PgmGAWqOO+DGDSgj7mnZ8IrIhzZgjiRpBEcHyL0NZrSCJc07j9lprsRzvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753491; c=relaxed/simple;
	bh=LLMGp714NUJtAYoSJJfvg+tAURcKNyM+caOeo+Zjxmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNjOoaefTaayF9W1iF/fQLjzadMFe4c9fjf28mlF9GqBopjQmj5t5RDpCnX/MMfBm9HzYbTZmcBcMKe23qcL7rsQHB2qHLdVhByZtY6zVxUuM+hZNCrTrmmWnOCjl3F9k2rg1xKz4jGR8P3k2XLqIZn6F+OHtxdb9kef3eQTOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iw2pEUtO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7JASDXn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 14:51:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712753488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4QXXsu71JXQrIDib+0DcdWbOZC0pgoPfrFmZFNP9YI=;
	b=iw2pEUtOI2eZiBNUtW4AgZjjSQmLZy0yBPIv5T+wXGvsHP/vuXHFfAEk+2JDNji2JuZLsQ
	Ab9vPegknyD5vGwSW1VGmsRYvrkc6QhlWj4C7ORnw/Hc35OFqr2Nsni17Zdvxtmmt12WSN
	Cnk7cFq/zsyrE985StGzJ6ugfTxqdCGYaCsj0bO3s+4fmd9+ObbRJAUezu8vuWqrbs4mTF
	f9+qNqR5q2gKGWAuoUl4QYUsayf4PCjKySbF32oNI0NktBVhyyH/rofwjqVDcPHiipmtF5
	2nI8U2Si4vQxzDOcWhypE9RX2EYJFsyFh9Jftyq0U5sS76/6Ezesxl38Jjp+3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712753488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4QXXsu71JXQrIDib+0DcdWbOZC0pgoPfrFmZFNP9YI=;
	b=V7JASDXnjHUwWxLVi//k+JlpDl2zSCScJLqjUnDnxSA1Nx3xsauxDrCktOo/z8fugJI5aN
	t2jNcUrovOpx6uDg==
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
Message-ID: <20240410125126.X26tR8tM@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
 <ZhUaAjhQXN6ahtpS@localhost.localdomain>
 <20240409105405.TXUU--_W@linutronix.de>
 <ZhUt8XMndGSwNuwx@localhost.localdomain>
 <20240409133336.Y4Io-16-@linutronix.de>
 <ZhZsOvM3uTP6nTnZ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhZsOvM3uTP6nTnZ@localhost.localdomain>

On 2024-04-10 12:38:50 [+0200], Frederic Weisbecker wrote:
> > Anyway, I misunderstood the concept
> > before. That means we need to keep that counter here and a
> > migrate_disable() is needed to avoid CPU migration which is sad.
> 
> I fear that won't work either. The task is then pinned but another
> task can come up on that CPU and its software events will be ignored...

oh, right.

> Some alternatives:
> 
> _ Clear event->pending_work = 0 after perf_sigtrap(), preventing an
> event in there from adding a new task work. We may miss a signal though...
> 
> _ Make the recursion context per task on -RT...

The per-task counter would be indeed the easiest thing to do. But then
only for task context, right?

But why would we miss a signal if we clean event->pending_work late?
Isn't cleaning late same as clearing in
perf_swevent_put_recursion_context()?
If clearing pending_work late works, I would prefer to avoid yet another
per-task counter if possible.

> > > Thanks.

Sebastian

