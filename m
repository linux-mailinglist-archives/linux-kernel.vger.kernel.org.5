Return-Path: <linux-kernel+bounces-90547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176C8700FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32C41C2155E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EC63BBF8;
	Mon,  4 Mar 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Zmc3PHWa"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BA2261A;
	Mon,  4 Mar 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554244; cv=none; b=JuGjdcma9e0UgsLvImxKf6IV7ToGsajkiBzNCIHSayCb9dleWPZxvYe//s/8acmx+wwpVC9YIkPNX8fQG9HZSqYcPkG3nseMlRr/PviE0OjSb3AfmdIG/eedFBxkkkdZ6mNddR86lI1XHuxpBPpPfkJBEzOoBWcU2p0hqhefk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554244; c=relaxed/simple;
	bh=w8KVMfNx2zd6C6LYa7vJU1D+To3lrbFoF0bVr9U0imU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2lHm+IW5Kl764I7kk5M0aPjVPnJXy9L+3K0QEpyd5AeYFiJvVDVM8khWhpIU9YGlcJYtnYF0yIfX8WIhXetzPk6egOeEFow/qoui3W+joE6SiZZv1ORlSLAC+wgdtKblQpkw1K1tVG2IkVLRU1Q4vrVg2gbsPpwk7rmf8O+0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Zmc3PHWa; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709554212; x=1710159012; i=markus.elfring@web.de;
	bh=w8KVMfNx2zd6C6LYa7vJU1D+To3lrbFoF0bVr9U0imU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Zmc3PHWa6lOwpCA6+weIY3sdyr7tgF0RQpb+052BMFhBYTrSqBDa0Ni1ytlwX9mN
	 EnJjLYwD5wJ/YRS3UYUAzb7xLyVVC3GRF77iqYnvBcL02gcuUyQb+FK2f+UPVndie
	 aK6uYpeJY095Yl1Zv+aOAYI8ah+1CuKPVrMtX5M0xc7JREXbJgd2TaNDfetW8Jv2j
	 N6SzcWlcCy0ZmgAYA1sh+2v4GHmqti8T/TvSl0ein80ZIwiuD1NdmsXPBIqRC1gCm
	 mvRrHQwbn1ZUdECEtGZEzMykMpLHEjP9W974pfMyOh2TDf5ovDtAUr22HDqS7Eg0+
	 /dANATb3HxV9AlMmVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2gkl-1riU3f36XH-004NU4; Mon, 04
 Mar 2024 13:10:12 +0100
Message-ID: <a8cae5ad-8a2a-4752-a2cd-634c1746af8f@web.de>
Date: Mon, 4 Mar 2024 13:10:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: iqs626a - Use scope-based resource management
 in iqs626_parse_events()
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, linux-input@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Jeff LaBundy <jeff@labundy.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71> <ZeVOPSt0L1D4BxuZ@google.com>
 <e8a2b63f-4f9a-463b-b419-c5f673191111@web.de>
 <b91fe21-fe2-eac8-d1ee-ea8922a08861@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b91fe21-fe2-eac8-d1ee-ea8922a08861@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PKES2OXGqOX5haTvklakPWg73v8jW8wtWclFnqH2pzuUBW7Xr/w
 A7vLT6ATYTbJCX52lGPrSnYwgWGdPvOtk/tT0Hq9gOhLL5TpBaFVVChg48PyAY8cOl8h7lo
 DUidwoYKeYgHpNQfBqCu0lQai6cmp5xznL8rdueAnME+ruajHrPr8O7VRg59m0prqwJb/6a
 qrNJuFRqPRdnGA6al/OxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DNcDAss1Lss=;J+Ty/FXrv4R1l3N0EljlsZQhbMX
 e+tYAqBtBYmJg3e1gA/d67ve0J8cQuNw8Suas1sIgfGZskJNuPTkukqwm5UEkxdAyT3vjckmv
 MfS109EG+fH2VtNp2C/BawYffFYWMW9lZ8lpYLAXBGN4u3nxG20Z1ZG6XtyDeibgNN/Sb3MyI
 kPzYEWLfBJkurOUy/DUda/zblrQ6TjxL64yoLxWmVV9gNZzK3e8T0dp37B5zjz543w6hhlKH9
 u8gKEF9Z5/fe5yzvpIwa2EMvp48ckEy2LcwlYpSu8+pUj06CgQU9KLB1RhJoMvtRu9KM3c9uk
 vtcT6xkEGZHAuAuzyF+/BBXqwIUimqmdNJ7amxLSoqbDu1lGvW+Zy3ew47SRTlgnWkz81Wf2Q
 TXpAMGuYEXXZpTh2ZTPTAOG2XwuR9l79ELZ6Do2BnClxmjK3C3RIRa353YTCYXSSI0FA3RW9y
 t86kC61H1uT4X/PF5dRMOf7wsgWQuVu0XJP/cddIQLH51Xth/Wz2DdLOsxq8lyy97PMEVyqjy
 V0USe2t7YzRfEsASjdMYCx+6WqmYVn+u04PCHq+zx8lrNHit2qsz8T5zLQXh5N1y+KU1wlbES
 skxAYskP2K2dmC8NAe2mqsX0VV0pM8U4Sri5v8OTLaqkZ4GrqaQJVoGBsqnKky2WoZ1eMPMlE
 uj/Y1/9e3Hf4McYl1Ei0B7RBDoX4GRC0FAn0Yf2CBwO5PjY2YMIM8QztXF80s6q1NLZ8D02KQ
 6U5IuNmef30R3FscUbMWRY4fUBiSR9/yKmzazpyHVEr4R8F9LTYKLBErRCsLOC5vY0hZEw8ar
 3NQ/UZ9RmGms6lWsFxT+ZwvlA/kIdiknUNt6d/rpB4Ak0=

>> Scope-based resource management became supported also for this software
>> area by contributions of Jonathan Cameron on 2024-02-17.
>>
>> device property: Add cleanup.h based fwnode_handle_put() scope based cl=
eanup.
>> https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org
>>
>>
>> * Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.
>>
>> * Reduce the scope for the local variable =E2=80=9Cev_node=E2=80=9D int=
o a for loop.
=E2=80=A6
>> +++ b/drivers/input/misc/iqs626a.c
>> @@ -462,7 +462,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>>  {
>>  	struct iqs626_sys_reg *sys_reg =3D &iqs626->sys_reg;
>>  	struct i2c_client *client =3D iqs626->client;
>> -	struct fwnode_handle *ev_node;
>>  	const char *ev_name;
>>  	u8 *thresh, *hyst;
>>  	unsigned int val;
>> @@ -501,6 +500,8 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>>  		if (!iqs626_channels[ch_id].events[i])
>>  			continue;
>>
>> +		struct fwnode_handle *ev_node __free(fwnode_handle);
>
> Doesn't this need to be initialized?

This variable should usually be set in both branches of the subsequent if =
statement,
shouldn't it?

Please take another look at the proposed scope reduction
for the affected variable.
May additional curly brackets be omitted for this source code transformati=
on?

Regards,
Markus

