Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B9B778749
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjHKGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKGHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:07:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0F2722;
        Thu, 10 Aug 2023 23:07:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9a828c920so24902661fa.1;
        Thu, 10 Aug 2023 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691734032; x=1692338832;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bk+exM8X9S4Sq3L4XC4ctpy1FDaZFp/bRE9a4iozmw=;
        b=Y01wTSr/DoRbmIqKdYRW78ACJSxzyJbakuGLbhzDa1lmVlREwtW3tiMvb7Jp7Q/gPg
         QxOXdmls7Im/6TQ9IkKhhefuxLlq6IARWRQ4yLpFylIKsdYb7smChXhW+i6C6nRS5XuW
         I3II8X6IEB92dCL75R65+mmlnZlzx8HAC9MIW6Zy0isOl4hjFej+McYANsu3DzulM6Zy
         f8SYcxCwwZB5csnGb7aqyisOo1zTCZ2zaWZxpFEdzC6UFUKGlq7N9TVEjh70NyWx8pX5
         aPHh06gQEVWIGYOkILYsIXwiVxnHxrRjR36FR4WdXw3ibVZVAxyY+FwOXgRUmLoYSaer
         OpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734032; x=1692338832;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bk+exM8X9S4Sq3L4XC4ctpy1FDaZFp/bRE9a4iozmw=;
        b=hF9SxdV0SyanBRUJKV5PjQPmHT9hNwMYY/+zx/KBnsHbMT5Qmsu1iPMylMD7+4WG2U
         tLZ90NOAY8c+D5NuVS8btID/ZSfkZx7DFtolFl6xAck0ET/2c5NchQMeB8XObXqxRfQJ
         F+ND6/m0g3q3ojA2lYa9b8IjNPWCH1HDK98Wv3N+SuI6uaCTCeDWLPNlQF6QmM9DezXG
         hyy0bwHW04tTEFHfXX0QRRPL8MXHvJKrhaMv9q2Dtl31Hn3EdhfmBxJHn4Ra+5tg/c5E
         zV1lvx9Djehd2iyXq0VM2syk+yfYCfpUBHf/anucOzgWms8UR/RVCdlwMCleY+bAXA+x
         Ms8A==
X-Gm-Message-State: AOJu0Yxku77Gk9UxoTp2VZ6+r2UzaVQTZ7HQ4GrmgOhC/pXlyNXQ+axj
        c4AI8+mlYAUJzI0Fnrb4GS0=
X-Google-Smtp-Source: AGHT+IEDJkq9L72dxkIvJYXHWt0S/ObKGtluYL52BnMKo73cLNHOz1YKohCZoSVoQZXhj4QPxSohZQ==
X-Received: by 2002:a2e:3c0e:0:b0:2b9:e7d7:64bd with SMTP id j14-20020a2e3c0e000000b002b9e7d764bdmr733901lja.47.1691734031793;
        Thu, 10 Aug 2023 23:07:11 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9036:1900:752a:2ca1:e48c:43a7? (dynamic-2a02-3100-9036-1900-752a-2ca1-e48c-43a7.310.pool.telefonica.de. [2a02:3100:9036:1900:752a:2ca1:e48c:43a7])
        by smtp.googlemail.com with ESMTPSA id s7-20020adfecc7000000b0031912c0ffebsm3542748wro.23.2023.08.10.23.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 23:07:11 -0700 (PDT)
Message-ID: <2cdc67aa-6029-7231-76a8-54c6b51b066c@gmail.com>
Date:   Fri, 11 Aug 2023 08:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     Luke Lu <luke.lu@libre.computer>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
References: <20230809214946.18975-1-luke.lu@libre.computer>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v4] net: phy: meson-gxl: implement
 meson_gxl_phy_resume()
In-Reply-To: <20230809214946.18975-1-luke.lu@libre.computer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2023 23:49, Luke Lu wrote:
> From: Da Xue <da@libre.computer>
> 
> While testing the suspend/resume function, we found the ethernet
> is broken if using internal PHY of Amlogic meson GXL SoC.
> After system resume back, the ethernet is down, no carrier found.
> 
> 	eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> 		DOWN group default qlen 1000
> 
> In this patch, we re-initialize the internal PHY to fix this problem.
> 

It's not an unusual case that system cuts power to the PHY during
system suspend. So the PHY needs to be re-initialized on resume.
That's why we call phy_init_hw() in mdio_bus_phy_resume().

If going your way we would be better off calling .config_init()
in genphy_resume(). Please check the MAC driver, maybe it's better
to re-initialize the PHY in the resume path of the MAC driver.

> 	eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> 		group default qlen 1000
> 
> Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")
> Signed-off-by: Da Xue <da@libre.computer>
> Signed-off-by: Luke Lu <luke.lu@libre.computer>
> 
> ---
> Note, we don't Cc stable kernel tree in this patch intentionally, since
> there will be a cherry-pick failure if apply this patch from kernel version
> less than v6.2, it's not a logic failure but due to the changes too close.
> 
> Please check commit 69ff53e4a4c9 ("net: phy: meson-gxl: use MMD access dummy stubs for GXL, internal PHY")
> We plan to slightly rework the patch, and send it to stable tree separately
> once this patch is accepted into mainline.
> 
> v4:
>  - refactor commit message to better explain the problem & fix
>  - check return value of genphy_resume()
>  - add 'net' annotation
>  - add Fixes tag
> 
> v3: https://lore.kernel.org/netdev/20230808050016.1911447-1-da@libre.computer
>  - fix missing parameter of genphy_resume()
> 
> v2: https://lore.kernel.org/netdev/20230804201903.1303713-1-da@libre.computer
>  - call generic genphy_resume()
> 
> v1: https://lore.kernel.org/all/CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com
> ---
>  drivers/net/phy/meson-gxl.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index bb9b33b6bce2..9ebe09b0cd8c 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -132,6 +132,21 @@ static int meson_gxl_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int meson_gxl_phy_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_resume(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = meson_gxl_config_init(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /* This function is provided to cope with the possible failures of this phy
>   * during aneg process. When aneg fails, the PHY reports that aneg is done
>   * but the value found in MII_LPA is wrong:
> @@ -196,7 +211,7 @@ static struct phy_driver meson_gxl_phy[] = {
>  		.config_intr	= smsc_phy_config_intr,
>  		.handle_interrupt = smsc_phy_handle_interrupt,
>  		.suspend        = genphy_suspend,
> -		.resume         = genphy_resume,
> +		.resume         = meson_gxl_phy_resume,
>  		.read_mmd	= genphy_read_mmd_unsupported,
>  		.write_mmd	= genphy_write_mmd_unsupported,
>  	}, {

