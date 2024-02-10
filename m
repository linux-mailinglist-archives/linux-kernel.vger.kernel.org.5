Return-Path: <linux-kernel+bounces-60546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB085067E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B3B284A76
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC85FDBF;
	Sat, 10 Feb 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D6nG5JDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7LDWvqR"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DC5FDA2;
	Sat, 10 Feb 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707600902; cv=none; b=RUhbetsDqgUYVuIGCvWUJSJ1STzeNxYyVYAy1uRHUOy2yeJOapCwT1n6DqDIG11OS0+KiJLUqH2zU8Fjir8sZhsZeWFjqjGYKihjNdeU/2srkNS4E3LfGitnvAnjEcEtBavd9Zu4wptGvcKUH/Gf+XE2s9gCPYRW+219H/f43tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707600902; c=relaxed/simple;
	bh=vD0Gfk8yiuqnha75NMQ0Ir3RaZu54e3oU3UeiTvr8w0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HWzniStSzJFVcDX6tQWCj6CWDrxvUETwCPRSWbM7TKLGbT9/cHEeYSrDNmeO54uR9yjFe7s8uuv8Ddgygml93ie35vJaYoHGSHTpSqG3BHyvVqGYMHARCiWnz67MPSAHeiWPKd2G25BKgIXj8oYG3ODSAaJG7D9zUKI4yNUBm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D6nG5JDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7LDWvqR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3BA291380077;
	Sat, 10 Feb 2024 16:34:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 10 Feb 2024 16:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707600899;
	 x=1707687299; bh=/n4UmH9uvR4f4o0GIkRteIm3y5vy+StK/jssqoL6VLg=; b=
	D6nG5JDMvzl9PqHC8QWkjXIBwbZsmLZ7ifX4aM1EFfraYgK64G50RvGbjMrhfZ61
	a6ciO3yPhJvmVyttfDWaKO7OnNux97kG+wv0DLWOVSTs+gzXbcQenfPdBk6g7/Pm
	L1KN5ogpsJNv8R+iqCpmIY0O5Fldw1jTpxIsVFp6zBc58zvwIruid++WIhWwi8/T
	+dMrIEQFZPLj+vGrK0BjZRkN+ks+2XGftGXa7DX+0aPi3JX7EwHZbI9SdB9Ilb0b
	y1PMF/fHLlJpLNY+g9bY3Tq9YYTRQI1Vqz+XI6TJUFBOI0U43JD9XjE7pqB4ej7L
	YBExfyY7VeaWZhlz4O9bNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707600899; x=
	1707687299; bh=/n4UmH9uvR4f4o0GIkRteIm3y5vy+StK/jssqoL6VLg=; b=e
	7LDWvqRT04hepOkfZ6f1+B/Lu0U7vpgZsaQZB91YoyXfjz9lz5tMrEBru94g+iiq
	E0ngKuBsMlQ4XcO2a/RmtH+fuveYMaJt6kGU77BAinl0d968Azr3bg70nxhqwYgR
	hF2fhnCTezMfu6LYsWRJDC7/Pcs96/bEl7KtniQoj+UQiy7RUcPU9ZA3y0pv329S
	yfP+aY8LPe8QO1YEPm/uLT65CA6GQkaclArtcOEJUJhU0gg6Qa29tTzFa0QN08fI
	2JzbfRTTaIYza08xSYEFbUE/BlY6y7QtOeaZ9e2TSfYc0Sl5MyY7FiFAE/Rmu3tH
	qysWpFs1373P4FbdHxkuA==
X-ME-Sender: <xms:AezHZS_7jhg30Y_aN_MSErIrKKz3IOaRPkZGn28PBQW64WMS4KJFYg>
    <xme:AezHZStJ14M3ypx1ROsnT76IHYucI9BFtq2ErOAoO2yqeQmlmxs2UhAEaP3MVMU0K
    APa_Cdv7IJPmbrnFzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AezHZYAha0NBTzTUPu3qrrIkJhtCUX5Mz9XFxal-szefyuF1-rLGoA>
    <xmx:AezHZaevmRsVpgAMctIgHgN7XaKG5H7Qc0tVwRriU5vLYbn9qxSrQw>
    <xmx:AezHZXOYd9CypCRGpCJsGphzz2h-7TDfsNeugzwSBsFUxxrZ0xEbiw>
    <xmx:A-zHZS3AQRUAQ407xbkgTLUXYRPxQtA47_W4w-OgRihYza34Q3nDfg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C7EDBB6008D; Sat, 10 Feb 2024 16:34:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74835eb6-5625-4ff5-87ef-0edc96dba0fc@app.fastmail.com>
In-Reply-To: 
 <CACRpkdYtUFAWweawpJquz2BUT81Ako0cZnKgZeyj8Jj93ru8fA@mail.gmail.com>
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com>
 <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
 <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com>
 <87e339bf-6ca9-406a-9f15-d744f90c9c40@app.fastmail.com>
 <CACRpkdYtUFAWweawpJquz2BUT81Ako0cZnKgZeyj8Jj93ru8fA@mail.gmail.com>
Date: Sat, 10 Feb 2024 22:34:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 "Christoph Hellwig" <hch@lst.de>, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024, at 20:38, Linus Walleij wrote:
> On Sat, Feb 10, 2024 at 12:58=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> On Sat, Feb 10, 2024, at 00:41, Linus Walleij wrote:
>
>> > The only difference is where the CPU have to read/write the
>> > buffers really, before the change those were all guaranteed to
>> > be in lowmem (bounced there by the block core), now they can
>> > also be in highmem, but sg_miter will deal with it for sure.
>>
>> Yes, that was my point: The sg_miter() code is meant to
>> handle exactly this case with highmem data, but as far
>> as I can tell, that code path has never been tested on
>> 32-bit systems with highmem but without BLK_BOUNCE_HIGH.
>
> It's actually possible to enforce testing of highmem scatterlists
> to an MMC card (one need to be careful as this is destructive
> testing!)
> drivers/mmc/core/mmc_test.c
>
> ...but the one relevant target I have is a Kirkwood and it only
> has 128 MB of memory so highmem won't be exercised.

I think you can pass a vmalloc=3D command line option to the
kernel that will increase the size of the vmalloc are at
the expense of lowmem and give you some highmem instead.

      Arnd

