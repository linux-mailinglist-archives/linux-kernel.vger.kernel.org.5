Return-Path: <linux-kernel+bounces-39987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAA83D825
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418F61C2D8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C11BF43;
	Fri, 26 Jan 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="F8NHV3m1"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BE1BF4C;
	Fri, 26 Jan 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264071; cv=none; b=FiT4c/3HRHsm0UBz9Z19746XE5MamWaQyPhtJE9z9Dg5IQvxej0LyT5x97meMvVO8JGQeEQBkgsj1eIrCSPWSzOAznIY8kulIvxiMgxBtqDDIrCnuNGnx599yC5sdbNVvvUUs7SGc0vVoCpGjHRQ0gTzmOrpReat1CILSgu1ikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264071; c=relaxed/simple;
	bh=+0+nQq894MrTFCh+tHBfI/zmt74sL6Ou9mUQJRks7Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvK0J/mfINiq+ErPXJnjrWmg5JjjJ9960C1f8FfKJTcBOq6Coz+rOqFKh4+JRCgF8R/5nJYEaK9SIsrdKVQebGnrgrFEI4O0+KjHpL/9xudWAQTBdSCe2fdAZ2FQwYzWIq33EFHJQkBuGkIVGMQfWL9VC7/xqLHsQLKKCkJbe+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=F8NHV3m1; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1706264062;
	bh=1k2FleW08EFpcRDpXrvxONkJfyn0V4juB3NAGIE5ozs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F8NHV3m1Zf0Mvkxw8T7aJL6mVEThRHpk8gFOnVDprBZLb5m9g+KOQKTNMfalncjvz
	 LO1xpipEarhkjEvTZva9FkioAaVQ5YDl4vB/8J2k6VNLdWNxz8GJQ5gPdHnrd0mF/S
	 Tz+c+scwTnvCGQ1PwEo2Llun9rLyq1Srm99Tc0R4=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 55D95A0717;
	Fri, 26 Jan 2024 11:14:22 +0100 (CET)
Message-ID: <84e362b0-9a9f-461b-b472-a9b3666cb94b@ysoft.com>
Date: Fri, 26 Jan 2024 11:14:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: qca8k: fix illegal usage of GPIO
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, petr.benes@ysoft.com
References: <1706096225-23468-1-git-send-email-michal.vokac@ysoft.com>
 <2477cf4a-6824-4997-aef8-3f8e5f9b2399@lunn.ch>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <2477cf4a-6824-4997-aef8-3f8e5f9b2399@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 01. 24 17:59, Andrew Lunn wrote:
>> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
>> index ec57d9d52072..3663de8f2617 100644
>> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
>> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
>> @@ -2037,13 +2037,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
>>   	priv->dev = &mdiodev->dev;
>>   	priv->info = of_device_get_match_data(priv->dev);
>>   
>> -	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
>> -						   GPIOD_ASIS);
>> +	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset", GPIOD_OUT_HIGH);
> 
> Sorry, i should of pointed this out on the previous version. netdev
> kept with 80 character lines. That is why what you deleted was split
> over two lines, and what you add should also split at the same point.
OK, no problem I will fix that. I did not realize, that netdev kept
that rule.

Michal

