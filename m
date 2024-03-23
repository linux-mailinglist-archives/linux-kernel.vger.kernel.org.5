Return-Path: <linux-kernel+bounces-112348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C438878AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710E61C221AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0387E383AA;
	Sat, 23 Mar 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="epygnKxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rWHPG+dj"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498501DDC9;
	Sat, 23 Mar 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711198075; cv=none; b=liZpDy2fHbUuua86gQKcF09V8g7K/qKITe6nXQIWMjrT5AjOfYC9yaNVFpQRUF0dZb1U2pSek52Ctx8lZU2oL09xcFYoD1cwyqsOX64Y/wE5uMk9JLA1vJy++ID3QExddUr0h1wUoBhlFGQOCd3pVyR6u598cUMJDODFblaviMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711198075; c=relaxed/simple;
	bh=DK8kn31nMc4vLLNkopTWFlKbbvyPKPiFHunCkcXMieQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=K8xSfujddaxRiySNtUpQDm1JzursNXXEHIlF4+/JzcUvvJZoaEZTK0nUmPMbqDC6aB8C9NhvflgHZ4/bLzO+hCXsG+S9IIFJuZSD4GRZdFe5kMwefYEzlbMKRMK2JLnRi9D+Cr570wyvBxvCRNO/xel3NIxWAhU+QIYceaYCwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=epygnKxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rWHPG+dj; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id DF3811C000A7;
	Sat, 23 Mar 2024 08:47:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 23 Mar 2024 08:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711198070; x=1711284470; bh=no3SxpIrjY
	uNJG9JdLGwJceQHSCubNomtZhDzLJ/D4o=; b=epygnKxeUHDKv/1k8Tp6dWRUzA
	QjRORAIJdjyi+4voAuYw3zil0q9w2xtCJLqnqIIltzo9zW/INN5mfqU28X9ykelU
	uXDHsrwuHNXk5/IRa1SprNynh+6h4ca7nzjox4+tgdxd1kX3O8KX2Nut7Qy0Q2SU
	aXcerVaYPHRjijlcAJZEM2jc1e9kgg3ASmI6RgCGwjOPaN8x+8Z10AtrWfo43Bl8
	JTvSirUgRSD+Y4mNngF61z69NorJvRLPtzgfPUIewhr9q8JS9BdlrdwOcWZiwCd5
	HW3ONw2gveusbmHYoMUWtZekbt63Pnq74V7hV6cgzjCLdYaXo6xQveGXrg8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711198070; x=1711284470; bh=no3SxpIrjYuNJG9JdLGwJceQHSCu
	bNomtZhDzLJ/D4o=; b=rWHPG+djIQkMTy7dtpYCukU5eXVYdVF5nJEwLAmtIyyx
	YM+oSx2HAHvNEEORhOTWM3rFSj6opLGuLMjidwamWbdwG53Luv690zsJciwnNARl
	xinbwufK1SVOY48KBufE9ZxdfgwJ3WcE4vpyr6ksu0KQahLl+EvjoDInVQEoMwDi
	x2wPgy9v86CCvmWFMeeq9yROkRmtupo/0G7o07xkQN9Jv3xxx2abC0KzgPzJU4Gh
	oKEZ7+u4Q1OYiI7NlJv3yGLIkJ6B0zOsKqbR6SuclltnHI1uEbmOTSKmVFi/OACl
	nYwUl3O1XBZNLIbjvKXdlJfKeun386Wt1muNfoTuIQ==
X-ME-Sender: <xms:dc_-ZQ4gwCN1jJ0xu5uLIMaaWJhffwOGRKdeAOztL7kqV5RtwTUPfg>
    <xme:dc_-ZR5WeM5wrJ2DRRIIAcv59iD2m5SxaFrJwkuIvqaX4vlZqKOB49jrMaG9DBxoO
    XDXbwWVQpORj2_xLkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dc_-Zff2o2V8MTNE4RremOsZn7Dy_Ia-JJMGAIwzgyveD9CnI-MrVA>
    <xmx:dc_-ZVJ9Sbm1Rn6BzzZO2rKZ7l99487NeNWBupmjtR9jwu4pQX89gQ>
    <xmx:dc_-ZULMvcrmDFTm8YLv1sKqam6W6iXv5UblEwUu_iaEtr_oQpukzQ>
    <xmx:dc_-ZWzgEeLX_I2iwKUfqOlpibMl0A5a2TNpy1fPFSzUkVhU8FVbIA>
    <xmx:ds_-ZV5-uap66XGLQza-C4SRX_Nj60UZXJGFt8P0zYkQBOTvyWEOvMMsk-g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8DE76B6008D; Sat, 23 Mar 2024 08:47:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4a8e28d-ab9b-41cd-92e2-7ef111efd5a3@app.fastmail.com>
In-Reply-To: <2ebe2ea5-b107-4020-8e60-ff8cf43a3aab@arm.com>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
 <db7dfa2d-c7c6-4b10-981a-a7ecc87c8541@arm.com>
 <acfc522a-5162-4b33-9d6c-1e25d0c44a71@app.fastmail.com>
 <2ebe2ea5-b107-4020-8e60-ff8cf43a3aab@arm.com>
Date: Sat, 23 Mar 2024 13:47:29 +0100
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

On Sat, Mar 23, 2024, at 00:40, Jeremy Linton wrote:
> On 3/8/24 14:29, Arnd Bergmann wrote:
>> On Fri, Mar 8, 2024, at 17:49, Jeremy Linton wrote:
>>> On 3/7/24 05:10, Arnd Bergmann wrote:
>>>>
>>>> I'm not sure I understand the logic. Do you mean that accessing
>>>> CNTVCT itself is slow, or that reseeding based on CNTVCT is slow
>>>> because of the overhead of reseeding?
>>>
>>> Slow, as in, its running at a much lower frequency than a cycle counter.
>> 
>> Ok, I see. Would it be possible to use PMEVCNTR0 instead?
>
> So, I presume you actually mean PMCCNTR_EL0 because I don't see the 
> point of a dedicated event, although maybe...

Right, that would make more sense.

> So, the first and maybe largest problem is the PMxxx registers are all 
> optional because the PMU is optional! Although, they are strongly 
> recommended and most (AFAIK) machines do implement them. So, maybe if 
> its just using a cycle counter to dump some entropy into rnd_state it 
> becomes a statement that kstack randomization is slower or unsupported 
> if there isn't a PMU?

I think that sounds workable, especially as there is already
the randomize_kstack_offset=on/off conditional at boot time, it
could fall back to just not randomizing and print a warning
if the feature is enabled but unavailable at boot time.

> But then we have to basically enable the PMU cycle counter globally, 
> which requires reworking how it works, because the cycle counter is 
> enabled/disabled and reset on the fly depending on whether the user is 
> trying to profile something. So, I have hacked that up, and it appears 
> to be working, although i'm not sure what kind of interaction will 
> happen with KVM yet.
>
> But I guess the larger question is whether its worth changing the PMU 
> behavior for this?

I don't know too much about how the PMU works in detail, but I'm
also worried about two possible issues that end up preventing us
from using it in practice:

- if enabling PMCCNTR_EL0 takes away one of the limited number
  of available counters, we probably don't want to go there

- similarly, I would expect it to have a nonzero power
  consumption if the default is to have the clock disabled
  and non-counting. Probably not a big deal for server machines,
  but could be an issue on battery powered embedded devices.

     Arnd

