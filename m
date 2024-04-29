Return-Path: <linux-kernel+bounces-161835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36898B5200
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E461F21871
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051E134DE;
	Mon, 29 Apr 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lc/I3oyZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791DEED4;
	Mon, 29 Apr 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374496; cv=none; b=VyLEdclmXUGSvqA1W6+cBt22ii9thrFI/hK7h6//UC2x0Q28hjzGJUN7y5Tn9whHa7sM7sibMsPCfBPo3OFhPz9vZudKNCXt0Rdm7heXIcbmlMKJlDlWV0wnvB1R16ND+pqxliQPBXT7xnwuE4rwX0ke/JynQkQq9rC7SO6u3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374496; c=relaxed/simple;
	bh=C2BxIS0N3dmWzQ9cgH+7pz/lzpzb+iCAx2gAwbADPHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hC1nvpFcUzSmfEreWQ3MvbNdOhhw8WdJYDDBIC5uo5E7yVwySXbINEvVt+VUPEwozZlrMitjJLSI/S8wMaA0UXamG1cEMIahZLljAN5xVW5js3FpmcCSjbPd1iiaquwM7ZDMzy4Z6IsWx/Nei+Pq8kDuWTIjkd5e6Tx6PuWUdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lc/I3oyZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714374494; x=1745910494;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=C2BxIS0N3dmWzQ9cgH+7pz/lzpzb+iCAx2gAwbADPHY=;
  b=Lc/I3oyZH5tCb57cPVvBlKgGbySUDYNXrS7Pfm/hgb6ZIcpQ8JTGTFPg
   JvUIpguLnvqQak+9h7SiDP5S7chdyuLm9S1Z01NOvxL9YTWcuvMoSwHpd
   fmvRQur0BedGPIMDjmDu23x4XL4YBeJeM+tCINWfGfdFprO4HT5g/BKr2
   796f0nypTEnIq00g5w+VGL531AHqpTxes426yakCWCFBPqSo3Kn3Qu/RZ
   hXjoz+MNhNa3IM8RprwIBeJlAEPi1PsmY3/s1RIwmVW415QZHfiUAUDhm
   u+KtOqRhbnKzh9FfsBCyG4Bp2Z0jCZTN0r6XEPc3F4P+BjE4vKientiHZ
   w==;
X-CSE-ConnectionGUID: QKMksg49RzqKDnoeKSDOvQ==
X-CSE-MsgGUID: xU+aLn5SRpigVnaxbyrktw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27475166"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27475166"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 00:08:13 -0700
X-CSE-ConnectionGUID: FYnyvPCcR1mW/gt0AA+Tog==
X-CSE-MsgGUID: tjGHuoAcSHqLPE0fsKe/vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26022810"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.71])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 00:08:07 -0700
Message-ID: <ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com>
Date: Mon, 29 Apr 2024 10:08:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc_priv
To: Chen Wang <unicornxw@gmail.com>, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jszhang@kernel.org,
 dfustini@baylibre.com, yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com, guoren@kernel.org, inochiama@outlook.com,
 unicorn_wang@outlook.com
References: <cover.1714270290.git.unicorn_wang@outlook.com>
 <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/04/24 05:32, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> The current framework is not easily extended to support new SOCs.
