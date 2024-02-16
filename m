Return-Path: <linux-kernel+bounces-69213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9788585D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14214289891
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE9135A46;
	Fri, 16 Feb 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck+WO+AD"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE351353F0;
	Fri, 16 Feb 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109577; cv=none; b=LR/zSg2JUUM1XyOjYzc++ILT/OsMVo2dcFAs7iTbn0oJ2mGUlTXEw+9IZENWD/+EJRGSgLpbJfezkH/eY+8mz7yLubiTaSZKKuqZjQLpKaiexrlCV/KrDcYbakqA+QzNBD2XP/C9YafJeWQ89X4+vV4LbR/G4xW9oBE4EpPQ5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109577; c=relaxed/simple;
	bh=3WkD8y+Hm2LbxjUUEU7dK0+hHpLtVVkdwRsfFhX61YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3wGLgyi4pKe838gzeFYXeka5PNy30fDqvB6wh6L7USV43gAfRHkX/HMz2t+kijZnnXvvrZpyKZfHTLwyzoYgmjwShu+YqmpE93gxwZTjCNMb1OMIbpGGeZ5QZ0+Te2OHCTz+wFfzYKI2DT1uW/kFAnMCSk251LZgW/WYY7ZoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck+WO+AD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42dc7ccabbaso8516851cf.0;
        Fri, 16 Feb 2024 10:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109575; x=1708714375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w66qiBcuO517k0fIfzU2tv5eomSTAcruHYKVEIiNz7U=;
        b=ck+WO+ADeEfG2y4BG7FocgevHgRR7k15rEZb9UQeOEMToSgNJplPszgHE4y691I2S5
         RxjQbK4Jjk8/icHfUJAfhxzPMzmDIzZ3Lwa0yZZYnk59UIe31BgpmIGW/tzPGrttTkGG
         oxxVX9iiAtmbIJOHJe+tEWKv5Gwl1poUhaf26Hdjb6gmTIpT2eA3I4M1bP+FASkuW4gg
         zRO1BxjPIGXFosXNaKOLzmpfxLd3Wv0Hhr4WLpprvMlUw14ajsZYbL/y30orxzqFORsg
         N5gULBcfbJPYR/Ccckx5QLvvqN+QMhq1BargarvnR4qvAfcP0HL6qUSe4E3vlSFspkXa
         pFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109575; x=1708714375;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w66qiBcuO517k0fIfzU2tv5eomSTAcruHYKVEIiNz7U=;
        b=ExF6rrxbjW2LA2bce1A23XjMZYyKYEVhyKfqcjPViT6WJSMNTsaNRd7mGV4KNN/LUZ
         xAfjEY7r8APMoTGv9StSKUP7f9xOojsFphySLa8OnSdjezcJscm4Z4l+6lV1akd+joFA
         pvhRfkI+iTw/QI17SFRf4JxLm4/EaVYsr1ETreAsuC8UFRW38S2ELu2DdX4BBLk+w4bH
         OyzieW/Y/YCJ8qJS7ckJSK6LHpPfUqAQ/H5R7Pt5gZfgA1SwJ7KvNOuc+Me3zPDGx5AX
         e/S4DyKGbpaJysksr1z3455qg6OiE4rJOfpvsFaSfOwxpFgCf3RFaufAwHX2Q5u0I+bf
         wMaA==
X-Forwarded-Encrypted: i=1; AJvYcCUpzWZyDZBHwPfWr7Fb96pe6EnZRZoo47ATuNcq/xS39PbvwpxGMN2Lo/zIQ5cde8Eel/4556Gf0JOb3OzgAh5w8bfc38S6fKeMM9Hjce/WGPn1lo9r0xGpuFnTCASe6S1aEFu2nha85lHqtaPL5bMF52CKlzYzEggnThr0gdbq
X-Gm-Message-State: AOJu0Yx8aVLf4lETrlj7SzeG+UNqtFO0eFOfxrvgqN/7fhilzXDsMrG5
	IEnX4uEkC+smtNfyrKYTmMJU2RPKgnuwaHgKJVA58xT+CpgqCPhT
