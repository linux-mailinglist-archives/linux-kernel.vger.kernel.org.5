Return-Path: <linux-kernel+bounces-38993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E6B83C97A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1279429950C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB413BE95;
	Thu, 25 Jan 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KTZN1ugO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t8gaVy5t"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB3130E30;
	Thu, 25 Jan 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202172; cv=none; b=lzyCZQHDME7uCsrri37L2S2qN/0filTdX6Sn5Fbtq1nHUyeaqZNqaRNeR8w3vP7ZgsZokDq08GXrA9svyVoOS367oleG6l54Uw3lGGSVtprNK8U59sUjcyVp1NYuuSCYLyIWlEJs8M/UB55OTX2CTfR6c5vUU2KI6bF3m42ukpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202172; c=relaxed/simple;
	bh=WqahYEHmiuKZoQTeca9wIJ0qlqP8F/wnrf3PfIlb3ug=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZHEi+qakEqMHsbTN+TFfstlwQNlKhB21uGraHvdjtFDvR0Q793o45MaqVm9etaFuJs5OzO1qjOVkSER+V+yFWUQjOgyMliXRKNVLknybMpQihQkv5pmgVZERFILJFdXFWVlD63AFwM+FLDKaGJ4U3lNdPh4A/NKtTFnXx0Kkxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KTZN1ugO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t8gaVy5t; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E23603200AED;
	Thu, 25 Jan 2024 12:02:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 25 Jan 2024 12:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706202168; x=1706288568; bh=BaQC6n5Uf0
	h2jG2xEkFvdsaNKDAE+vFgA3Lv+DwHh0o=; b=KTZN1ugOuk2q1jONQMsU29eGYX
	ayZ+Y9xbEfVTC5srdmO4xX/FU/LJi1IyxvrJBbZgDVMtA9Di1NZemJvlBVKOqIWc
	4BQQCMeqkpYWf/sUtkdW3bpPLS5DRAYM5sV8g43XgQ4D6Bbq56FJctNIDtJusD3K
	1WugZ0ePEl9/SLfyT8ll2qn2Wl0IUixzbk6SPsdiGLsPcKuRPCUvqHGbIe6tPzHR
	UfDFp56zplZy0W4qZIKbwC7mj1t5lrSFWXLemGeo2IGMakKBgc/TvTUNsRDwmdKt
	dwRzJHj0g5/DJYQ7KJuPTPEFmcgBvYuPABpTjFvZYOj71x0Xwi4OCSJC2knA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706202168; x=1706288568; bh=BaQC6n5Uf0h2jG2xEkFvdsaNKDAE
	+vFgA3Lv+DwHh0o=; b=t8gaVy5tjB3mzwKydR4K3cgoWDhXoUkt/XHV2wQI8L+E
	6rEALfT0MXaluMFoFOONEOvsXJ7c2BYvoJ47bi09j4nZyhwWoO9ZVsT4025+/rLG
	hLVa/2+fqGl/lJtEhOvXMcAxLt30cHPmUkOfGGtOgLIuzrtt5YHsl5kNJgGYqZqL
	3OKOX0wq4R+Q71rkg1YKydmNeOmIWRGDABfTv65iF8aeg1WfsyvbOaPdRwsg8ISj
	hoUFmTGaMzRRTqpfgc7lz9FBhp645WmABAEa+X4rplEEOGb74S5ixjAEBUD4khGq
	Saq9C75sSSG1EVa2BADgFI/h4hMmrGVlAWa1LWXHYg==
X-ME-Sender: <xms:N5SyZWhqyNqq2NBhp7BFycUoijapUA4g405F_MZ3U5GXctfHjIanWg>
    <xme:N5SyZXDaxMapVE9PYd3N5qlawr6fYp0eBmjwZ1berw7ukS3UQsic8pFLnSEjmgQgO
    w83toIEdZfBYLhW4Hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:N5SyZeH5sfRVU2WzeLl_87QpDc7c-ZREuOwcg1MFR8Wztip1Gjdz8w>
    <xmx:N5SyZfT2ltRuKgtSh05dp1_QQMwHAat1r9KBoUB-dI1iaXCX4U-IxQ>
    <xmx:N5SyZTwiWqNTrBYKdNsjRtJVv4I36aM6KndYpU-AmkR9i1M_9GjUHg>
    <xmx:OJSyZak5RQBQ3QcZdI9QvXqh74t005QM-g6t68kNrgZDem1nVIGcbg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AA9FEB6008D; Thu, 25 Jan 2024 12:02:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8631ec7-046e-4ef7-a1ff-71e4ecebe706@app.fastmail.com>
In-Reply-To: <8367053.NyiUUSuA9g@camazotz>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <4864383.GXAFRqVoOG@camazotz>
 <3ec03a12-ee1b-45f8-9f03-258606763d1e@app.fastmail.com>
 <8367053.NyiUUSuA9g@camazotz>
Date: Thu, 25 Jan 2024 18:02:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/9] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Content-Type: text/plain

On Wed, Jan 24, 2024, at 23:28, Elizabeth Figura wrote:
> On Wednesday, 24 January 2024 13:52:52 CST Arnd Bergmann wrote:
>> On Wed, Jan 24, 2024, at 19:02, Elizabeth Figura wrote:

>> > That'd be nicer in general. I think there was some documentation that advised
>> > using timespec64 for new ioctl interfaces but it may have been outdated or
>> > misread.
>> 
>> It's probably something I wrote. It depends a bit on
>> whether you have an absolute or relative timeout. If
>> the timeout is relative to the current time as I understand
>> it is here, a 64-bit number seems more logical to me.
>> 
>> For absolute times, I would usually use a __kernel_timespec,
>> especially if it's CLOCK_REALTIME. In this case you would
>> also need to specify the time domain.
>
> Currently the interface does pass it as an absolute time, with the
> domain implicitly being MONOTONIC. This particular choice comes from
> process/botching-up-ioctls.rst, which is admittedly focused around GPU
> ioctls, but the rationale of having easily restartable ioctls applies
> here too.

Ok, I was thinking of Documentation/driver-api/ioctl.rst, which
has similar recommendations.

> (E.g. Wine does play games with signals, so we do want to be able to
> interrupt arbitrary waits with EINTR. The "usual" fast path for ntsync
> waits won't hit that, but we want to have it work.)
>
> On the other hand, if we can pass the timeout as relative, and write it
> back on exit like ppoll() does [assuming that's not proscribed], that
> would presumably be slightly better for performance.

I've seen arguments go either way between absolute and relative
times, just pick whatever works best for you here.

> When writing the patch I just picked the recommended option, and didn't
> bother doing any micro-optimizations afterward.
>
> What's the rationale for using timespec for absolute or written-back
> timeouts, instead of dealing in ns directly? I'm afraid it's not
> obvious to me.

There is no hard rule either way, I mainly didn't like the
indirect pointer to the timespec that you have here. For
traditional unix-style interfaces, a timespec with CLOCK_REALTIME
times usually makes sense since that is what user space is
already using elsewhere, but you probably don't need to
worry about that. In theory, the single u64 CLOCK_REALTIME
nanoseconds have the problem of no longer working after year
2262, but with CLOCK_MONOTONIC that is not a concern anyway.

Between embedding a __u64 nanosecond value and embedding
a __kernel_timespec, I would pick whichever avoids converting
a __u64 back into a timespec, as that is an expensive
operation at least on 32-bit code.

       Arnd

