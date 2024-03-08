Return-Path: <linux-kernel+bounces-97424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF73876A50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BAA284DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2E54BC1;
	Fri,  8 Mar 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0RyszwI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mKcWA01d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F6282EB;
	Fri,  8 Mar 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920703; cv=none; b=pN8k8ausbc3rssdXAr8MCKDvFjvGkVL49IYGCAYZaCk4Ew6VzOkUilF2sJGnMMuAMIlJ8oI0YZUsS7vSEvHNlbKOHanm313HKZ2Yd5z2aCJIU7CQFHGgMvpqKr1xp9RkmOHOLsgWrrv1+qj4dIk7SdqUHSWU75U7OuFqUlA2XsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920703; c=relaxed/simple;
	bh=rb4j/fngEBckvfiSTCJqL9xaGeMYTtosqeRUGbOZKI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LarfHqCz5xnk//SbwYkP1o48BKAgHPDKfhqnfsDp7pfUHOfNLMpGFS0YwyeImwalh+QmrSwwFBoewj7X6O0tQfJyxf4sZm6MMDU1jHpVWF2VMGLdbx2qGuhOKsIVeLBRV1WlaOHbEhEPtLGF/EM5d8DVic4J6FfjgJyERzRCpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S0RyszwI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mKcWA01d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709920699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rb4j/fngEBckvfiSTCJqL9xaGeMYTtosqeRUGbOZKI0=;
	b=S0RyszwIUN4ilqUtNGWL2DoIBFS6HL3AXshFOKdIcBylQs6EmgeURpOvx5LDYdv42LUJpQ
	qJu1PJho/gvB9Bsp4uAX4oMXjUD1Zzsy6bVinq+nK9+Z8EiPXvi/xoDy8TWXKe3Jh9uWH4
	C0BSXcD/O9qFIOXEt0UOIEkEvqqI+P+b19R808XEfljK5mEYPhH1oczU5CFoGzIThZWo8W
	2Mfgjfndktq/OwdUHQt3RBLtdOgcAt7hhuPlNJlpl157wZ8txOpTLde1kISwZwD6cICUsJ
	nTSp0IF2b/2SSiU7L7WpqvTrT966U4GScwfdhmnJu/B5ZZf0BzKaZBholojHDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709920699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rb4j/fngEBckvfiSTCJqL9xaGeMYTtosqeRUGbOZKI0=;
	b=mKcWA01d/b7ypBUfma0R9lss93FkwXKYdDbSzqtz8La0U2PjByiAQmwx6vN5QbIlDN10pn
	obZEJa4AtCBTeKBg==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on RT.
Date: Fri,  8 Mar 2024 18:51:26 +0100
Message-ID: <20240308175810.2894694-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
the signal gets delayed until event_sched_out() which then uses
task_work_add() for its delivery. This breaks on PREEMPT_RT because the
signal is delivered with disabled preemption.

While looking at this, I also stumbled upon __perf_pending_irq() which
requires disabled interrupts but this is not the case on PREEMPT_RT.

This series aim to address both issues while not introducing a new issue
at the same time ;)
Any testing is appreciated.

Sebastian

