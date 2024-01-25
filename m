Return-Path: <linux-kernel+bounces-39125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F683CB26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8491C2397F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8E134752;
	Thu, 25 Jan 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="K/rCKinA"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455713A27E;
	Thu, 25 Jan 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207431; cv=none; b=rzGeb5uGgJi7RUMO5CctGjbgt86pF0mTTM2Y7WVDZps9DWhoIfd6PXFlGCY9ET4KJgU0lj6U7YlX/6R4bv1SMzNMJ8XeYJ6hvKEoVeGQmU0erk3AFSNCJdBPIvcfR2nqQJcFbBSH6eEIZZ4sdbXDYs3NvQtdvot90vo1HHajTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207431; c=relaxed/simple;
	bh=xk5lgA+5ToNq/ucX/ooVAgYX4UIxxD91B19XXJ0l73o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocoHFO7Z0FF0oturx9QuAxfT1O5DdtJPTnNgS+k0xIhLhLycWpRDUYmbtGza9YEkbJFlO/LapmTjcE0LzAnEzv7Gb5mCHjQQacUf7sm1jREk0Q7tuLP3xZrbcy/Tpid/3CgVbbmyuZzqj3C33+zO90gdZ3awxGvcup8ztDwC7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=K/rCKinA; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=bxiUtU1DguFrA2jGmlDssND5B5NsHZATR5idxx5jFPg=; b=K/rCKinAZydckMAOwVXcCBPv8Z
	PlJfQFub472zGKkNzCDJk0OrDR/xS+bCXCGutsb7ybLKBioy4fDkI+MHP0YJ5omijNA6NaF0tC2zy
	UQ5FB93cWItK8/Vzq0WjHw7aAhLsIRvc8s5DBdvYgncHWiooYjkeex1sehuL4nWKS1vtlKaYL9MNb
	btKnrCfZKGI7eDNHrGnb45fm7enyiuE3lKwYLIirgEbMh7Od/wkzf/OB/99TSLx18w77sHUQdIqhu
	kcVOYs7xv2Vw+NswGs231hn1RYnuGgbse1VoUQHneyy4fw/38EdTd4S9INWP060CWjryhmI9/DyHT
	jJjiPNtQ==;
Received: from [10.69.139.15] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rT4Ue-00FQm3-1U;
	Thu, 25 Jan 2024 12:30:28 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/9] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Thu, 25 Jan 2024 12:30:28 -0600
Message-ID: <9225327.CDJkKcVGEf@terabithia>
In-Reply-To: <d8631ec7-046e-4ef7-a1ff-71e4ecebe706@app.fastmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <8367053.NyiUUSuA9g@camazotz>
 <d8631ec7-046e-4ef7-a1ff-71e4ecebe706@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 25 January 2024 11:02:26 CST Arnd Bergmann wrote:
> On Wed, Jan 24, 2024, at 23:28, Elizabeth Figura wrote:
> > On Wednesday, 24 January 2024 13:52:52 CST Arnd Bergmann wrote:
> >> On Wed, Jan 24, 2024, at 19:02, Elizabeth Figura wrote:
> >> > That'd be nicer in general. I think there was some documentation that
> >> > advised using timespec64 for new ioctl interfaces but it may have been
> >> > outdated or misread.
> >> 
> >> It's probably something I wrote. It depends a bit on
> >> whether you have an absolute or relative timeout. If
> >> the timeout is relative to the current time as I understand
> >> it is here, a 64-bit number seems more logical to me.
> >> 
> >> For absolute times, I would usually use a __kernel_timespec,
> >> especially if it's CLOCK_REALTIME. In this case you would
> >> also need to specify the time domain.
> > 
> > Currently the interface does pass it as an absolute time, with the
> > domain implicitly being MONOTONIC. This particular choice comes from
> > process/botching-up-ioctls.rst, which is admittedly focused around GPU
> > ioctls, but the rationale of having easily restartable ioctls applies
> > here too.
> 
> Ok, I was thinking of Documentation/driver-api/ioctl.rst, which
> has similar recommendations.
> 
> > (E.g. Wine does play games with signals, so we do want to be able to
> > interrupt arbitrary waits with EINTR. The "usual" fast path for ntsync
> > waits won't hit that, but we want to have it work.)
> > 
> > On the other hand, if we can pass the timeout as relative, and write it
> > back on exit like ppoll() does [assuming that's not proscribed], that
> > would presumably be slightly better for performance.
> 
> I've seen arguments go either way between absolute and relative
> times, just pick whatever works best for you here.
> 
> > When writing the patch I just picked the recommended option, and didn't
> > bother doing any micro-optimizations afterward.
> > 
> > What's the rationale for using timespec for absolute or written-back
> > timeouts, instead of dealing in ns directly? I'm afraid it's not
> > obvious to me.
> 
> There is no hard rule either way, I mainly didn't like the
> indirect pointer to the timespec that you have here. For
> traditional unix-style interfaces, a timespec with CLOCK_REALTIME
> times usually makes sense since that is what user space is
> already using elsewhere, but you probably don't need to
> worry about that. In theory, the single u64 CLOCK_REALTIME
> nanoseconds have the problem of no longer working after year
> 2262, but with CLOCK_MONOTONIC that is not a concern anyway.
> 
> Between embedding a __u64 nanosecond value and embedding
> a __kernel_timespec, I would pick whichever avoids converting
> a __u64 back into a timespec, as that is an expensive
> operation at least on 32-bit code.

Makes sense. I'll probably switch to using a relative and written-back u64 
then, thanks!



