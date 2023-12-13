Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69F81128C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbjLMNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379083AbjLMNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:09:12 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BAB3;
        Wed, 13 Dec 2023 05:09:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso66421891fa.1;
        Wed, 13 Dec 2023 05:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702472957; x=1703077757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HJoRFEHz30zB0ZJf+EKks3Tvo/kzW6L5hkkeuaBBCU=;
        b=NSxwU5wGzTjw+ytv8hERCHcgty6D8qJMkVzUlng7Z6BDH3NhWdKwFsTmvcxsYA7agw
         kFBhmc+tcPjhMypfzioqMrps+Yjd2p+CuZLJaQdh612o57OU1fF5mFzgdGvGr680rIOq
         kPEzE6il524kHXW0+ZtC4MmdHvkSYkCgaYHTQTl934vdhrYqGtYyVOoo6emNY4tagPRY
         lncSs1nGyUrfgVeRuvy/0upFMaVhiGdAljNGZ+lvUXnoknT6umk1GFrVYoW8+Z5CHlR6
         EMSMNREWrKkEcVmqz/jBevTd3QWBoO39eNRR+qNKy5ExwenB+/2z/k0VIUPaQWG6iGId
         VNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472957; x=1703077757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HJoRFEHz30zB0ZJf+EKks3Tvo/kzW6L5hkkeuaBBCU=;
        b=lyOcCqgAG8DDQAUvzVM8hok97ik610p08IcKMehmJK5NImwrRE66n/iF1dU4wO0Pz6
         VOt31K6DrvYaCh7wtt2yH/QqoaMcSrK3nw/VlBlFBxvekQVLZFJKuqgt8P799lmuMWQK
         R3472pNEXJbkaXs/M9MEGPEeh+s0tCbnRUrl/MOP/Q5NHuUpAPmu+B9Tr0ZHoA3MsjZl
         RMdTCfmOMIoTSt/EDlb87Eq9VPQu4IUY8tIXBzAhtVN0bhqIjrjXtq30aDu/9bUnCtI1
         YwwSF6nJWUugFFfrszA2p/GY/IMRvxc/vgN0PkHa3tCYBU3MzgqQBf187SFhYMaJdnqS
         9itA==
X-Gm-Message-State: AOJu0YyGxrxe0tWxTe2fobuVOmNEia7t7lN+aq/SHDb24QMgyq5eUNTi
        Vltybq/mVYKfzwwxyqRDCRU=
X-Google-Smtp-Source: AGHT+IEx1G2Ak0WCyDZGOhaHfa9iY3nMhLay3pfRJFLfsPi8CVj+jZd2gK+mqCcnf4++8bfHmYBixg==
X-Received: by 2002:a2e:b742:0:b0:2c9:e940:6780 with SMTP id k2-20020a2eb742000000b002c9e9406780mr3993926ljo.22.1702472956648;
        Wed, 13 Dec 2023 05:09:16 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m24-20020a2e9118000000b002ca02e43f40sm1840200ljg.74.2023.12.13.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:09:16 -0800 (PST)
Date:   Wed, 13 Dec 2023 16:09:12 +0300
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <f2pf2g23ln4qcoqxidy55plysn735qtfspj6nuu6f7isqxotp2@rj6ejru5eon7>
References: <20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 04:18:33PM -0600, Andrew Halaney wrote:
> Many hardware configurations have the MDIO bus disabled, and are instead
> using some other MDIO bus to talk to the MAC's phy.
> 
> of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> gracefully instead of failing to probe the MAC.
> 
> Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Changes in v2:
> - Improve error handling code (Serge)
> - Fix malformed Fixes tag (Simon)
> - Link to v1: https://lore.kernel.org/r/20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com

Looking good. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index fa9e7e7040b9..0542cfd1817e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -591,7 +591,11 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	new_bus->parent = priv->device;
>  
>  	err = of_mdiobus_register(new_bus, mdio_node);
> -	if (err != 0) {
> +	if (err == -ENODEV) {
> +		err = 0;
> +		dev_info(dev, "MDIO bus is disabled\n");
> +		goto bus_register_fail;
> +	} else if (err) {
>  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
>  		goto bus_register_fail;
>  	}
> 
> ---
> base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
> change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 
