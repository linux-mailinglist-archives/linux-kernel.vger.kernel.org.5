Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C6763682
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjGZMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGZMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:41:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48631FDA;
        Wed, 26 Jul 2023 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690375296; x=1721911296;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ETDxxOU+t5OdI9Iv6qVt7WaoqDevvPEJRI39rXKuOmU=;
  b=lsBw+pzrzwnETjHnu/fj7RuparAhNU2HM4rRbINkuJiKoDDeWphPyLz2
   +p6NiuWgbqgn0/PRilAf2U/UWVfnXXwORUPY7+kSdTiZsoKM4Us4Befo8
   mIPEdmviMP2IOAZiRVpJEuAhAQFWC6wOHUHgEp2l/0GmcVhRng9QZQiAk
   R2wAEn5cT1OgAq+c+4wb4Zex2ky3cQ+vOWldrjIpPbBqprd/wjLnEQvlF
   vvZ7hguLdyQKdaT4HigbrZVn2iDM/p7rOdfuTec2Ah/u/ND84w7eKAHw3
   +W4U0OnS9/TdXZBzY15DkcO0/TnUE9HT44NFBibJzW8S/PED2+GdrL8BO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347617488"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="347617488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676683362"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="676683362"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:41:32 -0700
Message-ID: <165b51d9-a9c8-1fea-f847-d3ce3757a7bd@intel.com>
Date:   Wed, 26 Jul 2023 15:41:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 1/6] mmc: sdhci-cadence: Rename functions/structures to
 SD4 specific
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-2-pmalgujar@marvell.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230717125146.16791-2-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/23 15:51, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Renaming the functions and structures specific to SD4 so
> that it can be separated from upcoming SD6 related
> functionality.
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 92 ++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index d2f62505468932b069e3411f2a4b7418ffece517..9bb38281bcb244b0be91ef579046c40de7a06e1f 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -16,14 +16,14 @@
>  
>  #include "sdhci-pltfm.h"
>  
> -/* HRS - Host Register Set (specific to Cadence) */
> -#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> -#define   SDHCI_CDNS_HRS04_ACK			BIT(26)> -#define   SDHCI_CDNS_HRS04_RD			BIT(25)
> -#define   SDHCI_CDNS_HRS04_WR			BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
> -#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
> -#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
> +/* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */ where
> +#define SDHCI_CDNS_HRS04			0x10	/* PHY access port */
> +#define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
> +#define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
> +#define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
> +#define SDHCI_CDNS_SD4_HRS04_RDATA		GENMASK(23, 16)
> +#define SDHCI_CDNS_SD4_HRS04_WDATA		GENMASK(15, 8)
> +#define SDHCI_CDNS_SD4_HRS04_ADDR		GENMASK(5, 0)

You have changed the style whereby the register and the fields
had different indentations (compare SDHCI_CDNS_HRS04 and
SDHCI_CDNS_HRS04_ACK).  The style doesn't matter much but it
would be nicer not to end up with a mix of styles.

It is also a bit surprising not to continue using the register
name as the prefix for the field name
e.g. why SDHCI_CDNS_SD4_HRS04_ACK instead of SDHCI_CDNS_HRS04_SD4_ACK

