Return-Path: <linux-kernel+bounces-77768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F5860A02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4321F235B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8711706;
	Fri, 23 Feb 2024 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVLc+QRb"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC91119E;
	Fri, 23 Feb 2024 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663898; cv=none; b=Wx3ePlly8YxYZ9hd6MDVX8tPeA2Vt3JIx2FwLRbc6cRlTvw2zGNyq5naPLX/7NQCwHEFgf+GlwRgObHrYUD/sEUiiNbiDEh/fx8y1nbfweNhKAgFeGTzyKc/BW04/rG6IMNRvd6oE00hUUBZzEYVwnZuF8hSfdHR+e89ChxO92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663898; c=relaxed/simple;
	bh=WpZgxRWc3wAmq+d6+4bjJvvI0kreM0RJjYmJMz355nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjlypb/yKA05I7NjI9MHy+e9SQ9q1kQ1RQ4p/hGfw9HXe9h1hbhyPA+uz5LOc8TJbTbOXYlMCcin6wNzWUYxH1e4ap94J86BMAr3sDTSzjHmdGFUHQm/OpjvN7bVJXM/p6SjL5EfiLZ3U4S1whNlvkC+tj1jJt358CyISNfrv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVLc+QRb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68facd7ea4bso2248326d6.0;
        Thu, 22 Feb 2024 20:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708663895; x=1709268695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwS5WBBcqvq1/ZN9IhwTyGP1bYKqILTox2fPA4BOLCY=;
        b=HVLc+QRblmZe7dRrvOj4noaTKxJRmGF6x/Ho9JF8FOes4RLfUl+/J6a2xLZZPa5+pt
         3ZX0lwDJloZEUxL0HrXI7RTWjkjAMOfr49FHRUQkp2nn2yXcPNqaYeNM+OmRzkcDZQ1y
         ddDMcVyZQJG1XMGrqni//bMcsl0DhSTRgKI45B0OF9mRrRXa4iG8r9kddpOB5QqIWpqU
         KYHGymrcYbFd6NaTdWj/vzas1/EthncvXHDQs81Fm+EMXQWAi+QVOjYCF4uJo6hoVx/n
         gAwUQezB+Vh53z4KdGhXX/lNsPl9iCTdp7BmRGbBv53/ji4puTqTKM/slUFaSCtosq+G
         b/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663895; x=1709268695;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwS5WBBcqvq1/ZN9IhwTyGP1bYKqILTox2fPA4BOLCY=;
        b=KUjy109Ids1L+R4DK+XN3Bb+9wp28F34gKZCebdbtPXxosuOyqiR1jotu2bA2TlMio
         RrX5zFw8e0Sa2KIAb3C+EekT3qnohYPUPdapy1K8RLks3sJ7ofB95J1en14KErc9ugri
         QkASf8RJSupSwFluAQduN5tg135CJ6AvMc7UouCGXXw2Y9zwARL5+4wllJOK3eqgWuAR
         ZalJAbZpfqLvr4jDFdcLPtdz5ZpF1dXzVyEoi63zuSUGYA8C2lq4qWitdDDDTHR4gYjI
         w20z1rF7TR1+gEnCrUif/0ZrbVvm+5ZPptGykfXqQoIO/bIh06WVU9KTI3Z/gEb75kxO
         NBNA==
X-Forwarded-Encrypted: i=1; AJvYcCXFeyk6rrc5Y2ZVEvbB2fcaaTzqzTK4M6aJhPdzroUhlFY5QGX2E7+aRyKf556wbKM3qv/gOxQR9+hxH/rLxJmI1gCXR/n+uZR16TLJBtcKb3iV2ey4Wvx0PQc1XuS9rIF0L579
X-Gm-Message-State: AOJu0YyTKpafMScLya/u9GS3N8Q4PQ1YpsjbFF3f1cJbMeEqxDEJUmvp
	iGaykZtZpcYoONeKcg33WgDuGtNfewXDhbQ7CQc6y3AcXsLsb0HhiQ/jBi+rjcQ=
X-Google-Smtp-Source: AGHT+IG1HIJ/NS4X2wQ0yHBPhBW+VdZBn5osbJJmTuG8cgPIHFDPqgh5d7a368g2oNwDjTgLReXhmQ==
X-Received: by 2002:a05:6214:e65:b0:68f:1bd9:f6d5 with SMTP id jz5-20020a0562140e6500b0068f1bd9f6d5mr1239079qvb.16.1708663895568;
        Thu, 22 Feb 2024 20:51:35 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id ol10-20020a0562143d0a00b0068f0ff36defsm3192165qvb.47.2024.02.22.20.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 20:51:35 -0800 (PST)
