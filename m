Return-Path: <linux-kernel+bounces-89533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE486F1A8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9A12826BA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6572BB0E;
	Sat,  2 Mar 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwCFKXBG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3C179BC;
	Sat,  2 Mar 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399798; cv=none; b=OSMlrhwIMNOfuLolJGbJPPnGvurtA2teEeY71zsk3iu8b0ZJXwFhBj0VP5VpqxZfLJqX+neIkunPuXp3hXq/dWSM6ynN1Grv8NfzUKPQlk7k3I0guGRlg3/QPcLoZT2vkSzauiIhA7Yjs226vUxHbU7ejhoPINrdBKF7nQ3Gj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399798; c=relaxed/simple;
	bh=yBjY3JSl4IOl2UTzOywctObflyTyGu87JynUATyH+tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeSfFH9f209sGQCcJDDzKNNFtLnDMxtpMvs1/Ps/2W7l7GOrk8TbWnz3476HoTIQ+tSaQln6/+fVLtoBY9ckWGHEHGLfAsFgxo6pa9qCHAIqn+uKm5f1yXsn4UTkTKLCiqOSrsez5pa8/g1IY8R+H3ydK7wmpDSQMLWP/xLndjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwCFKXBG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a446478b04bso331772666b.3;
        Sat, 02 Mar 2024 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709399795; x=1710004595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lv0buQgrg7icZpPZBpZ8bSE5jLKg1wK3LvErR9m8Xvw=;
        b=UwCFKXBG3COBuDfDbOWiK4raDrl8orif+mf072BdYhIHo9ug06ZpHatk0t9PZYZpmy
         Vjg6XWdWrRLM1hc4awzncIL82bjelUHasdjWyBdRHADqX2KJDtYK5gyYDthxPFIDp15K
         hUfz3di2KckYfLVV4CTu9for4G+Z9mzF9pRsBAWwvKinZ6FxyLFw7HuMi52xcF1kg1n0
         do3suu8yENBlSF3pEp2yhrqbH2HQ3AfEyM0E607Txke8uGesZPaZHhGL0scWSccB2MXK
         xXkl6Fb5kGVcBjextbcgIWGNPDqL8mo1IqbWYTnNFepwb2FXeByl6f9+uqN4GPRyX2T6
         FMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399795; x=1710004595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lv0buQgrg7icZpPZBpZ8bSE5jLKg1wK3LvErR9m8Xvw=;
        b=dt8fwj4Fm6Hp4jLtsTtTrn/i0fHJXrgQ1Nv5/PJ3mVpjgQcN6VsOz/LCGGfuRXWCx3
         8d4jX8Vangrg0TWbabHCkjKokU9BA5XppBUG1PNfBcAYoR8zjIfcK4p9igKtZVOFYlif
         FwC9tKYhuG7xvHy8irgTqPWoWdBxzQXmUFtG1bR3K35reLoITJC0AQ5ygLfGTrnh6duf
         l8E3QnPs/3eQgaSyXr938dAMe4DscFx7VXNhIH0BnjwvW+dnr+W0hhNWAX/YETKlCGvY
         CR81plhzseBw4Be1JDdHHYVvX5cHFEkLaGpAXn2gxpOXDZz46QGrtO/jICIGgpN2+56+
         LWQg==
X-Forwarded-Encrypted: i=1; AJvYcCXKkm1fReMuBEZ7kOJaw7pKCBEHkPrZUE31mCi9d/ZIhDmBilTPTOtj2+z9AuBtzE/YbZLwA1/Lw8aSbvrSfCW7q3qOVxyZVpoS3WAkPx3dHKRaJYmUTngIOahaIAl09mm57x4W
X-Gm-Message-State: AOJu0YxMsszWrIRvoELl8tiOOAe8NCZsT1IegJqp2lkESNoezYBAWDyf
	3DwLwWVqhbjayOlgk9gtWqAodivrZIKTDCvtefxL/82qsHpHcGsw
X-Google-Smtp-Source: AGHT+IELaML4iBu+K3taes6vp8ZfRvywkraVH9g+I+tW5Y3zsaC2cUQkzxhlsTSFf1pC1Y1+Xiv18g==
X-Received: by 2002:a17:906:4885:b0:a44:f225:d6cf with SMTP id v5-20020a170906488500b00a44f225d6cfmr861856ejq.33.1709399795328;
        Sat, 02 Mar 2024 09:16:35 -0800 (PST)
Received: from ?IPV6:2a01:c23:bcce:a400:2519:2036:7f0:6005? (dynamic-2a01-0c23-bcce-a400-2519-2036-07f0-6005.c23.pool.telefonica.de. [2a01:c23:bcce:a400:2519:2036:7f0:6005])
        by smtp.googlemail.com with ESMTPSA id tj7-20020a170907c24700b00a413d1eda4bsm2891305ejc.87.2024.03.02.09.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 09:16:34 -0800 (PST)
Message-ID: <d550b591-cd83-4ac6-8fd5-f5e0e2ad71d9@gmail.com>
Date: Sat, 2 Mar 2024 18:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/8] net: phy: Add helper to set EEE Clock
 stop enable bit
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
 <20240301100153.927743-4-o.rempel@pengutronix.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240301100153.927743-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.03.2024 11:01, Oleksij Rempel wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The MAC driver can request that the PHY stops the clock during EEE
> LPI. This has normally been does as part of phy_init_eee(), however
> that function is overly complex and often wrongly used. Add a
> standalone helper, to aid removing phy_init_eee().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/phy.c | 20 ++++++++++++++++++++
>  include/linux/phy.h   |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 2bc0a7d51c63f..ab18b0d9beb47 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1579,6 +1579,26 @@ void phy_mac_interrupt(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL(phy_mac_interrupt);
>  
> +/**
> + * phy_eee_clk_stop_enable - Clock should stop during LIP
> + * @phydev: target phy_device struct
> + *
> + * Description: Program the MMD register 3.0 setting the "Clock stop enable"
> + * bit.
> + */
> +int phy_eee_clk_stop_enable(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	mutex_lock(&phydev->lock);
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
> +			       MDIO_PCS_CTRL1_CLKSTOP_EN);
> +	mutex_unlock(&phydev->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_eee_clk_stop_enable);
> +
I don't see a user of this function in the series.
Based on the commit description, wouldn't it be better to
make this patch part of a future series removing
phy_init_eee()?

>  /**
>   * phy_init_eee - init and check the EEE feature
>   * @phydev: target phy_device struct
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index a880f6d7170ea..432c561f58098 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1995,6 +1995,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
>  int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
>  
>  int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
> +int phy_eee_clk_stop_enable(struct phy_device *phydev);
>  int phy_get_eee_err(struct phy_device *phydev);
>  int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
>  int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data);


