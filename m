Return-Path: <linux-kernel+bounces-130674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE1897B84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46751C23DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4B15697C;
	Wed,  3 Apr 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cJesWQV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wvGu6xtO"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33919156257;
	Wed,  3 Apr 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182812; cv=none; b=nKm2/1omOXYBtHGGconP4FtZYBbahrTXznjEvwivwgMzUA93Uea93ftPW5YV1d6GoKMAmyCzhlaGxBNzKstJ0b3/g2abkob//+wIbzTZdSYTsFeE9D5RtMKFhr6v0L5wcQIr6rK8jLI1Gp3W7hpr2pR/A+HPi2ltTJgnsp9POFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182812; c=relaxed/simple;
	bh=lhxZXpWe2OEgaHRkPZP3vfJA0SWyKK989dfzTEI4d+g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=la9R95PsZ46GDAhU18WqDtEj9O/x0ubIaMcyTLLXX5gG2lahpNW6Ino+bOr63AntW0pAEhKTQJu1HTbiO2oGjusvKMf8O7cJJUcZGufnetkJMnRgEfOef02pqPj5vPlQeKXxV9HAArrjSZNlkICwifPqHiy0dpmu3/+0q/uCzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cJesWQV6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wvGu6xtO; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E66511C000D6;
	Wed,  3 Apr 2024 18:20:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 18:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712182805;
	 x=1712269205; bh=Xbt92os27lL5H9pYrJJJSECna8SqfJoMjVwzgkuyoZM=; b=
	cJesWQV6sdI6FrzfX4Lid/lEGt6FnxnOnyh9gq0kDbchrgT68okmI4OuEg1r492/
	DQCj2kqFBdSg9f4v6PxKlwP3WJ0O2Gvq5+2rWETAzirKeRMxX4S6fuckou+9DtfQ
	UHcn/mNG6lnEE6byR7hr+uy7geJK8si93XjFbB5FNiFhY4rrKiS7H8jKjBdZjnY5
	UJsWFBC6TVig2jTzaxJiLECLQCw5EoiutJJw8v9tKcjnCwyZc098EWgIuqvwIyG9
	mND4GEj/1BxLEBB0LBRffwARQftQftUvvaV+0OP7hhITzN2AEtNUvKw0X+nP/E4S
	uYss4K1DglH6KZ5SYYt7hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712182805; x=
	1712269205; bh=Xbt92os27lL5H9pYrJJJSECna8SqfJoMjVwzgkuyoZM=; b=w
	vGu6xtOGcCz9d9iyhRkHEdJk+qDMi9unSaDst+Fg2yk7d3lTD7aYZC7WkjS0PhC/
	gOdopkn+KZthmg9+FTE/uRJ5yF36BuWnIFtd8C5kV8XJHaORKs+591FbtVBYxJ0h
	mpHmNItIxNT3WTJzXS1+TxYkeXpKx746regGbPsBvsMB+YPCIfIDyy0ntAq/urEz
	RrohZpr2o03YQ8aPUh3EWbRcT4xNfSmNf6RZiQna6io7rOTC5+jx03MOYe0wCTGe
	3XWNGWtwEchsbzLSfYtNuAmjAyhxsrA9Vwg31AHT63Fi7cbB73fc1BDDkYOn+emM
	upWAjEMBBVe8kEUWMagxQ==
X-ME-Sender: <xms:FNYNZluQf7QcdxGcufSbjYo1HsftnTLndE9a24KgyTIcl8ym2Mq7qw>
    <xme:FNYNZudU3LsSXhQcLB_u7SjDhgQp5drJPkhZqPnEZ-6b5sIwri950uqmb5Q5Qhizy
    rSwQAocGj9r-zSDhD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FNYNZowIbH-1mbC7tl04s8luS269xSWyYLvh50n0U2_Gm4z0pKpNag>
    <xmx:FNYNZsPXoN6J3nYP9LUHpomCZmMH848FtqB1lJFLPI7kw8rCZfX7UA>
    <xmx:FNYNZl_UXIpsDoIEVulnGYZMwWMxVwGZzIB6ZEMhxLWIfaJfFr34lg>
    <xmx:FNYNZsVizvrRhvC7M-87G7YT1K82Di35hmhKA6jWxC2yLKzsYM2bVA>
    <xmx:FdYNZhLG2Ve1yP_2u6OobwgJQnl7P8ga3FycwOyCVO30x_Cnr92C7lpT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 05200B60092; Wed,  3 Apr 2024 18:20:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5ebcbac-f445-4a48-a40f-7aa606c7d460@app.fastmail.com>