X-Google-Smtp-Source: AGHT+IGi4/giR855KA+m+KaoReOo/3kdOIgybpIeUkxcyuMIxsIsRMDjoh4w3/EXWLQ6H6JRkjhOZQ==
X-Received: by 2002:ac8:5acb:0:b0:42c:74ef:8f82 with SMTP id d11-20020ac85acb000000b0042c74ef8f82mr6389156qtd.67.1708109574675;
        Fri, 16 Feb 2024 10:52:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e18-20020ac86712000000b0042c61b99f42sm183180qtp.46.2024.02.16.10.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:52:54 -0800 (PST)
Message-ID: <57a8160e-7f56-40b1-a69a-1fc56d8a79df@gmail.com>
Date: Fri, 16 Feb 2024 10:52:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY default
 timestamp to MAC
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
In-Reply-To: <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 07:52, Kory Maincent wrote:
> Change the API to select MAC default time stamping instead of the PHY.
> Indeed the PHY is closer to the wire therefore theoretically it has less
> delay than the MAC timestamping but the reality is different. Due to lower
> time stamping clock frequency, latency in the MDIO bus and no PHC hardware
> synchronization between different PHY, the PHY PTP is often less precise
> than the MAC. The exception is for PHY designed specially for PTP case but
> these devices are not very widespread. For not breaking the compatibility
> default_timestamp flag has been introduced in phy_device that is set by
> the phy driver to know we are using the old API behavior.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v5:
> - Extract the API change in this patch.
> - Rename whitelist to allowlist.
> - Set NETDEV_TIMESTAMPING in register_netdevice function.
> - Add software timestamping case description in ts_info.
> 
> Change in v6:
> - Replace the allowlist phy with a default_timestamp flag to know which
>    phy is using old API behavior.
> - Fix dereferenced of a possible null pointer.
> - Follow timestamping layer naming update.
> - Update timestamp default set between MAC and software.
> - Update ts_info returned in case of software timestamping.
> 
> Change in v8:
> - Reform the implementation to use a simple phy_is_default_hwtstamp helper
>    instead of saving the hwtstamp in the net_device struct.
> ---
>   drivers/net/phy/bcm-phy-ptp.c     |  3 +++
>   drivers/net/phy/dp83640.c         |  3 +++
>   drivers/net/phy/micrel.c          |  6 ++++++
>   drivers/net/phy/mscc/mscc_ptp.c   |  3 +++
>   drivers/net/phy/nxp-c45-tja11xx.c |  3 +++
>   include/linux/phy.h               | 17 +++++++++++++++++
>   net/core/dev_ioctl.c              |  8 +++-----
>   net/core/timestamping.c           | 10 ++++++++--
>   net/ethtool/common.c              |  2 +-
>   9 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
> index 617d384d4551..d3e825c951ee 100644
> --- a/drivers/net/phy/bcm-phy-ptp.c
> +++ b/drivers/net/phy/bcm-phy-ptp.c
> @@ -931,6 +931,9 @@ struct bcm_ptp_private *bcm_ptp_probe(struct phy_device *phydev)
>   		return ERR_CAST(clock);
>   	priv->ptp_clock = clock;
>   
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
> +
>   	priv->phydev = phydev;
>   	bcm_ptp_init(priv);
>   
> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
> index 5c42c47dc564..64fd1a109c0f 100644
> --- a/drivers/net/phy/dp83640.c
> +++ b/drivers/net/phy/dp83640.c
> @@ -1450,6 +1450,9 @@ static int dp83640_probe(struct phy_device *phydev)
>   	phydev->mii_ts = &dp83640->mii_ts;
>   	phydev->priv = dp83640;
>   
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
> +

This probably does not matter too much given that the mii_ts is not 
visible until we fully probed the PHY, though for consistency and to be 
on the safe side, it would be more prudent to set default_timestamp 
before finishing the mii_ts assignment, in case we ever become more 
aggressive at exposing objects to user-space/kernel-space. Probably over 
thinking this.

More comments below:

[snip]

>   
> -	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
> +	if (!skb->dev)
> +		return false;
> +
> +	if (!phy_is_default_hwtstamp(skb->dev->phydev))

Was not obvious that we could remove the phydev NULL check, but it's 
fine because phy_is_default_hwtstamp() calls phy_has_hwtstamp() first, 
and that function has that check. Seems a bit brittle, but fair enough.
-- 
Florian


