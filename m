Return-Path: <linux-kernel+bounces-7736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88581AC70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FD9287846
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CAB4416;
	Thu, 21 Dec 2023 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rywXbeVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGdXB5Qv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E03C02;
	Thu, 21 Dec 2023 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D55045C02CD;
	Wed, 20 Dec 2023 20:58:02 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 20:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703123882;
	 x=1703210282; bh=5u7cmTEb3k7I+rXqFdXZKIeekD/goMRvCSAHF2YUEFY=; b=
	rywXbeVgH/6+nU+ZRSW11MClxtxfH7K6HG+Smddk5xtVKl8CzSr/khQ6dGfWENPG
	BAsjk5VByijrJHs7IWogFitDAj5HwPMWfz7BVpWg1neO6/TIQdZBN17zzYk83Uou
	LIy/kHZk4qX17IxDQkXIjgr7puvZKA4CZbRzsNSbQYt6eAbp3MChOwWFSw0JYhGH
	VbsEAew6ecfWPRMLGzSlGSS0YuZe/imJW/yZWh0BWpcI3p3NPKZmeZJBkTG0usv1
	L92DvAvYIbnblqKZByImDo+SSkdVKwP6M1fncgDH+3qyDW3mU7lvrjrKHJ6NBCNx
	6B/aIGvvcvgH4BWr/Uafjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703123882; x=
	1703210282; bh=5u7cmTEb3k7I+rXqFdXZKIeekD/goMRvCSAHF2YUEFY=; b=S
	GdXB5Qvwwm3fLo99MKH9Wp9JfHG3qFzhOtzmqm0a8rgSbzLVlLdtgTg1L1YbjrsD
	E4f1qs3W1odLy1SoG8fpkhBD2pUK8vV50zkHeLqHwCF7lVKdSOYO5Qfq78WO0Q2M
	dbZ3Q8d4phHWGpOBtg+cUQ9tv0jVDOAs7tmeewfvG2fLBc6LhZibKS7l9KN6t0/W
	dEZv2/RbOYJT7B+DkL1McpS1wZGRnZpFLBuyk7W3JEoNbieAZs0IwKmmMqJ5oWwQ
	ji60ZipzRxkdfJFDTuKaGeF7Rsglf6YY4TaSeECwGKYMTN/xjLXDuR97T4b2ya6X
	tjZXUGXd2B7xQwg0wooyA==
X-ME-Sender: <xms:qpuDZRAfgz312h5agU1NLmAx1J5XgHhUJtdevJqkXd8wEPkKG8bbuA>
    <xme:qpuDZfi1csmvxsRQBYl8PmW8mMxALX7-lyk8aQd9pz2bz0Ccdj3VBIcghnsiG6Orn
    8YkEGa4cet-YThrfGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:qpuDZcmiVJ0WHtnrjBfO6Dwqp5BG62EEh0v2WMecaNO43d75CTYfyg>
    <xmx:qpuDZbxReaveKF1guUPgJGyqhueJOLrEJtSMoBOoHEfPtw_2rDCE-g>
    <xmx:qpuDZWR5qp9rzaqEK7AkAirW7Vn_dlUjz6eJVphG2Iy0MiycUqjt0Q>
    <xmx:qpuDZbIs8vD5OFs9KsAJNapnmre0enEmlYlbjx_ktXS7NBoui4pEiA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7EAD136A0076; Wed, 20 Dec 2023 20:58:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b20873d4-1627-4e68-8646-c3837c0d135c@app.fastmail.com>
In-Reply-To: <ZYNhbQjMbAH6I0kI@alpha.franken.de>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop> <ZYNhbQjMbAH6I0kI@alpha.franken.de>
Date: Thu, 21 Dec 2023 01:57:42 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>
Cc: "paulburton@kernel.org" <paulburton@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82023=E5=B9=B412=E6=9C=8820=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=889:49=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Dec 15, 2023 at 05:39:39PM +0100, Gregory CLEMENT wrote:
>> Hello Thomas,
>>=20
>> > Hello,
>> >
>> > The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
>> > and features multiple controllers such as the classic UART, I2C, SP=
I,
>> > as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
>> > Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
>> > Security Module, Functional Safety Hardware, and MJPEG encoder.
>> >
>> > One peculiarity of this SoC is that the physical address of the DDDR
>> > exceeds 32 bits. Given that the architecture is 64 bits, this is not
>> > an issue, but it requires some changes in how the mips64 is current=
ly
>> > managed during boot.
>> >
>> > In this fifth version, there aren't many changes, mostly just tweak=
ing
>> > commit messages based on Sergey's feedback and fixing up the code
>> > style. But, the real reason for this series is a bit of a whoopsie =
on
>> > my end. It turns out, despite what I confidently claimed in the last
>> > round, some configuration tweaks were missing. All sorted now, thou=
gh!
>> >
>>=20
>> A few weeks ago, you were concerned about the introduction of the
>> specific kconfig CONFIG_USE_XKPHYS to support EyeQ5, and you wanted us
>> to set up a new platform instead. Since then, Jiaxun proposed a series
>> that was merged here to provide more generic support.
>
> well, there is more to improve and stuff I don't like in Jaixun series.
> For example misusing CONFIG_PHYSICAL_START to force a load address via=
 config
> (IMHO it's already a hack for CRASH_DUMP).
>
> As there is your series and Jiaxun series, where should I comment more
> detailed ?

You can comment on my patches in this series, I'm listening.

>> I had other issues in the initial series, and I think that now I've
>> fixed all of them. So, I would like to know what your opinion is now
>> about this series.
>>=20
>> Will you accept it, or do you still think that a new platform has to =
be
>> set up?
>
> things have improved, but I'm still in favor to use a new platform.
> And my main point stays. A "generic" kernel compiled for EyeQ5 will
> just run on that platform, which doesn't sound generic to me.

There are many case generic-ish kernel won't boot on other system, FIT
file built for one platform certainly won't boot on another, not to ment=
ion
that we already have systems not following UHI boot protocol in generic =
platform,
such as MSCC Ocelot.

If only one extra Kconfig option (CONFIG_PHYSICAL_START) can make kernel
support a new type of platform, duplicating the code for a new platform
does not make much sense here.

In multi-cluster boston system we are having the same problem that low R=
AM
space is not sufficient for kernel image due to GCRs eating up low addre=
ss
space, that's why I devote my time to get XKPHYS booting work.

Also if we fix up relocatable kernel support, we can indeed share one si=
ngle
kernel image between all those systems.

Thanks
>
> Thomas.
>
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not necessa=
rily a
> good idea.                                                [ RFC1925, 2=
.3 ]

--=20
- Jiaxun

