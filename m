Return-Path: <linux-kernel+bounces-118786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E587388BF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DEE1C3D696
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6A6CDCF;
	Tue, 26 Mar 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjIXOk+I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC13DABE8;
	Tue, 26 Mar 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448728; cv=none; b=Q6Fb5gMSUibfDRec98Oqx8fbe848rgDY1DYNu1e3fO80/SbBnGkKXsJBV9x4W2blYEcz2LcIAwHXJ1HUnZ4FbPaGlKgKzpPHDvKimVfxR+g+teXR0Jud++qIoE7JU5/mLrIjhaSFotCbhFdfdawDJq3v8z7tP/QbmLT8Z7pTiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448728; c=relaxed/simple;
	bh=apIKmvfoqCCziBUKxRgHaz8L8n5IlOgWUbMMp/ziAZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agbHmvOTM96H352vMAmNpNsM4jb3XH35hwkY7unGOxZh0X/OB3JZULaTBa/m81v56PrWcAdPbbCpwhU/osin2vgYvJPIdeV3psQB6iVjxiRF05TGnb5nWrKpXJ5m/dfcF3AhNFbUa4amfiVAZ4DZLP+J46eWS1bqB4q/3DbBgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjIXOk+I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448726; x=1742984726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apIKmvfoqCCziBUKxRgHaz8L8n5IlOgWUbMMp/ziAZg=;
  b=CjIXOk+IqgANgAAZfcbMCl+6qJbiUe6OpFmeltd5XOsKmuuYcFuowZwS
   uO3kh2V3S6X8ZfsiCcEjPZ0UNEas2Dqtf7LZP9RvIZw52oq16ne4uKYwj
   K64wzeWYIhTFKZspQX8f+eTSAphbMWcRTF7vfiv770DNIyq4m3GI8EN1h
   4Hrn7eU+DoSZS8xtRDKxpsFuBJi6xMlOc31ncmrlSusUZdBy+zEtSM9BP
   X/KVjw0KZQO/P3122DHUiQbwVdb7cHCwSS0hBETt+SV9ho36hIGqXoLg6
   qLl3ZtwmVpJB1CTQQEFbNwQuNZIsjWOJXX15acSjqJ2N/++9gQYlBw23y
   g==;
X-CSE-ConnectionGUID: fKXYkTq4QzeRVtq3Js6oTw==
X-CSE-MsgGUID: 6+utZfqWRJav+n/wO334Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6702712"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6702712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15835316"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.215])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:25:22 -0700
Message-ID: <2e712cf6-7521-4c0b-b6fd-76bacc309496@intel.com>
Date: Tue, 26 Mar 2024 12:25:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
To: Mantas Pucka <mantas@8devices.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Pramod Gurav <pramod.gurav@linaro.org>,
 Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/24 16:30, Mantas Pucka wrote:
> Generic sdhci code registers LED device and uses host->runtime_suspended
> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
> which causes a crash when LED is accessed while controller is runtime
> suspended. Fix this by setting the flag correctly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
> Signed-off-by: Mantas Pucka <mantas@8devices.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 668e0aceeeba..e113b99a3eab 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2694,6 +2694,11 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	host->runtime_suspended = true;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	/* Drop the performance vote */
>  	dev_pm_opp_set_rate(dev, 0);
> @@ -2708,6 +2713,7 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long flags;
>  	int ret;
>  
>  	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> @@ -2726,7 +2732,15 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  
>  	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
>  
> -	return sdhci_msm_ice_resume(msm_host);
> +	ret = sdhci_msm_ice_resume(msm_host);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	host->runtime_suspended = false;
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return ret;
>  }
>  
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
> 
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240321-sdhci-mmc-suspend-34f4af1d0286
> 
> Best regards,


