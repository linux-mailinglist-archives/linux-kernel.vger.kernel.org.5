Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A87980899B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442615AbjLGNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442553AbjLGNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:55:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF710F2;
        Thu,  7 Dec 2023 05:55:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so838051e87.3;
        Thu, 07 Dec 2023 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701957322; x=1702562122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv99P0Cwbob2IZ5KHU9goQeyjwZHcKSLv3OpI2FqkiY=;
        b=lXB2XNmWdXYZRyU0/xKvRUnmDZH6OrAsAmzC7jr3W6yJTXA/mAC5ul5cojTrYxtjWo
         uUO/0rpu8UwAh6ua9tWaowc3I8+aJEIKRUGIX6xMKaP6Hg7Vq2b0e+y/WP/vmrLdqnvG
         mHbmVnf5diUkC3IVCYB/84TjbPSR5fkJTUgI9FHqQlYpRzNs8XgYYQWvkHy5xb7CGd4g
         OJxNJHIBGAwS61Dp0yO1ONGz4+GLts80Vft5fU15mQYer7q7IoK4nz6xzQwvLp75ApxW
         qAtf0kYBqGAhimpbaFZtadP+x6+anvfNPl6Pxz05/6zYhGFXdCzw68tQ08Pc8Sb7qYB2
         5s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957322; x=1702562122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv99P0Cwbob2IZ5KHU9goQeyjwZHcKSLv3OpI2FqkiY=;
        b=VPoWPQzL/XUttI+ZIEt17T9dFye80sIvLCR1WTnGYaaRLqD+88PnMKyWNfwaakBvkT
         ZvsBoR4wC57M0kgOEX9jtfUqXuCmmQ+9xnxqmicEhjbHBUExOvClhAfD88VHIRb3fkxz
         5mDt5HlFaroIPkyaYniXmXq/K/vzjbzAjS+twU0spf+gjkyvWP+pcw3ih6FZEu93Df6d
         m40DMMhMahpxio9vkMmyvOl2mWIZcv0DoJw5WzVustz1RutGAmt/r6reCYcB68spmClW
         KB5fIC0YF+RJJ0w8DvhcK1F3zzI2Bk30kWkusvzqWYgQG0j7cAZAiPgEDeHJZfdgiIDh
         rm2A==
X-Gm-Message-State: AOJu0YwA+oU6/1465kNla6DCH3a5vfif6H5ez0rUgDmrGYBavZXePNW1
        FfE/sI7rzzlrELDEDvx5vEu+jeIolYI=
X-Google-Smtp-Source: AGHT+IEGB4xbcrdvLVhG1vISLjJuiKNX+6Yof/B8clw0ibuf/ixT8aOrRztoSikFwXxu/nprTW3hLA==
X-Received: by 2002:a05:6512:3c2:b0:50b:e302:597b with SMTP id w2-20020a05651203c200b0050be302597bmr1542042lfp.12.1701957322300;
        Thu, 07 Dec 2023 05:55:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p23-20020ac246d7000000b0050bf48e6610sm175994lfo.229.2023.12.07.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:55:21 -0800 (PST)
Date:   Thu, 7 Dec 2023 16:55:19 +0300
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
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <rlq2eodwlesa4bvxz2ro24tsrhfd3cyz3blxhxzldrs3nuktzu@wspwzlz3umkh>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
 <o3abmn7ocuksmjg23rrgsib7nfm4yo5rtzlqw2np2pplg73drd@7qe4vrsx2gyc>
 <vmjpuli2l6r7awtiwip6hbgmc4m7hgtbyoqi3z4rhb5chfoiu4@5ebw7tepe6mp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vmjpuli2l6r7awtiwip6hbgmc4m7hgtbyoqi3z4rhb5chfoiu4@5ebw7tepe6mp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 07:32:29AM -0600, Andrew Halaney wrote:
