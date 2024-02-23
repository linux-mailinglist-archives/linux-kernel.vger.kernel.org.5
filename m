Return-Path: <linux-kernel+bounces-77853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36632860B08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2DD1C21F88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23220134C5;
	Fri, 23 Feb 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Mh4XFH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56200125C0;
	Fri, 23 Feb 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671499; cv=none; b=Dwv04//llHtxrIPpyJ0r5OfSiUGTRV0n4VerqXDxqRjMigZ6t4xse3FgGg2ZRQYXiolpikzp0mhq1IHHRUCSSh6ivTifoTxhONt1KhpY9iwbcVKWRN165Wu6dpCxwrd4/tn0TnT94dQaXQQVLQjIDeJ6Lap4lr5VgtpHPGpFk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671499; c=relaxed/simple;
	bh=lc/yt4IS94i/PggBesRtoUxeMb9Ge0+HWzjbnUyIH6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lmawm4Fvf9McEqRcBE21EoQQ+2uLifDqsBIiby228olRaxP4FH6QwMgkPJYndivtMfvXKeoxahykCy/R5KFmNadSbqEmacoygazsrY9hL6+cNxtyjMU43behyp2f/+RfiFxAHdPnZUudGkubsWjLRDRRZcLvyPfuHflKmZozjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Mh4XFH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso5179766b.1;
        Thu, 22 Feb 2024 22:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708671495; x=1709276295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PYQW8xk+KH0pSpx6H5KsMCXCe4+bWONQsAJOLW2+kE8=;
        b=K2Mh4XFH5Ma37ze/5c+jpQ+lJSPgFsg1zw1rLaNlUv/tflVBkzZUrgy22qhj2mIJxD
         p7+RbxE9C+3XndDxXOaUeMFT/L9YhVr2ShFs130XWu44l2h5H+JQpWlKdtlT18Qa99xs
         JCIGwBCL8/TeQFYRWI3ho0bazyPvEkLxp4VfqRwRqN8J40uJCu6SiuN/fDyR0Aqwuba/
         aqI7h47hcg0nHfxlsttlP/rPeULxpsqyR5TuGTwG4hbgFXN1I6fcmUJESC2yGBVLBJPf
         nOSkNJwTjyBxPSkZfpSDPRNgA5ffp7LPTP6+7QWVGQDU2rMFrRpReIFpBYEUlc1QKcMd
         3zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708671495; x=1709276295;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYQW8xk+KH0pSpx6H5KsMCXCe4+bWONQsAJOLW2+kE8=;
        b=iESNlUb1LLdoa7sGiwbiuEpi6uJSqrF4Y6B1BVWVbBXm2mGjdxh2SsfBfi0cLs5Q2b
         jTESYLjLWmTomHUVmjXDWvkRENNQ3igwezJtzcc7zBRJF8wF+/gMzYTGKtv81Se+zUpa
         LbUew5tVxbG+R4jwEIC+BFChqKPaGiPYWCV9snLtid/k8Iez6Q450yJS9uawLEUylRF/
         Teu5CBZNH5TgTsO4+HoKKT4xlkX20JpgqzlBDc4zCAlK/wNIhn3BpEdt5fMFnYI8mC5s
         rDFJ3djGmTtF8NP/GRXWEszaQmC1bYFmKKgxGfOq2BZc1IIhFq1/JqzjaouN9YS0oYru
         mZSw==
X-Forwarded-Encrypted: i=1; AJvYcCUvDSMizii33oJBOnrowNBhaxaCHu4Dzj1WcNdVOVxnm6pJ9nWGq/zeSDeoqfcmg8DbC1xdABPeGBfX99y/SFRnJBFeg58mKNDg+gfDjG2zAZ0nSDb2oJlrEyHGkUjgbgIu++pL
X-Gm-Message-State: AOJu0Yw+m2rHlHG/ydCMXzjWryuzK77t7i4tmankLKv3KX/OREwpc3oh
	LEwpALdCdEyQ8jOV4RutTtP86hA3qyu+/u1p5vm11zqQxthd5703
X-Google-Smtp-Source: AGHT+IFHpcJ55PGpgA8fFtoMt9eQSNpL1qLuU1a6ObwzIYK4/gHMGyh+NP9Qv20jXnV6y24WKoa5Xg==
X-Received: by 2002:a17:906:b789:b0:a3e:8bd8:b711 with SMTP id dt9-20020a170906b78900b00a3e8bd8b711mr908003ejb.37.1708671495353;
        Thu, 22 Feb 2024 22:58:15 -0800 (PST)
Received: from ?IPV6:2a01:c23:c403:8000:4442:2b24:9c18:44ef? (dynamic-2a01-0c23-c403-8000-4442-2b24-9c18-44ef.c23.pool.telefonica.de. [2a01:c23:c403:8000:4442:2b24:9c18:44ef])
        by smtp.googlemail.com with ESMTPSA id tj2-20020a170907c24200b00a3f480154a3sm2107724ejc.65.2024.02.22.22.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 22:58:14 -0800 (PST)
