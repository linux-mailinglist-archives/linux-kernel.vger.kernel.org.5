Return-Path: <linux-kernel+bounces-103023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2B87BA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F81D1C21CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B996BFAC;
	Thu, 14 Mar 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eG5My/UC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjiPh8uk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC036AFB6;
	Thu, 14 Mar 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407438; cv=none; b=jORdzxsroSwHC6Hmz6Zc9vn8u57D30jwchVs0AeqeAFTuLwDnrCmCui/iXrcpCHQ3Sr2E1xp350QaSzGPHvsnTceCs+Un3tCWpQfYMrPhciR8ed7lHBMQEWwG3CLGTVwOBES51ugB3qbzm3yfElU6itAsQW7Nm7hjzijbxkEEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407438; c=relaxed/simple;
	bh=3v9SI2y0Fbvlzkw2wA+/CtWaFGYXqQtPaKDdJ2JD1XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyNbV6lOxW+KwaqRP7a5ua1AmXJ87WuSLt/uiM79pqoMwL1DkNOo/DjLh3LJrjKU1h6Rbxngn128po5zjPoDd6MbNKZfYNdsea3wwu1szsyAXvC/8unsOWyotGCntHZnW9hLaBsznpWqQNrkDBycoRh7gY4VNFcYgsYenjkUbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eG5My/UC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjiPh8uk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Mar 2024 10:10:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710407434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmjRAo4dqjYG8fE9KebsrrowCz2F2+E8qqexBK8mMaQ=;
	b=eG5My/UC4kai2HQxiRn18cvfF/+09X/3vLu6graK6aLIT2t8dVxjDz4k/kdb+PKU9Fiq+5
	bgmh0E5GOHeXQcgfM3bZ9NAkKQ400dtIarrfaysX71YsniLWOzgYMT318yRFGBGZsLZexg
	wn7NfulEYfBZt/LfQfmkfTTw53KaFynJ75zMcThreokM5NqPg+OA7vAEY4IOu5fLCX2Hgy
	p6LQXfPD+HLc11Xc6rNXCyI2hbB5jxdGY2BD3W7I2NBE22kdAtvw3xdwVbGXomuzqtu1SD
	zNVhh0cpO2I9CHHNW5glXngsPCyFhVLSf6GVmpSBhRtC3+iZ92oimAU1T/DALQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710407434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmjRAo4dqjYG8fE9KebsrrowCz2F2+E8qqexBK8mMaQ=;
	b=CjiPh8ukq0RYuOn4ajwbGi2UCFtxExM9RJEnxN4UtGFfg6j4WJ7LDKrl+KijWgVan2v01w
	KQMNgYySV62EVzBg==
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
Message-ID: <20240314091033.woaK8h83@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
 <ZfHw3J5PY6qy4mXn@x1>
 <ZfIIqcmRlrxwUFTn@x1>
 <ZfIJIfqeI9tWnnS5@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfIJIfqeI9tWnnS5@x1>

On 2024-03-13 17:14:25 [-0300], Arnaldo Carvalho de Melo wrote:
> > tldr; No dmesg activity, no kernel splats, most tests passed, nothing
> > noticeable when running with/without the patch with Vince's regression
> > tests. So:
>  
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Too quick, now I'm testing it on top of torvalds/master, no PREEMPT_RT.

Just to be clear: You revert your Tested-by because now you test this on
torvalds/master but not because you reported a regression which I
missed.

> - Arnaldo

Sebastian

