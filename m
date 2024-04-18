Return-Path: <linux-kernel+bounces-149704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759048A94CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25A7B22330
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA312F36C;
	Thu, 18 Apr 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtgPTzn7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0412FB21;
	Thu, 18 Apr 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428260; cv=none; b=RGVjr8QuglhXvYcPiH6L5t1/OdYhwq76B7aBoWSPKkoEDU4e8Z/4vHNyNV9G+suEc81orzdPpg4cMRSCVp/029tW0+Xp/XcZmsFQUp1i1GwpPKtYKAR9LoZPEHVTeI7Z7HsWX//lxXeSMXme/ziwQXxt05+feUdQ4VgCovMcxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428260; c=relaxed/simple;
	bh=CYDL0l4UBLOBtZRvohz/ZhWzYZtC9asa7c67MweOKtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZW9aWLmmxKZVY4Vzz4fj3evgFDiCjqYRRQSnidV/aFWscA5cb9FQs4qjdX9/stKAUJkCAO31M6px6Sr20t3OaK1rk2/Tbv8xj5p2KzkoJvNzNczaIIF8tpBRyAwnucezFUWR+bCwVxIn3F5aHeM6/kXfaXEXRpatTRRPcbv1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtgPTzn7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so563525e87.2;
        Thu, 18 Apr 2024 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713428238; x=1714033038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlNNcUScDIGSnpnqgWFU5e+3JX9/1lQWaa8cNUyZpso=;
        b=mtgPTzn7iUdY6igVEyqvquG26OyVGLdADF63MP2f/Ln7/7OdpCSD7x1VES0fFspJBP
         3bakELz3g1W4y79A7GMivW/ZKBmmLsSxAdFslUWGUQ/6QUzQ2ueFi423/XrgBF+pJcYt
         WVRiIrOYRXlWziVr0VNezEBzZTfXkra4FtwgMtZwCfmDqvlSHyDdEXQprAghFIbtqi8b
         S64+0PDRdnHK0mY9xVuvn9nWG0UhgQ5Ho/RNotisUWVbI1I72/k8zqDjoFmWJ6w1pcIa
         tXZx4WxeCvSk0+IMggvtIJZBQaO6+aRoX0mH5jmqJqtqn5M1FtYn5fTmSHXG/Az5w4Ia
         uzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713428238; x=1714033038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlNNcUScDIGSnpnqgWFU5e+3JX9/1lQWaa8cNUyZpso=;
        b=PuCt52F12pXk1/RzFAsfHb0kDV1TNkmAi2r5HK3QBl6DXsah4J35R58VqNC+6w5AI3
         aBuPCB2JiW7uUG0tIdWOcrcbFdpIVEhv3rsHS4ByvNflaV9ybyXwwAR+qGud293OILYp
         tTSVvitoMqLmXWUabrRLfL6dX06heUVs/0Y45o4cAzbTzNA2LnpoiDG6F9rtbeYckKyE
         F/sEYqd0vxSsRY1EqOsfJsyF83+QvClWma521+GoM6PszlGxGaY5ZdSN2tPqcrxq4AOB
         GryIGWHs9SXr/etfrYQVq9a0A0YN7XnAou46M7UD0oYq7TOWFttyCpuornbWM92x3mmz
         Rekw==
X-Forwarded-Encrypted: i=1; AJvYcCVaWmeAjST15iYThc7JgNyfr5zD8Ike6lmT5d3OLJWgua0EQ/1xJeYHg0863JDbnTvW/F1AiqDZA4e8tzsv67gDrh5WzY369gl2O2/48CNsD/b7zJTCbW0GEPuEiSG3XnijDGJV8gTpOna2891a3Vxeglo70XJROLGUWWX6Ip3pEg==
X-Gm-Message-State: AOJu0Yz9O8Yqf7JnS0zS+QD0YPwmHwOseUAeetXLAI+I8XHjsWvJFNpP
	0RvZAh0u4uXlUD15IeEsvR2AGly9Xz/wLxXDHKRjaC5Gphjh6IKAu3WduGaP