Message-ID: <4a43c21e-1ba9-4853-b2e2-8d2f5f8be464@gmail.com>
Date: Fri, 23 Feb 2024 07:58:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/8] net: phy: Add phydev->enable_tx_lpi to
 simplify adjust link callbacks
To: Wei Fang <wei.fang@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 dl-linux-imx <linux-imx@nxp.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-3-o.rempel@pengutronix.de>
 <AM5PR04MB3139BF92ABAE988EAD75088D88552@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <AM5PR04MB3139BF92ABAE988EAD75088D88552@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.02.2024 06:36, Wei Fang wrote:
>> -----Original Message-----
>> From: Oleksij Rempel <o.rempel@pengutronix.de>
>> Sent: 2024年2月21日 14:21
>> To: Wei Fang <wei.fang@nxp.com>; David S. Miller <davem@davemloft.net>;
>> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> Paolo Abeni <pabeni@redhat.com>; Andrew Lunn <andrew@lunn.ch>;
>> Heiner Kallweit <hkallweit1@gmail.com>; Russell King
>> <linux@armlinux.org.uk>
>> Cc: Florian Fainelli <florian.fainelli@broadcom.com>; Oleksij Rempel
>> <o.rempel@pengutronix.de>; kernel@pengutronix.de;
>> linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Shenwei Wang
>> <shenwei.wang@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
>> dl-linux-imx <linux-imx@nxp.com>
>> Subject: [PATCH net-next v5 2/8] net: phy: Add phydev->enable_tx_lpi to
>> simplify adjust link callbacks
>>
>> From: Andrew Lunn <andrew@lunn.ch>
>>
>> MAC drivers which support EEE need to know the results of the EEE auto-neg
>> in order to program the hardware to perform EEE or not.  The oddly named
>> phy_init_eee() can be used to determine this, it returns 0 if EEE should be
>> used, or a negative error code, e.g. -EOPPROTONOTSUPPORT if the PHY does
>> not support EEE or negotiate resulted in it not being used.
>>
>> However, many MAC drivers get this wrong. Add phydev->enable_tx_lpi
>> which indicates the result of the autoneg for EEE, including if EEE is
>> administratively disabled with ethtool. The MAC driver can then access this in
>> the same way as link speed and duplex in the adjust link callback. If
>> enable_tx_lpi is true, the MAC should send low power indications and does
>> not need to consider anything else with respect to EEE.
>>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>> v2 Check for errors from genphy_c45_eee_is_active
>> v5: Rename to enable_tx_lpi to fit better with phylink changes
>> ---
>>  drivers/net/phy/phy.c | 7 +++++++
>>  include/linux/phy.h   | 2 ++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c index
>> 14224e06d69f..a54b1daf5d5f 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -983,9 +983,16 @@ static int phy_check_link_status(struct phy_device
>> *phydev)
>>  	if (phydev->link && phydev->state != PHY_RUNNING) {
>>  		phy_check_downshift(phydev);
>>  		phydev->state = PHY_RUNNING;
>> +		err = genphy_c45_eee_is_active(phydev,
>> +					       NULL, NULL, NULL);
>> +		if (err < 0)
>> +			phydev->enable_tx_lpi = false;
>> +		else
>> +			phydev->enable_tx_lpi = err;
> 
> phydev->enable_tx_lpi = !!err; Is this better?
> 
I don't think so. Effectively err is a bool value, and it's implicitly
converted.

>>  		phy_link_up(phydev);
>>  	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
>>  		phydev->state = PHY_NOLINK;
>> +		phydev->enable_tx_lpi = false;
>>  		phy_link_down(phydev);
>>  	}
>>
>> diff --git a/include/linux/phy.h b/include/linux/phy.h index
>> e3ab2c347a59..a880f6d7170e 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -594,6 +594,7 @@ struct macsec_ops;
>>   * @supported_eee: supported PHY EEE linkmodes
>>   * @advertising_eee: Currently advertised EEE linkmodes
>>   * @eee_enabled: Flag indicating whether the EEE feature is enabled
>> + * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
>>   * @lp_advertising: Current link partner advertised linkmodes
>>   * @host_interfaces: PHY interface modes supported by host
>>   * @eee_broken_modes: Energy efficient ethernet modes which should be
>> prohibited @@ -713,6 +714,7 @@ struct phy_device {
>>
>>  	/* Energy efficient ethernet modes which should be prohibited */
>>  	u32 eee_broken_modes;
>> +	bool enable_tx_lpi;
>>
>>  #ifdef CONFIG_LED_TRIGGER_PHY
>>  	struct phy_led_trigger *phy_led_triggers;
>> --
>> 2.39.2
> 


