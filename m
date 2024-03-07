Return-Path: <linux-kernel+bounces-96294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53C8759CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B0C1F22DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3213BAC4;
	Thu,  7 Mar 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IXIoiZAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoR/RmPg"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EC135A5C;
	Thu,  7 Mar 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848641; cv=none; b=QFGAHIz3Z1OzVVN+6agxv2rai50nzYDBgismxyXllbkvmgzwsI7Voeifdx7rF9DgfWDX7Za82uCs1PY8IMOlF7+5F25EKjhJowjRwAuxfKInBs5YhllAoKjEMuMIrRzNQ+FY3hyS6hSneTLUzAbxEL7gTExxe7nGc12+gXzTnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848641; c=relaxed/simple;
	bh=HiQyqI5rhqj3eJbJ9OeeVS0Z5fHH9JryUtUYn6IL4I0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Pf0pTzYB2OWP3tVwLoYHj0/W905FGUbrC/7d1sbLyWwat7DB/V3/AfHQJ0S8+78HaVlgTNwzbJIBtWZssE5RCtUCkKYrirtIfJZCOhg0mPxSKAq4D/Ff59vzbzNgN+oolvpW8W+4oK1U3AZo+wnlLeoSvcMYih0+Cp7fZaPNOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IXIoiZAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoR/RmPg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 84EE91380089;
	Thu,  7 Mar 2024 16:57:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 16:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709848638; x=1709935038; bh=fKOSRnnBdF
	tGTfuNnx0zHhRTbIYCaKgWUvk5mFPlNag=; b=IXIoiZASfg4ILvonS78TTpY3DW
	xs+6+Dvt4YuN7NTQMvgO7K0v2cjg6FvVxMeOYj0GvpeoS9fo8RvVL0Q6UmsjfarY
	/uT1ccQZ+2qGfd7qOcIvnFr+MRvHKHvIP9S/GPDW7sYJjebi/r0wF/n8teeZU1dN
	Z5CI3St5Dy6yEQJPQnDBKmMyW97aLFPU4Ox2iY6joScyMrltuhohGQILQuzqIeg5
	pma967mIltBq5F8dWR2IFAUtLaRyCfGizui9bgwUPN7Cl9Kv/SH829t73dJaropt
	aWKFimvbubKKoT+/PNsHQKWi8dCfcHpMCGM/EH8hrsJlxHcRWKGXc3j/3Emw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709848638; x=1709935038; bh=fKOSRnnBdFtGTfuNnx0zHhRTbIYC
	aKgWUvk5mFPlNag=; b=IoR/RmPgMpfk+DxEz3rub8QhBHlyi6qOlgNda8o1KgP5
	1OCTKXunFhxGvVjUyy2SWG+Rpx6mFjwuvBKLLNrCQt7ZK/jNq/G5i4hFXFB8+hMd
	ObDCAz1Dvml8RCqCQJohdOo7FUYE7W86X2NiUCRlW5z63SoU/FmfmWqpbvAhGh3B
	UVp1mYIaAnqn4uq/eUYMFQQTRmqpZAivd5zcpS7JIB/6+lpenAdnuA4FTV+KfIwE
	ILtw2h/SwDC9Oua8+ZZK6N8U/20paBJr+mhOxiZLXkRzJmNmWzto7n9D+Z1gzLfx
	/iQjEZeGCUlidb5gRlKvYddrhRC9HeaDJZBB9Bjogw==
X-ME-Sender: <xms:PTjqZVGhlAXQVTuB_90xBhXagE-P8qoGKG4_GmK9xUXZ_kYlPaVjyg>
    <xme:PTjqZaWR2SXrNf-KIuv_0XwFdGFeGA9SyPtmjOqWfK-naKLq_Y2JkJ5PyM1uXCmAq
    pH5IAeawzyZ5nrNsAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PTjqZXKZ-ee6QPgP2XJt5HsWhsiczr5ueWR9sHGlUFumrliEVlKRng>
    <xmx:PTjqZbEtHpuRsp4GkE9adwMiUE6D6Nmg0MdR4WlkX9C1hvUs2QJYkg>
    <xmx:PTjqZbU-VgK6pupr5v3wvcg60SQMzPM9AX002vsvanifomlyXhMNHg>
    <xmx:PjjqZUU-sVuQfsXw9XSS5RafDMsJ0qaKl5P0gM8qTolyGpxwG4oe6A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 80BD1B6008F; Thu,  7 Mar 2024 16:57:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <50d4146e-57a2-48a8-809f-713279935f32@app.fastmail.com>
In-Reply-To: <202403071105.C3B038C@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
 <202403071105.C3B038C@keescook>
Date: Thu, 07 Mar 2024 22:56:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <keescook@chromium.org>
Cc: "Jeremy Linton" <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mark Brown" <broonie@kernel.org>,
 "Guo Hui" <guohui@uniontech.com>, Manoj.Iyer@arm.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 "James Yang" <james.yang@arm.com>, "Shiyou Huang" <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Content-Type: text/plain

On Thu, Mar 7, 2024, at 20:10, Kees Cook wrote:
> On Thu, Mar 07, 2024 at 12:10:34PM +0100, Arnd Bergmann wrote:
>> For the strength, we have at least four options:
>> 
>> - strong rng, most expensive
>> - your new prng, less strong but somewhat cheaper and/or more
>>   predictable overhead
>> - cycle counter, cheap but probably even less strong,
>>   needs architecture code.
>
> Are the low bits of a cycler counter really less safe than a
> deterministic pRNG?

I don't know, that was based on Jeremy's assertion. I'm not
even convinced that either one is actually safer than no
randomization. ;-)

For both the timer and the pRNG, I guess you'd need a gadget
to extract the current offset and from there extract the
per-cpu state value. Once you know the state and there is no
reseed, you can pick the value you want for the next syscall
by either calling getpid() repeatedly or waiting for the
cycle counter to reach the desired value before calling
a vulnerable syscall. At that point the pRNG and no
randomization are reliably predictable, while the timer
may still have some jitter left.

>> - no rng, no overhead and no protection.
>
> For the pRNG, why not just add a reseed timer or something that'll
> happen outside the syscall window, if that's the concern about reseeding
> delay? (In which case, why not continue to use the strong rng?)

I fear a timer or workqueue would be both weaker than a forced
reseed if the attacker wins the race against the reseed, and
still cause latency that hurts realtime usecases.

       Arnd

