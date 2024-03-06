Return-Path: <linux-kernel+bounces-94568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729FD874186
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80751B222B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544A14F70;
	Wed,  6 Mar 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ThrrGvtN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HY8535K7"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051217543;
	Wed,  6 Mar 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757989; cv=none; b=BAVkMdwaAL9JZD08VbTNl6SSP4hmvhjU30QcamlTEJGe4Az91ybHlal/1PDD920wZ5ph2la0l8ZctHMmqGlDkaI1Dk4GIUVjuM+OjEkNOCerV1LUg6jo5ggEdtt/n/tBK65uuJZ+8TvVQtvgQgvjxTZiL70P2qt+w47BEVaUhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757989; c=relaxed/simple;
	bh=/B2yALI7zqPJev0Pw2q0EWWFl+jOU8z8GxveIztIOyo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ibfiatv9vGWdVe3PqxWOa1IKQ5iQk84SohzqlZIfVdIZ9CGy842pAe41aZYgEnrAeUJ5RlOuUJDM1yPd7FYcvIt3icrhQCHOXfGnz9xWq8e1dCyCW3xM4WbFqWfamoaNFpAPzHal7LYkhh2ty8s5DFd+/e8oLAs4jEsq7+Nil70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ThrrGvtN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HY8535K7; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5A217180009F;
	Wed,  6 Mar 2024 15:46:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 15:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709757983; x=1709844383; bh=ihK6fPeDn0
	5KjNcIADQQobaXIIWxpdLvsjBzEjv3acM=; b=ThrrGvtNCCG96IJhoeJNQBiHsP
	P/lMoD0XQvUfD95jI6yecAFpiheXOq1GAoLACpDH+FyKCn9Bfg0C1y7hccuairPa
	nIl3B+/td/UVZzQ/l+mnZcoa05tiBFu2yflEbi7/T3Y1FHFZb12pmzmi1m5ULO0D
	pwYJ3ecD3SKeoNAClTU39j4x5EinNfsuqcn+07KSjGZZ4IpdkoNaitso3HD7z+Q4
	mJVRLd7dCCPYSE43q9daqzlLfvJCxs2+57Wfj1XAHjF5IpVQVvHk6BLdlvjSV1Kk
	CbXrKTjbTyaqtMW6wra8hMEuP+HLtWZF2waAuhIpPoV1shpX9ozXDcvCoJ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709757983; x=1709844383; bh=ihK6fPeDn05KjNcIADQQobaXIIWx
	pdLvsjBzEjv3acM=; b=HY8535K7ekn0RtqgbE/P2CSWkNMEKIqAa9i1a/Y+rGiJ
	gs8q90dcR7XUIBACGNiEF64DTymhynUAck5ENwpbKxctgW3sOEyW350G4wtxjR94
	XZhzq6C7DKswvtSoQwbDp526wcBEhfv3/wm5bgbeaMbAmpRct4tz01JLtsoqApGR
	rFpsNzMnf3bngSy7HFoX0/tZl2bgx+HeISWgVzS0pXZg+JeSsixzvLwS/A1kHiA3
	Fc1AYajPnJtpKjqWHBCecDE7ANhGw8xW3Gc9SNwslsVrZmLEH9ZTbRICuAnX7toi
	LFaXDVnJRceX06+ti9wkOdheQVCOfBkmIIKf0HtW6Q==
X-ME-Sender: <xms:H9boZbfVqx5-obISdN3n1nxgPjoD0OMMPGIbC9DNFNeLlKLMhnZMPQ>
    <xme:H9boZROF1m8luAZgoAmHmfz0Z1MBkqJU-XAyZn1lQ_XAwpvuSGvufT_s3AZKAfbOW
    AvxRnd32uahBK1ZiJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:H9boZUgTynjP1axclVfT_fLzq_SRjxgacNI56rJ253kHASzz-8EWmw>
    <xmx:H9boZc9RoHZ7EC3u1PAK1gYPdMetk8PDKIKE6FhIE8rMVo4n7TED3A>
    <xmx:H9boZXuT2rR5utO5f0EW3t6QgeX92XQch2IlRTW3fibOpD2xtuZRgA>
    <xmx:H9boZfMYT8Sh25jeRFwocoiXpmD6pfFmV_WHnQogy00K0C2Y_fUffs5ZV4o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22BBBB6008D; Wed,  6 Mar 2024 15:46:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
In-Reply-To: <202403051526.0BE26F99E@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
Date: Wed, 06 Mar 2024 21:46:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <keescook@chromium.org>,
 "Jeremy Linton" <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
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

On Wed, Mar 6, 2024, at 00:33, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 04:18:24PM -0600, Jeremy Linton wrote:
>> The existing arm64 stack randomization uses the kernel rng to acquire
>> 5 bits of address space randomization. This is problematic because it
>> creates non determinism in the syscall path when the rng needs to be
>> generated or reseeded. This shows up as large tail latencies in some
>> benchmarks and directly affects the minimum RT latencies as seen by
>> cyclictest.
>> 
>> Other architectures are using timers/cycle counters for this function,
>> which is sketchy from a randomization perspective because it should be
>> possible to estimate this value from knowledge of the syscall return
>> time, and from reading the current value of the timer/counters.

As I commented on the previous version, I don't want to see
a change that only addresses one architecture like this. If you
are convinced that using a cycle counter is a mistake, then we
should do the same thing on the other architectures as well
that currently use a cycle counter.

>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>> +DEFINE_PER_CPU(struct rnd_state, kstackrng);
>> +
>> +static u16 kstack_rng(void)
>> +{
>> +	u32 rng = prandom_u32_state(this_cpu_ptr(&kstackrng));
>> +
>> +	return rng & 0x1ff;
>> +}
>> +
>> +/* Should we reseed? */
>> +static int kstack_rng_setup(unsigned int cpu)
>> +{
>> +	u32 rng_seed;
>> +
>> +	/* zero should be avoided as a seed */
>> +	do {
>> +		rng_seed = get_random_u32();
>> +	} while (!rng_seed);
>> +	prandom_seed_state(this_cpu_ptr(&kstackrng), rng_seed);
>> +	return 0;
>> +}
>> +
>> +static int kstack_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:kstackrandomize",
>> +				kstack_rng_setup, NULL);
>
> This will run initial seeding, but don't we need to reseed this with
> some kind of frequency?

Won't that defeat the purpose of the patch that was intended
to make the syscall latency more predictable? At least the
simpler approaches of reseeding from the kstack_rng()
function itself would have this problem, deferring it to
another context comes with a separate set of problems.

      Arnd