> On Thu, Dec 07, 2023 at 02:56:25PM +0300, Serge Semin wrote:
> > Hi Andrew
> > 
> > On Wed, Dec 06, 2023 at 05:46:09PM -0600, Andrew Halaney wrote:
> > > The stmmac_dt_phy() function, which parses the devicetree node of the
> > > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > > fixed-link means in relation to the MAC's MDIO bus. This results in
> > > a MDIO bus being created in situations it need not be.
> > > 
> > > Currently a MDIO bus is created if the description is either:
> > > 
> > >     1. Not fixed-link
> > >     2. fixed-link but contains a MDIO bus as well
> > > 
> > > The "1" case above isn't always accurate. If there's a phy-handle,
> > > it could be referencing a phy on another MDIO controller's bus[1]. In
> > > this case currently the MAC will make a MDIO bus and scan it all
> > > anyways unnecessarily.
> > > 
> > > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > > be created and scanned for a phy. This case can also be inferred from
> > > the platform description by not having a phy-handle && not being
> > > fixed-link. This hits case "1" in the current driver's logic.
> > > 
> > > Let's improve the logic to create a MDIO bus if either:
> > > 
> > >     - Devicetree contains a MDIO bus
> > >     - !fixed-link && !phy-handle (legacy handling)
> > > 
> > > Below upstream devicetree snippets can be found that explain some of
> > > the cases above more concretely.
> > > 
> > > Here's[0] a devicetree example where the MAC is both fixed-link and
> > > driving a switch on MDIO (case "2" above). This needs a MDIO bus to
> > > be created:
> > > 
> > >     &fec1 {
> > >             phy-mode = "rmii";
> > > 
> > >             fixed-link {
> > >                     speed = <100>;
> > >                     full-duplex;
> > >             };
> > > 
> > >             mdio1: mdio {
> > >                     switch0: switch0@0 {
> > >                             compatible = "marvell,mv88e6190";
> > >                             pinctrl-0 = <&pinctrl_gpio_switch0>;
> > >                     };
> > >             };
> > >     };
> > > 
> > > Here's[1] an example where there is no MDIO bus or fixed-link for
> > > the ethernet1 MAC, so no MDIO bus should be created since ethernet0
> > > is the MDIO master for ethernet1's phy:
> > > 
> > >     &ethernet0 {
> > >             phy-mode = "sgmii";
> > >             phy-handle = <&sgmii_phy0>;
> > > 
> > >             mdio {
> > >                     compatible = "snps,dwmac-mdio";
> > >                     sgmii_phy0: phy@8 {
> > >                             compatible = "ethernet-phy-id0141.0dd4";
> > >                             reg = <0x8>;
> > >                             device_type = "ethernet-phy";
> > >                     };
> > > 
> > >                     sgmii_phy1: phy@a {
> > >                             compatible = "ethernet-phy-id0141.0dd4";
> > >                             reg = <0xa>;
> > >                             device_type = "ethernet-phy";
> > >                     };
> > >             };
> > >     };
> > > 
> > >     &ethernet1 {
> > >             phy-mode = "sgmii";
> > >             phy-handle = <&sgmii_phy1>;
> > >     };
> > > 
> > > Finally there's descriptions like this[2] which don't describe the
> > > MDIO bus but expect it to be created and the whole address space
> > > scanned for a phy since there's no phy-handle or fixed-link described:
> > > 
> > >     &gmac {
> > >             phy-supply = <&vcc_lan>;
> > >             phy-mode = "rmii";
> > >             snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
> > >             snps,reset-active-low;
> > >             snps,reset-delays-us = <0 10000 1000000>;
> > >     };
> > > 
> > > [0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
> > > [1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > > [2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164
> > 
> > Thank you for the patch. Please find a comment below.
> > 
> > > 
> > > Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > ---
> > >  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 85 ++++++++++------------
> > >  1 file changed, 37 insertions(+), 48 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > index 1ffde555da47..7da461fe93f6 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > @@ -296,69 +296,39 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
> > >  }
> > >  
> > >  /**
> > > - * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
> > > - * @plat: driver data platform structure
> > > - * @np: device tree node
> > > - * @dev: device pointer
> > > - * Description:
> > > - * The mdio bus will be allocated in case of a phy transceiver is on board;
> > > - * it will be NULL if the fixed-link is configured.
> > > - * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
> > > - * in any case (for DSA, mdio must be registered even if fixed-link).
> > > - * The table below sums the supported configurations:
> > > - *	-------------------------------
> > > - *	snps,phy-addr	|     Y
> > > - *	-------------------------------
> > > - *	phy-handle	|     Y
> > > - *	-------------------------------
> > > - *	fixed-link	|     N
> > > - *	-------------------------------
> > > - *	snps,dwmac-mdio	|
> > > - *	  even if	|     Y
> > > - *	fixed-link	|
> > > - *	-------------------------------
> > > + * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree
> > > + * @np: devicetree node
> > >   *
> > > - * It returns 0 in case of success otherwise -ENODEV.
> > > + * The MDIO bus will be searched for in the following ways:
> > > + * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
> > > + *    child node exists
> > > + * 2. A child node with the "snps,dwmac-mdio" compatible is present
> > > + *
> > > + * Return: The MDIO node if present otherwise NULL
> > >   */
> > > -static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
> > > -			 struct device_node *np, struct device *dev)
> > > +static struct device_node *stmmac_of_get_mdio(struct device_node *np)
> > >  {
> > > -	bool mdio = !of_phy_is_fixed_link(np);
> > >  	static const struct of_device_id need_mdio_ids[] = {
> > >  		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
> > >  		{},
> > >  	};
> > > +	struct device_node *mdio_node = NULL;
> > >  
> > >  	if (of_match_node(need_mdio_ids, np)) {
> > > -		plat->mdio_node = of_get_child_by_name(np, "mdio");
> > > +		mdio_node = of_get_child_by_name(np, "mdio");
> > >  	} else {
> > >  		/**
> > >  		 * If snps,dwmac-mdio is passed from DT, always register
> > >  		 * the MDIO
> > >  		 */
> > > -		for_each_child_of_node(np, plat->mdio_node) {
> > > -			if (of_device_is_compatible(plat->mdio_node,
> > > +		for_each_child_of_node(np, mdio_node) {
> > > +			if (of_device_is_compatible(mdio_node,
> > >  						    "snps,dwmac-mdio"))
> > >  				break;
> > >  		}
> > >  	}
> > >  
> > > -	if (plat->mdio_node) {
> > > -		dev_dbg(dev, "Found MDIO subnode\n");
> > > -		mdio = true;
> > > -	}
> > > -
> > > -	if (mdio) {
> > > -		plat->mdio_bus_data =
> > > -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> > > -				     GFP_KERNEL);
> > > -		if (!plat->mdio_bus_data)
> > > -			return -ENOMEM;
> > > -
> > > -		plat->mdio_bus_data->needs_reset = true;
> > > -	}
> > > -
> > > -	return 0;
> > > +	return mdio_node;
> > >  }
> > >  
> > >  /**
> > > @@ -417,6 +387,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> > >  	struct device_node *np = pdev->dev.of_node;
> > >  	struct plat_stmmacenet_data *plat;
> > >  	struct stmmac_dma_cfg *dma_cfg;
> > > +	bool legacy_mdio;
> > >  	int phy_mode;
> > >  	void *ret;
> > >  	int rc;
> > > @@ -471,10 +442,28 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> > >  	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
> > >  		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
> > >  
> > > -	/* To Configure PHY by using all device-tree supported properties */
> > > -	rc = stmmac_dt_phy(plat, np, &pdev->dev);
> > > -	if (rc)
> > > -		return ERR_PTR(rc);
> > > +	plat->mdio_node = stmmac_of_get_mdio(np);
> > > +	if (plat->mdio_node)
> > > +		dev_dbg(&pdev->dev, "Found MDIO subnode\n");
> > > +
> > 
> > > +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> > > +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> > > +	 * described assume this is the case since there must be something
> > > +	 * connected to the MAC.
> > > +	 */
> > > +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> > > +	if (legacy_mdio)
> > > +		dev_info(&pdev->dev, "Deprecated MDIO bus assumption used\n");
> > > +
> > > +	if (plat->mdio_node || legacy_mdio) {
> > > +		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> > > +						   sizeof(struct stmmac_mdio_bus_data),
> > > +						   GFP_KERNEL);
> > > +		if (!plat->mdio_bus_data)
> > > +			return ERR_PTR(-ENOMEM);
> > > +
> > > +		plat->mdio_bus_data->needs_reset = true;
> > > +	}
> > 
> > Why did you decide to move this out of the dedicated function?
> > stmmac_probe_config_dt() is already overwhelmed with various
> > non-coherent actions. The method has already got to being too long to
> > follow the kernel coding style limit (I have got a not submitted yet
> > cleanup patchset which step-by-step fixes that). Could you please get
> > the chunk above back to the respective function and, for instance,
> > just change it's name to something like stmmac_mdio_setup()? (I prefer
> > having "_setup" suffix because some of the locally defined static
> > methods already use it: stmmac_axi_setup(), stmmac_mtl_setup().)
> 

> Sure, I can put it back in. I'll probably keep stmmac_of_get_mdio()
> (which is named in the style I see in the current file -- although as
> you highlight that shouldn't be taken as the best example of clean),
> and have stmmac_mdio_setup() call that and and mimic the inputs/outputs
> of the current function (moving the rest of the added code from
> stmmac_probe_config_dt() back into that function).
> 
> Thanks for the feedback, let me know if you still think that abstraction
> isn't ideal (or wait till I post it :P) and I'll go with exactly as you
> said.

Sounds good. Thanks for taking my comment into account.

> I'm not _too_ opinionated on it, but thought stmmac_dt_phy()
> didn't explain much and stmmac_of_get_mdio() was self-explanatory enough
> that it helped readability.

You were right. stmmac_dt_phy() hasn't been explicitly doing
PHY-related things since commit 74371272f97f ("net: stmmac: Convert to
phylink and remove phylib logic"), but has been left with the MDIO
stuff only. The function name wasn't that well chosen either.  It
didn't indicate what the function actually did, like "init", "get",
"setup", etc. From that perspective your naming is much better - short
and self-explanatory indeed.

-Serge(y)

> 
> > 
> > -Serge(y)
> > 
> > >  
> > >  	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
> > >  
> > > 
> > > ---
> > > base-commit: fd8a79b63710acb84321be3ce74be23c876873fb
> > > change-id: 20231127-stmmac-no-mdio-node-1db9da8a25d9
> > > 
> > > Best regards,
> > > -- 
> > > Andrew Halaney <ahalaney@redhat.com>
> > > 
> > > 
> > 
> 
