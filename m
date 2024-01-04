Return-Path: <linux-kernel+bounces-16479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01A3823F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C24286862
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9320B07;
	Thu,  4 Jan 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tdPHzEay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ypSzdl/S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F269208DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 08C9D5C0229;
	Thu,  4 Jan 2024 05:04:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Jan 2024 05:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704362651;
	 x=1704449051; bh=RuqivH/bHN8+FXTQPZU0gzRg06uxicsl69RvAIZgijQ=; b=
	tdPHzEayjwUYBSOi+/TjwkF4q2Il908vrZEhqMvLlfyvBK6nmrcguC2aUtx6uup6
	FiPPqWUHPj2mTK9XjdT2lNIszJ33YoKApR2caoSdRHtHBbz3T/h7HHUfYj9+4X1B
	BsyoCijCiuUFRiDBTq4N2xLQJTz3+vje/0Y9P8j238xN9LVUrPNFHN+HDg+Mmp9B
	SRfNc73E9iiESy9js5q/nt/OQcbYrxg1gPHb7xHy6ycV3PAC4s0OJEVxh1zmkADn
	DQ5uoYt/oIr9ti67FV9P3urbJjf4u9a/1QcTzQGv/9Yyw0zRQnYZTEowBxfIhcqL
	MksUTglzBPDCp/AsfgelJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704362651; x=
	1704449051; bh=RuqivH/bHN8+FXTQPZU0gzRg06uxicsl69RvAIZgijQ=; b=y
	pSzdl/S+1VPJN9qymIEy8DDgypVkG1s02ph+5nMBiBQ1n18UmrP8B/YJzdt/wAX8
	dQEqZpDssxjZzsgOXc2eW86KDxuXtsmzZe7VZ7PaVh1oOcftZY53sFpxBcwOzvrz
	A2vMKAZZ4ZDs9iAp3xyHtZaX2ZSkPgVYTFHFiPaTIV0ryJJn2rlsTJUdgT9TUMI5
	FIiglYQrlHS/lZKqjWkm959FN0CB4wkjPlCw2MUa4klU6gnx6fT2p3rjuDz1c4e8
	AHCCd9bU4Urk/0nFv+C5gwaF4ZRmU5JnIUZJBj+odUK3hYxX0gE6sTswpJGPLy3E
	zpXSMVFwWR4nrM8+GYOJA==
X-ME-Sender: <xms:moKWZX96WnvQG9zn-AAfpaEql5YcP4JWdJACC53eL3FLsnfbKaeHSw>
    <xme:moKWZTtenibssmiU-ukGWIbrXey6LRD200HdbOR4lTEuGUsQVGCT-16WOfLCefSPp
    KmJS1yP1ukk1ykVMR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:moKWZVB527mfSOBSgfllNPC8Jor3BB-TmHs_iAMBe4p44AHY3CHy0w>
    <xmx:moKWZTfzE8zEibuX8PHISqTfMzXczmyITs7J8D18IlGln1vTPwWvHw>
    <xmx:moKWZcO8-fUhsBjoR8mKicdhnbJsE8fhTVu75Bw0yg2iifQ0eUXz6A>
    <xmx:m4KWZb2uDXtdYsysFEhtb08ilMPwaKHzOV2jRRfVFkOQHwN1aC-ykg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EB611B6008D; Thu,  4 Jan 2024 05:04:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2295d860-44cf-4816-8a1a-54274974302f@app.fastmail.com>
In-Reply-To: 
 <rj7ijuyy47jrffi6sk7wikqo3rnutz2swkdrznyegalylacawz@jdncegf3elct>
References: <20240103210604.16877-1-duje.mihanovic@skole.hr>
 <rj7ijuyy47jrffi6sk7wikqo3rnutz2swkdrznyegalylacawz@jdncegf3elct>
Date: Thu, 04 Jan 2024 11:03:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Lubomir Rintel" <lkundrak@v3.sk>, "zhang.songyi" <zhang.songyi@zte.com.cn>,
 soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC RESEND] soc: pxa: ssp: Cast to enum pxa_ssp_type instead of int
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024, at 10:08, Uwe Kleine-K=C3=B6nig wrote:
> [adding lakml to Cc for wider audience]
>
> On Wed, Jan 03, 2024 at 10:06:03PM +0100, Duje Mihanovi=C4=87 wrote:
>> On ARM64 platforms, id->data is a 64-bit value and casting it to a
>> 32-bit integer causes build errors. Cast it to the corresponding enum
>> instead.
>>=20
>> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
>> ---
>> This patch is necessary for my Marvell PXA1908 series to compile succ=
essfully
>> with allyesconfig:
>> https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@s=
kole.hr/
>> ---
>>  drivers/soc/pxa/ssp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
>> index a1e8a07f7275..e2ffd8fd7e13 100644
>> --- a/drivers/soc/pxa/ssp.c
>> +++ b/drivers/soc/pxa/ssp.c
>> @@ -152,11 +152,11 @@ static int pxa_ssp_probe(struct platform_device=
 *pdev)
>>  	if (dev->of_node) {
>>  		const struct of_device_id *id =3D
>>  			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
>> -		ssp->type =3D (int) id->data;
>> +		ssp->type =3D (enum pxa_ssp_type) id->data;
>
> I wonder if this is a long-term fix. The error that the compiler throws
> is:
>
> 	drivers/soc/pxa/ssp.c:155:29: error: cast from pointer to integer of=20
> different size [-Werror=3Dpointer-to-int-cast]
> 	  155 |                 ssp->type =3D (int) id->data;
> 	      |                             ^
>
> enum pxa_ssp_type is an integer type, too, and its width could be
> smaller than 64 bit, too.

I would just change the cast to (uintptr_t), which is what we
have elsewhere.

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devic=
etable.h
> index f458469c5ce5..fbe16089e4bb 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -283,7 +283,10 @@ struct of_device_id {
>  	char	name[32];
>  	char	type[32];
>  	char	compatible[128];
> -	const void *data;
> +	union {
> +		const void *data;
> +		kernel_ulong_t driver_data;
> +	};
>  };
>=20
>  /* VIO */
>
> For this driver the change would be nice, as several casts can be
> dropped.

I think this is a nice idea in general, but I would keep
it separate from the bugfix, as we might want to do this on
a wider scale, or run into problems.

In particular, removing tons of casts to (kernel_ulong_t)
in other subsystems is probably more valuable than removing
casts to (void *) for of_device_id, since kernel_ulong_t
is particularly confusing, with a definition that is
completely unrelated to the similarly named __kernel_ulong_t.

      Arnd

