Return-Path: <linux-kernel+bounces-74438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBE85D439
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4971C22E27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E893D55E;
	Wed, 21 Feb 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2gNEAT4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+jJlUhw"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867533B781;
	Wed, 21 Feb 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508919; cv=none; b=sh8caVVozQPmhJM+J9WPNtQZWGoho5ulofqYOxSKpaoPeKNsDqJ6RDYkuIl/eTq8pXRH9gyaycRBfWKkUIQETTG9FWAY60iAeISjaxILbk8Nt+CZo0MAuVbX3mDrfVONM7+xsrYzepqHg0K3iTO7u4PUoMMQJ30MsCuQuDqOK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508919; c=relaxed/simple;
	bh=HLE/MP1SWWxlDamRNgvoEaBeblwna1EiTKCiw4WhSCk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qlQVm70MABritlQ+1hPoW+/GoZ4whfytwiisEdxksZp9vVn4rH/PmraoFfa01biAJpfPjE1CZdWG/KrYqJvKpo635wEF01hgIpxe6PeBccXcaiuitTh8HTs+3w/gvMzRpTif4YLf3tWFx1xw0PQFfI8PM8078SfVfuZrCkKHu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2gNEAT4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+jJlUhw; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2719432001AB;
	Wed, 21 Feb 2024 04:48:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 04:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708508914; x=1708595314; bh=Fw9lSJoYft
	ih2HH5DSoXI7rUStJLYAI4RgfN/FK3Rx8=; b=2gNEAT4pin6JGIAnt8bwDF8i/y
	dxEN6bb4iHtQoqbP3lVzUxytZUW00tT3+JjWU4qg5fqI1guNgjRy68mUGWNgV+C1
	1xsIejWLV5OQjEbNMzcU9ggp2RXzud15v35SiCS5UfBcpIi54yCe5dWmJzkIL9rL
	a85RIpRD6ZPv8sumhAKtm/SjOdRGS9qDJHCplrWv0KxQtQxIHRBgoh8JkG3gGMlF
	l3rZp8xOBpMN514u8tm8+XqwkMeHYVD6/TiJ1fIT+4bMBiVJBFg4ubv0kBt9unFi
	zyiKRdecuT7mGCXTG+ndxo47a1cBssKpv2IL+4/fXQ3YbJUnlv4N3DXldFPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708508914; x=1708595314; bh=Fw9lSJoYftih2HH5DSoXI7rUStJL
	YAI4RgfN/FK3Rx8=; b=Y+jJlUhwn2Xxw5axMqBCkm6M4C2Y/yBLWAoNSy1RShLI
	rH+TmCdFjkJZdQGKN3t5GMVXjg2YsNhOTxq/QE5OClC0Q78aNRlYT9fitKY4qjNh
	7HdM9Zsn5R8FHlfPhM51nE3duHAaqeQFDsewCNZKoTC0jIqwE2OMZkzuso39OsBc
	HX7mT5kCvkWZWLq2vqUV6m7nhKZ5rNn/vDmB4snjDXQTD2/m1kvDgPB9cLTx86YH
	zMWH0YCJjC1c+Nmmcu67f7jfPAPR8fIakBOo40agc+LrYMynVH4lTuFuW3ZVIHJU
	8db1OhMLygnZ7OzdKAjFPmg24CGKNskQTeZiovWsPA==
X-ME-Sender: <xms:8sbVZSMzblp1OEWPd-v2NpPQ3PjdRcaZ6kawcqduEoE1wmkFiC4rAg>
    <xme:8sbVZQ9UF0lyRCoMoN3qphU4tyTxrkMnMY7wvbGVpIoA-Ee1QyvgddQzqg-oMyFzw
    0h-WoRsXuxA8HCcZ2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8sbVZZScqItcSO1tcHZc2YIG43a4PawB7RjYMfePrVwiKUDm_Nj1-g>
    <xmx:8sbVZSsPy-iXcZYKkJBjOqyfVl3mn41HoUdesiYlscHAb7rsu3HDEA>
    <xmx:8sbVZafb_Q_hf0W56ovGZceEXz-ISsc8LWRtIJHrP-TyyjQa6KVYpA>
    <xmx:8sbVZR-j0XCHrDFtXulF0JMNDiCyjeGvkH7SCCCy8xLd2UCKXEMO2Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 29F20B6008D; Wed, 21 Feb 2024 04:48:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <938f3418-fd88-476d-b67f-3f7ada98e444@app.fastmail.com>
In-Reply-To: <20240221020258.1210148-1-jeremy.linton@arm.com>
References: <20240221020258.1210148-1-jeremy.linton@arm.com>
Date: Wed, 21 Feb 2024 10:48:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeremy Linton" <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Kees Cook" <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mark Brown" <broonie@kernel.org>,
 "Guo Hui" <guohui@uniontech.com>, Manoj.Iyer@arm.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 "James Yang" <james.yang@arm.com>, "Shiyou Huang" <shiyou.huang@arm.com>
Subject: Re: [RFC] arm64: syscall: Direct PRNG kstack randomization
Content-Type: text/plain

On Wed, Feb 21, 2024, at 03:02, Jeremy Linton wrote:
> The existing arm64 stack randomization uses the kernel rng to acquire
> 5 bits of address space randomization. This is problematic because it
> creates non determinism in the syscall path when the rng needs to be
> generated or reseeded. This shows up as large tail latencies in some
> benchmarks and directly affects the minimum RT latencies as seen by
> cyclictest.

Hi Jeremy,

I think from your description it's clear that reseeding the
rng is a problem for predictable RT latencies, but at the same
time we have too many things going on to fix this by
special-casing kstack randomization on one architecture:

- if reseeding latency is a problem, can we be sure that
  none of the other ~500 files containing a call to
  get_random_{bytes,long,u8,u16,u32,u64} are in an equally
  critical path for RT? Maybe those are just harder to hit?

- CONFIG_RANDOMIZE_KSTACK_OFFSET can already be disabled
  at compile or at at boot time to avoid the overhead entirely,
  which may be the right thing to do for users that care more
  deeply about syscall latencies than the fairly weak stack
  randomization. Most architectures don't implement it at all.

- It looks like the unpredictable latency from reseeding
  started with f5b98461cb81 ("random: use chacha20 for
  get_random_int/long"), which was intended to make
  get_random() faster and better, but it could be seen
  as  regression for real-time latency guarantees. If this
  turns out to be a general problem for RT workloads,
  the answer might be to bring back an option to make
  get_random() have predictable overhead everywhere
  rather than special-casing the stack randomization.

> Other architectures are using timers/cycle counters for this function,
> which is sketchy from a randomization perspective because it should be
> possible to estimate this value from knowledge of the syscall return
> time, and from reading the current value of the timer/counters.
>
> So, a poor rng should be better than the cycle counter if it is hard
> to extract the stack offsets sufficiently to be able to detect the
> PRNG's period.

I'm not convinced by the argument that the implementation you
have here is less predictable than the cycle counter, but I
have not done any particular research here and would rely on
others to take a closer look. The 32 bit global state variable
does appear weak, and I know that 

OTOH if we can show that a particular implementation is in fact
better than a cycle counter, I strongly think we should
use the same one across all architectures that currently
use the cycle counter.

      Arnd

