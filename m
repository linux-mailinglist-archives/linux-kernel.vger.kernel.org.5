Return-Path: <linux-kernel+bounces-86231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9286C277
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7EF1F21E40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501A51C2C;
	Thu, 29 Feb 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LTdCLwgf"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF174503B;
	Thu, 29 Feb 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191483; cv=none; b=mEMpBG1AAsXg3zvxZd36IudOz2rnCnVYaA24fGlP5TF9K/RfPusbOxT4broeCT51Ze9UkU0Fy9De4DJU3u8IWecdIIy2eAV3oJIb/ZL3pqauimrSLuUMP1mAcqcVMLyqPIFCdzVduPL9Q7LofPpnZRQcvi290KQr4YYA1iXnmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191483; c=relaxed/simple;
	bh=6fSYPGqi6Mgwam4bansrfoHe9+dSee44GBYoLoyESMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVpnW81vpol3f00G5T6yZ1EhGd33MH3fAQiucxulmKq4hd6S4hHq9W+RleNtAdTNHsF+HBAxu6Dr2cIGF2nyJFF9O0At9KqVVWxdQKAUUIqjXznif2tG+n9+68/7ywlLhgEALswKdcGTXLkeQl15Q5sCGRgIQmkqcPIZ7sTXwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LTdCLwgf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD2F560002;
	Thu, 29 Feb 2024 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709191473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNhb0IZu8kQF7xXW6m4JH0n5eEc9dZ6Qir73N+A60sI=;
	b=LTdCLwgfoFaKv1AFHCUXlQyhTgxxayhfwJO+DZo3k5BT8vOpte1KOopHVm6L9VasZURBlQ
	R03v8RWu+JD9lpzrg7vk3lDGIasxgTU0T3VWJX92ZuFsRqcx2XVO0Qn/UmEnKcJkIUUlaI
	E/swf2WCdv+uAPrJHPD2O9ktGMwCn/so+G0f75Q0JKrEdkIGcSGd/V+BcxaWMbyG944CZp
	tiSfl145UY2VtEIGd7/q4I52sdI01HPhrv7re/VplJ7GabT/EwSQoDibNzjOFh6GsVMUV2
	bzvJLJhLoNojQYRVtt3dyzdoEUefhp8ymRnlm35ifLSI+SqU/8W3dc7OwmUWMw==
Message-ID: <e1936774-14bf-4ae5-9754-e21f5a0c59b3@bootlin.com>
Date: Thu, 29 Feb 2024 08:24:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] leds: trigger: Create a new LED netdev trigger for
 collision
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-leds@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-3-bastien.curutchet@bootlin.com>
 <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Andrew,


On 2/27/24 17:03, Andrew Lunn wrote:
> On Tue, Feb 27, 2024 at 10:39:41AM +0100, Bastien Curutchet wrote:
>> Collisions on link does not fit into one of the existing netdev triggers.
>>
>> Add TRIGGER_NETDEV_COLLISION in the enum led_trigger_netdev_modes.
>> Add its definition in Documentation.
>> Add its handling in ledtrig-netdev, it can only be supported by hardware
>> so no software fallback is implemented.
> How useful is collision? How did you test this? How did you cause
> collisions to see if the LED actually worked?
Indeed I am not able to generate collision on my setup so I did not test 
this
collision part.
My use case is that the hardware strap configuration that selects the 
LED output mode
can not be trusted so I have to force configuration with software. I 
added this collision
part because I wanted to cover all the LED configuration modes offered 
by the PHY.
> As far as i can see, this is just a normal 100Base-T PHY. Everybody
> uses that point-to-point nowadays. If it was an 100Base-T1, with a
> shared medium, good old CSMA/CD then collision might actually be
> useful.
>
> I also disagree with not having software fallback:
>
> ip -s link show eth0
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>      link/ether 80:ee:73:83:60:27 brd ff:ff:ff:ff:ff:ff
>      RX:     bytes    packets errors dropped  missed   mcast
>      4382213540983 2947876747      0       0       0  154890
>      TX:     bytes    packets errors dropped carrier collsns
>        18742773651  197507119      0       0       0       0
>
> collsns = 0. The information is there in a standard format. However,
> when did you last see it not 0?

Ok, I could add the software callback but I will not be able to test it ...


Best regards,
Bastien


