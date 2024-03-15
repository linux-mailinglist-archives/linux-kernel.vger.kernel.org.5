Return-Path: <linux-kernel+bounces-104123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A787C968
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBB6B21762
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD221429A;
	Fri, 15 Mar 2024 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVhT/5Bm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBzm4NEk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285112E71;
	Fri, 15 Mar 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710488480; cv=none; b=CUhWPuNsiPKFEil51sbgkzLtHIkZkG+bsTLW03uAsaUUoePDWQWNp0vGhLHfihWcIYAKPi8RNIOeccff4coXqccHawS92RzHWNmh5/pXsyznZ09rHjFdOMfoRvJUtsyOIXkmzUbF/yoRz5Sk8jKD0UTONk195mdnZ4dvOCFcS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710488480; c=relaxed/simple;
	bh=CQ8sthM+ukAAJ+yhQdfaSjJZHn505UW1ZJOHTWsqQBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVwCBOlc2YQLS1tFBWKtoR3YGckoiyhNqmLdTg5R7zV6vG5IvR1hqgecICWlS+3N4Cueujnre2PmcujYpA0dBrxCAMX2Hb8l0CbGdNiQuCkUwjjHw2pzpwNbFpSotZv3sjZfA+FIGcMnGobc2RcVHE22HZqn+b07MFPDdBS6K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVhT/5Bm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBzm4NEk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Mar 2024 08:41:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710488476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VDp1Ceo9uiNPto1QZnXHckVKvG4yvIiVDzP9krVh2w=;
	b=GVhT/5BmPboBfXfrBdfMvV/KOSpjoHawAmDYKvFDbHx5/9opTgfSsjFJ3JhHBd312Pb/SS
	b2RkTz1D3UJesQSqhCGxIbkSiBe5GWXifLzyzk1K11kfSyR4UpMGGUD5XF1V4PK7ofV4LH
	nBiwDUJMpyy06QrsPxeZnPp3z7Pye6PbOjnDa99tQRgupbEowpr4r50IXp1WgZ87BysbiJ
	I8B5OT/d73+czOKTv3C1jfzxk9vAnnaWUFhKZGAUE4OccYrkphNVgd39iN3mifZJCMOKxj
	vs2TRoVjID5xS/tQBA0K0/Wla7Alf0Mr8KwQ4xl8wJhATb9QkbK3Bc9kpUPMyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710488476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VDp1Ceo9uiNPto1QZnXHckVKvG4yvIiVDzP9krVh2w=;
	b=uBzm4NEkle7ynXXoIeCeRHz7B8GbWEJK9cohpzRcJGjM5hwkuP166D0FnbrqZAm4y+0Mid
	M9MDGCiKTCybrxAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Marco Elver <elver@google.com>, Vince Weaver <vincent.weaver@maine.edu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240315074114.1wRuzXFO@linutronix.de>
References: <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
 <ZfHw3J5PY6qy4mXn@x1>
 <ZfIIqcmRlrxwUFTn@x1>
 <ZfIJIfqeI9tWnnS5@x1>
 <20240314091033.woaK8h83@linutronix.de>
 <ZfMK_yTzxTQCMGZ1@x1>
 <ZfNqnjdR-0YEsSnb@x1>
 <ZfNwLfdOLBytjF06@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfNwLfdOLBytjF06@x1>

On 2024-03-14 18:46:21 [-0300], Arnaldo Carvalho de Melo wrote:
> So despite this mistake all is well, torvalds/master + your patchkit
> seems ok.
> 
> Sorry for the noise :-\

No worries, thank you.

> - Arnaldo

Sebastian

