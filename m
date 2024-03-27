Return-Path: <linux-kernel+bounces-120249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E560188D4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D779B228E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B121A02;
	Wed, 27 Mar 2024 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="KKIivvUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCHPLDR6"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BA208B6;
	Wed, 27 Mar 2024 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508506; cv=none; b=AKMme6IDinYWnwIYV5MUcFy6NNB44Tj0cFdxHa+/nY+7pbXCUWyJJH/k+van+DmAgQvr4u6m1KYMGAW0e7WvGKRAM7CN1HNkqiEdtoVk1p9bVBPBJPU0nomr3pEUmyCRHd3iWrA+iThYddx/W8IPM/ngwgkgeZC7d28NAm5Xn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508506; c=relaxed/simple;
	bh=WO1tuqv6KtTmnnZY01fg0iyp4jRQg3qr0tvEWh+n9Os=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=F2y2Rw5DTBHU0Q4D5Mb25o8jqBAI68fVyiLnHTw+GiJJeIzEgCSAvqE0pNh658b5JqSWRbmhFaZR2q7IjUKen4q83JcRw5SfZuXn4k16TUnp0AxCZ3LUwu0cmBeAmFdUTFIzCVJbbj1WO0wCbM44r4RvmNTlyA3IBJx2WNBZdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=KKIivvUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCHPLDR6; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9C4001800093;
	Tue, 26 Mar 2024 23:01:41 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 23:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711508501;
	 x=1711594901; bh=XDNkI3SmEoA0OjZZUZYGac6GPd3VSr3k5M6ddxPtvgc=; b=
	KKIivvUjL9GnPWDtJZyIL3qR7ZnlehwOdsaWdlj+997b1QcqDX3yI/OMpn75y+3g
	ifE4QM9vObgKW0O0AKIGCrDaIhckkx+GnctltSta3Gzfa8/gYp42+Kxi0Ms+nCuw
	1xPjM59BDie09ZAZWoFN3GgZK1s7yljw7okBYZRgeLgAFbH4cHpNgMlEQnJ4dFYh
	WFG0TPNxAs3s0PNwkCS4Zeb0YlL0Focaag0EWYtiUCctbbMqPE3MHN9/20VvTZq9
	gI6mu3epD11E4cbwSNkBJGLdupV10pwrdZ49k5cIJUJfRVExCSps0NOae/d6bapE
	LbAjwYAK+RTPTpHXYIwr2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711508501; x=
	1711594901; bh=XDNkI3SmEoA0OjZZUZYGac6GPd3VSr3k5M6ddxPtvgc=; b=P
	CHPLDR6rzZ2W0kUHZ0A4gHIHOlw5f/bWtnHmoNV4IyBbDL8WCxh373eFY1TiKtPz
	/eGN2cx09wZX5NzWcULh9iOX3We41P+dMPzi+0/+DX3zH8ICTpyX1equPuqVWmB2
	AI2a6AufZmgcFynwPEiYlO4YmMkEBqRvTpAnH2MAz9f+mvPE4JctKPb9c0w5KZal
	D76Um6GSVnZYXuliVhXdfybPKru990OMXL1ttiydV9movL0A7vyhfdsmwjwHA8ch
	bPmlkRfEfxTI0IQxTCyKqLPSQRilobnIFhFOyohJPkfc95q/kPkuLebMZb26+2sg
	hSWneE3IdVD799zY9WUeA==
X-ME-Sender: <xms:FIwDZt-FtPURrUPuBmZiynzl1xAlUX4xe9TxVhC_Uy0Tk8oGRjtkTw>
    <xme:FIwDZht2reFmbOWePYcvGaa03GQxVjgPftvFh-vwhVaO2SVyzFmO-LOWqpfgyW1xQ
    hYtutJ6naRD4RUz9gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:FIwDZrDjOzFVkzIz7AFPodJ34ddMn4JEQktoKLICdmmgxImmuRLYxg>
    <xmx:FIwDZhd-M5BNiAuYk6bORjyc78lbZ1EgNGQOqlywp4oaotOFewAqMw>
    <xmx:FIwDZiMerRQnpBCC8kTYFiN-fMMeYDOzZwa6KzUgCxxXju0FuQu46w>
    <xmx:FIwDZjnj8_kyri066q7d4UNL-Kg_DKkMI9D-eFZNmgga9BNCTp8gdA>
    <xmx:FYwDZvoD-DuSoXMEN2VK6zpmqUrICpJpotRt9eAimjAeLqGtGNt18RPWKEs>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B5B22340080; Tue, 26 Mar 2024 23:01:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea29c277-73cf-4574-8316-dff85a449f54@app.fastmail.com>
