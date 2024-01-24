Return-Path: <linux-kernel+bounces-37614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F383B294
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E724328292C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29C133412;
	Wed, 24 Jan 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="A+/A63xh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lT+iXOVz"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBA131749;
	Wed, 24 Jan 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125997; cv=none; b=AFK+83K1CRKJ8dl/x8QwODOWfn0CfIi/MQE8E0iLxqsxJonTrdBo5UcA6TfC2sPjwGni+41mbG6E3GRAuZXst5RPJgVgZCKba4WzmE6LZzvSzrQ6ynqeSPZX4KAMestyn3csT+aPJ1HJOKwfxkTU5LL91THqB29GWL912wcKC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125997; c=relaxed/simple;
	bh=SwgTspLxFGhapYw4Ru7+OVzFFI0NckTW4NA+OsvMalo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mpjny2uK2xOARJnKsIEir2R0vnuZ7ZHU5oSCnpcGzK8ah5j62b+HmSXhPsbu4f1c39HfabqCXSkXbMY4tE/Ec1nLcCeIrUV90ads08arEuw+Zuyb2fM88xGWi646ssW++zrIytGBNrSKluyJ82qyJkf36Cw2sh5nO1BJaWvLok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=A+/A63xh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lT+iXOVz; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 221733200AD5;
	Wed, 24 Jan 2024 14:53:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 14:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706125993; x=1706212393; bh=sDekHfYu/b
	reQaJXZDRG+5CmXfkqyiEh3Ug/BHq3NCk=; b=A+/A63xhJvI6FAhB7d21eQqM+8
	4ROkoAjIrPZecxvmfBU0MJwTTpkdq0v4aN4S98wIC1HXTsaLrlEqj/Zf/7p8nsKR
	yqbVDC1ikBx/RdDXlxyCQP5AD+7dcRRdoMn6Pe+gZLG+2rGne4dgofSjxE9wFFfD
	cg/77IYHLEULfVqSdM9gFvRDmqoyt5vc1+Us37AW81hE/em87PCqEQRVVOZYMGp5
	uC7D5skD0Y+w1xqT/kF7ErVyMV3HOIIn4aYY1yg5XcYroQeaZaitELDKyzd8xaYK
	OyzyD3oMHeJ6yjLxXaf5Mb1Z3Cs9Oaw+B0aaANp2bT+tD7FeH3o+BleFNFLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706125993; x=1706212393; bh=sDekHfYu/breQaJXZDRG+5CmXfkq
	yiEh3Ug/BHq3NCk=; b=lT+iXOVzpz5ed7FAG5VvhFfsRT83wNtnNPI8oaMVsswF
	+cRFVm7mci9ShMErww4nN6bNxJarfTlXVW9AbBbT2SuxD1qCFU4TNEgwdn4Ym+9P
	YL6Sc/QfLKfrxcPL9i9Z2iPZvxPZ7V+DqssiqNJ7cbrcvq+/WSL1HX/UxKXRu9uo
	l4nufx5n86Kp9Ici2xYXq8n3KFNYTr4tojw9vQ2zfbeELQib6YouEgtH7Jgduq3o
	HWOX2S2YQ1OhTTmFS0cMCtH+fOfdDqDku8IIMdGIM/q3XbTvgbq1pdlbkczhOQdb
	VfhPidkByjAgAWoIRKc4cNRLjA1A0MzKjS1l/pSSHQ==
X-ME-Sender: <xms:qWqxZbmGqv2kbzjy1E6tOr7ZNBmnSmEDHls-Ch7R81SlowSoc6WjUg>
    <xme:qWqxZe2uJx94oZk6SoHOZjdCiVcKIC80dg4J7oeVctk2_8vOYIrd2EqhoTM2joGkV
    EY3Az7hC4zxitrU_p8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qWqxZRrB6qraNON4Ij3jtCBB16Q-I-xblqBwZhqrkoUPq609IH_htg>
    <xmx:qWqxZTkATYRF39lVAtHehvB7BeExjy77z52gNhvOZ5tq6Tb3EEQPSg>
    <xmx:qWqxZZ0SzGENy1GGBUAVB_nv8wlSST2uLQ_wsK3-0ySUVOWMzLThVw>
    <xmx:qWqxZToMm9SBs95FdGS1XhmnuE5p-We-wQLVykLbeuUHJx1t8dJXNA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 142D2B6008D; Wed, 24 Jan 2024 14:53:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ec03a12-ee1b-45f8-9f03-258606763d1e@app.fastmail.com>
In-Reply-To: <4864383.GXAFRqVoOG@camazotz>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-6-zfigura@codeweavers.com>
 <18c814fa-b458-48f9-b7e8-88b23a1825e2@app.fastmail.com>
 <4864383.GXAFRqVoOG@camazotz>
Date: Wed, 24 Jan 2024 20:52:52 +0100
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

On Wed, Jan 24, 2024, at 19:02, Elizabeth Figura wrote:
> On Wednesday, 24 January 2024 01:56:52 CST Arnd Bergmann wrote:
>> On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
>> 
>> > +	if (args->timeout) {
>> > +		struct timespec64 to;
>> > +
>> > +		if (get_timespec64(&to, u64_to_user_ptr(args->timeout)))
>> > +			return -EFAULT;
>> > +		if (!timespec64_valid(&to))
>> > +			return -EINVAL;
>> > +
>> > +		timeout = timespec64_to_ns(&to);
>> > +	}
>> 
>> Have you considered just passing the nanosecond value here?
>> Since you do not appear to write it back, that would avoid
>> the complexities of dealing with timespec layout differences
>> and indirection.
>
> That'd be nicer in general. I think there was some documentation that advised
> using timespec64 for new ioctl interfaces but it may have been outdated or
> misread.

It's probably something I wrote. It depends a bit on
whether you have an absolute or relative timeout. If
the timeout is relative to the current time as I understand
it is here, a 64-bit number seems more logical to me.

For absolute times, I would usually use a __kernel_timespec,
especially if it's CLOCK_REALTIME. In this case you would
also need to specify the time domain.

      Arnd