In-Reply-To: <Zg3GdUtBUKzB6NNZ@surfacebook.localdomain>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-32-arnd@kernel.org>
 <b4418ac1-10ba-4932-be6e-93282707024f@sirena.org.uk>
 <5f3qvhasho4mfnf6f7i6djak3ankje375mt4fzvv3gqrlj242o@zdk2ajvha6hx>
 <Zg3GdUtBUKzB6NNZ@surfacebook.localdomain>
Date: Thu, 04 Apr 2024 00:19:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Mark Brown" <broonie@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kernel@vger.kernel.org,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Kevin Hilman" <khilman@baylibre.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Jerome Brunet" <jbrunet@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Alim Akhtar" <alim.akhtar@samsung.com>,
 "Li Zetao" <lizetao1@huawei.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Rob Herring" <robh@kernel.org>,
 "Yang Yingliang" <yangyingliang@huawei.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Luis de Arquer" <luis.dearquer@inertim.com>,
 "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Sam Protsenko" <semen.protsenko@linaro.org>,
 "Peter Griffin" <peter.griffin@linaro.org>,
 "Jaewon Kim" <jaewon02.kim@samsung.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 31/34] spi: remove incorrect of_match_ptr annotations
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024, at 23:13, Andy Shevchenko wrote:
> Wed, Apr 03, 2024 at 11:05:51PM +0200, Uwe Kleine-K=C3=B6nig kirjoitti:
>> On Wed, Apr 03, 2024 at 10:56:58AM +0100, Mark Brown wrote:
>> > On Wed, Apr 03, 2024 at 10:06:49AM +0200, Arnd Bergmann wrote:
>> >=20
>> > > These appear to all be copied from the same original driver, so f=
ix them at the
>> > > same time by removing the unnecessary of_match_ptr() annotation. =
As far as I
>> > > can tell, all these drivers are only actually used on configurati=
ons that
>> > > have CONFIG_OF enabled.
>> >=20
>> > Why are we not fixing of_match_ptr() here, or at least adding the i=
fdefs
>> > in case someone does end up wanting to run without OF?
>>=20
>> Fixing of_match_ptr =3D
>>=20
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index a0bedd038a05..d980bccffda0 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -890,7 +890,7 @@ static inline const void *of_device_get_match_dat=
a(const struct device *dev)
>>  	return NULL;
>>  }
>> =20
>> -#define of_match_ptr(_ptr)	NULL
>> +#define of_match_ptr(_ptr)	(0 ? (_ptr) : NULL)

This would require removing several hundred "#ifdef CONFIG_OF"
checks around the of_device_id tables at the same time
unfortunately. Most of those are completely unnecessary, so
if we wanted to remove those, we should remove the of_match_ptr()
instances at the same time.

>>  #define of_match_node(_matches, _node)	NULL
>>  #endif /* CONFIG_OF */
>> =20
>> ?
>>=20
>> Assuming this helps, I agree this would be the better fix.
>
> Why? I mean why do we need to even have this API? It's always
> good to know which devices are supported by the module even
> if you have no need in such support or it's not compiled in.
> One of the reasons why is to be able to google for compatible hardware,
> for example.

As far as I can tell, the of_match_ptr() helper was a historic
mistake, it makes pretty much no sense in its current form.

The version that Uwe proposes would have made sense but we
can't change it now.

      Arnd

