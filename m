Return-Path: <linux-kernel+bounces-36661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899F83A4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD791F224C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2117BA0;
	Wed, 24 Jan 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wm7G64nC"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51927179A6;
	Wed, 24 Jan 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086612; cv=none; b=Zlk7CeSHs64gjTqup7po0iikvPka40bSNgFfevaO4nz8A8kVqQtuDkjdMNXm43EUOFeLBDtSoe5M73tpRWHtttTe9CiAg2Acf9Sncmb2QVaGm8SS8RdwLSwtQg9djWkDQnCal8UZ9KySX53JtyTlCYJoiLHjsCbVEXuPHj/JE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086612; c=relaxed/simple;
	bh=/OD/2t1TGBsqUf0HAmljucfP4HVknb+V4wrjgny/K/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5C2G8m5G6jJBuE2NyaWXHR/KeTq5UMfInnM6oxVzhVoNfH10nnVh31WdBdbNIcTFtRQQ2H/yptMeelqk/i29qeFnlFJSbrPhKLXnLoLFL7aaaidOBIUvdVRV+5NxugfJ3Q2KdikD3gtFYy+xshBiWPXNFRMSySlbjB+BuV8uWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wm7G64nC; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FD3A6000F;
	Wed, 24 Jan 2024 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706086607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dF9DvtTO2eIsCU2bgzByEO8VGGB2vesiCczCBU+W1pQ=;
	b=Wm7G64nCNIrNzMPw3lSWmtdk+9mxBKQCtEtvj/NY7RvCo1o50gz0X4YTJjZdMfW7tTgPWc
	/ebrHmoflEiO8tRKJM5+g/xAcrZNRg46FfNOjQKLby0pRvJq/cumMVN/Nm1AZFLGTx74RM
	EgS2znhNWkdG+fOilYaVe3dgY1j8eAHgA7WE11QYDUGS1/Ve7Qj+voEnMZ60Di7cVq0E+h
	M6lawpcHqjWzSL+rXIFcadQdwhj1GCmZuBOj4VHWguXVVutuBdlnN2xws5JD6uHDUXqqwF
	Kgooaxax88pA6KjUEBx7Mi7nIokr3NILjaM34p0Xzy4U9GS90/DQeFWYLn8ZIQ==
Message-ID: <41a5c85b-073d-4083-be9e-830452f88438@bootlin.com>
Date: Wed, 24 Jan 2024 09:56:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Content-Language: en-US
To: rafael@kernel.org, daniel.lezcano@linaro.org, J KEERTHY <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com
References: <20231130164953.2043305-1-thomas.richard@bootlin.com>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231130164953.2043305-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

Added Keerthy

