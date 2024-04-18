Return-Path: <linux-kernel+bounces-149586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3D8A9324
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0404D1C20C78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA72576F;
	Thu, 18 Apr 2024 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HuxvxZ+v"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B8111BB;
	Thu, 18 Apr 2024 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422043; cv=none; b=APWeRf+geb+d/Ve3y3wkyrTWqWeCRk50qjaYaShyz+DJQXjg2Cq+v0YWnj9fynULPWf5Mrc8gR2OuFu3hhkw/eQGXztFQiQ6m2LUwTssiJkkQF186jwZoFGyvxGuTwoCOMXPsOqv4lKVInyRCPr//q1dwKdREULfCwqi6EnI46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422043; c=relaxed/simple;
	bh=RHIejf4V54iNzGlOs7usTAyAIGAlOA/ZaJt8Mf4ep/w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CB3VCLvd3Qs5w22QQLqSgtIKATFjH+01mw/zQO7ds4EgIB9xb8/rMCe6Rz/MElVoxYKwgLb+o4ZZ5t8qePNLrTMX88xPb97En7ReJtfJ+FQyFweTyQevfAoOTMSIjTmP+6Wahpv6a9ygGXPkN6mZxonrweNN3mcf/R10sdbc9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HuxvxZ+v; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713422038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJfHenXGscRQCfMOH93v/ydARNP1MmiUsLyM1PnpdpI=;
	b=HuxvxZ+vIQDChoGpBAoPM4zf+SQyTRodNZa4WDHc57jd0ZUM/VJWKclmWAsxiZJuLXa+ct
	M5m1O3JiEw1m4cjZ2Gs8fwdV2qP7VYXnl4p4e82vFQfnKdHU4nfwiwzRPOh9YIcJMYxcfP
	7QsT+PypYWMtnaAmV+lZVzeXTWvQBB/CBqJux2cGtCNB0UIn5X/UhAvOGJDcObD3LWccoc
	TKrTFyM0C8mPtyUn4pOetsyAkYMxQSj3IQQoB4i+MWRpb4kG4VZTfEObXflmCf6MxYRiaj
	AerknqM00o7STOBNGTl+A5GWcZ9V8X0pVYVuC4lP7bUW/ast1hQQZcbpUJuNLQ==
Date: Thu, 18 Apr 2024 08:33:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, jonas@kwiboo.se, conor+dt@kernel.org,
 devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
In-Reply-To: <9e915ef29a2b49ce56446ec9d474eb64@manjaro.org>
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
 <a144c052fcc2460a615a754a64a8f739@manjaro.org>
 <B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com>
 <9e915ef29a2b49ce56446ec9d474eb64@manjaro.org>
Message-ID: <ebf7b5f5ff4cd3c8cbee36f35df6ef5d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-04-18 07:55, Dragan Simic wrote:
> On 2024-04-18 07:52, FUKAUMI Naoki wrote:
>> this is Naoki @ Radxa.
>> 
>> thank you for your great work!
>> 
>> On 4/18/24 02:02, Dragan Simic wrote:
>>> Hello Chukun,
>>> 
>>> On 2024-04-17 15:30, Chukun Pan wrote:
>>>> Hi Jonas,
>>>>>> +    model = "Radxa ROCK3 Model C";
>>>>> 
>>>>> The marketing name seems to be "Radxa ROCK 3C" according to the 
>>>>> product
>>>>> page at [1].
>>>>> 
>>>>> [1] https://radxa.com/products/rock3/3c
>>>> 
>>>> According to https://wiki.radxa.com/Rock3/3c , it should be called
>>>> "Radxa ROCK 3 Model C". I copied rock3a here without paying 
>>>> attention.
>> 
>> sorry, wiki.radxa.com is outdated.
>> 
>> docs.radxa.com is correct one and maintained.
>> (but it still has some errors, sorry)
>> 
>>> If I may interject, here's the result of a quick qrep:
>>> 
>>> ./rk3399pro-rock-pi-n10.dts:    model = "Radxa ROCK Pi N10";
>>> ./rk3399-rock-pi-4a-plus.dts:    model = "Radxa ROCK Pi 4A+";
>>> ./rk3588s-rock-5a.dts:    model = "Radxa ROCK 5 Model A";
>>> ./rk3588-rock-5b.dts:    model = "Radxa ROCK 5 Model B";
>>> ./rk3399-rock-4c-plus.dts:    model = "Radxa ROCK 4C+";
>>> ./rk3399-rock-pi-4b-plus.dts:    model = "Radxa ROCK Pi 4B+";
>>> ./rk3399-rock-pi-4b.dts:    model = "Radxa ROCK Pi 4B";
>>> ./rk3399-rock-pi-4c.dts:    model = "Radxa ROCK Pi 4C";
>>> ./rk3308-rock-pi-s.dts:    model = "Radxa ROCK Pi S";
>>> ./rk3399-rock-pi-4a.dts:    model = "Radxa ROCK Pi 4A";
>>> ./rk3399-rock-4se.dts:    model = "Radxa ROCK 4SE";
>>> ./rk3328-rock-pi-e.dts:    model = "Radxa ROCK Pi E";
>>> ./rk3568-rock-3a.dts:    model = "Radxa ROCK3 Model A";
>>> 
>>> Based on that, I think that "Radxa ROCK 3 Model C" would actually
>>> be the preferred name...  Perhaps?
>>> 
>>> If we end up following that approach, the last board dts on the list
>>> above should also be fixed to read "Radxa ROCK 3 Model A".
>>> 
>>> Either that, or all "Model " strings should be stripped out from
>>> all board dts files that currently contain it.
>> 
>> we have a document named "Radxa Product Naming Convention".
>> there are "full name" and "short name". "Model" is used in "full
>> name", but it's not used in "short name". both are correct.
>> 
>> but, we preferred to use "short name" for "model = " in mainline 
>> linux/u-boot.
>> 
>> for ROCK 3C, please use
>> 
>>  model = "Radxa ROCK 3C";
>> 
>> for ROCK 5A/5B and ROCK 3A,
>> 
>>  model = "Radxa ROCK 5A";
>>  model = "Radxa ROCK 5B";
>>  model = "Radxa ROCK 3A";
>> 
>> are preferred.
>> 
>> we need to fix this inconsistency. (include our docs)
> 
> Great, thanks for this detailed clarification!

I went ahead and prepared a patch that cleans up currently present
naming inconsistencies for the Radxa boards.  AFAICT, there should
be no issues arising from the changes in the "model" and "compatible"
strings, because they aren't used anywhere in the drivers.  There
are no board-specific ALSA UCM2 profiles, which could be affected
by those changes.  U-Boot is also fine.

I'll think a bit more about it, and I'll send the patch over a bit
later.  If it goes well, I'll prepare and send one more similar patch,
for some other boards.

