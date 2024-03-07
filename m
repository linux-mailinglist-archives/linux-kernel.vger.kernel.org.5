Return-Path: <linux-kernel+bounces-95389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF2874D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE21C2209D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A112B149;
	Thu,  7 Mar 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OSFmEkZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qshz4UXt"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093F12839B;
	Thu,  7 Mar 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809861; cv=none; b=MqfoPZEAALml+dG26jIsn1LaewMBKq+Toi8+zlhMBTW+Kv1OtpyFE3lIvKQs1tXQ91jF5fi5qtjzpqCZsRjGu8/2EoS5Q+NzfUa1QuYG7+yD0QnUNBrTfAFcMr67ITgXMW14CQWKZNJg5ssIMtz5CPq/wnD8UfHxf6hj/zcUIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809861; c=relaxed/simple;
	bh=MoREPiTv1yKmu90Q/9l2I/LfYL/ZqPWpLVhh62qRurU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mQlG1rD2y59RJEgWDjIYDd8CkWUdkxt26V1ME70cvGEWgUwfkFP7azBfgtEavTQTyFpSHLqyWYsmew16DL7vzU6MmlhBcMBrCFGjHFvHY49iWpvdWOa5WQhtldUMgH3S9otuZEFieU7kCCYvh/V8GlT7ZmBPbuXwcpkJH+g2cMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OSFmEkZC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qshz4UXt; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 24A451C0005B;
	Thu,  7 Mar 2024 06:10:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 06:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709809856; x=1709896256; bh=AtFaL5EGzw
	xRRbAOMHdeBVoU44eLeNyTo8XPDMkPqiY=; b=OSFmEkZCJGBrbqz9g7e/8w0teR
	WUo9kKzYjoJcjENBEYmlZQeaK0jgDetatmG9hNKwGA9qnPnHZHZDXEsmNN+QkrC2
	196R/0u28NUhfZsyMfIg2JYb/s3iyAxEKSlcz9Yjmx6YHZg94MyiNfsn8i0zfQIb
	F8/MAz5MtvAW7YNNH7vBzrTlGFhZIxu+xOZes60pE+9e5SfZzOOJHwiWJKAL34iS
	VbVXVLUtOCLrQW4b9AOkqgj2KMKecdtTiIj6dQxvo36y4fAXj3MNmNyUtT2NEA1i
	XEnSCHmBarAS/cwh/V+/FMLCDBU0/0ZrgAWX9NIl8akvZaaUULbgc1ci7kyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709809856; x=1709896256; bh=AtFaL5EGzwxRRbAOMHdeBVoU44eL
	eNyTo8XPDMkPqiY=; b=Qshz4UXtsyv+fARPcD2AY8botM+ZWZ7PLLmEbnJ9FVO9
	zXFSu3Rdj8hP8AGJA002XJNMaof07GnXoJfmFZMWnCKpllzf5a0nc6DUulLomLIw
	pZdkBE2n83iX61owqb4NdXmWtfIWwHOjR4LnLbtCkx3YYBSkoKW4oh6zCiFrm77T
	NiGwBIJeaQYqQ3vk2kOzFr+AgammZ7xGyIEzdaOEAexEPQ68otmthKCxFJH7qdiO
	KObgA+t9WCYvsOYxfAkn2z4/wGcjOtdpYVJl27OUCuxBZoyaHwRlX116uTryO2AD
	k0kzTfWkPTX6PrBNFZcSoQRmCXw8LwOF3zUBFRy5vg==
X-ME-Sender: <xms:v6DpZWxZn2gmfg3zfwbwBetZrfg2q-s45SteM7B6_KV0_p9QeYfk6w>
    <xme:v6DpZSQ3thUXdU6UXkQ2MVGo4G_POWI1FzDdH9aYaIw6F2y0eXJKNBNqvgpsXPceF
    Md8f9p-omy0orGw0Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:wKDpZYUqsPi8GYTBhsWQGUJF3xhXOIbHba0Yk2U_qVYgQU95NSOznw>
    <xmx:wKDpZcgEtfYJ-omZO4hDdlIv7OUXgcMbdNpMldWJVhD3TsOlzf8RdQ>
    <xmx:wKDpZYB9AsLe0UdXoghnkKgj90L953t-KvsbF45LWpEx56cTO99anw>
    <xmx:wKDpZWTKTTOoYeaASoQMqYL2lAbT2LToqOmJeySJ0hxAjCBCTQE3hiOxTUM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D9D49B6008D; Thu,  7 Mar 2024 06:10:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
In-Reply-To: <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
Date: Thu, 07 Mar 2024 12:10:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeremy Linton" <jeremy.linton@arm.com>,
 "Kees Cook" <keescook@chromium.org>
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

