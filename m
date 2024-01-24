Return-Path: <linux-kernel+bounces-36740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9F383A5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F212C1C285DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538AE18042;
	Wed, 24 Jan 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="R+0igcYN"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42A18026;
	Wed, 24 Jan 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089662; cv=none; b=M69vCrdJrNwFh1Z91xkFqMG2Kj5FjlNCfWV3zDCChfoPJkJYGNRNu+nhwagLtogVmLmzT20RGQKnLkCZ77AT0/d5d3V4+SNfJQ5+oYSm0D2Jg5emQhsvHTqKnrw9n94hF9O5fF1Of641w6XNF9ph5/3UTwIOLDnANqt3e67m6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089662; c=relaxed/simple;
	bh=DhBk2roOAt7FxbT1JxJRnTyNS8BQtfRrdklAx9s6+qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2GoiMlFmdyrETCBxLc3q0/tUa1CK6G9P4eDh+46tuqVIhrEGq6lyOlMlg6oFTp3byE1/E3A7o9EXF3/AR0l2mtSehRROQFLXdEHpWbQzb1W/vQCLYv3zPeYWqfNbaL3+gTUWHz9J1fcByyP2nfoE/CfYDNia7txs/1aW+YKL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=R+0igcYN; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1706089653;
	bh=Jx4GYD8pm9jQ3Imx4Fz11AN1lh24CdaB97dRh/vezrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R+0igcYNNGyrqLFiugjgepjQV7d+BYKjP/DPfm0kZbitG5ElL2YknPTUIjZf+SWll
	 z/+ljT5xgCcPA/xeImat5ZZDT7PbjU0LdS6BbhcPJ/5W3lFHEtEOATTOWmgPrlPQ6g
	 pKh2batzBToFS94fSCufv61PgMK6oVMjFkIsMTNo=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 197CCA047B;
	Wed, 24 Jan 2024 10:47:33 +0100 (CET)
Message-ID: <4e74b2a8-f19e-492a-a796-057f52dddd93@ysoft.com>
Date: Wed, 24 Jan 2024 10:47:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: qca8k: fix illegal usage of GPIO
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, petr.benes@ysoft.com,
 Vladimir Oltean <olteanv@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jiasheng Jiang <jiasheng@iscas.ac.cn>
References: <1705925049-5756-1-git-send-email-michal.vokac@ysoft.com>
 <82712052-e7e6-414d-9c11-5595e0d6e097@lunn.ch>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <82712052-e7e6-414d-9c11-5595e0d6e097@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 01. 24 0:07, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 01:04:09PM +0100, Michal Vokáč wrote:
>> When working with GPIO, its direction must be set either when the GPIO is
>> requested by gpiod_get*() or later on by one of the gpiod_direction_*()
>> functions. Neither of this is done here which result in undefined behavior
>> on some systems.
>>
>> As the reset GPIO is used right after it is requested here, it makes sense
>> to configure it as GPIOD_OUT_HIGH right away.
>> Fixes: a653f2f538f9 ("net: dsa: qca8k: introduce reset via gpio feature")
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   drivers/net/dsa/qca/qca8k-8xxx.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
>> index 4ce68e655a63..83b19c2d7b97 100644
>> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
>> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
>> @@ -2037,8 +2037,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
>>   	priv->dev = &mdiodev->dev;
>>   	priv->info = of_device_get_match_data(priv->dev);
>>   
>> -	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
>> -						   GPIOD_ASIS);
>> +	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(priv->reset_gpio))
>>   		return PTR_ERR(priv->reset_gpio);
> 
> Hi Michal
> 
> So the current code is:
> 
> 	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
> 						   GPIOD_ASIS);
> 	if (IS_ERR(priv->reset_gpio))
> 		return PTR_ERR(priv->reset_gpio);
> 
> 	if (priv->reset_gpio) {
> 		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> 		/* The active low duration must be greater than 10 ms
> 		 * and checkpatch.pl wants 20 ms.
> 		 */
> 		msleep(20);
> 		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> 	}
> 
> Doesn't your change make the gpiod_set_value_cansleep() pointless?
> 
> Please extend your patch to remove it, maybe extending the comment a
> little.

Hi Andrew,
I agree, in this case the call to gpiod_set_value(1) is now pointless.
I will remove it and describe the change.
  
> Please also make sure what v2 Is Cc: to the qca8k Maintainers.

I wonder who do you mean by qca8k maintainers? There is no one explicitly
stated as a qca8k driver maintainer in MAINTAINERS file.

I admit that there is couple of people listed in get_maintainer output
as authors/commit signers that I have not Cc'd. I have added them to
the Cc list now and will do in the v2 as well.

Thanks for the comments!
Michal