>  
>  #define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
>  #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
> @@ -39,7 +39,7 @@
>  /* SRS - Slot Register Set (SDHCI-compatible) */
>  #define SDHCI_CDNS_SRS_BASE		0x200
>  
> -/* PHY */
> +/* PHY registers for SD4 controller */
>  #define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
>  #define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
>  #define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
> @@ -60,7 +60,7 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> -struct sdhci_cdns_phy_param {
> +struct sdhci_cdns_sd4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
> @@ -73,10 +73,10 @@ struct sdhci_cdns_priv {
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> -	struct sdhci_cdns_phy_param phy_params[];
> +	struct sdhci_cdns_sd4_phy_param phy_params[];
>  };
>  
> -struct sdhci_cdns_phy_cfg {
> +struct sdhci_cdns_sd4_phy_cfg {
>  	const char *property;
>  	u8 addr;
>  };
> @@ -86,7 +86,7 @@ struct sdhci_cdns_drv_data {
>  	const struct sdhci_pltfm_data pltfm_data;
>  };
>  
> -static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> +static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
>  	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> @@ -106,76 +106,76 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>  	writel(val, reg);
>  }
>  
> -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -				    u8 addr, u8 data)
> +static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
> +					u8 addr, u8 data)
>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
>  	int ret;
>  
> -	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> +	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
>  				 0, 10);
>  	if (ret)
>  		return ret;
>  
> -	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
> -	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
> +	tmp = FIELD_PREP(SDHCI_CDNS_SD4_HRS04_WDATA, data) |
> +	      FIELD_PREP(SDHCI_CDNS_SD4_HRS04_ADDR, addr);
>  	priv->priv_writel(priv, tmp, reg);
>  
> -	tmp |= SDHCI_CDNS_HRS04_WR;
> +	tmp |= SDHCI_CDNS_SD4_HRS04_WR;
>  	priv->priv_writel(priv, tmp, reg);
>  
> -	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
> +	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_SD4_HRS04_ACK, 0, 10);
>  	if (ret)
>  		return ret;
>  
> -	tmp &= ~SDHCI_CDNS_HRS04_WR;
> +	tmp &= ~SDHCI_CDNS_SD4_HRS04_WR;
>  	priv->priv_writel(priv, tmp, reg);
>  
> -	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> +	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
>  				 0, 10);
>  
>  	return ret;
>  }
>  
> -static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
> +static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
>  {
>  	unsigned int count = 0;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
> -		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++)
> +		if (of_property_read_bool(np, sdhci_cdns_sd4_phy_cfgs[i].property))
>  			count++;
>  
>  	return count;
>  }
>  
> -static void sdhci_cdns_phy_param_parse(struct device_node *np,
> -				       struct sdhci_cdns_priv *priv)
> +static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
> +					   struct sdhci_cdns_priv *priv)
>  {
> -	struct sdhci_cdns_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
> -		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++) {
> +		ret = of_property_read_u32(np, sdhci_cdns_sd4_phy_cfgs[i].property,
>  					   &val);
>  		if (ret)
>  			continue;
>  
> -		p->addr = sdhci_cdns_phy_cfgs[i].addr;
> +		p->addr = sdhci_cdns_sd4_phy_cfgs[i].addr;
>  		p->data = val;
>  		p++;
>  	}
>  }
>  
> -static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
>  
>  	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
> -					       priv->phy_params[i].data);
> +		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
> +						   priv->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -218,7 +218,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>  
> -static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
> +static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
>  	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
> @@ -271,7 +271,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		return 0;
>  
>  	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
> -		if (sdhci_cdns_set_tune_val(host, i) ||
> +		if (sdhci_cdns_sd4_set_tune_val(host, i) ||
>  		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
>  			cur_streak = 0;
>  		} else { /* good */
> @@ -288,7 +288,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		return -EIO;
>  	}
>  
> -	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
> +	return sdhci_cdns_sd4_set_tune_val(host, end_of_streak - max_streak / 2);
>  }
>  
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> @@ -410,7 +410,7 @@ static int elba_drv_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct sdhci_ops sdhci_cdns_ops = {
> +static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -421,7 +421,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +	.ops = &sdhci_cdns_sd4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
>  };
> @@ -433,9 +433,9 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
>  	},
>  };
>  
> -static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +static const struct sdhci_cdns_drv_data sdhci_cdns_sd4_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns_sd4_ops,
>  	},
>  };
>  
> @@ -497,9 +497,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns_drv_data;
> +		data = &sdhci_cdns_sd4_drv_data;
>  
> -	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> +	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
>  	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>  				struct_size(priv, phy_params, nr_phy_params));
>  	if (IS_ERR(host)) {
> @@ -532,9 +532,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> -	sdhci_cdns_phy_param_parse(dev->of_node, priv);
> +	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns_sd4_phy_init(priv);
>  	if (ret)
>  		goto free;
>  
> @@ -574,7 +574,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns_sd4_phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  

