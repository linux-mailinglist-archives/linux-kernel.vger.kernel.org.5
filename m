Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFC7CA595
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjJPKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:37:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78230B4;
        Mon, 16 Oct 2023 03:37:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so7296241a12.2;
        Mon, 16 Oct 2023 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452631; x=1698057431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYPaLG/yqq2AeQmdJ6S7bmu8cvVq2TzURcOqOkOdsJE=;
        b=SSqz0NLoHwFG1V+5Ci+O0kVUQcxHU/wgnB0vyJvBLSOc6ODc39SzMaQak9eUn7zKag
         VA0QEnbnRlY802OiJpuTwaOqcTeJs9ggieUyKrb4llO5asPIJ8gAcIxEmwzviUJSeQJp
         BX24BuAvgzmIO7bIpgC9DuZKHKIaJCCA0mXLpDlICV5dOp+IcchKfUEyO/wDOCdbvKvz
         /Tauuh9w83lqUfX7pQH9sI37GfHEXO51tgNcuqd3RjARaDbIFi9PFg3kENRFcfaz9fuy
         Xe0/9WZ9q93T6wFZQWX+V9X8nypGtCAL6owp1zkekzES0OfDG81Wy5VfpINTY5uqk63i
         wyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452631; x=1698057431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYPaLG/yqq2AeQmdJ6S7bmu8cvVq2TzURcOqOkOdsJE=;
        b=NH9yquLh8bkSwhETtvD45mG6iG2ME/4ErILBtHaLlXPw/CBaZtgfhbbf1MkxDoQRAu
         dochGi8OuWzMtdCOJjedh3+PNsDQcGm0K0dzTBUFkRrs4Lwf+UoQNOiK+b6KNQpUu6Yw
         6wY+2g6zY1PWhd5P2GbK0dBMxsbUvj80ER3OnU/J55GGxGWvQUG5Gr0n0zkBjLGYC3uM
         ijqaCkq83JLia+U4KGJBI+KVp8cI3o1ZtVWP2I9lXqVZMrwzHoIEZDpXPEKrX8y5Gtgv
         vvs9QlhPfAJYBLKs6HViPufOrskifig4qqxMVIgRZPt1yXvlSOS75NrWw2VtjlfhGq4E
         OtPg==
X-Gm-Message-State: AOJu0Yz05GnTQUEh65iFHjLMloGFfpvZSlVVQ4kUm5wUjzmtqX1mZLQI
        ckHlusoQY5BDLk0HhDA7Qo0=
X-Google-Smtp-Source: AGHT+IEXtTbrs2iEVL6pfGr8blG7GifaIRJu/lvf+cSiq6TJEJoDPY9DrrN3BE9mCdr2dSxUY4ut7g==
X-Received: by 2002:a05:6402:40d0:b0:53e:a9bd:508 with SMTP id z16-20020a05640240d000b0053ea9bd0508mr3069297edb.25.1697452630828;
        Mon, 16 Oct 2023 03:37:10 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a26-20020a50e71a000000b00537963f692esm15440188edn.0.2023.10.16.03.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:37:10 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:37:08 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net:dsa:microchip: add property to
 select internal RMII reference clock
Message-ID: <20231016103708.6ka5vxfkdatrjvdk@skbuf>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
 <cover.1697107915.git.ante.knezic@helmholz.de>
 <c8bb7002e6d81a661c853dd21e0fe18e95887609.1697107915.git.ante.knezic@helmholz.de>
 <c8bb7002e6d81a661c853dd21e0fe18e95887609.1697107915.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8bb7002e6d81a661c853dd21e0fe18e95887609.1697107915.git.ante.knezic@helmholz.de>
 <c8bb7002e6d81a661c853dd21e0fe18e95887609.1697107915.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit message: "net: dsa: microchip: ".

On Thu, Oct 12, 2023 at 12:55:55PM +0200, Ante Knezic wrote:
> Microchip KSZ8863/KSZ8873 have the ability to select between internal
> and external RMII reference clock. By default, reference clock
> needs to be provided via REFCLKI_3 pin. If required, device can be
> setup to provide RMII clock internally so that REFCLKI_3 pin can be
> left unconnected.
> Add a new "microchip,rmii-clk-internal" property which will set
> RMII clock reference to internal. If property is not set, reference
> clock needs to be provided externally.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c     | 5 +++++
>  drivers/net/dsa/microchip/ksz8795_reg.h | 3 +++
>  drivers/net/dsa/microchip/ksz_common.c  | 3 +++
>  drivers/net/dsa/microchip/ksz_common.h  | 1 +
>  4 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 91aba470fb2f..78f3a668aa99 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -1434,6 +1434,11 @@ int ksz8_setup(struct dsa_switch *ds)
>  	for (i = 0; i < (dev->info->num_vlans / 4); i++)
>  		ksz8_r_vlan_entries(dev, i);
>  
> +	if (ksz_is_ksz88x3(dev))
> +		ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
> +			KSZ88X3_PORT3_RMII_CLK_INTERNAL,
> +			dev->rmii_clk_internal);
> +

Can this be done in dev->dev_ops->phylink_mac_config() (which so far has no implementation)
for port 3 of ksz88x3?

>  	return ksz8_handle_global_errata(ds);
>  }
>  
> diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
> index 3c9dae53e4d8..beca974e0171 100644
> --- a/drivers/net/dsa/microchip/ksz8795_reg.h
> +++ b/drivers/net/dsa/microchip/ksz8795_reg.h
> @@ -22,6 +22,9 @@
>  #define KSZ8863_GLOBAL_SOFTWARE_RESET	BIT(4)
>  #define KSZ8863_PCS_RESET		BIT(0)
>  
> +#define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
> +#define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
> +
>  #define REG_SW_CTRL_0			0x02
>  
>  #define SW_NEW_BACKOFF			BIT(7)
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index b800ace40ce1..0a0a53ce5b1b 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -4160,6 +4160,9 @@ int ksz_switch_register(struct ksz_device *dev)
>  		}
>  	}
>  
> +	dev->rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
> +						       "microchip,rmii-clk-internal");

Port property.

> +
>  	ret = dsa_register_switch(dev->ds);
>  	if (ret) {
>  		dev->dev_ops->exit(dev);
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 8842efca0871..e5b0445fe2ca 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -163,6 +163,7 @@ struct ksz_device {
>  	phy_interface_t compat_interface;
>  	bool synclko_125;
>  	bool synclko_disable;
> +	bool rmii_clk_internal;
>  
>  	struct vlan_table *vlan_cache;
>  
> -- 
> 2.11.0
