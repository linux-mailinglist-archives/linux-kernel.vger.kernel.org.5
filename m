Return-Path: <linux-kernel+bounces-158701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787348B23FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF301C21D71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049514BFA3;
	Thu, 25 Apr 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ini0VbyF"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3114A0A9;
	Thu, 25 Apr 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054834; cv=none; b=qhxclAy2dmau+mh+MqIUFSabjOcXA3aegLJXFRVSS4hH/OI/RE3LNPpEzGQMbw5zw40IDoNPXvOpOj01/CqjmlR/RbA4fMsHInZEwCRkVRV9SdbYQZffFL4rUXOYL9muPZDDVVxzTJ7rDf/NfyoMNxODXkdpJP6u1g9Pf93Z4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054834; c=relaxed/simple;
	bh=JekMetg/YF071aOgGl/DrEuzh3d8IGL9N+wrQlKfEO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QREqstlpPuZz6XToXezUAY06ahm63XI0bqh5JI/78f33VDYnoxIMSLamgps6bBHFdMEUZcXGwwAe6scWsUOJuFPR/XlOYog1DmFun0EF8irHlFxGOkTxvfpo672KH2w+2fUb9XbNgtTYMLOiH6bEsXQC3KyNVZQT2rh9fOni+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ini0VbyF reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 05c7b55a3e2687dd; Thu, 25 Apr 2024 16:20:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AFECE66DF01;
	Thu, 25 Apr 2024 16:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714054830;
	bh=JekMetg/YF071aOgGl/DrEuzh3d8IGL9N+wrQlKfEO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ini0VbyF7UvGBKz+HxzK+fk/fRgbPxizJ+PdVeO+Tdw11egMVG0nhZXUhg5H8BQHf
	 ZsdNyYWSjoL9rrMEYCLoO9Hg4Prf28sHrML1iS2AItLw7opD840kfjFBPD+Yq9ZCCV
	 gdDnbO70s6Ymtmjr8J9w42lgToFRjyGmrfmw2f7yU0HASKMAAKZaPifs2EVTlxhouR
	 F1Awtj8RGdQOgnFzT/z7s5xQIfCtTR7Ygh0O/RZseekMnnKkeU4GThowGQZBv3p3OU
	 TIQy0EXga+T6ROHadsqzdXKl9rjQoUtcbEUJeFIr3gOKgGH/Tk41etN/Z9uCXlQ8wP
	 nxkcnFSJ6YZAg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
Date: Thu, 25 Apr 2024 16:20:29 +0200
Message-ID: <8409301.NyiUUSuA9g@kreacher>
In-Reply-To: <20240424100127.GV40213@noisy.programming.kicks-ass.net>
References:
 <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
 <20240424100127.GV40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

On Wednesday, April 24, 2024 12:01:27 PM CEST Peter Zijlstra wrote:
> On Tue, Apr 16, 2024 at 06:11:21AM -0600, Jens Axboe wrote:
> > iowait is a bogus metric, but it's helpful in the sense that it allows
> > short waits to not enter sleep states that have a higher exit latency
> > than would've otherwise have been picked for iowait'ing tasks. However,
> > it's harmless in that lots of applications and monitoring assumes that
> > iowait is busy time, or otherwise use it as a health metric.
> > Particularly for async IO it's entirely nonsensical.
> 
> Let me get this straight, all of this is about working around
> cpuidle menu governor insaity?
> 
> Rafael, how far along are we with fully deprecating that thing? Yes it
> still exists, but should people really be using it still?

Well, they appear to be used to it ...