On 11/30/23 17:49, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.
> 
> The derived_table is kept-as is, so the resume is only about
> pm_runtime_* calls and restoring the same registers as the probe.
> 
> Extract the hardware initialization procedure to a function called at
> both probe-time & resume-time.
> 
> The probe-time loop is split in two to ensure doing the hardware
> initialization before registering thermal zones. That ensures our
> callbacks cannot be called while in bad state.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> 
> v2:
> - Fix warnings/errors reported by kernel test robot
> 
>  drivers/thermal/k3_j72xx_bandgap.c | 112 ++++++++++++++++++++---------
>  1 file changed, 79 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index c74094a86982..4ad23c8bf73b 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -178,6 +178,7 @@ struct k3_j72xx_bandgap {
>  	void __iomem *base;
>  	void __iomem *cfg2_base;
>  	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
> +	int cnt;
>  };
>  
>  /* common data structures */
> @@ -338,24 +339,53 @@ static void print_look_up_table(struct device *dev, int *ref_table)
>  		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
>  }
>  
> +static void k3_j72xx_bandgap_init_hw(struct k3_j72xx_bandgap *bgp)
> +{
> +	struct k3_thermal_data *data;
> +	int id, high_max, low_temp;
> +	u32 val;
> +
> +	for (id = 0; id < bgp->cnt; id++) {
> +		data = bgp->ts_data[id];
> +		val = readl(bgp->cfg2_base + data->ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> +			K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> +		writel(val, bgp->cfg2_base + data->ctrl_offset);
> +	}
> +
> +	/*
> +	 * Program TSHUT thresholds
> +	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> +	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> +	 *         This is already taken care as per of init
> +	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> +	 */
> +	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> +	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> +
> +	writel((low_temp << 16) | high_max, bgp->cfg2_base + K3_VTM_MISC_CTRL2_OFFSET);
> +	mdelay(100);
> +	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, bgp->cfg2_base + K3_VTM_MISC_CTRL_OFFSET);
> +}
> +
>  struct k3_j72xx_bandgap_data {
>  	const bool has_errata_i2128;
>  };
>  
>  static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  {
> -	int ret = 0, cnt, val, id;
> -	int high_max, low_temp;
> -	struct resource *res;
> +	const struct k3_j72xx_bandgap_data *driver_data;
> +	struct thermal_zone_device *ti_thermal;
>  	struct device *dev = &pdev->dev;
> +	bool workaround_needed = false;
>  	struct k3_j72xx_bandgap *bgp;
>  	struct k3_thermal_data *data;
> -	bool workaround_needed = false;
> -	const struct k3_j72xx_bandgap_data *driver_data;
> -	struct thermal_zone_device *ti_thermal;
> -	int *ref_table;
>  	struct err_values err_vals;
>  	void __iomem *fuse_base;
> +	int ret = 0, val, id;
> +	struct resource *res;
> +	int *ref_table;
>  
>  	const s64 golden_factors[] = {
>  		-490019999999999936,
> @@ -422,10 +452,10 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  
>  	/* Get the sensor count in the VTM */
>  	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
> -	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> -	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
> +	bgp->cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> +	bgp->cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
>  
> -	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
> +	data = devm_kcalloc(bgp->dev, bgp->cnt, sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		ret = -ENOMEM;
>  		goto err_alloc;
> @@ -449,8 +479,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  	else
>  		init_table(3, ref_table, pvt_wa_factors);
>  
> -	/* Register the thermal sensors */
> -	for (id = 0; id < cnt; id++) {
> +	/* Precompute the derived table & fill each thermal sensor struct */
> +	for (id = 0; id < bgp->cnt; id++) {
>  		data[id].bgp = bgp;
>  		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
>  		data[id].stat_offset = data[id].ctrl_offset +
> @@ -470,13 +500,13 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  		else if (id == 0 && !workaround_needed)
>  			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
>  
> -		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
> -		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> -			K3_VTM_TMPSENS_CTRL_SOC |
> -			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> -		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
> -
>  		bgp->ts_data[id] = &data[id];
> +	}
> +
> +	k3_j72xx_bandgap_init_hw(bgp);
> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < bgp->cnt; id++) {
>  		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
>  							   &k3_of_thermal_ops);
>  		if (IS_ERR(ti_thermal)) {
> @@ -486,21 +516,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	/*
> -	 * Program TSHUT thresholds
> -	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> -	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> -	 *         This is already taken care as per of init
> -	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> -	 */
> -	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> -	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> -
> -	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
> -	       K3_VTM_MISC_CTRL2_OFFSET);
> -	mdelay(100);
> -	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
> -	       K3_VTM_MISC_CTRL_OFFSET);
> +	platform_set_drvdata(pdev, bgp);
>  
>  	print_look_up_table(dev, ref_table);
>  	/*
> @@ -527,6 +543,35 @@ static void k3_j72xx_bandgap_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> +static int __maybe_unused k3_j72xx_bandgap_suspend(struct device *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return 0;
> +}
> +
> +static int __maybe_unused k3_j72xx_bandgap_resume(struct device *dev)
> +{
> +	struct k3_j72xx_bandgap *bgp = dev_get_drvdata(dev);
> +	int ret;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	k3_j72xx_bandgap_init_hw(bgp);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops k3_j72xx_bandgap_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(k3_j72xx_bandgap_suspend, k3_j72xx_bandgap_resume)
> +};
> +
>  static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
>  	.has_errata_i2128 = true,
>  };
> @@ -554,6 +599,7 @@ static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
>  	.driver = {
>  		.name = "k3-j72xx-soc-thermal",
>  		.of_match_table	= of_k3_j72xx_bandgap_match,
> +		.pm = &k3_j72xx_bandgap_pm_ops,
>  	},
>  };
>  
-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


