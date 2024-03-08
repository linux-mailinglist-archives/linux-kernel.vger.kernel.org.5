Return-Path: <linux-kernel+bounces-96816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DE78761C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F841C21347
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B554BDA;
	Fri,  8 Mar 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWNyRQk3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B295477C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893157; cv=none; b=V0NusIU/xpWo7Uv7B6s75cd3tYvFVad7aAMP7zGziui6PYl8IQFqLB+SAg+6glAXdSNLEI19hLDF7Z5TPdiRHXjsSQ17oSr4c/mUMS+WG+BAm5hbdnqdMz0c3X1dioJUERvCJyYhUV1ns6O8WcnWgWoUHNHWOTyfqOlTaIueAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893157; c=relaxed/simple;
	bh=EHuUG/lUX4Voy6qFsjndzxhPMrP2IU1WHS5ecmeM3xE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RcGvEZd94nG3mCRXZggRO+o8XIY5may2uyTqxg0mzV8jSjj6Lcml2E3soj/id1UlRC+0yZVXlT8Oa4EdP2io4CuaB0jvB33hnwPtDm8PFR6TuqhW1FYzWvaHBVM9Y4vXAQKl8irYQ1Faa/YDRSvUecckfXfZkYWGutQZG20qBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWNyRQk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFABC43399;
	Fri,  8 Mar 2024 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893157;
	bh=EHuUG/lUX4Voy6qFsjndzxhPMrP2IU1WHS5ecmeM3xE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=hWNyRQk3Sq6nbZLdDNP+3pxuJJptXwJN18uWY94XdTCw7xL+IaCkvZtktc5mc+Soh
	 HH0mQHki4AX3hZKEOk/DK38QYKscuzyewbK6u56510E9UqYy4vbMvStkKRgisRy/Xw
	 xtbSnUDQR/mbFnZG9q+/wHnU3gbBl+kTey0c+xDgvQTTqRyV6stpyTUH2Dat/+cpEo
	 RQOvDCQE7V1igJQUx1f+lthRJOF9+abl/MP51sbuKTOK4ag5tzl4WT4sPyH1cpAXI6
	 Ih4ol2NCa+HZAo0xg3dBgS+Tnh6JneQOFFSwkHFdf7n3Aj19eZWx4fyEjP8djqMb3B
	 CVZIkBaSwZ2qw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7CEA7120006A;
	Fri,  8 Mar 2024 05:19:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Mar 2024 05:19:15 -0500
X-ME-Sender: <xms:IubqZRuwP9C2mSJg1MZfdyCF4JdJB-4pCZHii7cAzVn_bNNoVyFsTw>
    <xme:IubqZadZMO5N8RHTEWeyyFpBFKeqdB1b_IDkR-bT1W4z_eBrVYFclDLV6v08frfiu
    o2ba2raffrKTM1OC5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveevtefh
    feejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:IubqZUyOdko5il6Bg4o38C5Ud3feg-7bYZrGak-kHYFCrObk62Ldpw>
    <xmx:IubqZYNKRpOx9gkZlLlVYFr-URSsGzR4zA0rCZ6edwsvfAfQzz-Xew>
    <xmx:IubqZR8w52KzjxviRGXG_ZUz5-JXrywCII3FTYASM9UsczVUbk7ESg>
    <xmx:I-bqZfchXpntL4UEGqQPJgce-UL7V6mEn9Afm-4jTFf5neKn4asxd8o7Frg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 83348B6008D; Fri,  8 Mar 2024 05:19:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8177b94d-82c9-42b6-85eb-728dec762162@app.fastmail.com>
In-Reply-To: 
 <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
 <87edclgoon.fsf@BL-laptop>
 <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
Date: Fri, 08 Mar 2024 11:18:54 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Gregory Clement" <gregory.clement@bootlin.com>
Cc: "Chris Packham" <chris.packham@alliedtelesis.co.nz>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Rob Herring" <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 "Conor Dooley" <conor+dt@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
 "Lee Jones" <lee@kernel.org>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024, at 10:56, Andy Shevchenko wrote:
> On Fri, Mar 8, 2024 at 9:36=E2=80=AFAM Gregory CLEMENT
> <gregory.clement@bootlin.com> wrote:
>>
>> Chris Packham <chris.packham@alliedtelesis.co.nz> writes:
>>
>> > The Allied Telesis x530 products have a 7-segment LED display which=
 is
>> > used for node identification when the devices are stacked. Represent
>> > this as a gpio-7-segment device.
>> >
>> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>
>> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> Normally, this patch should be taken in mvebu and then merged by
>> arm-soc. However, I haven't seen any other patch touching this file (=
so
>> no risk of merge conflict) and I think it's too late for me to make a
>> new pull request to arm-soc. So I'm not against it being taken with t=
he
>> rest of the patches. However, I think it would be a good idea to see
>> what Arnd thinks about it.
>
> Arnd wasn't Cc'ed, now I added him.

I already have a 'late' branch for stuff that for some reason
was too late be part of the normal pull requests but should
still make it into 6.9. If this one is important, I don't
mind taking it.

On the other hand, from the patch description this one doesn't
seem that urgent, so I don't see much harm in delaying it
to v6.10, and using the normal process for it.

     Arnd

