Return-Path: <linux-kernel+bounces-20717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CED828411
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9601C23BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA699364B6;
	Tue,  9 Jan 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jWiapSy2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7xYaP8h9"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBB13FE0;
	Tue,  9 Jan 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B579A3200A51;
	Tue,  9 Jan 2024 05:35:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 05:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704796547; x=1704882947; bh=DgG9tCDREy
	TfxAwH9mDVpC/UFPRAXNZSHBS2vcSJXRU=; b=jWiapSy2JW7izbbWmSzVs7RHGy
	NYrT/mP0CmV2uSUWKFoTiLgU2aLm3HH7zxQbmpqnFerzFFas2LevMfawtBzbA21/
	6v6gS6FV5yzPH19s0wTx/x0H6VGa4wDACgkmQNzYstwJIqGhGzxi4H4N16yfAnUf
	Pt1Lzs22mpi4artsj9c5FHd6ZBWktc6Hm/WU0+6JRQn2Xj5LqDMU6PScnGpGybyn
	EWeyT+9uczVokEfqp64mLFxRXE44Y/4Li71gkF2rmJydO3RJRrBSDEP/HbSAoh13
	Z+byJFgUoimTjicJGGpUgyZT0Hja9tZj4Ojl1fEFc+BTncvqF2opTFvGNufA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704796547; x=1704882947; bh=DgG9tCDREyTfxAwH9mDVpC/UFPRA
	XNZSHBS2vcSJXRU=; b=7xYaP8h9UrHAJ+SEQA2d0sh8T9lgXKtXfhz7L/ctcO6m
	o2LC21vB2dwZ+BMW5T51rOTtYk5W2TuWaJt0Q5KEErupShgEUupuRC+EIemJL+2y
	Uk4P6/8yA+VVvYtaat6upbpwfAkIhs9q+yp+xIn+W5a58IPDfBnIkptEPuDYAh5f
	vmRx9jwvSyWmWwgy7J+7+o62fWT2TOgZ3Lrv7vtsXBoP3TiG9FmNS/fqtz0M+O4x
	oUxWnmY0djEj/ogNCfN2gTShnkd7HFvOl78cfBTDOvAzJglXTmIHqeKQhVlcbwKu
	3i9uk9fEC4TGGgC8+SCMycak2wmwg2pqedMWW6Yhqg==
X-ME-Sender: <xms:giGdZY-PegoksqYrZRanLBhTqZVVFv-DRKm7bu2rw1yRRGDmbHLHZg>
    <xme:giGdZQu28zTkxel3LogUfLSzJcFR10IY7WoGL-VfIxoPVxgK8Q4o5dTp4TkuElwgS
    Tjht46wuNLhtB0dCX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:giGdZeC81tTlvnFmALc-wQhcV6FNbl3C0ydHmAju8mN2Jomw-zihvQ>
    <xmx:giGdZYcXgzAU3cbWsycUQc9iJsOMvsxU8jqcxPqnRCZEnD82NXlNYQ>
    <xmx:giGdZdMSrG0d9-vyy7aZ7_uZX2IzqRxOzX3jGxafbTH_MYqZC1_FeA>
    <xmx:gyGdZZD2dvZNN4ekKml_HGglqJScMv8XauUYoLa3RKkaYmVWChESRw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 973E4B6008F; Tue,  9 Jan 2024 05:35:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <468ce58a-9f4a-4a75-adbf-7beb8fa13580@app.fastmail.com>
In-Reply-To: <4c859da1-9551-4d0b-a19c-f20f1133acac@gmail.com>
References: <20240109090715.982332-1-arnd@kernel.org>
 <4c859da1-9551-4d0b-a19c-f20f1133acac@gmail.com>
Date: Tue, 09 Jan 2024 11:35:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Pavel Machek" <pavel@ucw.cz>,
 "Lee Jones" <lee@kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Hans de Goede" <hdegoede@redhat.com>,
 "Jean-Jacques Hiblot" <jjhiblot@traphandler.com>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: remove led_init_default_state_get() and
 devm_led_classdev_register_ext() stubs
Content-Type: text/plain

On Tue, Jan 9, 2024, at 11:10, Heiner Kallweit wrote:
> On 09.01.2024 10:06, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> These two functions have stub implementations that are called when
>> NEW_LEDS and/or LEDS_CLASS are disabled, theorerically allowing drivers
>> to optionally use the LED subsystem.
>> 
>> However, this has never really worked because a built-in driver is
>> unable to link against these functions if the LED class is in a loadable
>> module. Heiner ran into this problem with a driver that newly gained
>> a LEDS_CLASS dependency and suggested using an IS_REACHABLE() check.
>> 
>> This is the reverse approach, removing the stub entirely to acknowledge
>> that it is pointless in its current form, and that not having it avoids
>> misleading developers into thinking that they can rely on it.
>> 
>> This survived around 1000 randconfig builds to validate that any callers
>> of the interface already have the correct Kconfig dependency already,
>> with the exception of the one that Heiner just added.
>> 
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Link: https://lore.kernel.org/linux-leds/0f6f432b-c650-4bb8-a1b5-fe3372804d52@gmail.com/T/#u
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> For r8169 we have a Kconfig-based solution now, right. I had a brief look
> at other drivers using LED functionality, and already the first one I looked
> at seems to suffer from the same problem. input/keyboard/qt2160.c has the
> following what should result in the same link error if qt2160 is built-in
> and CONFIG_LEDS_CLASS=m. qt2160 has a Kconfig dependency only on I2C.
>
> #ifdef CONFIG_LEDS_CLASS
> static int qt2160_register_leds(struct qt2160_data *qt2160)
> {
> [...]
> 	error = devm_led_classdev_register(&client->dev, &led->cdev);
> [...]		
> }
> #else

This is a bug, but I think a different one, with a similar effect.

Part of the problem in this driver is that it uses #ifdef instead
of "#if IS_ENABLED(CONFIG_LEDS_CLASS)". As a result, it just
never uses the LEDS when LEDS_CLASS=m, because that would
define CONFIG_LEDS_CLASS_MODULE but not CONFIG_LEDS_CLASS.

Changing it to IS_ENABLED() would cause the link failure
you describe, but would do it regardless of my change.

The same bug seems to be present in other files as well.

> 2. If stubs are removed (but also in the current situation, see example),
>    then it seems some drivers need adding proper build dependencies.

I don't see any driver that actually relies on the stub, since
that would only work a driver that can never be built-in.

If a driver can be built-in (like your r8169 code) and uses
the stub, we would have seen it fail to link in randconfig
kernels and added a LEDS_CLASS dependency.

     Arnd

