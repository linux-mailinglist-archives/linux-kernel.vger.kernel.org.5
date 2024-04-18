Return-Path: <linux-kernel+bounces-149546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B58A92AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4881F2195A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58BD5F569;
	Thu, 18 Apr 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ykfkeqf2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D828DB7;
	Thu, 18 Apr 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419750; cv=none; b=MzEy6HzZGifRIg5eI21oDDU++k5TBe63W/d39IJDlzC+K1xL9RHeL9kaX5oShzwQYa//4lhlV3E+f9sveY4ZFtTmF7Px1qpATv/kcBH4E2sWa2S9A1reQ6fO1N0E2kDx0wHDDxcUBUnYDrN1V8RZ9IkMAv+mFAHZfSNUvrgThDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419750; c=relaxed/simple;
	bh=3ScaB9o0mIdGivlL1IWiwdNEaUelKIbNDupyzQljuaY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZORLTQbWWZfYAxcYwFFFHuUEtgPW5Ry/xsL3YLdKfkl3jcyNMfDs+JpyMTeO6V4F0Z2kPx4LITGgKwYrxf66gQfQRaEAglt2ILZsrXI65btd1nqe8NqoXSmMuteJAiMnBOhQFzHElIdPs+I70NF/MCfslyNTmS8bcSPF7gPBJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ykfkeqf2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713419745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSRB1G5vKqQuI0ZVQYhgc4yCtAXJx+kTtv4a9ntPscI=;
	b=Ykfkeqf2xNa5NXF0caDEdaSAf7D7n0bJGV7q7mwW4ZN9pruM2VTw1JSbTOaaRvehuKKfHE
	4kbi+GkCPJUf6gEuUvQlkRI1ZBuJco+3GIAm70o1QCodEe2ui3zRahJfz8xwjohDzi5fRB
	000s4AitRjfBc3OQiMJbyuqFzolVO5Ok2LTjwFtX8cyvsBCvLdJPZpsMqPjTy7kHcCq7p5
	hIzLJ98SDH5/6yhFyQjTbby9cE9W/18THARE/qnbAHxflPk0Ur9MUQM223B4/3FDQ7Ocbi
	WNWLw14B73/PSJy/KMOZei7/b3BgHhDrL28S+HbQlMb/2Np+BcIF5qhhSo1cKw==
Date: Thu, 18 Apr 2024 07:55:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, jonas@kwiboo.se, conor+dt@kernel.org,
 devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
In-Reply-To: <B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com>
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
 <a144c052fcc2460a615a754a64a8f739@manjaro.org>
 <B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com>
Message-ID: <9e915ef29a2b49ce56446ec9d474eb64@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Naoki,

On 2024-04-18 07:52, FUKAUMI Naoki wrote:
> this is Naoki @ Radxa.
> 
> thank you for your great work!
> 
> On 4/18/24 02:02, Dragan Simic wrote:
>> Hello Chukun,
>> 
>> On 2024-04-17 15:30, Chukun Pan wrote:
>>> Hi Jonas,
>>>>> +    model = "Radxa ROCK3 Model C";
>>>> 
>>>> The marketing name seems to be "Radxa ROCK 3C" according to the 
>>>> product
>>>> page at [1].
>>>> 
>>>> [1] https://radxa.com/products/rock3/3c
>>> 
>>> According to https://wiki.radxa.com/Rock3/3c , it should be called
>>> "Radxa ROCK 3 Model C". I copied rock3a here without paying 
>>> attention.
> 
> sorry, wiki.radxa.com is outdated.
> 
> docs.radxa.com is correct one and maintained.
> (but it still has some errors, sorry)
> 
>> If I may interject, here's the result of a quick qrep:
>> 
>> ./rk3399pro-rock-pi-n10.dts:    model = "Radxa ROCK Pi N10";
>> ./rk3399-rock-pi-4a-plus.dts:    model = "Radxa ROCK Pi 4A+";
>> ./rk3588s-rock-5a.dts:    model = "Radxa ROCK 5 Model A";
>> ./rk3588-rock-5b.dts:    model = "Radxa ROCK 5 Model B";
>> ./rk3399-rock-4c-plus.dts:    model = "Radxa ROCK 4C+";
>> ./rk3399-rock-pi-4b-plus.dts:    model = "Radxa ROCK Pi 4B+";
>> ./rk3399-rock-pi-4b.dts:    model = "Radxa ROCK Pi 4B";
>> ./rk3399-rock-pi-4c.dts:    model = "Radxa ROCK Pi 4C";
>> ./rk3308-rock-pi-s.dts:    model = "Radxa ROCK Pi S";
>> ./rk3399-rock-pi-4a.dts:    model = "Radxa ROCK Pi 4A";
>> ./rk3399-rock-4se.dts:    model = "Radxa ROCK 4SE";
>> ./rk3328-rock-pi-e.dts:    model = "Radxa ROCK Pi E";
>> ./rk3568-rock-3a.dts:    model = "Radxa ROCK3 Model A";
>> 
>> Based on that, I think that "Radxa ROCK 3 Model C" would actually
>> be the preferred name...  Perhaps?
>> 
>> If we end up following that approach, the last board dts on the list
>> above should also be fixed to read "Radxa ROCK 3 Model A".
>> 
>> Either that, or all "Model " strings should be stripped out from
>> all board dts files that currently contain it.
> 
> we have a document named "Radxa Product Naming Convention".
> there are "full name" and "short name". "Model" is used in "full
> name", but it's not used in "short name". both are correct.
> 
> but, we preferred to use "short name" for "model = " in mainline 
> linux/u-boot.
> 
> for ROCK 3C, please use
> 
>  model = "Radxa ROCK 3C";
> 
> for ROCK 5A/5B and ROCK 3A,
> 
>  model = "Radxa ROCK 5A";
>  model = "Radxa ROCK 5B";
>  model = "Radxa ROCK 3A";
> 
> are preferred.
> 
> we need to fix this inconsistency. (include our docs)

Great, thanks for this detailed clarification!

