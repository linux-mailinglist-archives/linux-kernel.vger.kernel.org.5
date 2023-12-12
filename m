Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9206E80E98E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjLLK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLLK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:59:23 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775BA0;
        Tue, 12 Dec 2023 02:59:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bffb64178so6520251e87.2;
        Tue, 12 Dec 2023 02:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702378768; x=1702983568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBACCwW/u1iAUGLoPTfmihwXKrVJVbnjXJdVbLxBVuc=;
        b=TLImtWxIKnyiWo1goY5pw6aJzjGur/5b98LF/msLof+FovWePPK8Ly+FTkqGsilDyk
         rYZ9G3tAAuaISfmw3fcA2zxI8MUlhm0RXkRWtGplCLdEkOFWBcinlf2zBgYr6T75HNcz
         GoAEEttWA8ah34s5fFD3e4HTg3OFZ6qypvQhmKF0x+8gXxQ4tf9+AIQ5VOGFYMq0OacT
         +LvULlZKmnrf6MQlMuTbriPeQuzjlV5EbL+xhTVwxueYoPknlHwvJ7PVK/D5yfGB+m21
         Yt9dpiFucVjkn+AJ0CFoWN+P9R8Li0fn/Rfk+/EeOGApEdYJ1NddLoYQKOoaHUwK9iVB
         gDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378768; x=1702983568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBACCwW/u1iAUGLoPTfmihwXKrVJVbnjXJdVbLxBVuc=;
        b=myLu1xckwUWVhEHqfKsjvYqYuKk8NztlCCGLCgcnEDlQOCeBc476coTZYQWXZ2hYZd
         CKkqE74DJeBOMM7FnCU+GvNAKZzCtcI7WTheAtUsDRduYenLWcUqUIm+p7Frc8NE62vH
         o8oG8V6JLENcUpMzQdePNFufkPBxCJKanlpbyGOT0/jPeQToh6EVYieFbpzcdu2xml0j
         CNlX80Ilwecwi3+7W2iRQcwH7gyQFX2ot51mzJKsfwqiiwwJL6NdFZTG/TtUkmOkBkZi
         xwqaAvnUn+y7AucZV1lhHeuLhEXxr6NmzOsR0TAqEy7aceG/W6Ox/jCVzMHNXoxybrwJ
         eeHw==
X-Gm-Message-State: AOJu0YxkO94NprVSaRXx4e/dw44yWDu3aY25wblb28xnGG5iCuFubzFU
        OLYkk1dpvkpGqx0chteKYy0=
X-Google-Smtp-Source: AGHT+IFENj5x54Op3KLBMNmk1vpxHnMd7tYQWResL1rD1eJl9lh0gvrTRZQsB8pjxfiVQfYkjXFdgw==
X-Received: by 2002:a05:6512:6cb:b0:50d:12ea:cba0 with SMTP id u11-20020a05651206cb00b0050d12eacba0mr3566985lff.95.1702378767797;
        Tue, 12 Dec 2023 02:59:27 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id dx7-20020a0565122c0700b0050d12fa98fesm1289491lfb.300.2023.12.12.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:59:27 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:59:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <ggbqvhdhgl6wmuewqtwtgud7ubx2ypmnb3p6p6w7cy37mnnyxn@2eqd63s2t5ii>
References: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:31:17PM -0600, Andrew Halaney wrote:
> Many hardware configurations have the MDIO bus disabled, and are instead
> using some other MDIO bus to talk to the MAC's phy.
> 
> of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> gracefully instead of failing to probe the MAC.
> 
> Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index fa9e7e7040b9..a39be15d41a8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -591,7 +591,13 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	new_bus->parent = priv->device;
>  
>  	err = of_mdiobus_register(new_bus, mdio_node);
> -	if (err != 0) {
> +	if (err) {
> +		if (err == -ENODEV) {
> +			/* The bus is disabled in the devicetree, that's ok */
> +			mdiobus_free(new_bus);
> +			return 0;
> +		}
> +
>  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
>  		goto bus_register_fail;
>  	}

This can be implemented a bit simpler, more maintainable and saving
one indentations level:

	err = of_mdiobus_register(new_bus, mdio_node);
	if (err == -ENODEV) {
		err = 0;
		dev_warn(dev, "MDIO bus is disabled\n");
		goto bus_register_fail;
	} else if (err) {
  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
  		goto bus_register_fail;
	}

-Serge(y)

> 
> ---
> base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
> change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 
