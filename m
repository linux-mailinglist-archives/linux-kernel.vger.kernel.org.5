Return-Path: <linux-kernel+bounces-84583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B186A8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A402F1F25996
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9322F0F;
	Wed, 28 Feb 2024 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NnNnCZgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgDsn9er"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B92263E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103764; cv=none; b=gIxuB7IgblAGTDMBuMm7J2sQku44PKOP/efkp+p+xZma1Slb3DEg4tDCuW91u33B5nBLu5S1UuZ64R7+QcIqiOcPdKztwpFw8shSadQ/8Q5bQE5/qfqJSsdfq9Avr0DXq/6KYg3deMfi6sYD8bw69pFndfkUvnixozwzpznmLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103764; c=relaxed/simple;
	bh=i0bHmdzvSy7rB/sXXnR0LYGhqcScCCQPwq5Vt4OHjhA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dh+LvYKiL/FrheJsmtpPTzq67rsz+kKhnHw785bRI4bFnVfOzD+XstszhXWxJhMXZ1niymfULKKaeqqFE0rDHywA7mZEGXh3Cg/EtVPJ2PN6kuZJdZyWip9ORaQEIU+7rs2k/gQ4ow+iqk0Q1lf9PhIsTIRJWQI2kkfENatU4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NnNnCZgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgDsn9er; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id AC7691C00090;
	Wed, 28 Feb 2024 02:02:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 28 Feb 2024 02:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709103759;
	 x=1709190159; bh=7qu93z4Gh5S2MJl0vhisPCE12BlopcVtI06Ur+5x7J4=; b=
	NnNnCZgZmXo4XdGOReeOMoO+AJ4SCkFQXEh4WIjOVwcHrq7IDkX5FPV4mezsb0Bi
	PwvtJ+VyhVBdYi0yh0ddD7GXDsnWe/byEiIE8M9HEO4OQY4D1EqJ6Qtim4KHg23P
	F77iTR6NqiV7C1IuQwW2603CgMtv3/W69LoUiC0o2hbCkzaQXjZXsOIfS43JNWXP
	FxI7r7BhabAyFXPL0VOrwyd/lCQMpTOE94gKJxZgjMvzl1tKrAqQcGj0LsWjVbQI
	Ch65GWOlQ9ILNza4hddGooq/sUZeEcQVwCPWElGfIwS0FIvl3aOazWoPALkuS7Jl
	kNGTnb3EWxGF6f+zn74mCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709103759; x=
	1709190159; bh=7qu93z4Gh5S2MJl0vhisPCE12BlopcVtI06Ur+5x7J4=; b=F
	gDsn9erXTdNDlGXYBggcxa9WNTOfu9J2E6eTwiXLDuL5KqW+PEyUGlzhX1qpD4SK
	jHUPN1ne3Ze9gf3hX43apw/99nJ3DcQeDBuy1WEiVfIdyEOqDV9eR5ISFS1LNjla
	x6B+lszYv6owANWJnR1bhyKY1/NQGaV/zW5MP3tnyatFUjj2PgB0F8g/PlE7VgM3
	2B9C4923E8coR1RpcFyuCQZGkBzreDXhQGmmVDa5jlsXBqMzIhIsca7yP3/k8LP6
	iCBA7wOqJD8Xw2VUKQS2qxYXWRCXYiYlBwq5fj07qF3o2gYsgFnv6Ie1uAQm+Sd7
	TU4/P+TSxGJRvbJRYFrzA==
X-ME-Sender: <xms:jtreZeLPdHUIEtyAcHwSDO02cg4PIc_FPYJWs8m1kszBDu18QnLyFg>
    <xme:jtreZWKrz92Q6eY9ipw4pN7PQYgrELVK5EZP3Nkn1uh-ZZZ-d60tmHLVbJGZNRVcX
    dSPQVCeGHXPaX-y99g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jtreZetcHvdL1ZGsNG9Xpuw5Ho7TdOLybXZksdMMo-pek5wLnp13yg>
    <xmx:jtreZTYe8DYAv-bj1fAJ9wIUoqgx5GzZ9xE3v5yJgJtt9uD6foSzHg>
    <xmx:jtreZVYlbQlnZME1REAhlGH767RPmdH6GCgEkCgfZ04sEs3v1ww6VA>
    <xmx:j9reZaPxHVo5Of1cOmTEagJoDfTCG4MFbDNTRhUV7PF9F4ws_U-5tKlq1sI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6D382B6008D; Wed, 28 Feb 2024 02:02:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200055c2-30a2-4b3a-a102-abacda522c22@app.fastmail.com>
In-Reply-To: <ae7a35e9-16f6-4877-8075-a0fb9fe5bfff@t-8ch.de>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
 <20240213053953-mutt-send-email-mst@kernel.org>
 <ae7a35e9-16f6-4877-8075-a0fb9fe5bfff@t-8ch.de>
Date: Wed, 28 Feb 2024 08:02:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Zhangjin Wu" <falcon@tinylab.org>,
 "Willy Tarreau" <w@1wt.eu>, "Yuan Tan" <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024, at 07:48, Thomas Wei=C3=9Fschuh wrote:
> Hi Michael,
>
> On 2024-02-13 05:41:48-0500, Michael S. Tsirkin wrote:
>> On Sat, Nov 04, 2023 at 02:05:02PM +0100, Greg Kroah-Hartman wrote:
>> > > diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpa=
nic.h
>> > > index 54b7485390d3..82fc618bfbcf 100644
>> > > --- a/include/uapi/misc/pvpanic.h
>> > > +++ b/include/uapi/misc/pvpanic.h
>> > > @@ -5,5 +5,6 @@
>> > > =20
>> > >  #define PVPANIC_PANICKED	(1 << 0)
>> > >  #define PVPANIC_CRASH_LOADED	(1 << 1)
>> > > +#define PVPANIC_SHUTDOWN	(1 << 2)
>> >=20
>> > Why are these in a uapi file?
>> >=20
>> > And if they need to be here, why not use the proper BIT() macro for=
 it?
>> >=20
>>=20
>> This is interface with hypervisor not userspace, but for PV historica=
lly
>> we do this since the compatibility implications are about the same,
>> hypervisors (e.g. QEMU) are mostly userspace and so it is convenient =
for
>> them to reuse the same machinery to export the headers.
>>=20
>> Let's stick to that, cleaner than duplicating everything I think.
>
> as Greg seems to be busy with other stuff I'd like to go ahead with
> submitting this again using the existing header file.

FWIW, I agree using the uapi header for APIs shared between
kernel and qemu is fine, and we don't really have any other
place for those, so please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

