Return-Path: <linux-kernel+bounces-138721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089189F985
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1089C1F2BA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CD15F411;
	Wed, 10 Apr 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcyKDb6E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEObH6fW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACC15DBAF;
	Wed, 10 Apr 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757998; cv=none; b=giaQE2EuOL9KjeGNWDNNwH2IbGTEW7TCUMsSMdK+OlNhQbj317QaqrmAZ5iDNajwlWOJbsakoD4ti4Z7urErhjgqq7jm7jPRDOLsS8t2xQDPKZ/TXYI/Mjeb//ZVSvvPKvsI6wBVa7zZXlrfD7Hd8nGb2+/aynHeE33CnEoc/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757998; c=relaxed/simple;
	bh=YG3UNFG71SI7VV/cXkcthvTWFGFfieVr3YwF+lYyvKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvRjNKSawpL3qBUiVefRWzVxcKVErtDS5x7oFmQlqm8iJUx0rnmKKUrOeFv90kF41PqV5k/IbfRVK+Z6yJnWHx8tsqEyIQM4nuJksKRcMIE4itDIYqQnHj8X4T+ngiuvygOEv9nc2C5bXvR7bmQTuCNn6fs1O7w6eVC2fBKP+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcyKDb6E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEObH6fW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 16:06:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712757995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YG3UNFG71SI7VV/cXkcthvTWFGFfieVr3YwF+lYyvKM=;
	b=FcyKDb6E4bYWPJy/ktmc6KpStYEOiziYCzyXgEL+DP3YXwsy1/f8fUc913/lmEdT38kEdV
	pcR/7uCTbmtNq85FfqyJT//utRRtHpZA7togdpMnGrfrNy1gAo5TPOopYqY8MwfaGqZb0r
	+7QK2WFWvj+D1FOHpbJGklLZR0zp+BKED5snqiR92qXGnGVN7bOvZXtBRzQgvG2JPjPIR7
	GWR0EyTxLvpuQyeGAxRnTUx6yYs2JDn/Y6LY0BDm8EpXHkppqgubk9bGx5DHpbbZ7uoYRX
	gcED50gnyZXfzYt6YFX1CS3PVY4d1oK5OSzbnW9IF1JvwUjkZ5uDZ//mqwrF4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712757995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YG3UNFG71SI7VV/cXkcthvTWFGFfieVr3YwF+lYyvKM=;
	b=bEObH6fWkZ/awcDQZVhwsXdq3B0DTTDpy6ipTP9YT+nRySAFw3dBJKKM6/KDj50+yKeXsm
	Bu0LYFUNB8Mg4OAg==
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
Message-ID: <20240410140633.0MHBLpMI@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
 <ZhZ54XAcBt50WEnE@localhost.localdomain>
 <20240410134702.dcWYciZB@linutronix.de>
 <ZhabcanCbQej1azv@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZhabcanCbQej1azv@localhost.localdomain>

On 2024-04-10 16:00:17 [+0200], Frederic Weisbecker wrote:
> Le Wed, Apr 10, 2024 at 03:47:02PM +0200, Sebastian Andrzej Siewior a =C3=
=A9crit :
> > On 2024-04-10 13:37:05 [+0200], Frederic Weisbecker wrote:
> > > > Couldn't we either flush _or_ remove the task_work in perf_release(=
)?
> > >=20
> > > Right so the problem in perf_release() is that we may be dealing with=
 task works
> > > of other tasks than current. In that case, task_work_cancel() is fine=
 if it
> > > successes. But if it fails, you don't have the guarantee that the tas=
k work
> > > isn't concurrently running or about to run. And you have no way to kn=
ow about
> > > that. So then you need some sort of flushing indeed.
> >=20
> > Since perf_release() preemptible, a wait/sleep for completion would be
> > best (instead of flushing).
>=20
> Like this then?
>=20
> https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28=
147d8ac06b21c64d7784d49f892e06c0e50

Kind of, yes. Do we have more than one waiter? If not, maybe that
rcuwait would work then.
Otherwise (>1 waiter) we did establish that we may need a per-task
counter for recursion handling so preempt-disable shouldn't be a problem
then. The pending_work_wq must not be used outside of task context (means
no hardirq or something like that).

Sebastian

