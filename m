Return-Path: <linux-kernel+bounces-99163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E852878458
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6571C21653
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E647F77;
	Mon, 11 Mar 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNPllqJS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GwV6I2XE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833B47F4D;
	Mon, 11 Mar 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172772; cv=none; b=RE+T/8N1+md8dnDpfgqWnvr5F7f23+CJddY9D6CJzNO6XoWzcK+UbZ25Zh/1Ql7zowL+4mfA06SOUCPda2zMTejUNUFH4joLsWIjjDRWiTxrBKyNAMHceDW85SkeFMGWr0GjOBGjmELctIUCBOyrLOro55gMtEI207xo/T7oARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172772; c=relaxed/simple;
	bh=4BugHr60TAxM9GFD7EMINyyXd3drcAbOdsx/EbogY5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsJbfP8oaIdR/3m523AdCVAosIxXqyKR5gQ0QZgSAxGlEx4vdBDEhUJ+Tm5TpMyCJaupv4oRQ66moVJabA1oTiB7SZguN9FrLCqg2JD4YI7C8PCUTp5BM4m/0JwHm12JpK5MR8Q5KrAoJ+gJhY7CrUu3o/numQ+23DSF1SDUyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNPllqJS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwV6I2XE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Mar 2024 16:59:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710172769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BugHr60TAxM9GFD7EMINyyXd3drcAbOdsx/EbogY5w=;
	b=oNPllqJSSEriL4FYJmhPwJbZNqWG0YixSPKtZXWqa9GfDUbEyKsbaepG1yDdCslYJExcNx
	cnqjw2on+1jhfoqJ4O1F3PuZNJyOeWQhzeARzOOte5U3Nt6QrGYRS6wYGDqGN9XVQ1R5HW
	hTj/ZkYNScuuyEw7XzExoOoBKrhUv/fLFnQTvh4+uCrboyYVJdwlw0wyf9mC8TpcIKNwNG
	kcySEVx+pPU5jLFmEaiiKtqz07Q9+cxRmQHE9FGaZpWGvICVGc5YlGyZFoxmmKCS+A5m2T
	hU7BFnVdCTrHPdsvmX1dGzCvHJktUvFov43dHZaAHSncsF76Ic3C2xiORrPeJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710172769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BugHr60TAxM9GFD7EMINyyXd3drcAbOdsx/EbogY5w=;
	b=GwV6I2XExeJg1n5NnD/ICHqt3deefJJMMp8xu8YU4QSs/eNHN2SijcCZ+NiNSX4uLLrK2t
	xdhK69G9fnCAurCA==
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
Subject: Re: [PATCH 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on
 RT.
Message-ID: <20240311155927.sbWzLN62@linutronix.de>
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
 <Ze7eKgdajyEgQcpL@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ze7eKgdajyEgQcpL@elver.google.com>

On 2024-03-11 11:34:18 [+0100], Marco Elver wrote:
> Unfortunately there's a bug in it somewhere. It can be reproduced with
> tools/testing/selftests/perf_events/remove_on_exec.
>=20
> (FWIW, the kselftests in that directory are more aggressive test cases
> that I never figured out how to properly port to the 'perf test'
> framework: sigtrap_threads is a more aggressive version of the 'sigtrap'
> perf test, and remove_on_exec has no perf test counterpart.)

You posted to warnings, I can only reproduce the second one. Based on the
backtrace it is obvious what happens and I dare to say that I know why=E2=
=80=A6
Let me try address them.

> Thanks,
> -- Marco

Sebastian

