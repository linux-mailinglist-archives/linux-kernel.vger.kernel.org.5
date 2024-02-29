Return-Path: <linux-kernel+bounces-86232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20F86C27F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A61C22DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3645941;
	Thu, 29 Feb 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mfuTIlIr"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88D13D31F;
	Thu, 29 Feb 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191737; cv=none; b=VXGkASdW4o4EtFYhXTzwIDB79rKP0vYY1QEBKXjZOhVPR17yxlalCqdaoGeXWiUWwHnm62djkcGm7AKygFLIKyJ+3/k8twmQRtkuh0DwIWsIQU0sY7oT4oqCNA/InR7YMzOSezI/BysduJhWZFH5BWwI8FocBblOBGBow0vK+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191737; c=relaxed/simple;
	bh=BNbUtZKAY9WIJQ+LXoEoIqpg2tgwfPuz7uDBz6FAzlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRtq9MFjYhfmrjwUDpBkUsUIdaBIJa2fEpQVRkKHA4MjtAww/Eg09G+gXI44aHTSFwmxspyLYjY25egY9/8RJJHmXMjw38zbKbyZHlh8zm8Tc5vvQGgzekxF902iyjGQLCMn4FtdpV4jZ+2Vx3LdO3OSD3bVYou8rFwDQCIfUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mfuTIlIr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51BED60004;
	Thu, 29 Feb 2024 07:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709191733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSmjHPU1m34PxGjrak0OtXcvXk2Aj1aj+/aArU74NH8=;
	b=mfuTIlIrHoeLGjhtkzROtLXolPCsYl8Q6pj+XBnVlwTcPyoXhAYzh1V3caitDiGZKdP8kL
	hnquzy/52h9Rt7yeApOntnQhl9gtmQGdIFd5LhAm/eLVwiV3pgB5yRd9lI5OtRYw58CYiM
	YF/a+WsWjvBJXPZrg/I4goMIZJv2umuED+b4NARHs/1prFjIK0VsMfba9s3SOULe2mlRIv
	8YwdI2rXk2GTfV83E0SUPWlOIVmH9Tjt+Cz7/ENi4Pa8DEQbfYjg/C1ZcAaBTykut4bDnn
	1HQPuwQ+E9vclCYzqEVSNRQCacw50/MjJdWcFNEmHjaANefgOXNwytZyfQyj0g==
Message-ID: <1a6df254-a6fa-46bd-b28c-1c123e9689c4@bootlin.com>
Date: Thu, 29 Feb 2024 08:28:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] net: phy: DP83640: Add LED handling
Content-Language: en-US
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
 <20240227093945.21525-4-bastien.curutchet@bootlin.com>
 <9b06003c-afc9-419a-af36-7b81aab8517e@lunn.ch>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <9b06003c-afc9-419a-af36-7b81aab8517e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi

On 2/28/24 16:04, Andrew Lunn wrote:
>> +static int dp83640_led_brightness_set(struct phy_device *phydev, u8 index,
>> +				      enum led_brightness brightness)
>> +{
>> +	int val;
>> +
>> +	if (index > DP83640_SPDLED_IDX)
>> +		return -EINVAL;
>> +
>> +	phy_write(phydev, PAGESEL, 0);
>> +
>> +	val = phy_read(phydev, LEDCR) & ~DP83640_LED_DIS(index);
>> +	val |= DP83640_LED_DRV(index);
>> +	if (brightness)
>> +		val |= DP83640_LED_VAL(index);
>> +	else
>> +		val &= ~DP83640_LED_VAL(index);
>> +	phy_write(phydev, LEDCR, val);
> I don't understand this driver too well, but should this be using
> ext_read() and ext_write().
>
> I'm also woundering if it would be good to implement the .read_page
> and .write_page members in phy_driver and then use phy_write_paged()
> and phy_write_paged() and phy_modify_paged(), which should do better
> locking.
I don't feel comfortable implementing .read_page and write_page members 
as I have
only one PHY on my board so I'll not be able to test all the broadcast 
thing.

If that's OK with you, I'll use the ext_read() and ext_write()


Best regards,

Bastien


