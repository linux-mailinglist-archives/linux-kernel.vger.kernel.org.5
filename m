Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D608580871F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379007AbjLGL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:56:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A813D;
        Thu,  7 Dec 2023 03:56:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be58a751cso646664e87.2;
        Thu, 07 Dec 2023 03:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701950190; x=1702554990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gls+WyCxKy2/T0zF66LnozzlvZPMTRXDjtHjhUio7sc=;
        b=B05OfpvMo4MD2GjMGSLSZdtcE0cvCkVZ86xCEHph9MM4oJmhGV8OxA22ZKwQe89qFC
         hE4xO7oKuibCXOAnexObBtPKyUaK3ZmYk/k2rdZ6WXa/GWGA4+29zeZwEtLTT1PW0QeT
         UZEiPT9i9VGRIXR319w+APxIxXoornjJ4Ii6pEytiF6KXs/qi/y5E5lCxe+W+41SJqAY
         5OR5yxfL+Jte5I8fl85DBVr9p29VBFrhoHbnpKaZg1kSkhxcl3PjKoixxpFdNVVXNcN2
         4Ebl8DisSFcSTAhq6zSvLDY5Zk5DGhPqwTdTzz9Edc2zedoKzHguk+Hug+evsi2OByb7
         +khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701950190; x=1702554990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gls+WyCxKy2/T0zF66LnozzlvZPMTRXDjtHjhUio7sc=;
        b=P2gX2VLOu7b6wpzZWrgtCcKqtV8oIl7tFrIrEoA4NIBBy0T47yd1RblEfGA5vBbjMt
         fSP8mDVKhSC3NYuVyizj4JXJZbeCNHKnJt/jJLMBb6AxEJRI0FAsxZCSA5/SRMuQsRcW
         t9h3DZhuXF8fgFaZB3xhoa+SN9rhZvio8Bo2YZf7LnuA1DRR8RFu8xCAiy61xAIZZkED
         XWDj39rj6rwpOQT4ZumGCXrz8K0S0BBawpmuCcpZQXXRX31H22l/ZlNvS2VQOhrsqWWB
         cho4BLWc+jDqc1Kt3iC4O35+FkLDV1ge65fUeRHYBjuqaBoxkSLAz4zLH9T7EjkAKNle
         tQFg==
X-Gm-Message-State: AOJu0YwVDlq4jyGtDHZtC6MJPOSNXKT/sYgMwyKunwlUSFEL7EAR+5jZ
        T4cIHz6SdROmb2Hy7N+yF2w=
X-Google-Smtp-Source: AGHT+IEnhr3ahyypOkUp3wSLNt4z5714lFEU2AvrxADFIVShXeA6ReLC21IXA5ucF4iUL8XcjRwldA==
X-Received: by 2002:a05:6512:4859:b0:50b:fb93:bb02 with SMTP id ep25-20020a056512485900b0050bfb93bb02mr1201865lfb.115.1701950189592;
        Thu, 07 Dec 2023 03:56:29 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512074a00b0050bf1e8950esm154936lfs.10.2023.12.07.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 03:56:29 -0800 (PST)
Date:   Thu, 7 Dec 2023 14:56:25 +0300
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
Message-ID: <o3abmn7ocuksmjg23rrgsib7nfm4yo5rtzlqw2np2pplg73drd@7qe4vrsx2gyc>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On Wed, Dec 06, 2023 at 05:46:09PM -0600, Andrew Halaney wrote:
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

Thank you for the patch. Please find a comment below.

> 
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 85 ++++++++++------------
>  1 file changed, 37 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 1ffde555da47..7da461fe93f6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -296,69 +296,39 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
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
> + * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree
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
> -		dev_dbg(dev, "Found MDIO subnode\n");
> -		mdio = true;
> -	}
> -
> -	if (mdio) {
> -		plat->mdio_bus_data =
> -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> -				     GFP_KERNEL);
> -		if (!plat->mdio_bus_data)
> -			return -ENOMEM;
> -
> -		plat->mdio_bus_data->needs_reset = true;
> -	}
> -
> -	return 0;
> +	return mdio_node;
>  }
>  
>  /**
> @@ -417,6 +387,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_dma_cfg *dma_cfg;
> +	bool legacy_mdio;
>  	int phy_mode;
>  	void *ret;
>  	int rc;
> @@ -471,10 +442,28 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
>  		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
>  
> -	/* To Configure PHY by using all device-tree supported properties */
> -	rc = stmmac_dt_phy(plat, np, &pdev->dev);
> -	if (rc)
> -		return ERR_PTR(rc);
> +	plat->mdio_node = stmmac_of_get_mdio(np);
> +	if (plat->mdio_node)
> +		dev_dbg(&pdev->dev, "Found MDIO subnode\n");
> +

> +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> +	 * described assume this is the case since there must be something
> +	 * connected to the MAC.
> +	 */
> +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> +	if (legacy_mdio)
> +		dev_info(&pdev->dev, "Deprecated MDIO bus assumption used\n");
> +
> +	if (plat->mdio_node || legacy_mdio) {
> +		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> +						   sizeof(struct stmmac_mdio_bus_data),
> +						   GFP_KERNEL);
> +		if (!plat->mdio_bus_data)
> +			return ERR_PTR(-ENOMEM);
> +
> +		plat->mdio_bus_data->needs_reset = true;
> +	}

Why did you decide to move this out of the dedicated function?
stmmac_probe_config_dt() is already overwhelmed with various
non-coherent actions. The method has already got to being too long to
follow the kernel coding style limit (I have got a not submitted yet
cleanup patchset which step-by-step fixes that). Could you please get
the chunk above back to the respective function and, for instance,
just change it's name to something like stmmac_mdio_setup()? (I prefer
having "_setup" suffix because some of the locally defined static
methods already use it: stmmac_axi_setup(), stmmac_mtl_setup().)

-Serge(y)

>  
>  	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
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
