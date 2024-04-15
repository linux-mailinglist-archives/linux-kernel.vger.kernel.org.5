Return-Path: <linux-kernel+bounces-144628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEE8A488D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321F5B23A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C62C1B9;
	Mon, 15 Apr 2024 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcUdgbnE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81F2940F;
	Mon, 15 Apr 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164319; cv=none; b=Et41jJ/8iuRyDU/CsMhg8mwIc6UJ9ljMniHvHrOGeykLOv4UwMBm64TQepKgvSUC5G4jWPgyrnHxapabsP4sjg50tkztzTTvQQABvJTzzwcutmXFQTbOXLbJQyopQzPsnyCTGSpqkipPg/Hj+c6WddsTSIrY/vLRPkUrKgi07v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164319; c=relaxed/simple;
	bh=MjpXaim/P8mM167opCuJ1D7Qz1gNtJb4q3g3a6eERx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4qWpj22lMHTydYlUXBmhiIW1Syl/vFKZeJdMTGvLek3kQzl13SBdrfIzCzSaOquOXuSVrAhYti8A3nDM9zg5vOUKyfeBqfyOKDagwCB48zxUSooHfP//ZBNgLAmkSEuTCedo5GhrkcvrVxFRibrHUS9MVqQX9PVhNttRgAmth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcUdgbnE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164318; x=1744700318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MjpXaim/P8mM167opCuJ1D7Qz1gNtJb4q3g3a6eERx8=;
  b=EcUdgbnEjfFMn+TWuQXeQh+cfvCX6gWIRJ28EddqDEDXTWT7AGkNa6sN
   /gqsZmdIRzlmwmbOuH469w3C7m0j5G40d/BV1h5yJkYAArMlhV4UgaB0K
   XDhkVhCHak3TcaXo0N6z7og5jxawgswu+RqIubuQ+OEL5BXrz4q7HqyTm
   WVyyq6LLssu0UNss6+glWA/y/WvTw0y2bxAPGYn6jTieT3SgoDidg2C1I
   HOhcVyLWC3td3zceOQXUrWByohQrzWEZEJ+lBO6u0fTufwxwJX3bcjJyy
   n2Mqk/YFlphe2fWniuISwbGtBDIx2CDgKH1KGqIKScAR8+RDCyIT81LlV
   A==;
X-CSE-ConnectionGUID: 9YgG5YTVS42JvNi2y78zNg==
X-CSE-MsgGUID: XnoQWXhfSQuKsUoEo9R3Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="31016424"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="31016424"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:58:38 -0700
X-CSE-ConnectionGUID: ZvTG74JWSrGYcMRo7Rha4w==
X-CSE-MsgGUID: cW8sPqsJSry5fDpGGROAeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26620492"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.19])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:58:36 -0700
Message-ID: <c6c041d4-d9ed-46bb-9e6e-b53dc9ac0002@intel.com>
Date: Mon, 15 Apr 2024 09:58:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Add tuning support for Sophgo
 CV1800B and SG200X
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240414164112.2732-1-jszhang@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240414164112.2732-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/24 19:41, Jisheng Zhang wrote:
> Implement the .platform_execute_tuning for Sophgo CV1800B and SG200X.
> Some code is borrowed from sdhci-esdhc-imx.c. The tuning result is
> similar as the one of SoC vendor's SDK.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

One comment, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 112 ++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ab4b964d4058..7b55acd9830c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -66,6 +66,10 @@
>  #define CV18XX_SDHCI_PHY_CONFIG			0x4c
>  #define  CV18XX_PHY_TX_BPS			BIT(0)
>  
> +#define CV18XX_TUNE_MAX				128
> +#define CV18XX_TUNE_STEP			1
> +#define CV18XX_RETRY_TUNING_MAX			50
> +
>  /* Rockchip specific Registers */
>  #define DWCMSHC_EMMC_DLL_CTRL		0x800
>  #define DWCMSHC_EMMC_DLL_RXCLK		0x804
> @@ -685,6 +689,113 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
>  }
>  
> +static void cv18xx_sdhci_set_tap(struct sdhci_host *host, int tap)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 clk;
> +	u32 val;
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> +	val &= ~CV18XX_LATANCY_1T;
> +	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> +
> +	val =  (FIELD_PREP(CV18XX_PHY_TX_DLY_MSK, 0) |
> +		FIELD_PREP(CV18XX_PHY_TX_SRC_MSK, CV18XX_PHY_TX_SRC_INVERT_CLK_TX) |
> +		FIELD_PREP(CV18XX_PHY_RX_DLY_MSK, tap));
> +	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
> +
> +	sdhci_writel(host, 0, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_CONFIG);
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	mdelay(1);

Did you consider usleep_range() instead of mdelay()?

> +}
> +
> +static int cv18xx_retry_tuning(struct mmc_host *mmc, u32 opcode, int *cmd_error)
> +{
> +	int ret, retry = 0;
> +
> +	while (retry < CV18XX_RETRY_TUNING_MAX) {
> +		ret = mmc_send_tuning(mmc, opcode, NULL);
> +		if (ret)
> +			return ret;
> +		retry++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
> +{
> +	u32 val;
> +
> +	val = sdhci_readl(host, SDHCI_INT_STATUS);
> +	val |= SDHCI_INT_DATA_AVAIL;
> +	sdhci_writel(host, val, SDHCI_INT_STATUS);
> +
> +	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +}
> +
> +static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int min, max, avg, ret;
> +	int win_length, target_min, target_max, target_win_length;
> +
> +	min = max = 0;
> +	target_win_length = 0;
> +
> +	sdhci_reset_tuning(host);
> +
> +	while (max < CV18XX_TUNE_MAX) {
> +		/* find the mininum delay first which can pass tuning */
> +		while (min < CV18XX_TUNE_MAX) {
> +			cv18xx_sdhci_set_tap(host, min);
> +			if (!cv18xx_retry_tuning(host->mmc, opcode, NULL))
> +				break;
> +			min += CV18XX_TUNE_STEP;
> +		}
> +
> +		/* find the maxinum delay which can not pass tuning */
> +		max = min + CV18XX_TUNE_STEP;
> +		while (max < CV18XX_TUNE_MAX) {
> +			cv18xx_sdhci_set_tap(host, max);
> +			if (cv18xx_retry_tuning(host->mmc, opcode, NULL)) {
> +				max -= CV18XX_TUNE_STEP;
> +				break;
> +			}
> +			max += CV18XX_TUNE_STEP;
> +		}
> +
> +		win_length = max - min + 1;
> +		/* get the largest pass window */
> +		if (win_length > target_win_length) {
> +			target_win_length = win_length;
> +			target_min = min;
> +			target_max = max;
> +		}
> +
> +		/* continue to find the next pass window */
> +		min = max + CV18XX_TUNE_STEP;
> +	}
> +
> +	cv18xx_sdhci_post_tuning(host);
> +
> +	/* use average delay to get the best timing */
> +	avg = (target_min + target_max) / 2;
> +	cv18xx_sdhci_set_tap(host, avg);
> +	ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +
> +	dev_dbg(mmc_dev(host->mmc), "tuning %s at 0x%x ret %d\n",
> +		ret ? "failed" : "passed", avg, ret);
> +
> +	return ret;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -721,6 +832,7 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
>  	.get_max_clock		= dwcmshc_get_max_clock,
>  	.reset			= cv18xx_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.platform_execute_tuning = cv18xx_sdhci_execute_tuning,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {


