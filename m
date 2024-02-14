Return-Path: <linux-kernel+bounces-65957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB83855449
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE81C2099E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80D13A264;
	Wed, 14 Feb 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cezpfzgh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkWegzM6"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36555E45;
	Wed, 14 Feb 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943639; cv=none; b=A+acYoweg9QSeQkmxzZsSTO29MGcyGVIVlFYOqdbEZ5HqbC5aGBtz6mSplFlutWqebDGXY+ebMhGdcZQzuMwSrGUUzBOUUIrbdnVzhY88O3w0u+cXsqDTWzrwplpXkVou92/g8lSmx7pdLOjsCXBGBvwHaA8bRTRugmZ/2TdSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943639; c=relaxed/simple;
	bh=lj2iRtunSsbwOF8jHR1368A0TRHv5QANP0TYDzdnr/4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FmEuO6SQvbrCrQUSEb8CXrY8uFYnT1go0hr2o7jm8g55Aj5zZmQNmRjpXhHSPAUUMtShBic8MEbb9LldV+sEXHZPthqseU2MOZIazxFlKf+x3dXjE3gfmBdW/AbCMayDdHsuwdib3WhveBs8efXIA5Xv2llDTKBaY0kDezY853M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Cezpfzgh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WkWegzM6; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D0DBE1C00086;
	Wed, 14 Feb 2024 15:47:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 15:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707943635;
	 x=1708030035; bh=qKVLPFtRqeaV8XnwIHp+8ptgdRas93oDLyQ07hmKIXo=; b=
	Cezpfzghblb7kaiIlV18CM8xqUf4M7ffBqTj3ggiz49IECztWZpyvouD0oe4Ohlc
	JeXPaUGk758WMgZCgRfJUisEkBtgvaYmpXk2qtkEsMYkpRY7WCai3JpwETGb5/b7
	1QDysbp4Py98T5qtqwZkFztabgYREmV8/zZgMOBY+ENxWITsWz2q08MJIev6vPEn
	R2UWr6ym5z/uGCozKwJP5WwdaPTfgivE5ywKNXa3LZqB9qNIyo5/A+3C/rnqw/8Z
	2/nGxE0+uwLpmXHD6t/fG9IibBHUy3NTcmmJQK2xd3m68qc16jGBz0FJWG5Ss0O5
	5TBTPLJ91KYO7ta4pt7Ulg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707943635; x=
	1708030035; bh=qKVLPFtRqeaV8XnwIHp+8ptgdRas93oDLyQ07hmKIXo=; b=W
	kWegzM6xFh7udjj+ONU7e4ZTf4ZwGYIHGp5WFopX4DuLCTXWssLwGNlen+YVORby
	klOB/tJhpp5fi3dC1strjpD1Ghyxfxpqx6IaZG7SCQ47jOkyico2W4jWBmN3hX8X
	8agze6sHg5UvIgG4fioABjT6wkVBouGWuOcyUC52ZftICnKW7URXeOcmqlDFG+pd
	fDnZ/I8ldLZ64gxtunUDHGl2bb6IwMxwwqFcS8sTlAFO4e3GiplDKWVe73AsLjoC
	wLc1IW6e/wKo5z+2Rw9DvHYkuqSgfCbikvngdvEVMTCgm9PwVFB49Gn8N9MfUrhf
	2pxAJeIa2qnRvRJDh4m3A==
X-ME-Sender: <xms:0ibNZUnyrWMEcaKX4-2IyZldpFrw8riqoXCBuiJAfdo4eAKUz3C2cw>
    <xme:0ibNZT3b_6keWWJJM35wJMK3iVu8PlYDc7J9P7fXVdtxcFiX5dyae8D3Q_E4vIm7H
    XlgntBscMK9txMR3Ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0ibNZSp_hTq68M36gWLFnqnXkAy3fGJRLr7PWrrtuGOzG7-cN-8eRg>
    <xmx:0ibNZQlNssZigmjDVU1GGZt4QBaG9jc73Rf5gVbCW-T1MrSihgILEA>
    <xmx:0ibNZS2nsNnR1VIWQTtrbiylITmS3lC9HbacAL0YQfYeAOE9zXewcA>
    <xmx:0ybNZbmuulMYaXdKo7NTJNXFFPaYkxYELRtaQMfb_mA-KQLb3hcRm1PUIyU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B67CEB6008D; Wed, 14 Feb 2024 15:47:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23b58d3c-82eb-450f-a246-f8a91b8e8075@app.fastmail.com>
In-Reply-To: 
 <CAK7LNASQUhJGSdQiyEpc5Rpuk_hJwSCu=W=4JkL-Et_giFNvPg@mail.gmail.com>
References: <20240214181942.3562473-1-arnd@kernel.org>
 <CAK7LNASQUhJGSdQiyEpc5Rpuk_hJwSCu=W=4JkL-Et_giFNvPg@mail.gmail.com>
Date: Wed, 14 Feb 2024 21:45:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: ignore ARMv4 thunks along with others
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024, at 21:34, Masahiro Yamada wrote:
> On Thu, Feb 15, 2024 at 3:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
> If this is a recurring problem,
> maybe is it better to use a regular expression?
>
>
> Remove these lines:
>
> # arm64 lld
> / __AArch64ADRPThunk_/d
>
> # arm lld
> / __ARMV5PILongThunk_/d
> / __ARMV7PILongThunk_/d
> / __ThumbV7PILongThunk_/d
>
> # mips lld
> / __LA25Thunk_/d
> / __microLA25Thunk_/d
>
>
>
>
>
> Add this:
>
> # lld
> / __[^[:space:]]*Thunk_/d
>
> This pattern is only used in tooling,
> but never in the kernel space.

Right, makes sense. There is always a risk of removing
intential kernel symbols and this is slightly higher
with the regex but still not that bad.

I'll give this a spin and send a v2 tomorrow then.

    Arnd