> For example, in the current code we see that the SOC-level
> structure `rk35xx_priv` and related logic are distributed in
> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
> which is inappropriate.
> 
> The solution is to abstract some possible common operations of soc
> into virtual members of `dwcmshc_priv`. Each soc implements its own
> corresponding callback function and registers it in init function.
> dwcmshc framework is responsible for calling these callback functions
> in those dwcmshc_xxx functions.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 152 +++++++++++++++++-----------
>  1 file changed, 91 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 39edf04fedcf..525f954bcb65 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -214,6 +214,10 @@ struct dwcmshc_priv {
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
> +
> +	void (*soc_postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	int (*soc_clks_enable)(struct dwcmshc_priv *dwc_priv);
> +	void (*soc_clks_disable)(struct dwcmshc_priv *dwc_priv);

Normally the ops would be part of platform data.  For example,
sdhci-of-arasan.c has:

	struct sdhci_arasan_of_data {
		const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
		const struct sdhci_pltfm_data *pdata;
		const struct sdhci_arasan_clk_ops *clk_ops;
	};

And then:

	static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
		.soc_ctl_map = &rk3399_soc_ctl_map,
		.pdata = &sdhci_arasan_cqe_pdata,
		.clk_ops = &arasan_clk_ops,
	};
	etc

	static const struct of_device_id sdhci_arasan_of_match[] = {
		/* SoC-specific compatible strings w/ soc_ctl_map */
		{
			.compatible = "rockchip,rk3399-sdhci-5.1",
			.data = &sdhci_arasan_rk3399_data,
		},
		etc

So, say:

struct dwcmshc_pltfm_data {
	const struct sdhci_pltfm_data *pltfm_data;
	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
}

Or if the ops are mostly the same, it might be more convenient to
have them in their own structure:

struct dwcmshc_pltfm_data {
	const struct sdhci_pltfm_data *pltfm_data;
	const struct dwcmshc_ops *ops;
}

>  };
>  
>  /*
> @@ -1033,10 +1037,40 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
>  }
>  
> -static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static int dwcmshc_rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
>  {
> -	int err;
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	int ret = 0;
> +
> +	if (priv)
> +		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
> +	return ret;
> +}
> +
> +static void dwcmshc_rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
> +{
> +	struct rk35xx_priv *priv = dwc_priv->priv;
> +
> +	if (priv)
> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> +					   priv->rockchip_clks);
> +}
> +
> +static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);

Avoid forward declarations if possible.  If necessary, it is
preferable to move the function definition.

> +static int dwcmshc_rk35xx_init(struct device *dev,
> +			       struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)

This patch looks like it might be doing too much.  Please consider
splitting it so reorganising the code is separate from adding the
callbacks.

> +{
> +	int err;
> +	struct rk35xx_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
> +		priv->devtype = DWCMSHC_RK3588;
> +	else
> +		priv->devtype = DWCMSHC_RK3568;
>  
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
> @@ -1071,6 +1105,11 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
>  
> +	dwc_priv->priv = priv;
> +	dwc_priv->soc_postinit = dwcmshc_rk35xx_postinit;
> +	dwc_priv->soc_clks_enable = dwcmshc_rk35xx_clks_enable;
> +	dwc_priv->soc_clks_disable = dwcmshc_rk35xx_clks_disable;
> +
>  	return 0;
>  }
>  
> @@ -1088,6 +1127,35 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
>  	}
>  }
>  
> +static int dwcmshc_th1520_init(struct device *dev,
> +			       struct sdhci_host *host,
> +			       struct dwcmshc_priv *dwc_priv)
> +{
> +	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> +
> +	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> +	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> +	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	else
> +		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
> +
> +	/*
> +	 * start_signal_voltage_switch() will try 3.3V first
> +	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
> +	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> +	 * in sdhci_start_signal_voltage_switch().
> +	 */
> +	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		host->flags |=  SDHCI_SIGNALING_180;
> +	}
> +
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
> @@ -1134,7 +1202,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
> -	struct rk35xx_priv *rk_priv = NULL;
>  	const struct sdhci_pltfm_data *pltfm_data;
>  	int err;
>  	u32 extra, caps;
> @@ -1191,46 +1258,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>  
>  	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
> -		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
> -		if (!rk_priv) {
> -			err = -ENOMEM;
> -			goto err_clk;
> -		}
> -
> -		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
> -			rk_priv->devtype = DWCMSHC_RK3588;
> -		else
> -			rk_priv->devtype = DWCMSHC_RK3568;
> -
> -		priv->priv = rk_priv;
> -
> -		err = dwcmshc_rk35xx_init(host, priv);
> +		err = dwcmshc_rk35xx_init(dev, host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
>  
>  	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> -		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> -
> -		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> -		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> -		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
> -			priv->flags |= FLAG_IO_FIXED_1V8;
> -		else
> -			priv->flags &= ~FLAG_IO_FIXED_1V8;
> -
> -		/*
> -		 * start_signal_voltage_switch() will try 3.3V first
> -		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
> -		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> -		 * in sdhci_start_signal_voltage_switch().
> -		 */
> -		if (priv->flags & FLAG_IO_FIXED_1V8) {
> -			host->flags &= ~SDHCI_SIGNALING_330;
> -			host->flags |=  SDHCI_SIGNALING_180;
> -		}
> -
> -		sdhci_enable_v4_mode(host);
> +		err = dwcmshc_th1520_init(dev, host, priv);
> +		if (err)
> +			goto err_clk;
>  	}
>  
>  #ifdef CONFIG_ACPI
> @@ -1260,8 +1296,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		dwcmshc_cqhci_init(host, pdev);
>  	}
>  
> -	if (rk_priv)
> -		dwcmshc_rk35xx_postinit(host, priv);
> +	if (priv->soc_postinit)
> +		priv->soc_postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);
>  	if (err)
> @@ -1279,9 +1315,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->soc_clks_disable)
> +		priv->soc_clks_disable(priv);
> +
>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -1303,7 +1339,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -1315,9 +1350,9 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->soc_clks_disable)
> +		priv->soc_clks_disable(priv);
> +
>  	sdhci_pltfm_free(pdev);
>  }
>  
> @@ -1327,7 +1362,6 @@ static int dwcmshc_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	pm_runtime_resume(dev);
> @@ -1346,9 +1380,8 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
>  
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->soc_clks_disable)
> +		priv->soc_clks_disable(priv);
>  
>  	return ret;
>  }
> @@ -1358,7 +1391,6 @@ static int dwcmshc_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	ret = clk_prepare_enable(pltfm_host->clk);
> @@ -1371,29 +1403,27 @@ static int dwcmshc_resume(struct device *dev)
>  			goto disable_clk;
>  	}
>  
> -	if (rk_priv) {
> -		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
> -					      rk_priv->rockchip_clks);
> +	if (priv->soc_clks_enable) {
> +		ret = priv->soc_clks_enable(priv);
>  		if (ret)
>  			goto disable_bus_clk;
>  	}
>  
>  	ret = sdhci_resume_host(host);
>  	if (ret)
> -		goto disable_rockchip_clks;
> +		goto disable_soc_clks;
>  
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_resume(host->mmc);
>  		if (ret)
> -			goto disable_rockchip_clks;
> +			goto disable_soc_clks;
>  	}
>  
>  	return 0;
>  
> -disable_rockchip_clks:
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +disable_soc_clks:
> +	if (priv->soc_clks_disable)
> +		priv->soc_clks_disable(priv);
>  disable_bus_clk:
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);


