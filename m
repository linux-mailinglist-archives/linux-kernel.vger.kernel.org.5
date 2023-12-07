Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DC809527
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444061AbjLGWQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjLGWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:16:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE062170C;
        Thu,  7 Dec 2023 14:16:16 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so16723061fa.1;
        Thu, 07 Dec 2023 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987375; x=1702592175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXX2SimUn48mcVbhB+e4BDcFMonTTNXXs/7BudeSvw0=;
        b=cmZoqJYkZdiyve5oE6naNYSKWQFBjmDjvIfUHyj0q5BSgCehK7hlOXX5hB4qjBfGAp
         KNTZfMBsFHZKC4dvcEBcfnezCLPb+dUv8gS34tb5+xNojv+ZJoKlxu3aAKBeZIyYRYAS
         h11zULp1gRv9U7ahOkcrz+/vvPYrEGP/Ynf5FV3BahOpuy/f5WMaBzMdzzVQEzCFygId
         Y5Ln66tFBUlQP0OpPCitzUJ5YsfR4aNTtFap9dB5+Xso7TrQ7Rv+qCUHfNeLn+R8/KPB
         iR7UAR9rkgNf46XkjJhm2PAyWaH6kTEZNRkYRNaa9nP3A4YzqxUMV7nu7RWAnNoH1Vy8
         9Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987375; x=1702592175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXX2SimUn48mcVbhB+e4BDcFMonTTNXXs/7BudeSvw0=;
        b=H4vWp2knWzjBGvgusLsUrVd+4px6ni/aD/Mmr/GSJrarmh/bnhNbAsfiFKSM9vLtj5
         J72C4hATwK8nIbipo0qsLgVLkZwLbqIzEqj6Y8QFaXrKhVB7rlhfwEJIkYM9hv0yNHdn
         mk3lD4hxg8r6FIMkrVef3VKXcesrZNh+W8bJeYjtP6g54ECyGxvGUYNngpXgHAg02GGb
         OYrL9CzkRVgBnz62VpgFNP5+tiTpmk5okyiDvMAXxqMV67mH8kQ2nKpnixwMIMr2HWbD
         cgUBUmByau2zmZ7jgxGt0Q+C7simAuXolTBS6SHnl20wvp+fiCcOLm0ZTdAYPhGytJ+f
         0qIw==
X-Gm-Message-State: AOJu0YxdJ0mMhw3+dx5jJ9pCZ+giP7cJPGmgZwTygAhW+XyhNCHZAOgd
        D3sxwURR0CjLWHh7wVp8KZ8=
X-Google-Smtp-Source: AGHT+IE6LZ2v1Jvbi5K7ltNfx74fGPNBHOrCUdjDzp2zk+F1/+j+7FEfiAtOUrMFt2pO6nq5/OdvCw==
X-Received: by 2002:a2e:910c:0:b0:2ca:749:3f43 with SMTP id m12-20020a2e910c000000b002ca07493f43mr1236540ljg.32.1701987374730;
        Thu, 07 Dec 2023 14:16:14 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id u5-20020a05651c130500b002ca0290a0fesm51799lja.126.2023.12.07.14.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:16:14 -0800 (PST)
Date:   Fri, 8 Dec 2023 01:16:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> The stmmac_dt_phy() function, which parses the devicetree node of the
> MAC and ultimately causes MDIO bus allocation, misinterprets what
> fixed-link means in relation to the MAC's MDIO bus. This results in
> a MDIO bus being created in situations it need not be.
> 
> Currently a MDIO bus is created if the description is either:
> 
>     1. Not fixed-link
>     2. fixed-link but contains a MDIO bus as well
> 
> The "1" case above isn't always accurate. If there's a phy-handle,
> it could be referencing a phy on another MDIO controller's bus[1]. In
> this case currently the MAC will make a MDIO bus and scan it all
> anyways unnecessarily.
> 
> There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> be created and scanned for a phy. This case can also be inferred from
> the platform description by not having a phy-handle && not being
> fixed-link. This hits case "1" in the current driver's logic.
> 
> Let's improve the logic to create a MDIO bus if either:
> 

