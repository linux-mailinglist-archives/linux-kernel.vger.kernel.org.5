Return-Path: <linux-kernel+bounces-26232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B026B82DD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3121F24211
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C517BAE;
	Mon, 15 Jan 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iY3DUK4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eybOU38d"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644F17BA1;
	Mon, 15 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 317F13200A24;
	Mon, 15 Jan 2024 11:15:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jan 2024 11:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705335306; x=1705421706; bh=OwwV079+Ib
	4EhCbveDYoIfXqeXgw7sWlHiHGG0LHoH0=; b=iY3DUK4+l4x1zKVZt/k7PFIF2T
	9GDD31aL2Nj9MbIq/iW7zEJNz9xwhZSOc8HNPXnB4499+tAIHkyhQOxRcdkA8UI0
	6bZrxDFvUpAuE5HvEcMDHuRRQKMgpwH5AHEiMEYz2eHblWWvEnRxz/RI+nal6KfK
	qiLKDTtWqA/mJxfiuoW0YMRibjnO67CI0PTGamje4QsXWuD8pjxM7cuJapiZwzYr
	8VL49wvb+zmV7024PyQn/cl/SjVr1H5v49CHj5RY739qeryfkqHOmQf9F6DJcoM9
	UndCI49i5EKETL7YRzJ0AP1oejWlcO2XEt/dkkVgMoto8/eQ2qrBYjJizW3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705335306; x=1705421706; bh=OwwV079+Ib4EhCbveDYoIfXqeXgw
	7sWlHiHGG0LHoH0=; b=eybOU38d2C55AfxnNCB5YYoTKubKkcYLl1HuKNMxsaAE
	CYwHMEPVdF+HoQWWmEp7ZfUhPy55abq7fsr82qLxEE35BLgUxAn0LylyfO0Y5xlT
	VxhrN1ddFTZa5mDYp5WDc8qS/z8MW5I5nbxWi0XMcp2fEVpAo+bBm0cZGEteVLBH
	/YLr6Cuwubvtb+4b1aO2JSI9PqTtkMZfFg9LpKiB77EaXO+4VND95uwRZep+Vr5J
	pAj5l/2q245PGZPp0bgzDAY8f2dnfaqp+5dDT3AWjLkby0x2mKpFgH80tRLSTyxj
	v+HL0W/cPsVxVZ+ZRFR3nJuL/29wIUoq0gfi8qXBtQ==
X-ME-Sender: <xms:ClqlZb1bvHx7W99HefEkf9N086keHr4jvu_Lj4nJhtw23wQnRVdodw>
    <xme:ClqlZaH50Bb-xmchKsdP4PZRqDkyI1MohXKydXLAd1sJjc69yfUB6elhMCEha_khI
    0yzScobDup4WIA-XOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkeehtefguddvleejvdeileeifffhueevgedvheeiudfhueevgfehkeeitedu
    keeknecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ClqlZb5HDS1LRxqzJYVDnneQGoXfUI4iXL1UE667Uq4EAlfyErYR-A>
    <xmx:ClqlZQ2sJ0mYSBIQueyA14P8y33zfIvxjBHlTG9Yl1fNcrvKw-pTpQ>
    <xmx:ClqlZeGzt-jgAjwSwZCzrFkES_TEU0o48wygK48rMRWIJj8M-JbYkw>
    <xmx:ClqlZbPv0bAFj_XAFQDrV-UIFIReuNBf2XAj8ch4tTyPK6TnOvagCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 58AA2B6008D; Mon, 15 Jan 2024 11:15:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <faf84e13-a927-4679-b837-2509f0209f82@app.fastmail.com>
In-Reply-To: <20be7b9d5b8c0bef2a35da3d207c15eae75bfd4d.camel@mwa.re>
References: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
 <ZYEFCHBC75rjCE0n@google.com>
 <9e97eb50-f9a6-4655-9422-fa1106fff97a@app.fastmail.com>
 <491250ba57be2ab983048ffcf5ffd2aec2bedb9e.camel@mwa.re>
 <1a528414-f193-4ac0-a911-af426bb48d64@app.fastmail.com>
 <caa041d27b0fa45aad09a9a262038e3ae4099ca2.camel@mwa.re>
 <20be7b9d5b8c0bef2a35da3d207c15eae75bfd4d.camel@mwa.re>
Date: Mon, 15 Jan 2024 17:11:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Antonios Salios" <antonios@mwa.re>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jan Henrik Weinstock" <jan@mwa.re>,
 =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Subject: Re: element sizes in input_event struct on riscv32
Content-Type: text/plain

On Mon, Jan 15, 2024, at 16:46, Antonios Salios wrote:
> On Thu, 2023-12-21 at 14:38 +0100, Antonios Salios wrote:
>> On Thu, 2023-12-21 at 12:28 +0000, Arnd Bergmann wrote:
>> > On Thu, Dec 21, 2023, at 08:56, Antonios Salios wrote:
>> > > On Tue, 2023-12-19 at 13:53 +0000, Arnd Bergmann wrote:
>> > > > On Tue, Dec 19, 2023, at 02:50, Dmitry Torokhov wrote:
>> > 
>> > I don't know what __TIMESIZE is, this is not part of the kernel ABI
>> > as far as I can tell. __USE_TIME_BITS64 should be set by any 32-bit
>> > architecture if the C library defines a 64-bit time_t, otherwise
>> > the
>> > kernel headers have no way of picking the correct definitions based
>> > on preprocessor logic.
>> 
>> Okay, I agree that this might be a libc problem then. I'll ask the
>> glibc maintainers.
>> 
>
> According to a glibc maintainer, __USE_TIME_BITS64 is not set on
> architectures that use 64-bit time_t as default such as riscv32.
> This can also be seen here [1].
>
> Perhaps the kernel header needs to check the size of time_t in some
> other way?
>
> [1]
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/features-time64.h;hb=glibc-2.37

I don't see any better way, the kernel headers started using this
in 2018 based on the glibc design documents and discussions
with glibc maintainers, see the section on ioctls in
https://sourceware.org/glibc/wiki/Y2038ProofnessDesign

The kernel only relies on this macro for the sound and
input subsystem, but there are numerous applications and
libraries that copied the kernel definition because that
was defined as the only reliable method.

Maybe you can work around by patching the glibc sources
yourself?

     Arnd

