Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA707BEC5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378651AbjJIVJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378168AbjJIVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:09:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E0A93;
        Mon,  9 Oct 2023 14:09:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77432add7caso284567585a.2;
        Mon, 09 Oct 2023 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885773; x=1697490573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouDqE5xqHuiZG4IdJK2v7hAXQoZnKygwFe+kQFd7jI4=;
        b=j6VkUMYiuqTPFhoxsd8GuPhDp9I2aFWap6fTTFyBqC6xZXzOnCIpzNFJT0nw17j73+
         8QaovckyTY3ba3cPcBnvT67UtY6RK367eXiqUAzBqabJH9xa53ws9MqjbsDQFeH7VXX2
         CKVPmFl8Jm2oiaSlz80FM7bppA+q+Wucf9VD0RFXEbnfI6GZf6wEm34A5qYIViM59bq0
         TmQ//fwx1GuuA9n3hj2tveu6NuWdis/sC7DKLiWVdd+t/FlORQZgd6IVervZ1rrGboby
         vDM/WXCUTzwiEoLt0w1SYCls1x0SglesxyeKW5x5Wwnzp6p0Bir3Tt6+whhKVifo2c5R
         b9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885773; x=1697490573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouDqE5xqHuiZG4IdJK2v7hAXQoZnKygwFe+kQFd7jI4=;
        b=bFeOCvx5n4r3D+8JiQvnukQE8/JvWYGQeIyKtHPISlGkL4lvV1ExakdKKZrUHZsgax
         5uwfdaHqr2fKMmN4NbZhdRcydMOO2OLmqXkMBG7vGulSWWzXoevGoy7Yj//pLzaq/EjP
         ZhVqIqHrhSJjSatRsxW3InhzdtKzkBnCl1VBNhVlm4+9+We3OzYRWMIXHZzBRxsHeoHL
         JWVjNwCEsTKvbasvY7U61JFNTaxwL3Dsf/tgU/UQGi110G5xEcvTudrUKwM7SHvxGX4a
         /yFk8GQiUyeWXhxo1cucr37GL8xlwY8LeHz+QhnviiOYU8Il8p5QZNDcdEaVyiT4gkFL
         2XrA==
X-Gm-Message-State: AOJu0Yy+VcigBCqOQ/2AwRfXAmnFybEtHXJlBfPGooLkNoU+yxbjeiPy
        OhNw5cSvq2xotoeASciXne8=
X-Google-Smtp-Source: AGHT+IFNpbLVvI8bkPaXK3gRdNxJnMA/nM6IOrgnUIwPs0AThT71A4bdGQwGwjblNT+oFghYGljXUA==
X-Received: by 2002:a05:622a:1495:b0:417:b269:4689 with SMTP id t21-20020a05622a149500b00417b2694689mr17801086qtx.53.1696885772740;
        Mon, 09 Oct 2023 14:09:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k24-20020ac84758000000b004199f47ccdbsm3956048qtp.51.2023.10.09.14.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:09:31 -0700 (PDT)
Message-ID: <57791a7d-04ce-4d02-815d-7f540ea15b89@gmail.com>
Date:   Mon, 9 Oct 2023 14:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 05/16] net: Make dev_set_hwtstamp_phylib
 accessible
Content-Language: en-US
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-6-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-6-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 08:51, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Make the dev_set_hwtstamp_phylib function accessible in prevision to use
> it from ethtool to reset the tstamp current configuration.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>   include/linux/netdevice.h | 3 +++
>   net/core/dev_ioctl.c      | 6 +++---
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e070a4540fba..b9d0411836db 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3922,6 +3922,9 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
>   int generic_hwtstamp_set_lower(struct net_device *dev,
>   			       struct kernel_hwtstamp_config *kernel_cfg,
>   			       struct netlink_ext_ack *extack);
> +int dev_set_hwtstamp_phylib(struct net_device *dev,
> +			    struct kernel_hwtstamp_config *cfg,
> +			    struct netlink_ext_ack *extack);
>   int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
>   unsigned int dev_get_flags(const struct net_device *);
>   int __dev_change_flags(struct net_device *dev, unsigned int flags,
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index b46aedc36939..342a667858ac 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -322,9 +322,9 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
>    * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
>    * dev->priv_flags.
>    */
> -static int dev_set_hwtstamp_phylib(struct net_device *dev,
> -				   struct kernel_hwtstamp_config *cfg,
> -				   struct netlink_ext_ack *extack)
> +int dev_set_hwtstamp_phylib(struct net_device *dev,
> +			    struct kernel_hwtstamp_config *cfg,
> +			    struct netlink_ext_ack *extack)
>   {
>   	const struct net_device_ops *ops = dev->netdev_ops;
>   	bool phy_ts = phy_has_hwtstamp(dev->phydev);

Missing EXPORT_SYMBOL_GPL() here?
-- 
Florian

