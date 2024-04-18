Return-Path: <linux-kernel+bounces-149543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CF8A92A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182641C20F03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330915B217;
	Thu, 18 Apr 2024 05:53:56 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E25FB8F;
	Thu, 18 Apr 2024 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419635; cv=none; b=R0eF0QrT+ai5PjV9Z3kbgDT5dD2gz22O6U3cB/iFhEmLsekhvnL3e2qlHLyxKe+XP1xVrcjtethapdK6lqYwN+RSWeJJAldbR9PxG+1ejzV0WTeDCiMl1IDr59hMFWWKVHIp3VM1oWrFG6Hfza/epnCnLaojLPs80N+wSw47OzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419635; c=relaxed/simple;
	bh=lYmHWYwjXNyR35BoVTlYlLsaQ5d/bd2fXNxYkZW56cI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=juv92eW6v/j64h6m2rrNUJE7W4+TvYzq5Z0j4oBRIYZVAwyAYrb2eLeVAMXawzHcxSgiOXoFNNBDeCSR1Z6hAa7nTAkrr5H5pMZtuask/GzJiZc/7E2EU7u2pu9qBYDGvHjsIV1XzpqX7OEYvWfUc3to9kF13sNhJUPh1iJlhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpsz13t1713419533tf4gio
X-QQ-Originating-IP: KK9L0DB68nJZeG2DfOPLLnMrgziwM3QZRsgGEYAJBOs=
Received: from [192.168.159.131] ( [106.150.157.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 13:52:11 +0800 (CST)
X-QQ-SSF: 01100000000000C0G000000A0000000
X-QQ-FEAT: 83ShfzFP0oC8nXF2nK1YIPY3n1Qcg8oyeTIWy3Fn5A9bOP4KrCgiPFprv0W9n
	MslRqKoEPWyLKMlAmtgq3br1a0asRJiisfNBavmenK36g2HxTuSzidvFkwkmvHmwYoH7OyF
	h9eK7FWdU8OOfMPAxWgyam2Vixa+f2x5+LpvaiEQVegoCEk09cx/YUePckIcI4MJjUkVxRV
	vdjvTWN+JFZlNcL4BWMeLaRg/yPkYW9l88JqgseXYIOSgzKsbb9Fbg2vnjyyA/HNmZCGbqG
	0LnQ8WDttduZ96gA4rNdSxrUZjGixdaHDsCZuVPRDwXHaqPhfxqqM1T1KBXHJ1Xkd2l2H3f
	dajYZ4/URtpN/QqiM1c2Dm1A3ExN6KPqcny8DwLkeDQQ7mSHHGVM3Ql9ZcnuedHLaShfU0l
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15298947766438916063
Message-ID: <B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com>
Date: Thu, 18 Apr 2024 14:52:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
To: Dragan Simic <dsimic@manjaro.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: jonas@kwiboo.se, conor+dt@kernel.org, devicetree@vger.kernel.org,
 heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
 <a144c052fcc2460a615a754a64a8f739@manjaro.org>
Content-Language: en-US
In-Reply-To: <a144c052fcc2460a615a754a64a8f739@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz6a-0

Hi,

this is Naoki @ Radxa.

thank you for your great work!

On 4/18/24 02:02, Dragan Simic wrote:
> Hello Chukun,
> 
> On 2024-04-17 15:30, Chukun Pan wrote:
>> Hi Jonas,
>>>> +    model = "Radxa ROCK3 Model C";
>>>
>>> The marketing name seems to be "Radxa ROCK 3C" according to the product
>>> page at [1].
>>>
>>> [1] https://radxa.com/products/rock3/3c
>>
>> According to https://wiki.radxa.com/Rock3/3c , it should be called
>> "Radxa ROCK 3 Model C". I copied rock3a here without paying attention.

sorry, wiki.radxa.com is outdated.

docs.radxa.com is correct one and maintained.
(but it still has some errors, sorry)

> If I may interject, here's the result of a quick qrep:
> 
> ./rk3399pro-rock-pi-n10.dts:    model = "Radxa ROCK Pi N10";
> ./rk3399-rock-pi-4a-plus.dts:    model = "Radxa ROCK Pi 4A+";
> ./rk3588s-rock-5a.dts:    model = "Radxa ROCK 5 Model A";
> ./rk3588-rock-5b.dts:    model = "Radxa ROCK 5 Model B";
> ./rk3399-rock-4c-plus.dts:    model = "Radxa ROCK 4C+";
> ./rk3399-rock-pi-4b-plus.dts:    model = "Radxa ROCK Pi 4B+";
> ./rk3399-rock-pi-4b.dts:    model = "Radxa ROCK Pi 4B";
> ./rk3399-rock-pi-4c.dts:    model = "Radxa ROCK Pi 4C";
> ./rk3308-rock-pi-s.dts:    model = "Radxa ROCK Pi S";
> ./rk3399-rock-pi-4a.dts:    model = "Radxa ROCK Pi 4A";
> ./rk3399-rock-4se.dts:    model = "Radxa ROCK 4SE";
> ./rk3328-rock-pi-e.dts:    model = "Radxa ROCK Pi E";
> ./rk3568-rock-3a.dts:    model = "Radxa ROCK3 Model A";
> 
> Based on that, I think that "Radxa ROCK 3 Model C" would actually
> be the preferred name...  Perhaps?
> 
> If we end up following that approach, the last board dts on the list
> above should also be fixed to read "Radxa ROCK 3 Model A".
> 
> Either that, or all "Model " strings should be stripped out from
> all board dts files that currently contain it.

we have a document named "Radxa Product Naming Convention".
there are "full name" and "short name". "Model" is used in "full name", 
but it's not used in "short name". both are correct.

but, we preferred to use "short name" for "model = " in mainline 
linux/u-boot.

for ROCK 3C, please use

  model = "Radxa ROCK 3C";

for ROCK 5A/5B and ROCK 3A,

  model = "Radxa ROCK 5A";
  model = "Radxa ROCK 5B";
  model = "Radxa ROCK 3A";

are preferred.

we need to fix this inconsistency. (include our docs)

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.



