Return-Path: <linux-kernel+bounces-71079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708EC85A066
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF281F227F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978312555D;
	Mon, 19 Feb 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jku3DWDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpxYwmVu"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057524B5B;
	Mon, 19 Feb 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336691; cv=none; b=sSa0RULRXJTtLWNCcwCrKuQix8Z/ewFCdVBzCGSi9d93b/VYdkJ9ZozwDpZLrPwUZ0PJ0wehDE6w1aTTMU0SwoRmzO4wjmTjfHPisLkf3e7oXMfs37iLfDkAGsUhplY3GqHiC877ER/6cPY1Ogtbaz9gWg0SjmdmriyNSZI2w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336691; c=relaxed/simple;
	bh=qsbrELK53euiF+j557Fesa+Wxd418Cyk4NfQ8Tbts9I=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Wh5i+LWzmHSPxi0GDL9g3axMzP3cPTkwy5Ugp5O6OaQdcNNmwjYnVfnq0I+irXf1AoOq0FYQiDKrI88MhrywKrTBHlt+VBjbqTvXphXfNggixhMRUZ8Tpzx+Z2Gw6eA9yCYDIqXnoQqQg7fjSe496C2WGpMrsdvwvhT+9v9Erdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jku3DWDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpxYwmVu; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0151F5C008D;
	Mon, 19 Feb 2024 04:58:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 04:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708336687; x=1708423087; bh=U+WPdpqhJ6
	dppLBFxP7wVdPkEaQuPQkLuRk1nba0D8U=; b=jku3DWDNgxb/KeDJDDfxWiAtnZ
	HigmjbzOxZsJVV6D6VUFcNebBHahVXuA7W4xJLTOKzZGi2iHiDqAhwRWuE5Bd9Sk
	ARntntAp8XIbYVe+bjxivFGJUndlIdIjuCSMmRPHTGTKPmzn8J7KbatCBdAH/rRx
	EY6svVDwYXPs9RNz0qayxoZH9K1n8nde1es30orWbCVhut6r8COKFIAsqGZYSYP8
	DmNqoA+LjvPQbrgNLpjIsfUWdd4yVi4EX7Wv3xRn9B7pTRBs4lrrW5DwRXJfG9MI
	3WYE7F503zoimI+pvwfReZEBzKglAc1sMlYbq9KsNSieIykaERESx9rP48nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708336687; x=1708423087; bh=U+WPdpqhJ6dppLBFxP7wVdPkEaQu
	PQkLuRk1nba0D8U=; b=dpxYwmVuxEiEJubqKVidgpqvarM9L3DDeiO6VQfIIG1w
	OW5V//d+BRlO1rfCb8h3j8QjxUsoP99qe/atADjAEqmMOkOt1WbfW6BntHCphtWl
	OnOMkh0KkhoSVP7y3n85MR4/WUb9DGw/05SnxSahnvz7y+4iLi9+QUVCWeRaORNG
	2RnzFcZkY2v3ntdFapT7hppqLOSmxmiZpZ7K9+Ics1mYWsVY5+Be7W14vHYqUd+E
	OooAFuMDgTzBfz9U34iWE//mYpTWHwgUe/sdaNMLpLKyYa06zKOp/SCyeP3kbLB0
	AbI8qrpfFFTnovJqiNQnCADlH2yrwMKSF3UHEJ5wow==
X-ME-Sender: <xms:LybTZUbI82gZOy2vrBlZFE58Y5uT-7DiwrYLs4Q2Wu-HzqKWg4247Q>
    <xme:LybTZfZFOVKXJoXFovnXxljBdeMqqTWgBxCB5-WPCv2bI2ej05pBtWz9JYdZdgO-D
    jTqxRhvojYeDAcaeik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LybTZe8lZkFmyqhXjnIbiPrVSPWOBmQLUhS-eg9_1vZo9f2rnoMH7w>
    <xmx:LybTZepMyh15puTgkymbHSbw2oc-9pVODJp-ZE3_spumtQ0ufy1s5g>
    <xmx:LybTZfq_OIDej-l8ouf2QjH1hXpmrJc3PraXLTbQ8LvTZ_WnlYVyVg>
    <xmx:LybTZQBK_g68Ht9VyQaNhjlYOBbOPpvSbHVDhfYCRYY7-hUbYmNVvw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 90A79B6008D; Mon, 19 Feb 2024 04:58:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7299839b-06e6-40eb-8024-93ed5f9b733f@app.fastmail.com>
In-Reply-To: 
 <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
References: 
 <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
 <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
Date: Mon, 19 Feb 2024 10:57:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Russell King" <linux@armlinux.org.uk>
Cc: "Calvin Owens" <jcalvinowens@gmail.com>,
 "Dave Martin" <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Content-Type: text/plain

On Mon, Feb 19, 2024, at 10:40, Kent Overstreet wrote:
> On Mon, Feb 19, 2024 at 09:26:51AM +0000, Russell King (Oracle) wrote:
>> On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
>> 
>> +1 - bcachefs definitely needs fixing. Passing all that as an argument
>> not only means that it has to be read into registers, but also when
>> accessing members, it has to be extracted from those registers as well.
>> 
>> Passing that by argument is utterly insane.
>
> If the compiler people can't figure out a vaguely efficient way to pass
> a small struct by value, that's their problem - from the way you
> describe it, I have to wonder at what insanity is going on there.

On most ABIs, there are only six argument registers (24 bytes)
for function calls. The compiler has very little choice here if
it tries to pass 32 bytes worth of data.

On both x86_64 and arm64, there are theoretically enough
registers to pass the data, but kernel disallows using the
vector and floating point registers for passing large
compounds arguments.

The integer registers on x86 apparently allow passing compounds
up to 16 bytes, but only if all members are naturally aligned.
Since you have both __packed members and bitfields, the compiler
would not even be allowed to pass the structure efficiently
even if it was small enough.

      Arnd

