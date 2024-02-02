Return-Path: <linux-kernel+bounces-49386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139678469D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9449B24C39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293017BC7;
	Fri,  2 Feb 2024 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rjMlxXbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io8eXFBV"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E017BA4;
	Fri,  2 Feb 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860394; cv=none; b=WGcMqGMm9LXcF2AADyV34EuEXeWh8Z2/aF8AU4eomX6rrsEinmH28l27tgt+HJpTfwiJ0i+pCEHX8tDR+8YDRvtT2jnGHarnGuLMimBcZ9NEW2or5WvnZ3QJTRQSec2Uyia5bmNo8e82XoshmGL/TxgpUwmdZoiwWFDnOkfJ7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860394; c=relaxed/simple;
	bh=lw9OzvZqpEqF27r4UJeZnGPbYTFw/zKrYRjFXG18lb8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=O8PwcJm9DhDe9xU/UjY7AdRtGUyljlHDh497ZUvqfjuBvXyF6DqP9owxClrDoJgdMlaM08BSnSGn4zZAYe7M3mfwmoROPhq0JwjU2QB657s7RHiHwSdr3J8QOOcRTRj6ezEiJv6p55VPETpGK/V7/cIR6od3VfahH6hxE2R3R/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rjMlxXbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Io8eXFBV; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 866295C00B4;
	Fri,  2 Feb 2024 02:53:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 02:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706860391; x=1706946791; bh=fXvCVgfX/1
	8RW3JDrWY/F6GsRFhBUuasaue8CYQCWc0=; b=rjMlxXbChQxTtLSlaCFIj0Ka5a
	wBAk63Fvmo9upKjZ1BcS3Gn4cXyE3mRKNncCOx675qkE9RDsLM0a6WxfoPwWPBlT
	aKURfbEw680x9H8SKl22qYus+8EpiosszRWghNcZ5a7wxOTIJaUFWk1UMbjznWvS
	6vOdCfUIfRZwDVvqF0iyCkchsXIBdnH89yHbsk4fZNE6sC1QJZf1hS1aYPzkDG11
	5yZx886ju6IuPil8SMwTPPNE2iFKeY7I7CuC4VUYI8+Gj8OyNheSOeMLvsnCV9Zy
	6AqEBjBlhpolwKTfuvHaWDA3AvpMd7tnHS/s+DAZuDnNnGadwEiTc0U6rZ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706860391; x=1706946791; bh=fXvCVgfX/18RW3JDrWY/F6GsRFhB
	Uuasaue8CYQCWc0=; b=Io8eXFBVwUHNlr8eRc3RTP0C3JlJPZLyeIkhOsopVraJ
	2DtpAKUcIlxwjzdnB2Tru7EGhkO8ATszrwHfbqf0yjDwYMcro9yWH5yj6qRI5adA
	eGRhpxrZm3YrIKHYwu7+U9JHYXy5eLH14og6PZTgBhIeUVOTDLDztjJXTkNHPGAh
	oIepTe3YpkB0T7lWGjXESX6LIOhnv3zVf/18g5BCXHVBQv4Y9DHzjQ3O1gYWaBzn
	Js7DPLTUHWITuSX1/FAXpFv5OE2/659jyd7F17s+0FjHz4bmf02cn2oZCEpgILOG
	yWa5OywJroaDQWwvtbg1CooJSigL2qeyrlJwbO7vaA==
X-ME-Sender: <xms:Z5-8ZQg3XSH-oRTJWLqn2g47dww7DaFvi2MKs0_DUTTIMjEbMo43Ng>
    <xme:Z5-8ZZC6d-cqeQuti7rNE46VaSTzrqlaI-VkDWvQQx7k_F1zItba-lHecdx4lNBEN
    HBJkLCWPvclQ-1hPuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkeffhfdtteeiueegfedvgeefvdetveeghfethfetffffheekvedvvdevfefh
    tdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhnuhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggv
X-ME-Proxy: <xmx:Z5-8ZYEnuPOCn-3lEb7iKiW68O0zeFNQN3S7kqogGhhHLLCoJA3VbA>
    <xmx:Z5-8ZRQktsaKZkHY41Rz4YoRN8rtjx8T3WmrhD0k1F-aLewKnL5N5Q>
    <xmx:Z5-8ZdwYqxZMIdOKVf2cdETe_HfHjzgkvcAH9QIGXYQEZiYqRfT5UA>
    <xmx:Z5-8ZY_lFSkeQt5V-HVpqrBJG19Mm9fP62fkG8vIB-8jeWvetlpF6Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 32E5CB6008D; Fri,  2 Feb 2024 02:53:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34210a52-f4b3-46a1-b301-c76fb24adc42@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
References: <Za6JwRpknVIlfhPF@work>
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Date: Fri, 02 Feb 2024 08:52:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Kees Cook" <keescook@chromium.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
Content-Type: text/plain

On Fri, Jan 26, 2024, at 22:22, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 07:29, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>>
>> Enable -Wstringop-overflow globally
>
> I suspect I'll have to revert this.
>
> On arm64, I get a "writing 16 bytes into a region of size 0" in the Xe driver
>
>    drivers/gpu/drm/xe/xe_gt_pagefault.c:340
>
> but I haven't looked into it much yet.
>
> It's not some gcc-11 issue, though, this is with gcc version 13.2.1
>
> It looks like the kernel test robot reported this too (for s390), at
>
>     https://lore.kernel.org/all/202401161031.hjGJHMiJ-lkp@intel.com/T/
>
> and in that case it was gcc-13.2.0.
>
> So I don't think the issue is about gcc-11 at all, but about other
> random details.

I did a creduce pass on this warning when it first showed up
and opened a gcc bug report as well as a driver workaround:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113214
https://lore.kernel.org/lkml/20240103114819.2913937-1-arnd@kernel.org/#r

The reply in bugzilla is that sanitizers are expected to randomly
produce false-positive warnings like this one. In this case it's
-fsanitize=thread (KCSAN) that triggers it. There are other
warnings that have similar problems, so I guess we could work
around it by having certain warnings moved back to W=1 when
any sanitizers are enabled.

     Arnd

