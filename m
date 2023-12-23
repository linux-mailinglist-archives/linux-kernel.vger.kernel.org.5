Return-Path: <linux-kernel+bounces-10392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E1E81D3C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ADA284B8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF81CA6A;
	Sat, 23 Dec 2023 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xfp54mz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0HIjcz+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C04CA58
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 302F83200A00;
	Sat, 23 Dec 2023 06:33:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 23 Dec 2023 06:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703331182;
	 x=1703417582; bh=aw1PRUd2U9q887uS/aiizkeSrf4aRE7RJgeRxnuMliQ=; b=
	Xfp54mz4Bp1csZj7ib7g2UoanPQIHA6/nKdFxZIAFSHCRsstZX79TwqxsFOHTtt2
	3zmxT9NZDuv6Lt5zQ8YcEppnQOmLGxv+DPn2Jw5FZtOod2sbW1pu57Qh8eARt4at
	luYh3B+cd1X+O/byefVogOWUoxLHncC06SI9JVw5IpjfTK0Lku6WtGMbQwgunIEr
	FkCK8Fjhx7Yx5vUX5k5J4TeHFT2vZJUtYejN4UnlXi09qg44JC7+legseDKGAAq9
	EJIYmTQmrODrb0rOsV0pEcdM4A45gc+YPxhesyWYHkdE7g2y5nr19f7zmQQnWx+z
	GNB/vtt3UlIkulYx4S8DXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703331182; x=
	1703417582; bh=aw1PRUd2U9q887uS/aiizkeSrf4aRE7RJgeRxnuMliQ=; b=l
	0HIjcz+xdT+u+8grJUB671q5Zwn6SZGbjyYuJtWk3XxSypGPmJkT1F7GtGXQeLBb
	nzjy4D8rHtuRlaA7WlB0kuDag9688lGwUaY/vxLYuTrf7wHz+d7vy6E5KgWit2Sn
	QzehuyvaY+IpQs8byQGuAeQOuQj2SBkuETI47zJ7avoglJvjjk3zUTGB9vMucwMK
	NygWCId/PTUtcYHQ2CsIvekUd7XoFOZZO8ko7BhjgoosfD7GB//ihhakoiqc4DCF
	/amSgXJ/zMabiubRHjCtEIrGrBSZFey41JzPE8Oli43gZeZwnH8zqWViZ4rJimGj
	j0Xi7SNXrafZFF0+X5c7A==
X-ME-Sender: <xms:bMWGZT38xwoTthpo6iYY_9tYI87JX5qAbNBPOp23b_iJoeaZk1rYaA>
    <xme:bMWGZSFQ9_lV9M3E9hcAFCctZX8DIBNzv4SDIq2qy2g4DH_o0MTmcXQtWIh64WgGP
    qgiFPLJB9hV7NDptJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bMWGZT4cFxRJg-O1E3TwVHF1upmaN6qABPqT2eMYnfAlVC4FiYrLSQ>
    <xmx:bMWGZY0mQmORdAGC3rsd95ydpSSs0aAVvR1La5dSQlyWDHlQekAp9Q>
    <xmx:bMWGZWHcDL6Ck2pfv5fj2KoFLkn9wkGypHyNZmX7kvC0lXjwCQe4Dg>
    <xmx:bsWGZR_Qgt6ZTBmNWtYp4t0UmkEcbKt3uqqDomea85t4Li3F-TdpFA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6A574B6008D; Sat, 23 Dec 2023 06:33:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <04af87cb-1a37-4ce5-8a02-1ae909b0d9eb@app.fastmail.com>
In-Reply-To: <e0be87889c7d2a79e0d559ffcf9b08888f994b08.camel@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-8-c307b8ac9aa8@maquefel.me>
 <ZXn51mcYslZzQ3y-@smile.fi.intel.com>
 <e0be87889c7d2a79e0d559ffcf9b08888f994b08.camel@maquefel.me>
Date: Sat, 23 Dec 2023 11:32:02 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Conor.Dooley" <conor.dooley@microchip.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>, "Joel Stanley" <joel@jms.id.au>,
 "Walker Chen" <walker.chen@starfivetech.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 "Huisong Li" <lihuisong@huawei.com>, "Wei Xu" <xuwei5@hisilicon.com>,
 "Emil Renner Berthing" <kernel@esmil.dk>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Hal Feng" <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/40] soc: Add SoC driver for Cirrus ep93xx
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023, at 10:06, Nikita Shubin wrote:
> On Wed, 2023-12-13 at 20:37 +0200, Andy Shevchenko wrote:
>> On Tue, Dec 12, 2023 at 11:20:25AM +0300, Nikita Shubin wrote:

>>=20
>> Maybe
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strict device *dev =3D=
 &pdev->dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum ep93xx_soc_model=
 model;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D (enum
>> ep93xx_soc_model)(uintptr_t)device_get_match_data(dev);
>>=20
>> ?

You can just skip the second cast:

    model =3D (uintptr_t)device_get_match_data(dev);


or even better, since the only thing you look up by model is the
string put the string directly into the data:

+static const struct of_device_id ep9301_syscon_of_device_ids[] =3D {
+	{ .compatible	=3D "cirrus,ep9301-syscon", .data =3D "pinctrl-ep9301" },
+	{ .compatible	=3D "cirrus,ep9302-syscon", .data =3D "pinctrl-ep9301" },
+	{ .compatible	=3D "cirrus,ep9307-syscon", .data =3D "pinctrl-ep9307" },
+	{ .compatible	=3D "cirrus,ep9312-syscon", .data =3D "pinctrl-ep9312" },
+	{ .compatible	=3D "cirrus,ep9315-syscon", .data =3D "pinctrl-ep9312" },
+	{ /* sentinel */ }
+};

Since the strings are constants, gcc should even be able to deduplicate =
them.

>>=20
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(dev, "EP93xx So=
C revision %s\n", attrs->revision);
>>=20
>> Hmm... Is this message anyhow useful?
>>=20
>
> Can we keep it please ? It makes us happy when we see it in logs for
> historical reasons - it's been there since 2.4.

In general we don't do these at all, but since you are likely the only
person paying attention to this particular one, you may as well keep it.

     Arnd

