Return-Path: <linux-kernel+bounces-118746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AC88BED1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1586C1F2C8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE60535AC;
	Tue, 26 Mar 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CsMZArFr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frTN7S43"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F167482D3;
	Tue, 26 Mar 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447650; cv=none; b=fuHntQz3unp+EL4vCnLAdokTATqntMGUNDfIj8IlE5gNSTpjM2vKnKiQo0M4Qf4CFDMgSOFRLwP/IgsRBz3PROsZQ03zaGxnmG4F0Nj0Vy/GqJKdd4lLFn3166NL2HPhVVxqf7ZzAdwWTA+vNcZ13g8eMql2fXhYEMTwA6AuLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447650; c=relaxed/simple;
	bh=MtysH8+9HAmIANTQD0du5b+w4USbcY1NMUiynk3OwAk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mpu34LPmg4s54nKgdDWmp9G11Iwb1sr9DGv8QW3znLITl+cV0g6YfTV18cHX5TgDdf1MtN6I2jxKBIgH9p/hJ6N9Q6845lIMmvKEYXLir6rTBSedClYGRqyM0rDwtL8GtZk0ljQYj0Qy11kKdNmAEUY0IACbZKKy2jS3lgJDMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CsMZArFr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frTN7S43; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9DCAE13800CE;
	Tue, 26 Mar 2024 06:07:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 06:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711447647; x=1711534047; bh=LwutBSd20d
	Y9F2mV05mJEYeO4BD3EduCXGrjUsQ79Ro=; b=CsMZArFrjB454eFa2IaUgiH3xK
	0MRTkkqFo2vmNw4bOoDWENLwQkM3ABomud1mKU3TT9evCNdjbblBJOSQqIcd5qMC
	6rxMjSd2Fg/t0pCvummOAbK/x22/mwRxZ2GarBGBCSUzMHdF1Kn4BCGCyzkA7IPj
	DCVXOtwz5wHUpTcZWC2LJgmy1dVyDnIbjesxEvUdlH56pCjfHtOG3tp5a7T73dJd
	4EJ9ok6hgtYma2lsbIYeQJyyUZ9ZWZlotYsMBidNO90HeZhVKdmvq4fDhOBkMR0v
	IfQ1V1fcXLCx8zI4yS3xotKhuOYmXx3TQVPzmNZ/RDQyy46iAL+baxNHSGZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711447647; x=1711534047; bh=LwutBSd20dY9F2mV05mJEYeO4BD3
	EduCXGrjUsQ79Ro=; b=frTN7S438NzNyONuwLxfeFnIrPXFXA5syP9EOLb4QFFO
	OHXWLUu1w9sK0l0+os7Ly1LDnynSV38+WBHpcJSKwQus3WHNh/oe2bm4T1ixx6Iw
	Vdkc+07CpeUU6tak7ucAsifjM77y+nw6K+JhUNY0rKcL3KYp5pvPEhHPZ6cAAPy+
	sXUvk6xm6f1FSg+JC1ngdkTF09KlV0k6MJ6D/qWUHk6PC+Bdg7yzqndqBkPP07dP
	tlkKsfarE7zhGeeztF00a5AiLQlNZTp6n8YErdZb621M2+btJSpzZKlHCFnbeA1A
	ZaHqHRDr3vqM/BslddYfTj3OmI9HXV8IPlppssiThw==
X-ME-Sender: <xms:X54CZslcRnEP8GQqOaqL2qFWoFk9x1LPeHsVTk2ZA3juxTIfs-FtxQ>
    <xme:X54CZr0zlJGpEZUXQBxe5hNUXeOym6EpVoRLM92PTRuVRWQCiESxQa3YO-Dt8rF3P
    GGGgTc7Q_uZBVhom8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X54CZqotMrL3f26Han1MXzsLZ6KFBuU6P-LHv6tDRNhUu7pjHOn0_A>
    <xmx:X54CZomZ_73Aybk-QGJuQSC4MHfMyq46bXjEts8s0c8MwFGNIfiaDw>
    <xmx:X54CZq05VR5SBrlbuzXA8hPvvFY4g9qiVCv1UuyN8Yug5tlZx66mMg>
    <xmx:X54CZvuYfS6YqCeoa10rL6eI_TpBy1NkhVrlPrGsUlF14gwbB5bReA>
    <xmx:X54CZrLUz0t1F7r_4oYTrTmhGasFsvpMgLDMeUxrzv7ZH85wfoBiRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 717EEB6008D; Tue, 26 Mar 2024 06:07:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <66e1da99-5cf4-4506-b0bf-4bdf04959f41@app.fastmail.com>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
Date: Tue, 26 Mar 2024 11:07:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Lukasz Majewski" <lukma@denx.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Thierry Reding" <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Mark Brown" <broonie@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Ralf Baechle" <ralf@linux-mips.org>, "Aaron Wu" <Aaron.Wu@analog.com>,
 "Lee Jones" <lee@kernel.org>, "Olof Johansson" <olof@lixom.net>,
 "Niklas Cassel" <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
Content-Type: text/plain

On Tue, Mar 26, 2024, at 10:18, Nikita Shubin via B4 Relay wrote:
> The goal is to recieve ACKs for all patches in series to merge it via 
> Arnd branch.

Thank you for the continued updates, I really hope we can merge
it all for 6.10. I've looked through it again and I'm pretty much
ready to just merge it, though I admit that the process is not
working out that great, and it would probably have been quicker
to add DT support to drivers individually through the subsystem
trees.

> Stephen Boyd, Vinod Koul PLEASE! give some comments on following, couse 
> i hadn't one for a couple of iterations already:
>
> Following patches require attention from Stephen Boyd, as they were 
> converted to aux_dev as suggested:
>
> - ARM: ep93xx: add regmap aux_dev
> - clk: ep93xx: add DT support for Cirrus EP93xx
>
> Following patches require attention from Vinod Koul:
>
> - dma: cirrus: Convert to DT for Cirrus EP93xx
> - dma: cirrus: remove platform code

I suspect that Stephen and Vinod may be missing this, as reviewing
a 38 patch series tends to be a lot of work, and they may have
missed that they are on the critical path here. I certainly
tend to just ignore an entire thread when it looks like I'm not
immediately going to be reviewing it all and other people are
likely to have more comments first, so I'm not blaming them.

To better catch their attention, I would suggest you repost the
two smaller sets of patches as a separate series, with only the
relevant people on Cc. Please also include the respective
bindings when you send send these patches to Stephen and
Vinod.

      Arnd

