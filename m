Return-Path: <linux-kernel+bounces-37992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4483B965
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F2B288C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8111197;
	Thu, 25 Jan 2024 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="nhfsBEwV"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6111185
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162744; cv=none; b=oyxCVvljhmkz7nO15NjFEuGH+bYlOU5XO6WpC2v3nlc/h8OOUQy4rsilL6+MANPnADsaSmLyOU63t2fz87hlxen8SDBt/14/kQ5K6SMCkdWcIChCvObpbhklLqUJnI+oEZnZ3yHYXSKHMKytzmGd9f2IZIcGsCmrtIRoeLcEbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162744; c=relaxed/simple;
	bh=Wht9+cfyMSO6oCY/3DAsC5VOfZrZkJAwCDXfPdou5B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z0cdH92JdWDCQ+pJ23WDCjoD8ITBMagAhgx7PdxHb5FeoGvWBdmRF98sruICNbNot1EgWyyZESr8lqM4UvLiT85HDpanv0Ep384s5wuVw5I+qXREon1r0JWqLKT4pwtH9ZPox1ZeNJas7wXFlaYHdWenBUwukTif9Aw9R4GNybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=nhfsBEwV; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706162736; x=1708754736;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wht9+cfyMSO6oCY/3DAsC5VOfZrZkJAwCDXfPdou5B4=;
	b=nhfsBEwVk6iu/2098D3fQGwGC65TyhgE/4hhyoVF1aTzDseviTIsi8StgRbzJV0u
	rRyLyvgZ32smBzn0RaPFUBt+3wo0lG364ds3UPLjw8fXPG7BP/NGMXepnSs0a0YL
	rM1mttK3C6/1shgFvoy74By7P8GuwC1Yqf0Sjp3OfgA=;
X-AuditID: ac14000a-fbefe7000000290d-99-65b1fa3058b2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 95.F3.10509.03AF1B56; Thu, 25 Jan 2024 07:05:36 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 25 Jan
 2024 07:05:32 +0100
Message-ID: <13f6edd6-f3ae-4e32-88e9-03355d78153c@phytec.de>
Date: Thu, 25 Jan 2024 07:05:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, Mathieu Othacehe <othacehe@gnu.org>
CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Li Yang
	<leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, Christoph
 Stoidner <c.stoidner@phytec.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<upstream@lists.phytec.de>
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
 <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
 <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
 <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
 <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
 <47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net> <87o7da4zc1.fsf@gnu.org>
 <f2fcb4d4-b1d7-4d82-a3b0-d06c0ffd906b@gmx.net>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <f2fcb4d4-b1d7-4d82-a3b0-d06c0ffd906b@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWyRpKBR9fg18ZUg21XDCzW7D3HZDH/yDlW
	i4dX/S1WTd3JYtH34iGzxaHmA0wWmx5fY7Xo+rWS2eLyrjlsFufvbmG2ONH1kNWide8Rdou/
	2zexWLzYIm7R/U7d4viJTmYHAY+ds+6yeyzetJ/No22amcemVZ1sHneu7WHz2Lyk3qO/u4XV
	4/vXDaweG9/tYPLo/2vg8XmTXAB3FJdNSmpOZllqkb5dAlfGxNdLWQsOC1Y8Ov6auYHxB28X
	IyeHhICJRENXO1MXIxeHkMBiJolti5ewQzh3GSUO98wCcjg4eAVsJN4e9gJpYBFQlXj9opMF
	xOYVEJQ4OfMJmC0qIC9x/9YMdhBbWCBIYsPxv2wgNrOAuMStJ/OZQGwRAU+gkcvYQOYzCxxh
	kfj6fQXUsuvMEnP+97CCVLEJqEvc2fANzOYUsJZomLiWBWKShcTiNwfZIWx5ie1v5zCD2EJA
	9otLy1kg3pGXmHbuNTOEHSqx9ct2pgmMwrOQHDsLyVGzkIydhWTsAkaWVYxCuZnJ2alFmdl6
	BRmVJanJeimpmxhB0SzCwLWDsW+OxyFGJg7GQ4wSHMxKIrwmphtThXhTEiurUovy44tKc1KL
	DzFKc7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTD6duor5E3z2jgnOllvjfi5+xLJC3i/
	r8v6VnKulU1H1Uj4YWyt6bVnsw5miBldP/Roueq09zZyi2RfWd44LCl4vy7kwt1LZ/IPLzfL
	3Pr8molPYF5r22GliTZN9gw1t6u9LqsdYmCcnHXB7mvbnk+Vu4UOiLPInW79s/Hr2tXBOdP3
	zP+i8o5TiaU4I9FQi7moOBEA0DThJ9QCAAA=


Am 24.01.24 um 18:28 schrieb Stefan Wahren:
> Hello Mathieu,
>
> Am 24.01.24 um 14:48 schrieb Mathieu Othacehe:
>> Hello Stefan,
>>
>>>> Defining line names should be fine. But I would still prefer to have
>>>> the muxing in an overlay bound to a specific use case.
>>> I'm fine with this. Unfortunately Mathieu dropped the line names in V5
>>> today :-(
>>>
>>> AFAIR reviewers should have 2 weeks time maximum. This was just 2 days.
>> I am sorry but it is not easy for me to deal with contradictory input. I
>> chose to remove the gpio-line-names even though it also seemed like a
>> nice addition to me. The idea was to not interfere with Phytec plans in
>> the future.
> tbh sending v5 before the discussion between Wadim and me was finished
> made it more complicated. Please keep in mind that some reviewers do
> this in their spare time, so a response could take some time.
>
> In this particular case Wadim and me agreed on a solution, so no action
> from your side was necessary except a little bit patience.
>
> The reason why i suggested the gpio-line-names in the first place is
> that users doesn't need to care about different versions of the DT files
> (except the downstream one). Changing the line names afterwards leads to
> confusion.
>
> So before we discuss on a v6, just a question: are on the X16 connector
> just 2 pins muxable as GPIO? This is hard to believe.

In theory you can use more of the Pins as GPIOs. But at this point I 
should mention that the Segin board became slightly more complicated 
since it started to support more SoMs with different SoCs. We have 
routings for various pins to help with the compatibility. So the naming 
in the schematics is not really trivial. And IMO the dt should follow 
the naming of the schematics.

I would prefer to go with v5 without having any namings for now.

Regards,
Wadim

>
> Best regards
>> There is no hurry and I can always restore them in a v6.
>>
>> Let me know what you think,
>>
>> Thanks,
>>
>> Mathieu
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

