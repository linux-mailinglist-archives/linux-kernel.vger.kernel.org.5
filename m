Return-Path: <linux-kernel+bounces-5289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D895818904
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AE91F25633
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11181BDD4;
	Tue, 19 Dec 2023 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PjEiICY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5/p7dm1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E911BDC5;
	Tue, 19 Dec 2023 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id F278B3200A1A;
	Tue, 19 Dec 2023 08:53:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Dec 2023 08:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702994005; x=1703080405; bh=GrP0mRtGJr
	zfoHpL2Av5Ll+A0UZ1SBEllqzx1qntSPk=; b=PjEiICY96bMM67IaxgvmSGHBTZ
	UBnpc4zom9Mmbjvi5lbNj9dBIP6Gg+m2202t3kToxaf6GF24E6kg95p52IplWw32
	JdRL5XH9Xni2vam5oJC9Si6EbYlJWDiiBMvgMtRJI5i97gqFe/wF2CX31hJN5KpF
	sxeJSSxhLODSVtil/EzB/DsM8AFy/S6wOiHLNsOzzajm/j6sw6sFrcIXDIlm/1/e
	98wHECCXm48UJantn3PV1SB/yE51MOjBBMA8Ofyv86MCogzNt1lRTTUtHA++xFvH
	6WRtEwiBEdPK5AvJFfSaBIJlxKJ8xupkxflBLDOMohL5/8GIZ6QH+zLf5zYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702994005; x=1703080405; bh=GrP0mRtGJrzfoHpL2Av5Ll+A0UZ1
	SBEllqzx1qntSPk=; b=C5/p7dm1NSW/24hewx6c+w703Qb1zJkHDw6e/IpXGlv6
	rRKQuem/OnyebipspdjmJG/JDLhD8isUi3WJ97IClY18ShCc2v79tHNIYagzo5G2
	FAmfx171ZlKeAqjOAAKaYC1dSkdNMq7TAj7AcJsDGE1eI7t6OYxXEJXZhmzW66aY
	pEaFROgJSj111G2H7DX0WpxyXZKjwa/+e/b2AHBC8UfPNkhN3ZONS964TVoaPHAo
	O6xO8xuIjsw5iUCwpyWsWjo+XJG6zQBBiHpYoKVBkyqtrTQslNek39RiD4j9ATqc
	CcG6fqcFxUMbiIQahOPJh5cypTok+5QfywU3PlTAmg==
X-ME-Sender: <xms:VaCBZRxuPtULKFqd7nIw5QACE8tKnUShCrwVNNnBQGMGZ8qCiJBxfw>
    <xme:VaCBZRQmSPTqEIaTpgRUS_JxkaFQCDLqDZeHL41uNRCWmvRZSGiZ3XSpeABI-em1C
    OWTx2ESSBRFKxF97mI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkedugfegvdfggefffeefvdfflefgleduhfeufeejieevkedtveefheejffek
    heevnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
    vg
X-ME-Proxy: <xmx:VaCBZbWGvj4kJ7kX2jS0HaoKGY6NFG89qjiWrErjZhl4Wq64jBn-pA>
    <xmx:VaCBZThl5U0td9x08lqpaUIq_ZRTR7eji3eRIbMsbwrLqv6cxa5KxQ>
    <xmx:VaCBZTAtgF9-KUD1Fv433g8IkIPHk70KogOj2I4L79vf3vWI2a_B1g>
    <xmx:VaCBZe5Q_agi4vH4sTbrQi_v84g1FT9vCLj2ppeyiJaFkFkawPUQpA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0A481B6008F; Tue, 19 Dec 2023 08:53:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1350-g1d0a93a8fb-fm-20231218.001-g1d0a93a8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e97eb50-f9a6-4655-9422-fa1106fff97a@app.fastmail.com>
In-Reply-To: <ZYEFCHBC75rjCE0n@google.com>
References: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
 <ZYEFCHBC75rjCE0n@google.com>
Date: Tue, 19 Dec 2023 13:53:07 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Antonios Salios" <antonios@mwa.re>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jan Henrik Weinstock" <jan@mwa.re>,
 =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Subject: Re: element sizes in input_event struct on riscv32
Content-Type: text/plain

On Tue, Dec 19, 2023, at 02:50, Dmitry Torokhov wrote:
> Hi Antonious,
>
> On Thu, Dec 14, 2023 at 11:11:18AM +0100, Antonios Salios wrote:
>> Hi all.
>> 
>> I'm having trouble getting evdev to run in a simulated Buildroot
>> environment on riscv32. Evtest (and the x11 driver) seems to be
>> receiving garbage data from input devices.
>> 
>> Analyzing the input_event struct shows that the kernel uses 32-bit (aka
>> __kernel_ulong_t) values for __sec & __usec.
>> Evtest on the other hand interprets these variables as 64-bit time_t
>> values in a timeval struct, resulting in a mismatch between the kernel
>> and userspace.
>> 
>> What would be the correct size for these values on a 32-bit
>> architecture that uses 64-bit time_t values?
>
> I think there is misunderstanding - we do not have *2* 64-bit values on
> 32-but architectures. Here is what was done:
>
>     Input: extend usable life of event timestamps to 2106 on 32 bit systems

Thanks for forwarding this to me. You are definitely right that
the user-space structure is intended to use a pair of __kernel_ulong_t
for the timestamp. Usually if an application gets this wrong, it is the
result of having copied old kernel headers the source directory that
need to be updated.

For evtest in particular, I don't see how that is possible, the source
code at [1] shows that it just includes the global linux/input.h,
which on riscv32 would have to be at least from linux-5.6 anyway
because older versions are too old to build a time64 glibc.

Antonios, can you check which header was used to build your copy
of evtest, and in case this came from /usr/include/linux, which
version it corresponds to?

      Arnd

[1] https://gitlab.freedesktop.org/libevdev/evtest/-/blob/master/evtest.c?ref_type=heads