On Wed, Mar 6, 2024, at 22:54, Jeremy Linton wrote:
> On 3/6/24 14:46, Arnd Bergmann wrote:
>> On Wed, Mar 6, 2024, at 00:33, Kees Cook wrote:
>>> On Tue, Mar 05, 2024 at 04:18:24PM -0600, Jeremy Linton wrote:
>>>> The existing arm64 stack randomization uses the kernel rng to acquire
>>>> 5 bits of address space randomization. This is problematic because it
>>>> creates non determinism in the syscall path when the rng needs to be
>>>> generated or reseeded. This shows up as large tail latencies in some
>>>> benchmarks and directly affects the minimum RT latencies as seen by
>>>> cyclictest.
>>>>
>>>> Other architectures are using timers/cycle counters for this function,
>>>> which is sketchy from a randomization perspective because it should be
>>>> possible to estimate this value from knowledge of the syscall return
>>>> time, and from reading the current value of the timer/counters.
>> 
>> As I commented on the previous version, I don't want to see
>> a change that only addresses one architecture like this. If you
>> are convinced that using a cycle counter is a mistake, then we
>> should do the same thing on the other architectures as well
>> that currently use a cycle counter.
>
> I personally tend to agree as long as we aren't creating a similar set 
> of problems for those architectures as we are seeing on arm. Currently 
> the kstack rng on/off choice is basically zero overhead for them.

I think we have two separate problems to solve here: how
strong a kernel stack randomization should be on a given system,
and who gets to make the decision.

For the strength, we have at least four options:

- strong rng, most expensive
- your new prng, less strong but somewhat cheaper and/or more
  predictable overhead
- cycle counter, cheap but probably even less strong,
  needs architecture code.
- no rng, no overhead and no protection.

On architectures that have a cheap hardware rng instruction, you
can count that one as well.

For picking between the options, we have

- architecture maintainer
- defconfig (CONFIG_RANDOMIZE_KSTACK_OFFSET)
- boot time (randomize_kstack_offset=on)

For both of these lists, I would like to see as few options
as possible, and in particular I think the architecture
maintainer should not make that decision for the users.

If we want to improve this, I would start by changing
the binary CONFIG_RANDOMIZE_KSTACK_OFFSET option into
a three-way choice between cycle counter (where available),
strong rng and off, possibly adding the cycle counter
option to the two architectures that currently don't use
it, while moving the strong rng into common code.

After that, we can debate adding a fourth option, or
replacing one of the existing two that is too slow or
not random enough.

>> Won't that defeat the purpose of the patch that was intended
>> to make the syscall latency more predictable? At least the
>> simpler approaches of reseeding from the kstack_rng()
>> function itself would have this problem, deferring it to
>> another context comes with a separate set of problems.
>
> And that describes why I've not come up with an inline reseeding 
> solution. Which of course isn't a problem on !arm if one just pushes a 
> few bits of a cycle counter into the rnd_state every few dozen syscalls, 
> or whatever. Mark R, mentioned offline the idea of just picking a few 
> bits off CNTVCT as a seed, but its so slow it basically has to be used 
> to fuzz a bit or two of rnd_state on some fairly long interval. Long 
> enough that if someone has a solution for extracting rnd_state it might 
> not add any additional security. Or that is my take, since i'm not a big 
> fan of any independent counter/clock based RNG seeding (AFAIK, entropy 
> from clocks requires multiple _independent_ sources).

I'm not sure I understand the logic. Do you mean that accessing
CNTVCT itself is slow, or that reseeding based on CNTVCT is slow
because of the overhead of reseeding?

On powerpc/s390/x86, the low bits of the respective cycle counter
is simply used without any kind of bit shuffling, and we already
rely on the cycle counter to be fast to access since it's used
for timekeeping anywhere.

There is not even any attempt to use the most random bits of
the cycle counter, as both the high 22 to 24 bits get masked
out (to keep the wasted stack space small) and the low 3 or 4
bits get ignored because of stack alignment. If there was
any desire to make it more random, a trivial improvement
would be:

+++ b/include/linux/randomize_kstack.h
@@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
        if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
                                &randomize_kstack_offset)) {            \
                u32 offset = raw_cpu_read(kstack_offset);               \
-               offset ^= (rand);                                       \
+               offset = ror32(offset, 5) & (rand);                     \
                raw_cpu_write(kstack_offset, offset);                   \
        }                                                               \
 } while (0)

My impression is that is is already bordering on becoming
a "bespoke rng" implementation that Jason was objecting to,
so the current version is intentionally left weak in order
to not even give the appearance of being a security relevant
feature.

> This is a bit out of my wheelhouse, so I defer to anyone with a better 
> feel or some actual data.
>
> The best plan I have at the moment is just some deferred work to call 
> kstack_rng_setup on some call or time based interval, which AFAIK isn't 
> ideal for RT workloads which expect ~100% CPU isolation. Plus, that 
> solution assumes we have some handle on how fast an attacker can extract 
> kstackrng sufficiently to make predictions.

I think you fundamentally can't have both. If you rely on the
reseeding to happen for a particular number of syscalls, you
eventually end up blocking on it, regardless of the context
it runs in. Deferring it to another process means blocking
for longer, and deferring it to a low-priority task would mean
that real-time tasks get less randomness.

       Arnd

