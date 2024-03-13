Return-Path: <linux-kernel+bounces-101609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC887A94F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8181F215E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19046436;
	Wed, 13 Mar 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hXvkL1Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8KyTIjh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08517482D4;
	Wed, 13 Mar 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339355; cv=none; b=nXH9UY25J1WbaejIY/oIyUlx/XHcg06xD0a5aayyOyBqwxxZ8PQGJzcTpLawjtovohIg9jzVZx2JyiQ2G3/Qs473l+mIVAxuDlx8WpeyRA4ZMLTB8LEvycthT1gMUYT6smNEZqHBr5u4Ck8ru11dIpQaDVbFoGL1PMaHSVZOY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339355; c=relaxed/simple;
	bh=WpNypiDUbIttvmRZkKiZ5UNvBc+73ezSZ8gMtTGp8RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS1Ct7JooyWDbyK7czCMx6KLXLTEsHGSSawnGp04VF3VrYnO82VS8uVYALb4dwanW3I7TEMPU7fq8ccVde4AsaxdsITKGFnfHbvwQoq6/THliWRzTRqCamzFhwHnJM8Er188ZuUZIjR9kKo7iTZ/VOfetee7FqcyJm3v4twTW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hXvkL1Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8KyTIjh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 15:15:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710339352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI193fJDLU/y2cWHTwdgLD8Oka3XevL6LyppQimuzjM=;
	b=1hXvkL1Zg/IhiS075mOGe9ZU0T4/6WK/nwiua1qSKzQlOHStZQrv4dOeJPtn9dUEF32h+b
	n51CM6FTNuHGeJhd4QgkruPmi18/fHD5PMfV3BsjnBhVa+olyUGzydvSUQtW3vhALmw7LU
	u+mrk9ru/rWzbgaQxNP48T/6WvEG3+OJhV/9X2sNVGQSLAfqMAkXBYyKHT+F/KEGU/2TJX
	MY2L84ig2L+cfjsXBNyzTQKBWV1UaPVr/nuudxR7DEdIQln7fIRnybIXlTp+bag9XMy2nL
	7AL7HaSkH6qfgUIbmt5NbxEulDFAyEr8iD3dY3uvXHdAZ/PtNT/IzHI24tdVaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710339352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI193fJDLU/y2cWHTwdgLD8Oka3XevL6LyppQimuzjM=;
	b=h8KyTIjhtVY8rAzk8nCvbHrXPCRFSv3lon8hw5z3qffzk7/z8PcZMD1+MD9UhiI4+i6T2B
	OJ6b0gBt196JxxAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240313141550.eG5aJcAq@linutronix.de>
References: <ZfGqCWzyVzyGQrAQ@x1>
 <ZfGudRl9-tB_TszO@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZfGudRl9-tB_TszO@x1>

On 2024-03-13 10:47:33 [-0300], Arnaldo Carvalho de Melo wrote:
> /* For exec'd child. */
> static void exec_child(void)
> {
>         struct sigaction action =3D {};
>         const int val =3D 42;
>=20
>         /* Set up sigtrap handler in case we erroneously receive a trap. =
*/
>         action.sa_flags =3D SA_SIGINFO | SA_NODEFER;
>         action.sa_sigaction =3D sigtrap_handler;
>         sigemptyset(&action.sa_mask);
>         if (sigaction(SIGTRAP, &action, NULL))
>                 _exit((perror("sigaction failed"), 1));
>=20
>         /* Signal parent that we're starting to spin. */
>         if (write(STDOUT_FILENO, &val, sizeof(int)) =3D=3D -1)
>                 _exit((perror("write failed"), 1));
>=20
>         /* Should hang here until killed. */
>         while (!signal_count);
> }
>=20
> So probably just a test needing to be a bit more polished?

Maybe. I'm not sure where this is coming from. Either someone should
kill or the signal should be delivered but, hmm=E2=80=A6 If the signal isn't
coming then it might one of those without a perf counter.

> Seems like it, on a newer machine, faster, I managed to reproduce it on
> a non-RT kernel, with one exec_child remaining:

Okay, so no regression. That is something ;)

> - Arnaldo

Sebastian

