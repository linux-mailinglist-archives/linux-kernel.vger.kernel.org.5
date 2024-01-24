Return-Path: <linux-kernel+bounces-37739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0ED83B4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70248B21C96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF00135A57;
	Wed, 24 Jan 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="AxTz45O4"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074ED1350DA;
	Wed, 24 Jan 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135329; cv=none; b=L8K6ClUuomDtje75KL1h52CM9E/0gdPwe7AHRD7KkRUeDFhYp5CloTX44M1m+IQQPclbYHthCxTJkH6Y72Vad4AOkpurFwojN3u9LEgaeVTefh54vqw+g2Zo2akGtBxVzlzTULM3G3pF5MszzOcQ1KZ1mFuUfKQaQWjwlP1W9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135329; c=relaxed/simple;
	bh=PjBaRGUcCxuYYlWRwycncNyI+zHRwufStuIXzbjivD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuCw2ehcbW/yjcsa6k32BYnJsa00CD5QVfPvqgdojmkzT48uU3OUo3lhzjy4x3kZyDJKG4cm8YHfZCaI0w2CBm96Ajq1yMuAvdrX6hMzPwxtf34bKcVaXxJlUBQr0V1wJmF/75IcGBosyyuDSi62hqeW/l4ifzDzQWi5ss/zkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=AxTz45O4; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=ZPBOl6Oodg5WNWEtfw0bznlEeM32JTkt2mppCYXTsZU=; b=AxTz45O4IPVwdEsZ4d2jxOhU5b
	trCrIwiFt53OCWqirS86TFnC/4IA4+FwEHvCEyzhnrE+eQB0Z9XpwShy4tYX/NLAbMpHhj7WA6tEB
	68tzCKBgAEf+7iUGjyatfhRgvi8f1MyS3OBFUFHj7hIVY+9LbprlGU7weKylilMiRTwke31IlSy1r
	L1R29ouAuiLhj0LUq7L9eELs7+Gtr/XfBTuf0Tep2hpafhL3PpY7JtGzzv7FQtO+I65Kq4qDG6EKa
	8v19v6pGxRpkH55Yt6HSDW1VBGpZv/yJmKifTZ9+34ygDSZUxgqhMVUH1NUqSmceV75aozH3mKiSn
	AnnLk1sg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSljd-00EYcK-27;
	Wed, 24 Jan 2024 16:28:41 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/9] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Wed, 24 Jan 2024 16:28:41 -0600
Message-ID: <8367053.NyiUUSuA9g@camazotz>
In-Reply-To: <3ec03a12-ee1b-45f8-9f03-258606763d1e@app.fastmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <4864383.GXAFRqVoOG@camazotz>
 <3ec03a12-ee1b-45f8-9f03-258606763d1e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 January 2024 13:52:52 CST Arnd Bergmann wrote:
> On Wed, Jan 24, 2024, at 19:02, Elizabeth Figura wrote:
> > On Wednesday, 24 January 2024 01:56:52 CST Arnd Bergmann wrote:
> >> On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
> >> 
> >> > +	if (args->timeout) {
> >> > +		struct timespec64 to;
> >> > +
> >> > +		if (get_timespec64(&to, u64_to_user_ptr(args->timeout)))
> >> > +			return -EFAULT;
> >> > +		if (!timespec64_valid(&to))
> >> > +			return -EINVAL;
> >> > +
> >> > +		timeout = timespec64_to_ns(&to);
> >> > +	}
> >> 
> >> Have you considered just passing the nanosecond value here?
> >> Since you do not appear to write it back, that would avoid
> >> the complexities of dealing with timespec layout differences
> >> and indirection.
> >
> > That'd be nicer in general. I think there was some documentation that advised
> > using timespec64 for new ioctl interfaces but it may have been outdated or
> > misread.
> 
> It's probably something I wrote. It depends a bit on
> whether you have an absolute or relative timeout. If
> the timeout is relative to the current time as I understand
> it is here, a 64-bit number seems more logical to me.
> 
> For absolute times, I would usually use a __kernel_timespec,
> especially if it's CLOCK_REALTIME. In this case you would
> also need to specify the time domain.

Currently the interface does pass it as an absolute time, with the
domain implicitly being MONOTONIC. This particular choice comes from
process/botching-up-ioctls.rst, which is admittedly focused around GPU
ioctls, but the rationale of having easily restartable ioctls applies
here too.

(E.g. Wine does play games with signals, so we do want to be able to
interrupt arbitrary waits with EINTR. The "usual" fast path for ntsync
waits won't hit that, but we want to have it work.)

On the other hand, if we can pass the timeout as relative, and write it
back on exit like ppoll() does [assuming that's not proscribed], that
would presumably be slightly better for performance.

When writing the patch I just picked the recommended option, and didn't
bother doing any micro-optimizations afterward.

What's the rationale for using timespec for absolute or written-back
timeouts, instead of dealing in ns directly? I'm afraid it's not
obvious to me.

--Zeb



