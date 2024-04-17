Return-Path: <linux-kernel+bounces-148964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E423D8A89C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2139B1C23B37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0C171647;
	Wed, 17 Apr 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="spxE8R9x"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE21411CF;
	Wed, 17 Apr 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373337; cv=none; b=IzsbLFh5ik43BLylVZ0o1pMT5WRr4Q+69XWQbZCKGRbGFceFyO9rpuQBkDFTM/y54sm4vY7UJkV2PIq7osGoPlBKD74HJZ7SU8YIjhiGaCLncKfq3FaX/QmsEba5D9bNczMt33cGX6Xc8Sje67eKfB6cokvXOr8OuxvrOh1RmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373337; c=relaxed/simple;
	bh=s89mJsOAnMWNTbTfm1fj3amuQEAZ4l1Gj99QXHAA41k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TD9dgMvyfUT57y9Xhp3J5LyGRk0mZlZTgtYslT4SpDZfv24V+tEqz8j8ikSfQq/yugq7DhSx+flVzquDFqBKFWE7rwK4q5PxjpuSACYYiKDzUK6HzOTaxC08n1YAH5K8jdhSkw1cedeswXz/C1ie+gqC/jivLOd2A1CdxUFp0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=spxE8R9x; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713373323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHdkwE1wKobPUP6YkxHMexKranCL+6y9ijo3D9qQ91M=;
	b=spxE8R9xWA8NmolDUPu8n10CZDK0eI349D6Og9WPjmCe2mni/UDucQdHAiAAvT6D3PAR2a
	TSAtpW2P1LsPw24LaE2jd2oqITzhJGrH5W+o96ifCOGD8t0M1/iaRV8Aefs8nKDUS0JoXr
	UCdVPJ7X5lkQORhSQyU4ji/bMqVlUmRBXKX3yOofrZvYr8YycS3/lpoOZDK3nGyF0+BLla
	Cy15fNeqRqe619juzmZIl9rrLasjrvgr+Ns/E5AKUNKojsWeNJArhV+fZ/h6qSr7iGLezF
	kmEL+RZ19sC1eoWeoyH1p0kHdhq6WNad8GWS6zbFi2fG9UCnn/QakeH1P5n7Vw==
Date: Wed, 17 Apr 2024 19:02:02 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: jonas@kwiboo.se, conor+dt@kernel.org, devicetree@vger.kernel.org,
 heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
In-Reply-To: <20240417133016.62753-1-amadeus@jmu.edu.cn>
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
Message-ID: <a144c052fcc2460a615a754a64a8f739@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chukun,

On 2024-04-17 15:30, Chukun Pan wrote:
> Hi Jonas,
>>> +	model = "Radxa ROCK3 Model C";
>> 
>> The marketing name seems to be "Radxa ROCK 3C" according to the 
>> product
>> page at [1].
>> 
>> [1] https://radxa.com/products/rock3/3c
> 
> According to https://wiki.radxa.com/Rock3/3c , it should be called
> "Radxa ROCK 3 Model C". I copied rock3a here without paying attention.

If I may interject, here's the result of a quick qrep:

/rk3399pro-rock-pi-n10.dts:	model = "Radxa ROCK Pi N10";
/rk3399-rock-pi-4a-plus.dts:	model = "Radxa ROCK Pi 4A+";
/rk3588s-rock-5a.dts:	model = "Radxa ROCK 5 Model A";
/rk3588-rock-5b.dts:	model = "Radxa ROCK 5 Model B";
/rk3399-rock-4c-plus.dts:	model = "Radxa ROCK 4C+";
/rk3399-rock-pi-4b-plus.dts:	model = "Radxa ROCK Pi 4B+";
/rk3399-rock-pi-4b.dts:	model = "Radxa ROCK Pi 4B";
/rk3399-rock-pi-4c.dts:	model = "Radxa ROCK Pi 4C";
/rk3308-rock-pi-s.dts:	model = "Radxa ROCK Pi S";
/rk3399-rock-pi-4a.dts:	model = "Radxa ROCK Pi 4A";
/rk3399-rock-4se.dts:	model = "Radxa ROCK 4SE";
/rk3328-rock-pi-e.dts:	model = "Radxa ROCK Pi E";
/rk3568-rock-3a.dts:	model = "Radxa ROCK3 Model A";

Based on that, I think that "Radxa ROCK 3 Model C" would actually
be the preferred name...  Perhaps?

If we end up following that approach, the last board dts on the list
above should also be fixed to read "Radxa ROCK 3 Model A".

Either that, or all "Model " strings should be stripped out from
all board dts files that currently contain it.