X-Google-Smtp-Source: AGHT+IEkl4oQ5eL+FkXyZ/IVZNia6d81ZoKJ3prwLaLO9l0/cT5rMB2dxps5UMONIgom/mkOG7+N7Q==
X-Received: by 2002:ac2:4c38:0:b0:517:61b1:45a6 with SMTP id u24-20020ac24c38000000b0051761b145a6mr930338lfq.53.1713428237445;
        Thu, 18 Apr 2024 01:17:17 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id e11-20020a05651236cb00b00515d1dfab34sm144215lfs.81.2024.04.18.01.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:17:17 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:17:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] net: ethernet: stmmac: rework glue to simplify
 management for next stm32
Message-ID: <peqz2hl6efyu25j26rpt6rqi5ovq4ymjvivfhczihnz4hf7w2o@akaiyvzuqjgo>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
 <20240411143658.1049706-4-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411143658.1049706-4-christophe.roullier@foss.st.com>

On Thu, Apr 11, 2024 at 04:36:50PM +0200, Christophe Roullier wrote:
> Change glue to be more generic and manage easily next stm32 products.
> The goal of this commit is to have one stm32mp1_set_mode function which
> can manage different STM32 SOC. SOC can have different SYSCFG register
> bitfields. so in pmcsetr we defined the bitfields corresponding to the SOC.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

[PATCH 03/11] net: ethernet: stmmac: rework glue to simplify management for next stm32

Just use the dwmac-stm32 prefix so you won't need to have the "for
next stm32" clause in all the commits. For instance like this:

[PATCH 03/11] net: stmmac: dwmac-stm32: rework glue to simplify management

the same for the patches 4 to 7.

-Serge(y)


> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 76 +++++++++++++------
>  1 file changed, 51 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index c92dfc4ecf570..68a02de25ac76 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -23,10 +23,6 @@
>  
>  #define SYSCFG_MCU_ETH_MASK		BIT(23)
>  #define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
> -#define SYSCFG_PMCCLRR_OFFSET		0x40
> -
> -#define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
> -#define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
>  
>  /* CLOCK feed to PHY*/
>  #define ETH_CK_F_25M	25000000
> @@ -46,9 +42,6 @@
>   * RMII  |   1	 |   0	  |   0	   |  n/a  |
>   *------------------------------------------
>   */
> -#define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
> -#define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
> -#define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
>  #define SYSCFG_PMCR_ETH_SEL_GMII	0
>  #define SYSCFG_MCU_ETH_SEL_MII		0
>  #define SYSCFG_MCU_ETH_SEL_RMII		1
> @@ -90,19 +83,33 @@ struct stm32_dwmac {
>  	int eth_ref_clk_sel_reg;
>  	int irq_pwr_wakeup;
>  	u32 mode_reg;		 /* MAC glue-logic mode register */
> +	u32 mode_mask;
>  	struct regmap *regmap;
>  	u32 speed;
>  	const struct stm32_ops *ops;
>  	struct device *dev;
>  };
>  
> +struct stm32_syscfg_pmcsetr {
> +	u32 eth1_clk_sel;
> +	u32 eth1_ref_clk_sel;
> +	u32 eth1_selmii;
> +	u32 eth1_sel_rgmii;
> +	u32 eth1_sel_rmii;
> +	u32 eth2_clk_sel;
> +	u32 eth2_ref_clk_sel;
> +	u32 eth2_sel_rgmii;
> +	u32 eth2_sel_rmii;
> +};
> +
>  struct stm32_ops {
>  	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
>  	int (*suspend)(struct stm32_dwmac *dwmac);
>  	void (*resume)(struct stm32_dwmac *dwmac);
>  	int (*parse_data)(struct stm32_dwmac *dwmac,
>  			  struct device *dev);
> -	u32 syscfg_eth_mask;
> +	u32 syscfg_clr_off;
> +	struct stm32_syscfg_pmcsetr pmcsetr;
>  	bool clk_rx_enable_in_suspend;
>  };
>  
> @@ -161,7 +168,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  {
>  	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>  	u32 reg = dwmac->mode_reg, clk_rate;
> -	int val;
> +	int val = 0;
>  
>  	clk_rate = clk_get_rate(dwmac->clk_eth_ck);
>  	dwmac->enable_eth_ck = false;
> @@ -169,7 +176,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_MII:
>  		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
>  			dwmac->enable_eth_ck = true;
> -		val = SYSCFG_PMCR_ETH_SEL_MII;
> +		val = dwmac->ops->pmcsetr.eth1_selmii;
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
>  		break;
>  	case PHY_INTERFACE_MODE_GMII:
> @@ -177,16 +184,17 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  		if (clk_rate == ETH_CK_F_25M &&
>  		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
>  			dwmac->enable_eth_ck = true;
> -			val |= SYSCFG_PMCR_ETH_CLK_SEL;
> +			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
>  		}
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
> -		val = SYSCFG_PMCR_ETH_SEL_RMII;
> +		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
>  		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
>  		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
>  			dwmac->enable_eth_ck = true;
> -			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
> +			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
> +			val |= dwmac->ops->pmcsetr.eth2_ref_clk_sel;
>  		}
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
>  		break;
> @@ -194,11 +202,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		val = SYSCFG_PMCR_ETH_SEL_RGMII;
> +		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
>  		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
>  		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
>  			dwmac->enable_eth_ck = true;
> -			val |= SYSCFG_PMCR_ETH_CLK_SEL;
> +			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
> +			val |= dwmac->ops->pmcsetr.eth2_clk_sel;
>  		}
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
>  		break;
> @@ -210,12 +219,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	}
>  
>  	/* Need to update PMCCLRR (clear register) */
> -	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
> -		     dwmac->ops->syscfg_eth_mask);
> +	regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
> +		     dwmac->mode_mask);
>  
>  	/* Update PMCSETR (set register) */
>  	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val);
> +				 dwmac->mode_mask, val);
>  }
>  
>  static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
> @@ -241,7 +250,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	}
>  
>  	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val << 23);
> +				 SYSCFG_MCU_ETH_MASK, val << 23);
>  }
>  
>  static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
> @@ -286,10 +295,17 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>  		return PTR_ERR(dwmac->regmap);
>  
>  	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
> +	if (err) {
> +		dev_err(dev, "Can't get sysconfig register offset (%d)\n", err);
> +		return err;
> +	}
> +
> +	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
> +	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
>  	if (err)
> -		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
> +		pr_debug("Warning sysconfig register mask not set\n");
>  
> -	return err;
> +	return 0;
>  }
>  
>  static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
> @@ -478,8 +494,7 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
>  	stm32_dwmac_suspend, stm32_dwmac_resume);
>  
>  static struct stm32_ops stm32mcu_dwmac_data = {
> -	.set_mode = stm32mcu_set_mode,
> -	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
> +	.set_mode = stm32mcu_set_mode
>  };
>  
>  static struct stm32_ops stm32mp1_dwmac_data = {
> @@ -487,8 +502,19 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>  	.suspend = stm32mp1_suspend,
>  	.resume = stm32mp1_resume,
>  	.parse_data = stm32mp1_parse_data,
> -	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
> -	.clk_rx_enable_in_suspend = true
> +	.clk_rx_enable_in_suspend = true,
> +	.syscfg_clr_off = 0x44,
> +	.pmcsetr = {
> +		.eth1_clk_sel		= BIT(16),
> +		.eth1_ref_clk_sel	= BIT(17),
> +		.eth1_selmii		= BIT(20),
> +		.eth1_sel_rgmii		= BIT(21),
> +		.eth1_sel_rmii		= BIT(23),
> +		.eth2_clk_sel		= 0,
> +		.eth2_ref_clk_sel	= 0,
> +		.eth2_sel_rgmii		= 0,
> +		.eth2_sel_rmii		= 0
> +	}
>  };
>  
>  static const struct of_device_id stm32_dwmac_match[] = {
> -- 
> 2.25.1
> 
> 

