Return-Path: <linux-kernel+bounces-8334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C376681B5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059331C2367C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E619874E35;
	Thu, 21 Dec 2023 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="3JFmqbWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vNfvZnCz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2773187;
	Thu, 21 Dec 2023 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 080055C020D;
	Thu, 21 Dec 2023 07:28:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 07:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703161706; x=1703248106; bh=mwOsNjPhM1
	5iVADcV6tlveRSC2qQe3l0324UDObUrhs=; b=3JFmqbWRUv1ymqXmOlMhsk187N
	4JQkihkPG9V20fBnr1utevdOfCprRe13bjUc4gASkj2hCzy60gWiulMsSiGps7L3
	vZwBN6+2nTQPElR8qXwg3XOVe2sql3ped6PuAVfXfG+9rXvZF07biwMlf+Z0EAEA
	jdr7TD9XRHvFm2uSe57hu+Op23EPGZc58/Sa4YiI0a0LbH59WUKtn3jd9wYm1uxK
	94xWDG8WINFPZVXZ18m5+C7uyDNlKKC0s3qsGg5M5mBeHLsjHZDDTcA+9+l8v9ZX
	l/CkrsRzhLc3LB9IA9b+TNgrfSEl04jxiMrnyz/DoxzYzhTAXrSzaVN3m04w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703161706; x=1703248106; bh=mwOsNjPhM15iVADcV6tlveRSC2qQ
	e3l0324UDObUrhs=; b=vNfvZnCzhdXrZNx644Dpz/fT55B481Nj0XPheT/DwfH5
	flD2EJGYDXE/blDmkHdvmUDsRVmichAgfBYbiNck0WPGJmjpbqHgG3QvY/mAOQ7H
	4xI+Jmt77OyDnbri/JHFGohxNc2aAqXqwIRNhDb0Ef90GoUbQoFSb+TARVrRHkyN
	gpKZjsl0CN/o1obVLW6+FCDt1d5a69CNrfelwa+ElbbqiIz/PpCV3y7WNbk9jwcJ
	A4Wo2W8ofMkRcjZIaiLTW1is4/mz3w91QgObnfiN0cakUlUc1B3pDlENbk4eBb4V
	s52Vllnf9ncqCkfO47lr8uIG9iISMTHmfZsPxtAAYQ==
X-ME-Sender: <xms:aS-EZR8RmXFpqu_q2NCvflilQO6E940Waw4W20XI4gAUSFiXdUMJ2A>
    <xme:aS-EZVtAGNbkpjuOZbLFwQXxWOtqyJIKtt_aydgLRY1xwwu4XnyYJi7-uOpvK5wAD
    Ty6ebJvS-qh7YgnFyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aS-EZfCAaScwo7BuOxb1vcTThldOYYZ6CwV4tiymR8uU8TLGnDaL5Q>
    <xmx:aS-EZVfy5tPVS6JK3iQX4WMNDB19syQ08CAGYEXtL1CFjSGAsggMWw>
    <xmx:aS-EZWMdh80G8eWHAo2bsYXrbATg6-ohwdWSIzHSzkx9vDDMujOGhA>
    <xmx:ai-EZd2DujiK_qVHaV82jGGeXF4qgdyC3uHIQuL-gfTsCbbeXt8Kxw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 91AC1B6008D; Thu, 21 Dec 2023 07:28:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a528414-f193-4ac0-a911-af426bb48d64@app.fastmail.com>
In-Reply-To: <491250ba57be2ab983048ffcf5ffd2aec2bedb9e.camel@mwa.re>
References: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
 <ZYEFCHBC75rjCE0n@google.com>
 <9e97eb50-f9a6-4655-9422-fa1106fff97a@app.fastmail.com>
 <491250ba57be2ab983048ffcf5ffd2aec2bedb9e.camel@mwa.re>
Date: Thu, 21 Dec 2023 12:28:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Antonios Salios" <antonios@mwa.re>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jan Henrik Weinstock" <jan@mwa.re>,
 =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Subject: Re: element sizes in input_event struct on riscv32
Content-Type: text/plain

On Thu, Dec 21, 2023, at 08:56, Antonios Salios wrote:
> On Tue, 2023-12-19 at 13:53 +0000, Arnd Bergmann wrote:
>> On Tue, Dec 19, 2023, at 02:50, Dmitry Torokhov wrote:
>
> The header is included from the sysroot of the toolchain, using version
> 6.5.6.
> I'm using glibc 2.37 with a toolchain built from Buildroot.
>
> The problem seems to be, that __USE_TIME_BITS64 is not defined even
> though riscv32 uses 64-bit time.

That sounds like a libc bug. Which C library are you using?

> __BITS_PER_LONG is set to 32 & __KERNEL__ is (of course) undefined in
> userspace.
> The userspace therefore uses 64-bit values as opposed to the kernel,
> which uses 32-bit values.
>
> __USE_TIME_BITS64 is only set when __TIMESIZE is set to 32. [1]
> Under riscv32, the default value of 64 is used. [2]

I don't know what __TIMESIZE is, this is not part of the kernel ABI
as far as I can tell. __USE_TIME_BITS64 should be set by any 32-bit
architecture if the C library defines a 64-bit time_t, otherwise the
kernel headers have no way of picking the correct definitions based
on preprocessor logic.

    Arnd