Message-ID: <693c8801-498d-42e0-bb4e-8a5bc07d9131@gmail.com>
Date: Thu, 22 Feb 2024 20:51:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/8] net: phy: Immediately call adjust_link if
 only tx_lpi_enabled changes
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-6-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240221062107.778661-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The MAC driver changes its EEE hardware configuration in its
> adjust_link callback. This is called when auto-neg
> completes. Disabling EEE via eee_enabled false will trigger an
> autoneg, and as a result the adjust_link callback will be called with
> phydev->enable_tx_lpi set to false. Similarly, eee_enabled set to true
> and with a change of advertised link modes will result in a new
> autoneg, and a call the adjust_link call.
> 
> If set_eee is called with only a change to tx_lpi_enabled which does
> not trigger an auto-neg, it is necessary to call the adjust_link
> callback so that the MAC is reconfigured to take this change into
> account.
> 
> When setting phydev->enable_tx_lpi, take both eee_enabled and
> tx_lpi_enabled into account, so the MAC drivers just needs to act on
> phydev->enable_tx_lpi and not the whole EEE configuration.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Definitively an improvement! Minor nits below

> ---
>   drivers/net/phy/phy-c45.c | 11 ++++++++---
>   drivers/net/phy/phy.c     | 25 ++++++++++++++++++++++---
>   2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index c69568e7695e..217d4df59eb6 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1549,6 +1549,8 @@ EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
>    * advertised, but the previously advertised link modes are
>    * retained. This allows EEE to be enabled/disabled in a
>    * non-destructive way.
> + * Returns either error code, 0 if there was no change, or positive
> + * value if there was a change which triggered auto-neg.
>    */
>   int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
>   			       struct ethtool_keee *data)
> @@ -1580,9 +1582,12 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
>   	ret = genphy_c45_an_config_eee_aneg(phydev);
>   	if (ret < 0)
>   		return ret;
> -	if (ret > 0)
> -		return phy_restart_aneg(phydev);
> -
> +	if (ret > 0) {
> +		ret = phy_restart_aneg(phydev);
> +		if (ret < 0)
> +			return ret;
> +		return 1;
> +	}
>   	return 0;
>   }
>   EXPORT_SYMBOL(genphy_c45_ethtool_set_eee);
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 7f3629d56503..dad827717ad9 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -988,7 +988,8 @@ static int phy_check_link_status(struct phy_device *phydev)
>   		if (err < 0)
>   			phydev->enable_tx_lpi = false;
>   		else
> -			phydev->enable_tx_lpi = err;
> +			phydev->enable_tx_lpi = (err & phydev->eee_cfg.tx_lpi_enabled);
> +
>   		phy_link_up(phydev);
>   	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
>   		phydev->state = PHY_NOLINK;
> @@ -1679,6 +1680,21 @@ int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
>   }
>   EXPORT_SYMBOL(phy_ethtool_get_eee);
>   
> +/* auto-neg not triggered, directly inform the MAC if something
> + * changed'

Stray ' character at the end here.

> + */
> +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> +				      struct ethtool_keee *data)
> +{
> +	if (phydev->eee_cfg.tx_lpi_enabled !=
> +	    data->tx_lpi_enabled) {
> +		eee_to_eeecfg(data, &phydev->eee_cfg);
> +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> +		if (phydev->link)
> +			phy_link_up(phydev);
> +	}
> +}
> +
>   /**
>    * phy_ethtool_set_eee - set EEE supported and status
>    * @phydev: target phy_device struct
> @@ -1695,11 +1711,14 @@ int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
>   
>   	mutex_lock(&phydev->lock);
>   	ret = genphy_c45_ethtool_set_eee(phydev, data);
> -	if (!ret)
> +	if (ret >= 0) {
> +		if (ret == 0)
> +			phy_ethtool_set_eee_noneg(phydev, data);
>   		eee_to_eeecfg(data, &phydev->eee_cfg);
> +	}
>   	mutex_unlock(&phydev->lock);
>   
> -	return ret;
> +	return (ret < 0 ? ret : 0);

Don't think the parenthesis are needed but does not hurt.
-- 
Florian