>     - Devicetree contains a MDIO bus
>     - !fixed-link && !phy-handle (legacy handling)

If what you suggest here is a free from regressions semantics change
(really hope it is) I will be with both my hands for it. This will
solve the problem we have with one of our device which doesn't have
SMA interface (hardware designers decided to save ~4K gates of the
chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
SMA interface available on a DW *MAC device but creating the MDIO-bus
on top of the non-existent SMA CSRs anyway causes having _32_ dummy
PHYs created with zero IDs.

> 
> Below upstream devicetree snippets can be found that explain some of
> the cases above more concretely.
> 
> Here's[0] a devicetree example where the MAC is both fixed-link and
> driving a switch on MDIO (case "2" above). This needs a MDIO bus to
> be created:
> 
>     &fec1 {
>             phy-mode = "rmii";
> 
>             fixed-link {
>                     speed = <100>;
>                     full-duplex;
>             };
> 
>             mdio1: mdio {
>                     switch0: switch0@0 {
>                             compatible = "marvell,mv88e6190";
>                             pinctrl-0 = <&pinctrl_gpio_switch0>;
>                     };
>             };
>     };
> 
> Here's[1] an example where there is no MDIO bus or fixed-link for
> the ethernet1 MAC, so no MDIO bus should be created since ethernet0
> is the MDIO master for ethernet1's phy:
> 
>     &ethernet0 {
>             phy-mode = "sgmii";
>             phy-handle = <&sgmii_phy0>;
> 
>             mdio {
>                     compatible = "snps,dwmac-mdio";
>                     sgmii_phy0: phy@8 {
>                             compatible = "ethernet-phy-id0141.0dd4";
>                             reg = <0x8>;
>                             device_type = "ethernet-phy";
>                     };
> 
>                     sgmii_phy1: phy@a {
>                             compatible = "ethernet-phy-id0141.0dd4";
>                             reg = <0xa>;
>                             device_type = "ethernet-phy";
>                     };
>             };
>     };
> 
>     &ethernet1 {
>             phy-mode = "sgmii";
>             phy-handle = <&sgmii_phy1>;
>     };
> 
> Finally there's descriptions like this[2] which don't describe the
> MDIO bus but expect it to be created and the whole address space
> scanned for a phy since there's no phy-handle or fixed-link described:
> 
>     &gmac {
>             phy-supply = <&vcc_lan>;
>             phy-mode = "rmii";
>             snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
>             snps,reset-active-low;
>             snps,reset-delays-us = <0 10000 1000000>;
>     };
> 
> [0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
> [1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> [2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164
> 
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Changes in v3:

>     - Keep logic out of stmmac_probe_config_dt() since it's already massive (Serge)

Thanks for taking my note into account. The change turned out even
better than I thought it would look like. The MDIO-bus setup procedure
is much more readable now. A small nitpick below.

> 
> Changes in v2:
>     - Handle the fixed-link + mdio case (Andrew Lunn)
>     - Reworded commit message
>     - Still handle the "legacy" case mentioned in the commit
>     - Bit further refactoring of the function for readability
> 
> - Link to v2: https://lore.kernel.org/r/20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com
> - Link to v1: https://lore.kernel.org/netdev/20230808120254.11653-1-brgl@bgdev.pl/
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 91 +++++++++++++---------
>  1 file changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 1ffde555da47..d6079c1432c7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -296,62 +296,80 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  }
>  
>  /**
> - * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
> - * @plat: driver data platform structure
> - * @np: device tree node
> - * @dev: device pointer
> - * Description:
> - * The mdio bus will be allocated in case of a phy transceiver is on board;
> - * it will be NULL if the fixed-link is configured.
> - * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
> - * in any case (for DSA, mdio must be registered even if fixed-link).
> - * The table below sums the supported configurations:
> - *	-------------------------------
> - *	snps,phy-addr	|     Y
> - *	-------------------------------
> - *	phy-handle	|     Y
> - *	-------------------------------
> - *	fixed-link	|     N
> - *	-------------------------------
> - *	snps,dwmac-mdio	|
> - *	  even if	|     Y
> - *	fixed-link	|
> - *	-------------------------------
> + * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree.
> + * @np: devicetree node
>   *
> - * It returns 0 in case of success otherwise -ENODEV.
> + * The MDIO bus will be searched for in the following ways:
> + * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
> + *    child node exists
> + * 2. A child node with the "snps,dwmac-mdio" compatible is present
> + *
> + * Return: The MDIO node if present otherwise NULL
>   */
> -static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
> -			 struct device_node *np, struct device *dev)
> +static struct device_node *stmmac_of_get_mdio(struct device_node *np)
>  {
> -	bool mdio = !of_phy_is_fixed_link(np);
>  	static const struct of_device_id need_mdio_ids[] = {
>  		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
>  		{},
>  	};
> +	struct device_node *mdio_node = NULL;
>  
>  	if (of_match_node(need_mdio_ids, np)) {
> -		plat->mdio_node = of_get_child_by_name(np, "mdio");
> +		mdio_node = of_get_child_by_name(np, "mdio");
>  	} else {
>  		/**
>  		 * If snps,dwmac-mdio is passed from DT, always register
>  		 * the MDIO
>  		 */
> -		for_each_child_of_node(np, plat->mdio_node) {
> -			if (of_device_is_compatible(plat->mdio_node,
> +		for_each_child_of_node(np, mdio_node) {
> +			if (of_device_is_compatible(mdio_node,
>  						    "snps,dwmac-mdio"))
>  				break;
>  		}
>  	}
>  
> -	if (plat->mdio_node) {
> +	return mdio_node;
> +}
> +
> +/**
> + * stmmac_mdio_setup() - Populate platform related MDIO structures.
> + * @plat: driver data platform structure
> + * @np: devicetree node
> + * @dev: device pointer
> + *
> + * This searches for MDIO information from the devicetree.
> + * If an MDIO node is found, it's assigned to plat->mdio_node and
> + * plat->mdio_bus_data is allocated.
> + * If no connection can be determined, just plat->mdio_bus_data is allocated
> + * to indicate a bus should be created and scanned for a phy.
> + * If it's determined there's no MDIO bus needed, both are left NULL.
> + *
> + * This expects that plat->phy_node has already been searched for.
> + *
> + * Return: 0 on success, errno otherwise.
> + */
> +static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
> +			     struct device_node *np, struct device *dev)
> +{
> +	bool legacy_mdio;
> +
> +	plat->mdio_node = stmmac_of_get_mdio(np);
> +	if (plat->mdio_node)
>  		dev_dbg(dev, "Found MDIO subnode\n");
> -		mdio = true;
> -	}
>  
> -	if (mdio) {
> -		plat->mdio_bus_data =
> -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> -				     GFP_KERNEL);

> +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> +	 * described assume this is the case since there must be something
> +	 * connected to the MAC.
> +	 */
> +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> +	if (legacy_mdio)
> +		dev_info(dev, "Deprecated MDIO bus assumption used\n");
> +
> +	if (plat->mdio_node || legacy_mdio) {
> +		plat->mdio_bus_data = devm_kzalloc(dev,

Special thanks for adding the comment above this code. It will really
save time of figuring out why MDIO-bus needs to be created anyway.

> +						   sizeof(struct stmmac_mdio_bus_data),

Should v4 is required I would suggest to change this to
sizeof(*plat->mdio_bus_data).

Anyway feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +						   GFP_KERNEL);
>  		if (!plat->mdio_bus_data)
>  			return -ENOMEM;
>  
> @@ -471,8 +489,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
>  		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
>  
> -	/* To Configure PHY by using all device-tree supported properties */
> -	rc = stmmac_dt_phy(plat, np, &pdev->dev);
> +	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> 
> ---
> base-commit: fd8a79b63710acb84321be3ce74be23c876873fb
> change-id: 20231127-stmmac-no-mdio-node-1db9da8a25d9
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 
> 