In-Reply-To: <13a24576-da89-95b8-4ed2-c24b5ba54a21@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev>
 <20240325054938.489732-2-luke@ljones.dev>
 <2cadcf26-7b99-3b32-8441-1b3939cf93b4@linux.intel.com>
 <9962eb39-23b8-470c-aab9-698f10c80358@app.fastmail.com>
 <13a24576-da89-95b8-4ed2-c24b5ba54a21@linux.intel.com>
Date: Wed, 27 Mar 2024 16:01:09 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Mar 2024, at 12:49 AM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 26 Mar 2024, Luke Jones wrote:
> > On Tue, 26 Mar 2024, at 2:47 AM, Ilpo J=C3=A4rvinen wrote:
> > > On Mon, 25 Mar 2024, Luke D. Jones wrote:
> > >=20
> > > > Support the 2024 mini-led backlight and adjust the related funct=
ions
> > > > to select the relevant dev-id. Also add `available_mini_led_mode=
` to the
> > > > platform sysfs since the available mini-led levels can be differ=
ent.
> > > >=20
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > > ---
>=20
> > > > @@ -2109,10 +2110,27 @@ static ssize_t mini_led_mode_show(struct=
 device *dev,
> > > >  struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > > >  int result;
> > > > =20
> > > > - result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_M=
INI_LED_MODE);
> > > > - if (result < 0)
> > > > - return result;
> > > > + result =3D asus_wmi_get_devstate_simple(asus, asus->mini_led_d=
ev_id);
> > > > =20
> > > > + /* Remap the mode values to match previous generation mini-led.
> > > > + * Some BIOSes return -19 instead of 2, which is "mini-LED off"=
, this
> > > > + * appears to be a  BIOS bug.
> > > > + */
> > > > + if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
) {
> > > > + switch (result) {
> > > > + case 0:
> > > > + result =3D 1;
> > > > + break;
> > > > + case 1:
> > > > + result =3D 2;
> > > > + break;
> > > > + case 2:
> > > > + case -19:
> > >=20
> > > Can you confirm this -19 really does come from BIOS? Because I sus=
pect=20
> > > it's -ENODEV error code from from one of the functions on the driv=
er side
> > > (which is why I asked you to change it into -ENODEV).
> >=20
> > Yes it does. It is rather annoying. What happens in this case is tha=
t=20
> > `2` is written to the WMI endpoint to turn off the MINI-Led feature,=20
> > this works fine and it is turned off, there are no errors from the w=
rite=20
> > at all - verifying the accepted limits in dsdt also shows it is corr=
ect.=20
> >=20
> > However, after that, the read fails once.
>=20
> Hi,
>=20
> I'm left a bit unsure how to interpret your response. If "read fails",=
 it=20
> would indicate that -ENODEV originates from asus_wmi_evaluate_method3(=
),=20
> asus_wmi_get_devstate() or asus_wmi_get_devstate_bits(), not from BIOS=
? So=20
> which way it is?
>=20
> After reading some more code, I think I figured out the answer myself.
> However, that raises another question... So lets now take a step back =
and=20
> walk through the code:
>=20
> Your patch does:
> result =3D asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);
>=20
> asus_wmi_get_devstate_simple() calls asus_wmi_get_devstate_bits() with
> ASUS_WMI_DSTS_STATUS_BIT mask that is 0x00000001.
>=20
> If there's no error, retval is masked with that ASUS_WMI_DSTS_STATUS_B=
IT=20
> forcing the return value to 0-1 range so:
>=20
> a) I don't think -19 can originate from BIOS but comes from kernel sid=
e.
> b) How can it ever return 2 (mini-LED off) ?????

You're right. *facepalm* *grumble*. Honestly if I were getting paid for =
this work I'd invest a bit more time in it and catch these silly little =
things myself.

I'll update the code with all feedback, including using a more appropria=
te WMI function whcih I really should have seen on my own.

Thank you for your time so far.

