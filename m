Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F07C85C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJMM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjJMM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:26:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800DA9;
        Fri, 13 Oct 2023 05:26:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2cee55056so355381166b.3;
        Fri, 13 Oct 2023 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697200009; x=1697804809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLZmmyB23MqsL0YjH6h472p8+DxkcdVuoOt1/sODOZc=;
        b=EFYwKLMUfDAzV9glu4To+eYNscNFP7n9D8IUUymp1p5Cewtas0kktO9ELKOAGuRA6F
         UFgCmhYDhqz2+7i9nc4/yzF7/GPeu6qSPBMdEWtec0c9Ki5sSD5aPjkpQ8Vrh/Dw3XGb
         4nZ+nIG+Y08vCIAK/DHIx86+D0v8zZYLAKDbehVWmCZO+Yet7mNFmJBAST1e59HlTRsN
         7zi0x/ZgLRQR0y06DKVUTfTuhOK/be6jOjlaVtcjBMlPWnlLAqzJzbquL/CJiRlNjFSb
         NcKQRpM3dmojmd9HIUsSezQin8UYp77Q/J/XWlAarXTv7VHc1pyACkEGM62D+4oKf3oA
         hAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697200009; x=1697804809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLZmmyB23MqsL0YjH6h472p8+DxkcdVuoOt1/sODOZc=;
        b=H73htvNZ0g7HKXRab1q9muG7k20vpcnumIuzOaXG/vm4WdGakMce5MtXaIPfGZFFk4
         Py4jN8KZ1F3OGekfrCRcZ7b4NaHHvceT16KaTWx3Q2/koJXdZdZm149Cq1UWbUesqAxB
         GsACIJXQjdanEVYQrrG2zg8KygWFGu4CQrDsuBsX4S8UbHPUseX9cOzluozdzD2liWSZ
         IRloAuElDfIRGW/EMdg59rBvFl5kJsVMUGutcvHPAgGSEIj4cSvotjQ27jS7RqFivvzF
         dEOz9aWic7Xs2fnJ0z0j8kllGtaCmgKzVKaVK0drQHKOpzwQMo1JYvwV9HM7DNDv0v4H
         G06Q==
X-Gm-Message-State: AOJu0Yx1r19FReET1maUfL9irJ6xT0A1ZW1KdtIuGfr8fdFpSijaLDtd
        SZbikerieGIZY73YanWrtEk=
X-Google-Smtp-Source: AGHT+IHLPuKBe8o7zFbZZBjsJAyNSnbAzqcspW1Zwm7xATl+IJe7o9ZwnUrVoA92KqYL4kfjcniG1A==
X-Received: by 2002:a17:906:3188:b0:9ae:594d:d3fc with SMTP id 8-20020a170906318800b009ae594dd3fcmr21526526ejy.17.1697200008980;
        Fri, 13 Oct 2023 05:26:48 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709065fd200b009adc7733f98sm12361031ejv.97.2023.10.13.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:26:48 -0700 (PDT)
Date:   Fri, 13 Oct 2023 15:26:46 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Message-ID: <20231013122646.bjiy6soo3pdquk53@skbuf>
References: <20231012065502.2928220-1-o.rempel@pengutronix.de>
 <20231012065502.2928220-1-o.rempel@pengutronix.de>
 <20231012065502.2928220-4-o.rempel@pengutronix.de>
 <20231012065502.2928220-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012065502.2928220-4-o.rempel@pengutronix.de>
 <20231012065502.2928220-4-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

On Thu, Oct 12, 2023 at 08:55:02AM +0200, Oleksij Rempel wrote:
> Address a link speed detection issue in KSZ886X PHY driver when in
> forced link mode. Previously, link partners like "ASIX AX88772B"
> with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.
> 
> The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
> even with autonegotiation off, misleading link partners in autoneg mode,
> leading to incorrect link speed detection.
> 
> Now, when autonegotiation is disabled, the driver sets the link state
> forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
> disabling autonegotiation, makes the PHY state more reliably detected by
> link partners using parallel detection, thus fixing the link speed
> misconfiguration.
> 
> With autonegotiation enabled, link state is not forced, allowing proper
> autonegotiation process participation.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Have you considered denying "ethtool -s swpN autoneg off" in "net.git"
(considering that it doesn't work properly), and re-enabling it in
"net-next.git"?

>  drivers/net/phy/micrel.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 927d3d54658e..599ebf54fafe 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1729,9 +1729,35 @@ static int ksz886x_config_aneg(struct phy_device *phydev)
>  {
>  	int ret;
>  
> -	ret = genphy_config_aneg(phydev);
> -	if (ret)
> -		return ret;
> +	if (phydev->autoneg != AUTONEG_ENABLE) {
> +		ret = genphy_setup_forced(phydev);
> +		if (ret)
> +			return ret;

__genphy_config_aneg() will call genphy_setup_forced() as appropriate,
and additionally it will resync the master-slave resolution to a forced
value, if needed. So I think it's better to call genphy_config_aneg()
from the common code path, and just use the "if (phydev->autoneg)" test
to keep the vendor-specific register in sync with the autoneg setting.

> +
> +		/* When autonegotation is disabled, we need to manually force
> +		 * the link state. If we don't do this, the PHY will keep
> +		 * sending Fast Link Pulses (FLPs) which are part of the
> +		 * autonegotiation process. This is not desired when
> +		 * autonegotiation is off.
> +		 */
> +		ret = phy_set_bits(phydev, MII_KSZPHY_CTRL,
> +				   KSZ886X_CTRL_FORCE_LINK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* If we had previously forced the link state, we need to
> +		 * clear KSZ886X_CTRL_FORCE_LINK bit now. Otherwise, the PHY
> +		 * will not perform autonegotiation.
> +		 */
> +		ret = phy_clear_bits(phydev, MII_KSZPHY_CTRL,
> +				     KSZ886X_CTRL_FORCE_LINK);
> +		if (ret)
> +			return ret;
> +
> +		ret = genphy_config_aneg(phydev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* The MDI-X configuration is automatically changed by the PHY after
>  	 * switching from autoneg off to on. So, take MDI-X configuration under
> -- 
> 2.39.2
> 

