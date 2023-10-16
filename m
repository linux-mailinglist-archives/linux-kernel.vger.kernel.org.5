Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18B7CA539
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjJPKXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjJPKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:23:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537CEE;
        Mon, 16 Oct 2023 03:22:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso672913366b.0;
        Mon, 16 Oct 2023 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697451777; x=1698056577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfJWdslS3Yal/mqU3hhH87VKZdvRShl/Pe/cybkKHWg=;
        b=TmcEhI906+Az0MSXct6z8ZR0aZPeGZfNxbs4iJARuzoErFLIpLJ9XLYHMDZ6XvhYD0
         PBCSK/MAFUqHfmJWVnlSDGkNyM0St+6S95Bh/AsHJVd0FQaENIghm5zP4M1CmSc7XMZn
         19Jp1Tob/ZQUkaF1nuwJiMXQlT2czT0+hmL5qWhX9dgjzAup77i+BK8OsZfi7UDI1wf7
         9iTSYrUsD+ugvqBLblEQBUHJ95/RU412QaQdJaawB9tkSCPoOSvtRJhkGzA2xY7xW876
         /T4QCJKN7wbXHL3KOpGPeuZA+FkhiBt2+DRKGAcIdCd7lN3JnAYSMRxZvhPDShfbJWZi
         6YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451777; x=1698056577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfJWdslS3Yal/mqU3hhH87VKZdvRShl/Pe/cybkKHWg=;
        b=LKQNn9iqE/9d2YYTzsKmj39EnTfKAdK8Sj/ereNEGOhBKJRL5B48ajEoiSczF0NRlr
         6sm/Pt5eD8yMzAzzxKRPEO1LKT0bZHrNO+Apg+rMbN63xXS42lUCjT3skRLAg0CVrzmu
         UmKKpE3X4DolnBHfVUTTPwcQlOgyYaJtTGgBboSbSVLuPfRp3fxaoxsBHEQomUJYMGxU
         TI3ixmkzhm4IcSQ44rZKJME6vN5w/0D1Ql3x0rvGeFWf4JXe9Y2aJKldHYfDP1VUQfDf
         KexZSlR5PS1etwU1VnZC+ppkO3HDlx2QJ2SedMPEeRAsufHRJ2OLkHRHxLANH6EUqaHo
         0Uqg==
X-Gm-Message-State: AOJu0Yx83xByEi2Zg28gXQS87DCkoVb+Yhs3IvWYUtiraYXmVUBjEsjJ
        wo/NQhnzYjEr1lVZflKc0LE=
X-Google-Smtp-Source: AGHT+IEKRQpew27HjOeGyjWHZXAUVaNqJuiqAmK9LZWwGrJlIJ3XHpuuO/jNnXt9DgwB+aS7MqbtNQ==
X-Received: by 2002:a17:907:7ba1:b0:9c4:4b20:44b2 with SMTP id ne33-20020a1709077ba100b009c44b2044b2mr1761032ejc.23.1697451777533;
        Mon, 16 Oct 2023 03:22:57 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id og41-20020a1709071de900b009adce1c97ccsm3701040ejc.53.2023.10.16.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:22:57 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:22:54 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] net: dsa: microchip: do not shut down
 the switch if WoL is active
Message-ID: <20231016102254.f7u7vrk52siqoihd@skbuf>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-8-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013122405.3745475-8-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:24:05PM +0200, Oleksij Rempel wrote:
> For Wake on Lan we should not reconfigure, reset or power down the
> switch on shut down sequence.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz9477_i2c.c |  3 +++
>  drivers/net/dsa/microchip/ksz_common.c  | 18 ++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.h  |  2 ++
>  drivers/net/dsa/microchip/ksz_spi.c     |  3 +++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
> index 2710afad4f3a..fe818742051c 100644
> --- a/drivers/net/dsa/microchip/ksz9477_i2c.c
> +++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
> @@ -66,6 +66,9 @@ static void ksz9477_i2c_shutdown(struct i2c_client *i2c)
>  	if (!dev)
>  		return;
>  
> +	if (ksz_wol_is_active(dev))
> +		return;
> +
>  	if (dev->dev_ops->reset)
>  		dev->dev_ops->reset(dev);

The rest of the code used to read:

	dsa_switch_shutdown(dev->ds);

	i2c_set_clientdata(i2c, NULL);
}

and that part is non-optional. Please only skip the dev->dev_ops->reset()
call if ksz_wol_is_active().

>  static void ksz_set_xmii(struct ksz_device *dev, int port,
>  			 phy_interface_t interface)
>  {
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 80679f38ee12..84b1eed8cd2a 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -397,6 +397,8 @@ bool ksz_get_gbit(struct ksz_device *dev, int port);
>  phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit);
>  extern const struct ksz_chip_data ksz_switch_chips[];
>  
> +bool ksz_wol_is_active(struct ksz_device *dev);
> +
>  /* Common register access functions */
>  static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
>  {
> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index 279338451621..c5d9c3d86ddb 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c
> @@ -114,6 +114,9 @@ static void ksz_spi_shutdown(struct spi_device *spi)
>  	if (!dev)
>  		return;
>  
> +	if (ksz_wol_is_active(dev))
> +		return;
> +
>  	if (dev->dev_ops->reset)
>  		dev->dev_ops->reset(dev);

Same here. Maybe introducing a common ksz_switch_shutdown() would be
appropriate.
